// ignore_for_file: use_late_for_private_fields_and_variables

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

  // ignore: unused_field
  final ApiClient _apiClient;

  // ignore: unused_field
  final _userProfileSubject = BehaviorSubject<UserProfile>();
  // ignore: cancel_subscriptions, unused_field
  StreamSubscription<UserProfile>? _userProfileSubscription;

  // ignore: comment_references
  /// Stores the last user id for which the [userProfile] method was called.
  /// It is used in order to reuse the stream and optimize number of calls
  /// to [UserProfileResource].
  // ignore: unused_field
  String? _lastUserId;
}
