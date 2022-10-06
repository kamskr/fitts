import 'package:app_models/app_models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_template.g.dart';

/// {@template workout_template}
/// This model represents a workout template.
/// It contains all the information about the workout.
/// It's used as a blueprint for creating actual workout logs.
/// It can be a part of routine or standalone.
///
/// example: Chest day, Back day, etc.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class WorkoutTemplate extends Equatable {
  /// {@macro workout_template}
  const WorkoutTemplate({
    required this.name,
    required this.notes,
    required this.tonnageLifted,
    required this.workoutsCompleted,
    required this.averageWorkoutLength,
    required this.lastAverageRestTime,
    required this.exercises,
  });

  /// Factory which converts a [Map] into a [WorkoutTemplate].
  factory WorkoutTemplate.fromJson(Map<String, dynamic> json) =>
      _$WorkoutTemplateFromJson(json);

  /// Converts the [WorkoutTemplate] to [Map].
  Map<String, dynamic> toJson() => _$WorkoutTemplateToJson(this);

  /// Name of the workout.
  final String name;

  /// Notes about the workout.
  final String notes;

  /// Total tonnage lifted in this workout.
  final int tonnageLifted;

  /// Total number of workouts completed.
  final int workoutsCompleted;

  /// Average workout length in seconds.
  final int averageWorkoutLength;

  /// Average rest time between sets in seconds.
  final int lastAverageRestTime;

  /// List of exercises in the workout. Order is important, it defines the order
  /// in which exercises are performed.
  final List<WorkoutExercise> exercises;

  /// Creates a copy of [WorkoutTemplate].
  WorkoutTemplate copyWith({
    String? name,
    String? notes,
    int? tonnageLifted,
    int? workoutsCompleted,
    int? averageWorkoutLength,
    int? lastAverageRestTime,
    List<WorkoutExercise>? exercises,
  }) {
    return WorkoutTemplate(
      name: name ?? this.name,
      notes: notes ?? this.notes,
      tonnageLifted: tonnageLifted ?? this.tonnageLifted,
      workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
      averageWorkoutLength: averageWorkoutLength ?? this.averageWorkoutLength,
      lastAverageRestTime: lastAverageRestTime ?? this.lastAverageRestTime,
      exercises: exercises ?? this.exercises,
    );
  }

  @override
  List<Object> get props => [
        name,
        notes,
        tonnageLifted,
        workoutsCompleted,
        averageWorkoutLength,
        lastAverageRestTime,
        exercises,
      ];
}
