part of 'workout_log_details_bloc.dart';

/// {@template workout_log_details_event}
/// Template for the [WorkoutLogDetailsBloc] event.
/// {@endtemplate}
abstract class WorkoutLogDetailsEvent extends Equatable {
  /// {@macro workout_log_details_event}
  const WorkoutLogDetailsEvent();

  @override
  List<Object> get props => [];
}

/// {@template workout_log_deleted}
/// Event to delete a [WorkoutLog].
/// {@endtemplate}
class WorkoutLogDeleted extends WorkoutLogDetailsEvent {}
