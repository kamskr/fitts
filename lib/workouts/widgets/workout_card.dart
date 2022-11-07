import 'dart:math';

import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/utils/date_time_formatters.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    if (workoutTemplate.recentTotalTonnageLifted != null &&
        workoutTemplate.recentTotalTonnageLifted!.isNotEmpty) {
      final sortedRecentTonnage = [...workoutTemplate.recentTotalTonnageLifted!]
        ..sort((a, b) => a.timePerformed.compareTo(b.timePerformed));

      for (var i = 0; i < min(sortedRecentTonnage.length, 6); i++) {
        tonnageLifted[i] = sortedRecentTonnage[i].weight;
      }

      // for (final entry in tonnageEntries) {
      //   tonnageLifted[entry.key] = entry.value.;
      // }
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
                  style: context.textTheme.headline5!.copyWith(
                    color: context.colorScheme.onPrimary,
                  ),
                ),
                if (workoutTemplate.lastPerformed != null)
                  Text(
                    l10n.homePagePreviousWorkoutDate(
                      DateTimeFormatters.weekdayMonthDay(
                        workoutTemplate.lastPerformed!,
                      ),
                    ),
                    style: context.textTheme.bodyText2!.copyWith(
                      color: context.colorScheme.onPrimary,
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
                          style: context.textTheme.headline5!.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          l10n.homePageNextWorkoutTimesCompleted,
                          style: context.textTheme.bodyText2!.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: AppButton.gradient(
                        onPressed: context.watch<WorkoutTrainingBloc>().state
                                is! WorkoutTrainingInProgress
                            ? () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                context.read<WorkoutTrainingBloc>().add(
                                      WorkoutTrainingStart(
                                        workoutTemplate: workoutTemplate,
                                      ),
                                    );
                              }
                            : null,
                        child: Text(l10n.homePageStartWorkoutButtonText),
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
