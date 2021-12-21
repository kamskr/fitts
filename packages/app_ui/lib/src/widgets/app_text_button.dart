import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template app_text_button}
/// Button with text displayed in the application.
/// {@endtemplate}
class AppTextButton extends StatelessWidget {
  /// {@macro app_text_button}
  const AppTextButton({
    Key? key,
    this.onPressed,
    Color? textColor,
    TextStyle? textStyle,
    required this.child,
  })  : _textColor = textColor ?? AppColors.primary,
        _textStyle = textStyle,
        super(key: key);

  /// [VoidCallback] called when button is pressed.
  /// Button is disabled when null.
  final VoidCallback? onPressed;

  /// A text color [Color] of the button.
  final Color _textColor;

  /// [TextStyle] of the button text.
  final TextStyle? _textStyle;

  /// [Widget] displayed on the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: kThemeAnimationDuration,
      opacity: onPressed != null ? 1 : 0.5,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(_textStyle),
          foregroundColor: MaterialStateProperty.all(_textColor),
        ),
        child: child,
      ),
    );
  }
}
