part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class Submit extends OnboardingEvent {
  const Submit();

  @override
  List<Object> get props => [];
}

class StepChanged extends OnboardingEvent {
  const StepChanged(this.step);

  final int step;

  @override
  List<Object> get props => [step];
}

class GenderChanged extends OnboardingEvent {
  const GenderChanged(this.gender);

  final Gender gender;

  @override
  List<Object> get props => [gender];
}

class DateOfBirthChanged extends OnboardingEvent {
  const DateOfBirthChanged(this.dateOfBirth);

  final DateTime dateOfBirth;

  @override
  List<Object> get props => [dateOfBirth];
}

class WeightChanged extends OnboardingEvent {
  const WeightChanged(this.weight);

  final double weight;

  @override
  List<Object> get props => [weight];
}

class HeightChanged extends OnboardingEvent {
  const HeightChanged(this.height);

  final int height;

  @override
  List<Object> get props => [height];
}

class ProfileSubmitted extends OnboardingEvent {}
