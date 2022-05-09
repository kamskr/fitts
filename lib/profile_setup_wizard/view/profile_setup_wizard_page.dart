import 'package:app_ui/app_ui.dart';
import 'package:fitts/profile_setup_wizard/profile_setup_wizard.dart';
import 'package:fitts/profile_setup_wizard/widgets/wizard_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupWizardPage extends StatelessWidget {
  const ProfileSetupWizardPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: ProfileSetupWizardPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileSetupWizardBloc(),
      child: const ProfileSetupWizardPageView(),
    );
  }
}

class ProfileSetupWizardPageView extends StatelessWidget {
  const ProfileSetupWizardPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: _ProfileSetupWizardPageBody(),
      ),
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
        return IndexedStack(
          index: state.currentStep - 1,
          children: const [
            _GenderStep(),
            _AgeStep(),
          ],
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
          const SizedBox(height: AppSpacing.xxxlg),
          const SizedBox(height: AppSpacing.xxxlg),
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
    final age = context.watch<ProfileSetupWizardBloc>().state.age;

    return WizardStep(
      headerText: 'How old are you?',
      text: 'This is used to make better suggestions on workouts and plans.',
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxxlg),
          const SizedBox(height: AppSpacing.xxxlg),
          AppNumberPicker(
            currentValue: age,
            onChanged: (value) => context.read<ProfileSetupWizardBloc>().add(
                  AgeChanged(value),
                ),
            minValue: 1,
            maxValue: 200,
          ),
        ],
      ),
    );
  }
}
