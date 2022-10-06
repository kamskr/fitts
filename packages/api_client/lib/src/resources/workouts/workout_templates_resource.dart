import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
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
  static const _userTemplatesCollectionName = 'UserTemplates';

  /// Get user's workout templates.
  Stream<List<WorkoutTemplate>?> getUserWorkoutTemplates(String userId) {
    try {
      return _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userTemplatesCollectionName)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          try {
            return snapshot.docs
                .map((doc) => WorkoutTemplate.fromJson(doc.data()))
                .toList();
          } catch (e, st) {
            throw DeserializationException(e, st);
          }
        } else {
          return null;
        }
      }).transform(
        StreamTransformer.fromHandlers(
          handleError: (e, st, sink) {
            sink.addError(e);
          },
        ),
      );
    } on Exception catch (e, st) {
      throw ApiException(e, st);
    }
  }

  /// Get workout template by id.
  Stream<WorkoutTemplate?> getUserWorkoutTemplateById({
    required String userId,
    required String workoutTemplateId,
  }) {
    try {
      return _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userTemplatesCollectionName)
          .doc(workoutTemplateId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          try {
            return WorkoutTemplate.fromJson(snapshot.data()!);
          } catch (e, st) {
            throw DeserializationException(e, st);
          }
        } else {
          return null;
        }
      }).transform(
        StreamTransformer.fromHandlers(
          handleError: (e, st, sink) {
            sink.addError(e);
          },
        ),
      );
    } on Exception catch (e, st) {
      throw ApiException(e, st);
    }
  }

  /// This will create a new workout template in the UserTemplates.
  Future<void> createUserWorkoutTemplate({
    required String userId,
    required WorkoutTemplate payload,
  }) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userTemplatesCollectionName)
          .add(payload.toJson());
    } catch (e, st) {
      throw ApiException(e, st);
    }
  }

  /// This will update a workout template in the UserTemplates.
  Future<void> updateUserWorkoutTemplate({
    required String userId,
    required String workoutTemplateId,
    required WorkoutTemplate payload,
  }) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userTemplatesCollectionName)
          .doc(workoutTemplateId)
          .update(payload.toJson());
    } catch (e, st) {
      throw ApiException(e, st);
    }
  }

  /// This will delete a workout template in the UserTemplates.
  Future<void> deleteUserWorkoutTemplate({
    required String userId,
    required String workoutTemplateId,
  }) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userTemplatesCollectionName)
          .doc(workoutTemplateId)
          .delete();
    } catch (e, st) {
      throw ApiException(e, st);
    }
  }
}
