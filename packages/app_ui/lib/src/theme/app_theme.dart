import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Rubik',
    colorScheme: _colorScheme,
    iconTheme: _iconTheme,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
  );

  static final _colorScheme = ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    background: AppColors.black[50],
    surface: AppColors.white,
    brightness: Brightness.light,
  );

  static const _iconTheme = IconThemeData(color: AppColors.primary);

  static final _appBarTheme = AppBarTheme(
    titleTextStyle: AppTypography.headline3.copyWith(
      color: AppColors.black,
      fontSize: 18,
    ),
    toolbarTextStyle: AppTypography.body1.copyWith(
      color: AppColors.primary,
    ),
    color: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.primary),
    elevation: 0,
  );

  static final _textTheme = TextTheme(
    headline1: AppTypography.headline1,
    headline2: AppTypography.headline2,
    headline3: AppTypography.headline3,
    headline4: AppTypography.headline4,
    headline5: AppTypography.headline5,
    headline6: AppTypography.headline6,
    subtitle1: AppTypography.subtitle1,
    subtitle2: AppTypography.subtitle2,
    bodyText1: AppTypography.body1,
    bodyText2: AppTypography.body2,
    button: AppTypography.button,
    caption: AppTypography.caption,
    overline: AppTypography.overline,
  );
}
