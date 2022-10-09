import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template workout_logs_resource}
/// Resource which exposes APIs related to workout logs.
/// {@endtemplate}
class WorkoutLogsResource {
  /// {@macro workout_logs_resource}
  WorkoutLogsResource(FirebaseFirestore firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  static const _collectionName = 'WorkoutLogs';
  static const _userLogsCollectionName = 'UserLogs';

  /// Get user's workout logs.
  Stream<List<WorkoutLog>?> getUserWorkoutLogs(String userId) {
    try {
      return _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userLogsCollectionName)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          try {
            return snapshot.docs
                .map((doc) => WorkoutLog.fromJson(doc.data()))
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

  /// Get workout log by id.
  Stream<WorkoutLog?> getUserWorkoutLogById({
    required String userId,
    required String workoutLogId,
  }) {
    try {
      return _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userLogsCollectionName)
          .doc(workoutLogId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          try {
            return WorkoutLog.fromJson(snapshot.data()!);
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

  ///

  /// This will create a new workout log in the UserLogs.
  Future<void> createUserWorkoutLog({
    required String userId,
    required WorkoutLog payload,
  }) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userLogsCollectionName)
          .doc(payload.id)
          .set(payload.toJson());
    } catch (e, st) {
      throw ApiException(e, st);
    }
  }

  /// This will update a workout log in the UserLogs.
  Future<void> updateUserWorkoutLog({
    required String userId,
    required String workoutLogId,
    required WorkoutLog payload,
  }) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userLogsCollectionName)
          .doc(workoutLogId)
          .update(payload.toJson());
    } catch (e, st) {
      throw ApiException(e, st);
    }
  }

  /// This will delete a workout log in the UserLogs.
  Future<void> deleteUserWorkoutLog({
    required String userId,
    required String workoutLogId,
  }) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .collection(_userLogsCollectionName)
          .doc(workoutLogId)
          .delete();
    } catch (e, st) {
      throw ApiException(e, st);
    }
  }
}
