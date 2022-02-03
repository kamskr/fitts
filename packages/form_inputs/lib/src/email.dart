import 'package:formz/formz.dart';

import '../form_inputs.dart';

/// Email Form Input Validation Error.
enum EmailValidationError {
  /// Email is empty.
  empty,

  /// Email does not match the [emailRegex].
  invalid
}

/// {@template email}
/// Email form input.
/// {@endtemplate}
class Email extends FormzInput<String, EmailValidationError> {
  /// {@macro email}
  const Email.pure() : super.pure('');

  /// {@macro email}
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    }

    if (!emailRegex.hasMatch(value)) {
      return EmailValidationError.invalid;
    }

    return null;
  }
}
