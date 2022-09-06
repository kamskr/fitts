import 'package:json_annotation/json_annotation.dart';

/// Classifies the exercises by the type of force.
enum Force {
  /// Pull the body part towards the body.
  @JsonValue('pull')
  pull,

  /// Push the body part away from the body.
  @JsonValue('push')
  push,

  /// Static exercises that do not involve movement.
  @JsonValue('static')
  static
}
