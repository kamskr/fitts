part of 'workout_history_bloc.dart';

/// {@template workout_history_event}
/// Template for the [WorkoutHistoryBloc] event.
/// {@endtemplate}
abstract class WorkoutHistoryEvent extends Equatable {
  /// {@macro workout_history_event}
  const WorkoutHistoryEvent();

  @override
  List<Object> get props => [];
}

/// {@template workout_logs_subscription_requested}
/// Event to request the subscription of  List [WorkoutLog].
/// {@endtemplate}
class WorkoutLogsSubscriptionRequested extends WorkoutHistoryEvent {
  /// {@macro workout_logs_subscription_requested}
  const WorkoutLogsSubscriptionRequested();
}
