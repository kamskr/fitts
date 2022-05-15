import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

part 'profile_setup_wizard_event.dart';
part 'profile_setup_wizard_state.dart';

class ProfileSetupWizardBloc
    extends Bloc<ProfileSetupWizardEvent, ProfileSetupWizardState> {
  ProfileSetupWizardBloc({
    required UserProfileRepository userProfileRepository,
    required UserProfile userProfile,
  })  : _userProfileRepository = userProfileRepository,
        _userProfile = userProfile,
        super(
          ProfileSetupWizardState(
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
    Emitter<ProfileSetupWizardState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProfileSetupWizardStatus.submitting));

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
          isNewUser: false,
        ),
      );
      emit(state.copyWith(status: ProfileSetupWizardStatus.submitSuccess));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProfileSetupWizardStatus.submitFailed));
      addError(error, stackTrace);
    }
  }

  void _onStepChanged(
    StepChanged event,
    Emitter<ProfileSetupWizardState> emit,
  ) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _onGenderChanged(
    GenderChanged event,
    Emitter<ProfileSetupWizardState> emit,
  ) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onDateOfBirthChanged(
    DateOfBirthChanged event,
    Emitter<ProfileSetupWizardState> emit,
  ) {
    emit(state.copyWith(dateOfBirth: event.dateOfBirth));
  }

  void _onWeightChanged(
    WeightChanged event,
    Emitter<ProfileSetupWizardState> emit,
  ) {
    emit(state.copyWith(weight: event.weight));
  }

  void _onHeightChanged(
    HeightChanged event,
    Emitter<ProfileSetupWizardState> emit,
  ) {
    emit(state.copyWith(height: event.height));
  }

  @override
  Future<void> close() {
    _userProfileSubscription?.cancel();
    return super.close();
  }
}
