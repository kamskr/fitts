import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OverallBest', () {
    const overallBest = OverallBest(
      repetitions: 10,
      weight: 130,
    );
    test('can be instantiated.', () {
      const overallBest2 = OverallBest(
        repetitions: 10,
        weight: 130,
      );
      expect(overallBest2, isNotNull);
    });

    test('supports value equality.', () {
      const overallBest2 = OverallBest(
        repetitions: 10,
        weight: 130,
      );

      expect(overallBest, equals(overallBest2));
    });

    test('has correct props', () {
      expect(
        overallBest.props,
        equals([
          overallBest.weight,
          overallBest.repetitions,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final copy = overallBest.copyWith(
        repetitions: 11,
        weight: 135,
      );

      const overallBest2 = OverallBest(
        repetitions: 11,
        weight: 135,
      );

      expect(copy, equals(overallBest2));
      expect(copy, equals(copy.copyWith()));
    });
  });
}
