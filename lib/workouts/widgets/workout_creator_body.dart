import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/exercises/exercises.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

/// {@template workout_creator_body}
/// Body used for updating the workout template.
/// {@endtemplate}
class WorkoutCreatorBody extends StatelessWidget {
  /// {@macro workout_creator_body}
  const WorkoutCreatorBody({
    Key? key,
    this.hideAppBar = false,
  }) : super(key: key);

  /// Whether to hide the app bar.
  final bool hideAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (!hideAppBar) const _AppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.md),
          ),
          const _BasicInfo(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.lg),
          ),
          const _WorkoutBuilder(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.md),
          ),
          const _AddExerciseButton(),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom),
          ),
          if (hideAppBar)
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
              ),
            ),
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
        if (context
            .watch<WorkoutCreatorBloc>()
            .state
            .status
            .isSubmissionInProgress)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          )
        else
          AppTextButton(
            textStyle: Theme.of(context).textTheme.bodyText1,
            textColor: Theme.of(context).colorScheme.onPrimary,
            child: const Text('Save'),
            // ignore: unnecessary_lambdas
            onPressed: () {
              FocusScope.of(context).hasFocus
                  ? FocusScope.of(context).unfocus()
                  : context.read<WorkoutCreatorBloc>().add(
                        const WorkoutCreatorSubmitTemplate(),
                      );
            },
          ),
      ],
      backgroundColor: Colors.transparent,
      pinned: true,
      expandedHeight: 150,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient:
              Theme.of(context).extension<AppColorScheme>()!.primaryGradient2,
        ),
        child: FlexibleSpaceBar(
          title: BlocBuilder<WorkoutCreatorBloc, WorkoutCreatorState>(
            buildWhen: (previous, current) =>
                previous.workoutTemplate.id != current.workoutTemplate.id,
            builder: (context, state) {
              final isNewWorkout = state.workoutTemplate.id.isEmpty;

              return Text(
                isNewWorkout
                    ? 'Create Workout Template'
                    : 'Edit Workout Template',
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BasicInfo extends StatelessWidget {
  const _BasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Workout Template Name',
              ),
              initialValue:
                  context.read<WorkoutCreatorBloc>().state.workoutTemplate.name,
              style: Theme.of(context).textTheme.headline5,
              onChanged: (value) {
                final bloc = context.read<WorkoutCreatorBloc>();
                bloc.add(
                  WorkoutCreatorTemplateChanged(
                    bloc.state.workoutTemplate.copyWith(
                      name: value,
                    ),
                  ),
                );
              },
            ),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              initialValue: context
                  .read<WorkoutCreatorBloc>()
                  .state
                  .workoutTemplate
                  .notes,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Notes',
              ),
              onChanged: (value) {
                final bloc = context.read<WorkoutCreatorBloc>();
                bloc.add(
                  WorkoutCreatorTemplateChanged(
                    bloc.state.workoutTemplate.copyWith(
                      notes: value,
                    ),
                  ),
                );
              },
            ),
          ],
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
          return child!;
        },
        child: child,
      );
    }

    return SliverReorderableList(
      proxyDecorator: proxyDecorator,
      onReorderStart: (_) {
        HapticFeedback.lightImpact();
      },
      onReorderEnd: (_) {
        HapticFeedback.lightImpact();
      },
      itemBuilder: (context, index) {
        return ExerciseCard(
          key: ValueKey(workoutExercises[index]),
          exerciseCardData: ExerciseCardData(
            exerciseIndex: index,
            exercise: workoutExercises[index],
            exerciseCount: workoutExercises.length,
            onExerciseChanged: (exerciseIndex, exercise) {
              bloc.add(
                WorkoutCreatorExerciseChanged(
                  exerciseIndex: exerciseIndex,
                  exercise: exercise,
                ),
              );
            },
            onExerciseDeleted: (index) {
              bloc.add(
                WorkoutCreatorDeleteExercise(
                  index: index,
                ),
              );
            },
            onExerciseSetDeleted: (exerciseIndex, setIndex) {
              bloc.add(
                WorkoutCreatorDeleteExerciseSet(
                  exerciseIndex: exerciseIndex,
                  setIndex: setIndex,
                ),
              );
            },
            onExerciseSetChanged: (exerciseIndex, setIndex, set) {
              bloc.add(
                WorkoutCreatorExerciseSetChanged(
                  exerciseIndex: exerciseIndex,
                  setIndex: setIndex,
                  set: set,
                ),
              );
            },
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
              Navigator.of(context)
                  .push(
                AddExercisesPage.route(),
              )
                  .then((selectedExercisesKeys) {
                if (selectedExercisesKeys != null &&
                    selectedExercisesKeys.isNotEmpty) {
                  final exercisesToAdd = selectedExercisesKeys
                      .map((key) => exercises[key]!)
                      .toList();

                  context.read<WorkoutCreatorBloc>().add(
                        WorkoutCreatorAddExercises(exercisesToAdd),
                      );
                }
              });
            },
            child: const Text('Add exercise'),
          ),
        ),
      ),
    );
  }
}
