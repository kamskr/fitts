import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum AppGapSize {
  xxxs,
  xxs,
  xs,
  sm,
  md,
  lg,
  xlg,
  xxlg,
  xxxlg,
}

extension AppGapSizeExtension on AppGapSize {
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

class AppGap extends StatelessWidget {
  const AppGap(
    this.size, {
    Key? key,
  }) : super(key: key);

  const AppGap.xxxs({
    Key? key,
  })  : size = AppGapSize.xxxs,
        super(key: key);

  const AppGap.xxs({
    Key? key,
  })  : size = AppGapSize.xxs,
        super(key: key);

  const AppGap.xs({
    Key? key,
  })  : size = AppGapSize.xs,
        super(key: key);

  const AppGap.sm({
    Key? key,
  })  : size = AppGapSize.sm,
        super(key: key);

  const AppGap.md({
    Key? key,
  })  : size = AppGapSize.md,
        super(key: key);

  const AppGap.lg({
    Key? key,
  })  : size = AppGapSize.lg,
        super(key: key);

  const AppGap.xlg({
    Key? key,
  })  : size = AppGapSize.xlg,
        super(key: key);

  const AppGap.xxlg({
    Key? key,
  })  : size = AppGapSize.xxlg,
        super(key: key);

  const AppGap.xxxlg({
    Key? key,
  })  : size = AppGapSize.xxxlg,
        super(key: key);

  final AppGapSize size;

  @override
  Widget build(BuildContext context) {
    return Gap(size.getSpacing());
  }
}
