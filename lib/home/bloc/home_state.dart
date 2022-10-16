part of 'home_bloc.dart';

/// {@template home_state}
/// Status values for [HomeBloc] state.
/// {@endtemplate}
enum HomeStatus {
  /// Initial state of the bloc and loading state.
  initial,

  /// Loading state of the bloc.
  loading,

  /// Success state of the bloc.
  success,

  /// Error state of the bloc.
  error,
}

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
  final HomeStatus status;

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
    HomeStatus? status,
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
