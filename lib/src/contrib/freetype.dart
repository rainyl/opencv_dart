// Copyright (c) 2025, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.freetype;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../g/constants.g.dart' show LINE_8;
import '../g/contrib.g.dart' as cvg;
import '../g/contrib.g.dart' as ccontrib;

class FreeType2 extends CvStruct<cvg.FreeType2> {
  FreeType2._(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory FreeType2.fromPointer(cvg.FreeType2Ptr ptr, [bool attach = true]) => FreeType2._(ptr, attach);

  /// Create a [FreeType2] object.
  ///
  /// [filename] FontFile Name, if not null, will call [loadFontData] internally.
  /// [idx] face_index to select a font faces in a single file.
  factory FreeType2.create({String? filename, int idx = 0}) {
    final p = calloc<cvg.FreeType2>();
    cvRun(() => ccontrib.cv_freetype_FreeType2_create(p));
    final ft = FreeType2._(p);
    if (filename != null) {
      ft.loadFontData(filename, idx);
    }
    return ft;
  }

  /// Load font data.
  ///
  /// The function loadFontData loads font data from file.
  ///
  /// [filename] FontFile Name
  /// [idx] face_index to select a font faces in a single file.
  void loadFontData(String filename, int idx) {
    final cname = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.cv_freetype_FreeType2_loadFontData(ref, cname, idx, ffi.nullptr));
    calloc.free(cname);
  }

  /// async version of [loadFontData]
  Future<void> loadFontDataAsync(String filename, int idx) async {
    final cname = filename.toNativeUtf8().cast<ffi.Char>();
    await cvRunAsync0(
      (callback) => ccontrib.cv_freetype_FreeType2_loadFontData(ref, cname, idx, callback),
      (c) {
        calloc.free(cname);
        c.complete();
      },
    );
  }

  /// Load font data.
  ///
  /// The function loadFontData loads font data from memory.
  /// The data is not copied, the user needs to make sure the data lives at least as long as FreeType2.
  /// After the FreeType2 object is destroyed, the buffer can be safely deallocated.
  ///
  /// [buffer] buffer containing font data
  /// [idx] face_index to select a font faces in a single file.
  void loadFontBuffer(Uint8List buffer, int idx) {
    final cbuffer = malloc<ffi.Uint8>(buffer.length);
    cbuffer.asTypedList(buffer.length).setAll(0, buffer);
    cvRun(
      () => ccontrib.cv_freetype_FreeType2_loadFontData_buf(
        ref,
        cbuffer.cast<ffi.Char>(),
        buffer.length,
        idx,
        ffi.nullptr,
      ),
    );
    malloc.free(cbuffer);
  }

  /// async version of [loadFontBuffer]
  Future<void> loadFontBufferAsync(Uint8List buffer, int idx) async {
    final cbuffer = malloc<ffi.Uint8>(buffer.length);
    cbuffer.asTypedList(buffer.length).setAll(0, buffer);
    await cvRunAsync0(
      (callback) => ccontrib.cv_freetype_FreeType2_loadFontData_buf(
        ref,
        cbuffer.cast<ffi.Char>(),
        buffer.length,
        idx,
        callback,
      ),
      (c) {
        malloc.free(cbuffer);
        c.complete();
      },
    );
  }

  /// Set Split Number from Bezier-curve to line
  ///
  /// The function [setSplitNumber] set the number of split points from bezier-curve to line.
  ///
  /// If you want to draw large glyph, large is better.
  ///
  /// If you want to draw small glyph, small is better.
  void setSplitNumber(int num) {
    cvRun(() => ccontrib.cv_freetype_FreeType2_setSplitNumber(ref, num));
  }

  /// Draws a text string.
  /// The function putText renders the specified text string in the image.
  /// Symbols that cannot be rendered using the specified font are replaced by "Tofu" or non-drawn.
  ///
  ///
  /// [img] Image. (Only 8UC1/8UC3/8UC4 2D mat is supported.)
  ///
  /// [text] Text string to be drawn.
  ///
  /// [org] Bottom-left/Top-left corner of the text string in the image.
  ///
  /// [fontHeight] Drawing font size by pixel unit.
  ///
  /// [color] Text color.
  ///
  /// [thickness] Thickness of the lines used to draw a text when negative, the glyph is filled. Otherwise, the glyph is drawn with this thickness.
  ///
  /// [lineType] Line type. See the line for details.
  ///
  /// [bottomLeftOrigin] When true, the image data origin is at the bottom-left corner. Otherwise, it is at the top-left corner.
  void putText(
    InputOutputArray img,
    String text,
    Point org,
    int fontHeight,
    Scalar color, {
    int thickness = 1,
    int lineType = LINE_8,
    bool bottomLeftOrigin = false,
  }) {
    final ctext = text.toNativeUtf8().cast<ffi.Char>();
    cvRun(
      () => ccontrib.cv_freetype_FreeType2_putText(
        ref,
        img.ref,
        ctext,
        org.ref,
        fontHeight,
        color.ref,
        thickness,
        lineType,
        bottomLeftOrigin,
        ffi.nullptr,
      ),
    );
    calloc.free(ctext);
  }

  /// Async version of [putText]
  ///
  /// Draws a text string.
  /// The function putText renders the specified text string in the image.
  /// Symbols that cannot be rendered using the specified font are replaced by "Tofu" or non-drawn.
  ///
  /// [img] Image. (Only 8UC1/8UC3/8UC4 2D mat is supported.)
  ///
  /// [text] Text string to be drawn.
  ///
  /// [org] Bottom-left/Top-left corner of the text string in the image.
  ///
  /// [fontHeight] Drawing font size by pixel unit.
  ///
  /// [color] Text color.
  ///
  /// [thickness] Thickness of the lines used to draw a text when negative, the glyph is filled. Otherwise, the glyph is drawn with this thickness.
  ///
  /// [lineType] Line type. See the line for details.
  ///
  /// [bottomLeftOrigin] When true, the image data origin is at the bottom-left corner. Otherwise, it is at the top-left corner.
  Future<void> putTextAsync(
    InputOutputArray img,
    String text,
    Point org,
    int fontHeight,
    Scalar color, {
    int thickness = 1,
    int lineType = LINE_8,
    bool bottomLeftOrigin = false,
  }) async {
    final ctext = text.toNativeUtf8().cast<ffi.Char>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_freetype_FreeType2_putText(
        ref,
        img.ref,
        ctext,
        org.ref,
        fontHeight,
        color.ref,
        thickness,
        lineType,
        bottomLeftOrigin,
        callback,
      ),
      (c) {
        calloc.free(ctext);
        return c.complete();
      },
    );
  }

  /// Calculates the width and height of a text string.
  ///
  /// The function getTextSize calculates and returns the approximate size of a box that contains the specified text.
  /// That is, the following code renders some text, the tight box surrounding it, and the baseline: :
  /// ```c++
  /// String text = "Funny text inside the box";
  /// int fontHeight = 60;
  /// int thickness = -1;
  /// int linestyle = LINE_8;
  ///
  /// Mat img(600, 800, CV_8UC3, Scalar::all(0));
  ///
  /// int baseline=0;
  ///
  /// cv::Ptr<cv::freetype::FreeType2> ft2;
  /// ft2 = cv::freetype::createFreeType2();
  /// ft2->loadFontData( "./mplus-1p-regular.ttf", 0 );
  ///
  /// Size textSize = ft2->getTextSize(text,
  /// fontHeight,
  /// thickness,
  /// &baseline);
  ///
  /// if(thickness > 0){
  /// baseline += thickness;
  /// }
  ///
  /// // center the text
  /// Point textOrg((img.cols - textSize.width) / 2,
  /// (img.rows + textSize.height) / 2);
  ///
  /// // draw the box
  /// rectangle(img, textOrg + Point(0, baseline),
  /// textOrg + Point(textSize.width, -textSize.height),
  /// Scalar(0,255,0),1,8);
  ///
  /// // ... and the baseline first
  /// line(img, textOrg + Point(0, thickness),
  /// textOrg + Point(textSize.width, thickness),
  /// Scalar(0, 0, 255),1,8);
  ///
  /// // then put the text itself
  /// ft2->putText(img, text, textOrg, fontHeight,
  /// Scalar::all(255), thickness, linestyle, true );
  /// ```
  ///
  /// [text] Input text string.
  /// [fontHeight] Drawing font size by pixel unit.
  /// [thickness] Thickness of lines used to render the text. See putText for details.
  ///
  /// Return:
  /// - [Size] size, The size of a box that contains the specified text.
  /// - [int] baseLine y-coordinate of the baseline relative to the bottom-most text point.
  ///
  /// Also see [putText]
  (Size size, int baseline) getTextSize(String text, int fontHeight, int thickness) {
    final pBaseline = calloc<ffi.Int>();
    final pSize = calloc<cvg.CvSize>();
    final textPtr = text.toNativeUtf8().cast<ffi.Char>();
    cvRun(
      () => ccontrib.cv_freetype_FreeType2_getTextSize(
        ref,
        textPtr,
        fontHeight,
        thickness,
        pBaseline,
        pSize,
        ffi.nullptr,
      ),
    );
    final rval = (Size.fromPointer(pSize), pBaseline.value);
    calloc.free(pBaseline);
    return rval;
  }

  static final finalizer = OcvFinalizer<cvg.FreeType2Ptr>(
    ccontrib.addresses.cv_freetype_FreeType2_close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_freetype_FreeType2_close(ptr);
  }

  @override
  cvg.FreeType2 get ref => ptr.ref;
}
