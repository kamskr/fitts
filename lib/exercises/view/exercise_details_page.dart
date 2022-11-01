import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/exercises/exercises.dart';
import 'package:fitts/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// {@template exercise_details_page}
/// Page that displays the details of an Exercise.
/// {@endtemplate}
class ExerciseDetailsPage extends StatelessWidget {
  /// {@macro exercise_details_page}
  const ExerciseDetailsPage({
    Key? key,
    required this.exercise,
    this.viewOnly = false,
  }) : super(key: key);

  /// Exercise to display.
  final Exercise exercise;

  /// Whether the page is in view only mode.
  final bool viewOnly;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: exercise,
      child: _ExerciseDetailsView(viewOnly: viewOnly),
    );
  }
}

class _ExerciseDetailsView extends StatefulWidget {
  const _ExerciseDetailsView({
    required this.viewOnly,
    Key? key,
  }) : super(key: key);

  final bool viewOnly;

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

    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
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
        actions: [
          if (!widget.viewOnly) const _AddExerciseButton(),
        ],
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

class _AddExerciseButton extends StatelessWidget {
  const _AddExerciseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ExercisesBloc>();
    final exercise = context.watch<Exercise>();

    final isSelected = bloc.state.selectedKeys.contains(exercise.id);

    return ExerciseSelectButton(
      isSelected: isSelected,
      onPressed: () {
        if (isSelected) {
          bloc.add(
            ExercisesSelectionKeyRemoved(exercise.id),
          );
        } else {
          bloc.add(
            ExercisesSelectionKeyAdded(exercise.id),
          );
        }
      },
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
