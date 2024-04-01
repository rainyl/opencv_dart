// ignore_for_file: constant_identifier_names

library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/rect.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

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
  Window(this.name) {
    cvRunArena((arena) {
      cvRun(() => CFFI.Window_New(name.toNativeUtf8(allocator: arena).cast(), 0));
    });
  }

  void close() {
    cvRunArena((arena) {
      cvRun(() => CFFI.Window_Close(name.toNativeUtf8(allocator: arena).cast()));
    });
  }

  /// [getWindowProperty] returns properties of a window.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#gaaf9504b8f9cf19024d9d44a14e461656
  double getWindowProperty(WindowPropertyFlags flag) {
    return cvRunArena<double>((arena) {
      final result = arena<ffi.Double>();
      cvRun(() => CFFI.Window_GetProperty(name.toNativeUtf8(allocator: arena).cast(), flag.value, result));
      return result.value;
    });
  }

  /// [setWindowProperty] changes parameters of a window dynamically.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga66e4a6db4d4e06148bcdfe0d70a5df27
  void setWindowProperty(WindowPropertyFlags flag, double value) {
    cvRunArena((arena) {
      cvRun(() => CFFI.Window_SetProperty(name.toNativeUtf8(allocator: arena).cast(), flag.value, value));
    });
  }

  /// SetWindowTitle updates window title.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga56f8849295fd10d0c319724ddb773d96
  void setWindowTitle(String title) {
    cvRunArena((arena) {
      cvRun(() => CFFI.Window_SetTitle(
          name.toNativeUtf8(allocator: arena).cast(), title.toNativeUtf8(allocator: arena).cast()));
    });
  }

  /// IMShow displays an image Mat in the specified window.
  /// This function should be followed by the WaitKey function which displays
  /// the image for specified milliseconds. Otherwise, it won't display the image.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga453d42fe4cb60e5723281a89973ee563
  void imshow(Mat img) {
    cvRunArena((arena) {
      cvRun(() => CFFI.Window_IMShow(name.toNativeUtf8(allocator: arena).cast(), img.ref));
    });
  }

  /// WaitKey waits for a pressed key.
  /// This function is the only method in OpenCV's HighGUI that can fetch
  /// and handle events, so it needs to be called periodically
  /// for normal event processing
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d7/dfc/group__highgui.html#ga5628525ad33f52eab17feebcfba38bd7
  int waitKey(int delay) {
    return cvRunArena<int>((arena) {
      final ret = arena<ffi.Int>();
      cvRun(() => CFFI.Window_WaitKey(delay, ret));
      return ret.value;
    });
  }

  /// MoveWindow moves window to the specified position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga8d86b207f7211250dbe6e28f76307ffb
  void moveWindow(int x, int y) {
    cvRunArena((arena) {
      cvRun(() => CFFI.Window_Move(name.toNativeUtf8(allocator: arena).cast(), x, y));
    });
  }

  /// ResizeWindow resizes window to the specified size.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga9e80e080f7ef33f897e415358aee7f7e
  void resizeWindow(int width, int height) {
    cvRunArena((arena) {
      cvRun(() => CFFI.Window_Resize(name.toNativeUtf8(allocator: arena).cast(), width, height));
    });
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
  Rect selectROI(Mat img) {
    return cvRunArena<Rect>((arena) {
      final result = arena<cvg.Rect>();
      cvRun(() => CFFI.Window_SelectROI(name.toNativeUtf8(allocator: arena).cast(), img.ref, result));
      return Rect.fromNative(result.ref);
    });
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
  VecRect selectROIs(Mat img) {
    return cvRunArena<VecRect>((arena) {
      final result = arena<cvg.VecRect>();
      cvRun(() => CFFI.Window_SelectROIs(name.toNativeUtf8(allocator: arena).cast(), img.ref, result));
      return VecRect.fromVec(result.ref);
    });
  }

  String name;
  // https://stackoverflow.com/a/48055987/18539998
  bool get isOpen {
    final ret = getWindowProperty(WindowPropertyFlags.WND_PROP_AUTOSIZE);
    return ret != -1;
  }
}

/// WaitKey that is not attached to a specific Window.
/// Only use when no Window exists in your application, e.g. command line app.
int waitKey(int delay) {
  return cvRunArena<int>((arena) {
    final ret = arena<ffi.Int>();
    cvRun(() => CFFI.Window_WaitKey(delay, ret));
    return ret.value;
  });
}

class Trackbar {
  Trackbar(this.name, this.parent, this.max, {int? value}) {
    cvRunArena((arena) {
      cvRun(
        () => CFFI.Trackbar_Create(parent.name.toNativeUtf8(allocator: arena).cast(),
            name.toNativeUtf8(allocator: arena).cast(), max),
      );
      if (value != null) {
        pos = value;
      }
    });
  }

  /// pos returns the trackbar position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga122632e9e91b9ec06943472c55d9cda8
  int get pos {
    return cvRunArena<int>((arena) {
      final result = arena<ffi.Int>();
      cvRun(() => CFFI.Trackbar_GetPos(parent.name.toNativeUtf8(allocator: arena).cast(),
          name.toNativeUtf8(allocator: arena).cast(), result));
      return result.value;
    });
  }

  /// pos sets the trackbar position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga67d73c4c9430f13481fd58410d01bd8d
  set pos(int pos) {
    cvRunArena((arena) {
      cvRun(
        () => CFFI.Trackbar_SetPos(
          parent.name.toNativeUtf8(allocator: arena).cast(),
          name.toNativeUtf8(allocator: arena).cast(),
          pos,
        ),
      );
    });
  }

  /// SetMin sets the trackbar minimum position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#gabe26ffe8d2b60cc678895595a581b7aa
  set minPos(int pos) {
    cvRunArena((arena) {
      cvRun(
        () => CFFI.Trackbar_SetMin(
          parent.name.toNativeUtf8(allocator: arena).cast(),
          name.toNativeUtf8(allocator: arena).cast(),
          pos,
        ),
      );
    });
  }

  /// SetMax sets the trackbar maximum position.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/dfc/group__highgui.html#ga7e5437ccba37f1154b65210902fc4480
  set maxPos(int pos) {
    cvRunArena((arena) {
      cvRun(
        () => CFFI.Trackbar_SetMax(
          parent.name.toNativeUtf8(allocator: arena).cast(),
          name.toNativeUtf8(allocator: arena).cast(),
          pos,
        ),
      );
    });
  }

  String name;
  Window parent;
  int max;
}

/// destroy all windows.
void destroyAllWindows() {
  cvRun(() => CFFI.destroyAllWindows());
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
