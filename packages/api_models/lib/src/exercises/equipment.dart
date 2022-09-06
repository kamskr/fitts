import 'package:json_annotation/json_annotation.dart';

/// Classifies exercises by the equipment used.
enum Equipment {
  /// No equipment is used.
  @JsonValue('body')
  body,

  /// A machine is used.
  @JsonValue('machine')
  machine,

  /// A kettlebell is used.
  @JsonValue('kettlebells')
  kettlebells,

  /// A dumbbell is used.
  @JsonValue('dumbbell')
  dumbbell,

  /// A cable is used.
  @JsonValue('cable')
  cable,

  /// A barbell is used.
  @JsonValue('barbell')
  barbell,

  /// A band is used.
  @JsonValue('bands')
  bands,

  /// A medicine ball is used.
  @JsonValue('medicineBall')
  medicineBall,

  /// An exercise ball i s used.
  @JsonValue('exerciseBall')
  exerciseBall,

  /// An ez bar is used.
  @JsonValue('eZCurlBar')
  eZCurlBar,

  /// A foam roller is used.
  @JsonValue('foamRoll')
  foamRoll,
}
