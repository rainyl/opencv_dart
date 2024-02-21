library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/rect.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

/// [Window] is a wrapper around OpenCV's "HighGUI" named windows.
/// While OpenCV was designed for use in full-scale applications and can be used
/// within functionally rich UI frameworks (such as Qt*, WinForms*, or Cocoa*)
/// or without any UI at all, sometimes there it is required to try functionality
/// quickly and visualize the results. This is what the HighGUI module has been designed for.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d7/dfc/group__highgui.html
class Window {
  /// creates a new named OpenCV window
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga5afdf8410934fd099df85c75b2e0888b
  Window(this.name) : open = true {
    final cname = name.toNativeUtf8();
    _bindings.Window_New(cname.cast(), 0);
    calloc.free(cname);
  }

  void close() {
    final cname = name.toNativeUtf8();
    _bindings.Window_Close(cname.cast());
    calloc.free(cname);
    open = false;
  }

  /// [getWindowProperty] returns properties of a window.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#gaaf9504b8f9cf19024d9d44a14e461656
  double getWindowProperty(WindowPropertyFlags flag) {
    final cname = name.toNativeUtf8();
    final result = _bindings.Window_GetProperty(cname.cast(), flag.value);
    calloc.free(cname);
    return result;
  }

  /// [setWindowProperty] changes parameters of a window dynamically.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga66e4a6db4d4e06148bcdfe0d70a5df27
  void setWindowProperty(WindowPropertyFlags flag, double value) {
    final cname = name.toNativeUtf8();
    _bindings.Window_SetProperty(cname.cast(), flag.value, value);
    calloc.free(cname);
  }

  /// SetWindowTitle updates window title.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga56f8849295fd10d0c319724ddb773d96
  void setWindowTitle(String title) {
    final cname = name.toNativeUtf8();
    final ctitle = name.toNativeUtf8();
    _bindings.Window_SetTitle(cname.cast(), ctitle.cast());
    calloc.free(cname);
    calloc.free(ctitle);
  }

  /// IMShow displays an image Mat in the specified window.
  /// This function should be followed by the WaitKey function which displays
  /// the image for specified milliseconds. Otherwise, it won't display the image.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga453d42fe4cb60e5723281a89973ee563
  void imshow(Mat img) {
    final cname = name.toNativeUtf8();
    _bindings.Window_IMShow(cname.cast(), img.ptr);
    calloc.free(cname);
  }

  /// WaitKey waits for a pressed key.
  /// This function is the only method in OpenCV's HighGUI that can fetch
  /// and handle events, so it needs to be called periodically
  /// for normal event processing
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga5628525ad33f52eab17feebcfba38bd7
  int waitKey(int delay) => _bindings.Window_WaitKey(delay);

  /// MoveWindow moves window to the specified position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga8d86b207f7211250dbe6e28f76307ffb
  void moveWindow(int x, int y) {
    final cname = name.toNativeUtf8();
    _bindings.Window_Move(cname.cast(), x, y);
    calloc.free(cname);
  }

  /// ResizeWindow resizes window to the specified size.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga9e80e080f7ef33f897e415358aee7f7e
  void resizeWindow(int width, int height) {
    final cname = name.toNativeUtf8();
    _bindings.Window_Resize(cname.cast(), width, height);
    calloc.free(cname);
  }

  /// SelectROI selects a Region Of Interest (ROI) on the given image.
  /// It creates a window and allows user to select a ROI using mouse.
  ///
  /// Controls:
  /// use space or enter to finish selection,
  /// use key c to cancel selection (function will return a zero Rect).
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga8daf4730d3adf7035b6de9be4c469af5
  Rect selectROI(Mat img) {
    final cname = name.toNativeUtf8();
    final result = _bindings.Window_SelectROI(cname.cast(), img.ptr);
    calloc.free(cname);
    return Rect.fromNative(result);
  }

  /// SelectROIs selects multiple Regions Of Interest (ROI) on the given image.
  /// It creates a window and allows user to select ROIs using mouse.
  ///
  /// Controls:
  /// use space or enter to finish current selection and start a new one
  /// use esc to terminate multiple ROI selection process
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga0f11fad74a6432b8055fb21621a0f893
  List<Rect> selectROIs(Mat img) {
    final cname = name.toNativeUtf8();
    final result = _bindings.Window_SelectROIs(cname.cast(), img.ptr);
    calloc.free(cname);
    return Rects.toList(result);
  }

  String name;
  bool open;
}

/// WaitKey that is not attached to a specific Window.
/// Only use when no Window exists in your application, e.g. command line app.
int waitKey(int delay) => _bindings.Window_WaitKey(delay);

class Trackbar {
  Trackbar(this.name, this.parent, this.max, {List<int>? values}) {
    final arena = Arena();
    final tname = name.toNativeUtf8();
    final pname = parent.name.toNativeUtf8();
    if (values != null) {
      final _values = arena<ffi.Int>(values.length);
      for (var i = 0; i < values.length; i++) _values[i] = values[i];
      _bindings.Trackbar_CreateWithValue(pname.cast(), tname.cast(), _values, max);
    } else {
      _bindings.Trackbar_Create(pname.cast(), tname.cast(), max);
    }
    calloc.free(tname);
    calloc.free(pname);
    arena.releaseAll();
  }

  /// pos returns the trackbar position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga122632e9e91b9ec06943472c55d9cda8
  int get pos {
    final pname = parent.name.toNativeUtf8();
    final tname = name.toNativeUtf8();
    final result = _bindings.Trackbar_GetPos(pname.cast(), tname.cast());
    calloc.free(pname);
    calloc.free(tname);
    return result;
  }

  /// pos sets the trackbar position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga67d73c4c9430f13481fd58410d01bd8d
  void set pos(int pos) {
    final pname = parent.name.toNativeUtf8();
    final tname = name.toNativeUtf8();
    _bindings.Trackbar_SetPos(pname.cast(), tname.cast(), pos);
    calloc.free(pname);
    calloc.free(tname);
  }

  /// SetMin sets the trackbar minimum position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#gabe26ffe8d2b60cc678895595a581b7aa
  set minPos(int pos) {
    final pname = parent.name.toNativeUtf8();
    final tname = name.toNativeUtf8();
    _bindings.Trackbar_SetMin(pname.cast(), tname.cast(), pos);
    calloc.free(pname);
    calloc.free(tname);
  }

  /// SetMax sets the trackbar maximum position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga7e5437ccba37f1154b65210902fc4480
  set maxPos(int pos) {
    final pname = parent.name.toNativeUtf8();
    final tname = name.toNativeUtf8();
    _bindings.Trackbar_SetMax(pname.cast(), tname.cast(), pos);
    calloc.free(pname);
    calloc.free(tname);
  }

  String name;
  Window parent;
  int max;
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
  final int value;
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
