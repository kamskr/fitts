part of 'profile_setup_wizard_bloc.dart';

class ProfileSetupWizardState extends Equatable {
  const ProfileSetupWizardState({
    this.currentStep = 1,
    this.age = 18,
    this.weight = 68,
    this.height = 170,
    this.gender,
  });

  /// Indicates on which step of the setup wizard user is
  /// currently in.
  final int currentStep;

  /// Total steps
  static const totalSteps = 4;

  /// Profile fields
  final Gender? gender;
  final int age;
  final double weight;
  final int height;

  @override
  List<Object?> get props => [currentStep, gender, age, weight, height];

  ProfileSetupWizardState copyWith({
    Gender? gender,
    int? age,
    double? weight,
    int? height,
    int? currentStep,
  }) {
    final newState = ProfileSetupWizardState(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      currentStep: currentStep ?? this.currentStep,
    );
    return newState;
  }
}

class ProfileSetupWizardInitial extends ProfileSetupWizardState {}
