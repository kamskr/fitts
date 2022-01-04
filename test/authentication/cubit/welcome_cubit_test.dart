// ignore_for_file: prefer_const_constructors
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/authentication/authentication.dart';

class WelcomeStateMockAuthenticationClient extends Mock
    implements AuthenticationClient {}

void main() {
  group('WelcomeCubit', () {
    late AuthenticationClient authenticationClient;

    setUp(() {
      authenticationClient = WelcomeStateMockAuthenticationClient();

      when(
        () => authenticationClient.signInWithGoogle(),
      ).thenAnswer((_) async {});
    });

    test('initial state is WelcomeState', () {
      expect(WelcomeCubit(authenticationClient).state, WelcomeState());
    });

    group('signInWithGoogle', () {
      blocTest<WelcomeCubit, WelcomeState>(
        'calls signInWithGoogle',
        build: () => WelcomeCubit(authenticationClient),
        act: (cubit) => cubit.signInWithGoogle(),
        verify: (_) {
          verify(() => authenticationClient.signInWithGoogle()).called(1);
        },
      );

      blocTest<WelcomeCubit, WelcomeState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when signInWithGoogle succeeds',
        build: () => WelcomeCubit(authenticationClient),
        act: (cubit) => cubit.signInWithGoogle(),
        expect: () => const <WelcomeState>[
          WelcomeState(status: FormzStatus.submissionInProgress),
          WelcomeState(status: FormzStatus.submissionSuccess)
        ],
      );

      blocTest<WelcomeCubit, WelcomeState>(
        'emits [submissionInProgress, submissionFailure] '
        'when signInWithGoogle fails with LogInWithGoogleFailure',
        setUp: () {
          when(
            () => authenticationClient.signInWithGoogle(),
          ).thenThrow(Exception('oops'));
        },
        build: () => WelcomeCubit(authenticationClient),
        act: (cubit) => cubit.signInWithGoogle(),
        expect: () => const <WelcomeState>[
          WelcomeState(status: FormzStatus.submissionInProgress),
          WelcomeState(status: FormzStatus.submissionFailure)
        ],
      );

      blocTest<WelcomeCubit, WelcomeState>(
        'emits [submissionInProgress, submissionFailure] '
        'when signInWithGoogle fails',
        setUp: () {
          when(
            () => authenticationClient.signInWithGoogle(),
          ).thenThrow(LogInWithGoogleFailure('oops'));
        },
        build: () => WelcomeCubit(authenticationClient),
        act: (cubit) => cubit.signInWithGoogle(),
        expect: () => const <WelcomeState>[
          WelcomeState(status: FormzStatus.submissionInProgress),
          WelcomeState(status: FormzStatus.submissionFailure)
        ],
      );
    });
  });
}
