import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template app_text_button}
/// Button with text displayed in the application.
/// {@endtemplate}
class AppTextButton extends StatelessWidget {
  /// {@macro app_text_button}
  const AppTextButton({
    Key? key,
    required this.child,
    this.onPressed,
    Color? textColor,
    TextStyle? textStyle,
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
    return TextButton(
      onPressed: onPressed != null
          ? () {
              HapticFeedback.lightImpact();
              onPressed!.call();
            }
          : null,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(_textStyle),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return _textColor.withOpacity(0.5);
          }
          return _textColor;
        }),
        splashFactory: NoSplash.splashFactory,
      ),
      child: child,
    );
  }
}
