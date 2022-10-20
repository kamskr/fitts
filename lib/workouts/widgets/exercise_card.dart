import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// {@template exercise_card}
/// Widget used to display an exercise in the workout.
/// It can be used in edit mode to update [WorkoutExercise].
/// {@endtemplate}
class ExerciseCard extends StatelessWidget {
  /// {@macro exercise_card}
  const ExerciseCard({
    Key? key,
    required this.exerciseIndex,
    required this.exerciseCount,
    required this.exercise,
  }) : super(key: key);

  /// Index of the exercise in the workout.
  final int exerciseIndex;

  /// Total number of exercises in the workout.
  final int exerciseCount;

  /// Exercise to display.
  final WorkoutExercise exercise;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Provider<WorkoutExercise>.value(
      value: exercise,
      child: Card(
        color: theme.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.xxs)),
          side: BorderSide(
            color: Theme.of(context).extension<AppColorScheme>()!.black100,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.lg,
          ),
          child: Column(
            children: [
              _CardTitle(
                exerciseIndex: exerciseIndex,
                exerciseCount: exerciseCount,
              ),
              const AppGap.lg(),
              ...exercise.sets.asMap().entries.map((setItem) {
                final set = setItem.value;
                final index = setItem.key;
                return _SetListItem(
                  setNumber: index + 1,
                  repsCount: set.repetitions,
                  weight: set.weight,
                  isDone: set.isDone,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SetListItem extends StatelessWidget {
  const _SetListItem({
    Key? key,
    required this.setNumber,
    required this.repsCount,
    required this.weight,
    this.isDone,
  }) : super(key: key);

  final int setNumber;
  final int repsCount;
  final double weight;
  final bool? isDone;

  @override
  Widget build(BuildContext context) {
    const containerWidth = 80.0;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.lg,
      ),
      color: isDone == true
          ? Theme.of(context)
              .extension<AppColorScheme>()!
              .black100
              .withOpacity(0.4)
          : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: containerWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SET $setNumber',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                if (isDone == true)
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      gradient: Theme.of(context)
                          .extension<AppColorScheme>()!
                          .secondaryAccentGradient,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSpacing.xxs),
                      ),
                    ),
                    child: Assets.icons.icCheckmark.svg(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: containerWidth,
            child: Column(
              children: [
                Text(
                  '$repsCount',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'reps',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          SizedBox(
            width: containerWidth,
            child: Column(
              children: [
                Text(
                  '$weight',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'kg',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    Key? key,
    required this.exerciseIndex,
    required this.exerciseCount,
  }) : super(key: key);

  final int exerciseIndex;
  final int exerciseCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exerciseId = context.read<WorkoutExercise>().exerciseId;
    final exercises = context.read<Map<String, Exercise>>();
    final exerciseName = exercises[exerciseId]?.name;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${exerciseIndex + 1} of $exerciseCount',
              style: theme.textTheme.overline,
            ),
            const SizedBox(
              height: AppSpacing.xxxs,
            ),
            Text(
              exerciseName ?? 'exercise not found',
              style: theme.textTheme.headline6,
            ),
          ],
        ),

        /// Place for history button in the future.
      ],
    );
  }
}
