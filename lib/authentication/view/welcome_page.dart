import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:prfit/l10n/l10n.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const WelcomeView();
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(height: 70),
              _WelcomeAppLogo(),
              SizedBox(height: 30),
              _WelcomeTitle(),
              SizedBox(height: 4),
              _WelcomeSubtitle(),
              SizedBox(height: 120),
              SignUpButton(),
              SizedBox(height: 10),
              SignUpWithGoogleButton(),
              SizedBox(height: 56),
              _AlreadyHaveAccountText(),
              SizedBox(height: 16),
              SignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeAppLogo extends StatelessWidget {
  const _WelcomeAppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Assets.icons.appLogo.svg(
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          l10n.welcomePageTitle,
          style: AppTypography.headline2,
        ),
      ),
    );
  }
}

class _WelcomeSubtitle extends StatelessWidget {
  const _WelcomeSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          l10n.welcomePageSubtitle,
          style: AppTypography.subtitle1,
        ),
      ),
    );
  }
}

@visibleForTesting
class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: AppButton.gradient(
        child: Text(l10n.signUpButton),
        onPressed: () {},
      ),
    );
  }
}

@visibleForTesting
class SignUpWithGoogleButton extends StatelessWidget {
  const SignUpWithGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: AppButton.outlined(
        child: Text(l10n.signUpWithGoogleButton),
        onPressed: () {},
      ),
    );
  }
}

class _AlreadyHaveAccountText extends StatelessWidget {
  const _AlreadyHaveAccountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Text(l10n.alreadyHaveAccountText);
  }
}

@visibleForTesting
class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppTextButton(
      onPressed: () {},
      child: Text(l10n.signInButton),
    );
  }
}
