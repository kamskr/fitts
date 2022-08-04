import 'package:app_ui/src/widgets/app_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/helpers.dart';

void main() {
  group('AppChartCard', () {
    const values = <double>[1, 2, 3, 4, 5, 6];
    const labels = ['a', 'b', 'c', 'd', 'e', 'f'];

    testWidgets('renders properly with only values.', (tester) async {
      await tester.pumpIt(
        SizedBox(
          height: 200,
          width: 200,
          child: AppChartCard(
            values: values,
          ),
        ),
      );

      expect(find.byType(AppChartCard), findsOneWidget);
    });

    testWidgets('renders properly with provided labels.', (tester) async {
      await tester.pumpIt(
        SizedBox(
          height: 200,
          width: 200,
          child: AppChartCard(
            values: const [
              1000,
              1000,
              1000,
              1000,
              1000,
              1000,
            ],
            labels: labels,
          ),
        ),
      );

      expect(find.byType(AppChartCard), findsOneWidget);
    });

    testWidgets(
      'throws assertion error if provided labels count != 6.',
      (tester) async {
        expect(
          () {
            Material(
              child: AppChartCard(
                values: values,
                labels: const [...labels, 'a', 'b'],
              ),
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'throws assertion error if provided values count != 6.',
      (tester) async {
        expect(
          () {
            Material(
              child: AppChartCard(
                values: const [...values, 1, 2],
                labels: labels,
              ),
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('renders header properly.', (tester) async {
      const headerText = 'chartHeader';
      await tester.pumpIt(
        SizedBox(
          height: 200,
          width: 200,
          child: AppChartCard(
            values: values,
            header: const Text(headerText),
          ),
        ),
      );

      expect(find.text(headerText), findsOneWidget);
    });
    testWidgets('renders footer properly.', (tester) async {
      const footerText = 'chartFooter';
      await tester.pumpIt(
        SizedBox(
          height: 200,
          width: 200,
          child: AppChartCard(
            values: values,
            footer: const Text(footerText),
          ),
        ),
      );

      expect(find.text(footerText), findsOneWidget);
    });
  });
}
