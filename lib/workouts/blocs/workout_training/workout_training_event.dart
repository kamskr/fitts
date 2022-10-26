part of 'workout_training_bloc.dart';

/// {@template workout_training_event}
/// The events of the [WorkoutTrainingBloc].
/// {@endtemplate}
abstract class WorkoutTrainingEvent extends Equatable {
  /// {@macro workout_training_event}
  const WorkoutTrainingEvent();

  @override
  List<Object> get props => [];
}

/// {@template workout_training_start}
/// Event used to start the workout.
/// {@endtemplate}
class WorkoutTrainingStart extends WorkoutTrainingEvent {
  /// {@macro workout_training_start}
  const WorkoutTrainingStart({
    required this.workoutTemplate,
  });

  /// Workout template used for this workout.
  final WorkoutTemplate workoutTemplate;

  @override
  List<Object> get props => [
        workoutTemplate,
      ];
}

/// {@template workout_training_finish}
/// Event used to finish the workout.
/// {@endtemplate}
class WorkoutTrainingFinish extends WorkoutTrainingEvent {
  /// {@macro workout_training_finish}
  const WorkoutTrainingFinish();

  @override
  List<Object> get props => [];
}

/// {@template workout_training_start_rest_timer}
/// Event used to start the rest timer.
/// {@endtemplate}
class WorkoutTrainingStartRestTimer extends WorkoutTrainingEvent {
  /// {@macro workout_training_start_rest_timer}
  const WorkoutTrainingStartRestTimer({
    required this.restTime,
  });

  /// Rest time in seconds.
  final int restTime;

  @override
  List<Object> get props => [
        restTime,
      ];
}

/// {@template workout_training_ticker_event}
/// Event used to update the workout based on ticker.
/// {@endtemplate}
class WorkoutTrainingTickerEvent extends WorkoutTrainingEvent {
  /// {@macro workout_training_ticker_event}
  const WorkoutTrainingTickerEvent();

  @override
  List<Object> get props => [];
}
