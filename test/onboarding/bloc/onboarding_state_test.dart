import 'package:fitts/onboarding/onboarding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingState', () {
    test('support value comparisons', () {
      expect(const OnboardingState(), const OnboardingState());
    });

    test('return some object when no properties are passed', () {
      expect(const OnboardingState().copyWith(), const OnboardingState());
    });
    test('returns object with updated status when status is passed', () {
      expect(
          const OnboardingState().copyWith(
            currentStep: 3,
          ),
          const OnboardingState(
            currentStep: 3,
          ));
    });
  });
}
