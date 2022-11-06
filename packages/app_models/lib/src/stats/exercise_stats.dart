import 'package:app_models/app_models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_stats.g.dart';

/// {@template exercise_stats}
/// Model representing users statistics for specific exercise.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class ExerciseStats extends Equatable {
  /// {@macro exercise_stats}
  const ExerciseStats({
    required this.highestWeight,
    required this.repetitionsDone,
    required this.timesPerformed,
    required this.overallBest,
    this.history,
  });

  /// Factory which converts a [Map] into a [ExerciseStats].
  factory ExerciseStats.fromJson(Map<String, dynamic> json) =>
      _$ExerciseStatsFromJson(json);

  /// Converts the [ExerciseStats] to [Map].
  Map<String, dynamic> toJson() => _$ExerciseStatsToJson(this);

  /// Highest weight used for the exercise.
  @JsonKey(name: 'highestWeight')
  final double highestWeight;

  /// Total of repetitions done for the exercise.
  @JsonKey(name: 'repetitionsDone')
  final int repetitionsDone;

  /// Total of times the exercise was performed.
  @JsonKey(name: 'timesPerformed')
  final int timesPerformed;

  /// Overall best result for the exercise (reps*weight).
  @JsonKey(name: 'overallBest')
  final OverallBest overallBest;

  /// History of this exercise performance.
  @JsonKey(name: 'history')
  final List<ExercisePerformHistory>? history;

  @override
  List<Object?> get props => [
        highestWeight,
        repetitionsDone,
        timesPerformed,
        overallBest,
        history,
      ];

  /// Creates a copy of [ExerciseStats].
  ExerciseStats copyWith({
    double? highestWeight,
    int? repetitionsDone,
    int? timesPerformed,
    OverallBest? overallBest,
    List<ExercisePerformHistory>? history,
  }) {
    return ExerciseStats(
      highestWeight: highestWeight ?? this.highestWeight,
      repetitionsDone: repetitionsDone ?? this.repetitionsDone,
      timesPerformed: timesPerformed ?? this.timesPerformed,
      overallBest: overallBest ?? this.overallBest,
      history: history ?? this.history,
    );
  }
}
