import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/authentication/authentication.dart';

import '../../helpers/pump_app.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class AuthenticationRepository {}

class MockWelcomeCubit extends MockCubit<WelcomeState> implements WelcomeCubit {
}

class FakeWelcomeState extends Fake implements WelcomeState {}

void main() {
  group('WelcomePage', () {
    late WelcomeCubit welcomeCubit;

    setUpAll(() {
      registerFallbackValue(FakeWelcomeState());
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
      expect(WelcomePage.page(), isA<MaterialPage>());
    });

    testWidgets('renders properly.', (tester) async {
      await tester.pumpApp(
        RepositoryProvider(
          create: (context) => AuthenticationClient(),
          child: const WelcomePage(),
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

    testWidgets(
        'initiates signInWithGoogle action on signInWithGoogle button pressed.',
        (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: welcomeCubit,
          child: const WelcomeView(),
        ),
      );

      final signInWithGoogleButton =
          find.byKey(const Key('welcomePage_signInWithGoogle'));

      expect(signInWithGoogleButton, findsOneWidget);
      await tester.tap(signInWithGoogleButton);
      await tester.pumpAndSettle();

      verify(welcomeCubit.signInWithGoogle).called(1);
    });
  });
}
