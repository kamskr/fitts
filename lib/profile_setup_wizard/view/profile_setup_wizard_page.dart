import 'package:fitts/profile_setup_wizard/widgets/wizard_step.dart';
import 'package:flutter/material.dart';

class ProfileSetupWizardPage extends StatelessWidget {
  const ProfileSetupWizardPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: ProfileSetupWizardPage());
  }

  @override
  Widget build(BuildContext context) {
    return const ProfileSetupWizardPageView();
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
    return IndexedStack(
      children: const [
        WizardStep(
          headerText: 'Male or female?',
          text: 'Certainly, men and women need different workout approaches 😉',
          currentStep: 1,
          totalSteps: 5,
          child: Center(
            child: SizedBox(
              height: 30,
              width: 49,
              child: Text('gender'),
            ),
          ),
        ),
      ],
    );
  }
}
