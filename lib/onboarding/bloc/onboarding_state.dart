part of 'onboarding_bloc.dart';

/// {@template onboarding_status}
/// Status of the onboarding process.
/// {@endtemplate}
enum OnboardingStatus {
  /// Initial status of the onboarding process.
  initial,

  /// Status when onboarding is being submitted..
  submitting,

  /// Status when onboarding submission finished with success.
  submitSuccess,

  /// Status when onboarding submission failed.
  submitFailed,
}

/// {@template onboarding_state}
/// State of the onboarding process.
/// {@endtemplate}
class OnboardingState extends Equatable {
  /// {@macro onboarding_state}
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.currentStep = 1,
    this.weight = 68,
    this.height = 170,
    this.gender,
    this.dateOfBirth,
  });

  /// Status of the views
  final OnboardingStatus status;

  /// Indicates on which step of the setup wizard user is
  /// currently in.
  final int currentStep;

  /// Total steps
  static const totalSteps = 4;

  /// Gender of the user.
  final Gender? gender;

  /// Date of birth of the user.
  final DateTime? dateOfBirth;

  /// Weight of the user.
  final double weight;

  /// Height of the user.
  final int height;

  @override
  List<Object?> get props => [
        status,
        currentStep,
        gender,
        dateOfBirth,
        weight,
        height,
      ];

  /// Copy method
  OnboardingState copyWith({
    OnboardingStatus? status,
    Gender? gender,
    DateTime? dateOfBirth,
    double? weight,
    int? height,
    int? currentStep,
    UserProfile? userProfile,
  }) {
    final newState = OnboardingState(
      status: status ?? this.status,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      currentStep: currentStep ?? this.currentStep,
    );
    return newState;
  }
}
