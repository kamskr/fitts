import 'package:api_models/src/exercises/exercises.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

/// {@template exercise}
/// Model representing an exercise.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class Exercise extends Equatable {
  /// {@macro exercise}
  const Exercise({
    required this.name,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.level,
    required this.category,
    required this.instructions,
    this.tips,
    this.force,
    this.mechanicType,
    this.equipment,
    this.description,
    this.aliases,
  });

  /// Factory which converts a [Map] into a [Exercise].
  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  /// Name of the exercise.
  final String name;

  /// Alias names of the exercise.
  final List<String>? aliases;

  /// Primary muscles used in the exercise.
  final List<Muscle> primaryMuscles;

  /// Secondary muscles used in the exercise.
  final List<Muscle> secondaryMuscles;

  /// Force type of the exercise.
  final Force? force;

  /// Difficulty level of the exercise.
  final Level level;

  /// Mechanic type of the exercise.
  final MechanicType? mechanicType;

  /// Equipment used in the exercise.
  final Equipment? equipment;

  /// Category of the exercise.
  final ExerciseCategory category;

  /// Instructions for the exercise.
  final List<String> instructions;

  /// Exercise description.
  final String? description;

  /// Tips for the exercise.
  final List<String>? tips;

  /// Converts the [Exercise] to [Map].
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  @override
  List<Object?> get props => [
        name,
        aliases,
        primaryMuscles,
        secondaryMuscles,
        force,
        level,
        mechanicType,
        equipment,
        category,
        instructions,
        description,
        tips,
      ];
}
