import 'dart:ui';

import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/workouts/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

/// {@template create_workout_page}
/// Page for creating a WorkoutTemplate.
/// {@endtemplate}
class CreateWorkoutPage extends StatelessWidget {
  /// {@macro create_workout_page}
  const CreateWorkoutPage({Key? key}) : super(key: key);

  /// Route helper
  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const CreateWorkoutPage(),
        fullscreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutCreatorBloc>(
      create: (_) => WorkoutCreatorBloc(),
      child: const _CreateWorkoutView(),
    );
  }
}

class _CreateWorkoutView extends StatelessWidget {
  const _CreateWorkoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBar(),
          _WorkoutBuilder(),
          SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.md),
          ),
          _AddExerciseButton(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

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
          child: const Text('Save'),
          // ignore: unnecessary_lambdas
          onPressed: () {
            HapticFeedback.lightImpact();
          },
        ),
      ],
      backgroundColor: Colors.transparent,
      pinned: true,
      expandedHeight: 150,
      flexibleSpace: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient1,
        ),
        child: FlexibleSpaceBar(
          title: Text('Create Workout'),
        ),
      ),
    );
  }
}

class _WorkoutBuilder extends StatelessWidget {
  const _WorkoutBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WorkoutCreatorBloc>();
    final exercises = bloc.state.workoutTemplate.exercises;

    if (exercises.isEmpty) {
      return const SliverToBoxAdapter(
        child: _NoExercisesAdded(),
      );
    }

    return const _ExercisesList();
  }
}

class _NoExercisesAdded extends StatelessWidget {
  const _NoExercisesAdded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppGap.xxlg(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/home/empty_dashboard.svg',
                semanticsLabel: 'Empty workouts',
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(0, 255, 255, 255),
                        Theme.of(context).colorScheme.background,
                      ],
                      stops: const [.1, .8],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const AppGap.md(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xlg,
          ),
          child: Text(
            'No exercises added yet',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ExercisesList extends StatelessWidget {
  const _ExercisesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WorkoutCreatorBloc>();
    final workoutExercises = bloc.state.workoutTemplate.exercises;

    Widget proxyDecorator(
      Widget child,
      int index,
      Animation<double> animation,
    ) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final animValue = Curves.easeInOut.transform(animation.value);
          final elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            shadowColor: Colors.black,
            child: child,
          );
        },
        child: child,
      );
    }

    return SliverReorderableList(
      proxyDecorator: proxyDecorator,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: ValueKey(workoutExercises[index]),
          background: ColoredBox(
            color: Theme.of(context).colorScheme.error,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                AppGap.md(),
              ],
            ),
          ),
          child: ListTile(
            tileColor: Colors.white,
            title: Text('Item ${workoutExercises[index].exerciseId}'),
            trailing: ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.menu),
            ),
          ),
        );
      },
      itemCount: workoutExercises.length,
      onReorder: (oldIndex, newIndex) {
        bloc.add(
          WorkoutCreatorReorderExercises(
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
        );
      },
    );
  }
}

class _AddExerciseButton extends StatelessWidget {
  const _AddExerciseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exercises = context.read<Map<String, Exercise>>();
    return SliverToBoxAdapter(
      child: Center(
        child: SizedBox(
          height: 48,
          width: 210,
          child: AppButton.gradient(
            onPressed: () {
              HapticFeedback.lightImpact();
              context.read<WorkoutCreatorBloc>().add(
                    WorkoutCreatorAddExercises([
                      exercises['3_4_sit_up']!,
                      exercises['ab_roller']!,
                    ]),
                  );
            },
            child: const Text('Add exercise'),
          ),
        ),
      ),
    );
  }
}
