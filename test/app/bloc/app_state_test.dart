// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures

// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/app/app.dart';

class MockUser extends Mock implements User {}

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
        final state = AppState.authenticated(
          User.empty,
        );
        expect(state.status, AppStatus.authenticated);
        expect(state.user, User.empty);
      });
    });
  });
}