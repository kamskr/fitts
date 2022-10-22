import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.onExerciseChanged,
    this.onExerciseDeleted,
    this.onExerciseSetDeleted,
  }) : super(key: key);

  /// Index of the exercise in the workout.
  final int exerciseIndex;

  /// Total number of exercises in the workout.
  final int exerciseCount;

  /// Exercise to display.
  final WorkoutExercise exercise;

  /// Callback to call when the exercise is changed.
  final void Function(int, WorkoutExercise)? onExerciseChanged;

  /// Callback to call when the exercise is deleted.
  final void Function(int)? onExerciseDeleted;

  /// Callback to call when the set of exercise is deleted.
  final void Function(
    int exerciseIndex,
    int setIndex,
  )? onExerciseSetDeleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final child = Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.lg,
      ),
      child: Column(
        children: [
          _CardTitle(
            exerciseIndex: exerciseIndex,
            exerciseCount: exerciseCount,
            onExerciseChanged: onExerciseChanged,
          ),
          const AppGap.lg(),
          if (exercise.sets.isEmpty && onExerciseChanged == null)
            const Center(
              child: Text('No sets'),
            ),
          ...exercise.sets.asMap().entries.map((setItem) {
            final set = setItem.value;
            final index = setItem.key;
            return _SetListItem(
              exerciseIndex: exerciseIndex,
              setNumber: index + 1,
              repsCount: set.repetitions,
              weight: set.weight,
              isDone: set.isDone,
              onExerciseSetDeleted: onExerciseSetDeleted,
            );
          }).toList(),
          if (onExerciseChanged != null) ...[
            const Divider(
              height: 1,
            ),
            AppTextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                const set = ExerciseSet(
                  repetitions: 10,
                  weight: 10,
                );

                onExerciseChanged!(
                  exerciseIndex,
                  exercise.copyWith(
                    sets: [
                      ...exercise.sets,
                      set,
                    ],
                  ),
                );
              },
              child: const Text('ADD SET'),
            )
          ],
        ],
      ),
    );

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
        child: onExerciseDeleted != null
            ? Dismissible(
                direction: DismissDirection.endToStart,
                key: UniqueKey(),
                background: ColoredBox(
                  color: Theme.of(context).colorScheme.error,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      AppGap.md(),
                    ],
                  ),
                ),
                onDismissed: (direction) => onExerciseDeleted!(exerciseIndex),
                child: child,
              )
            : child,
      ),
    );
  }
}

class _SetListItem extends StatelessWidget {
  const _SetListItem({
    Key? key,
    required this.exerciseIndex,
    required this.setNumber,
    required this.repsCount,
    required this.weight,
    this.isDone,
    this.onExerciseSetDeleted,
  }) : super(key: key);

  final int exerciseIndex;
  final int setNumber;
  final int repsCount;
  final double weight;
  final bool? isDone;
  final void Function(
    int exerciseIndex,
    int setIndex,
  )? onExerciseSetDeleted;

  @override
  Widget build(BuildContext context) {
    const containerWidth = 80.0;

    final child = Container(
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

    if (onExerciseSetDeleted != null) {
      return Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          onExerciseSetDeleted!(exerciseIndex, setNumber - 1);
        },
        background: ColoredBox(
          color: Theme.of(context).colorScheme.error,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              AppGap.md(),
            ],
          ),
        ),
        child: child,
      );
    }

    return child;
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    Key? key,
    required this.exerciseIndex,
    required this.exerciseCount,
    this.onExerciseChanged,
  }) : super(key: key);

  final int exerciseIndex;
  final int exerciseCount;
  final void Function(int, WorkoutExercise)? onExerciseChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exerciseId = context.read<WorkoutExercise>().exerciseId;
    final exercises = context.read<Map<String, Exercise>>();
    final exerciseName = exercises[exerciseId]?.name;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        if (onExerciseChanged != null)
          ReorderableDragStartListener(
            index: exerciseIndex,
            child: const Icon(Icons.menu),
          ),
      ],
    );
  }
}
