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
    final currentIndex =
        context.watch<ProfileSetupWizardBloc>().state.currentStep - 1;

    return IndexedStack(
      index: currentIndex,
      children: const [
        _GenderStep(),
      ],
    );
  }
}

class _GenderStep extends StatelessWidget {
  const _GenderStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WizardStep(
      headerText: 'Male or female?',
      text: 'Certainly, men and women need different workout approaches 😉',
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
