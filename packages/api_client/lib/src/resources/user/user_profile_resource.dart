import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template user_profile_resource}
/// Resource which exposes APIs related to user profile.
/// {@endtemplate}
class UserProfileResource {
  /// {@macro user_profile_resource}
  UserProfileResource(FirebaseFirestore firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  static const _collectionName = 'UserProfiles';

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
    try {
      return _firebaseFirestore
          .collection(_collectionName)
          .doc(userProfileId)
          .snapshots()
          .map(_mapSnapshotToUserProfile);
    } catch (e, st) {
      throw ApiException(e, st);
    }
  }

  UserProfile _mapSnapshotToUserProfile(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>?;
      try {
        final userProfileData = UserProfileData.fromJson(data!);
        final emptyUser = UserProfile.empty;

        Gender? gender;
        ProfileStatus? profileStatus;

        switch (userProfileData.gender) {
          case GenderStringValue.male:
            gender = Gender.male;
            break;
          case GenderStringValue.female:
            gender = Gender.female;
            break;
        }

        switch (userProfileData.profileStatus) {
          case ProfileStatusStringValue.active:
            profileStatus = ProfileStatus.active;
            break;
          case ProfileStatusStringValue.onboardingRequired:
            profileStatus = ProfileStatus.onboardingRequired;
            break;
          case ProfileStatusStringValue.blocked:
            profileStatus = ProfileStatus.blocked;
            break;
        }

        return emptyUser.copyWith(
          email: userProfileData.email,
          photoUrl: userProfileData.photoUrl,
          displayName: userProfileData.displayName,
          goal: userProfileData.goal,
          gender: gender,
          dateOfBirth: userProfileData.dateOfBirth,
          height: userProfileData.height,
          weight: userProfileData.weight,
          profileStatus: profileStatus,
        );
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
          .collection(_collectionName)
          .doc(payload.email)
          .set(payload.toJson());
    } catch (error, stackTrace) {
      throw ApiException(error, stackTrace);
    }
  }
}
