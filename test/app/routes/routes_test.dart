import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/profile_setup_wizard/profile_setup_wizard.dart';
import 'package:fitts/welcome/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('onGenerateAppViewPages', () {
    test('returns [WelcomePage] when not authenticated', () {
      expect(
        onGenerateAppViewPages(const AppState.unauthenticated(), []),
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
            const AppState.authenticated(
              User.empty,
              true,
            ),
            []),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<ProfileSetupWizardPage>(),
          )
        ],
      );
    });

    test('returns [HomePage] when authenticated and isNewUser == false', () {
      expect(
        onGenerateAppViewPages(
            const AppState.authenticated(
              User.empty,
              false,
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
