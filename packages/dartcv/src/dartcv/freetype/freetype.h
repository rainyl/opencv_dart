//
// Created by rainy on 2025/8/29.
//

#ifndef DARTCV_LIBRARY_FREETYPE_H
#define DARTCV_LIBRARY_FREETYPE_H

#ifdef __cplusplus
#include <opencv2/features2d.hpp>
#include <opencv2/core.hpp>
extern "C" {
#endif

#include "dartcv/core/types.h"
#include <stddef.h>

#ifdef __cplusplus
namespace cv {
namespace freetype {

//! @addtogroup freetype
//! @{
class CV_EXPORTS_W FreeType2 : public Algorithm {
  public:
    /** @brief Load font data.

The function loadFontData loads font data from file.

@param fontFileName FontFile Name
@param idx face_index to select a font faces in a single file.
*/

    CV_WRAP virtual void loadFontData(String fontFileName, int idx) = 0;

    /** @brief Load font data.

The function loadFontData loads font data from memory.
The data is not copied, the user needs to make sure the data lives at least as long as FreeType2.
After the FreeType2 object is destroyed, the buffer can be safely deallocated.

@param pBuf pointer to buffer containing font data
@param bufSize size of buffer
@param idx face_index to select a font faces in a single file.
*/

    CV_WRAP virtual void loadFontData(char* pBuf, size_t bufSize, int idx) = 0;

    /** @brief Set Split Number from Bezier-curve to line

The function setSplitNumber set the number of split points from bezier-curve to line.
If you want to draw large glyph, large is better.
If you want to draw small glyph, small is better.

@param num number of split points from bezier-curve to line
*/

    CV_WRAP virtual void setSplitNumber(int num) = 0;

    /** @brief Draws a text string.

The function putText renders the specified text string in the image. Symbols that cannot be rendered using the specified font are replaced by "Tofu" or non-drawn.

@param img Image. (Only 8UC1/8UC3/8UC4 2D mat is supported.)
@param text Text string to be drawn.
@param org Bottom-left/Top-left corner of the text string in the image.
@param fontHeight Drawing font size by pixel unit.
@param color Text color.
@param thickness Thickness of the lines used to draw a text when negative, the glyph is filled. Otherwise, the glyph is drawn with this thickness.
@param line_type Line type. See the line for details.
@param bottomLeftOrigin When true, the image data origin is at the bottom-left corner. Otherwise, it is at the top-left corner.
*/

    CV_WRAP virtual void putText(
        InputOutputArray img,
        const String& text,
        Point org,
        int fontHeight,
        Scalar color,
        int thickness,
        int line_type,
        bool bottomLeftOrigin
    ) = 0;

    /** @brief Calculates the width and height of a text string.

The function getTextSize calculates and returns the approximate size of a box that contains the specified text.
That is, the following code renders some text, the tight box surrounding it, and the baseline: :
@code
    String text = "Funny text inside the box";
    int fontHeight = 60;
    int thickness = -1;
    int linestyle = LINE_8;

    Mat img(600, 800, CV_8UC3, Scalar::all(0));

    int baseline=0;

    cv::Ptr<cv::freetype::FreeType2> ft2;
    ft2 = cv::freetype::createFreeType2();
    ft2->loadFontData( "./mplus-1p-regular.ttf", 0 );

    Size textSize = ft2->getTextSize(text,
                                     fontHeight,
                                     thickness,
                                     &baseline);

    if(thickness > 0){
        baseline += thickness;
    }

    // center the text
    Point textOrg((img.cols - textSize.width) / 2,
                  (img.rows + textSize.height) / 2);

    // draw the box
    rectangle(img, textOrg + Point(0, baseline),
              textOrg + Point(textSize.width, -textSize.height),
              Scalar(0,255,0),1,8);

    // ... and the baseline first
    line(img, textOrg + Point(0, thickness),
         textOrg + Point(textSize.width, thickness),
         Scalar(0, 0, 255),1,8);

    // then put the text itself
    ft2->putText(img, text, textOrg, fontHeight,
                 Scalar::all(255), thickness, linestyle, true );
@endcode

@param text Input text string.
@param fontHeight Drawing font size by pixel unit.
@param thickness Thickness of lines used to render the text. See putText for details.
@param[out] baseLine y-coordinate of the baseline relative to the bottom-most text
point.
@return The size of a box that contains the specified text.

@see cv::putText
 */
    CV_WRAP virtual Size getTextSize(
        const String& text, int fontHeight, int thickness, CV_OUT int* baseLine
    ) = 0;
};

}  // namespace freetype
}  // namespace cv
//! @}
CVD_TYPEDEF(cv::Ptr<cv::freetype::FreeType2>, FreeType2);
#else
CVD_TYPEDEF(void, FreeType2);
#endif

/// C wrappers
CvStatus* cv_freetype_FreeType2_create(FreeType2* rval);
void cv_freetype_FreeType2_close(FreeType2Ptr self);
CvStatus* cv_freetype_FreeType2_loadFontData(
    FreeType2 self, const char* fontFileName, int idx, CvCallback_0 callback
);
CvStatus* cv_freetype_FreeType2_loadFontData_buf(
    FreeType2 self, char* pBuf, size_t bufSize, int idx, CvCallback_0 callback
);
CvStatus* cv_freetype_FreeType2_setSplitNumber(FreeType2 self, int num);
CvStatus* cv_freetype_FreeType2_putText(
    FreeType2 self,
    MatInOut img,
    const char* text,
    CvPoint org,
    int fontHeight,
    Scalar color,
    int thickness,
    int line_type,
    bool bottomLeftOrigin,
    CvCallback_0 callback
);
CvStatus* cv_freetype_FreeType2_getTextSize(
    FreeType2 self,
    const char* text,
    int fontHeight,
    int thickness,
    int* baseLine,
    CvSize* rval,
    CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  //DARTCV_LIBRARY_FREETYPE_H
