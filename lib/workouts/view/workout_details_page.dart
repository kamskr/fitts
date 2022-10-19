import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template workout_details_page}
/// Page that displays the details of a WorkoutTemplate.
/// {@endtemplate}
class WorkoutDetailsPage extends StatelessWidget {
  /// {@macro workout_details_page}
  const WorkoutDetailsPage(
    this.workoutTemplateId, {
    Key? key,
  }) : super(key: key);

  /// Route helper.
  static Route<dynamic> route(String workoutTemplateId) =>
      MaterialPageRoute<void>(
        builder: (_) => WorkoutDetailsPage(workoutTemplateId),
      );

  /// ID of the current workout template.
  final String workoutTemplateId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutDetailsBloc>(
      create: (_) => WorkoutDetailsBloc(
        workoutTemplateId: workoutTemplateId,
        workoutsRepository: context.read<WorkoutsRepository>(),
      )..add(const WorkoutTemplateSubscriptionRequested()),
      child: const _WorkoutDetailsView(),
    );
  }
}

class _WorkoutDetailsView extends StatelessWidget {
  const _WorkoutDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorkoutDetailsBloc>().state;

    if (state.status == DataLoadingStatus.loading ||
        state.status == DataLoadingStatus.initial) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Details'),
      ),
      body: CustomScrollView(
        slivers: [
          const _WorkoutChart(),
          const _StartWorkoutButton(),
          const _WorkoutStats(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSpacing.md,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Text(
                'EXERCISES',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          ...state.workoutTemplate!.exercises
              .asMap()
              .entries
              .map((exerciseItem) {
            final exercise = exerciseItem.value;
            final index = exerciseItem.key;
            return SliverToBoxAdapter(
              child: ExerciseCard(
                exercise: exercise,
                exerciseIndex: index,
                exerciseCount: state.workoutTemplate!.exercises.length,
              ),
            );
          }).toList(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutChart extends StatelessWidget {
  const _WorkoutChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: WorkoutCard(
        workoutTemplate:
            context.watch<WorkoutDetailsBloc>().state.workoutTemplate!,
        footer: const SizedBox(),
        radius: 0,
      ),
    );
  }
}

class _StartWorkoutButton extends StatelessWidget {
  const _StartWorkoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomSliverHeaderDelegate(
        minHeight: 48,
        maxHeight: 80,
        child: AppButton.gradient(
          height: 80,
          child: const Text('START'),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _WorkoutStats extends StatelessWidget {
  const _WorkoutStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutTemplate =
        context.watch<WorkoutDetailsBloc>().state.workoutTemplate!;
    final totalKg = workoutTemplate.tonnageLifted;
    final iconColor = Theme.of(context).colorScheme.primary;
    const iconHeight = 22.0;

    late String totalKgString;

    if (totalKg < 1000) {
      totalKgString = totalKg.toString();
    } else {
      totalKgString = '${(totalKg / 1000).round()}k';
    }

    return WorkoutStatsGrid(
      workoutStats: [
        WorkoutStatGridItem(
          icon: Assets.icons.icTonnageLifted.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: workoutTemplate.workoutsCompleted.toString(),
          subtitle: 'workouts completed',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icWorkoutsCompleted.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: totalKgString,
          subtitle: 'tonnage lifted',
          titleSuffix: 'kg',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icRestTime.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: DateTimeFormatters.formatSeconds(
            workoutTemplate.lastAverageRestTime ?? 0,
          ),
          subtitle: 'avg. rest time',
          titleSuffix: 'min',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icDuration.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: DateTimeFormatters.formatSeconds(
            workoutTemplate.averageWorkoutLength ?? 0,
          ),
          subtitle: 'avg. workout length',
          titleSuffix: 'h',
        ),
      ],
    );
  }
}
