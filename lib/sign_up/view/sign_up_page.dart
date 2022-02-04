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
    final l10n = context.l10n;

    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient3),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: AppColors.white, //change your color here
          ),
        ),
        body: Center(
          child: Text(l10n.signUpPageTitle),
        ),
      ),
    );
  }
}
