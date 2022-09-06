import 'package:json_annotation/json_annotation.dart';

/// Represents different muscle groups.
enum Muscle {
  /// Abs
  @JsonValue('abdominals')
  abdominals,

  /// Hamstrings
  @JsonValue('hamstrings')
  hamstrings,

  /// Calves
  @JsonValue('calves')
  calves,

  /// Shoulders
  @JsonValue('shoulders')
  shoulders,

  /// Adductors
  @JsonValue('adductors')
  adductors,

  /// Glutes
  @JsonValue('glutes')
  glutes,

  /// Quadriceps
  @JsonValue('quadriceps')
  quadriceps,

  /// Biceps
  @JsonValue('biceps')
  biceps,

  /// Forearms
  @JsonValue('forearms')
  forearms,

  /// Abductors
  @JsonValue('abductors')
  abductors,

  /// Triceps
  @JsonValue('triceps')
  triceps,

  /// Chest
  @JsonValue('chest')
  chest,

  /// Lower back
  @JsonValue('lowerBack')
  lowerBack,

  /// Traps
  @JsonValue('traps')
  traps,

  /// Middle back
  @JsonValue('middleBack')
  middleBack,

  /// Lats
  @JsonValue('lats')
  lats,

  /// Neck
  @JsonValue('neck')
  neck,
}
