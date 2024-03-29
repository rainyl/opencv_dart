#include "core.h"

#ifdef __cplusplus
#include <opencv2/core.hpp>
#include <vector>
extern "C" {
#endif

CvStatus VecPoint_New(VecPoint *rval);
CvStatus VecPoint_NewFromPointer(Point *points, int length, VecPoint *rval);
CvStatus VecPoint_NewFromMat(Mat mat, VecPoint *rval);
CvStatus VecPoint_NewFromVec(VecPoint vec, VecPoint *rval);
CvStatus VecPoint_At(VecPoint vec, int idx, Point *rval);
CvStatus VecPoint_Append(VecPoint vec, Point p);
CvStatus VecPoint_Size(VecPoint vec, int *rval);
void     VecPoint_Close(VecPoint vec);

CvStatus VecVecPoint_New(VecVecPoint *rval);
CvStatus VecVecPoint_NewFromPointer(VecPoint *points, int length, VecVecPoint *rval);
CvStatus VecVecPoint_NewFromVec(VecVecPoint vec, VecVecPoint *rval);
CvStatus VecVecPoint_At(VecVecPoint vec, int idx, VecPoint *rval);
CvStatus VecVecPoint_Append(VecVecPoint vec, VecPoint pv);
CvStatus VecVecPoint_Size(VecVecPoint vec, int *rval);
void     VecVecPoint_Close(VecVecPoint vec);

CvStatus VecPoint2f_New(VecPoint2f *rval);
CvStatus VecPoint2f_NewFromPointer(Point2f *pts, int length, VecPoint2f *rval);
CvStatus VecPoint2f_NewFromMat(Mat mat, VecPoint2f *rval);
CvStatus VecPoint2f_NewFromVec(VecPoint2f vec, VecPoint2f *rval);
CvStatus VecPoint2f_Append(VecPoint2f vec, Point2f p);
CvStatus VecPoint2f_At(VecPoint2f vec, int idx, Point2f *rval);
CvStatus VecPoint2f_Size(VecPoint2f vec, int *rval);
void     VecPoint2f_Close(VecPoint2f vec);

CvStatus VecVecPoint2f_New(VecVecPoint2f *rval);
CvStatus VecVecPoint2f_NewFromPointer(VecPoint2f *points, int length, VecVecPoint2f *rval);
CvStatus VecVecPoint2f_NewFromVec(VecVecPoint2f vec, VecVecPoint2f *rval);
CvStatus VecVecPoint2f_Size(VecVecPoint2f vec, int *rval);
CvStatus VecVecPoint2f_At(VecVecPoint2f vec, int idx, VecPoint2f *rval);
CvStatus VecVecPoint2f_Append(VecVecPoint2f vec, VecPoint2f pv);
void     VecVecPoint2f_Close(VecVecPoint2f vec);

CvStatus VecPoint3f_New(VecPoint3f *rval);
CvStatus VecPoint3f_NewFromPointer(Point3f *points, int length, VecPoint3f *rval);
CvStatus VecPoint3f_NewFromMat(Mat mat, VecPoint3f *rval);
CvStatus VecPoint3f_NewFromVec(VecPoint3f vec, VecPoint3f *rval);
CvStatus VecPoint3f_Append(VecPoint3f vec, Point3f point);
CvStatus VecPoint3f_At(VecPoint3f vec, int idx, Point3f *rval);
CvStatus VecPoint3f_Size(VecPoint3f vec, int *rval);
void     VecPoint3f_Close(VecPoint3f vec);

CvStatus VecVecPoint3f_New(VecVecPoint3f *rval);
CvStatus VecVecPoint3f_NewFromPointer(VecPoint3f *points, int length, VecVecPoint3f *rval);
CvStatus VecVecPoint3f_NewFromVec(VecVecPoint3f vec, VecVecPoint3f *rval);
CvStatus VecVecPoint3f_Size(VecVecPoint3f vec, int *rval);
CvStatus VecVecPoint3f_At(VecVecPoint3f vec, int idx, VecPoint3f *rval);
CvStatus VecVecPoint3f_Append(VecVecPoint3f vec, VecPoint3f pv);
void     VecVecPoint3f_Close(VecVecPoint3f vec);

CvStatus VecUChar_New(VecUChar *rval);
CvStatus VecUChar_NewFromPointer(uchar *p, int length, VecUChar *rval);
CvStatus VecUChar_NewFromVec(VecUChar vec, VecUChar *rval);
CvStatus VecUChar_Append(VecUChar vec, uchar i);
CvStatus VecUChar_At(VecUChar vec, int idx, uchar *rval);
CvStatus VecUChar_Size(VecUChar vec, int *rval);
void     VecUChar_Close(VecUChar vec);

CvStatus VecChar_New(VecChar *rval);
CvStatus VecChar_NewFromPointer(const char *p, int length, VecChar *rval);
CvStatus VecChar_NewFromVec(VecChar vec, VecChar *rval);
CvStatus VecChar_Append(VecChar vec, char i);
CvStatus VecChar_At(VecChar vec, int idx, char *rval);
CvStatus VecChar_Size(VecChar vec, int *rval);
CvStatus VecChar_ToString(VecChar vec, char **rval, int *length);
void     VecChar_Close(VecChar vec);

CvStatus VecVecChar_New(VecVecChar *rval);
CvStatus VecVecChar_NewFromVec(VecVecChar vec, VecVecChar *rval);
CvStatus VecVecChar_Append(VecVecChar vec, VecChar v);
CvStatus VecVecChar_Append_Str(VecVecChar vec, const char *str);
CvStatus VecVecChar_At(VecVecChar vec, int idx, VecChar *rval);
CvStatus VecVecChar_At_Str(VecVecChar vec, int idx, char **rval, int *length);
CvStatus VecVecChar_Size(VecVecChar vec, int *rval);
void     VecVecChar_Close(VecVecChar vec);

CvStatus VecInt_New(VecInt *rval);
CvStatus VecInt_NewFromPointer(int *p, int length, VecInt *rval);
CvStatus VecInt_NewFromVec(VecInt vec, VecInt *rval);
CvStatus VecInt_Append(VecInt vec, int i);
CvStatus VecInt_At(VecInt vec, int idx, int *rval);
CvStatus VecInt_Size(VecInt vec, int *rval);
void     VecInt_Close(VecInt vec);

CvStatus VecFloat_New(VecFloat *rval);
CvStatus VecFloat_NewFromPointer(float *p, int length, VecFloat *rval);
CvStatus VecFloat_NewFromVec(VecFloat vec, VecFloat *rval);
CvStatus VecFloat_Append(VecFloat vec, float f);
CvStatus VecFloat_At(VecFloat vec, int idx, float *rval);
CvStatus VecFloat_Size(VecFloat vec, int *rval);
void     VecFloat_Close(VecFloat vec);

CvStatus VecDouble_New(VecDouble *rval);
CvStatus VecDouble_NewFromPointer(double *p, int length, VecDouble *rval);
CvStatus VecDouble_NewFromVec(VecDouble vec, VecDouble *rval);
CvStatus VecDouble_Append(VecDouble vec, double d);
CvStatus VecDouble_At(VecDouble vec, int idx, double *rval);
CvStatus VecDouble_Size(VecDouble vec, int *rval);
void     VecDouble_Close(VecDouble vec);

CvStatus VecMat_New(VecMat *rval);
CvStatus VecMat_NewFromPointer(Mat *mats, int length, VecMat *rval);
CvStatus VecMat_NewFromVec(VecMat vec, VecMat *rval);
CvStatus VecMat_Append(VecMat vec, Mat mat);
CvStatus VecMat_At(VecMat vec, int i, Mat *rval);
CvStatus VecMat_Size(VecMat vec, int *rval);
void     VecMat_Close(VecMat vec);

CvStatus VecRect_New(VecRect *rval);
CvStatus VecRect_NewFromPointer(Rect *rects, int length, VecRect *rval);
CvStatus VecRect_NewFromVec(VecRect vec, VecRect *rval);
CvStatus VecRect_At(VecRect vec, int idx, Rect *rval);
CvStatus VecRect_Append(VecRect vec, Rect rect);
CvStatus VecRect_Size(VecRect vec, int *rval);
void     VecRect_Close(VecRect vec);

CvStatus VecKeyPoint_New(VecKeyPoint *rval);
CvStatus VecKeyPoint_NewFromPointer(KeyPoint *keypoints, int length, VecKeyPoint *rval);
CvStatus VecKeyPoint_NewFromVec(VecKeyPoint vec, VecKeyPoint *rval);
CvStatus VecKeyPoint_Append(VecKeyPoint vec, KeyPoint kp);
CvStatus VecKeyPoint_At(VecKeyPoint vec, int idx, KeyPoint *rval);
CvStatus VecKeyPoint_Size(VecKeyPoint vec, int *rval);
void     VecKeyPoint_Close(VecKeyPoint vec);

CvStatus VecDMatch_New(VecDMatch *rval);
CvStatus VecDMatch_NewFromPointer(DMatch *matches, int length, VecDMatch *rval);
CvStatus VecDMatch_NewFromVec(VecDMatch vec, VecDMatch *rval);
CvStatus VecDMatch_Append(VecDMatch vec, DMatch dm);
CvStatus VecDMatch_At(VecDMatch vec, int idx, DMatch *rval);
CvStatus VecDMatch_Size(VecDMatch vec, int *rval);
void     VecDMatch_Close(VecDMatch vec);

CvStatus VecVecDMatch_New(VecVecDMatch *rval);
CvStatus VecVecDMatch_NewFromPointer(VecDMatch *matches, int length, VecVecDMatch *rval);
CvStatus VecVecDMatch_NewFromVec(VecVecDMatch vec, VecVecDMatch *rval);
CvStatus VecVecDMatch_At(VecVecDMatch vec, int idx, VecDMatch *rval);
CvStatus VecVecDMatch_Append(VecVecDMatch vec, VecDMatch dm);
CvStatus VecVecDMatch_Size(VecVecDMatch vec, int *rval);
void     VecVecDMatch_Close(VecVecDMatch vec);

#ifdef __cplusplus
}
#endif
