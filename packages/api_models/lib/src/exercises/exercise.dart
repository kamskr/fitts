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
    required this.id,
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

  /// ID of the exercise.
  @JsonKey(name: 'id')
  final String id;

  /// Name of the exercise.
  @JsonKey(name: 'name')
  final String name;

  /// Alias names of the exercise.
  @JsonKey(name: 'aliases', includeIfNull: false)
  final List<String>? aliases;

  /// Primary muscles used in the exercise.
  @JsonKey(name: 'primaryMuscles')
  final List<Muscle> primaryMuscles;

  /// Secondary muscles used in the exercise.
  @JsonKey(name: 'secondaryMuscles')
  final List<Muscle> secondaryMuscles;

  /// Force type of the exercise.
  @JsonKey(name: 'force')
  final Force? force;

  /// Difficulty level of the exercise.
  @JsonKey(name: 'level')
  final Level level;

  /// Mechanic type of the exercise.
  @JsonKey(name: 'mechanic', includeIfNull: false)
  final MechanicType? mechanicType;

  /// Equipment used in the exercise.
  @JsonKey(name: 'equipment', includeIfNull: false)
  final Equipment? equipment;

  /// Category of the exercise.
  @JsonKey(name: 'category', includeIfNull: false)
  final ExerciseCategory category;

  /// Instructions for the exercise.
  @JsonKey(name: 'instructions', includeIfNull: false)
  final List<String> instructions;

  /// Exercise description.
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  /// Tips for the exercise.
  @JsonKey(name: 'tips', includeIfNull: false)
  final List<String>? tips;

  /// Converts the [Exercise] to [Map].
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  /// Copy with helper method.
  Exercise copyWith({
    String? id,
    String? name,
    List<String>? aliases,
    List<Muscle>? primaryMuscles,
    List<Muscle>? secondaryMuscles,
    Force? force,
    Level? level,
    MechanicType? mechanicType,
    Equipment? equipment,
    ExerciseCategory? category,
    List<String>? instructions,
    String? description,
    List<String>? tips,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      aliases: aliases ?? this.aliases,
      primaryMuscles: primaryMuscles ?? this.primaryMuscles,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      force: force ?? this.force,
      level: level ?? this.level,
      mechanicType: mechanicType ?? this.mechanicType,
      equipment: equipment ?? this.equipment,
      category: category ?? this.category,
      instructions: instructions ?? this.instructions,
      description: description ?? this.description,
      tips: tips ?? this.tips,
    );
  }

  @override
  List<Object?> get props => [
        id,
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
