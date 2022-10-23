import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

part '_exercise_notes.dart';
part '_set_details.dart';
part '_set_list_item.dart';
part '_card_title.dart';

/// {@template exercise_card}
/// Widget used to display an exercise in the workout.
/// It can be used in edit mode to update [WorkoutExercise].
/// {@endtemplate}
class ExerciseCard extends StatelessWidget {
  /// {@macro exercise_card}
  const ExerciseCard({
    Key? key,
    required this.exerciseCardData,
  }) : super(key: key);

  /// Data for the exercise card.
  final ExerciseCardData exerciseCardData;

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
          const _CardTitle(),
          const _ExerciseNotes(),
          if (exerciseCardData.exercise.sets.isEmpty &&
              exerciseCardData.onExerciseChanged == null)
            const Center(
              child: Text('No sets'),
            ),
          if (exerciseCardData.exercise.sets.isNotEmpty)
            const _ExerciseSetsList(),
          if (exerciseCardData.onExerciseChanged != null) ...[
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

                exerciseCardData.onExerciseChanged!(
                  exerciseCardData.exerciseIndex,
                  exerciseCardData.exercise.copyWith(
                    sets: [
                      ...exerciseCardData.exercise.sets,
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

    return Provider<ExerciseCardData>.value(
      value: exerciseCardData,
      child: Card(
        color: theme.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppSpacing.xxs)),
          side: BorderSide(
            color: Theme.of(context).extension<AppColorScheme>()!.black100,
          ),
        ),
        child: child,
      ),
    );
  }
}

class _ExerciseSetsList extends StatelessWidget {
  const _ExerciseSetsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exerciseCardData = context.watch<ExerciseCardData>();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: exerciseCardData.exercise.sets.length,
      itemBuilder: (context, index) {
        final set = exerciseCardData.exercise.sets[index];
        return Provider.value(
          key: ValueKey(set),
          value: ExerciseSetData(
            setIndex: index,
            set: set,
          ),
          child: const _SetListItem(),
        );
      },
    );
  }
}

class _SetIndicator extends StatelessWidget {
  const _SetIndicator({
    Key? key,
    required this.isEditingSet,
  }) : super(key: key);

  final bool isEditingSet;

  @override
  Widget build(BuildContext context) {
    final setData = context.watch<ExerciseSetData>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SET ${setData.setIndex + 1}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          if (setData.set.isDone == true && isEditingSet == false) ...[
            const AppGap.md(),
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
        ],
      ),
    );
  }
}
