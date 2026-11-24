// A smoke test for the example UI. It builds the widget tree without `main()`, so `initDartcv()`
// is not awaited here; that only matters on the web, where the native-assets hooks did not run.

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:dartcv_example/main.dart';

void main() {
  testWidgets('renders the pick and process buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Pick Image'), findsOneWidget);
    expect(find.text('Process'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });
}
