import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// Min height of the miniplayer.
const kMinMiniplayerHeight = 68.0;

/// Max height of the miniplayer.
double maxMiniplayerHeight(BuildContext context) =>
    MediaQuery.of(context).size.height - kToolbarHeight;

/// A view used for workout in progress.
/// It is visible globally and is used to display the current workout.
/// {@endtemplate}
class WorkoutTraining extends StatelessWidget {
  /// {@macro workout_training}
  const WorkoutTraining({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _WorkoutTrainingView();
  }
}

class _WorkoutTrainingView extends StatelessWidget {
  const _WorkoutTrainingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutTrainingBloc, WorkoutTrainingState>(
      buildWhen: (previous, current) =>
          (previous is WorkoutTrainingInitial &&
              current is WorkoutTrainingInProgress) ||
          (previous is WorkoutTrainingInProgress &&
              current is WorkoutTrainingInitial),
      builder: (context, state) {
        if (state is! WorkoutTrainingInProgress) {
          return const SizedBox.shrink();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<MiniplayerController>().animateToHeight(
                state: PanelState.MAX,
              );
        });

        return BlocProvider(
          create: (context) => WorkoutCreatorBloc(
            workoutTemplate: state.workoutTemplate,
            workoutsRepository: context.read<WorkoutsRepository>(),
          ),
          child: SafeArea(
            child: Miniplayer(
              valueNotifier: context.read<ValueNotifier<double>>(),
              controller: context.read<MiniplayerController>(),
              minHeight: kMinMiniplayerHeight,
              maxHeight: maxMiniplayerHeight(context),
              backgroundColor: Colors.white,
              builder: (height, percentage) {
                return const _MiniplayerBody();
              },
            ),
          ),
        );
      },
    );
  }
}

class _MiniplayerBody extends StatelessWidget {
  const _MiniplayerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentHeight = maxMiniplayerHeight(context) - kMinMiniplayerHeight;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Scaffold(
        appBar: const _AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: contentHeight,
                  child: WorkoutCreatorBody(
                    hideAppBar: true,
                    onSetFinished: (exerciseIndex, setIndex, set) {
                      final exercise = context
                          .read<WorkoutCreatorBloc>()
                          .state
                          .workoutTemplate
                          .exercises[exerciseIndex];

                      context.read<WorkoutTrainingBloc>().add(
                            WorkoutTrainingStartRestTimer(
                              restTime: exercise.restTime,
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient:
            Theme.of(context).extension<AppColorScheme>()!.primaryGradient2,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 6,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          AppBar(
            leadingWidth: 120,
            leading: BlocBuilder<WorkoutTrainingBloc, WorkoutTrainingState>(
              builder: (context, state) {
                final remainingRestTime = state is WorkoutTrainingInProgress
                    ? state.remainingRestTime
                    : 0;

                return AppTextButton(
                  onPressed: () {
                    context.read<WorkoutTrainingBloc>().add(
                          const WorkoutTrainingStartRestTimer(restTime: 70),
                        );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icons.icTime.svg(color: Colors.white),
                      const AppGap.xxs(),
                      if (remainingRestTime > 0)
                        Text(
                          DateTimeFormatters.formatSeconds(
                            remainingRestTime,
                            showHours: false,
                            showSeconds: true,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      const Spacer(),
                    ],
                  ),
                );
              },
            ),
            title: Column(
              children: [
                const Text(
                  'Workout name',
                  style: TextStyle(color: Colors.white),
                ),
                const AppGap.xxs(),
                BlocBuilder<WorkoutTrainingBloc, WorkoutTrainingState>(
                  builder: (context, state) {
                    return Text(
                      DateTimeFormatters.formatSeconds(
                        (state as WorkoutTrainingInProgress).duration,
                        showSeconds: true,
                      ),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white,
                          ),
                    );
                  },
                ),
              ],
            ),
            actions: const [
              _FinishWorkoutButton(),
            ],
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinMiniplayerHeight);
}

class _FinishWorkoutButton extends StatelessWidget {
  const _FinishWorkoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      textStyle: Theme.of(context).textTheme.bodyText1,
      textColor: Theme.of(context).colorScheme.onPrimary,
      child: const Text('Finish'),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext _) {
            return BlocProvider.value(
              value: context.read<WorkoutCreatorBloc>(),
              child: const _ConfirmDialog(),
            );
          },
        );
      },
    );
  }
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutTrainingBloc, WorkoutTrainingState>(
      listener: (context, state) {
        if ((state as WorkoutTrainingInProgress).status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Finish Workout'),
          content: const Text(
            'Do you want to update the workout template?',
          ),
          actions:
              (state as WorkoutTrainingInProgress).status.isSubmissionInProgress
                  ? [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.md,
                        ),
                        child: SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    ]
                  : [
                      AppTextButton(
                        child: const Text('No'),
                        onPressed: () {
                          final workoutTemplate = context
                              .read<WorkoutCreatorBloc>()
                              .state
                              .workoutTemplate;
                          context.read<WorkoutTrainingBloc>().add(
                                WorkoutTrainingFinish(
                                  updateTemplate: false,
                                  workoutTemplate: workoutTemplate,
                                ),
                              );
                        },
                      ),
                      AppTextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          final workoutTemplate = context
                              .read<WorkoutCreatorBloc>()
                              .state
                              .workoutTemplate;
                          context.read<WorkoutTrainingBloc>().add(
                                WorkoutTrainingFinish(
                                  updateTemplate: true,
                                  workoutTemplate: workoutTemplate,
                                ),
                              );
                        },
                      ),
                    ],
        );
      },
    );
  }
}
