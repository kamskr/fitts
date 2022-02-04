// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const passwordString = 'TestPassword123!';
  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final password = Password.pure();
        expect(password.value, '');
        expect(password.pure, true);
      });

      test('dirty creates correct instance', () {
        final password = Password.dirty(passwordString);
        expect(password.value, passwordString);
        expect(password.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when password is empty', () {
        expect(
          Password.dirty().error,
          PasswordValidationError.empty,
        );
      });

      test('returns invalid error when password is malformed', () {
        expect(
          Password.dirty('test').error,
          PasswordValidationError.invalid,
        );
      });

      test('is valid when password is valid', () {
        expect(
          Password.dirty(passwordString).error,
          isNull,
        );
      });
    });
  });
}
