import 'package:api_models/api_models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_stats.g.dart';

/// {@template user_stats}
/// Model representing User statistics data. Stats are split into global and
/// per exercise statistics.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class UserStats extends Equatable {
  /// {@macro user_stats}
  const UserStats({
    required this.exercisesStats,
    required this.globalStats,
  });

  /// Factory which converts a [Map] into a [UserStats].
  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);

  /// Converts the [UserStats] to [Map].
  Map<String, dynamic> toJson() => _$UserStatsToJson(this);

  /// Statistics related to the individual exercises.
  ///
  /// [Map] where key is [String] representing exercise id and
  /// value is [ExerciseStats].
  @JsonKey(name: 'exercises')
  final Map<String, ExerciseStats> exercisesStats;

  /// Global user statistics.
  @JsonKey(name: 'global')
  final GlobalStats globalStats;

  @override
  List<Object> get props => [
        exercisesStats,
        globalStats,
      ];

  /// Creates a copy of [UserStats].
  UserStats copyWith({
    Map<String, ExerciseStats>? exercisesStats,
    GlobalStats? globalStats,
  }) {
    return UserStats(
      exercisesStats: exercisesStats ?? this.exercisesStats,
      globalStats: globalStats ?? this.globalStats,
    );
  }

  /// An empty [UserStats] object.
  static const UserStats empty = UserStats(
    exercisesStats: {},
    globalStats: GlobalStats(
      keyLifts: [],
      liftingTimeSpent: 0,
      totalKgLifted: 0,
      workoutsCompleted: 0,
    ),
  );
}
