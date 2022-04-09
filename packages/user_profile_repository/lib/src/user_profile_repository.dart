import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:rxdart/rxdart.dart';

/// {@template user_profile_repository}
/// Repository which exposes user profile resource.
/// {@endtemplate}
class UserProfileRepository {
  /// {@macro user_profile_repository}
  UserProfileRepository(ApiClient apiClient) : _apiClient = apiClient;

  final ApiClient _apiClient;

  final _userProfileSubject = BehaviorSubject<UserProfile>();
  StreamSubscription<UserProfile>? _userProfileSubscription;

  /// Stores the last user id for which the [userProfile] method was called.
  /// It is used in order to reuse the stream and optimize number of calls
  /// to [UserProfileResource].
  String? _lastUserId;
}
