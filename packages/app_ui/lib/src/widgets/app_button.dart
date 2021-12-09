import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template app_button}
/// Button with text displayed in the application.
/// {@endtemplate}
class AppButton extends StatelessWidget {
  /// {@macro app_button}
  const AppButton._({
    Key? key,
    this.onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    BorderSide? borderSide,
    TextStyle? textStyle,
    double? height,
    required this.child,
  })  : _backgroundColor = backgroundColor ?? AppColors.primary,
        _foregroundColor = foregroundColor ?? AppColors.white,
        _borderSide = borderSide,
        _textStyle = textStyle,
        _height = height ?? 42,
        super(key: key);

  /// Filled primary button.
  const AppButton.primary({
    Key? key,
    VoidCallback? onPressed,
    TextStyle? textStyle,
    required Widget child,
  }) : this._(
          key: key,
          child: child,
          onPressed: onPressed,
          textStyle: textStyle,
        );

  /// [VoidCallback] called when button is pressed.
  /// Button is disabled when null.
  final VoidCallback? onPressed;

  /// A background [Color] of the button.
  final Color _backgroundColor;

  /// [Color] of the text, icons etc.
  final Color _foregroundColor;

  /// A border of the button.
  final BorderSide? _borderSide;

  /// [TextStyle] of the button text.
  final TextStyle? _textStyle;

  /// [double] A height of the button.
  final double _height;

  /// [Widget] displayed on the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed != null ? 1 : 0.6,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(),
          ),
          textStyle: MaterialStateProperty.all(_textStyle),
          backgroundColor: MaterialStateProperty.all(_backgroundColor),
          foregroundColor: MaterialStateProperty.all(_foregroundColor),
          side: MaterialStateProperty.all(_borderSide),
        ),
        child: SizedBox(
          height: _height,
          child: Center(child: child),
        ),
      ),
    );
  }
}
