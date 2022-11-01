part of 'statistics_bloc.dart';

/// {@template statistics_event}
/// Event template for the [StatisticsBloc].
/// {@endtemplate}
abstract class StatisticsEvent extends Equatable {
  /// {@macro statistics_event}
  const StatisticsEvent();

  @override
  List<Object?> get props => [];
}

/// {@template statistics_changed}
/// Event that is fired when the [UserStats] changes.
/// {@endtemplate}
class StatisticsChanged extends StatisticsEvent {
  /// {@macro statistics_changed}
  const StatisticsChanged(this.userStats);

  /// The new [UserStats].
  final UserStats? userStats;

  @override
  List<Object?> get props => [userStats];
}

/// {@template statistics_loading_error}
/// Event that is fired when the [UserStats] fails to load.
/// {@endtemplate}
class StatisticsLoadingError extends StatisticsEvent {
  /// {@macro statistics_loading_error}
  const StatisticsLoadingError(this.exception);

  /// The [Exception] that occurred.
  final Exception exception;

  @override
  List<Object?> get props => [exception];
}
