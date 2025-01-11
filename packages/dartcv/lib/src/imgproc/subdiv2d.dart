// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names
library cv.imgproc.subdiv2d;

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/cv_vec.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/vec.dart';
import '../g/imgproc.g.dart' as cvg;
import '../native_lib.dart' show cimgproc;

class Subdiv2D extends CvStruct<cvg.Subdiv2D> {
  Subdiv2D._(cvg.Subdiv2DPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Subdiv2D.fromPointer(cvg.Subdiv2DPtr ptr) => Subdiv2D._(ptr);

  factory Subdiv2D.empty() {
    final p = calloc<cvg.Subdiv2D>();
    cvRun(() => cimgproc.cv_Subdiv2D_create(p));
    return Subdiv2D._(p);
  }

  factory Subdiv2D.fromRect(Rect rect) {
    final p = calloc<cvg.Subdiv2D>();
    cvRun(() => cimgproc.cv_Subdiv2D_create_1(rect.ref, p));
    return Subdiv2D._(p);
  }

  static final finalizer = OcvFinalizer<cvg.Subdiv2DPtr>(cimgproc.addresses.cv_Subdiv2D_close);

  void dispose() {
    finalizer.detach(this);
    cimgproc.cv_Subdiv2D_close(ptr);
  }

  /// Returns the edge destination.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#aee192f95bf19c74619641496c457586d
  (int rval, Point2f dstpt) edgeDst(int edge) {
    final pp = calloc<cvg.CvPoint2f>();
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_edgeDst(ref, edge, pp, p, ffi.nullptr));
    final rval = (p.value, Point2f.fromPointer(pp));
    calloc.free(p);
    return rval;
  }

  /// Returns the edge origin.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a5563e3cae0a9b95df63e72f0c12f9389
  (int rval, Point2f orgpt) edgeOrg(int edge) {
    final pp = calloc<cvg.CvPoint2f>();
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_edgeOrg(ref, edge, pp, p, ffi.nullptr));
    final rval = (p.value, Point2f.fromPointer(pp));
    calloc.free(p);
    return rval;
  }

  /// Finds the subdivision vertex closest to the given point.
  ///
  /// The function is another function that locates the input point within the subdivision.
  /// It finds the subdivision vertex that is the closest to the input point.
  /// It is not necessarily one of vertices of the facet containing the input point,
  /// though the facet (located using locate() ) is used as a starting point.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a3ec256af000e129e08eb5f269ccdeb0f
  (int rval, Point2f nearestPt) findNearest(Point2f pt) {
    final pp = calloc<cvg.CvPoint2f>();
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_findNearest(ref, pt.ref, pp, p, ffi.nullptr));
    final rval = (p.value, Point2f.fromPointer(pp));
    calloc.free(p);
    return rval;
  }

  /// Returns one of the edges related to the given edge.
  ///
  /// [nextEdgeType] : Parameter specifying which of the related edges to return.
  /// The following values are possible:
  ///
  /// - [NEXT_AROUND_ORG] next around the edge origin ( eOnext on the picture below if e is the input edge)
  /// - [NEXT_AROUND_DST] next around the edge vertex ( eDnext )
  /// - [PREV_AROUND_ORG] previous around the edge origin (reversed eRnext )
  /// - [PREV_AROUND_DST] previous around the edge destination (reversed eLnext )
  /// - [NEXT_AROUND_LEFT] next around the left facet ( eLnext )
  /// - [NEXT_AROUND_RIGHT] next around the right facet ( eRnext )
  /// - [PREV_AROUND_LEFT] previous around the left facet (reversed eOnext )
  /// - [PREV_AROUND_RIGHT] previous around the right facet (reversed eDnext )
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#af73f08576709bad7a36f8f8e5fc43c84
  int getEdge(int edge, int nextEdgeType) {
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_getEdge(ref, edge, nextEdgeType, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Returns a list of all edges.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#ab527c11e9938eed53cf9c790afa9416d
  List<Vec4f> getEdgeList() {
    final pv = calloc<ffi.Pointer<cvg.Vec4f>>();
    final psize = calloc<ffi.Size>();
    cvRun(() => cimgproc.cv_Subdiv2D_getEdgeList(ref, pv, psize, ffi.nullptr));
    final rval = List.generate(psize.value, (i) {
      final v = pv.value[i];
      return Vec4f(v.val1, v.val2, v.val3, v.val4);
    });
    calloc.free(psize);
    calloc.free(pv);
    return rval;
  }

  /// Returns a list of the leading edge ID connected to each triangle.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a2d02a1d66ef7f8f267beb549cb2823f1
  VecI32 getLeadingEdgeList() {
    final pv = VecI32();
    cvRun(() => cimgproc.cv_Subdiv2D_getLeadingEdgeList(ref, pv.ptr, ffi.nullptr));
    return pv;
  }

  /// Returns a list of all triangles.
  ///
  /// The function gives each triangle as a 6 numbers vector, where each two are one of the triangle vertices.
  /// i.e. p1_x = v[0], p1_y = v[1], p2_x = v[2], p2_y = v[3], p3_x = v[4], p3_y = v[5].
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a26bfe32209bc8ae9ecc53e93da01e466
  List<Vec6f> getTriangleList() {
    final pv = calloc<ffi.Pointer<cvg.Vec6f>>();
    final psize = calloc<ffi.Size>();
    cvRun(() => cimgproc.cv_Subdiv2D_getTriangleList(ref, pv, psize, ffi.nullptr));
    final rval = List.generate(psize.value, (i) {
      final v = pv.value[i];
      return Vec6f(v.val1, v.val2, v.val3, v.val4, v.val5, v.val6);
    });
    calloc.free(psize);
    calloc.free(pv);
    return rval;
  }

  /// Returns vertex location from vertex ID.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a5297daca30f90d1e6d0cc5a75ba76351
  (Point2f rval, int firstEdge) getVertex(int vertex) {
    final pp = calloc<cvg.CvPoint2f>();
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_getVertex(ref, vertex, p, pp, ffi.nullptr));
    final rval = (Point2f.fromPointer(pp), p.value);
    calloc.free(p);
    return rval;
  }

  /// Returns a list of all Voronoi facets.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a3a9e080423475be056a79da4c04741ea
  (VecVecPoint2f facetList, VecPoint2f facetCenters) getVoronoiFacetList(VecI32 idx) {
    final pf = VecVecPoint2f();
    final pfc = VecPoint2f();
    cvRun(() => cimgproc.cv_Subdiv2D_getVoronoiFacetList(ref, idx.ref, pf.ptr, pfc.ptr, ffi.nullptr));
    return (pf, pfc);
  }

  /// Creates a new empty Delaunay subdivision.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#ae4a3d65e798c46fd6ce64370f24b0287
  void initDelaunay(Rect rect) {
    cvRun(() => cimgproc.cv_Subdiv2D_initDelaunay(ref, rect.ref, ffi.nullptr));
  }

  /// Insert multiple points into a Delaunay triangulation.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a37223a499032ef57364f1372ad0c9c2e
  int insert(Point2f pt) {
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_insert(ref, pt.ref, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Insert a single point into a Delaunay triangulation.
  ///
  /// The function locates the input point within the subdivision and gives one of the triangle edges or vertices.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a18a6c9999210d769538297d843c613f2
  void insertVec(VecPoint2f pv) {
    cvRun(() => cimgproc.cv_Subdiv2D_insertVec(ref, pv.ref, ffi.nullptr));
  }

  /// Returns the location of a point within a Delaunay triangulation.
  ///
  // ignore: comment_references
  /// [rval] an integer which specify one of the following five cases for point location:
  ///
  ///   - The point falls into some facet. The function returns [PTLOC_INSIDE] and edge will contain one of edges of the facet.
  ///   - The point falls onto the edge. The function returns [PTLOC_ON_EDGE] and edge will contain this edge.
  ///   - The point coincides with one of the subdivision vertices. The function returns [PTLOC_VERTEX] and vertex will contain a pointer to the vertex.
  ///   - The point is outside the subdivision reference rectangle. The function returns [PTLOC_OUTSIDE_RECT] and no pointers are filled.
  ///   - One of input arguments is invalid. A runtime error is raised or, if silent or "parent" error processing mode is selected, [PTLOC_ERROR] is returned.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#aec8f1fd5a802f62faa97520b465897d7
  (int rval, int edge, int vertex) locate(Point2f pt) {
    final pedge = calloc<ffi.Int>();
    final pvertex = calloc<ffi.Int>();
    final prval = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_locate(ref, pt.ref, pedge, pvertex, prval, ffi.nullptr));
    final rval = (prval.value, pedge.value, pvertex.value);
    calloc.free(pedge);
    calloc.free(pvertex);
    calloc.free(prval);
    return rval;
  }

  /// Returns next edge around the edge origin.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a36ebf478e2546615c2db457106393acb
  int nextEdge(int edge) {
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_nextEdge(ref, edge, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// Returns another edge of the same quad-edge.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#aa1179507f651b67c22e06517fbc6a145
  int rotateEdge(int edge, int rotate) {
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_rotateEdge(ref, edge, rotate, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#aabbb10b8d5b0311b7e22040fc0db56b4
  int symEdge(int edge) {
    final p = calloc<ffi.Int>();
    cvRun(() => cimgproc.cv_Subdiv2D_symEdge(ref, edge, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  @override
  cvg.Subdiv2D get ref => ptr.ref;

  static const int NEXT_AROUND_ORG = 0x00;
  static const int NEXT_AROUND_DST = 0x22;
  static const int PREV_AROUND_ORG = 0x11;
  static const int PREV_AROUND_DST = 0x33;
  static const int NEXT_AROUND_LEFT = 0x13;
  static const int NEXT_AROUND_RIGHT = 0x31;
  static const int PREV_AROUND_LEFT = 0x20;
  static const int PREV_AROUND_RIGHT = 0x02;

  static const int PTLOC_ERROR = -2;
  static const int PTLOC_OUTSIDE_RECT = -1;
  static const int PTLOC_INSIDE = 0;
  static const int PTLOC_VERTEX = 1;
  static const int PTLOC_ON_EDGE = 2;
}
