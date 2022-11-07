import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

/// {@template sign_in_page}
/// Page used for user sign in.
/// {@endtemplate}
class SignInPage extends StatelessWidget {
  /// {@macro sign_in_page}
  const SignInPage({Key? key}) : super(key: key);

  /// Helper method for generating [MaterialPageRoute] to this page.
  static Route<void> route() => _SignInPageRoute();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(context.read<AuthenticationClient>()),
      child: const SignInView(),
    );
  }
}

class _SignInPageRoute extends MaterialPageRoute<void> {
  _SignInPageRoute()
      : super(
          builder: (_) => const SignInPage(),
        );
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final theme = Theme.of(context).pageTransitionsTheme;
    Animation<double> onlyForwardAnimation;
    switch (animation.status) {
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        onlyForwardAnimation = kAlwaysCompleteAnimation;
        break;
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        onlyForwardAnimation = animation;
        break;
    }

    return theme.buildTransitions<void>(
      this,
      context,
      onlyForwardAnimation,
      secondaryAnimation,
      child,
    );
  }
}

@visibleForTesting
// ignore: public_member_api_docs
class SignInView extends StatelessWidget {
  // ignore: public_member_api_docs
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final additionalColors = context.appColorScheme;

    return _SignInBlocListener(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: additionalColors.primaryGradient3,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: additionalColors.white,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SignInTitle(),
                  _EmailInput(),
                  _PasswordInput(),
                  _SignInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInBlocListener extends StatelessWidget {
  const _SignInBlocListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
        if (state.status.isSubmissionFailure && state.errorMessage != null) {
          AppSnackBar.show(
            context,
            Text(state.errorMessage ?? 'Authentication Failure'),
          );
        }
      },
      child: child,
    );
  }
}

class _SignInTitle extends StatelessWidget {
  const _SignInTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final additionalColors = context.appColorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Text(
        l10n.signInPageTitle,
        style: AppTypography.headline3.copyWith(color: additionalColors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final email = context.select((SignInBloc bloc) => bloc.state.email);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        key: const Key('signInPage_emailInput_textField'),
        labelText: l10n.signInPageEmailLabel,
        inputType: AppTextFieldType.email,
        errorText: email.invalid ? l10n.signUpPageEmailErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignInBloc>().add(SignInEmailChanged(newValue));
        },
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final password = context.select((SignInBloc bloc) => bloc.state.password);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        key: const Key('signInPage_passwordInput_textField'),
        labelText: l10n.signInPagePasswordLabel,
        inputType: AppTextFieldType.password,
        errorText:
            password.invalid ? l10n.signUpPagePasswordErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignInBloc>().add(SignInPasswordChanged(newValue));
        },
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxlg),
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return AppButton.gradient(
            key: const Key('signInPage_signInButton'),
            onPressed: state.status.isValidated
                ? () {
                    context
                        .read<SignInBloc>()
                        .add(SignInCredentialsSubmitted());
                  }
                : null,
            isLoading: state.status == FormzStatus.submissionInProgress,
            child: Text(l10n.signInPageSignInButton),
          );
        },
      ),
    );
  }
}
