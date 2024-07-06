// ignore_for_file: constant_identifier_names

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/cv_vec.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/vec.dart';
import '../g/imgproc.g.dart' as cvg;
import '../g/types.g.dart' as cvt;
import '../native_lib.dart' show cimgproc;
import 'subdiv2d.dart';

/// Async version of [Subdiv2D]
extension Subdiv2DAsync on Subdiv2D {
  static Future<Subdiv2D> emptyAsync() async => cvRunAsync(
        cimgproc.Subdiv2D_NewEmpty_Async,
        (c, p) => c.complete(Subdiv2D.fromPointer(p.cast<cvg.Subdiv2D>())),
      );

  static Future<Subdiv2D> fromRectAsync(Rect rect) async => cvRunAsync(
        (callback) => cimgproc.Subdiv2D_NewWithRect_Async(rect.ref, callback),
        (c, p) => c.complete(Subdiv2D.fromPointer(p.cast<cvg.Subdiv2D>())),
      );

  /// Returns the edge destination.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#aee192f95bf19c74619641496c457586d
  Future<(int rval, Point2f dstpt)> edgeDstAsync(int edge) async =>
      cvRunAsync2((callback) => cimgproc.Subdiv2D_EdgeDst_Async(ref, edge, callback), (completer, p, p1) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        completer.complete((rval, Point2f.fromPointer(p1.cast<cvg.Point2f>())));
      });

  /// Returns the edge origin.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a5563e3cae0a9b95df63e72f0c12f9389
  Future<(int rval, Point2f orgpt)> edgeOrgAsync(int edge) async =>
      cvRunAsync2((callback) => cimgproc.Subdiv2D_EdgeOrg_Async(ref, edge, callback), (completer, p, p1) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        completer.complete((rval, Point2f.fromPointer(p1.cast<cvg.Point2f>())));
      });

  /// Finds the subdivision vertex closest to the given point.
  ///
  /// The function is another function that locates the input point within the subdivision.
  /// It finds the subdivision vertex that is the closest to the input point.
  /// It is not necessarily one of vertices of the facet containing the input point,
  /// though the facet (located using locate() ) is used as a starting point.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a3ec256af000e129e08eb5f269ccdeb0f
  Future<(int rval, Point2f nearestPt)> findNearestAsync(Point2f pt) async =>
      cvRunAsync2((callback) => cimgproc.Subdiv2D_FindNearest_Async(ref, pt.ref, callback), (completer, p, p1) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        completer.complete((rval, Point2f.fromPointer(p1.cast<cvg.Point2f>())));
      });

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
  Future<int> getEdgeAsync(int edge, int nextEdgeType) async => cvRunAsync(
        (callback) => cimgproc.Subdiv2D_GetEdge_Async(ref, edge, nextEdgeType, callback),
        intCompleter,
      );

  /// Returns a list of all edges.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#ab527c11e9938eed53cf9c790afa9416d
  Future<VecVec4f> getEdgeListAsync() async => cvRunAsync1(
        (callback) => cimgproc.Subdiv2D_GetEdgeList_Async(ref, callback),
        (completer, p) => completer.complete(VecVec4f.fromPointer(p.cast<cvt.VecVec4f>())),
      );

  /// Returns a list of the leading edge ID connected to each triangle.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a2d02a1d66ef7f8f267beb549cb2823f1
  Future<VecInt> getLeadingEdgeListAsync() async =>
      cvRunAsync((callback) => cimgproc.Subdiv2D_GetLeadingEdgeList_Async(ref, callback), vecIntCompleter);

  /// Returns a list of all triangles.
  ///
  /// The function gives each triangle as a 6 numbers vector, where each two are one of the triangle vertices.
  /// i.e. p1_x = v[0], p1_y = v[1], p2_x = v[2], p2_y = v[3], p3_x = v[4], p3_y = v[5].
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a26bfe32209bc8ae9ecc53e93da01e466
  Future<VecVec6f> getTriangleListAsync() async => cvRunAsync1(
        (callback) => cimgproc.Subdiv2D_GetTriangleList_Async(ref, callback),
        (completer, p) => completer.complete(VecVec6f.fromPointer(p.cast<cvt.VecVec6f>())),
      );

  /// Returns vertex location from vertex ID.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a5297daca30f90d1e6d0cc5a75ba76351
  Future<(Point2f rval, int firstEdge)> getVertexAsync(int vertex) async =>
      cvRunAsync2((callback) => cimgproc.Subdiv2D_GetVertex_Async(ref, vertex, callback), (c, p, p1) {
        final firstEdge = p1.cast<ffi.Int>().value;
        calloc.free(p1);
        c.complete((Point2f.fromPointer(p.cast<cvg.Point2f>()), firstEdge));
      });

  /// Returns a list of all Voronoi facets.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a3a9e080423475be056a79da4c04741ea
  Future<(VecVecPoint2f facetList, VecPoint2f facetCenters)> getVoronoiFacetListAsync(VecInt idx) async =>
      cvRunAsync2(
        (callback) => cimgproc.Subdiv2D_GetVoronoiFacetList_Async(ref, idx.ref, callback),
        (completer, p, p1) => completer.complete(
          (
            VecVecPoint2f.fromPointer(p.cast<cvg.VecVecPoint2f>()),
            VecPoint2f.fromPointer(p1.cast<cvg.VecPoint2f>())
          ),
        ),
      );

  /// Creates a new empty Delaunay subdivision.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#ae4a3d65e798c46fd6ce64370f24b0287
  Future<void> initDelaunayAsync(Rect rect) async => cvRunAsync0(
        (callback) => cimgproc.Subdiv2D_InitDelaunay_Async(ref, rect.ref, callback),
        (c) => c.complete(),
      );

  /// Insert multiple points into a Delaunay triangulation.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a37223a499032ef57364f1372ad0c9c2e
  Future<int> insertAsync(Point2f pt) async =>
      cvRunAsync((callback) => cimgproc.Subdiv2D_Insert_Async(ref, pt.ref, callback), intCompleter);

  /// Insert a single point into a Delaunay triangulation.
  ///
  /// The function locates the input point within the subdivision and gives one of the triangle edges or vertices.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a18a6c9999210d769538297d843c613f2
  Future<void> insertVecAsync(VecPoint2f pv) async => cvRunAsync0(
        (callback) => cimgproc.Subdiv2D_InsertVec_Async(ref, pv.ref, callback),
        (c) => c.complete(),
      );

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
  Future<(int rval, int edge, int vertex)> locateAsync(Point2f pt) async =>
      cvRunAsync3((callback) => cimgproc.Subdiv2D_Locate_Async(ref, pt.ref, callback), (completer, p, p1, p2) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        final edge = p1.cast<ffi.Int>().value;
        calloc.free(p1);
        final vertex = p2.cast<ffi.Int>().value;
        calloc.free(p2);
        completer.complete((rval, edge, vertex));
      });

  /// Returns next edge around the edge origin.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#a36ebf478e2546615c2db457106393acb
  Future<int> nextEdgeAsync(int edge) async =>
      cvRunAsync((callback) => cimgproc.Subdiv2D_NextEdge_Async(ref, edge, callback), intCompleter);

  /// Returns another edge of the same quad-edge.
  ///
  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#aa1179507f651b67c22e06517fbc6a145
  Future<int> rotateEdgeAsync(int edge, int rotate) async =>
      cvRunAsync((callback) => cimgproc.Subdiv2D_RotateEdge_Async(ref, edge, rotate, callback), intCompleter);

  /// https://docs.opencv.org/4.x/df/dbf/classcv_1_1Subdiv2D.html#aabbb10b8d5b0311b7e22040fc0db56b4
  Future<int> symEdgeAsync(int edge) async =>
      cvRunAsync((callback) => cimgproc.Subdiv2D_SymEdge_Async(ref, edge, callback), intCompleter);
}
