part of 'profile_setup_wizard_bloc.dart';

enum ProfileSetupWizardStatus {
  initial,
  submitting,
  submitSuccess,
  submitFailed,
}

class ProfileSetupWizardState extends Equatable {
  const ProfileSetupWizardState({
    this.status = ProfileSetupWizardStatus.initial,
    this.currentStep = 1,
    this.weight = 68,
    this.height = 170,
    this.gender,
    this.dateOfBirth,
  });

  /// Status of the views
  final ProfileSetupWizardStatus status;

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

  ProfileSetupWizardState copyWith({
    ProfileSetupWizardStatus? status,
    Gender? gender,
    DateTime? dateOfBirth,
    double? weight,
    int? height,
    int? currentStep,
    UserProfile? userProfile,
  }) {
    final newState = ProfileSetupWizardState(
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
