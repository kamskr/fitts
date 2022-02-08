import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:prfit/l10n/l10n.dart';
import 'package:prfit/sign_in/sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const SignInPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(context.read<AuthenticationClient>()),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SignInBlocListener(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient3,
        ),
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
                    _SignInTitle(),
                    _EmailInput(),
                    _PasswordInput(),
                    _SignInButton(),
                  ],
                ),
              ),
            )),
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Text(
        l10n.signInPageTitle,
        style: AppTypography.headline3.copyWith(color: AppColors.white),
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
            onPressed: () {
              context.read<SignInBloc>().add(SignInCredentialsSubmitted());
            },
            isLoading: state.status == FormzStatus.submissionInProgress,
            child: Text(l10n.signInPageSignInButton),
          );
        },
      ),
    );
  }
}
