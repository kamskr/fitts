import 'package:app_models/app_models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_perform_history.g.dart';

/// {@template exercise_perform_history}
/// Model representing history of exercise performance.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class ExercisePerformHistory extends Equatable {
  /// {@macro exercise_perform_history}
  const ExercisePerformHistory({
    required this.datePerformed,
    required this.details,
  });

  /// Factory which converts a [Map] into a [ExercisePerformHistory].
  factory ExercisePerformHistory.fromJson(Map<String, dynamic> json) =>
      _$ExercisePerformHistoryFromJson(json);

  /// Converts the [ExercisePerformHistory] to [Map].
  Map<String, dynamic> toJson() => _$ExercisePerformHistoryToJson(this);

  /// Date when the exercise was performed.
  final DateTime datePerformed;

  /// Details about the exercise performance.
  final WorkoutExercise details;

  /// Creates a copy of [ExercisePerformHistory].
  ExercisePerformHistory copyWith({
    DateTime? datePerformed,
    WorkoutExercise? details,
  }) {
    return ExercisePerformHistory(
      datePerformed: datePerformed ?? this.datePerformed,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [datePerformed, details];
}
