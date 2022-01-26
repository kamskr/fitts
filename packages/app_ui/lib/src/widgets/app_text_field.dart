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
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: UnderlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
