import 'package:api_models/api_models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/onboarding/onboarding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class MockUserProfile extends Mock implements UserProfile {
  @override
  String get email => 'test@test.te';

  @override
  String get photoUrl => 'test';

  @override
  String get displayName => 'test';

  @override
  String get goal => 'test';

  @override
  ProfileStatus get profileStatus => ProfileStatus.onboardingRequired;
}

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  group('OnboardingBloc', () {
    late final UserProfileRepository userProfileRepository;
    late final UserProfile userProfile;
    late final UserProfileUpdatePayload payload;

    const gender = 'male';
    final dateOfBirth = DateTime(2000);
    const height = 176;
    const weight = 96.0;

    setUpAll(() {
      userProfileRepository = MockUserProfileRepository();
      userProfile = MockUserProfile();
      payload = UserProfileUpdatePayload(
        email: userProfile.email,
        photoUrl: userProfile.photoUrl,
        displayName: userProfile.displayName,
        goal: userProfile.goal,
        gender: gender,
        dateOfBirth: dateOfBirth,
        height: height,
        weight: weight,
        profileStatus: ProfileStatusStringValue.active,
      );

      when(() => userProfileRepository.updateUserProfile(payload: payload))
          .thenAnswer((_) async {});
    });

    blocTest<OnboardingBloc, OnboardingState>(
      'submits data when [ProfileSubmitted] is added',
      seed: () => OnboardingState(
        status: OnboardingStatus.submitting,
        gender: Gender.male,
        dateOfBirth: payload.dateOfBirth,
        height: payload.height,
        weight: payload.weight,
      ),
      build: () => OnboardingBloc(
        userProfile: userProfile,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(const ProfileSubmitted()),
      expect: () => <OnboardingState>[
        OnboardingState(
          status: OnboardingStatus.submitSuccess,
          gender: Gender.male,
          dateOfBirth: payload.dateOfBirth,
          height: payload.height,
          weight: payload.weight,
        ),
      ],
      verify: (_) {
        verify(
          () => userProfileRepository.updateUserProfile(payload: payload),
        ).called(1);
      },
    );
    blocTest<OnboardingBloc, OnboardingState>(
      'emits new state when [StepChanged] event is added',
      build: () => OnboardingBloc(
        userProfile: userProfile,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        const StepChanged(2),
      ),
      expect: () => <OnboardingState>[
        OnboardingState(
          dateOfBirth: dateOfBirth,
          currentStep: 2,
        ),
      ],
    );
    blocTest<OnboardingBloc, OnboardingState>(
      'emits new state when [GenderChanged] event is added',
      build: () => OnboardingBloc(
        userProfile: userProfile,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        const GenderChanged(Gender.male),
      ),
      expect: () => <OnboardingState>[
        OnboardingState(
          dateOfBirth: dateOfBirth,
          gender: Gender.male,
        ),
      ],
    );
    blocTest<OnboardingBloc, OnboardingState>(
      'emits new state when [DateOfBirthChanged] event is added',
      build: () => OnboardingBloc(
        userProfile: userProfile,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        DateOfBirthChanged(dateOfBirth),
      ),
      expect: () => <OnboardingState>[
        OnboardingState(
          dateOfBirth: dateOfBirth,
        ),
      ],
    );
    blocTest<OnboardingBloc, OnboardingState>(
      'emits new state when [WeightChanged] event is added',
      build: () => OnboardingBloc(
        userProfile: userProfile,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        const WeightChanged(weight),
      ),
      expect: () => <OnboardingState>[
        OnboardingState(
          dateOfBirth: dateOfBirth,
          weight: weight,
        ),
      ],
    );
    blocTest<OnboardingBloc, OnboardingState>(
      'emits new state when [HeightChanged] event is added',
      build: () => OnboardingBloc(
        userProfile: userProfile,
        userProfileRepository: userProfileRepository,
      ),
      act: (bloc) => bloc.add(
        const HeightChanged(height),
      ),
      expect: () => <OnboardingState>[
        OnboardingState(
          dateOfBirth: dateOfBirth,
          height: height,
        ),
      ],
    );
  });
}
