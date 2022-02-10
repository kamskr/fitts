import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';

/// Username Form Input Validation Error.
enum UsernameValidationError {
  /// Username is empty.
  empty,

  /// Username is invalid.
  invalid,
}

/// {@template password}
/// Username form input.
/// {@endtemplate}
class Username extends FormzInput<String, UsernameValidationError> {
  /// {@macro password}
  const Username.pure() : super.pure('');

  /// {@macro password}
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    }

    if (!usernameRegex.hasMatch(value)) {
      return UsernameValidationError.invalid;
    }

    return null;
  }
}
