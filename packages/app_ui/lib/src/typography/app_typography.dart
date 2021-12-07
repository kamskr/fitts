import 'package:flutter/material.dart';

abstract class AppTypography {
  static const _baseTextStyle = TextStyle(
    fontWeight: AppFontWeight.regular,
    package: 'app_ui',
    fontFamily: 'Rubik',
  );

  static final TextStyle headline1 = _baseTextStyle.copyWith(
    fontSize: 50,
    fontFamily: 'Questrial',
  );

  static final TextStyle headline2 = _baseTextStyle.copyWith(
    fontSize: 34,
    fontWeight: AppFontWeight.light,
  );

  static final TextStyle headline3 = _baseTextStyle.copyWith(
    fontSize: 30,
    fontWeight: AppFontWeight.medium,
  );

  static final TextStyle headline4 = _baseTextStyle.copyWith(
    fontSize: 29,
    fontFamily: 'Questrial',
  );

  static final TextStyle headline5 = _baseTextStyle.copyWith(
    fontSize: 24,
  );

  static final TextStyle headline6 = _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: AppFontWeight.medium,
  );

  static final TextStyle subtitle1 = _baseTextStyle.copyWith(
    fontSize: 16,
  );

  static final TextStyle subtitle2 = _baseTextStyle.copyWith(
    fontSize: 13,
  );

  static final TextStyle body1 = _baseTextStyle.copyWith(
    fontSize: 16,
  );

  static final TextStyle body2 = _baseTextStyle.copyWith(
    fontSize: 14,
  );

  static final TextStyle button = _baseTextStyle.copyWith(
    fontSize: 15,
    fontWeight: AppFontWeight.medium,
  );

  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 13,
  );

  static final TextStyle overline = _baseTextStyle.copyWith(
    fontSize: 12,
    fontFamily: 'Questrial',
  );
}

abstract class AppFontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w600;
  static const FontWeight black = FontWeight.w900;
}
