import 'package:json_annotation/json_annotation.dart';

/// Classifies exercises by the category.
enum ExerciseCategory {
  /// Strength exercises.
  @JsonValue('strength')
  strength,

  /// Stretching exercises.
  @JsonValue('stretching')
  stretching,

  /// Polyometrics exercises.
  @JsonValue('plyometrics')
  plyometrics,

  /// Strongman exercises.
  @JsonValue('strongman')
  strongman,

  /// Power-lifting exercises.
  @JsonValue('powerlifting')
  powerlifting,

  /// Cardio exercises.
  @JsonValue('cardio')
  cardio,

  /// Olympic lifting exercises.
  @JsonValue('olympicWeightlifting')
  olympicWeightlifting,

  /// Cross fit exercises.
  @JsonValue('crossfit')
  crossfit,

  /// Weighted body weight exercises.
  @JsonValue('weightedBodyweight')
  weightedBodyweight,

  /// Assisted body weight exercises.
  @JsonValue('assistedBodyweight')
  assistedBodyweight,
}
