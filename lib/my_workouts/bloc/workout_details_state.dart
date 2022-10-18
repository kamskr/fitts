part of 'workout_details_bloc.dart';

/// {@template workout_details_state}
/// State object for workout_details_bloc.
/// {@endtemplate}
class WorkoutDetailsState extends Equatable {
  /// {@macro workout_details_state}
  const WorkoutDetailsState({
    this.status = DataLoadingStatus.initial,
    this.workoutTemplate,
  });

  /// The [WorkoutTemplate] of current user.
  final WorkoutTemplate? workoutTemplate;

  /// Loading status.
  final DataLoadingStatus status;

  @override
  List<Object?> get props => [
        status,
        workoutTemplate,
      ];

  /// Copy method
  WorkoutDetailsState copyWith({
    DataLoadingStatus? status,
    WorkoutTemplate? workoutTemplate,
  }) {
    return WorkoutDetailsState(
      status: status ?? this.status,
      workoutTemplate: workoutTemplate ?? this.workoutTemplate,
    );
  }
}
