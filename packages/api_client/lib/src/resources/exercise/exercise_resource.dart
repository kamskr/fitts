import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template exercise_resource}
/// Resource which exposes APIs related to exercises.
/// {@endtemplate}
class ExerciseResource {
  /// {@macro exercise_resource}
  ExerciseResource(FirebaseFirestore firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  static const _collectionName = 'Exercises';

  /// get of [Exercise] data for exercise with [exerciseId].
  Future<Exercise> getExercise(String exerciseId) async {
    late final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
    late final Map<String, dynamic>? data;
    try {
      documentSnapshot = await _firebaseFirestore
          .collection(_collectionName)
          .doc(exerciseId)
          .get();
      data = documentSnapshot.data();
    } catch (e, st) {
      throw ApiException(e, st);
    }
    if (documentSnapshot.exists && data != null) {
      try {
        return Exercise.fromJson(data);
      } catch (exception, stackTrace) {
        throw DeserializationException(exception, stackTrace);
      }
    } else {
      throw const NotFoundException();
    }
  }

  /// Get all [Exercise] data.
  Future<Map<String, Exercise>> getAllExercises() async {
    late QuerySnapshot<Map<String, dynamic>> querySnapshot;

    try {
      querySnapshot =
          await _firebaseFirestore.collection(_collectionName).get();
    } catch (e, st) {
      throw ApiException(e, st);
    }

    try {
      final exercises = <String, Exercise>{};

      for (final documentSnapshot in querySnapshot.docs) {
        final data = documentSnapshot.data();
        if (documentSnapshot.exists) {
          exercises[documentSnapshot.id] = Exercise.fromJson(data);
        }
      }

      return exercises;
    } catch (exception, stackTrace) {
      throw DeserializationException(exception, stackTrace);
    }
  }
}
