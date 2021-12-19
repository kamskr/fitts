// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures

// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/app/app.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockUser extends Mock implements User {}

void main() {
  group('AppBloc', () {
    final user = MockUser();
    late AuthenticationClient authenticationClient;

    setUp(() {
      authenticationClient = MockAuthenticationClient();

      when(() => authenticationClient.user).thenAnswer(
        (_) => Stream.empty(),
      );
    });

    test('initial state is loading', () {
      expect(
        AppBloc(
          authenticationClient: authenticationClient,
        ).state,
        AppState.loading(),
      );
    });

    group('UserChanged', () {
      late User returningUser;
      late User newUser;

      setUp(() {
        returningUser = MockUser();
        newUser = MockUser();
        when(() => returningUser.isNewUser).thenReturn(false);
        when(() => newUser.isNewUser).thenReturn(true);
      });

      blocTest<AppBloc, AppState>(
        'emits unauthenticated when user is anonymous',
        setUp: () {
          when(() => authenticationClient.user).thenAnswer(
            (_) => Stream.value(User.empty),
          );
          when(() => user.isAnonymous).thenReturn(true);
        },
        build: () => AppBloc(
          authenticationClient: authenticationClient,
        ),
        expect: () => [AppState.unauthenticated()],
      );
    });
  });
}
