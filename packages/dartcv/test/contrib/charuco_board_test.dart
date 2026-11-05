import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.CharucoBoard', () {
    final dict = cv.ArucoDictionary.predefined(cv.PredefinedDictionaryType.DICT_6X6_250);
    final board = cv.CharucoBoard.create((5, 7), 0.04, 0.02, dict);

    expect(board.chessboardSize, cv.Size(5, 7));
    expect(board.squareLength, closeTo(0.04, 1e-6));
    expect(board.markerLength, closeTo(0.02, 1e-6));
    expect(board.chessboardCorners.length, 24);
    expect(board.ids.length, 17);
    expect(board.objPoints.length, 17);

    final img = board.generateImage((600, 800), marginSize: 12, borderBits: 1);
    expect(img.isEmpty, false);
    expect(img.cols, 600);
    expect(img.rows, 800);

    expect(board.legacyPattern, false);
    board.legacyPattern = true;
    expect(board.legacyPattern, true);

    final collinear = cv.VecI32.fromList([0, 1]);
    expect(board.checkCharucoCornersCollinear(collinear), true);

    img.dispose();
    collinear.dispose();
    board.dispose();
    dict.dispose();
  });

  test('cv.CharucoBoard with custom ids', () {
    final dict = cv.ArucoDictionary.predefined(cv.PredefinedDictionaryType.DICT_6X6_250);
    final ids = cv.VecI32.fromList(List.generate(17, (i) => i + 100));
    final board = cv.CharucoBoard.create((5, 7), 0.04, 0.02, dict, ids: ids);

    final boardIds = board.ids;
    expect(boardIds.length, 17);
    expect(boardIds[0], 100);
    expect(boardIds[16], 116);

    boardIds.dispose();
    board.dispose();
    ids.dispose();
    dict.dispose();
  });
}
