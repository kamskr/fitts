import 'package:json_annotation/json_annotation.dart';

/// Classifies exercises by the equipment used.
enum Equipment {
  /// No equipment is used.
  @JsonValue('body only')
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
  @JsonValue('medicine ball')
  medicineBall,

  /// An exercise ball i s used.
  @JsonValue('exercise ball')
  exerciseBall,

  /// An ez bar is used.
  @JsonValue('e-z curl bar')
  eZCurlBar,

  /// A foam roller is used.
  @JsonValue('foam roll')
  foamRoll,

  /// Not specified equipment.
  @JsonValue('other')
  other,
}
