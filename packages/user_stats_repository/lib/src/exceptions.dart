/// {@template user_profile_failure}
/// Base failure class for the user stats repository failures.
/// {@endtemplate}
abstract class UserStatsFailure implements Exception {
  /// {@macro user_profile_failure}
  const UserStatsFailure(this.error, this.stackTrace);

  /// The error which was caught.
  final Object error;

  /// The stack trace associated with the [error].
  final StackTrace stackTrace;
}

/// {@template user_profile_stream_failure}
/// Thrown when an error occurs during user stats streaming.
/// {@endtemplate}
class UserStatsStreamFailure extends UserStatsFailure {
  /// {@macro user_profile_stream_failure}
  const UserStatsStreamFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}

/// {@template update_user_profile_failure}
/// Thrown when updating user stats fails.
/// {@endtemplate}
class UpdateUserStatsFailure extends UserStatsFailure {
  /// {@macro update_user_profile_failure}
  const UpdateUserStatsFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}
