import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserStats', () {
    const overallBest = OverallBest(
      repetitions: 10,
      weight: 130,
    );

    const exerciseStats = ExerciseStats(
      highestWeight: 130,
      repetitionsDone: 10,
      timesPerformed: 50,
      overallBest: overallBest,
    );

    const globalStats = GlobalStats(
      keyLifts: ['bench', 'squat'],
      liftingTimeSpent: 100,
      totalKgLifted: 200,
      workoutsCompleted: 20,
    );

    const userStats = UserStats(
      exercisesStats: {'bench_press': exerciseStats},
      globalStats: globalStats,
    );

    test('can be instantiated.', () {
      const userStats2 = GlobalStats(
        keyLifts: ['bench', 'squat'],
        liftingTimeSpent: 100,
        totalKgLifted: 200,
        workoutsCompleted: 20,
      );
      expect(userStats2, isNotNull);
    });

    test('supports value equality.', () {
      const userStats2 = UserStats(
        exercisesStats: {'bench_press': exerciseStats},
        globalStats: globalStats,
      );

      expect(userStats, equals(userStats2));
    });

    test('has correct props', () {
      expect(
        userStats.props,
        equals([
          userStats.exercisesStats,
          userStats.globalStats,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final copy = userStats.copyWith(
        exercisesStats: {},
        globalStats: globalStats,
      );

      const userStats2 = UserStats(
        exercisesStats: {},
        globalStats: globalStats,
      );

      expect(copy, equals(userStats2));
      expect(copy, equals(copy.copyWith()));
    });
    test('can be created from json', () {
      const json = {
        'exercises': {
          'bench_press': {
            'highestWeight': 130,
            'repetitionsDone': 10,
            'timesPerformed': 50,
            'overallBest': {
              'repetitions': 10,
              'weight': 130,
            },
          },
        },
        'global': {
          'keyLifts': ['bench', 'squat'],
          'liftingTimeSpent': 100,
          'totalKgLifted': 200,
          'workoutsCompleted': 20,
        },
      };
      final userStats = UserStats.fromJson(json);
      expect(userStats, isNotNull);
    });
    test('can be converted to json', () {
      const json = {
        'exercises': {
          'bench_press': {
            'highestWeight': 130,
            'repetitionsDone': 10,
            'timesPerformed': 50,
            'overallBest': {
              'repetitions': 10,
              'weight': 130,
            },
          },
        },
        'global': {
          'keyLifts': ['bench', 'squat'],
          'liftingTimeSpent': 100,
          'totalKgLifted': 200,
          'workoutsCompleted': 20,
        },
      };
      final userStats = UserStats.fromJson(json);
      expect(userStats.toJson(), equals(json));
    });
  });
}
