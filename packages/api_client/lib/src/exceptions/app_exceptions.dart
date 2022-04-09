/// {@template app_exception}
/// Class to define what custom exceptions should hold as parameters.
/// {@endtemplate}
abstract class AppException implements Exception {
  /// {@macro app_exception}
  const AppException(this.originalException, this.originalStackTrace);

  /// Error originally thrown in the API layer.
  /// Passed to be reported in the upper layer.
  final Object originalException;

  /// [StackTrace] where the exception occurred.
  final StackTrace originalStackTrace;
}

/// {@template api_exception}
/// Umbrella for all the exceptions that can be thrown by the API.
/// {@endtemplate}
class ApiException extends AppException {
  /// {@macro api_exception}
  const ApiException(
    Object originalException,
    StackTrace originalStackTrace,
  ) : super(originalException, originalStackTrace);
}

/// {@template deserialization_exception}
/// [Exception] thrown when the object passed from API cannot be
/// deserialized in the expected by the app way.
/// {@endtemplate}
class DeserializationException extends AppException {
  /// {@macro deserialization_exception}
  const DeserializationException(
    Object originalException,
    StackTrace originalStackTrace,
  ) : super(originalException, originalStackTrace);
}
