import 'package:app_ui/app_ui.dart';
import 'package:fitts/my_workouts/bloc/workout_details_bloc.dart';
import 'package:fitts/my_workouts/widgets/widgets.dart';
import 'package:fitts/utils/utils.dart';
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                'EXERCISES',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: _ExerciseCard(),
          ),
          const SliverToBoxAdapter(
            child: _ExerciseCard(),
          ),
          const SliverToBoxAdapter(
            child: _ExerciseCard(),
          ),
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
  const _WorkoutStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderWidth = 1.0;
    final iconColor = Theme.of(context).colorScheme.primary;
    const iconHeight = 22.0;

    return SliverToBoxAdapter(
      child: ColoredBox(
        color: Theme.of(context).extension<AppColorScheme>()!.black100,
        child: Column(
          children: [
            Row(
              children: [
                StatsGridItem(
                  icon: Assets.icons.icTonnageLifted.svg(
                    color: iconColor,
                    height: iconHeight,
                  ),
                  title: '7',
                  subtitle: 'workouts completed',
                ),
                const SizedBox(
                  width: borderWidth,
                ),
                StatsGridItem(
                  icon: Assets.icons.icWorkoutsCompleted.svg(
                    color: iconColor,
                    height: iconHeight,
                  ),
                  title: '10k',
                  subtitle: 'tonnage lifted',
                  titleSuffix: 'kg',
                ),
              ],
            ),
            const SizedBox(
              height: borderWidth,
            ),
            Row(
              children: [
                StatsGridItem(
                  icon: Assets.icons.icRestTime.svg(
                    color: iconColor,
                    height: iconHeight,
                  ),
                  title: '02:22',
                  subtitle: 'avg. rest time',
                  titleSuffix: 'min',
                ),
                const SizedBox(
                  width: borderWidth,
                ),
                StatsGridItem(
                  icon: Assets.icons.icDuration.svg(
                    color: iconColor,
                    height: iconHeight,
                  ),
                  title: '01:12',
                  subtitle: 'avg. workout length',
                  titleSuffix: 'h',
                ),
              ],
            ),
            const SizedBox(
              height: borderWidth,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
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
          children: const [
            _CardTitle(),
            AppGap.lg(),
            _SetListItem(),
            _SetListItem(),
            _SetListItem(),
            _SetListItem(),
          ],
        ),
      ),
    );
  }
}

class _SetListItem extends StatelessWidget {
  const _SetListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'SET 1',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Column(
            children: [
              Text(
                '10',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'reps',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '100',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'kg',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1 of 3',
              style: theme.textTheme.overline,
            ),
            const SizedBox(
              height: AppSpacing.xxxs,
            ),
            Text(
              'Exercise 1',
              style: theme.textTheme.headline6,
            ),
          ],
        ),

        /// Place for history button in the future.
      ],
    );
  }
}
