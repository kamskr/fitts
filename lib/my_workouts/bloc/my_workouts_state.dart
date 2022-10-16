part of 'my_workouts_bloc.dart';

/// {@template my_workouts_state}
/// State object for my_workouts_bloc.
/// {@endtemplate}
class MyWorkoutsState extends Equatable {
  /// {@macro my_workouts_state}
  const MyWorkoutsState({
    this.status = DataLoadingStatus.initial,
    this.workoutTemplates,
  });

  /// The list of [WorkoutTemplate]s of current user.
  final List<WorkoutTemplate>? workoutTemplates;

  /// Loading status.
  final DataLoadingStatus status;

  @override
  List<Object> get props => [];

  /// Copy method
  MyWorkoutsState copyWith({
    DataLoadingStatus? status,
    List<WorkoutTemplate>? workoutTemplates,
  }) {
    return MyWorkoutsState(
      status: status ?? this.status,
      workoutTemplates: workoutTemplates ?? this.workoutTemplates,
    );
  }
}
