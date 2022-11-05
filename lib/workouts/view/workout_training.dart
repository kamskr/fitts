import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return BlocConsumer<WorkoutTrainingBloc, WorkoutTrainingState>(
      buildWhen: (previous, current) =>
          (previous is WorkoutTrainingInitial &&
              current is WorkoutTrainingInProgress) ||
          (previous is WorkoutTrainingInProgress &&
              current is WorkoutTrainingInitial),
      listenWhen: (previous, current) =>
          (previous is WorkoutTrainingInitial &&
              current is WorkoutTrainingInProgress) ||
          (previous is WorkoutTrainingInProgress &&
              current is WorkoutTrainingInitial),
      listener: (context, state) {
        if (state is WorkoutTrainingInitial && state.newLog != null) {
          Navigator.of(context).push(
            WorkoutLogDetails.route(state.newLog!),
          );
        }
      },
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
              backgroundColor: context.colorScheme.background,
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

    return GestureDetector(
      onTap: FocusScope.of(context).hasFocus
          ? () {
              FocusScope.of(context).unfocus();
            }
          : null,
      onLongPress: FocusScope.of(context).hasFocus
          ? () {
              FocusScope.of(context).unfocus();
            }
          : null,
      onVerticalDragDown: FocusScope.of(context).hasFocus
          ? (_) {
              FocusScope.of(context).unfocus();
            }
          : null,
      child: ClipRRect(
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

                        if (exercise.restTime != 0) {
                          context.read<WorkoutTrainingBloc>().add(
                                WorkoutTrainingStartRestTimer(
                                  restTime: exercise.restTime,
                                ),
                              );
                          showDialog<bool>(
                            context: context,
                            builder: (_) {
                              return const _RestTimerDialog();
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
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
        gradient: context.appColorScheme.primaryGradient2,
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
            leading: BlocConsumer<WorkoutTrainingBloc, WorkoutTrainingState>(
              listenWhen: (previous, current) =>
                  previous is WorkoutTrainingInProgress &&
                  current is WorkoutTrainingInProgress &&
                  previous.remainingRestTime != current.remainingRestTime,
              buildWhen: (previous, current) =>
                  previous is WorkoutTrainingInProgress &&
                  current is WorkoutTrainingInProgress &&
                  previous.remainingRestTime != current.remainingRestTime,
              listener: (context, state) {
                final currentState = state as WorkoutTrainingInProgress;
                if (currentState.remainingRestTime == 0) {
                  HapticFeedback.vibrate();

                  showDialog<bool>(
                    context: context,
                    builder: (BuildContext _) {
                      return const AlertDialog(
                        insetPadding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        title: Text('Rest time finished 🎉'),
                        content: Text('Get back to work!'),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                final remainingRestTime = state is WorkoutTrainingInProgress
                    ? state.remainingRestTime
                    : 0;

                return AppTextButton(
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return const _RestTimerDialog();
                      },
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
                    if (state is WorkoutTrainingInitial) {
                      return const SizedBox();
                    }

                    return Text(
                      DateTimeFormatters.formatSeconds(
                        (state as WorkoutTrainingInProgress).duration,
                        showSeconds: true,
                      ),
                      style: context.textTheme.caption!.copyWith(
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
      textStyle: context.textTheme.bodyText1,
      textColor: context.colorScheme.onPrimary,
      child: const Text('Finish'),
      onPressed: () {
        showDialog<bool>(
          context: context,
          builder: (BuildContext _) {
            return BlocProvider.value(
              value: context.read<WorkoutCreatorBloc>(),
              child: const _ConfirmDialog(),
            );
          },
        ).then((value) {
          if (value == true) {
            showDialog<bool>(
              context: context,
              builder: (BuildContext _) {
                return BlocProvider.value(
                  value: context.read<WorkoutCreatorBloc>(),
                  child: const _CancelWorkoutDialog(),
                );
              },
            );
          }
        });
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
      buildWhen: (previous, current) =>
          current is WorkoutTrainingInProgress &&
          (previous as WorkoutTrainingInProgress).status != current.status,
      listenWhen: (previous, current) =>
          current is WorkoutTrainingInProgress &&
          (previous as WorkoutTrainingInProgress).status != current.status,
      listener: (context, state) {
        if (state is WorkoutTrainingInitial) {
          return;
        }
        if ((state as WorkoutTrainingInProgress).status.isSubmissionSuccess) {
          Navigator.of(context).pop();
          context.read<MiniplayerController>().animateToHeight(
                state: PanelState.MIN,
              );
        }
      },
      builder: (context, state) {
        if (state is WorkoutTrainingInitial) {
          return const SizedBox();
        }
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          title: const Text('Finish Workout'),
          content: const Text(
            'Do you want to update the workout template?',
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
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
                        textColor: context.colorScheme.error,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Cancel Workout'),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                      ),
                    ],
        );
      },
    );
  }
}

class _CancelWorkoutDialog extends StatelessWidget {
  const _CancelWorkoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      title: const Text('Cancel Workout'),
      content: const Text(
        'Are you sure you want to cancel this workout?'
        ' All progress will be lost.',
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      actions: [
        AppTextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        AppTextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();

            context.read<WorkoutTrainingBloc>().add(
                  const WorkoutTrainingCancelWorkout(),
                );
          },
        ),
      ],
    );
  }
}

class _RestTimerDialog extends StatelessWidget {
  const _RestTimerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        context.watch<WorkoutTrainingBloc>().state as WorkoutTrainingInProgress;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      alignment: Alignment.center,
      title: const Text('Rest Timer'),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton.outlined(
                child: const Text('-10s'),
                onPressed: () {
                  context.read<WorkoutTrainingBloc>().add(
                        WorkoutTrainingStartRestTimer(
                          restTime: max(state.remainingRestTime - 10, 0),
                        ),
                      );
                },
              ),
            ),
            const AppGap.md(),
            Expanded(
              child: AppButton.outlined(
                child: const Text('+10s'),
                onPressed: () {
                  context.read<WorkoutTrainingBloc>().add(
                        WorkoutTrainingStartRestTimer(
                          restTime: state.remainingRestTime + 10,
                        ),
                      );
                },
              ),
            ),
            const AppGap.md(),
            Expanded(
              child: AppButton.primary(
                child: const Text('Skip'),
                onPressed: () {
                  context.read<WorkoutTrainingBloc>().add(
                        const WorkoutTrainingStartRestTimer(
                          restTime: 0,
                        ),
                      );
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppGap.md(),
          SizedBox(
            height: 300,
            width: 300,
            child: Stack(
              children: [
                const SizedBox(
                  height: 300,
                  width: 300,
                  child: _RestProgressIndicator(),
                ),
                Center(
                  child: Text(
                    DateTimeFormatters.formatSeconds(
                      state.remainingRestTime,
                      showHours: false,
                      showSeconds: true,
                    ),
                    style: context.textTheme.headline1,
                  ),
                )
              ],
            ),
          ),
          const AppGap.md(),
        ],
      ),
    );
  }
}

class _RestProgressIndicator extends StatefulWidget {
  const _RestProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  State<_RestProgressIndicator> createState() => _RestProgressIndicatorState();
}

class _RestProgressIndicatorState extends State<_RestProgressIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutTrainingBloc, WorkoutTrainingState>(
      buildWhen: (previous, current) =>
          (previous as WorkoutTrainingInProgress).restStartTime !=
          (current as WorkoutTrainingInProgress).restStartTime,
      builder: (context, state) {
        final currentState = state as WorkoutTrainingInProgress;

        if (currentState.remainingRestTime == 0 ||
            currentState.restStartTime == null) {
          _animationController.stop();
        } else {
          _animationController.duration =
              Duration(seconds: currentState.totalRestTime);

          final difference =
              DateTime.now().difference(currentState.restStartTime!).inSeconds;

          _animationController.forward(
            from: difference / currentState.totalRestTime,
          );
        }

        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return CircularProgressIndicator(
              backgroundColor: context.appColorScheme.primary50,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.appColorScheme.primary500,
              ),
              value: 1 - _animationController.value,
              strokeWidth: 8,
            );
          },
        );
      },
    );
  }
}
