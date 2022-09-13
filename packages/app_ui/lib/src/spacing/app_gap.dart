import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// {@template app_gap_size}
/// Gap size used by the application.
/// {@endtemplate}
enum AppGapSize {
  /// xxxs gap.
  xxxs,

  /// xxs gap.
  xxs,

  /// xs gap.
  xs,

  /// sm gap.
  sm,

  /// md gap.
  md,

  /// lg gap.
  lg,

  /// xlg gap.
  xlg,

  /// xxlg gap.
  xxlg,

  /// xxxlg gap.
  xxxlg,
}

/// {@template app_gap_size_extension}
///  Extension for [AppGapSize] to be converted to [AppSpacing].
/// {@endtemplate}
extension AppGapSizeExtension on AppGapSize {
  /// {@macro app_gap_size_extension}
  double getSpacing() {
    switch (this) {
      case AppGapSize.xxxs:
        return AppSpacing.xxxs;
      case AppGapSize.xxs:
        return AppSpacing.xxs;
      case AppGapSize.xs:
        return AppSpacing.xs;
      case AppGapSize.sm:
        return AppSpacing.sm;
      case AppGapSize.md:
        return AppSpacing.md;
      case AppGapSize.lg:
        return AppSpacing.lg;
      case AppGapSize.xlg:
        return AppSpacing.xlg;
      case AppGapSize.xxlg:
        return AppSpacing.xxlg;
      case AppGapSize.xxxlg:
        return AppSpacing.xxxlg;
    }
  }
}

/// {@template app_gap}
/// Gap used by the application.
/// {@endtemplate}
class AppGap extends StatelessWidget {
  /// {@macro app_gap}
  const AppGap(
    this.size, {
    Key? key,
  }) : super(key: key);

  /// [AppGap] with size of [AppGapSize.xxxs].
  const AppGap.xxxs({
    Key? key,
  })  : size = AppGapSize.xxxs,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.xxs].
  const AppGap.xxs({
    Key? key,
  })  : size = AppGapSize.xxs,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.xs].
  const AppGap.xs({
    Key? key,
  })  : size = AppGapSize.xs,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.sm].
  const AppGap.sm({
    Key? key,
  })  : size = AppGapSize.sm,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.md].
  const AppGap.md({
    Key? key,
  })  : size = AppGapSize.md,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.lg].
  const AppGap.lg({
    Key? key,
  })  : size = AppGapSize.lg,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.xlg].
  const AppGap.xlg({
    Key? key,
  })  : size = AppGapSize.xlg,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.xxlg].
  const AppGap.xxlg({
    Key? key,
  })  : size = AppGapSize.xxlg,
        super(key: key);

  /// [AppGap] with size of [AppGapSize.xxxlg].
  const AppGap.xxxlg({
    Key? key,
  })  : size = AppGapSize.xxxlg,
        super(key: key);

  /// Size of the gap.
  final AppGapSize size;

  @override
  Widget build(BuildContext context) {
    return Gap(size.getSpacing());
  }
}
