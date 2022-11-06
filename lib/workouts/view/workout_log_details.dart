import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_stats_repository/user_stats_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

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
    return BlocProvider(
      create: (context) => WorkoutLogDetailsBloc(
        workoutLog: workoutLog,
        userStatsRepository: context.read<UserStatsRepository>(),
        workoutsRepository: context.read<WorkoutsRepository>(),
      ),
      child: const _WorkoutLogDetailsView(),
    );
  }
}

class _WorkoutLogDetailsView extends StatelessWidget {
  const _WorkoutLogDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutLog = context.select(
      (WorkoutLogDetailsBloc bloc) => bloc.state.workoutLog,
    );

    final status = context.select(
      (WorkoutLogDetailsBloc bloc) => bloc.state.status,
    );

    return BlocListener<WorkoutLogDetailsBloc, WorkoutLogDetailsState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: WorkoutDateChip(date: workoutLog.datePerformed),
          actions: [
            if (status.isSubmissionInProgress)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colorScheme.primary,
                  ),
                ),
              )
            else
              IconButton(
                icon: const Icon(Icons.delete),
                color: context.colorScheme.error,
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return const _DeleteLogDialog();
                    },
                  ).then(
                    (shouldDelete) {
                      if (shouldDelete == true) {
                        context
                            .read<WorkoutLogDetailsBloc>()
                            .add(WorkoutLogDeleted());
                      }
                    },
                  );
                },
              ),
          ],
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
                  style: context.textTheme.caption,
                ),
              ),
              const _ExercisesList(),
            ],
          ),
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
    final workoutLog = context.select(
      (WorkoutLogDetailsBloc bloc) => bloc.state.workoutLog,
    );

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
            style: context.textTheme.headline3,
          ),
          Text(
            'Previous Workout: ${DateTimeFormatters.monthDayYearTime(
              workoutLog.datePerformed,
            )}',
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
    final workoutLog = context.select(
      (WorkoutLogDetailsBloc bloc) => bloc.state.workoutLog,
    );

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
                color: context.colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  muscle.name.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: context.colorScheme.onPrimary),
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
    final workoutLog = context.select(
      (WorkoutLogDetailsBloc bloc) => bloc.state.workoutLog,
    );
    final iconColor = context.colorScheme.primary;
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
    final workoutLog = context.select(
      (WorkoutLogDetailsBloc bloc) => bloc.state.workoutLog,
    );

    return Column(
      children: [
        ...workoutLog.exercises.asMap().entries.map((exerciseItem) {
          final exercise = exerciseItem.value;
          final index = exerciseItem.key;
          return ExerciseCard(
            exerciseCardData: ExerciseCardData(
              exercise: exercise,
              exerciseIndex: index,
              exerciseCount: workoutLog.exercises.length,
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _DeleteLogDialog extends StatelessWidget {
  const _DeleteLogDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      alignment: Alignment.center,
      title: const Text('Delete Workout Log'),
      content: const Text(
        'Are you sure you want to delete this workout log?'
        ' This action cannot be undone.',
      ),
      actions: [
        AppTextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        AppTextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
