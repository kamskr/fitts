/// {@template user_profile_failure}
/// Base failure class for the user profile repository failures.
/// {@endtemplate}
abstract class UserProfileFailure implements Exception {
  /// {@macro user_profile_failure}
  const UserProfileFailure(this.error, this.stackTrace);

  /// The error which was caught.
  final Object error;

  /// The stack trace associated with the [error].
  final StackTrace stackTrace;
}

/// {@template user_profile_stream_failure}
/// Thrown when an error occurs during user profile streaming.
/// {@endtemplate}
class UserProfileStreamFailure extends UserProfileFailure {
  /// {@macro user_profile_stream_failure}
  const UserProfileStreamFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}

/// {@template update_user_profile_failure}
/// Thrown when updating user profile fails.
/// {@endtemplate}
class UpdateUserProfileFailure extends UserProfileFailure {
  /// {@macro update_user_profile_failure}
  const UpdateUserProfileFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}

/// {@template update_user_profile_action_failure}
/// Thrown when updating user profile fails.
/// {@endtemplate}
class UpdateUserProfileActionFailure extends UserProfileFailure {
  /// {@macro update_user_profile_action_failure}
  const UpdateUserProfileActionFailure(
    Object error,
    StackTrace stackTrace, {
    required this.message,
  }) : super(error, stackTrace);

  /// A message associated with the failed action.
  final String? message;
}
