/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef OPENCV_DART_GAPI_H
#define OPENCV_DART_GAPI_H

#include "dartcv/core/types.h"

#ifdef __cplusplus
#include <opencv2/gapi.hpp>
#include <opencv2/gapi/core.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::GMat, GMat);
CVD_TYPEDEF(cv::GScalar, GScalar);
CVD_TYPEDEF(cv::GFrame, GFrame);
CVD_TYPEDEF(cv::GComputation, GComputation);
CVD_TYPEDEF(cv::GOpaque<cv::Rect>, GOpaqueRect);
CVD_TYPEDEF(cv::GOpaque<cv::Point>, GOpaquePoint);
CVD_TYPEDEF(cv::GOpaque<cv::Vec4f>, GOpaqueVec4f);
CVD_TYPEDEF(cv::GOpaque<cv::Vec6f>, GOpaqueVec6f);
CVD_TYPEDEF(std::vector<cv::GMat>, VecGMat);
CVD_TYPEDEF(cv::gapi::wip::draw::Prim, Prim);
CVD_TYPEDEF(std::vector<cv::gapi::wip::draw::Prim>, VecPrim);

CVD_TYPEDEF(cv::GArray<cv::GArray<cv::Point>>, GArrayGArrayPoint);
CVD_TYPEDEF(cv::GArray<cv::Vec4i>, GArrayVec4i);
CVD_TYPEDEF(cv::GArray<cv::Point>, GArrayPoint);
CVD_TYPEDEF(cv::GArray<cv::Point2f>, GArrayPoint2f);
CVD_TYPEDEF(cv::GArray<cv::Point2i>, GArrayPoint2i);
CVD_TYPEDEF(cv::GArray<cv::Point2d>, GArrayPoint2d);
CVD_TYPEDEF(cv::GArray<cv::Point3f>, GArrayPoint3f);
CVD_TYPEDEF(cv::GArray<cv::Point3d>, GArrayPoint3d);
CVD_TYPEDEF(cv::GArray<cv::Point3i>, GArrayPoint3i);
CVD_TYPEDEF(cv::GArray<cv::gapi::wip::draw::Prim>, GArrayPrim);

#else
CVD_TYPEDEF(void, GMat);
CVD_TYPEDEF(void, GScalar);
CVD_TYPEDEF(void, GFrame);
CVD_TYPEDEF(void, GComputation);
CVD_TYPEDEF(void, GOpaqueRect);
CVD_TYPEDEF(void, GOpaquePoint);
CVD_TYPEDEF(void, GOpaqueVec4f);
CVD_TYPEDEF(void, GOpaqueVec6f);
CVD_TYPEDEF(void, VecGMat);
CVD_TYPEDEF(void, Prim);
CVD_TYPEDEF(void, VecPrim);

CVD_TYPEDEF(void, GArrayGArrayPoint);
CVD_TYPEDEF(void, GArrayVec4i);
CVD_TYPEDEF(void, GArrayPoint);
CVD_TYPEDEF(void, GArrayPoint2f);
CVD_TYPEDEF(void, GArrayPoint2i);
CVD_TYPEDEF(void, GArrayPoint2d);
CVD_TYPEDEF(void, GArrayPoint3f);
CVD_TYPEDEF(void, GArrayPoint3d);
CVD_TYPEDEF(void, GArrayPoint3i);
CVD_TYPEDEF(void, GArrayPrim);
#endif

typedef VecPrim Prims;
// typedef void (*GMatCallback)(GMat *);
// typedef void (*MatCallback)(void *);

CvStatus *gapi_GMat_New_Empty(GMat *rval);
CvStatus *gapi_GMat_New_FromMat(Mat mat, GMat *rval);
void gapi_GMat_Close(GMatPtr mat);

CvStatus *gapi_GScalar_New_Empty(GScalar *rval);
CvStatus *gapi_GScalar_New_FromScalar(Scalar scalar, GScalar *rval);
CvStatus *gapi_GScalar_New_FromDouble(double v0, GScalar *rval);
void gapi_GScalar_Close(GScalarPtr scalar);

CvStatus *gapi_GComputation_New(GMat in, GMat out, GComputation *rval);
CvStatus *gapi_GComputation_New_1(GMat in, GScalar out, GComputation *rval);
CvStatus *gapi_GComputation_New_2(GMat in1, GMat in2, GMat out, GComputation *rval);
CvStatus *gapi_GComputation_New_3(GMat in1, GMat in2, GScalar out, GComputation *rval);
void gapi_GComputation_Close(GComputationPtr self);
CvStatus *gapi_GComputation_apply(GComputation self, Mat in,
                                  CvCallback_1 callback /*TODO: GCompileArgs &&args={}*/);
CvStatus *gapi_GComputation_apply_1(GComputation self, Mat in, Scalar *out /*TODO: GCompileArgs &&args={}*/);
CvStatus *gapi_GComputation_apply_2(GComputation self, Mat in1, Mat in2,
                                    Mat *out /*TODO: GCompileArgs &&args={}*/);
CvStatus *gapi_GComputation_apply_3(GComputation self, Mat in1, Mat in2,
                                    Scalar *out /*TODO: GCompileArgs &&args={}*/);

// CvStatus *VecGMat_NewFromVec(VecMat vec, VecGMat *rval);

CvStatus *Prim_from_Circle(CvPoint center, Scalar color, int lt, int radius, int shift, int thick, Prim *rval);
CvStatus *Prim_from_FText(char *text, int text_len, CvPoint org, int fh, Scalar color, Prim *rval);
CvStatus *Prim_from_Image(CvPoint org, Mat img, Mat alpha, Prim *rval);
CvStatus *Prim_from_Line(Scalar color, int lt, CvPoint pt1, CvPoint pt2, int shift, int thick, Prim *rval);
CvStatus *Prim_from_Mosaic(int cellSz, int decim, CvRect mos, Prim *rval);
CvStatus *Prim_from_Poly(VecPoint points, Scalar color, int thick, int lt, int shift, Prim *rval);
CvStatus *Prim_from_Rect(Scalar color, int lt, CvRect rect, int shift, int thick, Prim *rval);
CvStatus *Prim_from_Text(bool bottom_left_origin, Scalar color, int ff, double fs, int lt, CvPoint org,
                         char *text, int text_len, int thick, Prim *rval);

CvStatus *VecPrim_New(VecPrim *rval);
CvStatus *VecPrim_NewFromPointer(Prim *points, int length, VecPrim *rval);
CvStatus *VecPrim_NewFromVec(VecPrim vec, VecPrim *rval);
CvStatus *VecPrim_At(VecPrim vec, int idx, Prim *rval);
CvStatus *VecPrim_Append(VecPrim vec, Prim p);
CvStatus *VecPrim_Size(VecPrim vec, int *rval);
void VecPrim_Close(VecPrimPtr vec);

CvStatus *GArrayGArrayPoint_FromVec(VecVecPoint points, GArrayGArrayPoint *rval);
CvStatus *GArrayVec4i_FromVec(VecVec4i v, GArrayVec4i *rval);
CvStatus *GArrayPoint_FromVec(VecPoint v, GArrayPoint *rval);
CvStatus *GArrayPoint2f_FromVec(VecPoint v, GArrayPoint2f *rval);
CvStatus *GArrayPoint2i_FromVec(VecPoint v, GArrayPoint2i *rval);
CvStatus *GArrayPoint2d_FromVec(VecPoint v, GArrayPoint2d *rval);
CvStatus *GArrayPoint3f_FromVec(VecPoint v, GArrayPoint3f *rval);
CvStatus *GArrayPoint3d_FromVec(VecPoint v, GArrayPoint3d *rval);
CvStatus *GArrayPoint3i_FromVec(VecPoint v, GArrayPoint3i *rval);
CvStatus *GArrayPrim_FromVec(VecPrim v, GArrayPrim *rval);

// Graph API: Math operations
// https://docs.opencv.org/4.10.0/da/dd3/group__gapi__math.html#ga3fec036f5cf3f6cb8c2633c109085f0b
CvStatus *gapi_add(GMat src1, GMat src2, int ddepth, GMat *rval);
CvStatus *gapi_addC(GMat src, GScalar c, int ddepth, GMat *rval);
CvStatus *gapi_addC_1(GScalar c, GMat src, int ddepth, GMat *rval);
CvStatus *gapi_cartToPolar(GMat x, GMat y, bool angleInDegrees, GMat *rval, GMat *rval1);
CvStatus *gapi_div(GMat src1, GMat src2, double scale, int ddepth, GMat *rval);
CvStatus *gapi_divC(GMat src, GScalar divisor, double scale, int ddepth, GMat *rval);
CvStatus *gapi_divRC(GScalar divident, GMat src, double scale, int ddepth, GMat *rval);
CvStatus *gapi_mask(GMat src, GMat mask, GMat *rval);
CvStatus *gapi_mean(GMat src, GScalar *rval);
CvStatus *gapi_mul(GMat src1, GMat src2, double scale, int ddepth, GMat *rval);
CvStatus *gapi_mulC(GMat src, GScalar multiplier, int ddepth, GMat *rval);
CvStatus *gapi_mulC_1(GMat src, double multiplier, int ddepth, GMat *rval);
CvStatus *gapi_mulC_2(GScalar multiplier, GMat src, int ddepth, GMat *rval);
CvStatus *gapi_phase(GMat x, GMat y, bool angleInDegrees, GMat *rval);
CvStatus *gapi_polarToCart(GMat magnitude, GMat angle, bool angleInDegrees, GMat *rval);
CvStatus *gapi_sqrt(GMat src, GMat *rval);
CvStatus *gapi_sub(GMat src1, GMat src2, int ddepth, GMat *rval);
CvStatus *gapi_subC(GMat src, GScalar c, int ddepth, GMat *rval);
CvStatus *gapi_subRC(GScalar c, GMat src, int ddepth, GMat *rval);

// Graph API: Image filters
// https://docs.opencv.org/4.10.0/da/dc5/group__gapi__filters.html
CvStatus *gapi_bilateralFilter(const GMat src, int d, double sigmaColor, double sigmaSpace, int borderType,
                               GMat *rval);
CvStatus *gapi_blur(const GMat src, const CvSize ksize, const CvPoint anchor, int borderType,
                    const Scalar borderValue, GMat *rval);
CvStatus *gapi_boxFilter(const GMat src, int dtype, const CvSize ksize, const CvPoint anchor, bool normalize,
                         int borderType, const Scalar borderValue, GMat *rval);
CvStatus *gapi_dilate(const GMat src, const Mat kernel, const CvPoint anchor, int iterations, int borderType,
                      const Scalar borderValue, GMat *rval);
CvStatus *gapi_dilate3x3(const GMat src, int iterations, int borderType, const Scalar borderValue,
                         GMat *rval);
CvStatus *gapi_erode(const GMat src, const Mat kernel, const CvPoint anchor, int iterations, int borderType,
                     const Scalar borderValue, GMat *rval);
CvStatus *gapi_erode3x3(const GMat src, int iterations, int borderType, const Scalar borderValue, GMat *rval);
CvStatus *gapi_filter2D(const GMat src, int ddepth, const Mat kernel, const CvPoint anchor, const Scalar delta,
                        int borderType, const Scalar borderValue, GMat *rval);
CvStatus *gapi_gaussianBlur(const GMat src, const CvSize ksize, double sigmaX, double sigmaY, int borderType,
                            const Scalar borderValue, GMat *rval);
CvStatus *gapi_Laplacian(const GMat src, int ddepth, int ksize, double scale, double delta, int borderType,
                         GMat *rval);
CvStatus *gapi_medianBlur(const GMat src, int ksize, GMat *rval);
CvStatus *gapi_morphologyEx(const GMat src, const int op, const Mat kernel, const CvPoint anchor,
                            const int iterations, const int borderType, const Scalar borderValue, GMat *rval);
CvStatus *gapi_sepFilter(const GMat src, int ddepth, const Mat kernelX, const Mat kernelY, const CvPoint anchor,
                         const Scalar delta, int borderType, const Scalar borderValue, GMat *rval);
CvStatus *gapi_Sobel(const GMat src, int ddepth, int dx, int dy, int ksize, double scale, double delta,
                     int borderType, const Scalar borderValue, GMat *rval);
CvStatus *gapi_SobelXY(const GMat src, int ddepth, int order, int ksize, double scale, double delta,
                       int borderType, const Scalar borderValue, GMat *rval, GMat *rval1);

// Graph API: Converting image from one color space to another
CvStatus *gapi_BayerGR2RGB(const GMat src_gr, GMat *rval);
CvStatus *gapi_BGR2Gray(const GMat src, GMat *rval);
CvStatus *gapi_BGR2I420(const GMat src, GMat *rval);
CvStatus *gapi_BGR2LUV(const GMat src, GMat *rval);
CvStatus *gapi_BGR2RGB(const GMat src, GMat *rval);
CvStatus *gapi_BGR2YUV(const GMat src, GMat *rval);
CvStatus *gapi_I4202BGR(const GMat src, GMat *rval);
CvStatus *gapi_I4202RGB(const GMat src, GMat *rval);
CvStatus *gapi_LUV2BGR(const GMat src, GMat *rval);
CvStatus *gapi_NV12toBGR(const GMat src_y, const GMat src_uv, GMat *rval);
CvStatus *gapi_NV12toBGRp(const GMat src_y, const GMat src_uv, GMat *rval);
CvStatus *gapi_NV12toGray(const GMat src_y, const GMat src_uv, GMat *rval);
CvStatus *gapi_NV12toRGB(const GMat src_y, const GMat src_uv, GMat *rval);
CvStatus *gapi_NV12toRGBp(const GMat src_y, const GMat src_uv, GMat *rval);
CvStatus *gapi_RGB2Gray(const GMat src, GMat *rval);
CvStatus *gapi_RGB2Gray_1(const GMat src, float rY, float gY, float bY, GMat *rval);
CvStatus *gapi_RGB2HSV(const GMat src, GMat *rval);
CvStatus *gapi_RGB2I420(const GMat src, GMat *rval);
CvStatus *gapi_RGB2Lab(const GMat src, GMat *rval);
CvStatus *gapi_RGB2YUV(const GMat src, GMat *rval);
CvStatus *gapi_RGB2YUV422(const GMat src, GMat *rval);
CvStatus *gapi_YUV2BGR(const GMat src, GMat *rval);
CvStatus *gapi_YUV2RGB(const GMat src, GMat *rval);

// Graph API: Image Feature Detection
CvStatus *gapi_Canny(const GMat image, double threshold1, double threshold2, int apertureSize,
                     bool L2gradient, GMat *rval);
CvStatus *gapi_goodFeaturesToTrack(const GMat image, int maxCorners, double qualityLevel, double minDistance,
                                   const Mat mask, int blockSize, bool useHarrisDetector, double k);

// Graph API: Image Structural Analysis and Shape Descriptors
CvStatus *gapi_boundingRect(const GArrayPoint2f src, GOpaqueRect *rval);
CvStatus *gapi_boundingRect_1(const GArrayPoint2i src, GOpaqueRect *rval);
CvStatus *gapi_boundingRect_2(const GMat src, GOpaqueRect *rval);
CvStatus *gapi_findContours(const GMat src, const int mode, const int method, GArrayGArrayPoint *rval);
CvStatus *gapi_findContours_1(const GMat src, const int mode, const int method, const GOpaquePoint offset,
                              GArrayGArrayPoint *rval);
CvStatus *gapi_findContoursH(const GMat src, const int mode, const int method, GArrayGArrayPoint *rval,
                             GArrayVec4i *rval1);
CvStatus *gapi_findContoursH_1(const GMat src, const int mode, const int method, const GOpaquePoint offset,
                               GArrayGArrayPoint *rval, GArrayVec4i *rval1);
CvStatus *gapi_fitLine2D(const GArrayPoint2d src, const int distType, const double param, const double reps,
                         const double aeps, GOpaqueVec4f *rval);
CvStatus *gapi_fitLine2D_1(const GArrayPoint2f src, const int distType, const double param, const double reps,
                           const double aeps, GOpaqueVec4f *rval);
CvStatus *gapi_fitLine2D_2(const GArrayPoint2i src, const int distType, const double param, const double reps,
                           const double aeps, GOpaqueVec4f *rval);
CvStatus *gapi_fitLine2D_3(const GMat src, const int distType, const double param, const double reps,
                           const double aeps, GOpaqueVec4f *rval);
CvStatus *gapi_fitLine3D_1(const GArrayPoint3d src, const int distType, const double param, const double reps,
                           const double aeps, GOpaqueVec4f *rval);
CvStatus *gapi_fitLine3D_2(const GArrayPoint3f src, const int distType, const double param, const double reps,
                           const double aeps, GOpaqueVec4f *rval);
CvStatus *gapi_fitLine3D_3(const GArrayPoint3i src, const int distType, const double param, const double reps,
                           const double aeps, GOpaqueVec4f *rval);
CvStatus *gapi_fitLine3D_4(const GMat src, const int distType, const double param, const double reps,
                           const double aeps, GOpaqueVec4f *rval);

// Graph API: Image and channel composition functions
CvStatus *gapi_concatHor(const GMat src1, const GMat src2, GMat *rval);
// CvStatus *gapi_concatHor_1(const VecGMat v, GMat *rval);
CvStatus *gapi_concatVert(const GMat src1, const GMat src2, GMat *rval);
// CvStatus *gapi_concatVert_2(const VecGMat v, GMat *rval);
CvStatus *gapi_convertTo(const GMat src, int rdepth, double alpha, double beta, GMat *rval);
// CvStatus *gapi_copy(const GFrame in, GFrame *rval);
CvStatus *gapi_copy_1(const GMat in, GMat *rval);
CvStatus *gapi_crop(const GMat src, const CvRect rect, GMat *rval);
CvStatus *gapi_flip(const GMat src, int flipCode, GMat *rval);
CvStatus *gapi_LUT(const GMat src, const Mat lut, GMat *rval);
CvStatus *gapi_merge3(const GMat src1, const GMat src2, const GMat src3, GMat *rval);
CvStatus *gapi_merge4(const GMat src1, const GMat src2, const GMat src3, const GMat src4, GMat *rval);
CvStatus *gapi_normalize(const GMat src, double alpha, double beta, int norm_type, int ddepth, GMat *rval);
CvStatus *gapi_remap(const GMat src, const Mat map1, const Mat map2, int interpolation, int borderMode,
                     const Scalar borderValue, GMat *rval);
CvStatus *gapi_resize(const GMat src, const CvSize dsize, double fx, double fy, int interpolation, GMat *rval);
CvStatus *gapi_resizeP(const GMat src, const CvSize dsize, int interpolation, GMat *rval);
CvStatus *gapi_split3(const GMat src, GMat *rval, GMat *rval1, GMat *rval2);
CvStatus *gapi_split4(const GMat src, GMat *rval, GMat *rval1, GMat *rval2, GMat *rval3);
CvStatus *gapi_warpAffine(const GMat src, const Mat M, const CvSize dsize, int flags, int borderMode,
                          const Scalar borderValue, GMat *rval);
CvStatus *gapi_warpPerspective(const GMat src, const Mat M, const CvSize dsize, int flags, int borderMode,
                               const Scalar borderValue, GMat *rval);

// G-API Video processing functionality

// G-API Drawing and composition functionality
// CvStatus *gapi_wip_draw_render(cv::Mat bgr, const Prims prims /*, cv::GCompileArgs args*/);
// CvStatus *gapi_wip_draw_render_1(cv::Mat y_plane, cv::Mat uv_plane,
//                                 const Prims prims /*, cv::GCompileArgs args = {}*/);
// CvStatus *gapi_wip_draw_render_2(cv::MediaFrame frame, const Prims prims /*, cv::GCompileArgs args = {}*/);
// CvStatus *gapi_wip_draw_render3ch(const GMat src, const GArrayPrim prims, GMat *rval);
// CvStatus *gapi_wip_draw_renderNV12(const GMat y, const GMat uv, const GArrayPrim prims, GMat *rval,
//                                   GMat *rval1);

#ifdef __cplusplus
}
#endif

#endif // OPENCV_DART_GAPI_H
