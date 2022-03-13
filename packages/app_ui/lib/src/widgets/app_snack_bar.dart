import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

abstract class AppSnackBar {
  static void show(BuildContext context, Widget content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: content,
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.black,
      ));
  }
}
