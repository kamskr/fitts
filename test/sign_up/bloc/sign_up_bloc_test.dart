import 'package:api_models/api_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/sign_up/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

void main() {
  const invalidUsernameString = 't';
  const invalidUsername = Username.dirty(invalidUsernameString);

  const validUsernameString = 'testTest';
  const validUsername = Username.dirty(validUsernameString);

  const invalidEmailString = 'test';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 't0pS3cret1234!!';
  const validPassword = Password.dirty(validPasswordString);

  group('SignUpBloc', () {
    late AuthenticationClient authenticationClient;
    late UserProfileRepository userProfileRepository;

    setUp(() {
      authenticationClient = MockAuthenticationClient();
      userProfileRepository = MockUserProfileRepository();

      when(
        () => authenticationClient.signUp(
          displayName: any(named: 'displayName'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});

      when(
        () => userProfileRepository.updateUserProfile(
          payload: UserProfileUpdatePayload.empty.copyWith(
            displayName: validUsernameString,
            email: validEmailString,
          ),
        ),
      ).thenAnswer((_) async {});
    });

    group('username changed', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits [invalid] when username/email/password are invalid',
        build: () => SignUpBloc(
          authenticationClient: authenticationClient,
          userProfileRepository: userProfileRepository,
        ),
        act: (bloc) => bloc.add(
          const SignUpUsernameChanged(invalidUsernameString),
        ),
        expect: () => const <SignUpState>[
          SignUpState(username: invalidUsername, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignUpBloc(
          authenticationClient: authenticationClient,
          userProfileRepository: userProfileRepository,
        ),
        seed: () => const SignUpState(
          email: validEmail,
          password: validPassword,
        ),
        act: (bloc) =>
            bloc.add(const SignUpUsernameChanged(validUsernameString)),
        expect: () => const <SignUpState>[
          SignUpState(
            username: validUsername,
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('email changed', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits [invalid] when username/email/password are invalid',
        build: () => SignUpBloc(
          authenticationClient: authenticationClient,
          userProfileRepository: userProfileRepository,
        ),
        act: (bloc) => bloc.add(
          const SignUpEmailChanged(invalidEmailString),
        ),
        expect: () => const <SignUpState>[
          SignUpState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignUpBloc(
          authenticationClient: authenticationClient,
          userProfileRepository: userProfileRepository,
        ),
        seed: () => const SignUpState(
          username: validUsername,
          password: validPassword,
        ),
        act: (bloc) => bloc.add(const SignUpEmailChanged(validEmailString)),
        expect: () => const <SignUpState>[
          SignUpState(
            username: validUsername,
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('password changed', () {
      blocTest<SignUpBloc, SignUpState>(
        'emits [invalid] when username/email/password are invalid',
        build: () => SignUpBloc(
          authenticationClient: authenticationClient,
          userProfileRepository: userProfileRepository,
        ),
        act: (bloc) => bloc.add(
          const SignUpPasswordChanged(invalidPasswordString),
        ),
        expect: () => const <SignUpState>[
          SignUpState(password: invalidPassword, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignUpBloc, SignUpState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignUpBloc(
          authenticationClient: authenticationClient,
          userProfileRepository: userProfileRepository,
        ),
        seed: () => const SignUpState(
          email: validEmail,
          username: validUsername,
        ),
        act: (bloc) =>
            bloc.add(const SignUpPasswordChanged(validPasswordString)),
        expect: () => const <SignUpState>[
          SignUpState(
            username: validUsername,
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });
  });
}
