import 'dart:ui';

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
  static Route<void> route() => MaterialPageRoute<void>(
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
          // ExercisesList(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: [
        AppTextButton(
          textStyle: Theme.of(context).textTheme.bodyText1,
          textColor: Theme.of(context).colorScheme.onPrimary,
          child: const Text('Add'),
          onPressed: () {},
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
              Row(
                children: [
                  Assets.icons.icSearch.svg(
                    color: Colors.white,
                    height: 20,
                  ),
                  const AppGap.xs(),
                  const Text(
                    'search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
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
