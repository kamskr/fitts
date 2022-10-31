part of 'workout_training_bloc.dart';

/// {@template workout_training_state}
/// The state of the [WorkoutTrainingBloc].
/// {@endtemplate}
abstract class WorkoutTrainingState extends Equatable {
  /// {@macro workout_training_state}
  const WorkoutTrainingState();

  @override
  List<Object?> get props => [];
}

/// {@template workout_training_initial}
/// Initial state, no workout in progress.
/// {@endtemplate}
class WorkoutTrainingInitial extends WorkoutTrainingState {
  /// {@macro workout_training_initial}
  const WorkoutTrainingInitial({this.newLog});

  /// Whether the new log was created.
  final WorkoutLog? newLog;

  @override
  List<Object?> get props => [newLog];

  /// Copy method
  WorkoutTrainingInitial copyWith({
    WorkoutLog? newLog,
  }) {
    return WorkoutTrainingInitial(
      newLog: newLog ?? this.newLog,
    );
  }
}

/// {@template workout_training_in_progress}
/// State used when workout is in progress.
/// {@endtemplate}
class WorkoutTrainingInProgress extends WorkoutTrainingState {
  /// {@macro workout_training_in_progress}
  const WorkoutTrainingInProgress({
    required this.workoutTemplate,
    required this.workoutLog,
    this.restStartTime,
    this.duration = 0,
    this.remainingRestTime = 0,
    this.totalRestTime = 0,
    this.status = FormzStatus.pure,
  });

  /// Workout template used for this workout.
  final WorkoutTemplate workoutTemplate;

  /// Workout log that will be saved at the end of the workout..
  final WorkoutLog workoutLog;

  /// Workout duration in seconds (updates every second).
  final int duration;

  /// When rest timer was started.
  final DateTime? restStartTime;

  /// Remaining rest time in seconds.
  /// (if rest time is 0, no rest time is needed).
  final int remainingRestTime;

  /// Total rest time in seconds.
  /// (if total rest time is 0, no rest time is counting).
  final int totalRestTime;

  /// Status of the workout submission.
  final FormzStatus status;

  @override
  List<Object> get props => [
        workoutTemplate,
        workoutLog,
        duration,
        remainingRestTime,
        totalRestTime,
        status,
      ];

  /// Returns copy of this state.
  WorkoutTrainingInProgress copyWith({
    WorkoutTemplate? workoutTemplate,
    WorkoutLog? workoutLog,
    DateTime? restStartTime,
    int? duration,
    int? remainingRestTime,
    int? totalRestTime,
    FormzStatus? status,
  }) {
    return WorkoutTrainingInProgress(
      workoutTemplate: workoutTemplate ?? this.workoutTemplate,
      workoutLog: workoutLog ?? this.workoutLog,
      restStartTime: restStartTime ?? this.restStartTime,
      duration: duration ?? this.duration,
      remainingRestTime: remainingRestTime ?? this.remainingRestTime,
      totalRestTime: totalRestTime ?? this.totalRestTime,
      status: status ?? this.status,
    );
  }
}
