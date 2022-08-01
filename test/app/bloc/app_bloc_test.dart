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

class MockUser extends Mock implements User {}

class MockUserProfile extends Mock implements UserProfile {
  @override
  ProfileStatus get profileStatus => ProfileStatus.active;
}

class MockNewUserProfile extends Mock implements UserProfile {
  @override
  ProfileStatus get profileStatus => ProfileStatus.onboardingRequired;
}

void main() {
  group('AppBloc', () {
    late AuthenticationClient authenticationClient;
    late UserProfileRepository userProfileRepository;
    late User user;
    late UserProfile userProfileActive;
    late UserProfile userProfileNew;

    setUp(() {
      authenticationClient = MockAuthenticationClient();
      userProfileRepository = MockUserProfileRepository();
      user = MockUser();
      userProfileActive = MockUserProfile();
      userProfileNew = MockNewUserProfile();

      when(() => authenticationClient.user).thenAnswer(
        (_) => Stream.empty(),
      );
      when(() => userProfileRepository.userProfile('user@email.com'))
          .thenAnswer(
        (_) => Stream<UserProfile>.value(userProfileActive),
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
    blocTest<AppBloc, AppState>(
      'emits new AppState with user if user not empty',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(AppUserChanged(user)),
      expect: () => <AppState>[
        AppState.initial(userProfile: UserProfile.empty),
        AppState.initial(
          userProfile: UserProfile.empty,
          user: user,
        ),
      ],
    );
    blocTest<AppBloc, AppState>(
      'emits authenticated if UserProfile not empty and active',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        AppUserProfileChanged(
          userProfileActive,
        ),
      ),
      expect: () => <AppState>[
        AppState.initial(
          userProfile: userProfileActive,
          status: AppStatus.authenticated,
        ),
      ],
    );
    blocTest<AppBloc, AppState>(
      'emits onboardingRequired if UserProfile not empty and not active',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        AppUserProfileChanged(
          userProfileNew,
        ),
      ),
      expect: () => <AppState>[
        AppState.initial(
          userProfile: userProfileNew,
          status: AppStatus.onboardingRequired,
        ),
      ],
    );
    blocTest<AppBloc, AppState>(
      'emits unauthenticated if UserProfile empty',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        AppUserProfileChanged(
          UserProfile.empty,
        ),
      ),
      expect: () => <AppState>[
        AppState.initial(
          userProfile: UserProfile.empty,
          status: AppStatus.unauthenticated,
        ),
      ],
    );
    blocTest<AppBloc, AppState>(
      'does nothing if UserProfile has email == "waiting"',
      build: () => AppBloc(
        authenticationClient: authenticationClient,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        AppUserProfileChanged(
          UserProfile.empty.copyWith(email: 'waiting'),
        ),
      ),
      expect: () => <AppState>[],
    );
  });
}
