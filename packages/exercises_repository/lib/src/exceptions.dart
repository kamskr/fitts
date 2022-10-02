/// {@template exercise_failure}
/// Base failure class for the user profile repository failures.
/// {@endtemplate}
abstract class ExerciseFailure implements Exception {
  /// {@macro exercise_failure}
  const ExerciseFailure(this.error, this.stackTrace);

  /// The error which was caught.
  final Object error;

  /// The stack trace associated with the [error].
  final StackTrace stackTrace;
}

/// {@template exercises_fetch_failure}
/// Thrown when fetching exercises fails.
/// {@endtemplate}
class ExercisesFetchFailure extends ExerciseFailure {
  /// {@macro update_user_profile_failure}
  const ExercisesFetchFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}
