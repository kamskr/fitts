import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogInWithGoogleFailure', () {
    test('uses value equality', () {
      expect(
        const LogInWithGoogleFailure(
          'mock-error',
        ),
        equals(
          const LogInWithGoogleFailure(
            'mock-error',
          ),
        ),
      );
    });

    test('returns the correct error message depending on status code', () {
      expect(
        LogInWithGoogleFailure.fromCode(
          'account-exists-with-different-credential',
        ),
        equals(
          const LogInWithGoogleFailure(
            'Account exists with different credentials.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('invalid-credential'),
        equals(
          const LogInWithGoogleFailure(
            'The credential received is malformed or has expired.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('operation-not-allowed'),
        equals(
          const LogInWithGoogleFailure(
            'Operation is not allowed.  Please contact support.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('user-disabled'),
        equals(
          const LogInWithGoogleFailure(
            'This user has been disabled. Please contact support for help.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('user-not-found'),
        equals(
          const LogInWithGoogleFailure(
            'Email is not found, please create an account.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('wrong-password'),
        equals(
          const LogInWithGoogleFailure(
            'Incorrect password, please try again.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('invalid-verification-code'),
        equals(
          const LogInWithGoogleFailure(
            'The credential verification code received is invalid.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('invalid-verification-id'),
        equals(
          const LogInWithGoogleFailure(
            'The credential verification ID received is invalid.',
          ),
        ),
      );
      expect(
        LogInWithGoogleFailure.fromCode('unknown'),
        equals(
          const LogInWithGoogleFailure(),
        ),
      );
    });
  });
}
