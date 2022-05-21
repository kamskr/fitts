import 'package:app_ui/app_ui.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flutter/material.dart';

import 'profile_setup_wizard_page.dart';

class ProfileSetupWelcomePage extends StatelessWidget {
  const ProfileSetupWelcomePage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: ProfileSetupWelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const ProfileSetupWelcomePageView();
  }
}

class ProfileSetupWelcomePageView extends StatelessWidget {
  const ProfileSetupWelcomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _WelcomeImage(),
              AppGap.xxlg(),
              _WelcomeTitle(),
              AppGap.sm(),
              _WelcomeDescription(),
              AppGap.xxxlg(),
              AppGap.xxxlg(),
              _ContinueButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeImage extends StatelessWidget {
  const _WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      width: 225,
      child: Image.asset('assets/onboarding/welcome_image.png'),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Text(
      l10n.onboardingWeightSelectionTitle,
      style: AppTypography.headline5,
      textAlign: TextAlign.left,
    );
  }
}

class _WelcomeDescription extends StatelessWidget {
  const _WelcomeDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxlg,
      ),
      child: Text(
        l10n.onboardingWeightSelectionTitle,
        style: AppTypography.body1,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SizedBox(
      width: 200,
      child: AppButton.gradient(
        child: Text(l10n.onboardingWelcomeContinueButton),
        onPressed: () {
          Navigator.of(context).push<void>(
            ProfileSetupWizardPage.route(),
          );
        },
      ),
    );
  }
}
