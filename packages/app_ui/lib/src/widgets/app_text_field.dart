import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

enum AppTextFieldType { text, password }

/// {@template app_text_field}
/// A text field component based on material [TextFormField] widget with a
/// label
///
/// {@endtemplate}
class AppTextField extends StatefulWidget {
  /// {@macro app_text_field}
  const AppTextField({
    Key? key,
    this.onChanged,
    this.labelText,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.inputType = AppTextFieldType.text,
  }) : super(key: key);

  final String? initialValue;

  /// Text that describes the purpose of this field.
  final String? labelText;

  /// Text that suggests what sort of values this field accepts.
  final String? hintText;

  /// Text that appears below the text and indicates error.
  final String? errorText;

  /// [AppTextFieldType] that defines what kind of input is displayed.
  final AppTextFieldType? inputType;

  /// Action that is fired when value of the input changes.
  final ValueChanged<String>? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isFocused = false;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    // ignore: cascade_invocations
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _isFocused
            ? AppColors.primary[50]!.withOpacity(0.1)
            : Colors.transparent,
        border: !_isFocused
            ? Border(
                bottom: BorderSide(
                  color: AppColors.primary[50]!,
                  width: 0.2,
                ),
              )
            : const Border(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xlg,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: AppTypography.body1.copyWith(
              color: AppColors.white.withOpacity(0.8),
            ),
            hintText: widget.hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          obscureText: widget.inputType == AppTextFieldType.password,
          enableSuggestions: widget.inputType != AppTextFieldType.password,
          autocorrect: widget.inputType != AppTextFieldType.password,
          focusNode: _focus,
          cursorColor: AppColors.white,
          style: AppTypography.body1.copyWith(color: AppColors.white),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
