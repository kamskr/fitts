import 'package:app_models/app_models.dart';

/// {@template exercise_set_data}
/// Helper class for managing ExerciseSet state.
/// {@endtemplate}
class ExerciseSetData {
  /// {@macro exercise_set_data}
  ExerciseSetData({
    required this.setIndex,
    required this.set,
  });

  /// Index of the set in the exercise.
  final int setIndex;

  /// Set to display.
  final ExerciseSet set;
}
