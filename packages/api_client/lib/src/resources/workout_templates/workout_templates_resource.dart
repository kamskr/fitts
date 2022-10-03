import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template workout_templates_resource}
/// Resource which exposes APIs related to workout templates.
/// {@endtemplate}
class WorkoutTemplatesResource {
  /// {@macro workout_templates_resource}
  WorkoutTemplatesResource(FirebaseFirestore firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  static const _collectionName = 'WorkoutTemplates';

  // /// get of [Exercise] data for exercise with [exerciseId].
  // Future<Exercise> getExercise(String exerciseId) async {
  // }

  // /// Get all [Exercise] data.
  // Future<Map<String, Exercise>> getAllExercises() async {}
}
