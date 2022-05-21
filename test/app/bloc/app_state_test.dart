// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:api_models/api_models.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserProfile extends Mock implements UserProfile {}

void main() {
  group('AppState', () {
    group('unauthenticated', () {
      test('has correct status', () {
        final state = AppState.initial(
          userProfile: UserProfile.empty,
        );
        expect(state.status, AppStatus.loading);
        expect(state.user, null);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final state = AppState.initial(
          userProfile: MockUserProfile(),
          status: AppStatus.authenticated,
        );
        expect(state.status, AppStatus.authenticated);
        expect(state.userProfile, MockUserProfile());
      });
    });
  });
}
