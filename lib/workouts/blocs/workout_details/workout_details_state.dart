part of 'workout_details_bloc.dart';

/// {@template workout_details_state}
/// State object for workout_details_bloc.
/// {@endtemplate}
class WorkoutDetailsState extends Equatable {
  /// {@macro workout_details_state}
  const WorkoutDetailsState({
    this.status = DataLoadingStatus.initial,
    this.deleteStatus = FormzStatus.pure,
    this.workoutTemplate,
  });

  /// The [WorkoutTemplate] of current user.
  final WorkoutTemplate? workoutTemplate;

  /// Loading status.
  final DataLoadingStatus status;

  /// Delete status.
  final FormzStatus deleteStatus;

  @override
  List<Object?> get props => [status, workoutTemplate, deleteStatus];

  /// Copy method
  WorkoutDetailsState copyWith({
    DataLoadingStatus? status,
    WorkoutTemplate? workoutTemplate,
    FormzStatus? deleteStatus,
  }) {
    return WorkoutDetailsState(
      status: status ?? this.status,
      workoutTemplate: workoutTemplate ?? this.workoutTemplate,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }
}
