import 'package:flutter_test/flutter_test.dart';
import 'package:fitts/sign_up/sign_up.dart';

void main() {
  group('SignUpEvent', () {
    group('SignUpUsernameChanged', () {
      const username = 'testUsername';
      test('supports value comparisons', () {
        expect(
          const SignUpUsernameChanged(username),
          equals(const SignUpUsernameChanged(username)),
        );
      });

      test('props are correct', () {
        expect(
          const SignUpUsernameChanged('username').props,
          equals(<Object?>[
            'username', // title
          ]),
        );
      });
    });

    group('SignUpEmailChanged', () {
      const email = 'test@test.pl';
      test('supports value comparisons', () {
        expect(
          const SignUpEmailChanged(email),
          equals(const SignUpEmailChanged(email)),
        );
      });

      test('props are correct', () {
        expect(
          const SignUpEmailChanged('email').props,
          equals(<Object?>[
            'email', // title
          ]),
        );
      });
    });

    group('SignUpPasswordChanged', () {
      const password = 'testPassword';
      test('supports value comparisons', () {
        expect(
          const SignUpPasswordChanged(password),
          equals(const SignUpPasswordChanged(password)),
        );
      });

      test('props are correct', () {
        expect(
          const SignUpPasswordChanged('password').props,
          equals(<Object?>[
            'password', // title
          ]),
        );
      });
    });

    group('SignUpCredentialsSubmitted', () {
      test('supports value comparisons', () {
        expect(
          SignUpCredentialsSubmitted(),
          equals(SignUpCredentialsSubmitted()),
        );
      });
    });
  });
}
