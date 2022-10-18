// ignore_for_file: public_member_api_docs
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppSnackBarScreen extends StatelessWidget {
  const AppSnackBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBottomNavigationBar'),
      ),
      body: Center(
        child: AppButton.gradient(
          child: const Text('Open snackbar'),
          onPressed: () {
            AppSnackBar.show(context, const Text('Snackbar content.'));
          },
        ),
      ),
    );
  }
}
