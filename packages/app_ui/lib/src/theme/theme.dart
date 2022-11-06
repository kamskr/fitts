import 'package:app_ui/src/theme/theme.dart';
import 'package:flutter/material.dart';

export 'app_color_scheme.dart';
export 'app_theme.dart';

/// Extension on [BuildContext] makes it easier to access the [Theme]
extension AppLocalizationX on BuildContext {
  /// Syntactic sugar for  `Theme.of(this)`.
  ThemeData get theme => Theme.of(this);

  /// Syntactic sugar for  `Theme.of(this).textTheme`.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Syntactic sugar for  `Theme.of(this).colorScheme`.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Syntactic sugar for  `Theme.of(this).extension<AppColorScheme>`.
  AppColorScheme get appColorScheme =>
      Theme.of(this).extension<AppColorScheme>()!;
}
