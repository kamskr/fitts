import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';

import 'package:exercises_repository/src/exceptions.dart';

/// {@template exercise_repository}
/// Repository which exposes exercise resource.
/// {@endtemplate}
class ExerciseRepository {
  /// {@macro exercise_repository}
  ExerciseRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  final _exercises = <String, Exercise>{};

  /// Returns a list of exercises.
  /// Try to load exercises from local storage first.
  /// If there are no exercises in local storage,
  /// then load them from the API.
  Future<Map<String, Exercise>> getExercises() async {
    if (_exercises.isEmpty) {
      try {
        _exercises.addAll(await _apiClient.exerciseResource.getAllExercises());
      } catch (e, st) {
        throw ExercisesFetchFailure(e, st);
      }
    }
    return _exercises;
  }

  /// Returns an exercise with [exerciseId].
  /// Try to load exercises from local storage first.
  /// If there are no exercises in local storage,
  /// then load them from the API.
  Future<Exercise> getExercise(String exerciseId) async {
    if (_exercises[exerciseId] == null) {
      try {
        _exercises[exerciseId] = await _apiClient.exerciseResource.getExercise(
          exerciseId,
        );
      } catch (e, st) {
        throw ExercisesFetchFailure(e, st);
      }
    }

    return _exercises[exerciseId]!;
  }
}
