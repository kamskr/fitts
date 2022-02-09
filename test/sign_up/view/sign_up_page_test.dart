import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/sign_up/sign_up.dart';

import '../../helpers/pump_app.dart';

class MockSignUpBloc extends Mock implements SignUpBloc {}

void main() {
  const signUpButtonKey = Key('signUpPage_signUpButton');
  const usernameInputKey = Key('signUpForm_usernameInput_textField');
  const emailInputKey = Key('signUpForm_emailInput_textField');
  const passwordInputKey = Key('signUpForm_passwordInput_textField');

  const testUsername = 'testusername';
  const testEmail = 'test@gmail.com';
  const testPassword = 'testP@!ssw0rd1';

  group('SignUpPage', () {
    group('page', () {
      testWidgets('is routable.', (tester) async {
        expect(SignUpPage.route(), isA<MaterialPageRoute>());
      });

      testWidgets('renders properly.', (tester) async {
        await tester.pumpApp(const SignUpPage());

        expect(find.byType(SignUpPage), findsOneWidget);
      });
    });
    group('form', () {
      late SignUpBloc signUpBloc;
      // late MockNavigator navigator;

      setUp(() {
        signUpBloc = MockSignUpBloc();
        when(() => signUpBloc.state).thenReturn(const SignUpState());
      });

      group('adds', () {
        testWidgets('[SignUpUsernameChanged] when username changes',
            (tester) async {
          final expectedStates = [
            const SignUpState(),
            const SignUpState(
              username: Username.dirty(testUsername),
              status: FormzStatus.invalid,
            ),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );

          await tester.enterText(find.byKey(usernameInputKey), testUsername);

          verify(
            () => signUpBloc.add(const SignUpUsernameChanged(testUsername)),
          ).called(1);
        });
        testWidgets('[SignUpEmailChanged] when email changes', (tester) async {
          final expectedStates = [
            const SignUpState(),
            const SignUpState(
              email: Email.dirty(testEmail),
              status: FormzStatus.invalid,
            ),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );

          await tester.enterText(find.byKey(emailInputKey), testEmail);

          verify(
            () => signUpBloc.add(const SignUpEmailChanged(testEmail)),
          ).called(1);
        });

        testWidgets('[SignUpPasswordChanged] when password changes',
            (tester) async {
          final expectedStates = [
            const SignUpState(),
            const SignUpState(
              password: Password.dirty(testPassword),
              status: FormzStatus.invalid,
            ),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );

          await tester.enterText(find.byKey(passwordInputKey), testPassword);

          verify(
            () => signUpBloc.add(const SignUpPasswordChanged(testPassword)),
          ).called(1);
        });

        testWidgets(
            '[SignUpCredentialsSubmitted] when credentials valid '
            'and submit button pressed', (tester) async {
          final expectedStates = [
            const SignUpState(),
            const SignUpState(
              username: Username.dirty(testUsername),
              status: FormzStatus.invalid,
            ),
            const SignUpState(
              username: Username.dirty(testUsername),
              email: Email.dirty(testEmail),
              status: FormzStatus.invalid,
            ),
            const SignUpState(
              username: Username.dirty(testUsername),
              email: Email.dirty(testEmail),
              password: Password.dirty(testPassword),
              status: FormzStatus.invalid,
            ),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );

          await tester.enterText(find.byKey(usernameInputKey), testUsername);
          await tester.enterText(find.byKey(emailInputKey), testEmail);
          await tester.enterText(find.byKey(passwordInputKey), testPassword);
          await tester.tap(find.byKey(signUpButtonKey));

          verify(
            () => signUpBloc.add(SignUpCredentialsSubmitted()),
          ).called(1);
        });
      });
    });
  });
}
