import 'package:fitts/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('OnboardingOnboardingWelcomePage', () {
    testWidgets('is routable.', (tester) async {
      expect(OnboardingWelcomePage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders properly.', (tester) async {
      await tester.pumpApp(const OnboardingWelcomePage());

      expect(find.byType(OnboardingWelcomePage), findsOneWidget);
    });

    testWidgets('redirects to SignUpPage on SignUp button pressed.',
        (tester) async {
      await tester.pumpApp(
        const OnboardingWelcomePage(),
      );

      final continueButton = find.byKey(
        const Key('onboardingWelcomePage_continueButton'),
      );

      expect(continueButton, findsOneWidget);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      /// Ensure [OnboardingPage] presence.
      expect(find.byType(OnboardingPage), findsOneWidget);
    });
  });
}
