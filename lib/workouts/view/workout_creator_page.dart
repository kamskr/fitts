import 'package:app_models/app_models.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template workout_creator_page}
/// Page for creating and editing a WorkoutTemplate.
///
/// If workoutTemplate is passed to this page, it will be used to update this
/// existing template.
/// {@endtemplate}
class WorkoutCreatorPage extends StatelessWidget {
  /// {@macro workout_creator_page}
  const WorkoutCreatorPage({
    Key? key,
    this.workoutTemplate,
  }) : super(key: key);

  /// WorkoutTemplate to update (Optional).
  /// Creates new one if not passed.
  final WorkoutTemplate? workoutTemplate;

  /// Route helper
  static Route<void> route({
    WorkoutTemplate? workoutTemplate,
  }) =>
      MaterialPageRoute<void>(
        builder: (_) => WorkoutCreatorPage(
          workoutTemplate: workoutTemplate,
        ),
        fullscreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutCreatorBloc>(
      create: (_) => WorkoutCreatorBloc(
        workoutTemplate: workoutTemplate,
        workoutsRepository: context.read<WorkoutsRepository>(),
      ),
      child: const _WorkoutCreatorView(),
    );
  }
}

class _WorkoutCreatorView extends StatelessWidget {
  const _WorkoutCreatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const _BlocStateListener(
        child: WorkoutCreatorBody(),
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
              content: Text('Failed to save workout template!'),
            ),
          );
        }
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }
}
