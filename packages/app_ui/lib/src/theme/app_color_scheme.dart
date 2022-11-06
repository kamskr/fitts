// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// This is place where you should put all custom color scheme properties
@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme({
    required this.primary50,
    required this.primary100,
    required this.primary400,
    required this.primary,
    required this.primary900,
    required this.accent300,
    required this.accent,
    required this.accent900,
    required this.secondaryAccent,
    required this.secondaryAccent400,
    required this.secondaryAccent500,
    required this.white,
    required this.black,
    required this.black50,
    required this.black100,
    required this.black400,
    required this.black500,
    required this.black900,
    required this.primaryGradient1,
    required this.primaryGradient2,
    required this.primaryGradient3,
    required this.primaryGradient4,
    required this.primaryGradient5,
    required this.accentGradient,
    required this.secondaryAccentGradient,
  });

  // Extra colors here
  final Color primary;
  final Color primary50;
  final Color primary100;
  final Color primary400;
  final Color primary900;

  final Color accent;
  final Color accent300;
  final Color accent900;

  final Color secondaryAccent;
  final Color secondaryAccent400;
  final Color secondaryAccent500;

  final Color white;

  final Color black;
  final Color black50;
  final Color black100;
  final Color black400;
  final Color black500;
  final Color black900;

  final LinearGradient primaryGradient1;
  final LinearGradient primaryGradient2;
  final LinearGradient primaryGradient3;
  final LinearGradient primaryGradient4;
  final LinearGradient primaryGradient5;

  final LinearGradient accentGradient;
  final LinearGradient secondaryAccentGradient;

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? primary50,
    Color? primary100,
    Color? primary400,
    Color? primary,
    Color? primary900,
    Color? accent300,
    Color? accent,
    Color? accent900,
    Color? secondaryAccent,
    Color? secondaryAccent400,
    Color? secondaryAccent500,
    Color? white,
    Color? black,
    Color? black50,
    Color? black100,
    Color? black400,
    Color? black500,
    Color? black900,
    LinearGradient? primaryGradient1,
    LinearGradient? primaryGradient2,
    LinearGradient? primaryGradient3,
    LinearGradient? primaryGradient4,
    LinearGradient? primaryGradient5,
    LinearGradient? accentGradient,
    LinearGradient? secondaryAccentGradient,
  }) {
    return AppColorScheme(
      primary50: primary50 ?? this.primary50,
      primary100: primary100 ?? this.primary100,
      primary400: primary400 ?? this.primary400,
      primary: primary ?? this.primary,
      primary900: primary900 ?? this.primary900,
      accent300: accent300 ?? this.accent300,
      accent: accent ?? this.accent,
      accent900: accent900 ?? this.accent900,
      secondaryAccent: secondaryAccent ?? this.secondaryAccent,
      secondaryAccent400: secondaryAccent400 ?? this.secondaryAccent400,
      secondaryAccent500: secondaryAccent500 ?? this.secondaryAccent500,
      white: white ?? this.white,
      black: black ?? this.black,
      black50: black50 ?? this.black50,
      black100: black100 ?? this.black100,
      black400: black400 ?? this.black400,
      black500: black500 ?? this.black500,
      black900: black900 ?? this.black900,
      primaryGradient1: primaryGradient1 ?? this.primaryGradient1,
      primaryGradient2: primaryGradient2 ?? this.primaryGradient2,
      primaryGradient3: primaryGradient3 ?? this.primaryGradient3,
      primaryGradient4: primaryGradient4 ?? this.primaryGradient4,
      primaryGradient5: primaryGradient5 ?? this.primaryGradient5,
      accentGradient: accentGradient ?? this.accentGradient,
      secondaryAccentGradient:
          secondaryAccentGradient ?? this.secondaryAccentGradient,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }

    // Generate constructor with lerp function for each field
    return AppColorScheme(
      primary50: Color.lerp(primary50, other.primary50, t)!,
      primary100: Color.lerp(primary100, other.primary100, t)!,
      primary400: Color.lerp(primary400, other.primary400, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primary900: Color.lerp(primary900, other.primary900, t)!,
      accent300: Color.lerp(accent300, other.accent300, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accent900: Color.lerp(accent900, other.accent900, t)!,
      secondaryAccent: Color.lerp(secondaryAccent, other.secondaryAccent, t)!,
      secondaryAccent400:
          Color.lerp(secondaryAccent400, other.secondaryAccent400, t)!,
      secondaryAccent500:
          Color.lerp(secondaryAccent500, other.secondaryAccent500, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      black50: Color.lerp(black50, other.black50, t)!,
      black100: Color.lerp(black100, other.black100, t)!,
      black400: Color.lerp(black400, other.black400, t)!,
      black500: Color.lerp(black500, other.black500, t)!,
      black900: Color.lerp(black900, other.black900, t)!,
      primaryGradient1:
          LinearGradient.lerp(primaryGradient1, other.primaryGradient1, t)!,
      primaryGradient2:
          LinearGradient.lerp(primaryGradient2, other.primaryGradient2, t)!,
      primaryGradient3:
          LinearGradient.lerp(primaryGradient3, other.primaryGradient3, t)!,
      primaryGradient4:
          LinearGradient.lerp(primaryGradient4, other.primaryGradient4, t)!,
      primaryGradient5:
          LinearGradient.lerp(primaryGradient5, other.primaryGradient5, t)!,
      accentGradient:
          LinearGradient.lerp(accentGradient, other.accentGradient, t)!,
      secondaryAccentGradient: LinearGradient.lerp(
        secondaryAccentGradient,
        other.secondaryAccentGradient,
        t,
      )!,
    );
  }
}
