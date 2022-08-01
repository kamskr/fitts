import 'package:flutter/material.dart';

/// {@template app_colors}
/// Colors used by the application.
/// {@endtemplate}
abstract class AppColors {
  /// Primary color with different shades.
  static const primary = MaterialColor(0xff5063EE, {
    50: Color(0xffE9EAF2),
    400: Color(0xff808DED),
    500: Color(0xff5063EE),
    900: Color(0xff3346D4),
  });

  /// Accent color with different shades.
  static const accent = MaterialColor(0xffF99543, {
    300: Color(0xffFFBE8A),
    500: Color(0xffF99543),
    900: Color(0xffD47B33),
  });

  /// Secondary accent color with different shades.
  static const secondaryAccent = MaterialColor(0xff40A076, {
    400: Color(0xff69E7A4),
    500: Color(0xff40A076),
  });

  /// White color.
  static const white = Colors.white;

  /// Error color.
  static const error = Color(0xffED254E);

  /// Black color with different shades.
  ///
  /// Used also for grey shades
  static const black = MaterialColor(0xff23253A, {
    50: Color(0xffF5F5F5),
    100: Color(0xffDFDFE5),
    400: Color(0xff26262B),
    500: Color(0xff23253A),
    900: Color(0xff26262B),
  });

  /// Primary gradient color variant 1.
  static const primaryGradient1 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[AppColors.black, AppColors.primary],
  );

  /// Primary gradient color variant 2.
  static const primaryGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.primary, AppColors.black],
  );

  /// Primary gradient color variant 3.
  static const primaryGradient3 = LinearGradient(
    stops: [
      -2.2,
      0.90,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.primary,
      AppColors.black,
    ],
  );

  /// Primary gradient color variant 4.
  static const primaryGradient4 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[
      AppColors.black,
      AppColors.primary,
    ],
  );

  /// Primary gradient color variant 5.
  static const primaryGradient5 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[
      AppColors.primary,
      AppColors.black,
    ],
  );

  /// Accent gradient color.
  static final accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.accent,
      AppColors.accent[900]!,
    ],
  );

  /// Secondary accent gradient color.
  static final secondaryAccentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.secondaryAccent[400]!,
      AppColors.secondaryAccent,
    ],
  );
}
