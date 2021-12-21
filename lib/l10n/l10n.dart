import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Exension on [BuildContext] whis  makes it easier to access the [AppLocalizations]
extension AppLocalizationX on BuildContext {
  /// Syntactic sugar for  AppLocalizations.of(context)
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
