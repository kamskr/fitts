import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/onboarding/onboarding.dart';
import 'package:fitts/welcome/welcome.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(AppState state, List<Page<dynamic>> pages) {
  if (state.status == AppStatus.loading) {
    return [_LoadingPage.page()];
  }

  if (state.status == AppStatus.unauthenticated) {
    return [WelcomePage.page()];
  }

  if (state.status == AppStatus.onboardingRequired) {
    return [OnboardingWelcomePage.page()];
  }

  return [HomePage.page()];
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: _LoadingPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
