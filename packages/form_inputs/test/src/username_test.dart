// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const usernameString = 'TestUsername123';
  group('Username', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final username = Username.pure();
        expect(username.value, '');
        expect(username.pure, true);
      });

      test('dirty creates correct instance', () {
        final username = Username.dirty(usernameString);
        expect(username.value, usernameString);
        expect(username.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when username is empty', () {
        expect(
          Username.dirty().error,
          UsernameValidationError.empty,
        );
      });

      test('returns invalid error when username is malformed', () {
        expect(
          Username.dirty('test').error,
          UsernameValidationError.invalid,
        );
      });

      test('is valid when username is valid', () {
        expect(
          Username.dirty(usernameString).error,
          isNull,
        );
      });
    });
  });
}
