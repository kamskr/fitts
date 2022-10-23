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
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient1,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final toolbarHeight = MediaQuery.of(context).padding.top;
            final percent = (constraints.maxHeight - toolbarHeight) / 240;

            final paddingLeft =
                lerpDouble(AppSpacing.lg, AppSpacing.xxxlg, 1 - percent);

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
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('search'),
                        AppButton.outlined(
                          child: const Text('test'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
