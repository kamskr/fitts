import 'package:flutter/material.dart';

abstract class AppTypography {
  static const _baseTextStyle = TextStyle(
    fontWeight: AppFontWeight.regular,
    package: 'app_ui',
    fontFamily: 'Rubik',
  );

  static final TextStyle title1 = _baseTextStyle.copyWith(
    fontSize: 50,
    fontFamily: 'Questrial',
  );

  static final TextStyle title2 = _baseTextStyle.copyWith(
    fontSize: 34,
    fontWeight: AppFontWeight.light,
  );

  static final TextStyle title3 = _baseTextStyle.copyWith(
    fontSize: 29,
    fontFamily: 'Questrial',
  );

  static final TextStyle title4 = _baseTextStyle.copyWith(
    fontSize: 24,
  );

  static final TextStyle title5 = _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: AppFontWeight.medium,
  );

  static final TextStyle headline = _baseTextStyle.copyWith(
    fontSize: 30,
    fontWeight: AppFontWeight.medium,
  );

  static final TextStyle body = _baseTextStyle.copyWith(
    fontSize: 15,
  );

  static final TextStyle subhead = _baseTextStyle.copyWith(
    fontSize: 13,
  );

  static final TextStyle footnote = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.light,
  );

  static final TextStyle caption1 = _baseTextStyle.copyWith(
    fontSize: 13,
  );

  static final TextStyle caption2 = _baseTextStyle.copyWith(
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
