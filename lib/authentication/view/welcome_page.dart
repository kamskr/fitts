import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prfit/authentication/authentication.dart';
import 'package:prfit/l10n/l10n.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeCubit(context.read<AuthenticationClient>()),
      child: const WelcomeView(),
    );
  }
}

@visibleForTesting
class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SizedBox(height: 70),
              _WelcomeAppLogo(),
              SizedBox(height: AppSpacing.xlg),
              _WelcomeTitle(),
              SizedBox(height: AppSpacing.xxs),
              _WelcomeSubtitle(),
              SizedBox(height: 120),
              SignUpButton(),
              SizedBox(height: AppSpacing.sm),
              SignUpWithGoogleButton(),
              SizedBox(height: AppSpacing.xxxlg),
              _AlreadyHaveAccountText(),
              SizedBox(height: AppSpacing.md),
              SignInButton(),
              SizedBox(height: AppSpacing.md),
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
    const _boxSize = 50.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxlg),
      child: Assets.icons.appLogo.svg(
        alignment: Alignment.centerLeft,
        width: _boxSize,
        height: _boxSize,
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxlg),
      child: Text(
        l10n.welcomePageTitle,
        style: AppTypography.headline2,
        textAlign: TextAlign.left,
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxlg),
      child: Text(
        l10n.welcomePageSubtitle,
        style: AppTypography.subtitle1,
        textAlign: TextAlign.left,
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxlg),
      child: AppButton.gradient(
        onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
        child: Text(l10n.signUpButton),
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxlg),
      child: AppButton.outlined(
        child: Text(l10n.signInWithGoogleButton),
        onPressed: () {
          context.read<WelcomeCubit>().signInWithGoogle();
        },
      ),
    );
  }
}

class _AlreadyHaveAccountText extends StatelessWidget {
  const _AlreadyHaveAccountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Text(
      l10n.alreadyHaveAccountText,
      textAlign: TextAlign.center,
    );
  }
}

@visibleForTesting
class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppTextButton(
      child: Text(l10n.signInButton),
    );
  }
}
