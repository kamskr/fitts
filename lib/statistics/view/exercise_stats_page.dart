import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/text_formatters.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// {@template exercise_stats_page}
/// Page used to display statistics for an exercise.
/// {@endtemplate}
class ExerciseStatsPage extends StatelessWidget {
  /// {@macro exercise_stats_page}
  const ExerciseStatsPage({
    Key? key,
    required this.exercise,
    required this.exerciseStats,
  }) : super(key: key);

  /// Exercise for which the statistics are displayed.
  final Exercise exercise;

  /// Statistics for the exercise.
  final ExerciseStats exerciseStats;

  /// Route helper.
  static Route<dynamic> route({
    required Exercise exercise,
    required ExerciseStats exerciseStats,
  }) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => ExerciseStatsPage(
        exercise: exercise,
        exerciseStats: exerciseStats,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: exerciseStats,
      child: Provider.value(
        value: exercise,
        child: const _ExerciseDetailsView(),
      ),
    );
  }
}

class _ExerciseDetailsView extends StatefulWidget {
  const _ExerciseDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<_ExerciseDetailsView> createState() => _ExerciseDetailsViewState();
}

class _ExerciseDetailsViewState extends State<_ExerciseDetailsView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.black)
        .animate(_animationController);

    _scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    if (_scrollController.position.pixels < 50) {
      _animationController.reverse();
    } else if (_scrollController.position.pixels > 50) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: AnimatedBuilder(
          animation: _colorTween,
          builder: (_, __) => Text(
            context.read<Exercise>().name,
            style: TextStyle(color: _colorTween.value),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: const _ExerciseContent(),
      ),
    );
  }
}

class _ExerciseContent extends StatelessWidget {
  const _ExerciseContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exercise = context.watch<Exercise>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppGap.md(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: Text(
            context.read<Exercise>().name,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: Text(
            TextFormatters.camelToSentence(exercise.category.name),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const AppGap.md(),
        const Divider(height: 1),
        const _Stats(),
        const AppGap.md(),
        const _LevelIndicator(),
        const AppGap.md(),
        const Divider(height: 1),
        const AppGap.md(),
        const _MusclesInvolved(),
        const AppGap.md(),
        const Divider(height: 1),
        if (exercise.aliases != null && exercise.aliases!.isNotEmpty) ...[
          const AppGap.md(),
          const _Aliases()
        ],
        const AppGap.md(),
        const _About(),
        const AppGap.md(),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<ExerciseStats>();

    final iconColor = Theme.of(context).colorScheme.primary;
    const iconHeight = 22.0;

    return WorkoutStatsGrid(
      workoutStats: [
        WorkoutStatGridItem(
          icon: Assets.icons.icWeigh.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: stats.highestWeight.toString(),
          subtitle: 'highest weight',
          titleSuffix: 'kg',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icCheckmark.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: stats.repetitionsDone.toString(),
          subtitle: 'repetitions done',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icWorkoutsCompleted.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: stats.timesPerformed.toString(),
          subtitle: 'times performed',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icHistory.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: '${stats.overallBest.weight}*${stats.overallBest.repetitions}',
          subtitle: 'best lift, kg * reps',
        ),
      ],
    );
  }
}

class _MusclesInvolved extends StatelessWidget {
  const _MusclesInvolved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryMuscles = context.read<Exercise>().primaryMuscles;
    final secondaryMuscles = context.read<Exercise>().secondaryMuscles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MUSCLES INVOLVED',
            style: Theme.of(context).textTheme.caption,
          ),
          const AppGap.md(),
          Wrap(
            runSpacing: AppSpacing.xxs,
            children: [
              for (final muscle in primaryMuscles)
                _ExerciseMuscleChip(muscle: muscle),
              for (final muscle in secondaryMuscles)
                _ExerciseMuscleChip(
                  muscle: muscle,
                  isPrimary: false,
                ),
            ],
          )
        ],
      ),
    );
  }
}

class _ExerciseMuscleChip extends StatelessWidget {
  const _ExerciseMuscleChip({
    Key? key,
    required this.muscle,
    this.isPrimary = true,
  }) : super(key: key);

  final Muscle muscle;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: AppSpacing.xs, bottom: AppSpacing.xxxs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isPrimary
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).extension<AppColorScheme>()!.primary400,
              borderRadius: BorderRadius.circular(AppSpacing.xxs),
            ),
            child: Center(
              child: Text(
                TextFormatters.camelToSentence(muscle.name),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final instructions = context.read<Exercise>().instructions;
    final equipmentType = context.read<Exercise>().equipment;
    final mechanicType = context.read<Exercise>().mechanicType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ABOUT',
            style: Theme.of(context).textTheme.caption,
          ),
          if (equipmentType != null) ...[
            const AppGap.md(),
            Row(
              children: [
                const Icon(Icons.fitness_center),
                const AppGap.xs(),
                Text(
                  TextFormatters.camelToSentence(equipmentType.name),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ],
          if (mechanicType != null) ...[
            const AppGap.md(),
            Row(
              children: [
                const Icon(Icons.zoom_out_map_rounded),
                const AppGap.xs(),
                Text(
                  TextFormatters.camelToSentence(mechanicType.name),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ],
          const AppGap.sm(),
          for (String instruction in instructions) ...[
            const AppGap.xs(),
            Text(instruction),
          ],
        ],
      ),
    );
  }
}

class _Aliases extends StatelessWidget {
  const _Aliases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aliases = context.read<Exercise>().aliases!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ALIASES',
            style: Theme.of(context).textTheme.caption,
          ),
          const AppGap.sm(),
          for (String alias in aliases) ...[
            const AppGap.xs(),
            Text(alias),
          ],
        ],
      ),
    );
  }
}

class _LevelIndicator extends StatelessWidget {
  const _LevelIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final level = context.read<Exercise>().level;
    final levelName = TextFormatters.camelToSentence(level.name);

    late Color color;

    switch (level) {
      case Level.beginner:
        color = Theme.of(context).extension<AppColorScheme>()!.secondaryAccent;
        break;
      case Level.intermediate:
        color = Theme.of(context).extension<AppColorScheme>()!.primary500;
        break;
      case Level.advanced:
        color = Theme.of(context).extension<AppColorScheme>()!.accent500;
        break;
      case Level.expert:
        color = Theme.of(context).colorScheme.error;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LEVEL',
            style: Theme.of(context).textTheme.caption,
          ),
          const AppGap.md(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSpacing.xxs),
            ),
            child: Text(
              levelName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
