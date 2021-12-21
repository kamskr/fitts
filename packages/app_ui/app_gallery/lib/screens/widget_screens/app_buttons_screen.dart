import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppButtonsScreen extends StatelessWidget {
  const AppButtonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Buttons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            AppButton.primary(
              onPressed: () {},
              child: const Text('AppButton.primary()'),
            ),
            const SizedBox(
              height: 20,
            ),
            const AppButton.primary(
              child: Text('AppButton.primary() - disabled'),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton.outlined(
              onPressed: () {},
              child: const Text('AppButton.outlined()'),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton.gradient(
              onPressed: () {},
              child: const Text('AppButton.gradient()'),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton.accentGradient(
              onPressed: () {},
              child: const Text('AppButton.accentGradient()'),
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextButton(
              onPressed: () {},
              child: const Text('AppTextButton()'),
            ),
          ],
        ),
      ),
    );
  }
}
