import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template app_theme}
/// Theme used by the application.
/// {@endtemplate}
abstract class AppTheme {
  /// Light theme.
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Rubik',
    colorScheme: _lightColorScheme,
    iconTheme: _iconTheme,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    extensions: [_lightAppColorsExtension],
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: _lightColorScheme.background,
    dividerTheme: DividerThemeData(
      color: _lightAppColorsExtension.black100,
      thickness: 1,
    ),
  );

  static final _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.accent,
    onSecondary: AppColors.black,
    surface: AppColors.white,
    onSurface: AppColors.black,
    error: AppColors.error,
    onError: AppColors.white,
    background: AppColors.black[50]!,
    onBackground: AppColors.black,
  );

  static final _lightAppColorsExtension = AppColorScheme(
    primary50: AppColors.primary[50]!,
    primary100: AppColors.primary[100]!,
    primary400: AppColors.primary[400]!,
    primary: AppColors.primary,
    primary900: AppColors.primary[900]!,
    primary1000: AppColors.primary[1000]!,
    accent300: AppColors.accent[300]!,
    accent: AppColors.accent,
    accent900: AppColors.accent[900]!,
    secondaryAccent: AppColors.secondaryAccent,
    secondaryAccent400: AppColors.secondaryAccent[400]!,
    secondaryAccent500: AppColors.secondaryAccent[500]!,
    white: AppColors.white,
    black: AppColors.black,
    black50: AppColors.black[50]!,
    black100: AppColors.black[100]!,
    black400: AppColors.black[400]!,
    black500: AppColors.black[500]!,
    black900: AppColors.black[900]!,
    primaryGradient1: AppColors.primaryGradient1,
    primaryGradient2: AppColors.primaryGradient2,
    primaryGradient3: AppColors.primaryGradient3,
    primaryGradient4: AppColors.primaryGradient4,
    primaryGradient5: AppColors.primaryGradient5,
    accentGradient: AppColors.accentGradient,
    secondaryAccentGradient: AppColors.secondaryAccentGradient,
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
