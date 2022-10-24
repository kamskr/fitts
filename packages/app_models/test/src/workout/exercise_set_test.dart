import 'package:app_models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExerciseSet', () {
    test('can be instantiated.', () {
      const exerciseSet = ExerciseSet(
        weight: 100,
        repetitions: 10,
      );
      expect(exerciseSet, isNotNull);
    });

    test('supports value equality.', () {
      const exerciseSet1 = ExerciseSet(
        weight: 100,
        repetitions: 10,
      );
      const exerciseSet2 = ExerciseSet(
        weight: 100,
        repetitions: 10,
      );
      expect(exerciseSet1, exerciseSet2);
    });

    test('has correct props', () {
      const exerciseSet = ExerciseSet(
        repetitions: 10,
        weight: 100,
      );
      expect(exerciseSet.props, [10, 100, null]);
    });

    test('can be copyWith with changed properties', () {
      const exerciseSet = ExerciseSet(
        weight: 100,
        repetitions: 10,
      );
      const exerciseSet2 = ExerciseSet(
        weight: 200,
        repetitions: 20,
      );
      expect(exerciseSet.copyWith(weight: 200, repetitions: 20), exerciseSet2);
    });

    test('can be created from json', () {
      const exerciseSet = ExerciseSet(
        weight: 100,
        repetitions: 10,
      );
      final exerciseSet2 = ExerciseSet.fromJson(exerciseSet.toJson());
      expect(exerciseSet, exerciseSet2);
    });
  });
}
