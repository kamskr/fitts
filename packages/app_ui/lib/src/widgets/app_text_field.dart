import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template app_text_field}
/// A text field component based on material [TextFormField] widget with a
/// label
///
/// {@endtemplate}
class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.onChanged,
    this.labelText,
    this.initialValue,
    this.hintText,
    this.errorText,
  }) : super(key: key);

  /// Initial value of this field.
  final String? initialValue;

  /// Text that describes the purpose of this field.
  final String? labelText;

  /// Text that suggests what sort of values this field accepts.
  final String? hintText;

  /// Text that appears below the text and indicates error.
  final String? errorText;

  /// Action that is fired when value of the input changes.
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary[50]!.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xlg,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: AppTypography.body1.copyWith(
              color: AppColors.white.withOpacity(0.8),
            ),
            hintText: hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          cursorColor: AppColors.white,
          style: const TextStyle(color: AppColors.white),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
