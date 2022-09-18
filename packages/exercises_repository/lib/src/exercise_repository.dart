import 'package:api_client/api_client.dart';

/// {@template exercise_repository}
/// Repository which exposes exercise resource.
/// {@endtemplate}
class ExerciseRepository {
  /// {@macro exercise_repository}
  ExerciseRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Returns a list of exercises.
  /// Try to load exercises from local storage first.
  /// If there are no exercises in local storage,
  /// then load them from the API.
  // Future<Map<String, Exercise>> getExercises() async {}
}
