import 'package:app_ui/app_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_widget_tester.dart';

void main() {
  group('AppTextField', () {
    testWidgets('renders properly', (WidgetTester tester) async {
      const field = AppTextField(labelText: 'T');
      await tester.pumpIt(field);
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}
