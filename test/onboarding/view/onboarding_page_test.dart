import 'package:api_models/api_models.dart';
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
        expect(OnboardingPage.route(), isA<MaterialPageRoute<void>>());
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
        when(() => onboardingBloc.state)
            .thenAnswer((_) => const OnboardingState(currentStep: 2));

        final expectedStates = [
          const OnboardingState(currentStep: 2),
          const OnboardingState(currentStep: 3),
          const OnboardingState(currentStep: 2),
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
          () => onboardingBloc.add(const StepChanged(3)),
        ).called(1);

        await tester.pumpAndSettle();

        final backButton = find.byKey(const Key('flowButtonsBackButton'));
        expect(backButton, findsOneWidget);

        await tester.tap(backButton);

        verify(
          () => onboardingBloc.add(const StepChanged(1)),
        ).called(1);
      });
      testWidgets('displays submit button on last step', (tester) async {
        when(() => onboardingBloc.state).thenAnswer(
          (_) => const OnboardingState(
            currentStep: OnboardingState.totalSteps,
          ),
        );

        final expectedStates = [
          const OnboardingState(currentStep: OnboardingState.totalSteps),
        ];

        whenListen(onboardingBloc, Stream.fromIterable(expectedStates));

        await tester.pumpApp(
          BlocProvider.value(
            value: onboardingBloc,
            child: const OnboardingPageView(),
          ),
        );

        await tester.pumpAndSettle();

        final submitButton = find.byKey(const Key('onboarding_finish_button'));

        expect(submitButton, findsOneWidget);

        await tester.tap(submitButton);

        verify(
          () => onboardingBloc.add(const ProfileSubmitted()),
        ).called(1);
      });

      group('gender picker', () {
        testWidgets('renders on correct page', (tester) async {
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

          final genderPicker = find.byType(GenderPicker);

          expect(genderPicker, findsOneWidget);
        });
        testWidgets('selects correct weight', (tester) async {
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

          final malePicker = find.byKey(const Key('gender_picker_male'));

          await tester.tap(malePicker);

          verify(
            () => onboardingBloc.add(const GenderChanged(Gender.male)),
          ).called(1);

          final femalePicker = find.byKey(const Key('gender_picker_female'));

          await tester.tap(femalePicker);

          verify(
            () => onboardingBloc.add(const GenderChanged(Gender.female)),
          ).called(1);
        });
      });
    });
  });
}
