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
    LinearGradient? linearGradient,
    BorderRadius? borderRadius,
    required this.child,
  })  : _backgroundColor = backgroundColor ?? AppColors.primary,
        _foregroundColor = foregroundColor ?? AppColors.white,
        _borderSide = borderSide,
        _textStyle = textStyle,
        _height = height ?? 42,
        _linearGradient = linearGradient,
        _borderRadius = borderRadius ?? BorderRadius.zero,
        super(key: key);

  /// Filled primary button.
  const AppButton.primary({
    Key? key,
    VoidCallback? onPressed,
    required Widget child,
  }) : this._(
          key: key,
          child: child,
          onPressed: onPressed,
        );

  /// Outlined accent button.
  const AppButton.outlined({
    Key? key,
    VoidCallback? onPressed,
    required Widget child,
  }) : this._(
          key: key,
          child: child,
          onPressed: onPressed,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.primary,
          borderSide: const BorderSide(color: AppColors.primary),
          height: 64,
        );

  /// Gradient primary button.
  const AppButton.gradient({
    Key? key,
    VoidCallback? onPressed,
    required Widget child,
  }) : this._(
          key: key,
          child: child,
          onPressed: onPressed,
          height: 64,
          linearGradient: AppColors.primaryGradient1,
        );

  /// Gradient accent button.
  AppButton.accentGradient({
    Key? key,
    VoidCallback? onPressed,
    required Widget child,
  }) : this._(
          key: key,
          child: child,
          onPressed: onPressed,
          height: 52,
          linearGradient: AppColors.secondaryAccentGradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
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

  /// [LinearGradient] of the button.
  final LinearGradient? _linearGradient;

  /// [BorderRadius] of the button.
  final BorderRadius _borderRadius;

  /// [Widget] displayed on the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var currentChild = child;

    if (_linearGradient != null) {
      currentChild = Ink(
        decoration: BoxDecoration(
          gradient: _linearGradient,
          borderRadius: _borderRadius,
        ),
        child: Center(child: child),
      );
    }

    return Opacity(
      opacity: onPressed != null ? 1 : 0.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: _borderRadius,
            ),
          ),
          textStyle: MaterialStateProperty.all(_textStyle),
          backgroundColor: MaterialStateProperty.all(_backgroundColor),
          foregroundColor: MaterialStateProperty.all(_foregroundColor),
          side: MaterialStateProperty.all(_borderSide),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: SizedBox(
          height: _height,
          child: Align(
            child: currentChild,
          ),
        ),
      ),
    );
  }
}
