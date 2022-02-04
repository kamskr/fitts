import 'package:formz/formz.dart';

/// Text Form Input Validation Error.
enum TextValidationError {
  /// Text is empty.
  empty,
}

/// {@template password}
/// Text form input.
/// {@endtemplate}
class Text extends FormzInput<String, TextValidationError> {
  /// {@macro password}
  const Text.pure() : super.pure('');

  /// {@macro password}
  const Text.dirty([String value = '']) : super.dirty(value);

  @override
  TextValidationError? validator(String value) {
    if (value.isEmpty) {
      return TextValidationError.empty;
    }

    return null;
  }
}
