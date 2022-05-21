// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:api_models/api_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

class MockUserProfile extends Mock implements UserProfile {
  @override
  ProfileStatus get profileStatus => ProfileStatus.active;
}

void main() {
  group('AppBloc', () {
    late AuthenticationClient authenticationClient;
    late UserProfileRepository userProfileRepository;

    setUp(() {
      authenticationClient = MockAuthenticationClient();
      userProfileRepository = MockUserProfileRepository();

      when(() => authenticationClient.user).thenAnswer(
        (_) => Stream.empty(),
      );
    });

    test('has initial state `loading`', () {
      expect(
        AppBloc(
          authenticationClient: authenticationClient,
          userProfileRepository: userProfileRepository,
        ).state,
        AppState.initial(userProfile: UserProfile.empty),
      );
    });

    blocTest<AppBloc, AppState>(
      'emits AppState.unauthenticated() if user is empty',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(AppUserChanged(User.empty)),
      expect: () => <AppState>[
        AppState.initial(userProfile: UserProfile.empty),
        AppState.initial(
          userProfile: UserProfile.empty,
          status: AppStatus.unauthenticated,
        ),
      ],
    );
  });
}
