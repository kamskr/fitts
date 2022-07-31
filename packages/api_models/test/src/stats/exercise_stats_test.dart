import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExerciseStats', () {
    const exerciseStats = ExerciseStats(
      hightestWeight: 130,
      repetitionsDone: 10,
      timesPerformed: 50,
      overallBest: OverallBest(
        repetitions: 10,
        weight: 130,
      ),
    );

    test('can be instantiated.', () {
      const exerciseStats2 = ExerciseStats(
        hightestWeight: 130,
        repetitionsDone: 10,
        timesPerformed: 50,
        overallBest: OverallBest(
          repetitions: 10,
          weight: 130,
        ),
      );
      expect(exerciseStats2, isNotNull);
    });

    test('supports value equality.', () {
      const exerciseStats2 = ExerciseStats(
        hightestWeight: 130,
        repetitionsDone: 10,
        timesPerformed: 50,
        overallBest: OverallBest(
          repetitions: 10,
          weight: 130,
        ),
      );

      expect(exerciseStats, equals(exerciseStats2));
    });

    test('has correct props', () {
      expect(
        exerciseStats.props,
        equals([
          exerciseStats.hightestWeight,
          exerciseStats.repetitionsDone,
          exerciseStats.timesPerformed,
          exerciseStats.overallBest,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final copy = exerciseStats.copyWith(
        hightestWeight: 120,
        repetitionsDone: 11,
        timesPerformed: 55,
        overallBest: const OverallBest(
          repetitions: 11,
          weight: 120,
        ),
      );

      const exerciseStats2 = ExerciseStats(
        hightestWeight: 120,
        repetitionsDone: 11,
        timesPerformed: 55,
        overallBest: OverallBest(
          repetitions: 11,
          weight: 120,
        ),
      );

      expect(copy, equals(exerciseStats2));
    });
  });
}
