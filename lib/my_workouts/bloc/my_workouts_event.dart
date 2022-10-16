part of 'my_workouts_bloc.dart';

/// {@template my_workouts_event}
/// Template for the [MyWorkoutsBloc] event.
/// {@endtemplate}
abstract class MyWorkoutsEvent extends Equatable {
  /// {@macro my_workouts_event}
  const MyWorkoutsEvent();

  @override
  List<Object> get props => [];
}

/// Event to request the subscription of [WorkoutTemplate]s.
class WorkoutTemplatesSubscriptionRequested extends MyWorkoutsEvent {
  /// {@macro workout_templates_subscription_requested}
  const WorkoutTemplatesSubscriptionRequested();
}
