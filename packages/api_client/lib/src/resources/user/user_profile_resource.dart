import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template user_profile_resource}
/// Resource which exposes APIs related to user profile.
/// {@endtemplate}
class UserProfileResource {
  /// {@macro user_profile_resource}
  UserProfileResource(FirebaseFirestore firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;
  static const collectionName = 'UserProfiles';

  /// Returns a stream of user profile updates for given [userProfileId].
  ///
  /// Method onValue first populates stream with the existing user profile
  /// information and then continues to listen for updates to the same object.
  ///
  /// If the user profile value for the user with the given id does not exist
  /// [UserProfile.empty] will be emitted.
  ///
  /// It emits a [DeserializationException] when deserialization fails.
  Stream<UserProfile> userProfile(String userProfileId) {
    return _firebaseFirestore
        .collection(collectionName)
        .doc(userProfileId)
        .snapshots()
        .map(_mapSnapshotToUserProfile);
  }

  UserProfile _mapSnapshotToUserProfile(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      // final data = {
      //   'photoUrl': 'www.test-url.te',
      //   'displayName': 'displayName',
      //   'goal': 'goal',
      //   'gender': 'male',
      //   'dateOfBirth': DateTime.now(),
      //   'height': 180,
      //   'weight': 85.5
      // };
      final data = snapshot.data() as Map<String, dynamic>?;
      print(data);
      try {
        return UserProfile.fromJson(data!);
      } catch (error, stackTrace) {
        throw DeserializationException(error, stackTrace);
      }
    }

    return UserProfile.empty;
  }

  /// Update user profile information.
  /// This method can also be used to create user profile.
  ///
  /// When connection to the Firestore is not possible throws
  /// exception of type [ApiException].
  Future<void> updateUserProfile({
    required UserProfileUpdatePayload payload,
  }) async {
    try {
      await _firebaseFirestore
          .collection(collectionName)
          .doc(payload.email)
          .set(payload.toJson());
    } catch (error, stackTrace) {
      throw ApiException(error, stackTrace);
    }
  }
}
