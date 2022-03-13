import 'package:app_ui/app_ui.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockSignInBloc extends Mock implements SignInBloc {}

class MockUsername extends Mock implements Username {}

class MockEmail extends Mock implements Email {}

class MockPassword extends Mock implements Password {}

void main() {
  const signInButtonKey = Key('signInPage_signInButton');
  const emailInputKey = Key('signInPage_emailInput_textField');
  const passwordInputKey = Key('signInPage_passwordInput_textField');

  const testEmail = 'test@gmail.com';
  const testPassword = 'testP@!ssw0rd1';

  group('SignInPage', () {
    group('page', () {
      testWidgets('is routable.', (tester) async {
        expect(SignInPage.route(), isA<MaterialPageRoute>());
      });

      testWidgets('renders properly.', (tester) async {
        await tester.pumpApp(const SignInPage());

        expect(find.byType(SignInPage), findsOneWidget);
      });
    });
    group('form', () {
      late SignInBloc signInBloc;
      // late MockNavigator navigator;

      setUp(() {
        signInBloc = MockSignInBloc();
        when(() => signInBloc.state).thenReturn(const SignInState());
      });

      group('adds', () {
        testWidgets('[SignInEmailChanged] when email changes', (tester) async {
          final expectedStates = [
            const SignInState(),
            const SignInState(
              email: Email.dirty(testEmail),
              status: FormzStatus.invalid,
            ),
          ];

          whenListen(signInBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
            ),
          );

          await tester.enterText(find.byKey(emailInputKey), testEmail);

          verify(
            () => signInBloc.add(const SignInEmailChanged(testEmail)),
          ).called(1);
        });

        testWidgets('[SignInPasswordChanged] when password changes',
            (tester) async {
          final expectedStates = [
            const SignInState(),
            const SignInState(
              password: Password.dirty(testPassword),
              status: FormzStatus.invalid,
            ),
          ];

          whenListen(signInBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
            ),
          );

          await tester.enterText(find.byKey(passwordInputKey), testPassword);

          verify(
            () => signInBloc.add(const SignInPasswordChanged(testPassword)),
          ).called(1);
        });

        testWidgets(
            '[SignInCredentialsSubmitted] when credentials valid '
            'and submit button pressed', (tester) async {
          final expectedStates = [
            const SignInState(),
            const SignInState(
              status: FormzStatus.invalid,
            ),
            const SignInState(
              email: Email.dirty(testEmail),
              status: FormzStatus.invalid,
            ),
            const SignInState(
              email: Email.dirty(testEmail),
              password: Password.dirty(testPassword),
              status: FormzStatus.valid,
            ),
          ];

          whenListen(signInBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
            ),
          );

          await tester.enterText(find.byKey(emailInputKey), testEmail);
          await tester.enterText(find.byKey(passwordInputKey), testPassword);
          await tester.tap(find.byKey(signInButtonKey));

          verify(
            () => signInBloc.add(SignInCredentialsSubmitted()),
          ).called(1);
        });
      });

      group('renders', () {
        testWidgets('invalid email error text when email is invalid',
            (tester) async {
          final email = MockEmail();

          when(() => email.invalid).thenReturn(true);
          final expectedStates = [
            SignInState(email: email, status: FormzStatus.invalid),
          ];

          whenListen(signInBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
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
            SignInState(password: password, status: FormzStatus.invalid),
          ];

          whenListen(signInBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.text('This password is invalid'), findsOneWidget);
        });

        testWidgets('disabled sign up button when status is not validated',
            (tester) async {
          when(() => signInBloc.state).thenReturn(
            const SignInState(status: FormzStatus.invalid),
          );

          final expectedStates = [
            const SignInState(status: FormzStatus.invalid),
          ];

          whenListen(signInBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
            ),
          );

          final signInButton = tester.widget<AppButton>(
            find.byKey(signInButtonKey),
          );
          expect(signInButton.onPressed, isNull);
        });

        testWidgets('enabled sign up button when status is validated',
            (tester) async {
          when(() => signInBloc.state).thenReturn(
            const SignInState(status: FormzStatus.valid),
          );

          final expectedStates = [
            const SignInState(status: FormzStatus.valid),
          ];

          whenListen(signInBloc, Stream.fromIterable(expectedStates));

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
            ),
          );

          final signInButton = tester.widget<AppButton>(
            find.byKey(signInButtonKey),
          );
          expect(signInButton.onPressed, isNotNull);
        });
      });
      group('navigates', () {
        testWidgets('back to previous page when submission status is success',
            (tester) async {
          whenListen(
            signInBloc,
            Stream.fromIterable(const <SignInState>[
              SignInState(status: FormzStatus.submissionInProgress),
              SignInState(status: FormzStatus.submissionSuccess),
            ]),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: signInBloc,
              child: const SignInView(),
            ),
          );

          expect(find.byType(SignInView), findsOneWidget);
          await tester.pumpAndSettle();
          expect(find.byType(SignInView), findsNothing);
        });
      });
    });
  });
}
