import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// {@template workout_stat_grid_item}
///  Model used for displaying single item in WorkoutStatsGrid.
/// {@endtemplate}
class WorkoutStatGridItem {
  /// {@macro workout_stat_grid_item}
  const WorkoutStatGridItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.titleSuffix,
  });

  /// Title of the item.
  final String title;

  /// Subtitle of the item.
  final String subtitle;

  /// Icon of the item.
  final String? titleSuffix;

  /// Suffix of the title.
  final SvgPicture icon;
}

/// {@template workout_stats_grid}
/// Widget that displays a grid of workout stats.
/// {@endtemplate}
class WorkoutStatsGrid extends StatelessWidget {
  /// {@macro workout_stats_grid}
  const WorkoutStatsGrid({
    Key? key,
    required this.workoutStats,
  }) : super(key: key);

  /// List of workout stats to display.
  final List<WorkoutStatGridItem> workoutStats;

  @override
  Widget build(BuildContext context) {
    const borderWidth = 1.0;

    return SliverToBoxAdapter(
      child: ColoredBox(
        color: Theme.of(context).extension<AppColorScheme>()!.black100,
        child: Column(
          children: [
            for (int i = 0; i < workoutStats.length; i++) ...[
              if (i.isEven)
                Row(
                  children: [
                    _StatsGridItem(
                      icon: workoutStats[i].icon,
                      title: workoutStats[i].title,
                      subtitle: workoutStats[i].subtitle,
                      titleSuffix: workoutStats[i].titleSuffix,
                    ),
                    const SizedBox(
                      width: borderWidth,
                    ),
                    _StatsGridItem(
                      icon: workoutStats[i + 1].icon,
                      title: workoutStats[i + 1].title,
                      subtitle: workoutStats[i + 1].subtitle,
                      titleSuffix: workoutStats[i + 1].titleSuffix,
                    ),
                  ],
                )
              else
                const SizedBox(
                  width: borderWidth,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatsGridItem extends StatelessWidget {
  const _StatsGridItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.titleSuffix,
  }) : super(key: key);

  final SvgPicture icon;

  final String title;

  final String subtitle;

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
