import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:prfit/l10n/l10n.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const SignUpPage());

  @override
  Widget build(BuildContext context) {
    return const SignUpView();
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient3),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: AppColors.white, //change your color here
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SignUpTitle(),
                  _UsernameInput(),
                  _EmailInput(),
                  _PasswordInput(),
                  _LegalNote(),
                  _SignUpButton(),
                ],
              ),
            ),
          )),
    );
  }
}

class _SignUpTitle extends StatelessWidget {
  const _SignUpTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Text(
        l10n.signUpPageTitle,
        style: AppTypography.headline3.copyWith(color: AppColors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        labelText: l10n.signUpPageUsernameLabel,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        labelText: l10n.signUpPageEmailLabel,
        inputType: AppTextFieldType.email,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        labelText: l10n.signUpPagePasswordLabel,
        inputType: AppTextFieldType.password,
      ),
    );
  }
}

class _LegalNote extends StatelessWidget {
  const _LegalNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Text(
        l10n.signUpPageLegal,
        style: AppTypography.overline.copyWith(
          color: AppColors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxlg),
      child: AppButton.gradient(
        onPressed: () {},
        child: Text(l10n.signUpPageSignUpButton),
      ),
    );
  }
}
