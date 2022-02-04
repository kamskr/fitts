import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

/// Password Form Input Validation Error.
enum PasswordValidationError {
  /// Password is empty.
  empty,

  /// Password does not match the [passwordRegex].
  invalid
}

/// {@template password}
/// Password form input.
/// {@endtemplate}
class Email extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Email.pure() : super.pure('');

  /// {@macro password}
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }

    if (!emailRegex.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}
