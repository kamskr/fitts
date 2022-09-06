import 'package:json_annotation/json_annotation.dart';

/// Classifies exercises by the mechanic type.
enum MechanicType {
  /// Compound movements.
  @JsonValue('compound')
  compound,

  /// Isolated movements.
  @JsonValue('isolation')
  isolation,
}
