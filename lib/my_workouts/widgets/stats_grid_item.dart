import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// {@template stats_grid_item}
/// Item of the stats grid.
/// {@endtemplate}
class StatsGridItem extends StatelessWidget {
  /// {@macro stats_grid_item}
  const StatsGridItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.titleSuffix,
  }) : super(key: key);

  /// Icon of the item.
  final SvgPicture icon;

  /// Title of the item.
  final String title;

  /// Subtitle of the item.
  final String subtitle;

  /// Suffix of the title.
  final String? titleSuffix;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 94,
        color: Theme.of(context).colorScheme.background,
        // height: 94,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: icon,
                  ),
                  const AppGap.xs(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          if (titleSuffix != null) ...[
                            const AppGap.xxxs(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                titleSuffix!,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            )
                          ],
                        ],
                      ),
                      const AppGap.xxs(),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
