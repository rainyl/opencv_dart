/*

    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.

*/
#ifndef CVD_CORE_HANDLE_H_
#define CVD_CORE_HANDLE_H_

#ifdef __cplusplus

// The refcounted handle wrappers used by every module: `CVD_TYPEDEF` gives each C type a
// `std::shared_ptr<T>*` field, and the macros in types.h (`CVD_SET`, `CVD_MAKE`, `CVD_ADOPT`)
// build one through this header.
//
// This header must be included at file scope (never from inside a module header's
// `extern "C" {` block): templates cannot have C linkage.

#include <algorithm>
#include <atomic>
#include <cstdint>
#include <memory>
#include <mutex>
#include <string>
#include <utility>
#include <typeinfo>
#include <utility>
#include <vector>

namespace cvd {

/// How many wrapped C++ objects are alive, across all types.
///
/// Incremented when a wrapper takes ownership of an object and decremented by the deleter, so a
/// handle that a job still holds (an async call in flight, a `VecVecPoint[i]` view) keeps its
/// object counted. Diagnostics only: it is never read on a hot path.
std::atomic<std::int64_t>& live_total();

/// `"<type>=<count>\n"` for every type that has ever been wrapped, sorted, for failure messages.
std::string live_stats();

namespace detail {

struct per_type_counter {
    const char* name;
    std::atomic<std::int64_t>* counter;
};

std::vector<per_type_counter>& registry();
std::mutex& registry_mutex();

}  // namespace detail

/// The per-type counter, registered on first use so [live_stats] can report it.
template <typename T>
std::atomic<std::int64_t>& live_of() {
    static std::atomic<std::int64_t> counter{0};
    static const bool registered = [] {
        std::lock_guard<std::mutex> lock(detail::registry_mutex());
        detail::registry().push_back({typeid(T).name(), &counter});
        return true;
    }();
    (void)registered;
    return counter;
}

/// Deletes the object and drops both counters: this is what makes the handle refcount observable.
template <typename T>
struct counting_deleter {
    void operator()(T* raw) const noexcept {
        --live_of<T>();
        --live_total();
        delete raw;
    }
};

/// Takes ownership of a raw pointer. Returns `nullptr` for `nullptr`, so a wrapper without an
/// object still reads as `ptr == nullptr`.
template <typename T>
std::shared_ptr<T>* adopt(T* raw) {
    if (raw == nullptr) return nullptr;
    ++live_of<T>();
    ++live_total();
    return new std::shared_ptr<T>(raw, counting_deleter<T>{});
}

/// Stores a fresh handle in a wrapper, releasing whatever it held before: reusing an out-parameter
/// must not leak the previous object.
template <typename H, typename T>
void set(H* holder, T* raw) {
    delete holder->ptr;
    holder->ptr = adopt(raw);
}

template <typename T, typename... Args>
std::shared_ptr<T>* make(Args&&... args) {
    return adopt<T>(new T(std::forward<Args>(args)...));
}

}  // namespace cvd

// Inline functions with local statics: the standard guarantees one instance per program, so the
// counters are shared by every module that wraps handles.
namespace cvd {

inline std::atomic<std::int64_t>& live_total() {
    static std::atomic<std::int64_t> total{0};
    return total;
}

inline std::vector<detail::per_type_counter>& detail::registry() {
    static std::vector<per_type_counter> entries;
    return entries;
}

inline std::mutex& detail::registry_mutex() {
    static std::mutex m;
    return m;
}

inline std::string live_stats() {
    std::lock_guard<std::mutex> lock(detail::registry_mutex());
    std::vector<std::pair<std::string, std::int64_t>> rows;
    rows.reserve(detail::registry().size());
    for (const auto& entry : detail::registry()) {
        const auto n = entry.counter->load();
        if (n != 0) rows.emplace_back(entry.name, n);
    }
    std::sort(rows.begin(), rows.end());
    std::string out;
    for (const auto& [name, n] : rows) {
        out += name;
        out += '=';
        out += std::to_string(n);
        out += '\n';
    }
    return out;
}

}  // namespace cvd

#endif  // __cplusplus

#endif  // CVD_CORE_HANDLE_H_
