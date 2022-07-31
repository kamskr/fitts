import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:rxdart/rxdart.dart';

import 'exceptions.dart';

/// {@template user_stats_repository}
/// Repository which exposes user stats resource.
/// {@endtemplate}
class UserStatsRepository {
  /// {@macro user_stats_repository}
  UserStatsRepository(ApiClient apiClient) : _apiClient = apiClient;

  final ApiClient _apiClient;

  final _userStatsSubject = BehaviorSubject<UserStats>();

  /// Stores the last user id for which the [userProfile] method was called.
  /// It is used in order to reuse the stream and optimize number of calls
  /// to [UserStatsResource].
  String? _lastUserId;

  /// Emits [UserStats] data updates. If called multiple times, reuses
  /// existing stream.
  Stream<UserStats> userStats(String userId) {
    if (userId != _lastUserId) {
      _lastUserId = userId;

      _userProfileSubscription = _apiClient.userStatsResource
          .userStats(userId)
          .handleError(_handleUserStatsStreamError)
          .listen(_userStatsSubject.add);
    }

    return _userStatsSubject.stream;
  }

  void _handleUserStatsStreamError(Object error, StackTrace stackTrace) {
    _userStatsSubject.addError(UserStatsStreamFailure(error, stackTrace));
  }

  /// Updates the user stats.
  /// User ID is equal to the user email.
  Future<void> updateUserProfile({
    required String userId,
    required UserStats payload,
  }) async {
    try {
      final userStatsResource = _apiClient.userStatsResource;

      await userStatsResource.updateUserStats(
        payload: userStats,
      );
    } catch (error, stackTrace) {
      throw UpdateUserStatsFailure(error, stackTrace);
    }
  }
}
