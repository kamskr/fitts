import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';

/// NotEmptyText Form Input Validation Error.
enum NotEmptyTextValidationError {
  /// NotEmptyText is empty.
  empty,
}

/// {@template password}
/// NotEmptyText form input.
/// {@endtemplate}
class NotEmptyText extends FormzInput<String, NotEmptyTextValidationError> {
  /// {@macro password}
  const NotEmptyText.pure() : super.pure('');

  /// {@macro password}
  const NotEmptyText.dirty([String value = '']) : super.dirty(value);

  @override
  NotEmptyTextValidationError? validator(String value) {
    if (value.isEmpty) {
      return NotEmptyTextValidationError.empty;
    }

    return null;
  }
}
