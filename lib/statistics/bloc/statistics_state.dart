part of 'statistics_bloc.dart';

/// {@template statistics_state}
/// The state of the [StatisticsBloc].
/// {@endtemplate}
class StatisticsState extends Equatable {
  /// {@macro statistics_state}
  const StatisticsState({
    this.status = DataLoadingStatus.initial,
    this.userStats,
  });

  /// The current [UserStats].
  final UserStats? userStats;

  /// The current [DataLoadingStatus].
  final DataLoadingStatus status;

  @override
  List<Object?> get props => [userStats, status];

  /// Creates a copy of [StatisticsState].
  StatisticsState copyWith({
    UserStats? userStats,
    DataLoadingStatus? status,
  }) {
    return StatisticsState(
      userStats: userStats ?? this.userStats,
      status: status ?? this.status,
    );
  }
}
