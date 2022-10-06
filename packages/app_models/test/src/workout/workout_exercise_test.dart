import 'package:app_models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkoutExercise', () {
    test('can be instantiated.', () {
      const workoutExercise = WorkoutExercise(
        exerciseId: 'bench-press',
        notes: 'notes',
        sets: [
          ExerciseSet(
            weight: 100,
            repetitions: 10,
          ),
        ],
        restTime: 100,
      );
      expect(workoutExercise, isNotNull);
    });

    test('supports value equality.', () {
      const workoutExercise1 = WorkoutExercise(
        exerciseId: 'bench-press',
        notes: 'notes',
        sets: [
          ExerciseSet(
            weight: 100,
            repetitions: 10,
          ),
        ],
        restTime: 100,
      );
      const workoutExercise2 = WorkoutExercise(
        exerciseId: 'bench-press',
        notes: 'notes',
        sets: [
          ExerciseSet(
            weight: 100,
            repetitions: 10,
          ),
        ],
        restTime: 100,
      );
      expect(workoutExercise1, workoutExercise2);
    });

    test('has correct props', () {
      const workoutExercise = WorkoutExercise(
        exerciseId: 'bench-press',
        notes: 'notes',
        sets: [
          ExerciseSet(
            weight: 100,
            repetitions: 10,
          ),
        ],
        restTime: 100,
      );
      expect(workoutExercise.props, [
        'bench-press',
        'notes',
        [
          const ExerciseSet(
            weight: 100,
            repetitions: 10,
          ),
        ],
        100,
      ]);
    });

    test('can be copyWith with changed properties', () {
      const workoutExercise = WorkoutExercise(
        exerciseId: 'bench-press',
        notes: 'notes',
        sets: [
          ExerciseSet(
            weight: 100,
            repetitions: 10,
          ),
        ],
        restTime: 100,
      );
      const workoutExercise2 = WorkoutExercise(
        exerciseId: 'bench-press',
        notes: 'notes',
        sets: [
          ExerciseSet(
            weight: 200,
            repetitions: 20,
          ),
        ],
        restTime: 200,
      );
      expect(
        workoutExercise.copyWith(
          sets: [
            const ExerciseSet(
              weight: 200,
              repetitions: 20,
            ),
          ],
          restTime: 200,
        ),
        workoutExercise2,
      );
    });
    test('can be created from json', () {
      const workoutExercise = WorkoutExercise(
        exerciseId: 'bench-press',
        notes: 'notes',
        sets: [
          ExerciseSet(
            weight: 100,
            repetitions: 10,
          ),
        ],
        restTime: 100,
      );
      final workoutExercise2 =
          WorkoutExercise.fromJson(workoutExercise.toJson());
      expect(workoutExercise, workoutExercise2);
    });
  });
}
