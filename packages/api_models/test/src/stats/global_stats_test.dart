import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GlobalStats', () {
    const globalStats = GlobalStats(
      keyLifts: ['bench', 'squat'],
      liftingTimeSpent: 100,
      totalKgLifted: 200,
      workoutsCompleted: 20,
    );

    test('can be instantiated.', () {
      const globalStats2 = GlobalStats(
        keyLifts: ['bench', 'squat'],
        liftingTimeSpent: 100,
        totalKgLifted: 200,
        workoutsCompleted: 20,
      );
      expect(globalStats2, isNotNull);
    });

    test('supports value equality.', () {
      const globalStats2 = GlobalStats(
        keyLifts: ['bench', 'squat'],
        liftingTimeSpent: 100,
        totalKgLifted: 200,
        workoutsCompleted: 20,
      );

      expect(globalStats, equals(globalStats2));
    });

    test('has correct props', () {
      expect(
        globalStats.props,
        equals([
          globalStats.keyLifts,
          globalStats.liftingTimeSpent,
          globalStats.totalKgLifted,
          globalStats.workoutsCompleted,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final copy = globalStats.copyWith(
        keyLifts: ['pull ups', 'overhead press'],
        liftingTimeSpent: 150,
        totalKgLifted: 250,
        workoutsCompleted: 30,
      );

      const globalStats2 = GlobalStats(
        keyLifts: ['pull ups', 'overhead press'],
        liftingTimeSpent: 150,
        totalKgLifted: 250,
        workoutsCompleted: 30,
      );

      expect(copy, equals(globalStats2));
    });
  });
}
