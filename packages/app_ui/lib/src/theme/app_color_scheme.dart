import 'package:flutter/material.dart';

/// This class ensures that app color scheme is compatible with
/// Material [ColorScheme] pallet so build in components looks good with
/// our custom implementation.
abstract class BaseColorScheme {
  const BaseColorScheme({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
  });

  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;

  ColorScheme get materialColorScheme => ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        surface: surface,
        onSurface: onSurface,
        error: error,
        onError: onError,
        background: background,
        onBackground: onBackground,
      );
}

/// This is place where you should put all custom color scheme properties
@immutable
class AppColorScheme extends BaseColorScheme {
  AppColorScheme.fromMaterialColorScheme(
    ColorScheme colorScheme, {
    required this.primary50,
    required this.primary400,
    required this.primary500,
    required this.primary900,
    required this.accent300,
    required this.accent500,
    required this.accent900,
    required this.secondaryAccent,
    required this.secondaryAccent400,
    required this.secondaryAccent500,
    required this.white,
    required this.black,
    required this.primaryGradient1,
    required this.primaryGradient2,
    required this.primaryGradient3,
    required this.primaryGradient4,
    required this.primaryGradient5,
    required this.accentGradient,
    required this.secondaryAccentGradient,
  }) : super(
          brightness: colorScheme.brightness,
          primary: colorScheme.primary,
          onPrimary: colorScheme.onPrimary,
          secondary: colorScheme.secondary,
          onSecondary: colorScheme.onSecondary,
          surface: colorScheme.surface,
          onSurface: colorScheme.onSurface,
          error: colorScheme.error,
          onError: colorScheme.onError,
          background: colorScheme.background,
          onBackground: colorScheme.onBackground,
        );

  // Extra colors here
  final Color primary50;
  final Color primary400;
  final Color primary500;
  final Color primary900;

  final Color accent300;
  final Color accent500;
  final Color accent900;

  final Color secondaryAccent;
  final Color secondaryAccent400;
  final Color secondaryAccent500;

  final Color white;
  final Color black;

  final LinearGradient primaryGradient1;
  final LinearGradient primaryGradient2;
  final LinearGradient primaryGradient3;
  final LinearGradient primaryGradient4;
  final LinearGradient primaryGradient5;

  final LinearGradient accentGradient;
  final LinearGradient secondaryAccentGradient;
  // final Color disabled;
  // final Color onDisabled;
}
