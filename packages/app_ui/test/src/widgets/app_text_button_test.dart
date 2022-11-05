import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/helpers.dart';

void main() {
  group('AppTextButton', () {
    testWidgets(' is built if no onPressed is provided',
        (WidgetTester tester) async {
      const button = AppTextButton(child: Text('T'));
      await tester.pumpIt(button);
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('has provided child', (WidgetTester tester) async {
      await tester.pumpIt(
        Builder(
          builder: (context) => AppTextButton(
            textColor: context.appColorScheme.black100,
            child: const Text('T'),
            onPressed: () {},
          ),
        ),
      );
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets(
      'fires provided function',
      (WidgetTester tester) async {
        var testFlag = false;

        void changeFlagToTrue() {
          testFlag = true;
        }

        final widget = AppTextButton(
          onPressed: changeFlagToTrue,
          child: const Text('T'),
        );

        await tester.pumpIt(widget);
        final button = find.text('T');
        expect(button, findsOneWidget);
        await tester.tap(button);
        await tester.pump();
        expect(testFlag, isTrue);
      },
    );
  });
}
