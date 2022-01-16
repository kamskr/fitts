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
    late AuthenticationClient authenticationClient;
    late User authenticatedUser;

    setUp(() {
      authenticationClient = MockAuthenticationClient();
      authenticatedUser = MockUser();

      when(() => authenticationClient.user).thenAnswer(
        (_) => Stream.empty(),
      );
      when(() => authenticatedUser.isNewUser).thenReturn(false);
    });

    test('has initial state `loading`', () {
      expect(
        AppBloc(
          authenticationClient: authenticationClient,
        ).state,
        AppState.loading(),
      );
    });

    blocTest<AppBloc, AppState>(
      'emits AppState.unauthenticated() if user is empty',
      build: () => AppBloc(authenticationClient: authenticationClient),
      act: (bloc) => bloc.add(AppUserChanged(User.empty)),
      expect: () => const <AppState>[AppState.unauthenticated()],
    );

    blocTest<AppBloc, AppState>(
      'emits AppState.authenticated() if user is not empty',
      build: () => AppBloc(authenticationClient: authenticationClient),
      act: (bloc) => bloc.add(AppUserChanged(authenticatedUser)),
      expect: () => <AppState>[AppState.authenticated(authenticatedUser)],
    );
  });
}
