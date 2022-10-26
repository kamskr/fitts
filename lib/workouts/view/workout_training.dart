import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Miniplayer(
        minHeight: 68,
        maxHeight: MediaQuery.of(context).size.height,
        backgroundColor: Colors.white,
        builder: (height, percentage) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: Theme.of(context)
                        .extension<AppColorScheme>()!
                        .primaryGradient2,
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
                        leading: AppTextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.icons.icTime.svg(color: Colors.white),
                              const AppGap.xxs(),
                              const Text(
                                '0:24',
                                style: TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        title: Column(
                          children: [
                            const Text(
                              'Workout name',
                              style: TextStyle(color: Colors.white),
                            ),
                            const AppGap.xxs(),
                            Text(
                              '15:44',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: Colors.white,
                                      ),
                            ),
                          ],
                        ),
                        actions: [
                          AppTextButton(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            textColor: Theme.of(context).colorScheme.onPrimary,
                            child: const Text('Finish'),
                            onPressed: () {},
                          ),
                        ],
                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
