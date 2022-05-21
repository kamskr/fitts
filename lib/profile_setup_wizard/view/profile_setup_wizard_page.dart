import 'package:app_ui/app_ui.dart';
import 'package:fitts/app/bloc/app_bloc.dart';
import 'package:fitts/profile_setup_wizard/profile_setup_wizard.dart';
import 'package:fitts/profile_setup_wizard/widgets/wizard_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class ProfileSetupWizardPage extends StatelessWidget {
  const ProfileSetupWizardPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: ProfileSetupWizardPage());
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = context.watch<AppBloc>().state.userProfile!;

    return BlocProvider(
      create: (context) => ProfileSetupWizardBloc(
        userProfileRepository: context.read<UserProfileRepository>(),
        userProfile: userProfile,
      ),
      child: const ProfileSetupWizardPageView(),
    );
  }
}

class ProfileSetupWizardPageView extends StatelessWidget {
  const ProfileSetupWizardPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileSetupWizardListener(
      child: Stack(
        children: [
          Scaffold(
            body: BlocBuilder<ProfileSetupWizardBloc, ProfileSetupWizardState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == ProfileSetupWizardStatus.submitting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SafeArea(
                  child: _ProfileSetupWizardPageBody(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSetupWizardListener extends StatelessWidget {
  const ProfileSetupWizardListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileSetupWizardBloc, ProfileSetupWizardState>(
      listener: (context, state) {
        if (state.status == ProfileSetupWizardStatus.submitFailed) {
          AppSnackBar.show(
            context,
            const Text('Failed to submit'),
          );
        }
      },
      child: child,
    );
  }
}

class _ProfileSetupWizardPageBody extends StatelessWidget {
  const _ProfileSetupWizardPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupWizardBloc, ProfileSetupWizardState>(
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: IndexedStack(
            key: Key(state.currentStep.toString()),
            index: state.currentStep - 1,
            children: const [
              _GenderStep(),
              _AgeStep(),
              _WeightStep(),
              _HeightStep(),
            ],
          ),
        );
      },
    );
  }
}

class _GenderStep extends StatelessWidget {
  const _GenderStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gender = context.watch<ProfileSetupWizardBloc>().state.gender;

    return WizardStep(
      headerText: 'Male or female?',
      text: 'Certainly, men and women need different workout approaches 😉',
      canGoNext: gender != null,
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          Center(
            child: GenderPicker(
              selected: context.watch<ProfileSetupWizardBloc>().state.gender,
              onChange: (gender) {
                context
                    .read<ProfileSetupWizardBloc>()
                    .add(GenderChanged(gender));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AgeStep extends StatelessWidget {
  const _AgeStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateOfBirth =
        context.watch<ProfileSetupWizardBloc>().state.dateOfBirth;
    final dateTimeNow = DateTime.now();
    final dateValue = dateOfBirth ?? dateTimeNow;
    final maxNumberOfDaysInCurrentMonth =
        DateTime(dateValue.year, dateValue.month + 1, 0).day;

    return WizardStep(
      headerText: "What's your date of birth",
      text: 'This is used to make better suggestions on workouts and plans.',
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppNumberPicker(
                currentValue: dateValue.year,
                onChanged: (value) =>
                    context.read<ProfileSetupWizardBloc>().add(
                          DateOfBirthChanged(
                            DateTime(
                              value,
                              dateValue.month,
                              dateValue.day,
                            ),
                          ),
                        ),
                minValue: 1900,
                maxValue: dateTimeNow.year,
              ),
              AppNumberPicker(
                currentValue: dateValue.month,
                onChanged: (value) =>
                    context.read<ProfileSetupWizardBloc>().add(
                          DateOfBirthChanged(
                            DateTime(
                              dateValue.year,
                              value,
                              dateValue.day,
                            ),
                          ),
                        ),
                minValue: 1,
                maxValue: 12,
              ),
              AppNumberPicker(
                currentValue: dateValue.day,
                onChanged: (value) =>
                    context.read<ProfileSetupWizardBloc>().add(
                          DateOfBirthChanged(
                            DateTime(
                              dateValue.year,
                              dateValue.month,
                              value,
                            ),
                          ),
                        ),
                minValue: 1,
                maxValue: maxNumberOfDaysInCurrentMonth,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeightStep extends StatelessWidget {
  const _WeightStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weight = context.watch<ProfileSetupWizardBloc>().state.weight;

    return WizardStep(
      headerText: 'How much do you weigh?',
      text: 'This is used to set up recommendations just for you.',
      canGoNext: weight > 0,
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                width: 80,
                child: AppTextInput(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  initialValue: weight.toString(),
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    final newWeight = double.tryParse(value);

                    context.read<ProfileSetupWizardBloc>().add(
                          WeightChanged(newWeight ?? 0),
                        );
                  },
                  isDecimal: true,
                ),
              ),
              Text('kg', style: AppTypography.headline6),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeightStep extends StatelessWidget {
  const _HeightStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.watch<ProfileSetupWizardBloc>().state.height;

    return WizardStep(
      headerText: 'How tall are you?',
      text: 'This is used to set up recommendations just for you.',
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          AppNumberPicker(
            currentValue: height,
            onChanged: (value) => context.read<ProfileSetupWizardBloc>().add(
                  HeightChanged(value),
                ),
            textMapper: (value) => '$value cm',
            minValue: 1,
            maxValue: 300,
          ),
        ],
      ),
    );
  }
}
