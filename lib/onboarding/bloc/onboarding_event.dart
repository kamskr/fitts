part of 'onboarding_bloc.dart';

/// {@template onboarding_event}
/// Template for onboarding events
/// {@endtemplate}
abstract class OnboardingEvent extends Equatable {
  /// {@macro onboarding_event}
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

/// {@template step_changed}
///  Event for when the step of the onboarding changes.
///
/// This event should result in current page number changing
/// {@endtemplate}
class StepChanged extends OnboardingEvent {
  /// {@macro step_changed}
  const StepChanged(this.step);

  /// New step number.
  final int step;

  @override
  List<Object> get props => [step];
}

/// {@template gender_changed}
/// Event fired when picks value gender picker.
/// {@endtemplate}
class GenderChanged extends OnboardingEvent {
  /// {@macro gender_changed}
  const GenderChanged(this.gender);

  /// New gender.
  final Gender gender;

  @override
  List<Object> get props => [gender];
}

/// {@template date_of_birth_changed}
/// Event fired when user changes value on birth date picker.
/// {@endtemplate}
class DateOfBirthChanged extends OnboardingEvent {
  /// {@macro date_of_birth_changed}
  const DateOfBirthChanged(this.dateOfBirth);

  /// New date of birth.
  final DateTime dateOfBirth;

  @override
  List<Object> get props => [dateOfBirth];
}

/// {@template weight_changed}
/// Event fired when user changes value on weight picker.
/// {@endtemplate}
class WeightChanged extends OnboardingEvent {
  /// {@macro weight_changed}
  const WeightChanged(this.weight);

  /// New weight.
  final double weight;

  @override
  List<Object> get props => [weight];
}

/// {@template height_changed}
/// Event fired when user changes value on height picker.
/// {@endtemplate}
class HeightChanged extends OnboardingEvent {
  /// {@macro height_changed}
  const HeightChanged(this.height);

  /// New height.
  final int height;

  @override
  List<Object> get props => [height];
}

/// {@template profile_submitted}
/// Event fired when user submits profile.
/// {@endtemplate}
class ProfileSubmitted extends OnboardingEvent {
  /// {@macro profile_submitted}
  const ProfileSubmitted();

  @override
  List<Object> get props => [];
}
