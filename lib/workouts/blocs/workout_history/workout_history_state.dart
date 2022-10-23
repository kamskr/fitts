part of 'workout_history_bloc.dart';

/// {@template workout_history_state}
/// State of workout history.
/// {@endtemplate}
class WorkoutHistoryState extends Equatable {
  /// {@macro workout_history_state}
  const WorkoutHistoryState({
    this.status = DataLoadingStatus.initial,
    this.workoutLogsHistory,
  });

  /// List of [WorkoutLog] of current user.
  final List<WorkoutLog>? workoutLogsHistory;

  /// Loading status.
  final DataLoadingStatus status;

  @override
  List<Object?> get props => [
        status,
        workoutLogsHistory,
      ];

  /// Copy method
  WorkoutHistoryState copyWith({
    DataLoadingStatus? status,
    List<WorkoutLog>? workoutLogsHistory,
  }) {
    return WorkoutHistoryState(
      status: status ?? this.status,
      workoutLogsHistory: workoutLogsHistory ?? this.workoutLogsHistory,
    );
  }
}
