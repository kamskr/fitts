import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/sign_in/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

void main() {
  const invalidEmailString = 'test';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);
  const validEmailInvalidUserString = 'test1@gmail.com';
  const validEmailInvalidUser = Email.dirty('test1@gmail.com');

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 't0pS3cret1234!!';
  const validPassword = Password.dirty(validPasswordString);
  const errorMessage = 'Sth went wrong';

  group('SignInBloc', () {
    late AuthenticationClient authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationClient();
      when(
        () => authenticationRepository.signInWithEmailAndPassword(
          email: validEmailString,
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => authenticationRepository.signInWithEmailAndPassword(
          email: validEmailInvalidUserString,
          password: any(named: 'password'),
        ),
      ).thenThrow(const LogInWithEmailAndPasswordFailure(errorMessage));
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
    group('submitting', () {
      blocTest<SignInBloc, SignInState>(
        'emits [submissionSuccess] state when credentials are valid '
        'and submission is successful',
        build: () => SignInBloc(authenticationRepository),
        seed: () => const SignInState(
          email: validEmail,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.add(SignInCredentialsSubmitted()),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionInProgress,
          ),
          SignInState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );
      blocTest<SignInBloc, SignInState>(
        'emits [submissionFailure] with error message state when '
        'credentials are valid but repository returned error',
        build: () => SignInBloc(authenticationRepository),
        seed: () => const SignInState(
          email: validEmailInvalidUser,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.add(SignInCredentialsSubmitted()),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmailInvalidUser,
            password: validPassword,
            status: FormzStatus.submissionInProgress,
          ),
          SignInState(
            email: validEmailInvalidUser,
            password: validPassword,
            status: FormzStatus.submissionFailure,
            errorMessage: errorMessage,
          ),
        ],
      );
      blocTest<SignInBloc, SignInState>(
        'emits [submissionFailure] without error message state when '
        'credentials are valid but repository returned error',
        setUp: () {
          when(
            () => authenticationRepository.signInWithEmailAndPassword(
              email: validEmailInvalidUserString,
              password: any(named: 'password'),
            ),
          ).thenThrow(Error());
        },
        build: () => SignInBloc(authenticationRepository),
        seed: () => const SignInState(
          email: validEmailInvalidUser,
          password: validPassword,
          status: FormzStatus.valid,
        ),
        act: (bloc) => bloc.add(SignInCredentialsSubmitted()),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmailInvalidUser,
            password: validPassword,
            status: FormzStatus.submissionInProgress,
          ),
          SignInState(
            email: validEmailInvalidUser,
            password: validPassword,
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
      blocTest<SignInBloc, SignInState>(
        'emits [invalid] state when form is invalid',
        build: () => SignInBloc(authenticationRepository),
        seed: () => const SignInState(
          email: validEmail,
          password: invalidPassword,
        ),
        act: (bloc) => bloc.add(SignInCredentialsSubmitted()),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmail,
            password: invalidPassword,
            status: FormzStatus.invalid,
          ),
        ],
      );
    });
  });
}
