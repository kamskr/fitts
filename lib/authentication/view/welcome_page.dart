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
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.welcomePageTitle),
      ),
      body: Center(
        child: Text(l10n.welcomePageTitle),
      ),
    );
  }
}
