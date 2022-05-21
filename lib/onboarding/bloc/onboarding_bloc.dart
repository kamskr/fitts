import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({
    required UserProfileRepository userProfileRepository,
    required UserProfile userProfile,
  })  : _userProfileRepository = userProfileRepository,
        _userProfile = userProfile,
        super(
          OnboardingState(
            dateOfBirth: DateTime.now(),
          ),
        ) {
    on<Submit>(_onSubmit);
    on<StepChanged>(_onStepChanged);
    on<GenderChanged>(_onGenderChanged);
    on<DateOfBirthChanged>(_onDateOfBirthChanged);
    on<WeightChanged>(_onWeightChanged);
    on<HeightChanged>(_onHeightChanged);
  }

  final UserProfileRepository _userProfileRepository;
  final UserProfile _userProfile;

  StreamSubscription<UserProfile>? _userProfileSubscription;

  Future<void> _onSubmit(
    Submit event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: OnboardingStatus.submitting));

      late String gender;

      if (state.gender == Gender.male) {
        gender = GenderStringValue.male;
      } else {
        gender = GenderStringValue.female;
      }

      await _userProfileRepository.updateUserProfile(
        payload: UserProfileUpdatePayload(
          email: _userProfile.email,
          photoUrl: _userProfile.photoUrl,
          displayName: _userProfile.displayName,
          goal: _userProfile.goal,
          gender: gender,
          dateOfBirth: state.dateOfBirth!,
          height: state.height,
          weight: state.weight,
          profileStatus: ProfileStatusStringValue.active,
        ),
      );
      emit(state.copyWith(status: OnboardingStatus.submitSuccess));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OnboardingStatus.submitFailed));
      addError(error, stackTrace);
    }
  }

  void _onStepChanged(
    StepChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _onGenderChanged(
    GenderChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onDateOfBirthChanged(
    DateOfBirthChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(dateOfBirth: event.dateOfBirth));
  }

  void _onWeightChanged(
    WeightChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(weight: event.weight));
  }

  void _onHeightChanged(
    HeightChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(height: event.height));
  }

  @override
  Future<void> close() {
    _userProfileSubscription?.cancel();
    return super.close();
  }
}
