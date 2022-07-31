import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Navigation', () {
    group('page', () {
      testWidgets('is routable.', (tester) async {
        expect(Navigation.page(), isA<MaterialPage>());
      });

      testWidgets('renders properly.', (tester) async {
        await tester.pumpApp(const Navigation());

        expect(find.byType(Navigation), findsOneWidget);
      });
    });

    group('Navigation state', () {
      testWidgets('Shows initial page HomePage', (tester) async {
        await tester.pumpApp(
          const Navigation(),
        );

        await tester.pumpAndSettle();

        expect(
          find.byType(HomePage),
          findsOneWidget,
        );
      });
      testWidgets('Changes page on bottom navbar item click', (tester) async {
        await tester.pumpApp(
          const Navigation(),
        );

        await tester.pumpAndSettle();

        expect(
          find.byType(HomePage),
          findsOneWidget,
        );

        final lastMenuItem = find.text('Stats');
        await tester.tap(lastMenuItem);
        await tester.pumpAndSettle();

        expect(
          find.byType(HomePage),
          findsNothing,
        );
      });
    });
  });
}
