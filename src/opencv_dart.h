#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#ifdef _WIN32
#ifdef __cplusplus
#define FFI_PLUGIN_EXPORT extern "C" __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#endif // __cplusplus
#else
#ifdef __cplusplus
#define FFI_PLUGIN_EXPORT extern "C"
#else
#define FFI_PLUGIN_EXPORT
#endif // __cplusplus
#endif // _WIN32

// FFI_PLUGIN_EXPORT void rmbg_cv(CvMatPtr src, CvMatPtr dst, double contrast, double brightness, double threshold, int n_erode, int n_dilate);

FFI_PLUGIN_EXPORT int sum(int a, int b);