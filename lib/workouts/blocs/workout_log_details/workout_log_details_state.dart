part of 'workout_log_details_bloc.dart';

/// {@template workout_log_details_state}
/// State for the [WorkoutLogDetailsBloc].
/// {@endtemplate}
class WorkoutLogDetailsState extends Equatable {
  /// {@macro workout_log_details_state}
  const WorkoutLogDetailsState({
    required this.workoutLog,
    this.status = FormzStatus.pure,
  });

  /// The [WorkoutLog] to display.
  final WorkoutLog workoutLog;

  /// Status of the workout log submission.
  final FormzStatus status;

  @override
  List<Object> get props => [workoutLog, status];

  /// Copy the [WorkoutLogDetailsState] with the given parameters.
  WorkoutLogDetailsState copyWith({
    WorkoutLog? workoutLog,
    FormzStatus? status,
  }) {
    return WorkoutLogDetailsState(
      workoutLog: workoutLog ?? this.workoutLog,
      status: status ?? this.status,
    );
  }
}
