import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_widget_tester.dart';

void main() {
  group('AppTextField', () {
    const initialValue = 'Initial';
    const labelText = 'Label';
    const errorText = 'Error';
    const hintText = 'Hint';

    testWidgets('renders properly', (WidgetTester tester) async {
      const field = AppTextField();
      await tester.pumpIt(field);
      final foundField = find.byType(AppTextField);
      expect(foundField, findsOneWidget);
    });

    testWidgets('executes probided function on change',
        (WidgetTester tester) async {
      var changedValue = '';
      final field = AppTextField(
        onChanged: (value) {
          changedValue = value;
        },
      );
      await tester.pumpIt(field);
      final foundField = find.byType(AppTextField);
      await tester.enterText(foundField, 'test');
      await tester.pump();
      expect(foundField, findsOneWidget);
      expect(changedValue, equals('test'));
    });

    testWidgets('renders initial value properly', (WidgetTester tester) async {
      const field = AppTextField(initialValue: initialValue);
      await tester.pumpIt(field);
      final foundField = find.text(initialValue);
      expect(foundField, findsOneWidget);
    });
    testWidgets('renders label properly', (WidgetTester tester) async {
      const field = AppTextField(labelText: labelText);
      await tester.pumpIt(field);
      final foundField = find.text(labelText);
      expect(foundField, findsOneWidget);
    });
    testWidgets('renders errorText properly', (WidgetTester tester) async {
      const field = AppTextField(errorText: errorText);
      await tester.pumpIt(field);
      final foundField = find.text(errorText);
      expect(foundField, findsOneWidget);
    });
    testWidgets('renders hintText properly', (WidgetTester tester) async {
      const field = AppTextField(hintText: hintText);
      await tester.pumpIt(field);
      final foundField = find.text(hintText);
      expect(foundField, findsOneWidget);
    });

    testWidgets('AppTextField defaults to AppTextFieldType.text',
        (WidgetTester tester) async {
      const field = AppTextField();
      await tester.pumpIt(field);
      final foundField = tester.widget<AppTextField>(find.byType(AppTextField));
      expect(foundField.inputType, AppTextFieldType.text);
    });
  });
}
