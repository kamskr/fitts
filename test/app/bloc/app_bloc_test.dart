// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

class MockUser extends Mock implements User {}

void main() {
  group('AppBloc', () {
    late AuthenticationClient authenticationClient;
    late UserProfileRepository userProfileRepository;
    late User authenticatedUser;

    setUp(() {
      authenticationClient = MockAuthenticationClient();
      userProfileRepository = MockUserProfileRepository();
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
          userProfileRepository: userProfileRepository,
        ).state,
        AppState.loading(),
      );
    });

    blocTest<AppBloc, AppState>(
      'emits AppState.unauthenticated() if user is empty',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(AppUserChanged(User.empty)),
      expect: () => const <AppState>[AppState.unauthenticated()],
    );

    blocTest<AppBloc, AppState>(
      'emits AppState.authenticated() if user is not empty',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(AppUserChanged(authenticatedUser)),
      expect: () =>
          <AppState>[AppState.authenticated(authenticatedUser, false)],
    );
  });
}
