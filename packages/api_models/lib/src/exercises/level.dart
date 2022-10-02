import 'package:json_annotation/json_annotation.dart';

/// Classifies exercises by the level of difficulty.
enum Level {
  /// The exercise is for beginners.
  @JsonValue('beginner')
  beginner,

  /// The exercise is for intermediate users.
  @JsonValue('intermediate')
  intermediate,

  /// The exercise is for advanced users.
  @JsonValue('advanced')
  advanced,

  /// The exercise is for experts.
  @JsonValue('expert')
  expert,
}
