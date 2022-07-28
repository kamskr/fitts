import 'package:equatable/equatable.dart';

/// {@template global_stats}
/// Global user statistics.
/// {@endtemplate}
class GlobalStats extends Equatable {
  /// {@macro global_stats}
  const GlobalStats({
    required this.keyLifts,
    required this.liftingTimeSpent,
    required this.totalKgLifted,
    required this.workoutsCompleted,
  });

  /// List of key lifts. Defined by user. Those are the lifts that are shown in
  /// global stats. The list is ordered by the order of the lifts in the app.
  final List<String> keyLifts;

  /// Total time spent on lifting.
  final int liftingTimeSpent;

  /// Total amount of kilograms lifted.
  final int totalKgLifted;

  /// Total number of workouts completed.
  final int workoutsCompleted;

  @override
  List<Object> get props =>
      [keyLifts, liftingTimeSpent, totalKgLifted, workoutsCompleted];

  /// Creates a copy of [GlobalStats].
  GlobalStats copyWith({
    List<String>? keyLifts,
    int? liftingTimeSpent,
    int? totalKgLifted,
    int? workoutsCompleted,
  }) {
    return GlobalStats(
      keyLifts: keyLifts ?? this.keyLifts,
      liftingTimeSpent: liftingTimeSpent ?? this.liftingTimeSpent,
      totalKgLifted: totalKgLifted ?? this.totalKgLifted,
      workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
    );
  }
}
