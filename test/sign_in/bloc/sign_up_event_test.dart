import 'package:fitts/sign_in/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignInEvent', () {
    group('SignInEmailChanged', () {
      const email = 'test@test.pl';
      test('supports value comparisons', () {
        expect(
          const SignInEmailChanged(email),
          equals(const SignInEmailChanged(email)),
        );
      });

      test('props are correct', () {
        expect(
          const SignInEmailChanged('email').props,
          equals(<Object?>[
            'email', // title
          ]),
        );
      });
    });

    group('SignInPasswordChanged', () {
      const password = 'testPassword';
      test('supports value comparisons', () {
        expect(
          const SignInPasswordChanged(password),
          equals(const SignInPasswordChanged(password)),
        );
      });

      test('props are correct', () {
        expect(
          const SignInPasswordChanged('password').props,
          equals(<Object?>[
            'password', // title
          ]),
        );
      });
    });

    group('SignInCredentialsSubmitted', () {
      test('supports value comparisons', () {
        expect(
          SignInCredentialsSubmitted(),
          equals(SignInCredentialsSubmitted()),
        );
      });
    });
  });
}
