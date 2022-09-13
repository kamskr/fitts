import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

void main() {
  group('AppGap', () {
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.xxxs(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.xxxs);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.xxs(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.xxs);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.xs(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.xs);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.sm(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.sm);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.md(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.md);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.lg(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.lg);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.xlg(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.xlg);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.xxlg(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.xxlg);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap.xxxlg(key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.xxxlg);
    });
    testWidgets('AppGap creates correct gap size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                AppGap(AppGapSize.lg, key: Key('test')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(gap.mainAxisExtent, AppSpacing.lg);
    });
  });
}
