/*

    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.

*/
#ifndef CVD_CORE_ASYNC_H_
#define CVD_CORE_ASYNC_H_

#ifdef __cplusplus

// Real async support: every `*Async` C entry point takes a callback, and `cvd::dispatch` decides
// whether to run the work now (the synchronous callers pass `nullptr`) or hand it to a worker
// thread that calls back with the resulting `CvStatus*`.
//
// Two lifetimes have to be covered for a job that outlives the Dart call that started it:
//
//   * the C++ object, which the wrappers' `shared_ptr` already keeps alive once the job holds a
//     copy (that is what `cvd::hold` does);
//   * the wrapper's holder (`struct Mat { std::shared_ptr<cv::Mat>* ptr; }`), which
//     `CVD_FREE`/`dispose()` would otherwise delete while the job is dereferencing it. `release()`
//     therefore defers that deletion to the end of the queue when the holder is in use.
//
// This header must be included at file scope: it declares templates, which cannot have C linkage.

#include <algorithm>
#include <atomic>
#include <condition_variable>
#include <cstdint>
#include <cstring>
#include <deque>
#include <functional>
#include <memory>
#include <mutex>
#include <string>
#include <thread>
#include <unordered_map>
#include <utility>
#include <vector>

#include "dartcv/core/types.h"

namespace cvd {

/// One spawned worker unless configured otherwise: OpenCV already fills the machine with its own
/// threads (`cv::parallel_for_`), so a second worker only helps blocking I/O (a capture or a slow
/// disk) and spinning one up by default would oversubscribe every CPU-bound call.
constexpr int kDefaultAsyncThreads = 1;

namespace detail {

#ifndef __EMSCRIPTEN__
struct pool {
    std::mutex mu;
    std::condition_variable cv_job;
    std::condition_variable cv_idle;
    std::deque<std::pair<std::uintptr_t, std::function<void()>>> queue;
    std::vector<std::thread> workers;
    std::vector<std::uintptr_t> running_lanes;
    int active = 0;
    int threads = kDefaultAsyncThreads;
    bool stop = false;
    bool started = false;
    /// Set while `set_threads` is retiring the old workers: a submit that arrives then must only
    /// enqueue, because a worker spawned now would see `stop` and exit immediately.
    bool stopping = false;

    void start_workers_locked() {
        if (started || stopping) return;
        started = true;
        const int n = std::max(1, threads);
        workers.reserve(static_cast<std::size_t>(n));
        for (int i = 0; i < n; ++i) {
            workers.emplace_back([this]() { run(); });
        }
    }

    void run() {
        for (;;) {
            std::function<void()> job;
            std::uintptr_t lane = 0;
            {
                std::unique_lock<std::mutex> lock(mu);
                cv_job.wait(lock, [this]() {
                    if (stop) return true;
                    // Take a job only if its lane is idle, so calls that touch the same object run
                    // in the order they were made even with several workers.
                    return std::any_of(queue.begin(), queue.end(), [this](const auto& entry) {
                        return entry.first == 0 ||
                               std::find(running_lanes.begin(), running_lanes.end(), entry.first) ==
                                   running_lanes.end();
                    });
                });
                if (stop) return;
                auto it = std::find_if(queue.begin(), queue.end(), [this](const auto& entry) {
                    return entry.first == 0 ||
                           std::find(running_lanes.begin(), running_lanes.end(), entry.first) ==
                               running_lanes.end();
                });
                lane = it->first;
                job = std::move(it->second);
                queue.erase(it);
                ++active;
                if (lane != 0) running_lanes.push_back(lane);
            }
            job();
            {
                std::lock_guard<std::mutex> lock(mu);
                --active;
                if (lane != 0) {
                    running_lanes.erase(
                        std::find(running_lanes.begin(), running_lanes.end(), lane)
                    );
                }
                if (queue.empty() && active == 0) cv_idle.notify_all();
                cv_job.notify_all();
            }
        }
    }

    void submit(std::uintptr_t lane, std::function<void()> job) {
        {
            std::lock_guard<std::mutex> lock(mu);
            start_workers_locked();
            queue.emplace_back(lane, std::move(job));
        }
        cv_job.notify_one();
    }

    void drain() {
        std::unique_lock<std::mutex> lock(mu);
        cv_idle.wait(lock, [this]() { return queue.empty() && active == 0; });
    }

    std::int64_t pending() {
        std::lock_guard<std::mutex> lock(mu);
        return static_cast<std::int64_t>(queue.size()) + active;
    }

    void set_threads(int n) {
        n = std::max(1, n);
        std::vector<std::thread> retired;
        bool was_started = false;
        {
            std::unique_lock<std::mutex> lock(mu);
            cv_idle.wait(lock, [this]() { return queue.empty() && active == 0; });
            if (n == threads && started) return;
            threads = n;
            was_started = started;
            stopping = true;
            stop = true;
            retired.swap(workers);
            started = false;
        }
        cv_job.notify_all();
        for (auto& worker : retired) {
            if (worker.joinable()) worker.join();
        }
        // A submit that raced with the retirement only queued its job; start the new workers here, or
        // nothing would ever run it and `drain()` would wait forever.
        std::lock_guard<std::mutex> lock(mu);
        stop = false;
        stopping = false;
        if (was_started || !queue.empty()) start_workers_locked();
        cv_job.notify_all();
    }

    int thread_count() {
        std::lock_guard<std::mutex> lock(mu);
        return threads;
    }
};

/// Deliberately never destroyed: a process that exits while a worker is parked would otherwise run
/// `std::thread`'s destructor on a joinable thread and `std::terminate` (measured: `exit(0)` turned
/// into exit code 127), and a destructor that joins could touch the `holds()` singleton after that
/// one was destroyed. The OS reclaims both at exit.
inline pool& the_pool() {
    static pool* instance = new pool();
    return *instance;
}
#endif  // !__EMSCRIPTEN__

/// Holders (a wrapper's `ptr` field) currently referenced by a job, and the number of jobs that are
/// somewhere in the pipeline. `busy_jobs == 0` is the fast path for `release`: no job can be using
/// any holder, so nothing needs the registry.
///
/// The fast path is only sound because a wrapper is registered and released on the thread that owns
/// it (the isolate that created it): `dispatch` registers before it returns to Dart, so a `release()`
/// can never run between an increment and the matching insert.
struct hold_registry {
    std::mutex mu;
    std::unordered_map<void*, int> counts;
    /// Wrappers whose `dispose()` arrived while a job still held them: the job that drops the last
    /// reference deletes them, which keeps the deletion off the worker that may still be using them
    /// (queuing it would let another worker run it in parallel once the pool has more than one).
    std::unordered_map<void*, std::function<void()>> pending_release;
    std::atomic<int> busy_jobs{0};
};

inline hold_registry& holds() {
    static hold_registry* instance = new hold_registry();
    return *instance;
}

inline void register_holds(const std::vector<void*>& holders) {
    auto& r = holds();
    r.busy_jobs.fetch_add(1, std::memory_order_release);
    std::lock_guard<std::mutex> lock(r.mu);
    for (void* holder : holders) {
        if (holder != nullptr) ++r.counts[holder];
    }
}

inline void unregister_holds(const std::vector<void*>& holders) {
    auto& r = holds();
    std::vector<std::function<void()>> released;
    {
        std::lock_guard<std::mutex> lock(r.mu);
        for (void* holder : holders) {
            if (holder == nullptr) continue;
            auto it = r.counts.find(holder);
            if (it != r.counts.end()) {
                if (--it->second > 0) continue;
                r.counts.erase(it);
            }
            auto pending = r.pending_release.find(holder);
            if (pending != r.pending_release.end()) {
                released.push_back(std::move(pending->second));
                r.pending_release.erase(pending);
            }
        }
    }
    r.busy_jobs.fetch_sub(1, std::memory_order_release);
    // Outside the lock: a destructor may call back into the registry.
    for (auto& release : released) release();
}

/// Non-null when one of `holders` is in the hands of an async job: a synchronous call on the same
/// object would read it while another thread writes it, which is undefined behaviour rather than a
/// wait. The caller returns this as the status, so the Dart side sees a CvException.
inline CvStatus* conflict_status(const std::vector<void*>& holders) {
    auto& r = holds();
    if (r.busy_jobs.load(std::memory_order_acquire) == 0) return nullptr;  // nothing in flight
    std::lock_guard<std::mutex> lock(r.mu);
    for (void* holder : holders) {
        if (holder == nullptr) continue;
        auto it = r.counts.find(holder);
        if (it != r.counts.end() && it->second > 0) {
            return new CvStatus{
                .code = 3,
                .msg = strdup(
                    "dartcv: a synchronous call used an object that an async call is still working "
                    "on; await that Future first (only Async calls are ordered with each other)"
                ),
                .err = strdup("async call in flight on the same object"),
                .func = strdup(__func__),
                .file = strdup(__FILE__),
                .line = __LINE__,
            };
        }
    }
    return nullptr;
}

/// Remembers a wrapper whose `dispose()` has to wait for the jobs that still hold it.
inline void defer_release(void* holder, std::function<void()> deleter) {
    auto& r = holds();
    std::function<void()> immediate;
    {
        std::lock_guard<std::mutex> lock(r.mu);
        auto it = r.counts.find(holder);
        if (it == r.counts.end() || it->second <= 0) {
            immediate = std::move(deleter);
        } else {
            r.pending_release[holder] = std::move(deleter);
        }
    }
    if (immediate) immediate();
}

inline bool holder_in_use(void* holder) {
    auto& r = holds();
    std::lock_guard<std::mutex> lock(r.mu);
    auto it = r.counts.find(holder);
    return it != r.counts.end() && it->second > 0;
}

/// Running the same object's calls on different workers must not interleave, so jobs are keyed by the
/// set of objects they touch: a symmetric hash (sorted, mixed) gives the same lane for `copyTo(a, b)`
/// and `copyTo(b, a)`.
inline std::uintptr_t lane_of(const std::vector<void*>& holders) {
#ifndef __EMSCRIPTEN__
    if (the_pool().thread_count() <= 1 || holders.empty()) return 0;
#else
    if (holders.empty()) return 0;
#endif
    std::vector<std::uintptr_t> keys;
    keys.reserve(holders.size());
    for (void* holder : holders) {
        if (holder != nullptr) keys.push_back(reinterpret_cast<std::uintptr_t>(holder));
    }
    if (keys.empty()) return 0;
    std::sort(keys.begin(), keys.end());
    std::uint64_t hash = 1469598103934665603ull;
    for (std::uintptr_t key : keys) {
        hash = (hash ^ static_cast<std::uint64_t>(key)) * 1099511628211ull;
    }
    // 0 means "no lane", so never hand it out.
    return static_cast<std::uintptr_t>(hash == 0 ? 1 : hash);
}

}  // namespace detail

/// The status a caller gets when its work was accepted: not the work's own status, which the job
/// reports through the callback.
inline CvStatus* accepted_status() {
    return new CvStatus{
        .code = 0,
        .msg = strdup("accepted"),
        .err = strdup(""),
        .func = strdup(__func__),
        .file = strdup(__FILE__),
        .line = __LINE__,
    };
}

/// One strong reference per handle, taken by the job: the wrapper may be disposed while the job
/// waits or runs.
template <typename... H>
std::vector<void*> hold(const H&... handles) {
    std::vector<void*> out;
    out.reserve(sizeof...(H));
    ((out.push_back(static_cast<void*>(handles.ptr))), ...);
    return std::vector<void*>(out);
}

/// Refuses a synchronous call that would race an async one on the same object. Used by the wrappers
/// that take handles but have no callback parameter (a `CvStatus*` return lets them report it).
#define CVD_CHECK(...)                                                       \
    do {                                                                     \
        CvStatus* _cvd_conflict =                                            \
            ::cvd::detail::conflict_status(::cvd::hold(__VA_ARGS__));        \
        if (_cvd_conflict != nullptr) return _cvd_conflict;                  \
    } while (0)

/// Runs [work] now and returns its status, or queues it and returns an "accepted" status.
///
/// `callback == nullptr` is the synchronous call: same behaviour as before, exceptions are translated
/// by the work's own `BEGIN_WRAP`/`END_WRAP`.
inline CvStatus* dispatch(
    CvCallback_0 callback, std::vector<void*> holders, std::function<CvStatus*()> work
) {
    if (callback == nullptr) {
        // The synchronous caller runs on its own thread right now: refuse if an async job is still
        // using one of the same objects.
        if (CvStatus* conflict = detail::conflict_status(holders)) return conflict;
        return work();
    }
#ifdef __EMSCRIPTEN__
    // No threads on the web: the work runs here and the callback still fires, so callers keep the
    // same promise/Future shape (see tool/web/README.md).
    CvStatus* status = work();
    callback(status);
    return accepted_status();
#else
    detail::register_holds(holders);
    const std::uintptr_t lane = detail::lane_of(holders);
    detail::the_pool().submit(lane, [holders = std::move(holders), work = std::move(work),
                                     callback]() {
        CvStatus* status = nullptr;
        try {
            status = work();
        } catch (...) {
            // The body reports its own failures; this only catches what escapes it (a failure while
            // building the status, say), and the holders below still have to be released.
        }
        if (status == nullptr) {
            status = new CvStatus{
                .code = 2,
                .msg = strdup("async job failed"),
                .err = strdup("async job failed"),
                .func = strdup(__func__),
                .file = strdup(__FILE__),
                .line = __LINE__,
            };
        }
        // Release before reporting: the Dart continuation may immediately call something
        // synchronously on the same object, and would otherwise be told a finished job is in flight.
        // `callback` only posts a message, it does not touch the objects.
        detail::unregister_holds(holders);
        callback(status);
    });
    return accepted_status();
#endif
}

/// `CVD_FREE`: releases a wrapper. When a job still holds the wrapper's holder, the deletion is
/// deferred to the end of the queue instead of pulling the memory out from under it.
template <typename H>
void release(H* value) {
    if (value == nullptr) return;
    auto* self = value;
    auto deleter = [self]() {
        delete self->ptr;
        delete self;
    };
    if (detail::holds().busy_jobs.load(std::memory_order_acquire) > 0 &&
        detail::holder_in_use(static_cast<void*>(value->ptr))) {
        // The job that drops the last reference runs `deleter`, so this never races a worker that is
        // still dereferencing the holder.
        detail::defer_release(static_cast<void*>(value->ptr), std::move(deleter));
        return;
    }
    deleter();
}

inline void set_async_threads(int n) {
#ifndef __EMSCRIPTEN__
    detail::the_pool().set_threads(n);
#else
    (void)n;  // no threads on the web: the work always runs on the calling thread
#endif
}

inline int async_threads() {
#ifndef __EMSCRIPTEN__
    return detail::the_pool().thread_count();
#else
    return 1;
#endif
}

inline std::int64_t async_pending() {
#ifndef __EMSCRIPTEN__
    return detail::the_pool().pending();
#else
    return 0;
#endif
}

inline void async_drain() {
#ifndef __EMSCRIPTEN__
    detail::the_pool().drain();
#endif
}

}  // namespace cvd

#endif  // __cplusplus

#endif  // CVD_CORE_ASYNC_H_
