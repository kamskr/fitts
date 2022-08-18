import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUpWithEmailAndPasswordFailure', () {
    test('uses value equality', () {
      expect(
        const SignUpWithEmailAndPasswordFailure(
          'mock-error',
        ),
        equals(
          const SignUpWithEmailAndPasswordFailure(
            'mock-error',
          ),
        ),
      );
    });

    test('returns the correct error message depending on status code', () {
      expect(
        SignUpWithEmailAndPasswordFailure.fromCode(
          'invalid-email',
        ),
        equals(
          const SignUpWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted.',
          ),
        ),
      );
      expect(
        SignUpWithEmailAndPasswordFailure.fromCode(
          'user-disabled',
        ),
        equals(
          const SignUpWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help.',
          ),
        ),
      );
      expect(
        SignUpWithEmailAndPasswordFailure.fromCode(
          'email-already-in-use',
        ),
        equals(
          const SignUpWithEmailAndPasswordFailure(
            'An account already exists for that email.',
          ),
        ),
      );
      expect(
        SignUpWithEmailAndPasswordFailure.fromCode(
          'operation-not-allowed',
        ),
        equals(
          const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed.  Please contact support.',
          ),
        ),
      );
      expect(
        SignUpWithEmailAndPasswordFailure.fromCode(
          'weak-password',
        ),
        equals(
          const SignUpWithEmailAndPasswordFailure(
            'Please enter a stronger password.',
          ),
        ),
      );
      expect(
        SignUpWithEmailAndPasswordFailure.fromCode(
          'mock-error',
        ),
        equals(
          const SignUpWithEmailAndPasswordFailure(),
        ),
      );
    });
  });
}
