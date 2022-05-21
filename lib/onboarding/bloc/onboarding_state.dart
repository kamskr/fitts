part of 'onboarding_bloc.dart';

enum OnboardingStatus {
  initial,
  submitting,
  submitSuccess,
  submitFailed,
}

class OnboardingState extends Equatable {
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

  /// Profile fields
  final Gender? gender;
  final DateTime? dateOfBirth;
  final double weight;
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
