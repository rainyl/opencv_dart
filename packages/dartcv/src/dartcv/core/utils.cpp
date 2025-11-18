#include <vector>
#include "dartcv/core/utils.h"

VecU8* cv_yuv420_888_to_nv21(VecU8 y, VecU8 u, VecU8 v, size_t width, size_t height) {
    if (width == 0 || height == 0) {
        return nullptr;
    }
    const size_t y_size = width * height;
    const size_t uv_size = y_size / 4;
    auto _y = CVDEREF(y);
    auto _u = CVDEREF(u);
    auto _v = CVDEREF(v);

    // uint8_t* nv21 = new uint8_t[(height + height / 2) * width];
    auto nv21_ptr = new std::vector<uint8_t>(y_size + uv_size);
    nv21_ptr->assign(_y.begin(), _y.end());

    for (int i = 0; i < uv_size; ++i) {
        nv21_ptr->at(y_size + 2 * i) = _v[i];  // V first in NV21
        nv21_ptr->at(y_size + 2 * i + 1) = _u[i];  // U second in NV21
    }
    return new VecU8{nv21_ptr};
}
