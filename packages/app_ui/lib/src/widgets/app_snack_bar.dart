import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template app_snack_bar}
/// A snack bar is a temporary notification.
/// {@endtemplate}
abstract class AppSnackBar {
  /// {@macro app_snack_bar}
  static void show(BuildContext context, Widget content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: content,
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.black,
        ),
      );
  }
}
