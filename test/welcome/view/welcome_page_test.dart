import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitts/sign_in/sign_in.dart';
import 'package:fitts/sign_up/sign_up.dart';
import 'package:fitts/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class AuthenticationRepository {}

class MockWelcomeCubit extends MockCubit<WelcomeState> implements WelcomeCubit {
}

class FakeWelcomeState extends Fake implements WelcomeState {}

void main() {
  setupFirebaseAuthMocks();

  group('WelcomePage', () {
    late WelcomeCubit welcomeCubit;

    setUpAll(() async {
      registerFallbackValue(FakeWelcomeState());
      await Firebase.initializeApp();
    });

    setUp(() {
      welcomeCubit = MockWelcomeCubit();

      when(() => welcomeCubit.signInWithGoogle()).thenAnswer(
        (invocation) async => const WelcomeState(
          status: FormzStatus.submissionSuccess,
        ),
      );
    });

    testWidgets('is routable.', (tester) async {
      expect(WelcomePage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders properly.', (tester) async {
      await tester.pumpApp(
        RepositoryProvider(
          create: (context) => AuthenticationClient(),
          child: BlocProvider.value(
            value: welcomeCubit,
            child: const WelcomePage(),
          ),
        ),
      );

      expect(find.byType(WelcomePage), findsOneWidget);
    });

    testWidgets('redirects to SignUpPage on SignUp button pressed.',
        (tester) async {
      await tester.pumpApp(
        const WelcomePage(),
      );

      final signUpButton = find.byKey(const Key('welcomePage_signUpButton'));

      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      /// Ensure SignInPage presence.
      expect(find.byType(SignUpPage), findsOneWidget);
    });

    testWidgets('redirects to SignInPage on SignIn button pressed.',
        (tester) async {
      await tester.pumpApp(
        const WelcomePage(),
      );

      final signInButton = find.byKey(const Key('welcomePage_signInButton'));

      expect(signInButton, findsOneWidget);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      /// Ensure SignInPage presence.
      expect(find.byType(SignInPage), findsOneWidget);
    });
  });
}
