import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:rxdart/rxdart.dart';

import 'package:user_stats_repository/src/exceptions.dart';

/// {@template user_stats_repository}
/// Repository which exposes user stats resource.
/// {@endtemplate}
class UserStatsRepository {
  /// {@macro user_stats_repository}
  UserStatsRepository({
    required ApiClient apiClient,
    required AuthenticationClient authenticationClient,
  })  : _apiClient = apiClient,
        _authenticationClient = authenticationClient;

  final ApiClient _apiClient;
  final AuthenticationClient _authenticationClient;

  BehaviorSubject<UserStats?>? _userStatsSubject;

  /// Returns a stream of user stats updates for a current user.
  ///
  /// When this method is called multiple times for the same user id,
  /// then the already existing stream is reused.
  Stream<UserStats?> get userStats {
    if (_userStatsSubject == null) {
      _userStatsSubject = BehaviorSubject();

      final userStatsResource = _apiClient.userStatsResource;

      final userStatsStream = _authenticationClient.user
          .distinct((user1, user2) => user1.id == user2.id)
          .switchMap((user) => userStatsResource.userStats(user.id));

      userStatsStream
          .handleError(_handleUserStatsStreamError)
          .listen(_userStatsSubject!.add);
    }
    return _userStatsSubject!.stream;
  }

  void _handleUserStatsStreamError(Object error, StackTrace stackTrace) {
    _userStatsSubject?.addError(UserStatsStreamFailure(error, stackTrace));
  }

  /// Updates the user stats.
  /// User ID is equal to the user email.
  Future<void> updateUserStats({
    required String userId,
    required UserStats payload,
  }) async {
    try {
      final userStatsResource = _apiClient.userStatsResource;

      await userStatsResource.updateUserStats(
        userId: userId,
        payload: payload,
      );
    } catch (error, stackTrace) {
      throw UpdateUserStatsFailure(error, stackTrace);
    }
  }
}
