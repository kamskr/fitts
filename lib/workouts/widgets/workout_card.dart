import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/utils/date_time_formatters.dart';
import 'package:flutter/material.dart';

/// {@template workout_card}
/// Widget displaying workout template information.
/// {@endtemplate}
class WorkoutCard extends StatelessWidget {
  /// {@macro workout_card}
  const WorkoutCard({
    Key? key,
    required this.workoutTemplate,
    this.header,
    this.footer,
    this.radius,
    this.height,
  }) : super(key: key);

  /// Workout template to display.
  final WorkoutTemplate workoutTemplate;

  /// Replace header.
  final Widget? header;

  /// Replace footer.
  final Widget? footer;

  /// Pass to change border radius of the card.
  final double? radius;

  /// Height of the card.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tonnageLifted = List<double>.filled(6, 0);

    if (workoutTemplate.recentTotalTonnageLifted != null) {
      final tonnageEntries =
          workoutTemplate.recentTotalTonnageLifted!.asMap().entries;

      for (final entry in tonnageEntries) {
        tonnageLifted[entry.key] = entry.value.toDouble();
      }
    }

    return SizedBox(
      height: height ?? 290,
      width: double.infinity,
      child: AppChartCard(
        radius: radius,
        emptyText: workoutTemplate.recentTotalTonnageLifted == null ||
                (workoutTemplate.recentTotalTonnageLifted != null &&
                    workoutTemplate.recentTotalTonnageLifted!.isEmpty)
            ? l10n.workoutWidgetNoWorkoutsPerformedYet
            : null,
        header: header ??
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workoutTemplate.name,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                if (workoutTemplate.lastPerformed != null)
                  Text(
                    l10n.homePagePreviousWorkoutDate(
                      DateTimeFormatters.weekdayMonthDay(
                        workoutTemplate.lastPerformed!,
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
              ],
            ),
        values: [
          tonnageLifted[0],
          tonnageLifted[1],
          tonnageLifted[2],
          tonnageLifted[3],
          tonnageLifted[4],
          tonnageLifted[5],
          // 5, 5, 5, 5, 5, 5
        ],
        footer: footer ??
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          workoutTemplate.workoutsCompleted.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        Text(
                          l10n.homePageNextWorkoutTimesCompleted,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: AppButton.gradient(
                        child: Text(l10n.homePageStartWorkoutButtonText),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
