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
        final state = AppState.unauthenticated();
        expect(state.status, AppStatus.unauthenticated);
        expect(state.user, null);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final state = AppState.authenticated(MockUserProfile(), false);
        expect(state.status, AppStatus.authenticated);
        expect(state.user, MockUserProfile());
      });
    });
  });
}
