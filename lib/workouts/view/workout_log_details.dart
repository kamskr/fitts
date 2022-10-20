import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// {@template workout_log_details}
/// Page to display the details of a [WorkoutLog].
/// {@endtemplate}
class WorkoutLogDetails extends StatelessWidget {
  /// {@macro workout_log_details}
  const WorkoutLogDetails(
    this.workoutLog, {
    Key? key,
  }) : super(key: key);

  /// The [WorkoutLog] to display.
  final WorkoutLog workoutLog;

  /// Route helper
  static Route<dynamic> route(WorkoutLog workoutLog) => MaterialPageRoute<void>(
        builder: (_) => WorkoutLogDetails(workoutLog),
        fullscreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: workoutLog,
      child: const _WorkoutLogDetailsView(),
    );
  }
}

class _WorkoutLogDetailsView extends StatelessWidget {
  const _WorkoutLogDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutLog = Provider.of<WorkoutLog>(context);

    return Scaffold(
      appBar: AppBar(
        title: WorkoutDateChip(date: workoutLog.datePerformed),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const _LogTitle(),
            const _MusclesInvolved(),
            const AppGap.lg(),
            const _Stats(),
            const AppGap.md(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Text(
                'EXERCISES',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            const _ExercisesList(),
          ],
        ),
      ),
    );
  }
}

class _LogTitle extends StatelessWidget {
  const _LogTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutLog = Provider.of<WorkoutLog>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workoutLog.workoutTemplate.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          const Text(
            'Previous Workout',
          ),
        ],
      ),
    );
  }
}

class _MusclesInvolved extends StatelessWidget {
  const _MusclesInvolved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutLog = Provider.of<WorkoutLog>(context);

    final exerciseIds =
        workoutLog.exercises.map((exercise) => exercise.exerciseId);
    final exercises = context.read<Map<String, Exercise>>();
    final exercisesUsed = exerciseIds.map((id) => exercises[id]).toList();

    final primaryMusclesUsed = exercisesUsed.fold<List<Muscle>>(
      [],
      (previousValue, element) {
        if (element != null) {
          previousValue.addAll(element.primaryMuscles);
        }
        return previousValue;
      },
    );

    final secondaryMusclesUsed = exercisesUsed.fold<List<Muscle>>(
      [],
      (previousValue, element) {
        if (element != null) {
          previousValue.addAll(element.secondaryMuscles);
        }
        return previousValue;
      },
    );

    primaryMusclesUsed.addAll(secondaryMusclesUsed);

    final musclesUsed = primaryMusclesUsed.toSet();

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: musclesUsed.length,
        itemBuilder: (context, index) {
          final muscle = musclesUsed.elementAt(index);

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? AppSpacing.lg : 0,
              right: AppSpacing.sm,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  muscle.name.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutLog = Provider.of<WorkoutLog>(context);
    final iconColor = Theme.of(context).colorScheme.primary;
    const iconHeight = 22.0;

    final totalKg = workoutLog.totalWeight;

    late String totalKgString;

    if (totalKg < 1000) {
      totalKgString = totalKg.toString();
    } else {
      totalKgString = '${(totalKg / 1000).round()}k';
    }

    return Column(
      children: [
        const Divider(height: 1),
        WorkoutStatsGrid(
          workoutStats: [
            WorkoutStatGridItem(
              icon: Assets.icons.icTonnageLifted.svg(
                color: iconColor,
                height: iconHeight,
              ),
              title: totalKgString,
              subtitle: 'tonnage lifted',
              titleSuffix: 'kg',
            ),
            WorkoutStatGridItem(
              icon: Assets.icons.icTime.svg(
                color: iconColor,
                height: iconHeight,
              ),
              title: DateTimeFormatters.formatSeconds(
                workoutLog.duration,
              ),
              subtitle: 'time spent',
              titleSuffix: 'h',
            ),
            WorkoutStatGridItem(
              icon: Assets.icons.icTimer.svg(
                color: iconColor,
                height: iconHeight,
              ),
              title: DateTimeFormatters.formatSeconds(
                workoutLog.averageRestTime,
                showHours: false,
                showSeconds: true,
              ),
              subtitle: 'avg. rest time',
              titleSuffix: 'min',
            ),
            WorkoutStatGridItem(
              icon: Assets.icons.icCheckmark.svg(
                color: iconColor,
                height: iconHeight,
              ),
              title: workoutLog.exercises.length.toString(),
              subtitle: 'exercises done',
            ),
          ],
        ),
      ],
    );
  }
}

class _ExercisesList extends StatelessWidget {
  const _ExercisesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutLog = Provider.of<WorkoutLog>(context);

    return Column(
      children: [
        ...workoutLog.exercises.asMap().entries.map((exerciseItem) {
          final exercise = exerciseItem.value;
          final index = exerciseItem.key;
          return ExerciseCard(
            exercise: exercise,
            exerciseIndex: index,
            exerciseCount: workoutLog.exercises.length,
          );
        }).toList(),
      ],
    );
  }
}
