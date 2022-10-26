import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';

/// {@template workout_training}
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

        return SafeArea(
          child: Miniplayer(
            controller: context.read<MiniplayerController>(),
            minHeight: 68,
            maxHeight: MediaQuery.of(context).size.height,
            backgroundColor: Colors.white,
            builder: (height, percentage) {
              return const _MiniplayerBody();
            },
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Column(
        children: const [
          _AppBar(),
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
            actions: [
              AppTextButton(
                textStyle: Theme.of(context).textTheme.bodyText1,
                textColor: Theme.of(context).colorScheme.onPrimary,
                child: const Text('Finish'),
                onPressed: () {
                  context
                      .read<MiniplayerController>()
                      .animateToHeight(state: PanelState.MIN);
                  Future.delayed(const Duration(milliseconds: 300), () {
                    context.read<WorkoutTrainingBloc>().add(
                          const WorkoutTrainingFinish(),
                        );
                  });
                },
              ),
            ],
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
