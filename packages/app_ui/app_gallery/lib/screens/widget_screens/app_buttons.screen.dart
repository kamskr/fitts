import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppButtonsScreen extends StatelessWidget {
  const AppButtonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App buttons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            AppButton.primary(
              onPressed: () {},
              child: const Text('AppButton.primary()'),
            ),
          ],
        ),
      ),
    );
  }
}
