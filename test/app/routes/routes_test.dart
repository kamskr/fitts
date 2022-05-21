import 'package:api_models/api_models.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/profile_setup_wizard/profile_setup_wizard.dart';
import 'package:fitts/welcome/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserProfile extends Mock implements UserProfile {}

void main() {
  group('onGenerateAppViewPages', () {
    test('returns [WelcomePage] when not authenticated', () {
      expect(
        onGenerateAppViewPages(
            AppState.initial(
              userProfile: UserProfile.empty,
              status: AppStatus.unauthenticated,
            ),
            []),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<WelcomePage>(),
          )
        ],
      );
    });

    test(
        'returns [ProfileSetupWizardPage] when authenticated '
        'and isNewUser == true', () {
      expect(
        onGenerateAppViewPages(
            AppState.initial(
              userProfile: UserProfile.empty,
              status: AppStatus.onboardingRequired,
            ),
            []),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<OnboardingPage>(),
          )
        ],
      );
    });

    test('returns [HomePage] when authenticated and isNewUser == false', () {
      expect(
        onGenerateAppViewPages(
            AppState.initial(
              userProfile: UserProfile.empty,
              status: AppStatus.authenticated,
            ),
            []),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<HomePage>(),
          )
        ],
      );
    });
  });
}
