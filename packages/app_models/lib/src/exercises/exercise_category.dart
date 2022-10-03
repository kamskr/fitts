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
  @JsonValue('olympic weightlifting')
  olympicWeightlifting,

  /// Cross fit exercises.
  @JsonValue('crossfit')
  crossfit,

  /// Weighted body weight exercises.
  @JsonValue('weighted bodyweight')
  weightedBodyweight,

  /// Assisted body weight exercises.
  @JsonValue('assisted bodyweight')
  assistedBodyweight,
}
