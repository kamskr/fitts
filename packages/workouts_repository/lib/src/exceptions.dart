/// {@template user_profile_failure}
/// Base failure class for the user stats repository failures.
/// {@endtemplate}
abstract class WorkoutsFailure implements Exception {
  /// {@macro user_profile_failure}
  const WorkoutsFailure(this.error, this.stackTrace);

  /// The error which was caught.
  final Object error;

  /// The stack trace associated with the [error].
  final StackTrace stackTrace;
}

/// {@template workout_templates_stream_failure}
/// Thrown when an error occurs during workout templates list streaming.
/// {@endtemplate}
class WorkoutTemplatesStreamFailure extends WorkoutsFailure {
  /// {@macro workout_templates_stream_failure}
  const WorkoutTemplatesStreamFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}

/// {@template workout_template_stream_failure}
/// Thrown when an error occurs during single workout template streaming.
/// {@endtemplate}
class WorkoutTemplateStreamFailure extends WorkoutsFailure {
  /// {@macro workout_template_stream_failure}
  const WorkoutTemplateStreamFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}

/// {@template workout_logs_stream_failure}
/// Thrown when an error occurs during single workout logs streaming.
/// {@endtemplate}
class WorkoutLogsStreamFailure extends WorkoutsFailure {
  /// {@macro workout_logs_stream_failure}
  const WorkoutLogsStreamFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}

/// {@template workout_log_stream_failure}
/// Thrown when an error occurs during single workout log streaming.
/// {@endtemplate}
class WorkoutLogStreamFailure extends WorkoutsFailure {
  /// {@macro workout_logs_stream_failure}
  const WorkoutLogStreamFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}
