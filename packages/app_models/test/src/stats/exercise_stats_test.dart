import 'package:app_models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExerciseStats', () {
    const exerciseStats = ExerciseStats(
      highestWeight: 130,
      repetitionsDone: 10,
      timesPerformed: 50,
      overallBest: OverallBest(
        repetitions: 10,
        weight: 130,
      ),
    );

    test('can be instantiated.', () {
      const exerciseStats2 = ExerciseStats(
        highestWeight: 130,
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
        highestWeight: 130,
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
          exerciseStats.highestWeight,
          exerciseStats.repetitionsDone,
          exerciseStats.timesPerformed,
          exerciseStats.overallBest,
          null,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final copy = exerciseStats.copyWith(
        highestWeight: 120,
        repetitionsDone: 11,
        timesPerformed: 55,
        overallBest: const OverallBest(
          repetitions: 11,
          weight: 120,
        ),
      );

      const exerciseStats2 = ExerciseStats(
        highestWeight: 120,
        repetitionsDone: 11,
        timesPerformed: 55,
        overallBest: OverallBest(
          repetitions: 11,
          weight: 120,
        ),
      );

      expect(copy, equals(exerciseStats2));
      expect(copy, equals(copy.copyWith()));
    });
  });
}
