import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template user_stats_resource}
/// Resource which exposes APIs related to user stats.
/// {@endtemplate}
class UserStatsResource {
  /// {@macro user_stats_resource}
  UserStatsResource(FirebaseFirestore firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  static const _collectionName = 'UserStats';

  /// Stream of [UserStats] data for user with id [userId].
  Stream<UserStats?> userStats(String userId) {
    try {
      return _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .snapshots()
          .map<UserStats?>((documentSnapshot) {
        final data = documentSnapshot.data();
        if (documentSnapshot.exists && data != null) {
          try {
            return UserStats.fromJson(data);
          } catch (exception, stackTrace) {
            throw DeserializationException(exception, stackTrace);
          }
        } else {
          return null;
        }
      }).transform(StreamTransformer.fromHandlers(
        handleError: (e, st, sink) {
          sink.addError(e);
        },
      ));
    } on Exception catch (e, st) {
      throw ApiException(e, st);
    }
  }

  /// Update user stats information.
  /// This method can also be used to create user stats.
  ///
  /// When connection to the Firestore is not possible throws
  /// exception of type [ApiException].
  Future<void> updateUserStats({
    required String userId,
    required UserStats payload,
  }) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(userId)
          .set(payload.toJson());
    } catch (error, stackTrace) {
      throw ApiException(error, stackTrace);
    }
  }
}
