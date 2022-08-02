part of 'home_bloc.dart';

/// {@template home_event}
/// Template for the [HomeBloc] event.
/// {@endtemplate}
abstract class HomeEvent extends Equatable {
  /// {@macro home_event}
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/// {@template user_stats_subscription_requested_changed}
/// The event of the [HomeBloc] when you want to start subscription.
/// {@endtemplate}
class UserStatsSubscriptionRequested extends HomeEvent {
  /// {@macro home_loading_started}
  const UserStatsSubscriptionRequested();
}
