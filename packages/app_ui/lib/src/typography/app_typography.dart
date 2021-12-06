import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

abstract class AppTypography {
  static const _baseTextStyle = TextStyle(
    fontWeight: AppFontWeight.medium,
    height: 1.25,
    package: 'App_bank_ui',
    fontFamily: 'Roboto',
    color: AppColors.white,
  );

  /// Headlines
  static final TextStyle headlineBold = _baseTextStyle.copyWith(
    fontSize: 25,
    fontWeight: AppFontWeight.bold,
  );
  static final TextStyle headlineSemibold = _baseTextStyle.copyWith(
    fontSize: 21,
    fontWeight: AppFontWeight.semibold,
  );
  static final TextStyle headlineRegular = _baseTextStyle.copyWith(
    fontSize: 21,
    fontWeight: AppFontWeight.regular,
  );

  /// Body
  static final TextStyle textBold = _baseTextStyle.copyWith(
    fontSize: 17,
    fontWeight: AppFontWeight.bold,
  );
  static final TextStyle textMedium = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle textRegular = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle textSmallSemibold = _baseTextStyle.copyWith(
    fontSize: 15,
    fontWeight: AppFontWeight.semibold,
  );
  static final TextStyle textSmall = _baseTextStyle.copyWith(
    fontSize: 15,
    fontWeight: AppFontWeight.regular,
  );

  /// Caption
  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle captionSmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle captionSmaller = _baseTextStyle.copyWith(
    fontSize: 11,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle captionTiny = _baseTextStyle.copyWith(
    fontSize: 10,
    fontWeight: AppFontWeight.medium,
  );
}

abstract class AppFontWeight {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
