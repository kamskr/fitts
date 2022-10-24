import 'dart:ui';

import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:exercises_repository/exercises_repository.dart';
import 'package:fitts/exercises/exercises.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template add_exercises_page}
/// Page for adding exercises.
/// {@endtemplate}
class AddExercisesPage extends StatelessWidget {
  /// {@macro add_exercises_page}
  const AddExercisesPage({Key? key}) : super(key: key);

  /// Route helpers
  static Route<List<String>> route() => MaterialPageRoute<List<String>>(
        builder: (_) => const AddExercisesPage(),
        fullscreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExercisesBloc>(
      create: (_) => ExercisesBloc(
        exercisesRepository: context.read<ExercisesRepository>(),
      )..add(const ExercisesInitialized()),
      child: const _AddExercisesView(),
    );
  }
}

class _AddExercisesView extends StatelessWidget {
  const _AddExercisesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBar(),
          _ExercisesList(),
        ],
      ),
    );
  }
}

class _ExercisesList extends StatelessWidget {
  const _ExercisesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleExercises =
        context.watch<ExercisesBloc>().state.visibleExercises;

    if (visibleExercises.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No exercises found'),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final exercise = visibleExercises[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index == 0)
                const SizedBox(
                  height: AppSpacing.md,
                ),
              _ExerciseTile(exercise: exercise),
              if (index != visibleExercises.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Divider(height: 1),
                )
              else
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
            ],
          );
        },
        childCount: visibleExercises.length,
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exercise.name, style: Theme.of(context).textTheme.headline6),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: Wrap(
          runSpacing: 2,
          children: [
            for (Muscle muscle in exercise.primaryMuscles)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Center(
                      child: Text(
                        muscle.name.toUpperCase(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      trailing: BlocBuilder<ExercisesBloc, ExercisesState>(
        buildWhen: (previous, current) =>
            previous.selectedKeys != current.selectedKeys,
        builder: (context, state) {
          final isSelected = state.selectedKeys.contains(exercise.id);

          return _ExerciseSelectButton(
            isSelected: isSelected,
            onPressed: () {
              if (isSelected) {
                context.read<ExercisesBloc>().add(
                      ExercisesSelectionKeyRemoved(exercise.id),
                    );
              } else {
                context.read<ExercisesBloc>().add(
                      ExercisesSelectionKeyAdded(exercise.id),
                    );
              }
            },
          );
        },
      ),
    );
  }
}

class _ExerciseSelectButton extends StatelessWidget {
  const _ExerciseSelectButton({
    Key? key,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : const Icon(Icons.add),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: [
        AppTextButton(
          textStyle: Theme.of(context).textTheme.bodyText1,
          textColor: Theme.of(context).colorScheme.onPrimary,
          child: const Text('Add'),
          onPressed: () {
            Navigator.of(context)
                .pop(context.read<ExercisesBloc>().state.selectedKeys);
          },
        ),
      ],
      pinned: true,
      expandedHeight: 240,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient:
              Theme.of(context).extension<AppColorScheme>()!.primaryGradient2,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final toolbarHeight = MediaQuery.of(context).padding.top;
            final percent = (constraints.maxHeight - toolbarHeight) / 240;

            final paddingLeft = lerpDouble(
              AppSpacing.lg,
              AppSpacing.lg + AppSpacing.lg + AppSpacing.md,
              1 - percent,
            );

            return FlexibleSpaceBar(
              title: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    const Text('Add Exercises'),
                    Text(
                      'Workout creation',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.7),
                          ),
                    ),
                    const Spacer(),
                    const Flexible(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              titlePadding: EdgeInsets.only(
                left: paddingLeft!,
                bottom: 8,
              ),
              centerTitle: false,
              background: const _AppBarExpandedActions(),
            );
          },
        ),
      ),
    );
  }
}

class _AppBarExpandedActions extends StatelessWidget {
  const _AppBarExpandedActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.xxs,
            bottom: AppSpacing.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Assets.icons.icSearch.svg(
                      color: Colors.white,
                      height: 20,
                    ),
                    const AppGap.xs(),
                    const Expanded(child: _SearchInput()),
                  ],
                ),
              ),
              SizedBox(
                child: AppTextButton(
                  onPressed: () {},
                  child: Assets.icons.icFilter.svg(
                    color: Colors.white,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.xxs,
        right: AppSpacing.xxs,
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'search',
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
            border: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                ),
          ),
          enableSuggestions: false,
          autocorrect: false,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          textAlign: TextAlign.left,
          onChanged: (value) {
            context
                .read<ExercisesBloc>()
                .add(ExercisesSearchPhraseChanged(value));
          },
        ),
      ),
    );
  }
}
