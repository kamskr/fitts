import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers/helpers.dart';

void main() {
  group('AppButton.primary()', () {
    testWidgets('is built if no onPressed is provided',
        (WidgetTester tester) async {
      const button = AppButton.primary(child: Text('T'));
      await tester.pumpIt(button);
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('has provided child', (WidgetTester tester) async {
      final button =
          AppButton.primary(child: const Text('T'), onPressed: () {});
      await tester.pumpIt(button);
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

        final widget = AppButton.primary(
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
  group('AppButton.outlined()', () {
    testWidgets('is built if no onPressed is provided',
        (WidgetTester tester) async {
      const button = AppButton.outlined(child: Text('T'));
      await tester.pumpIt(button);
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('has provided child', (WidgetTester tester) async {
      final button =
          AppButton.outlined(child: const Text('T'), onPressed: () {});
      await tester.pumpIt(button);
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

        final widget = AppButton.outlined(
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
  group('AppButton.gradient()', () {
    testWidgets('is built if no onPressed is provided',
        (WidgetTester tester) async {
      const button = AppButton.gradient(child: Text('T'));
      await tester.pumpIt(button);
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('has provided child', (WidgetTester tester) async {
      final button =
          AppButton.gradient(child: const Text('T'), onPressed: () {});
      await tester.pumpIt(button);
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

        final widget = AppButton.gradient(
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
  group('AppButton.accentGradient()', () {
    testWidgets(
        'AppButton.accentGradient() is built if no onPressed is provided',
        (WidgetTester tester) async {
      final button = AppButton.accentGradient(child: const Text('T'));
      await tester.pumpIt(button);
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('has provided child', (WidgetTester tester) async {
      final button =
          AppButton.accentGradient(child: const Text('T'), onPressed: () {});
      await tester.pumpIt(button);
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

        final widget = AppButton.accentGradient(
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
