import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

/// {@macro sign_up_page}
/// Page used for user sign up.
/// {@endtemplate}
class SignUpPage extends StatelessWidget {
  /// {@macro sign_up_page}
  const SignUpPage({Key? key}) : super(key: key);

  /// Helper method for generating [MaterialPageRoute] to this page.
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const SignUpPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        authenticationClient: context.read<AuthenticationClient>(),
        userProfileRepository: context.read<UserProfileRepository>(),
      ),
      child: const SignUpView(),
    );
  }
}

@visibleForTesting
// ignore: public_member_api_docs
class SignUpView extends StatelessWidget {
  // ignore: public_member_api_docs
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final additionalColors = Theme.of(context).extension<AppColorScheme>()!;

    return _SignUpBlocListener(
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
                  _SignUpTitle(),
                  _UsernameInput(),
                  _EmailInput(),
                  _PasswordInput(),
                  _LegalNote(),
                  _SignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpBlocListener extends StatelessWidget {
  const _SignUpBlocListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
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

class _SignUpTitle extends StatelessWidget {
  const _SignUpTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final additionalColors = Theme.of(context).extension<AppColorScheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Text(
        l10n.signUpPageTitle,
        style: AppTypography.headline3.copyWith(color: additionalColors.white),
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
    final username = context.select((SignUpBloc bloc) => bloc.state.username);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        key: const Key('signUpPage_usernameInput_textField'),
        labelText: l10n.signUpPageUsernameLabel,
        errorText:
            username.invalid ? l10n.signUpPageUsernameErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignUpBloc>().add(SignUpUsernameChanged(newValue));
        },
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final email = context.select((SignUpBloc bloc) => bloc.state.email);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        key: const Key('signUpPage_emailInput_textField'),
        labelText: l10n.signUpPageEmailLabel,
        inputType: AppTextFieldType.email,
        errorText: email.invalid ? l10n.signUpPageEmailErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignUpBloc>().add(SignUpEmailChanged(newValue));
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
    final password = context.select((SignUpBloc bloc) => bloc.state.password);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        key: const Key('signUpPage_passwordInput_textField'),
        labelText: l10n.signUpPagePasswordLabel,
        inputType: AppTextFieldType.password,
        errorText:
            password.invalid ? l10n.signUpPagePasswordErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignUpBloc>().add(SignUpPasswordChanged(newValue));
        },
      ),
    );
  }
}

class _LegalNote extends StatelessWidget {
  const _LegalNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final additionalColors = Theme.of(context).extension<AppColorScheme>()!;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Text(
        l10n.signUpPageLegal,
        style: AppTypography.overline.copyWith(
          color: additionalColors.white.withOpacity(0.8),
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
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, next) => previous.status != next.status,
        builder: (context, state) {
          return AppButton.gradient(
            key: const Key('signUpPage_signUpButton'),
            onPressed: state.status.isValidated
                ? () =>
                    context.read<SignUpBloc>().add(SignUpCredentialsSubmitted())
                : null,
            isLoading: state.status == FormzStatus.submissionInProgress,
            child: Text(l10n.signUpPageSignUpButton),
          );
        },
      ),
    );
  }
}
