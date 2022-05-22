import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockOnboardingBloc extends Mock implements OnboardingBloc {}

void main() {
  group('OnboardingPage', () {
    group('page', () {
      testWidgets('is routable.', (tester) async {
        expect(OnboardingPage.route(), isA<MaterialPageRoute>());
      });

      testWidgets('renders properly.', (tester) async {
        await tester.pumpApp(const OnboardingPage());

        expect(find.byType(OnboardingPage), findsOneWidget);
      });
    });
    group('onboarding form', () {
      late OnboardingBloc onboardingBloc;

      setUp(() {
        onboardingBloc = MockOnboardingBloc();
        when(() => onboardingBloc.state).thenReturn(const OnboardingState());
      });

      testWidgets('changes pages properly', (tester) async {
        final expectedStates = [
          const OnboardingState(),
        ];

        whenListen(onboardingBloc, Stream.fromIterable(expectedStates));

        await tester.pumpApp(
          BlocProvider.value(
            value: onboardingBloc,
            child: const OnboardingPageView(),
          ),
        );

        await tester.pumpAndSettle();

        final continueButton =
            find.byKey(const Key('onboarding_continue_button'));

        expect(continueButton, findsOneWidget);

        await tester.tap(continueButton);

        verify(
          () => onboardingBloc.add(const StepChanged(2)),
        ).called(1);
      });
    });
  });
}
