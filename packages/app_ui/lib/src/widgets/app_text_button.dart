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
    this.textColor,
    this.textStyle,
  }) : super(key: key);

  /// [VoidCallback] called when button is pressed.
  /// Button is disabled when null.
  final VoidCallback? onPressed;

  /// A text color [Color] of the button.
  final Color? textColor;

  /// [TextStyle] of the button text.
  final TextStyle? textStyle;

  /// [Widget] displayed on the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? context.colorScheme.primary;

    return TextButton(
      onPressed: onPressed != null
          ? () {
              HapticFeedback.lightImpact();
              onPressed!.call();
            }
          : null,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          textStyle ?? context.textTheme.bodyText1,
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return color.withOpacity(0.5);
          }
          return color;
        }),
        splashFactory: NoSplash.splashFactory,
      ),
      child: child,
    );
  }
}
