import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Exercise', () {
    test('can be instantiated', () {
      const exercise = Exercise(
        name: 'name',
        primaryMuscles: [],
        secondaryMuscles: [],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: [],
      );
      expect(exercise, isNotNull);
    });
    test('supports value equality.', () {
      const exercise = Exercise(
        name: 'name',
        primaryMuscles: [],
        secondaryMuscles: [],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: [],
      );
      const exercise2 = Exercise(
        name: 'name',
        primaryMuscles: [],
        secondaryMuscles: [],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: [],
      );
      expect(exercise, equals(exercise2));
    });
    test('has correct props.', () {
      const exercise = Exercise(
        name: 'name',
        primaryMuscles: [],
        secondaryMuscles: [],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: [],
      );
      expect(
        exercise.props,
        equals([
          exercise.name,
          exercise.primaryMuscles,
          exercise.secondaryMuscles,
          exercise.level,
          exercise.category,
          exercise.instructions,
          exercise.tips,
          exercise.force,
          exercise.mechanicType,
          exercise.equipment,
          exercise.description,
          exercise.aliases,
        ]),
      );
    });
    test('can copyWith with changed properties.', () {
      const exercise = Exercise(
        name: 'name',
        primaryMuscles: [],
        secondaryMuscles: [],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: [],
      );
      final copy = exercise.copyWith(
        name: 'name2',
        primaryMuscles: [],
        secondaryMuscles: [],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: ['test'],
      );
      expect(copy, isNot(equals(exercise)));
      expect(copy.name, equals('name2'));
    });
    test('can be created from json.', () {
      const exerciseJson = {
        'name': 'name',
        'primaryMuscles': ['abdominals'],
        'secondaryMuscles': ['abdominals'],
        'level': 'beginner',
        'category': 'strength',
        'instructions': ['test'],
      };

      expect(
        Exercise.fromJson(exerciseJson),
        const Exercise(
          name: 'name',
          primaryMuscles: [Muscle.abdominals],
          secondaryMuscles: [Muscle.abdominals],
          level: Level.beginner,
          category: ExerciseCategory.strength,
          instructions: [],
        ),
      );
    });

    test('can be converted to json.', () {
      const exercise = Exercise(
        name: 'name',
        primaryMuscles: [Muscle.abdominals],
        secondaryMuscles: [Muscle.abdominals],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: ['test'],
      );

      const exerciseJson = {
        'name': 'name',
        'primaryMuscles': ['abdominals'],
        'secondaryMuscles': ['abdominals'],
        'level': 'beginner',
        'category': 'strength',
        'instructions': ['test'],
      };

      expect(exercise.toJson(), equals(exerciseJson));
    });
  });
}
