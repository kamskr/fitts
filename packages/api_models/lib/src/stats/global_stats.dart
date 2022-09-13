import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_stats.g.dart';

/// {@template global_stats}
/// Global user statistics.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class GlobalStats extends Equatable {
  /// {@macro global_stats}
  const GlobalStats({
    required this.keyLifts,
    required this.liftingTimeSpent,
    required this.totalKgLifted,
    required this.workoutsCompleted,
  });

  /// Factory which converts a [Map] into a [GlobalStats].
  factory GlobalStats.fromJson(Map<String, dynamic> json) =>
      _$GlobalStatsFromJson(json);

  /// Converts the [GlobalStats] to [Map].
  Map<String, dynamic> toJson() => _$GlobalStatsToJson(this);

  /// List of key lifts. Defined by user. Those are the lifts that are shown in
  /// global stats. The list is ordered by the order of the lifts in the app.
  @JsonKey(name: 'keyLifts')
  final List<String> keyLifts;

  /// Total time spent on lifting.
  @JsonKey(name: 'liftingTimeSpent')
  final int liftingTimeSpent;

  /// Total amount of kilograms lifted.
  @JsonKey(name: 'totalKgLifted')
  final int totalKgLifted;

  /// Total number of workouts completed.
  @JsonKey(name: 'workoutsCompleted')
  final int workoutsCompleted;

  @override
  List<Object> get props => [
        keyLifts,
        liftingTimeSpent,
        totalKgLifted,
        workoutsCompleted,
      ];

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
