import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/sign_in/sign_in.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

void main() {
  const invalidEmailString = 'test';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 't0pS3cret1234!!';
  const validPassword = Password.dirty(validPasswordString);

  group('SignInBloc', () {
    late AuthenticationClient authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationClient();
      when(
        () => authenticationRepository.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});
    });

    group('email changed', () {
      blocTest<SignInBloc, SignInState>(
        'emits [invalid] when username/email/password are invalid',
        build: () => SignInBloc(authenticationRepository),
        act: (bloc) => bloc.add(
          const SignInEmailChanged(invalidEmailString),
        ),
        expect: () => const <SignInState>[
          SignInState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignInBloc, SignInState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignInBloc(authenticationRepository),
        seed: () => const SignInState(
          password: validPassword,
        ),
        act: (bloc) => bloc.add(const SignInEmailChanged(validEmailString)),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('password changed', () {
      blocTest<SignInBloc, SignInState>(
        'emits [invalid] when username/email/password are invalid',
        build: () => SignInBloc(authenticationRepository),
        act: (bloc) => bloc.add(
          const SignInPasswordChanged(invalidPasswordString),
        ),
        expect: () => const <SignInState>[
          SignInState(password: invalidPassword, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignInBloc, SignInState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignInBloc(authenticationRepository),
        seed: () => const SignInState(
          email: validEmail,
        ),
        act: (bloc) =>
            bloc.add(const SignInPasswordChanged(validPasswordString)),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });
  });
}
