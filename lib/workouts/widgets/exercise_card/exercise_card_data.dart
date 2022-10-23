import 'package:app_models/app_models.dart';
import 'package:flutter/material.dart';

/// {@template exercise_card_data}
/// Helper class for managing ExerciseCard state.
/// {@endtemplate}
class ExerciseCardData {
  /// {@macro exercise_card_data}
  ExerciseCardData({
    required this.exerciseIndex,
    required this.exerciseCount,
    required this.exercise,
    this.onExerciseChanged,
    this.onExerciseDeleted,
    this.onExerciseSetDeleted,
    this.onExerciseSetChanged,
    this.onSetFinished,
  });

  /// Index of the exercise in the workout.
  final int exerciseIndex;

  /// Total number of exercises in the workout.
  final int exerciseCount;

  /// Exercise to display.
  final WorkoutExercise exercise;

  /// Callback to call when the exercise is changed.
  final void Function(int, WorkoutExercise)? onExerciseChanged;

  /// Callback to call when the exercise is deleted.
  final void Function(int)? onExerciseDeleted;

  /// Callback to call when the set of exercise is deleted.
  final void Function(
    int exerciseIndex,
    int setIndex,
  )? onExerciseSetDeleted;

  /// Callback to call when the set of exercise is changed.
  final void Function(
    int exerciseIndex,
    int setIndex,
    ExerciseSet set,
  )? onExerciseSetChanged;

  /// Callback called when the set is finished.
  final VoidCallback? onSetFinished;
}
