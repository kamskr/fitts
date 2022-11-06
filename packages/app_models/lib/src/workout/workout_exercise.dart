import 'dart:math';

import 'package:app_models/app_models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_exercise.g.dart';

/// {@template workout_exercise}
/// Model representing individual exercise in the workout.
/// It has a reference to the Exercise model which contains information about
/// the exercise itself.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class WorkoutExercise extends Equatable {
  /// {@macro workout_exercise}
  const WorkoutExercise({
    required this.exerciseId,
    required this.notes,
    required this.sets,
    required this.restTime,
  });

  /// Factory which converts a [Map] into a [WorkoutExercise].
  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      _$WorkoutExerciseFromJson(json);

  /// Converts the [WorkoutExercise] to [Map].
  Map<String, dynamic> toJson() => _$WorkoutExerciseToJson(this);

  /// Reference to the model containing details about the exercise.
  final String exerciseId;

  /// Notes about the exercise.
  final String notes;

  /// List of sets for the exercise.
  final List<ExerciseSet> sets;

  /// Rest time in seconds.
  final int restTime;

  /// Get total reps in this exercise.
  int get totalReps {
    return sets.fold<int>(
      0,
      (previousValue, element) => previousValue + element.repetitions,
    );
  }

  /// Get highest weight in this exercise.
  double get highestWeight {
    return sets.fold<double>(
      0,
      (previousValue, element) => max(previousValue, element.weight),
    );
  }

  /// Get overall best set in this exercise.
  OverallBest get overallBest {
    const currentOverallBest = OverallBest(weight: 0, repetitions: 0);

    return sets.fold<OverallBest>(
      currentOverallBest,
      (previousValue, element) {
        final currentOverallBest = element.weight * element.repetitions;
        final previousOverallBest =
            previousValue.weight * previousValue.repetitions;

        return currentOverallBest > previousOverallBest
            ? OverallBest(
                weight: element.weight,
                repetitions: element.repetitions,
              )
            : previousValue;
      },
    );
  }

  /// Creates a copy of [WorkoutExercise].
  WorkoutExercise copyWith({
    String? exerciseId,
    String? notes,
    List<ExerciseSet>? sets,
    int? restTime,
  }) {
    return WorkoutExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      notes: notes ?? this.notes,
      sets: sets ?? this.sets,
      restTime: restTime ?? this.restTime,
    );
  }

  @override
  List<Object> get props => [exerciseId, notes, sets, restTime];
}
