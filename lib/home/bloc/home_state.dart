part of 'home_bloc.dart';

/// {@template home_state}
/// Template for the [HomeBloc] state.
/// {@endtemplate}
class HomeState extends Equatable {
  /// {@macro home_state}
  const HomeState({
    required this.status,
    this.userStats,
    this.workoutTemplates,
    this.recentWorkoutLog,
  });

  /// Current status of the bloc.
  final DataLoadingStatus status;

  /// The [UserStats] of current user.
  final UserStats? userStats;

  /// Most recent workout_log.
  final WorkoutLog? recentWorkoutLog;

  /// The list of [WorkoutTemplate]s of current user.
  final List<WorkoutTemplate>? workoutTemplates;

  @override
  List<Object?> get props => [status, userStats, workoutTemplates];

  /// Copy method
  HomeState copyWith({
    DataLoadingStatus? status,
    UserStats? userStats,
    List<WorkoutTemplate>? workoutTemplates,
    WorkoutLog? recentWorkoutLog,
  }) {
    return HomeState(
      status: status ?? this.status,
      userStats: userStats ?? this.userStats,
      workoutTemplates: workoutTemplates ?? this.workoutTemplates,
      recentWorkoutLog: recentWorkoutLog ?? this.recentWorkoutLog,
    );
  }
}
