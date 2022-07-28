import 'package:api_models/api_models.dart';
import 'package:equatable/equatable.dart';

/// {@template user_stats}
/// Model representing User statistics data. Stats are split into global and
/// per exercise statistics.
/// {@endtemplate}
class UserStats extends Equatable {
  /// {@macro user_stats}
  const UserStats({
    required this.exercisesStats,
    required this.globalStats,
  });

  /// Statistics related to the individual exercises.
  ///
  /// [Map] where key is [String] representing exercise id and
  /// value is [ExerciseStats].
  final Map<String, ExerciseStats> exercisesStats;

  /// Global user statistics.
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
}
