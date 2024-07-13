#include "../core/core.h"

#include <gtest/gtest.h>
#include <stdint.h>
#include <vector>

TEST(Mat, New_Close)
{
  Mat      *mat = (Mat *)malloc(sizeof(Mat));
  CvStatus *s;
  s = Mat_New(mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE((*mat).ptr, nullptr);
  Mat_Close(mat);

  Mat mat1;
  s = Mat_NewWithSize(3, 3, CV_8UC1, &mat1);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat1.ptr, nullptr);

  bool is_empty;
  s = Mat_Empty(mat1, &is_empty);
  EXPECT_EQ(s->code, 0);
  EXPECT_FALSE(is_empty);

  int rows, cols, type;
  s = Mat_Rows(mat1, &rows);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(rows, 3);
  s = Mat_Cols(mat1, &cols);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(cols, 3);
  s = Mat_Type(mat1, &type);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(type, CV_8UC1);
  Mat_Close(&mat1);

  VecI32 sizes = {vecint_cpp2c({3, 3})};
  type = CV_8UC1;

  Mat mat2;
  s = Mat_NewWithSizes(sizes, type, &mat2);
  EXPECT_EQ(s->code, 0);

  s = Mat_Rows(mat2, &rows);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(rows, sizes.ptr->at(0));
  s = Mat_Cols(mat2, &cols);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(cols, sizes.ptr->at(1));
  s = Mat_Type(mat2, &type);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(type, CV_8UC1);
  Mat_Close(&mat2);

  Scalar scalar = {1, 2, 3, 4};
  Mat    mat3;

  s = Mat_NewWithSizesFromScalar(sizes, CV_8UC3, scalar, &mat3);

  // Check the result
  ASSERT_EQ(s->code, 0);
  ASSERT_NE(mat3.ptr, nullptr);
  EXPECT_EQ(mat3.ptr->rows, sizes.ptr->at(0));
  EXPECT_EQ(mat3.ptr->cols, sizes.ptr->at(1));
  EXPECT_EQ(mat3.ptr->type(), CV_8UC3);
  cv::Scalar expectedScalar(1, 2, 3, 4);
  for (int i = 0; i < mat3.ptr->rows; i++) {
    for (int j = 0; j < mat3.ptr->cols; j++) {
      cv::Vec3b pixel = mat3.ptr->at<cv::Vec3b>(i, j);
      EXPECT_EQ(pixel[0], expectedScalar.val[0]);
      EXPECT_EQ(pixel[1], expectedScalar.val[1]);
      EXPECT_EQ(pixel[2], expectedScalar.val[2]);
    }
  }
  Mat_Close(&mat3);

  Mat mat4;
  s = Mat_NewFromScalar(scalar, CV_8UC3, &mat4);
  ASSERT_EQ(s->code, 0);

  // Assert the created Mat object
  EXPECT_EQ(mat4.ptr->rows, 1);
  EXPECT_EQ(mat4.ptr->cols, 1);
  EXPECT_EQ(mat4.ptr->type(), CV_8UC3);
  Mat_Close(&mat4);

  Mat mat5;
  s = Mat_NewWithSizeFromScalar(scalar, rows, cols, CV_8UC3, &mat5);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(mat5.ptr->rows, rows);
  EXPECT_EQ(mat5.ptr->cols, cols);
  EXPECT_EQ(mat5.ptr->type(), CV_8UC3);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      cv::Vec3b pixel = mat5.ptr->at<cv::Vec3b>(i, j);
      EXPECT_EQ(pixel[0], scalar.val1);
      EXPECT_EQ(pixel[1], scalar.val2);
      EXPECT_EQ(pixel[2], scalar.val3);
    }
  }
  Mat_Close(&mat5);
}

TEST(Mat, Create_extra)
{
  Mat       mat;
  CvStatus *s;

  s = Zeros(3, 3, CV_8UC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);
  EXPECT_EQ(mat.ptr->rows, 3);
  EXPECT_EQ(mat.ptr->cols, 3);
  EXPECT_EQ(mat.ptr->type(), CV_8UC3);
  Mat_Close(&mat);

  Mat mat1;
  s = Ones(3, 3, CV_8UC3, &mat1);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat1.ptr, nullptr);
  EXPECT_EQ(mat1.ptr->rows, 3);
  EXPECT_EQ(mat1.ptr->cols, 3);
  EXPECT_EQ(mat1.ptr->type(), CV_8UC3);
  Mat_Close(&mat1);

  Mat mat2;
  s = Eye(3, 3, CV_8UC3, &mat2);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat2.ptr, nullptr);
  EXPECT_EQ(mat2.ptr->rows, 3);
  EXPECT_EQ(mat2.ptr->cols, 3);
  EXPECT_EQ(mat2.ptr->type(), CV_8UC3);
  Mat_Close(&mat2);

  std::vector<uchar> data = {0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13,
                             14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26};
  VecUChar           buf = {vecuchar_cpp2c(data)};
  Mat                matt = {};
  s = Mat_NewFromBytes(3, 3, CV_8UC3, data.data(), 0, &matt);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(matt.ptr, nullptr);
  EXPECT_EQ(matt.ptr->rows, 3);
  EXPECT_EQ(matt.ptr->cols, 3);
  EXPECT_EQ(matt.ptr->channels(), 3);
  auto v = matt.ptr->at<cv::Vec3b>(0, 0);
  std::cout << v << std::endl;
  EXPECT_EQ(v.val[1], 1);
  for (int i = 0; i < matt.ptr->rows; i++) {
    for (int j = 0; j < matt.ptr->cols; j++) {
      for (int k = 0; k < matt.ptr->channels(); k++) {
        std::cout << static_cast<int>(matt.ptr->at<uchar>(i, j, k)) << " ";
      }
    }
  }
  std::cout << *matt.ptr->data << std::endl;
}

TEST(Mat, Property)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_8UC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  int rows, cols, type, channels, step, total, elem_size;
  s = Mat_Rows(mat, &rows);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(rows, 3);
  s = Mat_Cols(mat, &cols);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(cols, 3);
  s = Mat_Type(mat, &type);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(type, CV_8UC3);
  s = Mat_Channels(mat, &channels);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(channels, 3);
  s = Mat_Step(mat, &step);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(step, 3 * 3);
  s = Mat_Total(mat, &total);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(total, 3 * 3);
  s = Mat_ElemSize(mat, &elem_size);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(elem_size, 3);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Setter_UChar)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_8UC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  uchar pix;
  s = Mat_GetUChar(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 1);

  s = Mat_SetUChar(mat, 0, 0, 241);
  EXPECT_EQ(s->code, 0);
  s = Mat_SetUChar3(mat, 0, 0, 0, 241);
  EXPECT_EQ(s->code, 0);

  s = Mat_GetUChar3(mat, 0, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 241);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Setter_Char)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_8SC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  int8_t pix;
  s = Mat_GetSChar(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 1);

  s = Mat_SetSChar(mat, 0, 0, 127);
  EXPECT_EQ(s->code, 0);
  s = Mat_SetSChar3(mat, 0, 0, 0, 127);
  EXPECT_EQ(s->code, 0);

  s = Mat_GetSChar3(mat, 0, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 127);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Setter_UShort)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_16UC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  uint16_t pix;
  s = Mat_GetUShort(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 1);

  s = Mat_SetUShort(mat, 0, 0, 127);
  EXPECT_EQ(s->code, 0);
  s = Mat_SetUShort3(mat, 0, 0, 0, 127);
  EXPECT_EQ(s->code, 0);

  s = Mat_GetUShort3(mat, 0, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 127);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Setter_Short)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_16SC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  int16_t pix;
  s = Mat_GetShort(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 1);

  s = Mat_SetShort(mat, 0, 0, 127);
  EXPECT_EQ(s->code, 0);
  s = Mat_SetShort3(mat, 0, 0, 0, 127);
  EXPECT_EQ(s->code, 0);

  s = Mat_GetShort3(mat, 0, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 127);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Setter_Int)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_32SC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  int pix;
  s = Mat_GetInt(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 1);

  s = Mat_SetInt(mat, 0, 0, 127);
  EXPECT_EQ(s->code, 0);
  s = Mat_SetInt3(mat, 0, 0, 0, 127);
  EXPECT_EQ(s->code, 0);

  s = Mat_GetInt3(mat, 0, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 127);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Setter_Float)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_32FC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  float pix;
  s = Mat_GetFloat(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 1);

  s = Mat_SetFloat(mat, 0, 0, 127);
  EXPECT_EQ(s->code, 0);
  s = Mat_SetFloat3(mat, 0, 0, 0, 127);
  EXPECT_EQ(s->code, 0);

  s = Mat_GetFloat3(mat, 0, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 127);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Setter_Double)
{
  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Mat_NewWithSizeFromScalar(scalar, 3, 3, CV_64FC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  double pix;
  s = Mat_GetDouble(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 1);

  s = Mat_SetDouble(mat, 0, 0, 127);
  EXPECT_EQ(s->code, 0);
  s = Mat_SetDouble3(mat, 0, 0, 0, 127);
  EXPECT_EQ(s->code, 0);

  s = Mat_GetDouble3(mat, 0, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix, 127);

  Mat_Close(&mat);
}

TEST(Mat, Getter_Vec)
{
  auto cvmat = cv::Mat(cv::Mat::ones(30, 30, CV_8UC3));
  auto expectedVec = cvmat.at<cv::Vec3b>(0, 0);

  auto cvmat1 = cv::Mat(30, 40, CV_8UC3, cv::Scalar(2, 4, 1, 0));
  auto v = static_cast<int>(cvmat1.at<uchar>(0, 0, 0));
  auto v1 = static_cast<int>(cvmat1.at<uchar>(0, 1, 0));
  auto v2 = static_cast<int>(cvmat1.at<uchar>(0, 2, 0));
  std::cout << v << "," << v1 << "," << v2 << std::endl;

  CvStatus *s;
  Scalar    scalar = {1, 2, 3, 4};
  Mat       mat;
  s = Ones(30, 30, CV_8UC3, &mat);
  EXPECT_EQ(s->code, 0);
  EXPECT_NE(mat.ptr, nullptr);

  Vec3b pix;
  s = Mat_GetVec3b(mat, 0, 0, &pix);
  EXPECT_EQ(s->code, 0);
  EXPECT_EQ(pix.val1, expectedVec.val[0]);
  EXPECT_EQ(pix.val2, expectedVec.val[1]);
  EXPECT_EQ(pix.val3, expectedVec.val[2]);

  Mat_Close(&mat);
}
