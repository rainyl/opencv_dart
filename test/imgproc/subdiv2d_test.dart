import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  final src = cv.Mat.fromScalar(400, 400, cv.MatType.CV_8UC3, cv.Scalar.white);
  final points = [
    cv.Point2f(23, 45),
    cv.Point2f(243, 145),
    cv.Point2f(308, 25),
    cv.Point2f(180, 230),
    cv.Point2f(343, 145),
    cv.Point2f(108, 25),
  ];
  for (var pt in points) {
    cv.circle(src, cv.Point(pt.x.toInt(), pt.y.toInt()), 1, cv.Scalar.black, thickness: 2);
  }

  test("cv.Subdiv2D", () {
    final subdiv = cv.Subdiv2D.fromRect(cv.Rect(0, 0, src.width, src.height));
    subdiv.insertVec(points.cvd);

    final triangleList = subdiv.getTriangleList();
    expect(triangleList.length, greaterThan(0));
    for (var tri in triangleList) {
      final p1 = cv.Point(tri.val1.toInt(), tri.val2.toInt());
      final p2 = cv.Point(tri.val3.toInt(), tri.val4.toInt());
      final p3 = cv.Point(tri.val5.toInt(), tri.val6.toInt());
      cv.line(src, p1, p2, cv.Scalar.red, thickness: 1);
      cv.line(src, p1, p3, cv.Scalar.red, thickness: 1);
      cv.line(src, p2, p3, cv.Scalar.red, thickness: 1);
    }
    // cv.imwrite("subdiv2d.png", src);
    // final win = cv.Window("Subdiv2D");
    // win.imshow(src);
    // win.waitKey(0);
    // cv.destroyAllWindows();
    subdiv.dispose();
  });

  test('cv.Subdiv2D.empty', () {
    final sub1 = cv.Subdiv2D.empty();
    sub1.initDelaunay(cv.Rect(0, 0, src.width, src.height));
    sub1.insert(cv.Point2f(241, 241));
  });

  test('cv.Subdiv2D others', () {
    final subdiv = cv.Subdiv2D.fromRect(cv.Rect(0, 0, src.width, src.height));
    subdiv.insertVec(points.cvd);

    {
      final (rval, pt) = subdiv.edgeDst(1);
      expect(rval, 0);
      expect(pt, cv.Point2f(0, 0));
    }

    {
      final (rval, pt) = subdiv.edgeOrg(1);
      expect(rval, 0);
      expect(pt, cv.Point2f(0, 0));
    }

    {
      final (rval, pt) = subdiv.findNearest(cv.Point2f(241, 241));
      expect(rval, 7);
      expect(pt, cv.Point2f(180, 230));
    }

    {
      final edge = subdiv.getEdge(1, cv.Subdiv2D.NEXT_AROUND_LEFT);
      expect(edge, 1);
    }

    {
      final edges = subdiv.getEdgeList();
      expect(edges.length, greaterThan(0));
    }

    {
      final r = subdiv.getLeadingEdgeList();
      expect(r.length, greaterThan(0));
    }

    {
      final (pt, v) = subdiv.getVertex(0);
      expect(pt, cv.Point2f(0, 0));
      expect(v, 0);
    }

    {
      final (fl, fc) = subdiv.getVoronoiFacetList([0, 1].i32);
      expect(fl.length, greaterThan(0));
      expect(fc.length, greaterThan(0));
    }

    {
      final (rval, edge, vertex) = subdiv.locate(cv.Point2f(241, 241));
      expect(rval, cv.Subdiv2D.PTLOC_INSIDE);
      expect(edge, 72);
      expect(vertex, 0);
    }

    {
      final nextEdge = subdiv.nextEdge(0);
      expect(nextEdge, 0);
      final rEdge = subdiv.rotateEdge(0, 90);
      expect(rEdge, 2);
      final sEdge = subdiv.symEdge(0);
      expect(sEdge, 2);
    }
  });
}
