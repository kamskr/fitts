import 'package:api_models/api_models.dart';
import 'package:equatable/equatable.dart';

/// {@template exercise_stats}
/// Model representing users statistics for specific exercise.
/// {@endtemplate}
class ExerciseStats extends Equatable {
  /// {@macro exercise_stats}
  const ExerciseStats({
    required this.hightestWeight,
    required this.repetitionsDone,
    required this.timesPerformed,
    required this.overallBest,
  });

  /// Highest weight used for the exercise.
  final double hightestWeight;

  /// Total of repetitions done for the exercise.
  final int repetitionsDone;

  /// Total of times the exercise was performed.
  final int timesPerformed;

  /// Overall best result for the exercise (reps*weight).
  final OverallBest overallBest;

  @override
  List<Object> get props =>
      [hightestWeight, repetitionsDone, timesPerformed, overallBest];

  /// Creates a copy of [ExerciseStats].
  ExerciseStats copyWith({
    double? hightestWeight,
    int? repetitionsDone,
    int? timesPerformed,
    OverallBest? overallBest,
  }) {
    return ExerciseStats(
      hightestWeight: hightestWeight ?? this.hightestWeight,
      repetitionsDone: repetitionsDone ?? this.repetitionsDone,
      timesPerformed: timesPerformed ?? this.timesPerformed,
      overallBest: overallBest ?? this.overallBest,
    );
  }
}
