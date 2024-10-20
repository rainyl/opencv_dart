// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

library cv.highgui;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/rect.dart';
import '../g/highgui.g.dart' as cvg;
import '../native_lib.dart' show chighgui;

String currentUIFramework() => chighgui.cv_currentUIFramework().toDartString();

int getMouseWheelDelta(int flags) => chighgui.cv_getMouseWheelDelta(flags);

int pollKey() => chighgui.cv_pollKey();

/// waits for a pressed key.
/// This function is the only method in OpenCV's HighGUI that can fetch
/// and handle events, so it needs to be called periodically
/// for normal event processing
///
/// For further details, please see:
/// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga5628525ad33f52eab17feebcfba38bd7
int waitKey(int delay) => chighgui.cv_waitKey(delay);
int waitKeyEx(int delay) => chighgui.cv_waitKeyEx(delay);

/// creates a new named OpenCV window
///
/// For further details, please see:
/// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga5afdf8410934fd099df85c75b2e0888b
void namedWindow(String name, [int flags = 0]) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_namedWindow(cname, flags));
  calloc.free(cname);
}

void destroyWindow(String name) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_destroyWindow(cname));
  calloc.free(cname);
}

/// destroy all windows.
void destroyAllWindows() {
  cvRun(chighgui.cv_destroyAllWindows);
}

/// displays an image Mat in the specified window.
/// This function should be followed by the WaitKey function which displays
/// the image for specified milliseconds. Otherwise, it won't display the image.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga453d42fe4cb60e5723281a89973ee563
void imshow(String name, Mat img) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_imshow(cname, img.ref));
  calloc.free(cname);
}

Rect getWindowImageRect(String name) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final p = calloc<cvg.CvRect>();
  cvRun(() => chighgui.cv_getWindowImageRect(cname, p));
  calloc.free(cname);
  return Rect.fromPointer(p);
}

/// [getWindowProperty] returns properties of a window.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/dfc/group__highgui.html#gaaf9504b8f9cf19024d9d44a14e461656
double getWindowProperty(String name, WindowPropertyFlags flag) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final p = calloc<ffi.Double>();
  cvRun(() => chighgui.cv_getWindowProperty(cname, flag.value, p));
  final rval = p.value;
  calloc.free(p);
  calloc.free(cname);
  return rval;
}

/// [setWindowProperty] changes parameters of a window dynamically.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga66e4a6db4d4e06148bcdfe0d70a5df27
void setWindowProperty(String name, WindowPropertyFlags flag, double value) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_setWindowProperty(cname, flag.value, value));
  calloc.free(cname);
}

/// SetWindowTitle updates window title.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga56f8849295fd10d0c319724ddb773d96
void setWindowTitle(String name, String title) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final ctitle = title.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_setWindowTitle(cname, ctitle));
  calloc.free(ctitle);
  calloc.free(cname);
}

/// MoveWindow moves window to the specified position.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga8d86b207f7211250dbe6e28f76307ffb
void moveWindow(String name, int x, int y) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_moveWindow(cname, x, y));
  calloc.free(cname);
}

/// ResizeWindow resizes window to the specified size.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga9e80e080f7ef33f897e415358aee7f7e
void resizeWindow(String name, int width, int height) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_resizeWindow(cname, width, height));
  calloc.free(cname);
}

/// SelectROI selects a Region Of Interest (ROI) on the given image.
/// It creates a window and allows user to select a ROI cvRunArena mouse.
///
/// Controls:
/// use space or enter to finish selection,
/// use key c to cancel selection (function will return a zero Rect).
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga8daf4730d3adf7035b6de9be4c469af5
Rect selectROI(
  String name,
  Mat img, {
  bool showCrosshair = true,
  bool fromCenter = false,
  bool printNotice = true,
}) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final p = calloc<cvg.CvRect>();
  cvRun(() => chighgui.cv_selectROI(cname, img.ref, showCrosshair, fromCenter, printNotice, p));
  calloc.free(cname);
  return Rect.fromPointer(p);
}

/// SelectROIs selects multiple Regions Of Interest (ROI) on the given image.
/// It creates a window and allows user to select ROIs cvRunArena mouse.
///
/// Controls:
/// use space or enter to finish current selection and start a new one
/// use esc to terminate multiple ROI selection process
///
/// For further details, please see:
/// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga0f11fad74a6432b8055fb21621a0f893
VecRect selectROIs(
  String name,
  Mat img, {
  bool showCrosshair = true,
  bool fromCenter = false,
  bool printNotice = true,
}) {
  final p = calloc<cvg.VecRect>();
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_selectROIs(cname, img.ref, p, showCrosshair, fromCenter, printNotice));
  calloc.free(cname);
  return VecRect.fromPointer(p);
}

// https://stackoverflow.com/a/48055987/18539998
bool isWindowOpen(String name) {
  final ret = getWindowProperty(name, WindowPropertyFlags.WND_PROP_VISIBLE).toInt();
  return ret != 0;
}

void createTrackbar(
  String name,
  String winname,
  int maxval, {
  cvg.Dartcv_TrackbarCallbackFunction? onChange,
}) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final cwinname = winname.toNativeUtf8().cast<ffi.Char>();
  if (onChange == null) {
    cvRun(() => chighgui.cv_createTrackbar(cname, cwinname, maxval));
  } else {
    final funcPointer = ffi.NativeCallable<cvg.cv_TrackbarCallbackFunction>.isolateLocal(onChange);
    cvRun(
      () => chighgui.cv_createTrackbar_1(
        cname,
        cwinname,
        ffi.nullptr,
        maxval,
        funcPointer.nativeFunction,
        ffi.nullptr,
      ),
    );
  }
  calloc.free(cname);
  calloc.free(cwinname);
}

int getTrackbarPos(String name, String winname) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final cwinname = winname.toNativeUtf8().cast<ffi.Char>();
  final p = calloc<ffi.Int>();
  cvRun(() => chighgui.cv_getTrackbarPos(cname, cwinname, p));
  final rval = p.value;
  calloc.free(p);
  calloc.free(cname);
  calloc.free(cwinname);
  return rval;
}

void setTrackbarPos(String name, String winname, int pos) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final cwinname = winname.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_setTrackbarPos(cname, cwinname, pos));
  calloc.free(cname);
  calloc.free(cwinname);
}

void setTrackbarMin(String name, String winname, int minval) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final cwinname = winname.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_setTrackbarMin(cname, cwinname, minval));
  calloc.free(cname);
  calloc.free(cwinname);
}

void setTrackbarMax(String name, String winname, int maxval) {
  final cname = name.toNativeUtf8().cast<ffi.Char>();
  final cwinname = winname.toNativeUtf8().cast<ffi.Char>();
  cvRun(() => chighgui.cv_setTrackbarMax(cname, cwinname, maxval));
  calloc.free(cname);
  calloc.free(cwinname);
}

enum WindowFlag {
  /// the user can resize the window (no constraint) / also use to switch a fullscreen window to a normal size.
  WINDOW_NORMAL(0x00000000),

  /// the user cannot resize the window, the size is constrainted by the image displayed.
  WINDOW_AUTOSIZE(0x00000001),

  /// window with opengl support.
  WINDOW_OPENGL(0x00001000),

  /// change the window to fullscreen.
  WINDOW_FULLSCREEN(1),

  /// the image expends as much as it can (no ratio constraint).
  WINDOW_FREERATIO(0x00000100),

  /// the ratio of the image is respected.
  WINDOW_KEEPRATIO(0x00000000),

  /// status bar and tool bar
  WINDOW_GUI_EXPANDED(0x00000000),

  /// old fashious way
  WINDOW_GUI_NORMAL(0x00000010);

  const WindowFlag(this.value);
  final double value;
}

enum WindowPropertyFlags {
  /// fullscreen property (can be WINDOW_NORMAL or WINDOW_FULLSCREEN).
  WND_PROP_FULLSCREEN(0),

  /// autosize property (can be WINDOW_NORMAL or WINDOW_AUTOSIZE).
  WND_PROP_AUTOSIZE(1),

  /// window’s aspect ration (can be set to WINDOW_FREERATIO or WINDOW_KEEPRATIO).
  WND_PROP_ASPECT_RATIO(2),

  /// opengl support.
  WND_PROP_OPENGL(3),

  /// checks whether the window exists and is visible
  WND_PROP_VISIBLE(4);

  const WindowPropertyFlags(this.value);
  final int value;
}
