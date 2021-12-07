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
    titleTextStyle: AppTypography.headline.copyWith(
      color: AppColors.black,
    ),
    toolbarTextStyle: AppTypography.body.copyWith(
      color: AppColors.primary,
    ),
    color: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.primary),
    elevation: 0,
  );

  static final _snackBarTheme = SnackBarThemeData(
    contentTextStyle: AppTypography.body.copyWith(
      color: AppColors.white,
    ),
    actionTextColor: AppColors.accent,
    backgroundColor: AppColors.white,
    elevation: 4,
    behavior: SnackBarBehavior.floating,
  );

  static final _textTheme = TextTheme(
    headline1: AppTypography.title1,
    headline2: AppTypography.title2,
    headline3: AppTypography.title3,
    headline4: AppTypography.title4,
    headline5: AppTypography.title5,
    headline6: AppTypography.headline,
    subtitle1: AppTypography.subhead,
    subtitle2: AppTypography.subhead,
    bodyText1: AppTypography.body,
    bodyText2: AppTypography.body,
    button: AppTypography.body,
    caption: AppTypography.footnote,
    overline: AppTypography.caption2,
  );
}
