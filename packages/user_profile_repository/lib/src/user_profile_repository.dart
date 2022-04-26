// ignore_for_file: use_late_for_private_fields_and_variables

import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_profile_repository/src/exceptions.dart';

/// {@template user_profile_repository}
/// Repository which exposes user profile resource.
/// {@endtemplate}
class UserProfileRepository {
  /// {@macro user_profile_repository}
  UserProfileRepository(ApiClient apiClient) : _apiClient = apiClient;

  // ignore: unused_field
  final ApiClient _apiClient;

  // ignore: unused_field
  final _userProfileSubject = BehaviorSubject<UserProfile>();

  StreamSubscription<UserProfile>? _userProfileSubscription;

  // ignore: comment_references
  /// Stores the last user id for which the [userProfile] method was called.
  /// It is used in order to reuse the stream and optimize number of calls
  /// to [UserProfileResource].
  String? _lastUserId;

  /// Emits [UserProfile] data updates. If called multiple times, reuses
  /// existing stream.
  Stream<UserProfile> userProfile(String userId) {
    if (userId != _lastUserId) {
      _lastUserId = userId;

      /// Emit empty user profile when waiting for updates from the database.
      /// Ensures new user does not see any profile information of the previous
      /// one while waiting for the response.
      _userProfileSubject.add(UserProfile.empty);

      _userProfileSubscription?.cancel();
      _userProfileSubscription = _apiClient.userProfileResource
          .userProfile(userId)
          .handleError(_handleUserProfileStreamError)
          .listen(_userProfileSubject.add);
    }

    return _userProfileSubject.stream;
  }

  void _handleUserProfileStreamError(Object error, StackTrace stackTrace) {
    _userProfileSubject.addError(UserProfileStreamFailure(error, stackTrace));
  }

  /// Updates the user profile.
  /// User ID is equal to the user email.
  Future<void> updateUserProfile({
    required UserProfileUpdatePayload payload,
  }) async {
    try {
      final userProfileResource = _apiClient.userProfileResource;

      await userProfileResource.updateUserProfile(
        payload: payload,
      );
    } catch (error, stackTrace) {
      throw UpdateUserProfileFailure(error, stackTrace);
    }
  }
}
