import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogInWithEmailAndPasswordFailure', () {
    test('uses value equality', () {
      expect(
        const LogInWithEmailAndPasswordFailure(
          'mock-error',
        ),
        equals(
          const LogInWithEmailAndPasswordFailure(
            'mock-error',
          ),
        ),
      );
    });

    test('returns the correct error message depending on status code', () {
      expect(
        LogInWithEmailAndPasswordFailure.fromCode('invalid-email'),
        equals(
          const LogInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted.',
          ),
        ),
      );
      expect(
        LogInWithEmailAndPasswordFailure.fromCode('user-disabled'),
        equals(
          const LogInWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help.',
          ),
        ),
      );
      expect(
        LogInWithEmailAndPasswordFailure.fromCode('user-not-found'),
        equals(
          const LogInWithEmailAndPasswordFailure(
            'Email is not found, please create an account.',
          ),
        ),
      );
      expect(
        LogInWithEmailAndPasswordFailure.fromCode('wrong-password'),
        equals(
          const LogInWithEmailAndPasswordFailure(
            'Incorrect password, please try again.',
          ),
        ),
      );
      expect(
        LogInWithEmailAndPasswordFailure.fromCode('unknown'),
        equals(
          const LogInWithEmailAndPasswordFailure(),
        ),
      );
    });
  });
}
