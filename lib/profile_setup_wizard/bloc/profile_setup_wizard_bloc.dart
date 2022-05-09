import 'package:api_models/api_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_setup_wizard_event.dart';
part 'profile_setup_wizard_state.dart';

class ProfileSetupWizardBloc
    extends Bloc<ProfileSetupWizardEvent, ProfileSetupWizardState> {
  ProfileSetupWizardBloc() : super(ProfileSetupWizardInitial()) {
    on<StepChanged>(_onStepChanged);
    on<GenderChanged>(_onGenderChanged);
    on<AgeChanged>(_onAgeChanged);
    on<WeightChanged>(_onWeightChanged);
    on<HeightChanged>(_onHeightChanged);
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

  void _onAgeChanged(
    AgeChanged event,
    Emitter<ProfileSetupWizardState> emit,
  ) {
    emit(state.copyWith(age: event.age));
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
}
