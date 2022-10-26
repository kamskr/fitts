part of 'workout_details_bloc.dart';

/// {@template workout_details_event}
/// Template for the [WorkoutDetailsBloc] event.
/// {@endtemplate}
abstract class WorkoutDetailsEvent extends Equatable {
  /// {@macro workout_details_event}
  const WorkoutDetailsEvent();

  @override
  List<Object> get props => [];
}

/// {@template workout_template_subscription_requested}
/// Event to request the subscription of [WorkoutTemplate].
/// {@endtemplate}
class WorkoutTemplateSubscriptionRequested extends WorkoutDetailsEvent {
  /// {@macro workout_template_subscription_requested}
  const WorkoutTemplateSubscriptionRequested();
}

/// {@template workout_template_delete_template}
/// Event to delete a [WorkoutTemplate].
/// {@endtemplate}
class WorkoutTemplateDeleteTemplate extends WorkoutDetailsEvent {
  /// {@macro workout_template_delete_template}
  const WorkoutTemplateDeleteTemplate();
}
