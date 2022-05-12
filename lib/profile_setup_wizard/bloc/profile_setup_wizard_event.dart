part of 'profile_setup_wizard_bloc.dart';

abstract class ProfileSetupWizardEvent extends Equatable {
  const ProfileSetupWizardEvent();

  @override
  List<Object> get props => [];
}

class StepChanged extends ProfileSetupWizardEvent {
  const StepChanged(this.step);

  final int step;

  @override
  List<Object> get props => [step];
}

class GenderChanged extends ProfileSetupWizardEvent {
  const GenderChanged(this.gender);

  final Gender gender;

  @override
  List<Object> get props => [gender];
}

class AgeChanged extends ProfileSetupWizardEvent {
  const AgeChanged(this.age);

  final int age;

  @override
  List<Object> get props => [age];
}

class WeightChanged extends ProfileSetupWizardEvent {
  const WeightChanged(this.weight);

  final double weight;

  @override
  List<Object> get props => [weight];
}

class HeightChanged extends ProfileSetupWizardEvent {
  const HeightChanged(this.height);

  final int height;

  @override
  List<Object> get props => [height];
}

class ProfileSubmitted extends ProfileSetupWizardEvent {}