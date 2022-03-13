import 'package:app_ui/app_ui.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fitts/sign_up/sign_up.dart';

import '../../helpers/pump_app.dart';

class MockSignUpBloc extends Mock implements SignUpBloc {}

class MockUsername extends Mock implements Username {}

class MockEmail extends Mock implements Email {}

class MockPassword extends Mock implements Password {}

void main() {
  const signUpButtonKey = Key('signUpPage_signUpButton');
  const usernameInputKey = Key('signUpPage_usernameInput_textField');
  const emailInputKey = Key('signUpPage_emailInput_textField');
  const passwordInputKey = Key('signUpPage_passwordInput_textField');

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

      group('renders', () {
        testWidgets('invalid username error text when username is invalid',
            (tester) async {
          final username = MockUsername();

          when(() => username.invalid).thenReturn(true);
          final expectedStates = [
            SignUpState(username: username, status: FormzStatus.invalid),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.text('This username is invalid'), findsOneWidget);
        });

        testWidgets('invalid email error text when email is invalid',
            (tester) async {
          final email = MockEmail();

          when(() => email.invalid).thenReturn(true);
          final expectedStates = [
            SignUpState(email: email, status: FormzStatus.invalid),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.text('This email is invalid'), findsOneWidget);
        });

        testWidgets('invalid password error text when password is invalid',
            (tester) async {
          final password = MockPassword();

          when(() => password.invalid).thenReturn(true);
          final expectedStates = [
            SignUpState(password: password, status: FormzStatus.invalid),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.text('This password is invalid'), findsOneWidget);
        });

        testWidgets('disabled sign up button when status is not validated',
            (tester) async {
          when(() => signUpBloc.state).thenReturn(
            const SignUpState(status: FormzStatus.invalid),
          );

          final expectedStates = [
            const SignUpState(status: FormzStatus.invalid),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );

          final signUpButton = tester.widget<AppButton>(
            find.byKey(signUpButtonKey),
          );
          expect(signUpButton.onPressed, isNull);
        });

        testWidgets('enabled sign up button when status is validated',
            (tester) async {
          when(() => signUpBloc.state).thenReturn(
            const SignUpState(status: FormzStatus.valid),
          );

          final expectedStates = [
            const SignUpState(status: FormzStatus.valid),
          ];

          whenListen(signUpBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );

          final signUpButton = tester.widget<AppButton>(
            find.byKey(signUpButtonKey),
          );
          expect(signUpButton.onPressed, isNotNull);
        });
      });
      group('navigates', () {
        testWidgets('back to previous page when submission status is success',
            (tester) async {
          whenListen(
            signUpBloc,
            Stream.fromIterable(const <SignUpState>[
              SignUpState(status: FormzStatus.submissionInProgress),
              SignUpState(status: FormzStatus.submissionSuccess),
            ]),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: signUpBloc,
              child: const SignUpView(),
            ),
          );

          expect(find.byType(SignUpView), findsOneWidget);
          await tester.pumpAndSettle();
          expect(find.byType(SignUpView), findsNothing);
        });
      });
    });
  });
}
