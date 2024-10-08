/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef OPENCV_DART_LIBRARY_ENUMS_H
#define OPENCV_DART_LIBRARY_ENUMS_H

/** the color conversion codes
@see @ref imgproc_color_conversions
@ingroup imgproc_color_conversions
 */
enum
{
    COLOR_BGR2BGRA = 0, //!< add alpha channel to RGB or BGR image
    COLOR_RGB2RGBA = COLOR_BGR2BGRA,

    COLOR_BGRA2BGR = 1, //!< remove alpha channel from RGB or BGR image
    COLOR_RGBA2RGB = COLOR_BGRA2BGR,

    COLOR_BGR2RGBA = 2, //!< convert between RGB and BGR color spaces (with or without alpha channel)
    COLOR_RGB2BGRA = COLOR_BGR2RGBA,

    COLOR_RGBA2BGR = 3,
    COLOR_BGRA2RGB = COLOR_RGBA2BGR,

    COLOR_BGR2RGB = 4,
    COLOR_RGB2BGR = COLOR_BGR2RGB,

    COLOR_BGRA2RGBA = 5,
    COLOR_RGBA2BGRA = COLOR_BGRA2RGBA,

    COLOR_BGR2GRAY = 6, //!< convert between RGB/BGR and grayscale, @ref color_convert_rgb_gray "color conversions"
    COLOR_RGB2GRAY = 7,
    COLOR_GRAY2BGR = 8,
    COLOR_GRAY2RGB = COLOR_GRAY2BGR,
    COLOR_GRAY2BGRA = 9,
    COLOR_GRAY2RGBA = COLOR_GRAY2BGRA,
    COLOR_BGRA2GRAY = 10,
    COLOR_RGBA2GRAY = 11,

    COLOR_BGR2BGR565 = 12, //!< convert between RGB/BGR and BGR565 (16-bit images)
    COLOR_RGB2BGR565 = 13,
    COLOR_BGR5652BGR = 14,
    COLOR_BGR5652RGB = 15,
    COLOR_BGRA2BGR565 = 16,
    COLOR_RGBA2BGR565 = 17,
    COLOR_BGR5652BGRA = 18,
    COLOR_BGR5652RGBA = 19,

    COLOR_GRAY2BGR565 = 20, //!< convert between grayscale to BGR565 (16-bit images)
    COLOR_BGR5652GRAY = 21,

    COLOR_BGR2BGR555 = 22, //!< convert between RGB/BGR and BGR555 (16-bit images)
    COLOR_RGB2BGR555 = 23,
    COLOR_BGR5552BGR = 24,
    COLOR_BGR5552RGB = 25,
    COLOR_BGRA2BGR555 = 26,
    COLOR_RGBA2BGR555 = 27,
    COLOR_BGR5552BGRA = 28,
    COLOR_BGR5552RGBA = 29,

    COLOR_GRAY2BGR555 = 30, //!< convert between grayscale and BGR555 (16-bit images)
    COLOR_BGR5552GRAY = 31,

    COLOR_BGR2XYZ = 32, //!< convert RGB/BGR to CIE XYZ, @ref color_convert_rgb_xyz "color conversions"
    COLOR_RGB2XYZ = 33,
    COLOR_XYZ2BGR = 34,
    COLOR_XYZ2RGB = 35,

    COLOR_BGR2YCrCb = 36, //!< convert RGB/BGR to luma-chroma (aka YCC), @ref color_convert_rgb_ycrcb "color conversions"
    COLOR_RGB2YCrCb = 37,
    COLOR_YCrCb2BGR = 38,
    COLOR_YCrCb2RGB = 39,

    COLOR_BGR2HSV = 40, //!< convert RGB/BGR to HSV (hue saturation value) with H range 0..180 if 8 bit image, @ref color_convert_rgb_hsv "color conversions"
    COLOR_RGB2HSV = 41,

    COLOR_BGR2Lab = 44, //!< convert RGB/BGR to CIE Lab, @ref color_convert_rgb_lab "color conversions"
    COLOR_RGB2Lab = 45,

    COLOR_BGR2Luv = 50, //!< convert RGB/BGR to CIE Luv, @ref color_convert_rgb_luv "color conversions"
    COLOR_RGB2Luv = 51,
    COLOR_BGR2HLS = 52, //!< convert RGB/BGR to HLS (hue lightness saturation) with H range 0..180 if 8 bit image, @ref color_convert_rgb_hls "color conversions"
    COLOR_RGB2HLS = 53,

    COLOR_HSV2BGR = 54, //!< backward conversions HSV to RGB/BGR with H range 0..180 if 8 bit image
    COLOR_HSV2RGB = 55,

    COLOR_Lab2BGR = 56,
    COLOR_Lab2RGB = 57,
    COLOR_Luv2BGR = 58,
    COLOR_Luv2RGB = 59,
    COLOR_HLS2BGR = 60, //!< backward conversions HLS to RGB/BGR with H range 0..180 if 8 bit image
    COLOR_HLS2RGB = 61,

    COLOR_BGR2HSV_FULL = 66, //!< convert RGB/BGR to HSV (hue saturation value) with H range 0..255 if 8 bit image, @ref color_convert_rgb_hsv "color conversions"
    COLOR_RGB2HSV_FULL = 67,
    COLOR_BGR2HLS_FULL = 68, //!< convert RGB/BGR to HLS (hue lightness saturation) with H range 0..255 if 8 bit image, @ref color_convert_rgb_hls "color conversions"
    COLOR_RGB2HLS_FULL = 69,

    COLOR_HSV2BGR_FULL = 70, //!< backward conversions HSV to RGB/BGR with H range 0..255 if 8 bit image
    COLOR_HSV2RGB_FULL = 71,
    COLOR_HLS2BGR_FULL = 72, //!< backward conversions HLS to RGB/BGR with H range 0..255 if 8 bit image
    COLOR_HLS2RGB_FULL = 73,

    COLOR_LBGR2Lab = 74,
    COLOR_LRGB2Lab = 75,
    COLOR_LBGR2Luv = 76,
    COLOR_LRGB2Luv = 77,

    COLOR_Lab2LBGR = 78,
    COLOR_Lab2LRGB = 79,
    COLOR_Luv2LBGR = 80,
    COLOR_Luv2LRGB = 81,

    COLOR_BGR2YUV = 82, //!< convert between RGB/BGR and YUV
    COLOR_RGB2YUV = 83,
    COLOR_YUV2BGR = 84,
    COLOR_YUV2RGB = 85,

    //! YUV 4:2:0 family to RGB
    COLOR_YUV2RGB_NV12 = 90,
    COLOR_YUV2BGR_NV12 = 91,
    COLOR_YUV2RGB_NV21 = 92,
    COLOR_YUV2BGR_NV21 = 93,
    COLOR_YUV420sp2RGB = COLOR_YUV2RGB_NV21,
    COLOR_YUV420sp2BGR = COLOR_YUV2BGR_NV21,

    COLOR_YUV2RGBA_NV12 = 94,
    COLOR_YUV2BGRA_NV12 = 95,
    COLOR_YUV2RGBA_NV21 = 96,
    COLOR_YUV2BGRA_NV21 = 97,
    COLOR_YUV420sp2RGBA = COLOR_YUV2RGBA_NV21,
    COLOR_YUV420sp2BGRA = COLOR_YUV2BGRA_NV21,

    COLOR_YUV2RGB_YV12 = 98,
    COLOR_YUV2BGR_YV12 = 99,
    COLOR_YUV2RGB_IYUV = 100,
    COLOR_YUV2BGR_IYUV = 101,
    COLOR_YUV2RGB_I420 = COLOR_YUV2RGB_IYUV,
    COLOR_YUV2BGR_I420 = COLOR_YUV2BGR_IYUV,
    COLOR_YUV420p2RGB = COLOR_YUV2RGB_YV12,
    COLOR_YUV420p2BGR = COLOR_YUV2BGR_YV12,

    COLOR_YUV2RGBA_YV12 = 102,
    COLOR_YUV2BGRA_YV12 = 103,
    COLOR_YUV2RGBA_IYUV = 104,
    COLOR_YUV2BGRA_IYUV = 105,
    COLOR_YUV2RGBA_I420 = COLOR_YUV2RGBA_IYUV,
    COLOR_YUV2BGRA_I420 = COLOR_YUV2BGRA_IYUV,
    COLOR_YUV420p2RGBA = COLOR_YUV2RGBA_YV12,
    COLOR_YUV420p2BGRA = COLOR_YUV2BGRA_YV12,

    COLOR_YUV2GRAY_420 = 106,
    COLOR_YUV2GRAY_NV21 = COLOR_YUV2GRAY_420,
    COLOR_YUV2GRAY_NV12 = COLOR_YUV2GRAY_420,
    COLOR_YUV2GRAY_YV12 = COLOR_YUV2GRAY_420,
    COLOR_YUV2GRAY_IYUV = COLOR_YUV2GRAY_420,
    COLOR_YUV2GRAY_I420 = COLOR_YUV2GRAY_420,
    COLOR_YUV420sp2GRAY = COLOR_YUV2GRAY_420,
    COLOR_YUV420p2GRAY = COLOR_YUV2GRAY_420,

    //! YUV 4:2:2 family to RGB
    COLOR_YUV2RGB_UYVY = 107,
    COLOR_YUV2BGR_UYVY = 108,
    // COLOR_YUV2RGB_VYUY = 109,
    // COLOR_YUV2BGR_VYUY = 110,
    COLOR_YUV2RGB_Y422 = COLOR_YUV2RGB_UYVY,
    COLOR_YUV2BGR_Y422 = COLOR_YUV2BGR_UYVY,
    COLOR_YUV2RGB_UYNV = COLOR_YUV2RGB_UYVY,
    COLOR_YUV2BGR_UYNV = COLOR_YUV2BGR_UYVY,

    COLOR_YUV2RGBA_UYVY = 111,
    COLOR_YUV2BGRA_UYVY = 112,
    // COLOR_YUV2RGBA_VYUY = 113,
    // COLOR_YUV2BGRA_VYUY = 114,
    COLOR_YUV2RGBA_Y422 = COLOR_YUV2RGBA_UYVY,
    COLOR_YUV2BGRA_Y422 = COLOR_YUV2BGRA_UYVY,
    COLOR_YUV2RGBA_UYNV = COLOR_YUV2RGBA_UYVY,
    COLOR_YUV2BGRA_UYNV = COLOR_YUV2BGRA_UYVY,

    COLOR_YUV2RGB_YUY2 = 115,
    COLOR_YUV2BGR_YUY2 = 116,
    COLOR_YUV2RGB_YVYU = 117,
    COLOR_YUV2BGR_YVYU = 118,
    COLOR_YUV2RGB_YUYV = COLOR_YUV2RGB_YUY2,
    COLOR_YUV2BGR_YUYV = COLOR_YUV2BGR_YUY2,
    COLOR_YUV2RGB_YUNV = COLOR_YUV2RGB_YUY2,
    COLOR_YUV2BGR_YUNV = COLOR_YUV2BGR_YUY2,

    COLOR_YUV2RGBA_YUY2 = 119,
    COLOR_YUV2BGRA_YUY2 = 120,
    COLOR_YUV2RGBA_YVYU = 121,
    COLOR_YUV2BGRA_YVYU = 122,
    COLOR_YUV2RGBA_YUYV = COLOR_YUV2RGBA_YUY2,
    COLOR_YUV2BGRA_YUYV = COLOR_YUV2BGRA_YUY2,
    COLOR_YUV2RGBA_YUNV = COLOR_YUV2RGBA_YUY2,
    COLOR_YUV2BGRA_YUNV = COLOR_YUV2BGRA_YUY2,

    COLOR_YUV2GRAY_UYVY = 123,
    COLOR_YUV2GRAY_YUY2 = 124,
    // CV_YUV2GRAY_VYUY    = CV_YUV2GRAY_UYVY,
    COLOR_YUV2GRAY_Y422 = COLOR_YUV2GRAY_UYVY,
    COLOR_YUV2GRAY_UYNV = COLOR_YUV2GRAY_UYVY,
    COLOR_YUV2GRAY_YVYU = COLOR_YUV2GRAY_YUY2,
    COLOR_YUV2GRAY_YUYV = COLOR_YUV2GRAY_YUY2,
    COLOR_YUV2GRAY_YUNV = COLOR_YUV2GRAY_YUY2,

    //! alpha premultiplication
    COLOR_RGBA2mRGBA = 125,
    COLOR_mRGBA2RGBA = 126,

    //! RGB to YUV 4:2:0 family
    COLOR_RGB2YUV_I420 = 127,
    COLOR_BGR2YUV_I420 = 128,
    COLOR_RGB2YUV_IYUV = COLOR_RGB2YUV_I420,
    COLOR_BGR2YUV_IYUV = COLOR_BGR2YUV_I420,

    COLOR_RGBA2YUV_I420 = 129,
    COLOR_BGRA2YUV_I420 = 130,
    COLOR_RGBA2YUV_IYUV = COLOR_RGBA2YUV_I420,
    COLOR_BGRA2YUV_IYUV = COLOR_BGRA2YUV_I420,
    COLOR_RGB2YUV_YV12 = 131,
    COLOR_BGR2YUV_YV12 = 132,
    COLOR_RGBA2YUV_YV12 = 133,
    COLOR_BGRA2YUV_YV12 = 134,

    //! Demosaicing, see @ref color_convert_bayer "color conversions" for additional information
    COLOR_BayerBG2BGR = 46, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2BGR = 47, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2BGR = 48, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2BGR = 49, //!< equivalent to GBRG Bayer pattern

    COLOR_BayerRGGB2BGR = COLOR_BayerBG2BGR,
    COLOR_BayerGRBG2BGR = COLOR_BayerGB2BGR,
    COLOR_BayerBGGR2BGR = COLOR_BayerRG2BGR,
    COLOR_BayerGBRG2BGR = COLOR_BayerGR2BGR,

    COLOR_BayerRGGB2RGB = COLOR_BayerBGGR2BGR,
    COLOR_BayerGRBG2RGB = COLOR_BayerGBRG2BGR,
    COLOR_BayerBGGR2RGB = COLOR_BayerRGGB2BGR,
    COLOR_BayerGBRG2RGB = COLOR_BayerGRBG2BGR,

    COLOR_BayerBG2RGB = COLOR_BayerRG2BGR, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2RGB = COLOR_BayerGR2BGR, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2RGB = COLOR_BayerBG2BGR, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2RGB = COLOR_BayerGB2BGR, //!< equivalent to GBRG Bayer pattern

    COLOR_BayerBG2GRAY = 86, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2GRAY = 87, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2GRAY = 88, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2GRAY = 89, //!< equivalent to GBRG Bayer pattern

    COLOR_BayerRGGB2GRAY = COLOR_BayerBG2GRAY,
    COLOR_BayerGRBG2GRAY = COLOR_BayerGB2GRAY,
    COLOR_BayerBGGR2GRAY = COLOR_BayerRG2GRAY,
    COLOR_BayerGBRG2GRAY = COLOR_BayerGR2GRAY,

    //! Demosaicing using Variable Number of Gradients
    COLOR_BayerBG2BGR_VNG = 62, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2BGR_VNG = 63, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2BGR_VNG = 64, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2BGR_VNG = 65, //!< equivalent to GBRG Bayer pattern

    COLOR_BayerRGGB2BGR_VNG = COLOR_BayerBG2BGR_VNG,
    COLOR_BayerGRBG2BGR_VNG = COLOR_BayerGB2BGR_VNG,
    COLOR_BayerBGGR2BGR_VNG = COLOR_BayerRG2BGR_VNG,
    COLOR_BayerGBRG2BGR_VNG = COLOR_BayerGR2BGR_VNG,

    COLOR_BayerRGGB2RGB_VNG = COLOR_BayerBGGR2BGR_VNG,
    COLOR_BayerGRBG2RGB_VNG = COLOR_BayerGBRG2BGR_VNG,
    COLOR_BayerBGGR2RGB_VNG = COLOR_BayerRGGB2BGR_VNG,
    COLOR_BayerGBRG2RGB_VNG = COLOR_BayerGRBG2BGR_VNG,

    COLOR_BayerBG2RGB_VNG = COLOR_BayerRG2BGR_VNG, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2RGB_VNG = COLOR_BayerGR2BGR_VNG, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2RGB_VNG = COLOR_BayerBG2BGR_VNG, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2RGB_VNG = COLOR_BayerGB2BGR_VNG, //!< equivalent to GBRG Bayer pattern

    //! Edge-Aware Demosaicing
    COLOR_BayerBG2BGR_EA = 135, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2BGR_EA = 136, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2BGR_EA = 137, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2BGR_EA = 138, //!< equivalent to GBRG Bayer pattern

    COLOR_BayerRGGB2BGR_EA = COLOR_BayerBG2BGR_EA,
    COLOR_BayerGRBG2BGR_EA = COLOR_BayerGB2BGR_EA,
    COLOR_BayerBGGR2BGR_EA = COLOR_BayerRG2BGR_EA,
    COLOR_BayerGBRG2BGR_EA = COLOR_BayerGR2BGR_EA,

    COLOR_BayerRGGB2RGB_EA = COLOR_BayerBGGR2BGR_EA,
    COLOR_BayerGRBG2RGB_EA = COLOR_BayerGBRG2BGR_EA,
    COLOR_BayerBGGR2RGB_EA = COLOR_BayerRGGB2BGR_EA,
    COLOR_BayerGBRG2RGB_EA = COLOR_BayerGRBG2BGR_EA,

    COLOR_BayerBG2RGB_EA = COLOR_BayerRG2BGR_EA, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2RGB_EA = COLOR_BayerGR2BGR_EA, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2RGB_EA = COLOR_BayerBG2BGR_EA, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2RGB_EA = COLOR_BayerGB2BGR_EA, //!< equivalent to GBRG Bayer pattern

    //! Demosaicing with alpha channel
    COLOR_BayerBG2BGRA = 139, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2BGRA = 140, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2BGRA = 141, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2BGRA = 142, //!< equivalent to GBRG Bayer pattern

    COLOR_BayerRGGB2BGRA = COLOR_BayerBG2BGRA,
    COLOR_BayerGRBG2BGRA = COLOR_BayerGB2BGRA,
    COLOR_BayerBGGR2BGRA = COLOR_BayerRG2BGRA,
    COLOR_BayerGBRG2BGRA = COLOR_BayerGR2BGRA,

    COLOR_BayerRGGB2RGBA = COLOR_BayerBGGR2BGRA,
    COLOR_BayerGRBG2RGBA = COLOR_BayerGBRG2BGRA,
    COLOR_BayerBGGR2RGBA = COLOR_BayerRGGB2BGRA,
    COLOR_BayerGBRG2RGBA = COLOR_BayerGRBG2BGRA,

    COLOR_BayerBG2RGBA = COLOR_BayerRG2BGRA, //!< equivalent to RGGB Bayer pattern
    COLOR_BayerGB2RGBA = COLOR_BayerGR2BGRA, //!< equivalent to GRBG Bayer pattern
    COLOR_BayerRG2RGBA = COLOR_BayerBG2BGRA, //!< equivalent to BGGR Bayer pattern
    COLOR_BayerGR2RGBA = COLOR_BayerGB2BGRA, //!< equivalent to GBRG Bayer pattern

    //! RGB to YUV 4:2:2 family

    COLOR_RGB2YUV_UYVY = 143,
    COLOR_BGR2YUV_UYVY = 144,
    COLOR_RGB2YUV_Y422 = COLOR_RGB2YUV_UYVY,
    COLOR_BGR2YUV_Y422 = COLOR_BGR2YUV_UYVY,
    COLOR_RGB2YUV_UYNV = COLOR_RGB2YUV_UYVY,
    COLOR_BGR2YUV_UYNV = COLOR_BGR2YUV_UYVY,

    COLOR_RGBA2YUV_UYVY = 145,
    COLOR_BGRA2YUV_UYVY = 146,
    COLOR_RGBA2YUV_Y422 = COLOR_RGBA2YUV_UYVY,
    COLOR_BGRA2YUV_Y422 = COLOR_BGRA2YUV_UYVY,
    COLOR_RGBA2YUV_UYNV = COLOR_RGBA2YUV_UYVY,
    COLOR_BGRA2YUV_UYNV = COLOR_BGRA2YUV_UYVY,

    COLOR_RGB2YUV_YUY2 = 147,
    COLOR_BGR2YUV_YUY2 = 148,
    COLOR_RGB2YUV_YVYU = 149,
    COLOR_BGR2YUV_YVYU = 150,
    COLOR_RGB2YUV_YUYV = COLOR_RGB2YUV_YUY2,
    COLOR_BGR2YUV_YUYV = COLOR_BGR2YUV_YUY2,
    COLOR_RGB2YUV_YUNV = COLOR_RGB2YUV_YUY2,
    COLOR_BGR2YUV_YUNV = COLOR_BGR2YUV_YUY2,

    COLOR_RGBA2YUV_YUY2 = 151,
    COLOR_BGRA2YUV_YUY2 = 152,
    COLOR_RGBA2YUV_YVYU = 153,
    COLOR_BGRA2YUV_YVYU = 154,
    COLOR_RGBA2YUV_YUYV = COLOR_RGBA2YUV_YUY2,
    COLOR_BGRA2YUV_YUYV = COLOR_BGRA2YUV_YUY2,
    COLOR_RGBA2YUV_YUNV = COLOR_RGBA2YUV_YUY2,
    COLOR_BGRA2YUV_YUNV = COLOR_BGRA2YUV_YUY2,

    COLOR_COLORCVT_MAX = 155
};

/** Histogram comparison methods
  @ingroup imgproc_hist
*/
enum
{
    /** Correlation
    \f[d(H_1,H_2) =  \frac{\sum_I (H_1(I) - \bar{H_1}) (H_2(I) - \bar{H_2})}{\sqrt{\sum_I(H_1(I) - \bar{H_1})^2 \sum_I(H_2(I) - \bar{H_2})^2}}\f]
    where
    \f[\bar{H_k} =  \frac{1}{N} \sum _J H_k(J)\f]
    and \f$N\f$ is a total number of histogram bins. */
    HISTCMP_CORREL = 0,
    /** Chi-Square
    \f[d(H_1,H_2) =  \sum _I  \frac{\left(H_1(I)-H_2(I)\right)^2}{H_1(I)}\f] */
    HISTCMP_CHISQR = 1,
    /** Intersection
    \f[d(H_1,H_2) =  \sum _I  \min (H_1(I), H_2(I))\f] */
    HISTCMP_INTERSECT = 2,
    /** Bhattacharyya distance
    (In fact, OpenCV computes Hellinger distance, which is related to Bhattacharyya coefficient.)
    \f[d(H_1,H_2) =  \sqrt{1 - \frac{1}{\sqrt{\bar{H_1} \bar{H_2} N^2}} \sum_I \sqrt{H_1(I) \cdot H_2(I)}}\f] */
    HISTCMP_BHATTACHARYYA = 3,
    HISTCMP_HELLINGER = HISTCMP_BHATTACHARYYA, //!< Synonym for HISTCMP_BHATTACHARYYA
    /** Alternative Chi-Square
    \f[d(H_1,H_2) =  2 * \sum _I  \frac{\left(H_1(I)-H_2(I)\right)^2}{H_1(I)+H_2(I)}\f]
    This alternative formula is regularly used for texture comparison. See e.g. @cite Puzicha1997 */
    HISTCMP_CHISQR_ALT = 4,
    /** Kullback-Leibler divergence
    \f[d(H_1,H_2) = \sum _I H_1(I) \log \left(\frac{H_1(I)}{H_2(I)}\right)\f] */
    HISTCMP_KL_DIV = 5
};

//! Various border types, image boundaries are denoted with `|`
//! @see borderInterpolate, copyMakeBorder
enum
{
    BORDER_CONSTANT = 0,    //!< `iiiiii|abcdefgh|iiiiiii`  with some specified `i`
    BORDER_REPLICATE = 1,   //!< `aaaaaa|abcdefgh|hhhhhhh`
    BORDER_REFLECT = 2,     //!< `fedcba|abcdefgh|hgfedcb`
    BORDER_WRAP = 3,        //!< `cdefgh|abcdefgh|abcdefg`
    BORDER_REFLECT_101 = 4, //!< `gfedcb|abcdefgh|gfedcba`
    BORDER_TRANSPARENT = 5, //!< `uvwxyz|abcdefgh|ijklmno` - Treats outliers as transparent.

    BORDER_REFLECT101 = BORDER_REFLECT_101, //!< same as BORDER_REFLECT_101
    BORDER_DEFAULT = BORDER_REFLECT_101,    //!< same as BORDER_REFLECT_101
    BORDER_ISOLATED = 16                    //!< Interpolation restricted within the ROI boundaries.
};

enum
{
    FILTER_SCHARR = -1
};

//! type of morphological operation
enum
{
    MORPH_ERODE = 0,  //!< see #erode
    MORPH_DILATE = 1, //!< see #dilate
    MORPH_OPEN = 2,   //!< an opening operation
    //!< \f[\texttt{dst} = \mathrm{open} ( \texttt{src} , \texttt{element} )= \mathrm{dilate} ( \mathrm{erode} ( \texttt{src} , \texttt{element} ))\f]
    MORPH_CLOSE = 3, //!< a closing operation
    //!< \f[\texttt{dst} = \mathrm{close} ( \texttt{src} , \texttt{element} )= \mathrm{erode} ( \mathrm{dilate} ( \texttt{src} , \texttt{element} ))\f]
    MORPH_GRADIENT = 4, //!< a morphological gradient
    //!< \f[\texttt{dst} = \mathrm{morph\_grad} ( \texttt{src} , \texttt{element} )= \mathrm{dilate} ( \texttt{src} , \texttt{element} )- \mathrm{erode} ( \texttt{src} , \texttt{element} )\f]
    MORPH_TOPHAT = 5, //!< "top hat"
    //!< \f[\texttt{dst} = \mathrm{tophat} ( \texttt{src} , \texttt{element} )= \texttt{src} - \mathrm{open} ( \texttt{src} , \texttt{element} )\f]
    MORPH_BLACKHAT = 6, //!< "black hat"
    //!< \f[\texttt{dst} = \mathrm{blackhat} ( \texttt{src} , \texttt{element} )= \mathrm{close} ( \texttt{src} , \texttt{element} )- \texttt{src}\f]
    MORPH_HITMISS = 7 //!< "hit or miss"
    //!<   .- Only supported for CV_8UC1 binary images. A tutorial can be found in the documentation
};

//! shape of the structuring element
enum
{
    MORPH_RECT = 0,  //!< a rectangular structuring element:  \f[E_{ij}=1\f]
    MORPH_CROSS = 1, //!< a cross-shaped structuring element:
    //!< \f[E_{ij} = \begin{cases} 1 & \texttt{if } {i=\texttt{anchor.y } {or } {j=\texttt{anchor.x}}} \\0 & \texttt{otherwise} \end{cases}\f]
    MORPH_ELLIPSE = 2 //!< an elliptic structuring element, that is, a filled ellipse inscribed
    //!< into the rectangle Rect(0, 0, esize.width, 0.esize.height)
};

//! @} imgproc_filter

//! @addtogroup imgproc_transform
//! @{

//! interpolation algorithm
enum
{
    /** nearest neighbor interpolation */
    INTER_NEAREST = 0,
    /** bilinear interpolation */
    INTER_LINEAR = 1,
    /** bicubic interpolation */
    INTER_CUBIC = 2,
    /** resampling using pixel area relation. It may be a preferred method for image decimation, as
    it gives moire'-free results. But when the image is zoomed, it is similar to the INTER_NEAREST
    method. */
    INTER_AREA = 3,
    /** Lanczos interpolation over 8x8 neighborhood */
    INTER_LANCZOS4 = 4,
    /** Bit exact bilinear interpolation */
    INTER_LINEAR_EXACT = 5,
    /** Bit exact nearest neighbor interpolation. This will produce same results as
    the nearest neighbor method in PIL, scikit-image or Matlab. */
    INTER_NEAREST_EXACT = 6,
    /** mask for interpolation codes */
    INTER_MAX = 7,
    /** flag, fills all of the destination image pixels. If some of them correspond to outliers in the
    source image, they are set to zero */
    WARP_FILL_OUTLIERS = 8,
    /** flag, inverse transformation

    For example, #linearPolar or #logPolar transforms:
    - flag is __not__ set: \f$dst( \rho , \phi ) = src(x,y)\f$
    - flag is set: \f$dst(x,y) = src( \rho , \phi )\f$
    */
    WARP_INVERSE_MAP = 16
};

/** \brief Specify the polar mapping mode
@sa warpPolar
*/
enum
{
    WARP_POLAR_LINEAR = 0, ///< Remaps an image to/from polar space.
    WARP_POLAR_LOG = 256   ///< Remaps an image to/from semilog-polar space.
};

enum
{
    INTER_BITS = 5,
    INTER_BITS2 = INTER_BITS * 2,
    INTER_TAB_SIZE = 1 << INTER_BITS,
    INTER_TAB_SIZE2 = INTER_TAB_SIZE * INTER_TAB_SIZE
};

//! @} imgproc_transform

//! @addtogroup imgproc_misc
//! @{

//! Distance types for Distance Transform and M-estimators
//! @see distanceTransform, fitLine
enum
{
    DIST_USER = -1,  //!< User defined distance
    DIST_L1 = 1,     //!< distance = |x1-x2| + |y1-y2|
    DIST_L2 = 2,     //!< the simple euclidean distance
    DIST_C = 3,      //!< distance = max(|x1-x2|,|y1-y2|)
    DIST_L12 = 4,    //!< L1-L2 metric: distance = 2(sqrt(1+x*x/2) - 1))
    DIST_FAIR = 5,   //!< distance = c^2(|x|/c-log(1+|x|/c)), c = 1.3998
    DIST_WELSCH = 6, //!< distance = c^2/2(1-exp(-(x/c)^2)), c = 2.9846
    DIST_HUBER = 7   //!< distance = |x|<c ? x^2/2 : c(|x|-c/2), c=1.345
};

//! Mask size for distance transform
enum
{
    DIST_MASK_3 = 3,      //!< mask=3
    DIST_MASK_5 = 5,      //!< mask=5
    DIST_MASK_PRECISE = 0 //!<
};

//! type of the threshold operation
//! ![threshold types](pics/threshold.png)
enum
{
    THRESH_BINARY = 0,     //!< \f[\texttt{dst} (x,y) =  \fork{\texttt{maxval}}{if \(\texttt{src}(x,y) > \texttt{thresh}\)}{0}{otherwise}\f]
    THRESH_BINARY_INV = 1, //!< \f[\texttt{dst} (x,y) =  \fork{0}{if \(\texttt{src}(x,y) > \texttt{thresh}\)}{\texttt{maxval}}{otherwise}\f]
    THRESH_TRUNC = 2,      //!< \f[\texttt{dst} (x,y) =  \fork{\texttt{threshold}}{if \(\texttt{src}(x,y) > \texttt{thresh}\)}{\texttt{src}(x,y)}{otherwise}\f]
    THRESH_TOZERO = 3,     //!< \f[\texttt{dst} (x,y) =  \fork{\texttt{src}(x,y)}{if \(\texttt{src}(x,y) > \texttt{thresh}\)}{0}{otherwise}\f]
    THRESH_TOZERO_INV = 4, //!< \f[\texttt{dst} (x,y) =  \fork{0}{if \(\texttt{src}(x,y) > \texttt{thresh}\)}{\texttt{src}(x,y)}{otherwise}\f]
    THRESH_MASK = 7,
    THRESH_OTSU = 8,     //!< flag, use Otsu algorithm to choose the optimal threshold value
    THRESH_TRIANGLE = 16 //!< flag, use Triangle algorithm to choose the optimal threshold value
};

//! adaptive threshold algorithm
//! @see adaptiveThreshold
enum
{
    /** the threshold value \f$T(x,y)\f$ is a mean of the \f$\texttt{blockSize} \times
    \texttt{blockSize}\f$ neighborhood of \f$(x, y)\f$ minus C */
    ADAPTIVE_THRESH_MEAN_C = 0,
    /** the threshold value \f$T(x, y)\f$ is a weighted sum (cross-correlation with a Gaussian
    window) of the \f$\texttt{blockSize} \times \texttt{blockSize}\f$ neighborhood of \f$(x, y)\f$
    minus C . The default sigma (standard deviation) is used for the specified blockSize . See
    #getGaussianKernel*/
    ADAPTIVE_THRESH_GAUSSIAN_C = 1
};

//! class of the pixel in GrabCut algorithm
enum
{
    GC_BGD = 0,    //!< an obvious background pixels
    GC_FGD = 1,    //!< an obvious foreground (object) pixel
    GC_PR_BGD = 2, //!< a possible background pixel
    GC_PR_FGD = 3  //!< a possible foreground pixel
};

//! GrabCut algorithm flags
enum
{
    /** The function initializes the state and the mask using the provided rectangle. After that it
    runs iterCount iterations of the algorithm. */
    GC_INIT_WITH_RECT = 0,
    /** The function initializes the state using the provided mask. Note that GC_INIT_WITH_RECT
    and GC_INIT_WITH_MASK can be combined. Then, all the pixels outside of the ROI are
    automatically initialized with GC_BGD .*/
    GC_INIT_WITH_MASK = 1,
    /** The value means that the algorithm should just resume. */
    GC_EVAL = 2,
    /** The value means that the algorithm should just run the grabCut algorithm (a single iteration) with the fixed model */
    GC_EVAL_FREEZE_MODEL = 3
};

//! distanceTransform algorithm flags
enum
{
    /** each connected component of zeros in src (as well as all the non-zero pixels closest to the
    connected component) will be assigned the same label */
    DIST_LABEL_CCOMP = 0,
    /** each zero pixel (and all the non-zero pixels closest to it) gets its own label. */
    DIST_LABEL_PIXEL = 1
};

//! floodfill algorithm flags
enum
{
    /** If set, the difference between the current pixel and seed pixel is considered. Otherwise,
    the difference between neighbor pixels is considered (that is, the range is floating). */
    FLOODFILL_FIXED_RANGE = 1 << 16,
    /** If set, the function does not change the image ( newVal is ignored), and only fills the
    mask with the value specified in bits 8-16 of flags as described above. This option only make
    sense in function variants that have the mask parameter. */
    FLOODFILL_MASK_ONLY = 1 << 17
};

//! @} imgproc_misc

//! @addtogroup imgproc_shape
//! @{

//! connected components statistics
enum
{
    CC_STAT_LEFT = 0, //!< The leftmost (x) coordinate which is the inclusive start of the bounding
    //!< box in the horizontal direction.
    CC_STAT_TOP = 1, //!< The topmost (y) coordinate which is the inclusive start of the bounding
    //!< box in the vertical direction.
    CC_STAT_WIDTH = 2,  //!< The horizontal size of the bounding box
    CC_STAT_HEIGHT = 3, //!< The vertical size of the bounding box
    CC_STAT_AREA = 4,   //!< The total area (in pixels) of the connected component
#ifndef CV_DOXYGEN
    CC_STAT_MAX = 5 //!< Max enumeration value. Used internally only for memory allocation
#endif
};

//! connected components algorithm
enum
{
    CCL_DEFAULT = -1,  //!< Spaghetti @cite Bolelli2019 algorithm for 8-way connectivity, Spaghetti4C @cite Bolelli2021 algorithm for 4-way connectivity.
    CCL_WU = 0,        //!< SAUF @cite Wu2009 algorithm for 8-way connectivity, SAUF algorithm for 4-way connectivity. The parallel implementation described in @cite Bolelli2017 is available for SAUF.
    CCL_GRANA = 1,     //!< BBDT @cite Grana2010 algorithm for 8-way connectivity, SAUF algorithm for 4-way connectivity. The parallel implementation described in @cite Bolelli2017 is available for both BBDT and SAUF.
    CCL_BOLELLI = 2,   //!< Spaghetti @cite Bolelli2019 algorithm for 8-way connectivity, Spaghetti4C @cite Bolelli2021 algorithm for 4-way connectivity. The parallel implementation described in @cite Bolelli2017 is available for both Spaghetti and Spaghetti4C.
    CCL_SAUF = 3,      //!< Same as CCL_WU. It is preferable to use the flag with the name of the algorithm (CCL_SAUF) rather than the one with the name of the first author (CCL_WU).
    CCL_BBDT = 4,      //!< Same as CCL_GRANA. It is preferable to use the flag with the name of the algorithm (CCL_BBDT) rather than the one with the name of the first author (CCL_GRANA).
    CCL_SPAGHETTI = 5, //!< Same as CCL_BOLELLI. It is preferable to use the flag with the name of the algorithm (CCL_SPAGHETTI) rather than the one with the name of the first author (CCL_BOLELLI).
};

//! mode of the contour retrieval algorithm
enum
{
    /** retrieves only the extreme outer contours. It sets `hierarchy[i][2]=hierarchy[i][3]=-1` for
    all the contours. */
    RETR_EXTERNAL = 0,
    /** retrieves all of the contours without establishing any hierarchical relationships. */
    RETR_LIST = 1,
    /** retrieves all of the contours and organizes them into a two-level hierarchy. At the top
    level, there are external boundaries of the components. At the second level, there are
    boundaries of the holes. If there is another contour inside a hole of a connected component, it
    is still put at the top level. */
    RETR_CCOMP = 2,
    /** retrieves all of the contours and reconstructs a full hierarchy of nested contours.*/
    RETR_TREE = 3,
    RETR_FLOODFILL = 4 //!<
};

//! the contour approximation algorithm
enum
{
    /** stores absolutely all the contour points. That is, any 2 subsequent points (x1,y1) and
    (x2,y2) of the contour will be either horizontal, vertical or diagonal neighbors, that is,
    max(abs(x1-x2),abs(y2-y1))==1. */
    CHAIN_APPROX_NONE = 1,
    /** compresses horizontal, vertical, and diagonal segments and leaves only their end points.
    For example, an up-right rectangular contour is encoded with 4 points. */
    CHAIN_APPROX_SIMPLE = 2,
    /** applies one of the flavors of the Teh-Chin chain approximation algorithm @cite TehChin89 */
    CHAIN_APPROX_TC89_L1 = 3,
    /** applies one of the flavors of the Teh-Chin chain approximation algorithm @cite TehChin89 */
    CHAIN_APPROX_TC89_KCOS = 4
};

/** @brief Shape matching methods

\f$A\f$ denotes object1,\f$B\f$ denotes object2

\f$\begin{array}{l} m^A_i =  \mathrm{sign} (h^A_i)  \cdot \log{h^A_i} \\ m^B_i =  \mathrm{sign} (h^B_i)  \cdot \log{h^B_i} \end{array}\f$

and \f$h^A_i, h^B_i\f$ are the Hu moments of \f$A\f$ and \f$B\f$ , respectively.
*/
enum
{
    CONTOURS_MATCH_I1 = 1, //!< \f[I_1(A,B) =  \sum _{i=1...7}  \left |  \frac{1}{m^A_i} -  \frac{1}{m^B_i} \right |\f]
    CONTOURS_MATCH_I2 = 2, //!< \f[I_2(A,B) =  \sum _{i=1...7}  \left | m^A_i - m^B_i  \right |\f]
    CONTOURS_MATCH_I3 = 3  //!< \f[I_3(A,B) =  \max _{i=1...7}  \frac{ \left| m^A_i - m^B_i \right| }{ \left| m^A_i \right| }\f]
};

//! @} imgproc_shape

//! @addtogroup imgproc_feature
//! @{

//! Variants of a Hough transform
enum
{

    /** classical or standard Hough transform. Every line is represented by two floating-point
    numbers \f$(\rho, \theta)\f$ , where \f$\rho\f$ is a distance between (0,0) point and the line,
    and \f$\theta\f$ is the angle between x-axis and the normal to the line. Thus, the matrix must
    be (the created sequence will be) of CV_32FC2 type */
    HOUGH_STANDARD = 0,
    /** probabilistic Hough transform (more efficient in case if the picture contains a few long
    linear segments). It returns line segments rather than the whole line. Each segment is
    represented by starting and ending points, and the matrix must be (the created sequence will
    be) of the CV_32SC4 type. */
    HOUGH_PROBABILISTIC = 1,
    /** multi-scale variant of the classical Hough transform. The lines are encoded the same way as
    HOUGH_STANDARD. */
    HOUGH_MULTI_SCALE = 2,
    HOUGH_GRADIENT = 3,     //!< basically *21HT*, described in @cite Yuen90
    HOUGH_GRADIENT_ALT = 4, //!< variation of HOUGH_GRADIENT to get better accuracy
};

//! Variants of Line Segment %Detector
enum
{
    LSD_REFINE_NONE = 0, //!< No refinement applied
    LSD_REFINE_STD = 1,  //!< Standard refinement is applied. E.g. breaking arches into smaller straighter line approximations.
    LSD_REFINE_ADV = 2   //!< Advanced refinement. Number of false alarms is calculated, lines are
    //!< refined through increase of precision, decrement in size, etc.
};

//! @addtogroup imgproc_shape
//! @{

//! types of intersection between rectangles
enum
{
    INTERSECT_NONE = 0,    //!< No intersection
    INTERSECT_PARTIAL = 1, //!< There is a partial intersection
    INTERSECT_FULL = 2     //!< One of the rectangle is fully enclosed in the other
};

/** types of line
@ingroup imgproc_draw
*/
enum
{
    FILLED = -1,
    LINE_4 = 4,  //!< 4-connected line
    LINE_8 = 8,  //!< 8-connected line
    LINE_AA = 16 //!< antialiased line
};

/** Only a subset of Hershey fonts <https://en.wikipedia.org/wiki/Hershey_fonts> are supported
@ingroup imgproc_draw
*/
enum
{
    FONT_HERSHEY_SIMPLEX = 0,        //!< normal size sans-serif font
    FONT_HERSHEY_PLAIN = 1,          //!< small size sans-serif font
    FONT_HERSHEY_DUPLEX = 2,         //!< normal size sans-serif font (more complex than FONT_HERSHEY_SIMPLEX)
    FONT_HERSHEY_COMPLEX = 3,        //!< normal size serif font
    FONT_HERSHEY_TRIPLEX = 4,        //!< normal size serif font (more complex than FONT_HERSHEY_COMPLEX)
    FONT_HERSHEY_COMPLEX_SMALL = 5,  //!< smaller version of FONT_HERSHEY_COMPLEX
    FONT_HERSHEY_SCRIPT_SIMPLEX = 6, //!< hand-writing style font
    FONT_HERSHEY_SCRIPT_COMPLEX = 7, //!< more complex variant of FONT_HERSHEY_SCRIPT_SIMPLEX
    FONT_ITALIC = 16                 //!< flag for italic font
};

/** Possible set of marker types used for the cv::drawMarker function
@ingroup imgproc_draw
*/
enum
{
    MARKER_CROSS = 0,        //!< A crosshair marker shape
    MARKER_TILTED_CROSS = 1, //!< A 45 degree tilted crosshair marker shape
    MARKER_STAR = 2,         //!< A star marker shape, combination of cross and tilted cross
    MARKER_DIAMOND = 3,      //!< A diamond marker shape
    MARKER_SQUARE = 4,       //!< A square marker shape
    MARKER_TRIANGLE_UP = 5,  //!< An upwards pointing triangle marker shape
    MARKER_TRIANGLE_DOWN = 6 //!< A downwards pointing triangle marker shape
};

//! matrix decomposition types
enum
{
    /** Gaussian elimination with the optimal pivot element chosen. */
    DECOMP_LU = 0,
    /** singular value decomposition (SVD) method; the system can be over-defined and/or the matrix
    src1 can be singular */
    DECOMP_SVD = 1,
    /** eigenvalue decomposition; the matrix src1 must be symmetrical */
    DECOMP_EIG = 2,
    /** Cholesky \f$LL^T\f$ factorization; the matrix src1 must be symmetrical and positively
    defined */
    DECOMP_CHOLESKY = 3,
    /** QR factorization; the system can be over-defined and/or the matrix src1 can be singular */
    DECOMP_QR = 4,
    /** while all the previous flags are mutually exclusive, this flag can be used together with
    any of the previous; it means that the normal equations
    \f$\texttt{src1}^T\cdot\texttt{src1}\cdot\texttt{dst}=\texttt{src1}^T\texttt{src2}\f$ are
    solved instead of the original system
    \f$\texttt{src1}\cdot\texttt{dst}=\texttt{src2}\f$ */
    DECOMP_NORMAL = 16
};

/** norm types

src1 and src2 denote input arrays.
*/

enum
{
    /**
    \f[
    norm =  \forkthree
    {\|\texttt{src1}\|_{L_{\infty}} =  \max _I | \texttt{src1} (I)|}{if  \(\texttt{normType} = \texttt{NORM_INF}\) }
    {\|\texttt{src1}-\texttt{src2}\|_{L_{\infty}} =  \max _I | \texttt{src1} (I) -  \texttt{src2} (I)|}{if  \(\texttt{normType} = \texttt{NORM_INF}\) }
    {\frac{\|\texttt{src1}-\texttt{src2}\|_{L_{\infty}}    }{\|\texttt{src2}\|_{L_{\infty}} }}{if  \(\texttt{normType} = \texttt{NORM_RELATIVE | NORM_INF}\) }
    \f]
    */
    NORM_INF = 1,
    /**
    \f[
    norm =  \forkthree
    {\| \texttt{src1} \| _{L_1} =  \sum _I | \texttt{src1} (I)|}{if  \(\texttt{normType} = \texttt{NORM_L1}\)}
    { \| \texttt{src1} - \texttt{src2} \| _{L_1} =  \sum _I | \texttt{src1} (I) -  \texttt{src2} (I)|}{if  \(\texttt{normType} = \texttt{NORM_L1}\) }
    { \frac{\|\texttt{src1}-\texttt{src2}\|_{L_1} }{\|\texttt{src2}\|_{L_1}} }{if  \(\texttt{normType} = \texttt{NORM_RELATIVE | NORM_L1}\) }
    \f]*/
    NORM_L1 = 2,
    /**
    \f[
    norm =  \forkthree
    { \| \texttt{src1} \| _{L_2} =  \sqrt{\sum_I \texttt{src1}(I)^2} }{if  \(\texttt{normType} = \texttt{NORM_L2}\) }
    { \| \texttt{src1} - \texttt{src2} \| _{L_2} =  \sqrt{\sum_I (\texttt{src1}(I) - \texttt{src2}(I))^2} }{if  \(\texttt{normType} = \texttt{NORM_L2}\) }
    { \frac{\|\texttt{src1}-\texttt{src2}\|_{L_2} }{\|\texttt{src2}\|_{L_2}} }{if  \(\texttt{normType} = \texttt{NORM_RELATIVE | NORM_L2}\) }
    \f]
    */
    NORM_L2 = 4,
    /**
    \f[
    norm =  \forkthree
    { \| \texttt{src1} \| _{L_2} ^{2} = \sum_I \texttt{src1}(I)^2} {if  \(\texttt{normType} = \texttt{NORM_L2SQR}\)}
    { \| \texttt{src1} - \texttt{src2} \| _{L_2} ^{2} =  \sum_I (\texttt{src1}(I) - \texttt{src2}(I))^2 }{if  \(\texttt{normType} = \texttt{NORM_L2SQR}\) }
    { \left(\frac{\|\texttt{src1}-\texttt{src2}\|_{L_2} }{\|\texttt{src2}\|_{L_2}}\right)^2 }{if  \(\texttt{normType} = \texttt{NORM_RELATIVE | NORM_L2SQR}\) }
    \f]
    */
    NORM_L2SQR = 5,
    /**
    In the case of one input array, calculates the Hamming distance of the array from zero,
    In the case of two input arrays, calculates the Hamming distance between the arrays.
    */
    NORM_HAMMING = 6,
    /**
    Similar to NORM_HAMMING, but in the calculation, each two bits of the input sequence will
    be added and treated as a single bit to be used in the same calculation as NORM_HAMMING.
    */
    NORM_HAMMING2 = 7,
    NORM_TYPE_MASK = 7, //!< bit-mask which can be used to separate norm type from norm flags
    NORM_RELATIVE = 8,  //!< flag
    NORM_MINMAX = 32    //!< flag
};

//! comparison types
enum
{
    CMP_EQ = 0, //!< src1 is equal to src2.
    CMP_GT = 1, //!< src1 is greater than src2.
    CMP_GE = 2, //!< src1 is greater than or equal to src2.
    CMP_LT = 3, //!< src1 is less than src2.
    CMP_LE = 4, //!< src1 is less than or equal to src2.
    CMP_NE = 5  //!< src1 is unequal to src2.
};

//! generalized matrix multiplication flags
enum
{
    GEMM_1_T = 1, //!< transposes src1
    GEMM_2_T = 2, //!< transposes src2
    GEMM_3_T = 4  //!< transposes src3
};

enum
{
    /** performs an inverse 1D or 2D transform instead of the default forward
        transform. */
    DFT_INVERSE = 1,
    /** scales the result: divide it by the number of array elements. Normally, it is
        combined with DFT_INVERSE. */
    DFT_SCALE = 2,
    /** performs a forward or inverse transform of every individual row of the input
        matrix; this flag enables you to transform multiple vectors simultaneously and can be used to
        decrease the overhead (which is sometimes several times larger than the processing itself) to
        perform 3D and higher-dimensional transformations and so forth.*/
    DFT_ROWS = 4,
    /** performs a forward transformation of 1D or 2D real array; the result,
        though being a complex array, has complex-conjugate symmetry (*CCS*, see the function
        description below for details), and such an array can be packed into a real array of the same
        size as input, which is the fastest option and which is what the function does by default;
        however, you may wish to get a full complex array (for simpler spectrum analysis, and so on) -
        pass the flag to enable the function to produce a full-size complex output array. */
    DFT_COMPLEX_OUTPUT = 16,
    /** performs an inverse transformation of a 1D or 2D complex array; the
        result is normally a complex array of the same size, however, if the input array has
        conjugate-complex symmetry (for example, it is a result of forward transformation with
        DFT_COMPLEX_OUTPUT flag), the output is a real array; while the function itself does not
        check whether the input is symmetrical or not, you can pass the flag and then the function
        will assume the symmetry and produce the real output array (note that when the input is packed
        into a real array and inverse transformation is executed, the function treats the input as a
        packed complex-conjugate symmetrical array, and the output will also be a real array). */
    DFT_REAL_OUTPUT = 32,
    /** specifies that input is complex input. If this flag is set, the input must have 2 channels.
        On the other hand, for backwards compatibility reason, if input has 2 channels, input is
        already considered complex. */
    DFT_COMPLEX_INPUT = 64,
    /** performs an inverse 1D or 2D transform instead of the default forward transform. */
    DCT_INVERSE = DFT_INVERSE,
    /** performs a forward or inverse transform of every individual row of the input
        matrix. This flag enables you to transform multiple vectors simultaneously and can be used to
        decrease the overhead (which is sometimes several times larger than the processing itself) to
        perform 3D and higher-dimensional transforms and so forth.*/
    DCT_ROWS = DFT_ROWS
};

//! GNU Octave/MATLAB equivalent colormaps
enum
{
    COLORMAP_AUTUMN = 0,            //!< ![autumn](pics/colormaps/colorscale_autumn.jpg)
    COLORMAP_BONE = 1,              //!< ![bone](pics/colormaps/colorscale_bone.jpg)
    COLORMAP_JET = 2,               //!< ![jet](pics/colormaps/colorscale_jet.jpg)
    COLORMAP_WINTER = 3,            //!< ![winter](pics/colormaps/colorscale_winter.jpg)
    COLORMAP_RAINBOW = 4,           //!< ![rainbow](pics/colormaps/colorscale_rainbow.jpg)
    COLORMAP_OCEAN = 5,             //!< ![ocean](pics/colormaps/colorscale_ocean.jpg)
    COLORMAP_SUMMER = 6,            //!< ![summer](pics/colormaps/colorscale_summer.jpg)
    COLORMAP_SPRING = 7,            //!< ![spring](pics/colormaps/colorscale_spring.jpg)
    COLORMAP_COOL = 8,              //!< ![cool](pics/colormaps/colorscale_cool.jpg)
    COLORMAP_HSV = 9,               //!< ![HSV](pics/colormaps/colorscale_hsv.jpg)
    COLORMAP_PINK = 10,             //!< ![pink](pics/colormaps/colorscale_pink.jpg)
    COLORMAP_HOT = 11,              //!< ![hot](pics/colormaps/colorscale_hot.jpg)
    COLORMAP_PARULA = 12,           //!< ![parula](pics/colormaps/colorscale_parula.jpg)
    COLORMAP_MAGMA = 13,            //!< ![magma](pics/colormaps/colorscale_magma.jpg)
    COLORMAP_INFERNO = 14,          //!< ![inferno](pics/colormaps/colorscale_inferno.jpg)
    COLORMAP_PLASMA = 15,           //!< ![plasma](pics/colormaps/colorscale_plasma.jpg)
    COLORMAP_VIRIDIS = 16,          //!< ![viridis](pics/colormaps/colorscale_viridis.jpg)
    COLORMAP_CIVIDIS = 17,          //!< ![cividis](pics/colormaps/colorscale_cividis.jpg)
    COLORMAP_TWILIGHT = 18,         //!< ![twilight](pics/colormaps/colorscale_twilight.jpg)
    COLORMAP_TWILIGHT_SHIFTED = 19, //!< ![twilight shifted](pics/colormaps/colorscale_twilight_shifted.jpg)
    COLORMAP_TURBO = 20,            //!< ![turbo](pics/colormaps/colorscale_turbo.jpg)
    COLORMAP_DEEPGREEN = 21         //!< ![deepgreen](pics/colormaps/colorscale_deepgreen.jpg)
};

//! Imread flags
enum
{
    IMREAD_UNCHANGED = -1,           //!< If set, return the loaded image as is (with alpha channel, otherwise it gets cropped). Ignore EXIF orientation.
    IMREAD_GRAYSCALE = 0,            //!< If set, always convert image to the single channel grayscale image (codec internal conversion).
    IMREAD_COLOR = 1,                //!< If set, always convert image to the 3 channel BGR color image.
    IMREAD_ANYDEPTH = 2,             //!< If set, return 16-bit/32-bit image when the input has the corresponding depth, otherwise convert it to 8-bit.
    IMREAD_ANYCOLOR = 4,             //!< If set, the image is read in any possible color format.
    IMREAD_LOAD_GDAL = 8,            //!< If set, use the gdal driver for loading the image.
    IMREAD_REDUCED_GRAYSCALE_2 = 16, //!< If set, always convert image to the single channel grayscale image and the image size reduced 1/2.
    IMREAD_REDUCED_COLOR_2 = 17,     //!< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/2.
    IMREAD_REDUCED_GRAYSCALE_4 = 32, //!< If set, always convert image to the single channel grayscale image and the image size reduced 1/4.
    IMREAD_REDUCED_COLOR_4 = 33,     //!< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/4.
    IMREAD_REDUCED_GRAYSCALE_8 = 64, //!< If set, always convert image to the single channel grayscale image and the image size reduced 1/8.
    IMREAD_REDUCED_COLOR_8 = 65,     //!< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/8.
    IMREAD_IGNORE_ORIENTATION = 128  //!< If set, do not rotate the image according to EXIF's orientation flag.
};

//! Imwrite flags
enum
{
    IMWRITE_JPEG_QUALITY = 1,                                  //!< For JPEG, it can be a quality from 0 to 100 (the higher is the better). Default value is 95.
    IMWRITE_JPEG_PROGRESSIVE = 2,                              //!< Enable JPEG features, 0 or 1, default is False.
    IMWRITE_JPEG_OPTIMIZE = 3,                                 //!< Enable JPEG features, 0 or 1, default is False.
    IMWRITE_JPEG_RST_INTERVAL = 4,                             //!< JPEG restart interval, 0 - 65535, default is 0 - no restart.
    IMWRITE_JPEG_LUMA_QUALITY = 5,                             //!< Separate luma quality level, 0 - 100, default is -1 - don't use.
    IMWRITE_JPEG_CHROMA_QUALITY = 6,                           //!< Separate chroma quality level, 0 - 100, default is -1 - don't use.
    IMWRITE_JPEG_SAMPLING_FACTOR = 7,                          //!< For JPEG, set sampling factor. See cv::ImwriteJPEGSamplingFactorParams.
    IMWRITE_PNG_COMPRESSION = 16,                              //!< For PNG, it can be the compression level from 0 to 9. A higher value means a smaller size and longer compression time. If specified, strategy is changed to IMWRITE_PNG_STRATEGY_DEFAULT (Z_DEFAULT_STRATEGY). Default value is 1 (best speed setting).
    IMWRITE_PNG_STRATEGY = 17,                                 //!< One of cv::ImwritePNGFlags, default is IMWRITE_PNG_STRATEGY_RLE.
    IMWRITE_PNG_BILEVEL = 18,                                  //!< Binary level PNG, 0 or 1, default is 0.
    IMWRITE_PXM_BINARY = 32,                                   //!< For PPM, PGM, or PBM, it can be a binary format flag, 0 or 1. Default value is 1.
    IMWRITE_EXR_TYPE = (3 << 4) + 0 /* 48 */,                  //!< override EXR storage type (FLOAT (FP32) is default)
    IMWRITE_EXR_COMPRESSION = (3 << 4) + 1 /* 49 */,           //!< override EXR compression type (ZIP_COMPRESSION = 3 is default)
    IMWRITE_EXR_DWA_COMPRESSION_LEVEL = (3 << 4) + 2 /* 50 */, //!< override EXR DWA compression level (45 is default)
    IMWRITE_WEBP_QUALITY = 64,                                 //!< For WEBP, it can be a quality from 1 to 100 (the higher is the better). By default (without any parameter) and for quality above 100 the lossless compression is used.
    IMWRITE_HDR_COMPRESSION = (5 << 4) + 0 /* 80 */,           //!< specify HDR compression
    IMWRITE_PAM_TUPLETYPE = 128,                               //!< For PAM, sets the TUPLETYPE field to the corresponding string value that is defined for the format
    IMWRITE_TIFF_RESUNIT = 256,                                //!< For TIFF, use to specify which DPI resolution unit to set; see libtiff documentation for valid values
    IMWRITE_TIFF_XDPI = 257,                                   //!< For TIFF, use to specify the X direction DPI
    IMWRITE_TIFF_YDPI = 258,                                   //!< For TIFF, use to specify the Y direction DPI
    IMWRITE_TIFF_COMPRESSION = 259,                            //!< For TIFF, use to specify the image compression scheme. See libtiff for integer constants corresponding to compression formats. Note, for images whose depth is CV_32F, only libtiff's SGILOG compression scheme is used. For other supported depths, the compression scheme can be specified by this flag; LZW compression is the default.
    IMWRITE_JPEG2000_COMPRESSION_X1000 = 272,                  //!< For JPEG2000, use to specify the target compression rate (multiplied by 1000). The value can be from 0 to 1000. Default is 1000.
    IMWRITE_AVIF_QUALITY = 512,                                //!< For AVIF, it can be a quality between 0 and 100 (the higher the better). Default is 95.
    IMWRITE_AVIF_DEPTH = 513,                                  //!< For AVIF, it can be 8, 10 or 12. If >8, it is stored/read as CV_32F. Default is 8.
    IMWRITE_AVIF_SPEED = 514                                   //!< For AVIF, it is between 0 (slowest) and (fastest). Default is 9.
};

enum
{
    IMWRITE_JPEG_SAMPLING_FACTOR_411 = 0x411111, //!< 4x1,1x1,1x1
    IMWRITE_JPEG_SAMPLING_FACTOR_420 = 0x221111, //!< 2x2,1x1,1x1(Default)
    IMWRITE_JPEG_SAMPLING_FACTOR_422 = 0x211111, //!< 2x1,1x1,1x1
    IMWRITE_JPEG_SAMPLING_FACTOR_440 = 0x121111, //!< 1x2,1x1,1x1
    IMWRITE_JPEG_SAMPLING_FACTOR_444 = 0x111111  //!< 1x1,1x1,1x1(No subsampling)
};

enum
{
    /*IMWRITE_EXR_TYPE_UNIT = 0, //!< not supported */
    IMWRITE_EXR_TYPE_HALF = 1, //!< store as HALF (FP16)
    IMWRITE_EXR_TYPE_FLOAT = 2 //!< store as FP32 (default)
};

enum
{
    IMWRITE_EXR_COMPRESSION_NO = 0,    //!< no compression
    IMWRITE_EXR_COMPRESSION_RLE = 1,   //!< run length encoding
    IMWRITE_EXR_COMPRESSION_ZIPS = 2,  //!< zlib compression, one scan line at a time
    IMWRITE_EXR_COMPRESSION_ZIP = 3,   //!< zlib compression, in blocks of 16 scan lines
    IMWRITE_EXR_COMPRESSION_PIZ = 4,   //!< piz-based wavelet compression
    IMWRITE_EXR_COMPRESSION_PXR24 = 5, //!< lossy 24-bit float compression
    IMWRITE_EXR_COMPRESSION_B44 = 6,   //!< lossy 4-by-4 pixel block compression, fixed compression rate
    IMWRITE_EXR_COMPRESSION_B44A = 7,  //!< lossy 4-by-4 pixel block compression, flat fields are compressed more
    IMWRITE_EXR_COMPRESSION_DWAA = 8,  //!< lossy DCT based compression, in blocks of 32 scanlines. More efficient for partial buffer access. Supported since OpenEXR 2.2.0.
    IMWRITE_EXR_COMPRESSION_DWAB = 9,  //!< lossy DCT based compression, in blocks of 256 scanlines. More efficient space wise and faster to decode full frames than DWAA_COMPRESSION. Supported since OpenEXR 2.2.0.
};

//! Imwrite PNG specific flags used to tune the compression algorithm.
/** These flags will be modify the way of PNG image compression and will be passed to the underlying zlib processing stage.

-   The effect of IMWRITE_PNG_STRATEGY_FILTERED is to force more Huffman coding and less string matching; it is somewhat intermediate between IMWRITE_PNG_STRATEGY_DEFAULT and IMWRITE_PNG_STRATEGY_HUFFMAN_ONLY.
-   IMWRITE_PNG_STRATEGY_RLE is designed to be almost as fast as IMWRITE_PNG_STRATEGY_HUFFMAN_ONLY, but give better compression for PNG image data.
-   The strategy parameter only affects the compression ratio but not the correctness of the compressed output even if it is not set appropriately.
-   IMWRITE_PNG_STRATEGY_FIXED prevents the use of dynamic Huffman codes, allowing for a simpler decoder for special applications.
*/
enum
{
    IMWRITE_PNG_STRATEGY_DEFAULT = 0,      //!< Use this value for normal data.
    IMWRITE_PNG_STRATEGY_FILTERED = 1,     //!< Use this value for data produced by a filter (or predictor).Filtered data consists mostly of small values with a somewhat random distribution. In this case, the compression algorithm is tuned to compress them better.
    IMWRITE_PNG_STRATEGY_HUFFMAN_ONLY = 2, //!< Use this value to force Huffman encoding only (no string match).
    IMWRITE_PNG_STRATEGY_RLE = 3,          //!< Use this value to limit match distances to one (run-length encoding).
    IMWRITE_PNG_STRATEGY_FIXED = 4         //!< Using this value prevents the use of dynamic Huffman codes, allowing for a simpler decoder for special applications.
};

//! Imwrite PAM specific tupletype flags used to define the 'TUPLETYPE' field of a PAM file.
enum
{
    IMWRITE_PAM_FORMAT_NULL = 0,
    IMWRITE_PAM_FORMAT_BLACKANDWHITE = 1,
    IMWRITE_PAM_FORMAT_GRAYSCALE = 2,
    IMWRITE_PAM_FORMAT_GRAYSCALE_ALPHA = 3,
    IMWRITE_PAM_FORMAT_RGB = 4,
    IMWRITE_PAM_FORMAT_RGB_ALPHA = 5
};

//! Imwrite HDR specific values for IMWRITE_HDR_COMPRESSION parameter key
enum
{
    IMWRITE_HDR_COMPRESSION_NONE = 0,
    IMWRITE_HDR_COMPRESSION_RLE = 1
};

enum
{
    SORT_EVERY_ROW = 0,    //!< each matrix row is sorted independently
    SORT_EVERY_COLUMN = 1, //!< each matrix column is sorted
    //!< independently; this flag and the previous one are
    //!< mutually exclusive.
    SORT_ASCENDING = 0, //!< each matrix row is sorted in the ascending
    //!< order.
    SORT_DESCENDING = 16 //!< each matrix row is sorted in the
    //!< descending order; this flag and the previous one are also
    //!< mutually exclusive.
};

//! @} core_utils

//! @addtogroup core
//! @{

//! Covariation flags
enum
{
    /** The output covariance matrix is calculated as:
       \f[\texttt{scale}   \cdot  [  \texttt{vects}  [0]-  \texttt{mean}  , \texttt{vects}  [1]-  \texttt{mean}  ,...]^T  \cdot  [ \texttt{vects}  [0]- \texttt{mean}  , \texttt{vects}  [1]- \texttt{mean}  ,...],\f]
       The covariance matrix will be nsamples x nsamples. Such an unusual covariance matrix is used
       for fast PCA of a set of very large vectors (see, for example, the EigenFaces technique for
       face recognition). Eigenvalues of this "scrambled" matrix match the eigenvalues of the true
       covariance matrix. The "true" eigenvectors can be easily calculated from the eigenvectors of
       the "scrambled" covariance matrix. */
    COVAR_SCRAMBLED = 0,
    /**The output covariance matrix is calculated as:
        \f[\texttt{scale}   \cdot  [  \texttt{vects}  [0]-  \texttt{mean}  , \texttt{vects}  [1]-  \texttt{mean}  ,...]  \cdot  [ \texttt{vects}  [0]- \texttt{mean}  , \texttt{vects}  [1]- \texttt{mean}  ,...]^T,\f]
        covar will be a square matrix of the same size as the total number of elements in each input
        vector. One and only one of #COVAR_SCRAMBLED and #COVAR_NORMAL must be specified.*/
    COVAR_NORMAL = 1,
    /** If the flag is specified, the function does not calculate mean from
        the input vectors but, instead, uses the passed mean vector. This is useful if mean has been
        pre-calculated or known in advance, or if the covariance matrix is calculated by parts. In
        this case, mean is not a mean vector of the input sub-set of vectors but rather the mean
        vector of the whole set.*/
    COVAR_USE_AVG = 2,
    /** If the flag is specified, the covariance matrix is scaled. In the
        "normal" mode, scale is 1./nsamples . In the "scrambled" mode, scale is the reciprocal of the
        total number of elements in each input vector. By default (if the flag is not specified), the
        covariance matrix is not scaled ( scale=1 ).*/
    COVAR_SCALE = 4,
    /** If the flag is
        specified, all the input vectors are stored as rows of the samples matrix. mean should be a
        single-row vector in this case.*/
    COVAR_ROWS = 8,
    /** If the flag is
        specified, all the input vectors are stored as columns of the samples matrix. mean should be a
        single-column vector in this case.*/
    COVAR_COLS = 16
};

//! @addtogroup core_cluster
//!  @{

//! k-Means flags
enum
{
    /** Select random initial centers in each attempt.*/
    KMEANS_RANDOM_CENTERS = 0,
    /** Use kmeans++ center initialization by Arthur and Vassilvitskii [Arthur2007].*/
    KMEANS_PP_CENTERS = 2,
    /** During the first (and possibly the only) attempt, use the
        user-supplied labels instead of computing them from the initial centers. For the second and
        further attempts, use the random or semi-random centers. Use one of KMEANS_\*_CENTERS flag
        to specify the exact method.*/
    KMEANS_USE_INITIAL_LABELS = 1
};

//! @} core_cluster

//! @addtogroup core_array
//! @{

enum
{
    REDUCE_SUM = 0, //!< the output is the sum of all rows/columns of the matrix.
    REDUCE_AVG = 1, //!< the output is the mean vector of all rows/columns of the matrix.
    REDUCE_MAX = 2, //!< the output is the maximum (column/row-wise) of all rows/columns of the matrix.
    REDUCE_MIN = 3, //!< the output is the minimum (column/row-wise) of all rows/columns of the matrix.
    REDUCE_SUM2 = 4 //!< the output is the sum of all squared rows/columns of the matrix.
};
enum
{
    ROTATE_90_CLOCKWISE = 0,        //!< Rotate 90 degrees clockwise
    ROTATE_180 = 1,                 //!< Rotate 180 degrees clockwise
    ROTATE_90_COUNTERCLOCKWISE = 2, //!< Rotate 270 degrees clockwise
};
enum
{
    TERM_COUNT = 1,
    TERM_MAX_ITER = TERM_COUNT,
    TERM_EPS = 2
};

enum
{
    RNG_DIST_UNIFORM = 0,
    RNG_DIST_NORMAL = 1
};

//! @addtogroup video_track
//! @{
/*
    cv::OPTFLOW_USE_INITIAL_FLOW = 4,
    cv::OPTFLOW_LK_GET_MIN_EIGENVALS = 8,
    cv::OPTFLOW_FARNEBACK_GAUSSIAN = 256
    For further details, please see: https://docs.opencv.org/master/dc/d6b/group__video__track.html#gga2c6cc144c9eee043575d5b311ac8af08a9d4430ac75199af0cf6fcdefba30eafe
*/
enum
{
    OPTFLOW_USE_INITIAL_FLOW = 4,
    OPTFLOW_LK_GET_MIN_EIGENVALS = 8,
    OPTFLOW_FARNEBACK_GAUSSIAN = 256
};

/*
    cv::MOTION_TRANSLATION = 0,
    cv::MOTION_EUCLIDEAN = 1,
    cv::MOTION_AFFINE = 2,
    cv::MOTION_HOMOGRAPHY = 3
    For further details, please see: https://docs.opencv.org/4.x/dc/d6b/group__video__track.html#ggaaedb1f94e6b143cef163622c531afd88a01106d6d20122b782ff25eaeffe9a5be
*/
enum
{
    MOTION_TRANSLATION = 0,
    MOTION_EUCLIDEAN = 1,
    MOTION_AFFINE = 2,
    MOTION_HOMOGRAPHY = 3
};

/** @brief cv::VideoCapture API backends identifier.

Select preferred API for a capture object.
To be used in the VideoCapture::VideoCapture() constructor or VideoCapture::open()

@note
-   Backends are available only if they have been built with your OpenCV binaries.
See @ref videoio_overview for more information.
-   Microsoft Media Foundation backend tries to use hardware accelerated transformations
if possible. Environment flag "OPENCV_VIDEOIO_MSMF_ENABLE_HW_TRANSFORMS" set to 0
disables it and may improve initialization time. More details:
https://learn.microsoft.com/en-us/windows/win32/medfound/mf-readwrite-enable-hardware-transforms
*/
enum
{
    CAP_ANY = 0,                 //!< Auto detect == 0
    CAP_VFW = 200,               //!< Video For Windows (obsolete, removed)
    CAP_V4L = 200,               //!< V4L/V4L2 capturing support
    CAP_V4L2 = CAP_V4L,          //!< Same as CAP_V4L
    CAP_FIREWIRE = 300,          //!< IEEE 1394 drivers
    CAP_FIREWARE = CAP_FIREWIRE, //!< Same value as CAP_FIREWIRE
    CAP_IEEE1394 = CAP_FIREWIRE, //!< Same value as CAP_FIREWIRE
    CAP_DC1394 = CAP_FIREWIRE,   //!< Same value as CAP_FIREWIRE
    CAP_CMU1394 = CAP_FIREWIRE,  //!< Same value as CAP_FIREWIRE
    CAP_QT = 500,                //!< QuickTime (obsolete, removed)
    CAP_UNICAP = 600,            //!< Unicap drivers (obsolete, removed)
    CAP_DSHOW = 700,             //!< DirectShow (via videoInput)
    CAP_PVAPI = 800,             //!< PvAPI, Prosilica GigE SDK
    CAP_OPENNI = 900,            //!< OpenNI (for Kinect)
    CAP_OPENNI_ASUS = 910,       //!< OpenNI (for Asus Xtion)
    CAP_ANDROID = 1000,          //!< MediaNDK (API Level 21+) and NDK Camera (API level 24+) for Android
    CAP_XIAPI = 1100,            //!< XIMEA Camera API
    CAP_AVFOUNDATION = 1200,     //!< AVFoundation framework for iOS (OS X Lion will have the same API)
    CAP_GIGANETIX = 1300,        //!< Smartek Giganetix GigEVisionSDK
    CAP_MSMF = 1400,             //!< Microsoft Media Foundation (via videoInput). See platform specific notes above.
    CAP_WINRT = 1410,            //!< Microsoft Windows Runtime using Media Foundation
    CAP_INTELPERC = 1500,        //!< RealSense (former Intel Perceptual Computing SDK)
    CAP_REALSENSE = 1500,        //!< Synonym for CAP_INTELPERC
    CAP_OPENNI2 = 1600,          //!< OpenNI2 (for Kinect)
    CAP_OPENNI2_ASUS = 1610,     //!< OpenNI2 (for Asus Xtion and Occipital Structure sensors)
    CAP_OPENNI2_ASTRA = 1620,    //!< OpenNI2 (for Orbbec Astra)
    CAP_GPHOTO2 = 1700,          //!< gPhoto2 connection
    CAP_GSTREAMER = 1800,        //!< GStreamer
    CAP_FFMPEG = 1900,           //!< Open and record video file or stream using the FFMPEG library
    CAP_IMAGES = 2000,           //!< OpenCV Image Sequence (e.g. img_%02d.jpg)
    CAP_ARAVIS = 2100,           //!< Aravis SDK
    CAP_OPENCV_MJPEG = 2200,     //!< Built-in OpenCV MotionJPEG codec
    CAP_INTEL_MFX = 2300,        //!< Intel MediaSDK
    CAP_XINE = 2400,             //!< XINE engine (Linux)
    CAP_UEYE = 2500,             //!< uEye Camera API
    CAP_OBSENSOR = 2600,         //!< For Orbbec 3D-Sensor device/module (Astra+, Femto, Astra2, Gemini2, Gemini2L, Gemini2XL, Femto Mega) attention: Astra2, Gemini2, and Gemini2L cameras currently only support Windows and Linux kernel versions no higher than 4.15, and higher versions of Linux kernel may have exceptions.
};

/** @brief cv::VideoCapture generic properties identifier.

 Reading / writing properties involves many layers. Some unexpected result might happens along this chain.
 Effective behaviour depends from device hardware, driver and API Backend.
 @sa videoio_flags_others, VideoCapture::get(), VideoCapture::set()
*/
enum
{
    CAP_PROP_POS_MSEC = 0,      //!< Current position of the video file in milliseconds.
    CAP_PROP_POS_FRAMES = 1,    //!< 0-based index of the frame to be decoded/captured next. When the index i is set in RAW mode (CAP_PROP_FORMAT == -1) this will seek to the key frame k, where k <= i.
    CAP_PROP_POS_AVI_RATIO = 2, //!< Relative position of the video file: 0=start of the film, 1=end of the film.
    CAP_PROP_FRAME_WIDTH = 3,   //!< Width of the frames in the video stream.
    CAP_PROP_FRAME_HEIGHT = 4,  //!< Height of the frames in the video stream.
    CAP_PROP_FPS = 5,           //!< Frame rate.
    CAP_PROP_FOURCC = 6,        //!< 4-character code of codec. see VideoWriter::fourcc .
    CAP_PROP_FRAME_COUNT = 7,   //!< Number of frames in the video file.
    CAP_PROP_FORMAT = 8,        //!< Format of the %Mat objects (see Mat::type()) returned by VideoCapture::retrieve().
    //!< Set value -1 to fetch undecoded RAW video streams (as Mat 8UC1).
    CAP_PROP_MODE = 9,         //!< Backend-specific value indicating the current capture mode.
    CAP_PROP_BRIGHTNESS = 10,  //!< Brightness of the image (only for those cameras that support).
    CAP_PROP_CONTRAST = 11,    //!< Contrast of the image (only for cameras).
    CAP_PROP_SATURATION = 12,  //!< Saturation of the image (only for cameras).
    CAP_PROP_HUE = 13,         //!< Hue of the image (only for cameras).
    CAP_PROP_GAIN = 14,        //!< Gain of the image (only for those cameras that support).
    CAP_PROP_EXPOSURE = 15,    //!< Exposure (only for those cameras that support).
    CAP_PROP_CONVERT_RGB = 16, //!< Boolean flags indicating whether images should be converted to RGB. <br/>
    //!< *GStreamer note*: The flag is ignored in case if custom pipeline is used. It's user responsibility to interpret pipeline output.
    CAP_PROP_WHITE_BALANCE_BLUE_U = 17, //!< Currently unsupported.
    CAP_PROP_RECTIFICATION = 18,        //!< Rectification flag for stereo cameras (note: only supported by DC1394 v 2.x backend currently).
    CAP_PROP_MONOCHROME = 19,
    CAP_PROP_SHARPNESS = 20,
    CAP_PROP_AUTO_EXPOSURE = 21, //!< DC1394: exposure control done by camera, user can adjust reference level using this feature.
    CAP_PROP_GAMMA = 22,
    CAP_PROP_TEMPERATURE = 23,
    CAP_PROP_TRIGGER = 24,
    CAP_PROP_TRIGGER_DELAY = 25,
    CAP_PROP_WHITE_BALANCE_RED_V = 26,
    CAP_PROP_ZOOM = 27,
    CAP_PROP_FOCUS = 28,
    CAP_PROP_GUID = 29,
    CAP_PROP_ISO_SPEED = 30,
    CAP_PROP_BACKLIGHT = 32,
    CAP_PROP_PAN = 33,
    CAP_PROP_TILT = 34,
    CAP_PROP_ROLL = 35,
    CAP_PROP_IRIS = 36,
    CAP_PROP_SETTINGS = 37, //!< Pop up video/camera filter dialog (note: only supported by DSHOW backend currently. The property value is ignored)
    CAP_PROP_BUFFERSIZE = 38,
    CAP_PROP_AUTOFOCUS = 39,
    CAP_PROP_SAR_NUM = 40,                    //!< Sample aspect ratio: num/den (num)
    CAP_PROP_SAR_DEN = 41,                    //!< Sample aspect ratio: num/den (den)
    CAP_PROP_BACKEND = 42,                    //!< Current backend (enum VideoCaptureAPIs). Read-only property
    CAP_PROP_CHANNEL = 43,                    //!< Video input or Channel Number (only for those cameras that support)
    CAP_PROP_AUTO_WB = 44,                    //!< enable/ disable auto white-balance
    CAP_PROP_WB_TEMPERATURE = 45,             //!< white-balance color temperature
    CAP_PROP_CODEC_PIXEL_FORMAT = 46,         //!< (read-only) codec's pixel format. 4-character code - see VideoWriter::fourcc . Subset of [AV_PIX_FMT_*](https://github.com/FFmpeg/FFmpeg/blob/master/libavcodec/raw.c) or -1 if unknown
    CAP_PROP_BITRATE = 47,                    //!< (read-only) Video bitrate in kbits/s
    CAP_PROP_ORIENTATION_META = 48,           //!< (read-only) Frame rotation defined by stream meta (applicable for FFmpeg and AVFoundation back-ends only)
    CAP_PROP_ORIENTATION_AUTO = 49,           //!< if true - rotates output frames of CvCapture considering video file's metadata  (applicable for FFmpeg and AVFoundation back-ends only) (https://github.com/opencv/opencv/issues/15499)
    CAP_PROP_HW_ACCELERATION = 50,            //!< (**open-only**) Hardware acceleration type (see #VideoAccelerationType). Setting supported only via `params` parameter in cv::VideoCapture constructor / .open() method. Default value is backend-specific.
    CAP_PROP_HW_DEVICE = 51,                  //!< (**open-only**) Hardware device index (select GPU if multiple available). Device enumeration is acceleration type specific.
    CAP_PROP_HW_ACCELERATION_USE_OPENCL = 52, //!< (**open-only**) If non-zero, create new OpenCL context and bind it to current thread. The OpenCL context created with Video Acceleration context attached it (if not attached yet) for optimized GPU data copy between HW accelerated decoder and cv::UMat.
    CAP_PROP_OPEN_TIMEOUT_MSEC = 53,          //!< (**open-only**) timeout in milliseconds for opening a video capture (applicable for FFmpeg and GStreamer back-ends only)
    CAP_PROP_READ_TIMEOUT_MSEC = 54,          //!< (**open-only**) timeout in milliseconds for reading from a video capture (applicable for FFmpeg and GStreamer back-ends only)
    CAP_PROP_STREAM_OPEN_TIME_USEC = 55,      //!< (read-only) time in microseconds since Jan 1 1970 when stream was opened. Applicable for FFmpeg backend only. Useful for RTSP and other live streams
    CAP_PROP_VIDEO_TOTAL_CHANNELS = 56,       //!< (read-only) Number of video channels
    CAP_PROP_VIDEO_STREAM = 57,               //!< (**open-only**) Specify video stream, 0-based index. Use -1 to disable video stream from file or IP cameras. Default value is 0.
    CAP_PROP_AUDIO_STREAM = 58,               //!< (**open-only**) Specify stream in multi-language media files, -1 - disable audio processing or microphone. Default value is -1.
    CAP_PROP_AUDIO_POS = 59,                  //!< (read-only) Audio position is measured in samples. Accurate audio sample timestamp of previous grabbed fragment. See CAP_PROP_AUDIO_SAMPLES_PER_SECOND and CAP_PROP_AUDIO_SHIFT_NSEC.
    CAP_PROP_AUDIO_SHIFT_NSEC = 60,           //!< (read only) Contains the time difference between the start of the audio stream and the video stream in nanoseconds. Positive value means that audio is started after the first video frame. Negative value means that audio is started before the first video frame.
    CAP_PROP_AUDIO_DATA_DEPTH = 61,           //!< (open, read) Alternative definition to bits-per-sample, but with clear handling of 32F / 32S
    CAP_PROP_AUDIO_SAMPLES_PER_SECOND = 62,   //!< (open, read) determined from file/codec input. If not specified, then selected audio sample rate is 44100
    CAP_PROP_AUDIO_BASE_INDEX = 63,           //!< (read-only) Index of the first audio channel for .retrieve() calls. That audio channel number continues enumeration after video channels.
    CAP_PROP_AUDIO_TOTAL_CHANNELS = 64,       //!< (read-only) Number of audio channels in the selected audio stream (mono, stereo, etc)
    CAP_PROP_AUDIO_TOTAL_STREAMS = 65,        //!< (read-only) Number of audio streams.
    CAP_PROP_AUDIO_SYNCHRONIZE = 66,          //!< (open, read) Enables audio synchronization.
    CAP_PROP_LRF_HAS_KEY_FRAME = 67,          //!< FFmpeg back-end only - Indicates whether the Last Raw Frame (LRF), output from VideoCapture::read() when VideoCapture is initialized with VideoCapture::open(CAP_FFMPEG, {CAP_PROP_FORMAT, -1}) or VideoCapture::set(CAP_PROP_FORMAT,-1) is called before the first call to VideoCapture::read(), contains encoded data for a key frame.
    CAP_PROP_CODEC_EXTRADATA_INDEX = 68,      //!< Positive index indicates that returning extra data is supported by the video back end.  This can be retrieved as cap.retrieve(data, <returned index>).  E.g. When reading from a h264 encoded RTSP stream, the FFmpeg backend could return the SPS and/or PPS if available (if sent in reply to a DESCRIBE request), from calls to cap.retrieve(data, <returned index>).
    CAP_PROP_FRAME_TYPE = 69,                 //!< (read-only) FFmpeg back-end only - Frame type ascii code (73 = 'I', 80 = 'P', 66 = 'B' or 63 = '?' if unknown) of the most recently read frame.
    CAP_PROP_N_THREADS = 70,                  //!< (**open-only**) Set the maximum number of threads to use. Use 0 to use as many threads as CPU cores (applicable for FFmpeg back-end only).
#ifndef CV_DOXYGEN
    CV__CAP_PROP_LATEST
#endif
};

/** @brief cv::VideoWriter generic properties identifier.
 @sa VideoWriter::get(), VideoWriter::set()
*/
enum
{
    VIDEOWRITER_PROP_QUALITY = 1,    //!< Current quality (0..100%) of the encoded videostream. Can be adjusted dynamically in some codecs.
    VIDEOWRITER_PROP_FRAMEBYTES = 2, //!< (Read-only): Size of just encoded video frame. Note that the encoding order may be different from representation order.
    VIDEOWRITER_PROP_NSTRIPES = 3,   //!< Number of stripes for parallel encoding. -1 for auto detection.
    VIDEOWRITER_PROP_IS_COLOR = 4,   //!< If it is not zero, the encoder will expect and encode color frames, otherwise it
    //!< will work with grayscale frames.
    VIDEOWRITER_PROP_DEPTH = 5,                      //!< Defaults to \ref CV_8U.
    VIDEOWRITER_PROP_HW_ACCELERATION = 6,            //!< (**open-only**) Hardware acceleration type (see #VideoAccelerationType). Setting supported only via `params` parameter in VideoWriter constructor / .open() method. Default value is backend-specific.
    VIDEOWRITER_PROP_HW_DEVICE = 7,                  //!< (**open-only**) Hardware device index (select GPU if multiple available). Device enumeration is acceleration type specific.
    VIDEOWRITER_PROP_HW_ACCELERATION_USE_OPENCL = 8, //!< (**open-only**) If non-zero, create new OpenCL context and bind it to current thread. The OpenCL context created with Video Acceleration context attached it (if not attached yet) for optimized GPU data copy between cv::UMat and HW accelerated encoder.
    VIDEOWRITER_PROP_RAW_VIDEO = 9,                  //!< (**open-only**) Set to non-zero to enable encapsulation of an encoded raw video stream. Each raw encoded video frame should be passed to VideoWriter::write() as single row or column of a \ref CV_8UC1 Mat. \note If the key frame interval is not 1 then it must be manually specified by the user. This can either be performed during initialization passing \ref VIDEOWRITER_PROP_KEY_INTERVAL as one of the extra encoder params  to \ref VideoWriter::VideoWriter(const String &, int, double, const Size &, const std::vector< int > &params) or afterwards by setting the \ref VIDEOWRITER_PROP_KEY_FLAG with \ref VideoWriter::set() before writing each frame. FFMpeg backend only.
    VIDEOWRITER_PROP_KEY_INTERVAL = 10,              //!< (**open-only**) Set the key frame interval using raw video encapsulation (\ref VIDEOWRITER_PROP_RAW_VIDEO != 0). Defaults to 1 when not set. FFMpeg backend only.
    VIDEOWRITER_PROP_KEY_FLAG = 11,                  //!< Set to non-zero to signal that the following frames are key frames or zero if not, when encapsulating raw video (\ref VIDEOWRITER_PROP_RAW_VIDEO != 0). FFMpeg backend only.
#ifndef CV_DOXYGEN
    CV__VIDEOWRITER_PROP_LATEST
#endif
};

//! @} videoio_flags_base

//! @addtogroup videoio_flags_others
//! @{

/** @name Hardware acceleration support
    @{
*/

/** @brief Video Acceleration type
 *
 * Used as value in #CAP_PROP_HW_ACCELERATION and #VIDEOWRITER_PROP_HW_ACCELERATION
 *
 * @note In case of FFmpeg backend, it translated to enum AVHWDeviceType (https://github.com/FFmpeg/FFmpeg/blob/master/libavutil/hwcontext.h)
 */
enum VideoAccelerationType
{
    VIDEO_ACCELERATION_NONE = 0, //!< Do not require any specific H/W acceleration, prefer software processing.
    //!< Reading of this value means that special H/W accelerated handling is not added or not detected by OpenCV.

    VIDEO_ACCELERATION_ANY = 1, //!< Prefer to use H/W acceleration. If no one supported, then fallback to software processing.
    //!< @note H/W acceleration may require special configuration of used environment.
    //!< @note Results in encoding scenario may differ between software and hardware accelerated encoders.

    VIDEO_ACCELERATION_D3D11 = 2, //!< DirectX 11
    VIDEO_ACCELERATION_VAAPI = 3, //!< VAAPI
    VIDEO_ACCELERATION_MFX = 4,   //!< libmfx (Intel MediaSDK/oneVPL)
};

//! @} Hardware acceleration support

/** @name IEEE 1394 drivers
    @{
*/

/** @brief Modes of the IEEE 1394 controlling registers
(can be: auto, manual, auto single push, absolute Latter allowed with any other mode)
every feature can have only one mode turned on at a time
*/
enum
{
    CAP_PROP_DC1394_OFF = -4,         //!< turn the feature off (not controlled manually nor automatically).
    CAP_PROP_DC1394_MODE_MANUAL = -3, //!< set automatically when a value of the feature is set by the user.
    CAP_PROP_DC1394_MODE_AUTO = -2,
    CAP_PROP_DC1394_MODE_ONE_PUSH_AUTO = -1,
    CAP_PROP_DC1394_MAX = 31
};

//! @} IEEE 1394 drivers

/** @name OpenNI (for Kinect)
    @{
*/

//! OpenNI map generators
enum
{
    CAP_OPENNI_DEPTH_GENERATOR = 1 << 31,
    CAP_OPENNI_IMAGE_GENERATOR = 1 << 30,
    CAP_OPENNI_IR_GENERATOR = 1 << 29,
    CAP_OPENNI_GENERATORS_MASK = CAP_OPENNI_DEPTH_GENERATOR + CAP_OPENNI_IMAGE_GENERATOR + CAP_OPENNI_IR_GENERATOR
};

//! Properties of cameras available through OpenNI backend
enum
{
    CAP_PROP_OPENNI_OUTPUT_MODE = 100,
    CAP_PROP_OPENNI_FRAME_MAX_DEPTH = 101, //!< In mm
    CAP_PROP_OPENNI_BASELINE = 102,        //!< In mm
    CAP_PROP_OPENNI_FOCAL_LENGTH = 103,    //!< In pixels
    CAP_PROP_OPENNI_REGISTRATION = 104,    //!< Flag that synchronizes the remapping depth map to image map
    //!< by changing depth generator's view point (if the flag is "on") or
    //!< sets this view point to its normal one (if the flag is "off").
    CAP_PROP_OPENNI_REGISTRATION_ON = CAP_PROP_OPENNI_REGISTRATION,
    CAP_PROP_OPENNI_APPROX_FRAME_SYNC = 105,
    CAP_PROP_OPENNI_MAX_BUFFER_SIZE = 106,
    CAP_PROP_OPENNI_CIRCLE_BUFFER = 107,
    CAP_PROP_OPENNI_MAX_TIME_DURATION = 108,
    CAP_PROP_OPENNI_GENERATOR_PRESENT = 109,
    CAP_PROP_OPENNI2_SYNC = 110,
    CAP_PROP_OPENNI2_MIRROR = 111
};

#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 5054)
#endif
//! OpenNI shortcuts
enum
{
    CAP_OPENNI_IMAGE_GENERATOR_PRESENT = CAP_OPENNI_IMAGE_GENERATOR + CAP_PROP_OPENNI_GENERATOR_PRESENT,
    CAP_OPENNI_IMAGE_GENERATOR_OUTPUT_MODE = CAP_OPENNI_IMAGE_GENERATOR + CAP_PROP_OPENNI_OUTPUT_MODE,
    CAP_OPENNI_DEPTH_GENERATOR_PRESENT = CAP_OPENNI_DEPTH_GENERATOR + CAP_PROP_OPENNI_GENERATOR_PRESENT,
    CAP_OPENNI_DEPTH_GENERATOR_BASELINE = CAP_OPENNI_DEPTH_GENERATOR + CAP_PROP_OPENNI_BASELINE,
    CAP_OPENNI_DEPTH_GENERATOR_FOCAL_LENGTH = CAP_OPENNI_DEPTH_GENERATOR + CAP_PROP_OPENNI_FOCAL_LENGTH,
    CAP_OPENNI_DEPTH_GENERATOR_REGISTRATION = CAP_OPENNI_DEPTH_GENERATOR + CAP_PROP_OPENNI_REGISTRATION,
    CAP_OPENNI_DEPTH_GENERATOR_REGISTRATION_ON = CAP_OPENNI_DEPTH_GENERATOR_REGISTRATION,
    CAP_OPENNI_IR_GENERATOR_PRESENT = CAP_OPENNI_IR_GENERATOR + CAP_PROP_OPENNI_GENERATOR_PRESENT,
};
#ifdef _MSC_VER
#pragma warning(pop)
#endif

//! OpenNI data given from depth generator
enum
{
    CAP_OPENNI_DEPTH_MAP = 0,         //!< Depth values in mm (CV_16UC1)
    CAP_OPENNI_POINT_CLOUD_MAP = 1,   //!< XYZ in meters (CV_32FC3)
    CAP_OPENNI_DISPARITY_MAP = 2,     //!< Disparity in pixels (CV_8UC1)
    CAP_OPENNI_DISPARITY_MAP_32F = 3, //!< Disparity in pixels (CV_32FC1)
    CAP_OPENNI_VALID_DEPTH_MASK = 4,  //!< CV_8UC1

    CAP_OPENNI_BGR_IMAGE = 5,  //!< Data given from RGB image generator
    CAP_OPENNI_GRAY_IMAGE = 6, //!< Data given from RGB image generator

    CAP_OPENNI_IR_IMAGE = 7 //!< Data given from IR image generator
};

//! Supported output modes of OpenNI image generator
enum
{
    CAP_OPENNI_VGA_30HZ = 0,
    CAP_OPENNI_SXGA_15HZ = 1,
    CAP_OPENNI_SXGA_30HZ = 2,
    CAP_OPENNI_QVGA_30HZ = 3,
    CAP_OPENNI_QVGA_60HZ = 4
};

//! @} OpenNI

/** @name GStreamer
    @{
*/

enum
{
    CAP_PROP_GSTREAMER_QUEUE_LENGTH = 200 //!< Default is 1
};

//! @} GStreamer

/** @name PvAPI, Prosilica GigE SDK
    @{
*/

//! PVAPI
enum
{
    CAP_PROP_PVAPI_MULTICASTIP = 300,           //!< IP for enable multicast master mode. 0 for disable multicast.
    CAP_PROP_PVAPI_FRAMESTARTTRIGGERMODE = 301, //!< FrameStartTriggerMode: Determines how a frame is initiated.
    CAP_PROP_PVAPI_DECIMATIONHORIZONTAL = 302,  //!< Horizontal sub-sampling of the image.
    CAP_PROP_PVAPI_DECIMATIONVERTICAL = 303,    //!< Vertical sub-sampling of the image.
    CAP_PROP_PVAPI_BINNINGX = 304,              //!< Horizontal binning factor.
    CAP_PROP_PVAPI_BINNINGY = 305,              //!< Vertical binning factor.
    CAP_PROP_PVAPI_PIXELFORMAT = 306            //!< Pixel format.
};

//! PVAPI: FrameStartTriggerMode
enum
{
    CAP_PVAPI_FSTRIGMODE_FREERUN = 0,   //!< Freerun
    CAP_PVAPI_FSTRIGMODE_SYNCIN1 = 1,   //!< SyncIn1
    CAP_PVAPI_FSTRIGMODE_SYNCIN2 = 2,   //!< SyncIn2
    CAP_PVAPI_FSTRIGMODE_FIXEDRATE = 3, //!< FixedRate
    CAP_PVAPI_FSTRIGMODE_SOFTWARE = 4   //!< Software
};

//! PVAPI: DecimationHorizontal, DecimationVertical
enum
{
    CAP_PVAPI_DECIMATION_OFF = 1,     //!< Off
    CAP_PVAPI_DECIMATION_2OUTOF4 = 2, //!< 2 out of 4 decimation
    CAP_PVAPI_DECIMATION_2OUTOF8 = 4, //!< 2 out of 8 decimation
    CAP_PVAPI_DECIMATION_2OUTOF16 = 8 //!< 2 out of 16 decimation
};

//! PVAPI: PixelFormat
enum
{
    CAP_PVAPI_PIXELFORMAT_MONO8 = 1,   //!< Mono8
    CAP_PVAPI_PIXELFORMAT_MONO16 = 2,  //!< Mono16
    CAP_PVAPI_PIXELFORMAT_BAYER8 = 3,  //!< Bayer8
    CAP_PVAPI_PIXELFORMAT_BAYER16 = 4, //!< Bayer16
    CAP_PVAPI_PIXELFORMAT_RGB24 = 5,   //!< Rgb24
    CAP_PVAPI_PIXELFORMAT_BGR24 = 6,   //!< Bgr24
    CAP_PVAPI_PIXELFORMAT_RGBA32 = 7,  //!< Rgba32
    CAP_PVAPI_PIXELFORMAT_BGRA32 = 8,  //!< Bgra32
};

//! @} PvAPI

/** @name XIMEA Camera API
    @{
*/

//! Properties of cameras available through XIMEA SDK backend
enum
{
    CAP_PROP_XI_DOWNSAMPLING = 400,                    //!< Change image resolution by binning or skipping.
    CAP_PROP_XI_DATA_FORMAT = 401,                     //!< Output data format.
    CAP_PROP_XI_OFFSET_X = 402,                        //!< Horizontal offset from the origin to the area of interest (in pixels).
    CAP_PROP_XI_OFFSET_Y = 403,                        //!< Vertical offset from the origin to the area of interest (in pixels).
    CAP_PROP_XI_TRG_SOURCE = 404,                      //!< Defines source of trigger.
    CAP_PROP_XI_TRG_SOFTWARE = 405,                    //!< Generates an internal trigger. PRM_TRG_SOURCE must be set to TRG_SOFTWARE.
    CAP_PROP_XI_GPI_SELECTOR = 406,                    //!< Selects general purpose input.
    CAP_PROP_XI_GPI_MODE = 407,                        //!< Set general purpose input mode.
    CAP_PROP_XI_GPI_LEVEL = 408,                       //!< Get general purpose level.
    CAP_PROP_XI_GPO_SELECTOR = 409,                    //!< Selects general purpose output.
    CAP_PROP_XI_GPO_MODE = 410,                        //!< Set general purpose output mode.
    CAP_PROP_XI_LED_SELECTOR = 411,                    //!< Selects camera signalling LED.
    CAP_PROP_XI_LED_MODE = 412,                        //!< Define camera signalling LED functionality.
    CAP_PROP_XI_MANUAL_WB = 413,                       //!< Calculates White Balance(must be called during acquisition).
    CAP_PROP_XI_AUTO_WB = 414,                         //!< Automatic white balance.
    CAP_PROP_XI_AEAG = 415,                            //!< Automatic exposure/gain.
    CAP_PROP_XI_EXP_PRIORITY = 416,                    //!< Exposure priority (0.5 - exposure 50%, gain 50%).
    CAP_PROP_XI_AE_MAX_LIMIT = 417,                    //!< Maximum limit of exposure in AEAG procedure.
    CAP_PROP_XI_AG_MAX_LIMIT = 418,                    //!< Maximum limit of gain in AEAG procedure.
    CAP_PROP_XI_AEAG_LEVEL = 419,                      //!< Average intensity of output signal AEAG should achieve(in %).
    CAP_PROP_XI_TIMEOUT = 420,                         //!< Image capture timeout in milliseconds.
    CAP_PROP_XI_EXPOSURE = 421,                        //!< Exposure time in microseconds.
    CAP_PROP_XI_EXPOSURE_BURST_COUNT = 422,            //!< Sets the number of times of exposure in one frame.
    CAP_PROP_XI_GAIN_SELECTOR = 423,                   //!< Gain selector for parameter Gain allows to select different type of gains.
    CAP_PROP_XI_GAIN = 424,                            //!< Gain in dB.
    CAP_PROP_XI_DOWNSAMPLING_TYPE = 426,               //!< Change image downsampling type.
    CAP_PROP_XI_BINNING_SELECTOR = 427,                //!< Binning engine selector.
    CAP_PROP_XI_BINNING_VERTICAL = 428,                //!< Vertical Binning - number of vertical photo-sensitive cells to combine together.
    CAP_PROP_XI_BINNING_HORIZONTAL = 429,              //!< Horizontal Binning - number of horizontal photo-sensitive cells to combine together.
    CAP_PROP_XI_BINNING_PATTERN = 430,                 //!< Binning pattern type.
    CAP_PROP_XI_DECIMATION_SELECTOR = 431,             //!< Decimation engine selector.
    CAP_PROP_XI_DECIMATION_VERTICAL = 432,             //!< Vertical Decimation - vertical sub-sampling of the image - reduces the vertical resolution of the image by the specified vertical decimation factor.
    CAP_PROP_XI_DECIMATION_HORIZONTAL = 433,           //!< Horizontal Decimation - horizontal sub-sampling of the image - reduces the horizontal resolution of the image by the specified vertical decimation factor.
    CAP_PROP_XI_DECIMATION_PATTERN = 434,              //!< Decimation pattern type.
    CAP_PROP_XI_TEST_PATTERN_GENERATOR_SELECTOR = 587, //!< Selects which test pattern generator is controlled by the TestPattern feature.
    CAP_PROP_XI_TEST_PATTERN = 588,                    //!< Selects which test pattern type is generated by the selected generator.
    CAP_PROP_XI_IMAGE_DATA_FORMAT = 435,               //!< Output data format.
    CAP_PROP_XI_SHUTTER_TYPE = 436,                    //!< Change sensor shutter type(CMOS sensor).
    CAP_PROP_XI_SENSOR_TAPS = 437,                     //!< Number of taps.
    CAP_PROP_XI_AEAG_ROI_OFFSET_X = 439,               //!< Automatic exposure/gain ROI offset X.
    CAP_PROP_XI_AEAG_ROI_OFFSET_Y = 440,               //!< Automatic exposure/gain ROI offset Y.
    CAP_PROP_XI_AEAG_ROI_WIDTH = 441,                  //!< Automatic exposure/gain ROI Width.
    CAP_PROP_XI_AEAG_ROI_HEIGHT = 442,                 //!< Automatic exposure/gain ROI Height.
    CAP_PROP_XI_BPC = 445,                             //!< Correction of bad pixels.
    CAP_PROP_XI_WB_KR = 448,                           //!< White balance red coefficient.
    CAP_PROP_XI_WB_KG = 449,                           //!< White balance green coefficient.
    CAP_PROP_XI_WB_KB = 450,                           //!< White balance blue coefficient.
    CAP_PROP_XI_WIDTH = 451,                           //!< Width of the Image provided by the device (in pixels).
    CAP_PROP_XI_HEIGHT = 452,                          //!< Height of the Image provided by the device (in pixels).
    CAP_PROP_XI_REGION_SELECTOR = 589,                 //!< Selects Region in Multiple ROI which parameters are set by width, height, ... ,region mode.
    CAP_PROP_XI_REGION_MODE = 595,                     //!< Activates/deactivates Region selected by Region Selector.
    CAP_PROP_XI_LIMIT_BANDWIDTH = 459,                 //!< Set/get bandwidth(datarate)(in Megabits).
    CAP_PROP_XI_SENSOR_DATA_BIT_DEPTH = 460,           //!< Sensor output data bit depth.
    CAP_PROP_XI_OUTPUT_DATA_BIT_DEPTH = 461,           //!< Device output data bit depth.
    CAP_PROP_XI_IMAGE_DATA_BIT_DEPTH = 462,            //!< bitdepth of data returned by function xiGetImage.
    CAP_PROP_XI_OUTPUT_DATA_PACKING = 463,             //!< Device output data packing (or grouping) enabled. Packing could be enabled if output_data_bit_depth > 8 and packing capability is available.
    CAP_PROP_XI_OUTPUT_DATA_PACKING_TYPE = 464,        //!< Data packing type. Some cameras supports only specific packing type.
    CAP_PROP_XI_IS_COOLED = 465,                       //!< Returns 1 for cameras that support cooling.
    CAP_PROP_XI_COOLING = 466,                         //!< Start camera cooling.
    CAP_PROP_XI_TARGET_TEMP = 467,                     //!< Set sensor target temperature for cooling.
    CAP_PROP_XI_CHIP_TEMP = 468,                       //!< Camera sensor temperature.
    CAP_PROP_XI_HOUS_TEMP = 469,                       //!< Camera housing temperature.
    CAP_PROP_XI_HOUS_BACK_SIDE_TEMP = 590,             //!< Camera housing back side temperature.
    CAP_PROP_XI_SENSOR_BOARD_TEMP = 596,               //!< Camera sensor board temperature.
    CAP_PROP_XI_CMS = 470,                             //!< Mode of color management system.
    CAP_PROP_XI_APPLY_CMS = 471,                       //!< Enable applying of CMS profiles to xiGetImage (see XI_PRM_INPUT_CMS_PROFILE, XI_PRM_OUTPUT_CMS_PROFILE).
    CAP_PROP_XI_IMAGE_IS_COLOR = 474,                  //!< Returns 1 for color cameras.
    CAP_PROP_XI_COLOR_FILTER_ARRAY = 475,              //!< Returns color filter array type of RAW data.
    CAP_PROP_XI_GAMMAY = 476,                          //!< Luminosity gamma.
    CAP_PROP_XI_GAMMAC = 477,                          //!< Chromaticity gamma.
    CAP_PROP_XI_SHARPNESS = 478,                       //!< Sharpness Strength.
    CAP_PROP_XI_CC_MATRIX_00 = 479,                    //!< Color Correction Matrix element [0][0].
    CAP_PROP_XI_CC_MATRIX_01 = 480,                    //!< Color Correction Matrix element [0][1].
    CAP_PROP_XI_CC_MATRIX_02 = 481,                    //!< Color Correction Matrix element [0][2].
    CAP_PROP_XI_CC_MATRIX_03 = 482,                    //!< Color Correction Matrix element [0][3].
    CAP_PROP_XI_CC_MATRIX_10 = 483,                    //!< Color Correction Matrix element [1][0].
    CAP_PROP_XI_CC_MATRIX_11 = 484,                    //!< Color Correction Matrix element [1][1].
    CAP_PROP_XI_CC_MATRIX_12 = 485,                    //!< Color Correction Matrix element [1][2].
    CAP_PROP_XI_CC_MATRIX_13 = 486,                    //!< Color Correction Matrix element [1][3].
    CAP_PROP_XI_CC_MATRIX_20 = 487,                    //!< Color Correction Matrix element [2][0].
    CAP_PROP_XI_CC_MATRIX_21 = 488,                    //!< Color Correction Matrix element [2][1].
    CAP_PROP_XI_CC_MATRIX_22 = 489,                    //!< Color Correction Matrix element [2][2].
    CAP_PROP_XI_CC_MATRIX_23 = 490,                    //!< Color Correction Matrix element [2][3].
    CAP_PROP_XI_CC_MATRIX_30 = 491,                    //!< Color Correction Matrix element [3][0].
    CAP_PROP_XI_CC_MATRIX_31 = 492,                    //!< Color Correction Matrix element [3][1].
    CAP_PROP_XI_CC_MATRIX_32 = 493,                    //!< Color Correction Matrix element [3][2].
    CAP_PROP_XI_CC_MATRIX_33 = 494,                    //!< Color Correction Matrix element [3][3].
    CAP_PROP_XI_DEFAULT_CC_MATRIX = 495,               //!< Set default Color Correction Matrix.
    CAP_PROP_XI_TRG_SELECTOR = 498,                    //!< Selects the type of trigger.
    CAP_PROP_XI_ACQ_FRAME_BURST_COUNT = 499,           //!< Sets number of frames acquired by burst. This burst is used only if trigger is set to FrameBurstStart.
    CAP_PROP_XI_DEBOUNCE_EN = 507,                     //!< Enable/Disable debounce to selected GPI.
    CAP_PROP_XI_DEBOUNCE_T0 = 508,                     //!< Debounce time (x * 10us).
    CAP_PROP_XI_DEBOUNCE_T1 = 509,                     //!< Debounce time (x * 10us).
    CAP_PROP_XI_DEBOUNCE_POL = 510,                    //!< Debounce polarity (pol = 1 t0 - falling edge, t1 - rising edge).
    CAP_PROP_XI_LENS_MODE = 511,                       //!< Status of lens control interface. This shall be set to XI_ON before any Lens operations.
    CAP_PROP_XI_LENS_APERTURE_VALUE = 512,             //!< Current lens aperture value in stops. Examples: 2.8, 4, 5.6, 8, 11.
    CAP_PROP_XI_LENS_FOCUS_MOVEMENT_VALUE = 513,       //!< Lens current focus movement value to be used by XI_PRM_LENS_FOCUS_MOVE in motor steps.
    CAP_PROP_XI_LENS_FOCUS_MOVE = 514,                 //!< Moves lens focus motor by steps set in XI_PRM_LENS_FOCUS_MOVEMENT_VALUE.
    CAP_PROP_XI_LENS_FOCUS_DISTANCE = 515,             //!< Lens focus distance in cm.
    CAP_PROP_XI_LENS_FOCAL_LENGTH = 516,               //!< Lens focal distance in mm.
    CAP_PROP_XI_LENS_FEATURE_SELECTOR = 517,           //!< Selects the current feature which is accessible by XI_PRM_LENS_FEATURE.
    CAP_PROP_XI_LENS_FEATURE = 518,                    //!< Allows access to lens feature value currently selected by XI_PRM_LENS_FEATURE_SELECTOR.
    CAP_PROP_XI_DEVICE_MODEL_ID = 521,                 //!< Returns device model id.
    CAP_PROP_XI_DEVICE_SN = 522,                       //!< Returns device serial number.
    CAP_PROP_XI_IMAGE_DATA_FORMAT_RGB32_ALPHA = 529,   //!< The alpha channel of RGB32 output image format.
    CAP_PROP_XI_IMAGE_PAYLOAD_SIZE = 530,              //!< Buffer size in bytes sufficient for output image returned by xiGetImage.
    CAP_PROP_XI_TRANSPORT_PIXEL_FORMAT = 531,          //!< Current format of pixels on transport layer.
    CAP_PROP_XI_SENSOR_CLOCK_FREQ_HZ = 532,            //!< Sensor clock frequency in Hz.
    CAP_PROP_XI_SENSOR_CLOCK_FREQ_INDEX = 533,         //!< Sensor clock frequency index. Sensor with selected frequencies have possibility to set the frequency only by this index.
    CAP_PROP_XI_SENSOR_OUTPUT_CHANNEL_COUNT = 534,     //!< Number of output channels from sensor used for data transfer.
    CAP_PROP_XI_FRAMERATE = 535,                       //!< Define framerate in Hz.
    CAP_PROP_XI_COUNTER_SELECTOR = 536,                //!< Select counter.
    CAP_PROP_XI_COUNTER_VALUE = 537,                   //!< Counter status.
    CAP_PROP_XI_ACQ_TIMING_MODE = 538,                 //!< Type of sensor frames timing.
    CAP_PROP_XI_AVAILABLE_BANDWIDTH = 539,             //!< Calculate and returns available interface bandwidth(int Megabits).
    CAP_PROP_XI_BUFFER_POLICY = 540,                   //!< Data move policy.
    CAP_PROP_XI_LUT_EN = 541,                          //!< Activates LUT.
    CAP_PROP_XI_LUT_INDEX = 542,                       //!< Control the index (offset) of the coefficient to access in the LUT.
    CAP_PROP_XI_LUT_VALUE = 543,                       //!< Value at entry LUTIndex of the LUT.
    CAP_PROP_XI_TRG_DELAY = 544,                       //!< Specifies the delay in microseconds (us) to apply after the trigger reception before activating it.
    CAP_PROP_XI_TS_RST_MODE = 545,                     //!< Defines how time stamp reset engine will be armed.
    CAP_PROP_XI_TS_RST_SOURCE = 546,                   //!< Defines which source will be used for timestamp reset. Writing this parameter will trigger settings of engine (arming).
    CAP_PROP_XI_IS_DEVICE_EXIST = 547,                 //!< Returns 1 if camera connected and works properly.
    CAP_PROP_XI_ACQ_BUFFER_SIZE = 548,                 //!< Acquisition buffer size in buffer_size_unit. Default bytes.
    CAP_PROP_XI_ACQ_BUFFER_SIZE_UNIT = 549,            //!< Acquisition buffer size unit in bytes. Default 1. E.g. Value 1024 means that buffer_size is in KiBytes.
    CAP_PROP_XI_ACQ_TRANSPORT_BUFFER_SIZE = 550,       //!< Acquisition transport buffer size in bytes.
    CAP_PROP_XI_BUFFERS_QUEUE_SIZE = 551,              //!< Queue of field/frame buffers.
    CAP_PROP_XI_ACQ_TRANSPORT_BUFFER_COMMIT = 552,     //!< Number of buffers to commit to low level.
    CAP_PROP_XI_RECENT_FRAME = 553,                    //!< GetImage returns most recent frame.
    CAP_PROP_XI_DEVICE_RESET = 554,                    //!< Resets the camera to default state.
    CAP_PROP_XI_COLUMN_FPN_CORRECTION = 555,           //!< Correction of column FPN.
    CAP_PROP_XI_ROW_FPN_CORRECTION = 591,              //!< Correction of row FPN.
    CAP_PROP_XI_SENSOR_MODE = 558,                     //!< Current sensor mode. Allows to select sensor mode by one integer. Setting of this parameter affects: image dimensions and downsampling.
    CAP_PROP_XI_HDR = 559,                             //!< Enable High Dynamic Range feature.
    CAP_PROP_XI_HDR_KNEEPOINT_COUNT = 560,             //!< The number of kneepoints in the PWLR.
    CAP_PROP_XI_HDR_T1 = 561,                          //!< Position of first kneepoint(in % of XI_PRM_EXPOSURE).
    CAP_PROP_XI_HDR_T2 = 562,                          //!< Position of second kneepoint (in % of XI_PRM_EXPOSURE).
    CAP_PROP_XI_KNEEPOINT1 = 563,                      //!< Value of first kneepoint (% of sensor saturation).
    CAP_PROP_XI_KNEEPOINT2 = 564,                      //!< Value of second kneepoint (% of sensor saturation).
    CAP_PROP_XI_IMAGE_BLACK_LEVEL = 565,               //!< Last image black level counts. Can be used for Offline processing to recall it.
    CAP_PROP_XI_HW_REVISION = 571,                     //!< Returns hardware revision number.
    CAP_PROP_XI_DEBUG_LEVEL = 572,                     //!< Set debug level.
    CAP_PROP_XI_AUTO_BANDWIDTH_CALCULATION = 573,      //!< Automatic bandwidth calculation.
    CAP_PROP_XI_FFS_FILE_ID = 594,                     //!< File number.
    CAP_PROP_XI_FFS_FILE_SIZE = 580,                   //!< Size of file.
    CAP_PROP_XI_FREE_FFS_SIZE = 581,                   //!< Size of free camera FFS.
    CAP_PROP_XI_USED_FFS_SIZE = 582,                   //!< Size of used camera FFS.
    CAP_PROP_XI_FFS_ACCESS_KEY = 583,                  //!< Setting of key enables file operations on some cameras.
    CAP_PROP_XI_SENSOR_FEATURE_SELECTOR = 585,         //!< Selects the current feature which is accessible by XI_PRM_SENSOR_FEATURE_VALUE.
    CAP_PROP_XI_SENSOR_FEATURE_VALUE = 586,            //!< Allows access to sensor feature value currently selected by XI_PRM_SENSOR_FEATURE_SELECTOR.
};

//! @} XIMEA

/** @name ARAVIS Camera API
    @{
*/

//! Properties of cameras available through ARAVIS backend
enum
{
    CAP_PROP_ARAVIS_AUTOTRIGGER = 600 //!< Automatically trigger frame capture if camera is configured with software trigger
};

//! @} ARAVIS

/** @name AVFoundation framework for iOS
    @{
*/

//! Properties of cameras available through AVFOUNDATION backend
enum
{
    CAP_PROP_IOS_DEVICE_FOCUS = 9001,
    CAP_PROP_IOS_DEVICE_EXPOSURE = 9002,
    CAP_PROP_IOS_DEVICE_FLASH = 9003,
    CAP_PROP_IOS_DEVICE_WHITEBALANCE = 9004,
    CAP_PROP_IOS_DEVICE_TORCH = 9005
};

//! @} AVFoundation framework for iOS

/** @name Smartek Giganetix GigEVisionSDK
    @{
*/

//! Properties of cameras available through Smartek Giganetix Ethernet Vision backend
/* --- Vladimir Litvinenko (litvinenko.vladimir@gmail.com) --- */
enum
{
    CAP_PROP_GIGA_FRAME_OFFSET_X = 10001,
    CAP_PROP_GIGA_FRAME_OFFSET_Y = 10002,
    CAP_PROP_GIGA_FRAME_WIDTH_MAX = 10003,
    CAP_PROP_GIGA_FRAME_HEIGH_MAX = 10004,
    CAP_PROP_GIGA_FRAME_SENS_WIDTH = 10005,
    CAP_PROP_GIGA_FRAME_SENS_HEIGH = 10006
};

//! @} Smartek

/** @name Intel Perceptual Computing SDK
    @{
*/
enum
{
    CAP_PROP_INTELPERC_PROFILE_COUNT = 11001,
    CAP_PROP_INTELPERC_PROFILE_IDX = 11002,
    CAP_PROP_INTELPERC_DEPTH_LOW_CONFIDENCE_VALUE = 11003,
    CAP_PROP_INTELPERC_DEPTH_SATURATION_VALUE = 11004,
    CAP_PROP_INTELPERC_DEPTH_CONFIDENCE_THRESHOLD = 11005,
    CAP_PROP_INTELPERC_DEPTH_FOCAL_LENGTH_HORZ = 11006,
    CAP_PROP_INTELPERC_DEPTH_FOCAL_LENGTH_VERT = 11007
};

//! Intel Perceptual Streams
enum
{
    CAP_INTELPERC_DEPTH_GENERATOR = 1 << 29,
    CAP_INTELPERC_IMAGE_GENERATOR = 1 << 28,
    CAP_INTELPERC_IR_GENERATOR = 1 << 27,
    CAP_INTELPERC_GENERATORS_MASK =
        CAP_INTELPERC_DEPTH_GENERATOR + CAP_INTELPERC_IMAGE_GENERATOR + CAP_INTELPERC_IR_GENERATOR
};

enum
{
    CAP_INTELPERC_DEPTH_MAP = 0,   //!< Each pixel is a 16-bit integer. The value indicates the distance from an object to the camera's XY plane or the Cartesian depth.
    CAP_INTELPERC_UVDEPTH_MAP = 1, //!< Each pixel contains two 32-bit floating point values in the range of 0-1, representing the mapping of depth coordinates to the color coordinates.
    CAP_INTELPERC_IR_MAP = 2,      //!< Each pixel is a 16-bit integer. The value indicates the intensity of the reflected laser beam.
    CAP_INTELPERC_IMAGE = 3
};

//! @} Intel Perceptual

/** @name gPhoto2 connection
    @{
*/

/** @brief gPhoto2 properties

If `propertyId` is less than 0 then work on widget with that __additive inversed__ camera setting ID
Get IDs by using CAP_PROP_GPHOTO2_WIDGET_ENUMERATE.
@see CvCaptureCAM_GPHOTO2 for more info
*/
enum
{
    CAP_PROP_GPHOTO2_PREVIEW = 17001,          //!< Capture only preview from liveview mode.
    CAP_PROP_GPHOTO2_WIDGET_ENUMERATE = 17002, //!< Readonly, returns (const char *).
    CAP_PROP_GPHOTO2_RELOAD_CONFIG = 17003,    //!< Trigger, only by set. Reload camera settings.
    CAP_PROP_GPHOTO2_RELOAD_ON_CHANGE = 17004, //!< Reload all settings on set.
    CAP_PROP_GPHOTO2_COLLECT_MSGS = 17005,     //!< Collect messages with details.
    CAP_PROP_GPHOTO2_FLUSH_MSGS = 17006,       //!< Readonly, returns (const char *).
    CAP_PROP_SPEED = 17007,                    //!< Exposure speed. Can be readonly, depends on camera program.
    CAP_PROP_APERTURE = 17008,                 //!< Aperture. Can be readonly, depends on camera program.
    CAP_PROP_EXPOSUREPROGRAM = 17009,          //!< Camera exposure program.
    CAP_PROP_VIEWFINDER = 17010                //!< Enter liveview mode.
};

//! @} gPhoto2

/** @name Images backend
    @{
*/

/** @brief Images backend properties

*/
enum
{
    CAP_PROP_IMAGES_BASE = 18000,
    CAP_PROP_IMAGES_LAST = 19000 // excluding
};

//! @} Images

/** @name OBSENSOR (for Orbbec 3D-Sensor device/module )
    @{
*/
//! OBSENSOR data given from image generator
// VideoCaptureOBSensorDataType
enum
{
    CAP_OBSENSOR_DEPTH_MAP = 0, //!< Depth values in mm (CV_16UC1)
    CAP_OBSENSOR_BGR_IMAGE = 1, //!< Data given from BGR stream generator
    CAP_OBSENSOR_IR_IMAGE = 2   //!< Data given from IR stream generator(CV_16UC1)
};

//! OBSENSOR stream generator
// VideoCaptureOBSensorGenerators
enum
{
    CAP_OBSENSOR_DEPTH_GENERATOR = 1 << 29,
    CAP_OBSENSOR_IMAGE_GENERATOR = 1 << 28,
    CAP_OBSENSOR_IR_GENERATOR = 1 << 27,
    CAP_OBSENSOR_GENERATORS_MASK =
        CAP_OBSENSOR_DEPTH_GENERATOR + CAP_OBSENSOR_IMAGE_GENERATOR + CAP_OBSENSOR_IR_GENERATOR
};

//! OBSENSOR properties
// VideoCaptureOBSensorProperties
enum
{
    // INTRINSIC
    CAP_PROP_OBSENSOR_INTRINSIC_FX = 26001,
    CAP_PROP_OBSENSOR_INTRINSIC_FY = 26002,
    CAP_PROP_OBSENSOR_INTRINSIC_CX = 26003,
    CAP_PROP_OBSENSOR_INTRINSIC_CY = 26004,
};

//! type of the template matching operation
// TemplateMatchModes
enum
{
    TM_SQDIFF = 0,        /*!< \f[R(x,y)= \sum _{x',y'} (T(x',y')-I(x+x',y+y'))^2\f]
                                      with mask:
                                      \f[R(x,y)= \sum _{x',y'} \left( (T(x',y')-I(x+x',y+y')) \cdot
                                         M(x',y') \right)^2\f] */
    TM_SQDIFF_NORMED = 1, /*!< \f[R(x,y)= \frac{\sum_{x',y'} (T(x',y')-I(x+x',y+y'))^2}{\sqrt{\sum_{
                                  x',y'}T(x',y')^2 \cdot \sum_{x',y'} I(x+x',y+y')^2}}\f]
                               with mask:
                               \f[R(x,y)= \frac{\sum _{x',y'} \left( (T(x',y')-I(x+x',y+y')) \cdot
                                  M(x',y') \right)^2}{\sqrt{\sum_{x',y'} \left( T(x',y') \cdot
                                  M(x',y') \right)^2 \cdot \sum_{x',y'} \left( I(x+x',y+y') \cdot
                                  M(x',y') \right)^2}}\f] */
    TM_CCORR = 2,         /*!< \f[R(x,y)= \sum _{x',y'} (T(x',y') \cdot I(x+x',y+y'))\f]
                                       with mask:
                                       \f[R(x,y)= \sum _{x',y'} (T(x',y') \cdot I(x+x',y+y') \cdot M(x',y')
                                          ^2)\f] */
    TM_CCORR_NORMED = 3,  /*!< \f[R(x,y)= \frac{\sum_{x',y'} (T(x',y') \cdot I(x+x',y+y'))}{\sqrt{
                                   \sum_{x',y'}T(x',y')^2 \cdot \sum_{x',y'} I(x+x',y+y')^2}}\f]
                                with mask:
                                \f[R(x,y)= \frac{\sum_{x',y'} (T(x',y') \cdot I(x+x',y+y') \cdot
                                   M(x',y')^2)}{\sqrt{\sum_{x',y'} \left( T(x',y') \cdot M(x',y')
                                   \right)^2 \cdot \sum_{x',y'} \left( I(x+x',y+y') \cdot M(x',y')
                                   \right)^2}}\f] */
    TM_CCOEFF = 4,        /*!< \f[R(x,y)= \sum _{x',y'} (T'(x',y') \cdot I'(x+x',y+y'))\f]
                                      where
                                      \f[\begin{array}{l} T'(x',y')=T(x',y') - 1/(w \cdot h) \cdot \sum _{
                                         x'',y''} T(x'',y'') \\ I'(x+x',y+y')=I(x+x',y+y') - 1/(w \cdot h)
                                         \cdot \sum _{x'',y''} I(x+x'',y+y'') \end{array}\f]
                                      with mask:
                                      \f[\begin{array}{l} T'(x',y')=M(x',y') \cdot \left( T(x',y') -
                                         \frac{1}{\sum _{x'',y''} M(x'',y'')} \cdot \sum _{x'',y''}
                                         (T(x'',y'') \cdot M(x'',y'')) \right) \\ I'(x+x',y+y')=M(x',y')
                                         \cdot \left( I(x+x',y+y') - \frac{1}{\sum _{x'',y''} M(x'',y'')}
                                         \cdot \sum _{x'',y''} (I(x+x'',y+y'') \cdot M(x'',y'')) \right)
                                         \end{array} \f] */
    TM_CCOEFF_NORMED = 5  /*!< \f[R(x,y)= \frac{ \sum_{x',y'} (T'(x',y') \cdot I'(x+x',y+y')) }{
                                  \sqrt{\sum_{x',y'}T'(x',y')^2 \cdot \sum_{x',y'} I'(x+x',y+y')^2}
                                  }\f] */
};

//! type of the robust estimation algorithm
enum
{
    HOMOGRAPY_ALL_POINTS = 0,
    HOMOGRAPY_LMEDS = 4,
    HOMOGRAPY_RANSAC = 8
};

//! Edge preserving filters
enum
{
    RECURS_FILTER = 1,  //!< Recursive Filtering
    NORMCONV_FILTER = 2 //!< Normalized Convolution Filtering
};

//! @addtogroup photo_inpaint
//! @{
//! the inpainting algorithm
enum
{
    INPAINT_NS = 0,   //!< Use Navier-Stokes based method
    INPAINT_TELEA = 1 //!< Use the algorithm proposed by Alexandru Telea @cite Telea04
};

//! seamlessClone algorithm flags
enum
{
    /** The power of the method is fully expressed when inserting objects with complex outlines into a new background*/
    NORMAL_CLONE = 1,
    /** The classic method, color-based selection and alpha masking might be time consuming and often leaves an undesirable
    halo. Seamless cloning, even averaged with the original image, is not effective. Mixed seamless cloning based on a loose selection proves effective.*/
    MIXED_CLONE = 2,
    /** Monochrome transfer allows the user to easily replace certain features of one object by alternative features.*/
    MONOCHROME_TRANSFER = 3
};

#pragma region calib3d

//! type of the robust estimation algorithm
enum
{
    LMEDS = 4,          //!< least-median of squares algorithm
    RANSAC = 8,         //!< RANSAC algorithm
    RHO = 16,           //!< RHO algorithm
    USAC_DEFAULT = 32,  //!< USAC algorithm, default settings
    USAC_PARALLEL = 33, //!< USAC, parallel version
    USAC_FM_8PTS = 34,  //!< USAC, fundamental matrix 8 points
    USAC_FAST = 35,     //!< USAC, fast settings
    USAC_ACCURATE = 36, //!< USAC, accurate settings
    USAC_PROSAC = 37,   //!< USAC, sorted points, runs PROSAC
    USAC_MAGSAC = 38    //!< USAC, runs MAGSAC++
};

enum SolvePnPMethod
{
    SOLVEPNP_ITERATIVE = 0, //!< Pose refinement using non-linear Levenberg-Marquardt minimization scheme @cite Madsen04 @cite Eade13 \n
    //!< Initial solution for non-planar "objectPoints" needs at least 6 points and uses the DLT algorithm. \n
    //!< Initial solution for planar "objectPoints" needs at least 4 points and uses pose from homography decomposition.
    SOLVEPNP_EPNP = 1, //!< EPnP: Efficient Perspective-n-Point Camera Pose Estimation @cite lepetit2009epnp
    SOLVEPNP_P3P = 2,  //!< Complete Solution Classification for the Perspective-Three-Point Problem @cite gao2003complete
    SOLVEPNP_DLS = 3,  //!< **Broken implementation. Using this flag will fallback to EPnP.** \n
    //!< A Direct Least-Squares (DLS) Method for PnP @cite hesch2011direct
    SOLVEPNP_UPNP = 4, //!< **Broken implementation. Using this flag will fallback to EPnP.** \n
    //!< Exhaustive Linearization for Robust Camera Pose and Focal Length Estimation @cite penate2013exhaustive
    SOLVEPNP_AP3P = 5, //!< An Efficient Algebraic Solution to the Perspective-Three-Point Problem @cite Ke17
    SOLVEPNP_IPPE = 6, //!< Infinitesimal Plane-Based Pose Estimation @cite Collins14 \n
    //!< Object points must be coplanar.
    SOLVEPNP_IPPE_SQUARE = 7, //!< Infinitesimal Plane-Based Pose Estimation @cite Collins14 \n
    //!< This is a special case suitable for marker pose estimation.\n
    //!< 4 coplanar object points must be defined in the following order:
    //!<   - point 0: [-squareLength / 2,  squareLength / 2, 0]
    //!<   - point 1: [ squareLength / 2,  squareLength / 2, 0]
    //!<   - point 2: [ squareLength / 2, -squareLength / 2, 0]
    //!<   - point 3: [-squareLength / 2, -squareLength / 2, 0]
    SOLVEPNP_SQPNP = 8, //!< SQPnP: A Consistently Fast and Globally OptimalSolution to the Perspective-n-Point Problem @cite Terzakis2020SQPnP
#ifndef CV_DOXYGEN
    SOLVEPNP_MAX_COUNT //!< Used for count
#endif
};

enum
{
    CALIB_CB_ADAPTIVE_THRESH = 1,
    CALIB_CB_NORMALIZE_IMAGE = 2,
    CALIB_CB_FILTER_QUADS = 4,
    CALIB_CB_FAST_CHECK = 8,
    CALIB_CB_EXHAUSTIVE = 16,
    CALIB_CB_ACCURACY = 32,
    CALIB_CB_LARGER = 64,
    CALIB_CB_MARKER = 128,
    CALIB_CB_PLAIN = 256
};

enum
{
    CALIB_CB_SYMMETRIC_GRID = 1,
    CALIB_CB_ASYMMETRIC_GRID = 2,
    CALIB_CB_CLUSTERING = 4
};

enum
{
    CALIB_NINTRINSIC = 18,
    CALIB_USE_INTRINSIC_GUESS = 0x00001,
    CALIB_FIX_ASPECT_RATIO = 0x00002,
    CALIB_FIX_PRINCIPAL_POINT = 0x00004,
    CALIB_ZERO_TANGENT_DIST = 0x00008,
    CALIB_FIX_FOCAL_LENGTH = 0x00010,
    CALIB_FIX_K1 = 0x00020,
    CALIB_FIX_K2 = 0x00040,
    CALIB_FIX_K3 = 0x00080,
    CALIB_FIX_K4 = 0x00800,
    CALIB_FIX_K5 = 0x01000,
    CALIB_FIX_K6 = 0x02000,
    CALIB_RATIONAL_MODEL = 0x04000,
    CALIB_THIN_PRISM_MODEL = 0x08000,
    CALIB_FIX_S1_S2_S3_S4 = 0x10000,
    CALIB_TILTED_MODEL = 0x40000,
    CALIB_FIX_TAUX_TAUY = 0x80000,
    CALIB_USE_QR = 0x100000, //!< use QR instead of SVD decomposition for solving. Faster but potentially less precise
    CALIB_FIX_TANGENT_DIST = 0x200000,
    // only for stereo
    CALIB_FIX_INTRINSIC = 0x00100,
    CALIB_SAME_FOCAL_LENGTH = 0x00200,
    // for stereo rectification
    CALIB_ZERO_DISPARITY = 0x00400,
    CALIB_USE_LU = (1
                    << 17),               //!< use LU instead of SVD decomposition for solving. much faster but potentially less precise
    CALIB_USE_EXTRINSIC_GUESS = (1 << 22) //!< for stereoCalibrate
};

#endif // OPENCV_DART_LIBRARY_ENUMS_H
