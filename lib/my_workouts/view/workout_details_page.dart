import 'package:app_ui/app_ui.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/my_workouts/bloc/workout_details_bloc.dart';
import 'package:fitts/my_workouts/widgets/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template workout_details_page}
/// Page that displays the details of a WorkoutTemplate.
/// {@endtemplate}
class WorkoutDetailsPage extends StatelessWidget {
  /// {@macro workout_details_page}
  const WorkoutDetailsPage(
    this.workoutTemplateId, {
    Key? key,
  }) : super(key: key);

  /// Route helper.
  static Route<dynamic> route(String workoutTemplateId) =>
      MaterialPageRoute<void>(
        builder: (_) => WorkoutDetailsPage(workoutTemplateId),
      );

  /// ID of the current workout template.
  final String workoutTemplateId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutDetailsBloc>(
      create: (_) => WorkoutDetailsBloc(
        workoutTemplateId: workoutTemplateId,
        workoutsRepository: context.read<WorkoutsRepository>(),
      )..add(const WorkoutTemplateSubscriptionRequested()),
      child: const _WorkoutDetailsView(),
    );
  }
}

class _WorkoutDetailsView extends StatelessWidget {
  const _WorkoutDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutTemplate =
        context.watch<WorkoutDetailsBloc>().state.workoutTemplate;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Details'),
      ),
      body: Column(
        children: [
          if (workoutTemplate != null)
            Stack(
              children: [
                WorkoutCard(
                  workoutTemplate: context
                      .watch<WorkoutDetailsBloc>()
                      .state
                      .workoutTemplate!,
                  footer: const SizedBox(height: 80),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AppButton.gradient(
                    height: 80,
                    child: Text(l10n.homePageStartWorkoutButtonText),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          Text(
            context.watch<WorkoutDetailsBloc>().state.workoutTemplate?.name ??
                'Loading',
          ),
        ],
      ),
    );
  }
}
