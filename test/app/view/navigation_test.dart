import 'package:fitts/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Navigation', () {
    group('page', () {
      testWidgets('is routable.', (tester) async {
        expect(Navigation.page(), isA<MaterialPage<void>>());
      });

      //   testWidgets('renders properly.', (tester) async {
      //     await tester.pumpApp(const Navigation());

      //     expect(find.byType(Navigation), findsOneWidget);
      //   });
      // });

      // group('Navigation state', () {
      //   testWidgets('Shows initial page HomePage', (tester) async {
      //     await tester.pumpApp(
      //       const Navigation(),
      //     );

      //     await tester.pumpAndSettle();

      //     expect(
      //       find.byType(HomePage),
      //       findsOneWidget,
      //     );
      //   });
      //   testWidgets('Changes page on bottom navbar item click', (tester)
      //async {
      //     await tester.pumpApp(
      //       const Navigation(),
      //     );

      //     await tester.pumpAndSettle();

      //     expect(
      //       find.byType(HomePage),
      //       findsOneWidget,
      //     );

      //     final lastMenuItem = find.text('Plans');
      //     await tester.tap(lastMenuItem);
      //     await tester.pumpAndSettle();

      //     expect(
      //       find.byType(HomePage),
      //       findsNothing,
      //     );
      //   });
    });
  });
}
