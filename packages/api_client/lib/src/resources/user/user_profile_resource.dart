import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template user_profile_resource}
/// Resource which exposes APIs related to user profile.
/// {@endtemplate}
class UserProfileResource {
  /// {@macro user_profile_resource}
  const UserProfileResource({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  /// Returns a stream of user profile updates for given [userId].
  ///
  /// Method onValue first populates stream with the existing user profile
  /// information and then continues to listen for updates to the same object.
  ///
  /// If the user profile value for the user with the given id does not exist
  /// [UserProfile.empty] will be emitted.
  ///
  /// It emits a [DeserializationException] when deserialization fails.
  Stream<UserProfile> userProfile(String userId) {
    return _firebaseFirestore
        .collection('profiles')
        .doc(userId)
        .snapshots()
        .map(_mapSnapshotToUserProfile);
  }

  UserProfile _mapSnapshotToUserProfile(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot as Map);
      try {
        return UserProfile.fromJson(data);
      } catch (error, stackTrace) {
        throw DeserializationException(error, stackTrace);
      }
    }

    return UserProfile.empty;
  }
}
