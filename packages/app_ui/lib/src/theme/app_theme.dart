import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent),
    canvasColor: _backgroundColor,
    backgroundColor: _backgroundColor,
    scaffoldBackgroundColor: _backgroundColor,
    iconTheme: _iconTheme,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    splashColor: AppColors.white,
    snackBarTheme: _snackBarTheme,
  );

  static const _backgroundColor = AppColors.white;

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

  static final _snackBarTheme = SnackBarThemeData(
    contentTextStyle: AppTypography.body1.copyWith(
      color: AppColors.white,
    ),
    actionTextColor: AppColors.accent,
    backgroundColor: AppColors.white,
    elevation: 4,
    behavior: SnackBarBehavior.floating,
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
