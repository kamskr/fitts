import 'package:app_models/app_models.dart';
import 'package:fitts/onboarding/onboarding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingEventTest', () {
    final dateTimeNow = DateTime.now();

    group('ProfileSubmitted', () {
      test('supports value comparisons', () {
        expect(
          const ProfileSubmitted(),
          equals(const ProfileSubmitted()),
        );
      });

      test('props are correct', () {
        expect(
          const ProfileSubmitted().props,
          equals(<Object?>[]),
        );
      });
    });
    group('StepChanged', () {
      test('supports value comparisons', () {
        expect(
          const StepChanged(1),
          equals(const StepChanged(1)),
        );
      });

      test('props are correct', () {
        expect(
          const StepChanged(1).props,
          equals(<Object?>[1]),
        );
      });
    });
    group('GenderChanged', () {
      test('supports value comparisons', () {
        expect(
          const GenderChanged(Gender.male),
          equals(const GenderChanged(Gender.male)),
        );
      });

      test('props are correct', () {
        expect(
          const GenderChanged(Gender.male).props,
          equals(<Object?>[Gender.male]),
        );
      });
    });
    group('DateOfBirthChanged', () {
      test('supports value comparisons', () {
        expect(
          DateOfBirthChanged(dateTimeNow),
          equals(DateOfBirthChanged(dateTimeNow)),
        );
      });

      test('props are correct', () {
        expect(
          DateOfBirthChanged(dateTimeNow).props,
          equals(<Object?>[dateTimeNow]),
        );
      });
    });
    group('WeightChanged', () {
      test('supports value comparisons', () {
        expect(
          const WeightChanged(60),
          equals(const WeightChanged(60)),
        );
      });

      test('props are correct', () {
        expect(
          const WeightChanged(60).props,
          equals(<Object?>[60]),
        );
      });
    });
    group('HeightChanged', () {
      test('supports value comparisons', () {
        expect(
          const HeightChanged(170),
          equals(const HeightChanged(170)),
        );
      });

      test('props are correct', () {
        expect(
          const HeightChanged(170).props,
          equals(<Object?>[170]),
        );
      });
    });
  });
}
