import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:workouts_repository/workouts_repository.dart';

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
      create: (_) => WorkoutCreatorBloc(
        workoutsRepository: context.read<WorkoutsRepository>(),
      ),
      child: const _CreateWorkoutView(),
    );
  }
}

class _CreateWorkoutView extends StatelessWidget {
  const _CreateWorkoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: _BlocStateListener(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              const _AppBar(),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _BlocStateListener extends StatelessWidget {
  const _BlocStateListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutCreatorBloc, WorkoutCreatorState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to create workout'),
            ),
          );
        }
        // if (state.status == FormzStatus.submissionSuccess) {
        //   Navigator.of(context).pop();
        // }
      },
      child: child,
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
                // border: InputBorder.none,
                hintText: 'Workout Template Name',
              ),
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
