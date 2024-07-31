#include "../core/vec.h"
#include <gtest/gtest.h>
#include <stdio.h>
#include <string.h>
#include <vector>

TEST(VecPoint, New)
{
  // Arrange
  VecPoint vecPoint;

  // Act
  CvStatus *status = VecPoint_New(&vecPoint);

  // Assert
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(vecPoint.ptr, nullptr);
  EXPECT_TRUE(vecPoint.ptr->empty()); // Check if the vector is empty

  // Clean up
  VecPoint_Close(&vecPoint);
}

TEST(VecPoint, NewFromPointerTest)
{
  VecPoint rval;
  int      length = 3;
  Point   *points = new Point[length];
  for (int i = 0; i < length; i++) {
    points[i].x = i;
    points[i].y = i;
  }
  // Call the function to be tested
  CvStatus *status = VecPoint_NewFromPointer(points, length, &rval);

  // Assert the return status
  ASSERT_EQ(status->code, 0);

  // Assert the vector size
  ASSERT_EQ(rval.ptr->size(), length);

  // Assert the vector content
  for (int i = 0; i < length; i++) {
    ASSERT_EQ(rval.ptr->at(i).x, points[i].x);
    ASSERT_EQ(rval.ptr->at(i).y, points[i].y);
  }
}

TEST(VecPoint, ConvertsMatToVecPoint)
{
  std::vector<cv::Point> expectedPts = {{1, 2}, {3, 4}, {5, 6}, {7, 8}};

  Mat      mat = {new cv::Mat(expectedPts)};
  VecPoint rval;
  // Call the function to be tested
  CvStatus *status = VecPoint_NewFromMat(mat, &rval);

  // Assert the return status
  if (status->code != 0) {
    printf("status->msg: %s", status->msg);
  }
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(rval.ptr, nullptr);

  // Assert the converted vector of points
  ASSERT_EQ(*rval.ptr, expectedPts);
}

TEST(VecPoint, At_Append_Size)
{
  // Initialize any required variables or objects for the tests
  VecPoint  vec;
  CvStatus *s;
  s = VecPoint_New(&vec);
  EXPECT_EQ(s->code, 0);
  s = VecPoint_Append(vec, {1, 2});
  EXPECT_EQ(s->code, 0);
  s = VecPoint_Append(vec, {3, 4});
  EXPECT_EQ(s->code, 0);

  int size = 0;
  s = VecPoint_Size(vec, &size);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(size, 2);

  Point point;
  s = VecPoint_At(vec, 0, &point);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(point.x, 1);
  EXPECT_EQ(point.y, 2);
}

TEST(VecVecPoint, New_Append_At_Size)
{
  VecVecPoint vec;
  CvStatus   *status = VecVecPoint_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  EXPECT_TRUE(vec.ptr->empty()); // Check if the vector is empty

  std::vector<cv::Point> vp = {{1, 2}, {3, 4}, {5, 6}, {7, 8}};
  VecVecPoint_Append(vec, {&vp});
  VecVecPoint_Append(vec, {&vp});

  int size = 0;
  status = VecVecPoint_Size(vec, &size);
  ASSERT_EQ(size, 2);

  VecPoint v;
  status = VecVecPoint_At(vec, 0, &v);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(v.ptr->front(), cv::Point(1, 2));

  VecVecPoint_Close(&vec);
}

TEST(VecVecPoint, NewFromPointerTest)
{
  // Create input data
  int length = 3;

  VecPoint *points = new VecPoint[length];
  for (int i = 0; i < length; i++) {
    std::vector<cv::Point> vp = {{1, 2}, {3, 4}, {5, 6}, {7, 8}};
    VecPoint               v = {.ptr = vecpoint_cpp2c(vp)};
    points[i] = v;
  }

  // Create output variable
  VecVecPoint vec;

  // Call the function to be tested
  CvStatus *status = VecVecPoint_NewFromPointer(points, length, &vec);

  // Assertions
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);

  // Verify the output
  ASSERT_EQ(vec.ptr->size(), length);
  for (int i = 0; i < length; i++) {
    EXPECT_EQ(vec.ptr->at(i).size(), 4);
    EXPECT_EQ(vec.ptr->at(i).front().x, 1);
    EXPECT_EQ(vec.ptr->at(i).front().y, 2);
    EXPECT_EQ(vec.ptr->at(i).back().x, 7);
    EXPECT_EQ(vec.ptr->at(i).back().y, 8);
  }

  VecVecPoint_Close(&vec);
}

TEST(VecPoint2f, New)
{
  // Arrange
  VecPoint2f vecPoint;

  // Act
  CvStatus *status = VecPoint2f_New(&vecPoint);

  // Assert
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(vecPoint.ptr, nullptr);
  EXPECT_TRUE(vecPoint.ptr->empty()); // Check if the vector is empty

  // Clean up
  VecPoint2f_Close(&vecPoint);
}

TEST(VecPoint2f, NewFromPointerTest)
{
  VecPoint2f rval;
  int        length = 3;
  Point2f   *points = new Point2f[length];
  for (int i = 0; i < length; i++) {
    points[i].x = i;
    points[i].y = i;
  }
  // Call the function to be tested
  CvStatus *status = VecPoint2f_NewFromPointer(points, length, &rval);

  // Assert the return status
  ASSERT_EQ(status->code, 0);

  // Assert the vector size
  ASSERT_EQ(rval.ptr->size(), length);

  // Assert the vector content
  for (int i = 0; i < length; i++) {
    ASSERT_EQ(rval.ptr->at(i).x, points[i].x);
    ASSERT_EQ(rval.ptr->at(i).y, points[i].y);
  }
}

TEST(VecPoint2f, ConvertsMatToVecPoint2f)
{
  std::vector<cv::Point2f> expectedPts = {{1, 2}, {3, 4}, {5, 6}, {7, 8}};

  Mat        mat = Mat{new cv::Mat(expectedPts)};
  VecPoint2f rval;
  // Call the function to be tested
  CvStatus *status = VecPoint2f_NewFromMat(mat, &rval);

  // Assert the return status
  if (status->code != 0) {
    printf("status->msg: %s", status->msg);
  }
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(rval.ptr, nullptr);

  // Assert the converted vector of points
  ASSERT_EQ(*rval.ptr, expectedPts);
}

TEST(VecPoint2f, At_Append_Size)
{
  // Initialize any required variables or objects for the tests
  VecPoint2f vec;
  CvStatus  *s;
  s = VecPoint2f_New(&vec);
  EXPECT_EQ(s->code, 0);
  s = VecPoint2f_Append(vec, {1.0, 2.0});
  EXPECT_EQ(s->code, 0);
  s = VecPoint2f_Append(vec, {3, 4});
  EXPECT_EQ(s->code, 0);

  int size = 0;
  s = VecPoint2f_Size(vec, &size);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(size, 2);

  Point2f point;
  s = VecPoint2f_At(vec, 0, &point);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(point.x, 1.0);
  EXPECT_EQ(point.y, 2.0);
}

TEST(VecVecPoint2f, New_Append_At_Size)
{
  VecVecPoint2f vec;
  CvStatus     *status = VecVecPoint2f_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  EXPECT_TRUE(vec.ptr->empty()); // Check if the vector is empty

  std::vector<cv::Point2f> vp = {{1, 2}, {3, 4}, {5, 6}, {7, 8}};
  VecVecPoint2f_Append(vec, {&vp});
  VecVecPoint2f_Append(vec, {&vp});

  int size = 0;
  status = VecVecPoint2f_Size(vec, &size);
  ASSERT_EQ(size, 2);

  VecPoint2f v;
  status = VecVecPoint2f_At(vec, 0, &v);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(v.ptr->front(), cv::Point2f(1, 2));

  VecVecPoint2f_Close(&vec);
}

TEST(VecVecPoint2f, NewFromPointerTest)
{
  // Create input data
  int length = 3;

  VecPoint2f *points = new VecPoint2f[length];
  for (int i = 0; i < length; i++) {
    std::vector<cv::Point2f> vp = {{1, 2}, {3, 4}, {5, 6}, {7, 8}};
    points[i] = {&vp};
  }

  // Create output variable
  VecVecPoint2f vec;

  // Call the function to be tested
  CvStatus *status = VecVecPoint2f_NewFromPointer(points, length, &vec);

  // Assertions
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);

  // Verify the output
  ASSERT_EQ(vec.ptr->size(), length);
  for (int i = 0; i < length; i++) {
    EXPECT_EQ(vec.ptr->at(i).size(), 4);
    EXPECT_EQ(vec.ptr->at(i).front().x, 1);
    EXPECT_EQ(vec.ptr->at(i).front().y, 2);
    EXPECT_EQ(vec.ptr->at(i).back().x, 7);
    EXPECT_EQ(vec.ptr->at(i).back().y, 8);
  }

  VecVecPoint2f_Close(&vec);
}

TEST(VecPoint3f, New)
{
  // Arrange
  VecPoint3f vecPoint;

  // Act
  CvStatus *status = VecPoint3f_New(&vecPoint);

  // Assert
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(vecPoint.ptr, nullptr);
  EXPECT_TRUE(vecPoint.ptr->empty()); // Check if the vector is empty

  // Clean up
  VecPoint3f_Close(&vecPoint);
}

TEST(VecPoint3f, NewFromPointerTest)
{
  VecPoint3f rval;
  int        length = 3;
  Point3f   *points = new Point3f[length];
  for (int i = 0; i < length; i++) {
    points[i].x = i;
    points[i].y = i;
    points[i].z = i;
  }
  // Call the function to be tested
  CvStatus *status = VecPoint3f_NewFromPointer(points, length, &rval);

  // Assert the return status
  ASSERT_EQ(status->code, 0);

  // Assert the vector size
  ASSERT_EQ(rval.ptr->size(), length);

  // Assert the vector content
  for (int i = 0; i < length; i++) {
    ASSERT_EQ(rval.ptr->at(i).x, points[i].x);
    ASSERT_EQ(rval.ptr->at(i).y, points[i].y);
    ASSERT_EQ(rval.ptr->at(i).z, points[i].z);
  }
}

TEST(VecPoint3f, ConvertsMatToVecPoint2f)
{
  std::vector<cv::Point3f> expectedPts = {{1, 2, 1}, {3, 4, 3}, {5, 6, 5}, {7, 8, 7}};

  Mat        mat = {new cv::Mat(expectedPts)};
  VecPoint3f rval;
  // Call the function to be tested
  CvStatus *status = VecPoint3f_NewFromMat(mat, &rval);

  // Assert the return status
  if (status->code != 0) {
    printf("status->msg: %s", status->msg);
  }
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(rval.ptr, nullptr);

  // Assert the converted vector of points
  ASSERT_EQ(*rval.ptr, expectedPts);
}

TEST(VecPoint3f, At_Append_Size)
{
  // Initialize any required variables or objects for the tests
  VecPoint3f vec;
  CvStatus  *s;
  s = VecPoint3f_New(&vec);
  EXPECT_EQ(s->code, 0);
  s = VecPoint3f_Append(vec, {1.0, 2.0, 1.0});
  EXPECT_EQ(s->code, 0);
  s = VecPoint3f_Append(vec, {3, 4, 3.0});
  EXPECT_EQ(s->code, 0);

  int size = 0;
  s = VecPoint3f_Size(vec, &size);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(size, 2);

  Point3f point;
  s = VecPoint3f_At(vec, 0, &point);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(point.x, 1.0);
  EXPECT_EQ(point.y, 2.0);
  EXPECT_EQ(point.z, 1.0);
}

TEST(VecVecPoint3f, New_Append_At_Size)
{
  VecVecPoint3f vec;
  CvStatus     *status = VecVecPoint3f_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  EXPECT_TRUE(vec.ptr->empty()); // Check if the vector is empty

  int      length = 4;
  Point3f *p = new Point3f[length];
  for (int i = 0; i < length; i++) {
    p[i].x = i;
    p[i].y = i + 1;
    p[i].z = i;
  }
  VecPoint3f vp;
  VecPoint3f_NewFromPointer(p, length, &vp);
  VecVecPoint3f_Append(vec, vp);
  VecVecPoint3f_Append(vec, vp);

  int size = 0;
  status = VecVecPoint3f_Size(vec, &size);
  ASSERT_EQ(size, 2);

  VecPoint3f v;
  status = VecVecPoint3f_At(vec, 0, &v);
  std::cout << *v.ptr << std::endl;
  std::cout << *vp.ptr << std::endl;
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(*v.ptr, *vp.ptr);

  VecVecPoint3f_Close(&vec);
}

TEST(VecVecPoint3f, NewFromPointerTest)
{
  int length = 3;

  VecPoint3f *points = new VecPoint3f[length];
  for (int i = 0; i < length; i++) {
    VecPoint3f vp;
    VecPoint3f_New(&vp);
    for (int j = 0; j < 4; j++) {
      VecPoint3f_Append(vp, {(float)j, (float)j + 1, (float)j});
    }
    points[i] = vp;
  }

  VecVecPoint3f vec;
  CvStatus     *status = VecVecPoint3f_NewFromPointer(points, length, &vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  ASSERT_EQ(vec.ptr->size(), length);
  for (int i = 0; i < length; i++) {
    EXPECT_EQ(vec.ptr->at(i).size(), 4.0);
    EXPECT_EQ(vec.ptr->at(i).front().x, 0.0);
    EXPECT_EQ(vec.ptr->at(i).front().y, 1.0);
    EXPECT_EQ(vec.ptr->at(i).front().z, 0.0);
    EXPECT_EQ(vec.ptr->at(i).back().x, 3.0);
    EXPECT_EQ(vec.ptr->at(i).back().y, 4.0);
    EXPECT_EQ(vec.ptr->at(i).back().z, 3.0);
  }

  VecVecPoint3f_Close(&vec);
}

TEST(VecUChar, New_Append_At_Size_Close)
{
  VecUChar  vec;
  CvStatus *status = VecUChar_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecUChar_Append(vec, 1);
  ASSERT_EQ(status->code, 0);
  status = VecUChar_Append(vec, 2);
  ASSERT_EQ(status->code, 0);

  uchar c;
  status = VecUChar_At(vec, 0, &c);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(c, 1);

  int size;
  status = VecUChar_Size(vec, &size);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(size, 2);

  VecUChar_Close(&vec);

  uchar *chars = new uchar[]{0, 1, 2, 3};
  status = VecUChar_NewFromPointer(chars, 4, &vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
}

TEST(VecChar, New_Append_At_Size_Close)
{
  VecChar   vec;
  CvStatus *status = VecChar_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecChar_Append(vec, 1);
  ASSERT_EQ(status->code, 0);
  status = VecChar_Append(vec, 2);
  ASSERT_EQ(status->code, 0);

  char c;
  status = VecChar_At(vec, 0, &c);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(c, 1);

  int size;
  status = VecChar_Size(vec, &size);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(size, 2);

  VecChar_Close(&vec);

  char *chars = new char[]{0, 1, 2, 3};
  status = VecChar_NewFromPointer(chars, 4, &vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  VecChar_Close(&vec);
}

TEST(VecChar, ToString)
{
  const char *s = "Hello";
  VecChar     vec;
  CvStatus   *status;
  status = VecChar_NewFromPointer(strdup(s), 5, &vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  char *ss = nullptr;
  int   length = 0;
  status = VecChar_ToString(vec, &ss, &length);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(ss, nullptr);
  ASSERT_EQ(length, 5);
  ASSERT_STREQ(ss, s);
  VecChar_Close(&vec);
}

TEST(VecVecChar, New_Append_At_Size_Close)
{
  VecVecChar vec;
  CvStatus  *status;
  status = VecVecChar_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);

  const char *str = "abc";
  VecChar     v;
  status = VecChar_NewFromPointer(str, 3, &v);
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(v.ptr, nullptr);
  status = VecVecChar_Append(vec, v);
  EXPECT_EQ(status->code, 0);
  int size = 0;
  status = VecVecChar_Size(vec, &size);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(size, 1);

  status = VecVecChar_Append_Str(vec, "abc");
  EXPECT_EQ(status->code, 0);
  status = VecVecChar_Size(vec, &size);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(size, 2);

  VecChar v1;
  status = VecVecChar_At(vec, 0, &v1);
  EXPECT_EQ(status->code, 0);

  int sz = 0;
  status = VecChar_Size(v1, &sz);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(sz, 3);

  char *s1 = nullptr;
  int   length = 0;
  status = VecVecChar_At_Str(vec, 0, &s1, &length);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(length, 3);
  EXPECT_STREQ(s1, "abc");
}

TEST(VecI32, New_Append_At_Size_Close)
{
  VecI32    vec;
  CvStatus *status = VecI32_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecI32_Append(vec, 1);
  ASSERT_EQ(status->code, 0);
  status = VecI32_Append(vec, 2);
  ASSERT_EQ(status->code, 0);

  int c;
  status = VecI32_At(vec, 0, &c);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(c, 1);

  int size;
  status = VecI32_Size(vec, &size);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(size, 2);

  VecI32_Close(&vec);

  int *chars = new int[]{0, 1, 2, 3};
  status = VecI32_NewFromPointer(chars, 4, &vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
}

TEST(VecF32, New_Append_At_Size_Close)
{
  VecF32  vec;
  CvStatus *status = VecF32_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecF32_Append(vec, 1);
  ASSERT_EQ(status->code, 0);
  status = VecF32_Append(vec, 2);
  ASSERT_EQ(status->code, 0);

  float c;
  status = VecF32_At(vec, 0, &c);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(c, 1);

  int size;
  status = VecF32_Size(vec, &size);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(size, 2);

  VecF32_Close(&vec);

  float *chars = new float[]{0, 1, 2, 3};
  status = VecF32_NewFromPointer(chars, 4, &vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
}

TEST(VecF64, New_Append_At_Size_Close)
{
  VecF64 vec;
  CvStatus *status = VecF64_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecF64_Append(vec, 1);
  ASSERT_EQ(status->code, 0);
  status = VecF64_Append(vec, 2);
  ASSERT_EQ(status->code, 0);

  double c;
  status = VecF64_At(vec, 0, &c);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(c, 1);

  int size;
  status = VecF64_Size(vec, &size);
  ASSERT_EQ(status->code, 0);
  ASSERT_EQ(size, 2);

  VecF64_Close(&vec);

  double *chars = new double[]{0, 1, 2, 3};
  status = VecF64_NewFromPointer(chars, 4, &vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
}

TEST(VecMat, New_Append_At_Size_Close)
{
  Mat mat;
  Zeros(3, 3, CV_8UC1, &mat);
  VecMat    vec;
  CvStatus *status = VecMat_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecMat_Append(vec, mat);
  EXPECT_EQ(status->code, 0);
  status = VecMat_Append(vec, mat);
  EXPECT_EQ(status->code, 0);

  Mat c;
  status = VecMat_At(vec, 0, &c);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ((*c.ptr).at<uchar>(0, 0), 0);

  int size;
  status = VecMat_Size(vec, &size);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(size, 2);

  VecMat_Close(&vec);

  Mat *mats = new Mat[4];
  for (int i = 0; i < 4; i++) {
    Mat m;
    Zeros(3, 3, 1, &m);
    mats[i] = m;
  }
  status = VecMat_NewFromPointer(mats, 4, &vec);
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(vec.ptr, nullptr);
}

TEST(VecRect, New_Append_At_Size_Close)
{
  Rect      rect = {1, 2, 3, 4};
  VecRect   vec;
  CvStatus *status = VecRect_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecRect_Append(vec, rect);
  EXPECT_EQ(status->code, 0);
  status = VecRect_Append(vec, rect);
  EXPECT_EQ(status->code, 0);

  Rect r;
  status = VecRect_At(vec, 0, &r);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(r.x, rect.x);
  EXPECT_EQ(r.y, rect.y);
  EXPECT_EQ(r.width, rect.width);
  EXPECT_EQ(r.height, rect.height);

  int size;
  status = VecRect_Size(vec, &size);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(size, 2);

  VecRect_Close(&vec);

  Rect *rects = new Rect[4];
  for (int i = 0; i < 4; i++) {
    Rect r = {1, 2, 3, 4};
    rects[i] = r;
  }
  status = VecRect_NewFromPointer(rects, 4, &vec);
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(vec.ptr, nullptr);
}

TEST(VecKeyPoint, New_Append_At_Size_Close)
{
  KeyPoint    kp = {1, 2, 3, 4, 5, 6, 7};
  VecKeyPoint vec;
  CvStatus   *status = VecKeyPoint_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecKeyPoint_Append(vec, kp);
  EXPECT_EQ(status->code, 0);
  status = VecKeyPoint_Append(vec, kp);
  EXPECT_EQ(status->code, 0);

  KeyPoint r;
  status = VecKeyPoint_At(vec, 0, &r);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(r.x, kp.x);
  EXPECT_EQ(r.y, kp.y);
  EXPECT_EQ(r.size, kp.size);

  int size;
  status = VecKeyPoint_Size(vec, &size);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(size, 2);

  VecKeyPoint_Close(&vec);

  KeyPoint *rects = new KeyPoint[4];
  for (int i = 0; i < 4; i++) {
    KeyPoint r = {1, 2, 3, 4, 5, 6, 7};
    rects[i] = r;
  }
  status = VecKeyPoint_NewFromPointer(rects, 4, &vec);
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(vec.ptr, nullptr);
}

TEST(VecDMatch, New_Append_At_Size_Close)
{
  DMatch    kp = {1, 2, 3, 4};
  VecDMatch vec;
  CvStatus *status = VecDMatch_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecDMatch_Append(vec, kp);
  EXPECT_EQ(status->code, 0);
  status = VecDMatch_Append(vec, kp);
  EXPECT_EQ(status->code, 0);

  DMatch r;
  status = VecDMatch_At(vec, 0, &r);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(r.queryIdx, kp.queryIdx);
  EXPECT_EQ(r.trainIdx, kp.trainIdx);
  EXPECT_EQ(r.imgIdx, kp.imgIdx);

  int size;
  status = VecDMatch_Size(vec, &size);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(size, 2);

  VecDMatch_Close(&vec);

  DMatch *dms = new DMatch[4];
  for (int i = 0; i < 4; i++) {
    DMatch r = {1, 2, 3, 4};
    dms[i] = r;
  }
  status = VecDMatch_NewFromPointer(dms, 4, &vec);
  EXPECT_EQ(status->code, 0);
  EXPECT_NE(vec.ptr, nullptr);
}

TEST(VecVecDMatch, New_Append_At_Size_Close)
{
  DMatch    kp = {1, 2, 3, 4};
  VecDMatch vecdm;
  CvStatus *status = VecDMatch_New(&vecdm);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vecdm.ptr, nullptr);
  status = VecDMatch_Append(vecdm, kp);
  EXPECT_EQ(status->code, 0);
  status = VecDMatch_Append(vecdm, kp);
  EXPECT_EQ(status->code, 0);

  VecVecDMatch vec;
  status = VecVecDMatch_New(&vec);
  ASSERT_EQ(status->code, 0);
  ASSERT_NE(vec.ptr, nullptr);
  status = VecVecDMatch_Append(vec, vecdm);
  EXPECT_EQ(status->code, 0);
  status = VecVecDMatch_Append(vec, vecdm);
  EXPECT_EQ(status->code, 0);

  VecDMatch r;
  status = VecVecDMatch_At(vec, 0, &r);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(r.ptr->front().queryIdx, kp.queryIdx);
  EXPECT_EQ(r.ptr->front().trainIdx, kp.trainIdx);
  EXPECT_EQ(r.ptr->front().imgIdx, kp.imgIdx);

  int size;
  status = VecVecDMatch_Size(vec, &size);
  EXPECT_EQ(status->code, 0);
  EXPECT_EQ(size, 2);

  VecVecDMatch_Close(&vec);

  VecDMatch *dms = new VecDMatch[4];
  for (int i = 0; i < 4; i++) {
    VecDMatch v;
    status = VecDMatch_New(&v);
    for (int j = 0; j < 4; j++) {
      DMatch dm = {1, 2, 3, 4};
      VecDMatch_Append(v, dm);
    }
    dms[i] = v;
  }
  status = VecVecDMatch_NewFromPointer(dms, 4, &vec);
  EXPECT_EQ(status->code, 0);
}
