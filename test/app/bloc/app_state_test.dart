// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:app_models/app_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserProfile extends Mock implements UserProfile {}

void main() {
  group('AppState', () {
    test('supports value comparisons', () {
      expect(
        AppState.initial(userProfile: UserProfile.empty),
        AppState.initial(userProfile: UserProfile.empty),
      );
    });
    test('can copy with', () {
      final userProfile = MockUserProfile();
      final initialState = AppState.initial(
        userProfile: userProfile,
      );

      final newState = AppState.initial(
        userProfile: userProfile,
        user: User(id: 'test'),
        status: AppStatus.onboardingRequired,
      );

      expect(
        initialState.copyWith(
          userProfile: userProfile,
          user: User(id: 'test'),
          status: AppStatus.onboardingRequired,
        ),
        newState,
      );
    });

    group('unauthenticated', () {
      test('has correct status', () {
        final state = AppState.initial(
          userProfile: UserProfile.empty,
        );
        expect(state.status, AppStatus.loading);
        expect(state.userProfile, UserProfile.empty);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final state = AppState.initial(
          userProfile: UserProfile.empty,
          status: AppStatus.authenticated,
        );
        expect(state.status, AppStatus.authenticated);
        expect(state.userProfile, UserProfile.empty);
      });
    });
  });
}
