import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Exercise', () {
    test('can be instantiated', () {
      const exercise = Exercise(
        id: 'id',
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
        id: 'id',
        name: 'name',
        primaryMuscles: [],
        secondaryMuscles: [],
        level: Level.beginner,
        category: ExerciseCategory.strength,
        instructions: [],
      );
      const exercise2 = Exercise(
        id: 'id',
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
        id: 'id',
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
          exercise.aliases,
          exercise.primaryMuscles,
          exercise.secondaryMuscles,
          exercise.force,
          exercise.level,
          exercise.mechanicType,
          exercise.equipment,
          exercise.category,
          exercise.instructions,
          exercise.description,
          exercise.tips,
        ]),
      );
    });
    test('can copyWith with changed properties.', () {
      const exercise = Exercise(
        id: 'id',
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
    test('can be created from json and ignores null.', () {
      const exerciseJson = {
        'id': 'id',
        'name': 'name',
        'primaryMuscles': ['abdominals'],
        'secondaryMuscles': ['abdominals'],
        'level': 'beginner',
        'category': 'strength',
        'instructions': ['test'],
        'equipment': null,
      };

      expect(
        Exercise.fromJson(exerciseJson),
        const Exercise(
          id: 'id',
          name: 'name',
          primaryMuscles: [Muscle.abdominals],
          secondaryMuscles: [Muscle.abdominals],
          level: Level.beginner,
          category: ExerciseCategory.strength,
          instructions: ['test'],
        ),
      );
    });

    test('can be converted to json.', () {
      const exercise = Exercise(
        id: 'id',
        name: 'name',
        aliases: ['name2'],
        primaryMuscles: [Muscle.abdominals],
        secondaryMuscles: [Muscle.abdominals],
        force: Force.pull,
        level: Level.beginner,
        mechanicType: MechanicType.isolation,
        equipment: Equipment.barbell,
        category: ExerciseCategory.strength,
        instructions: ['test'],
        description: 'description',
        tips: ['tip'],
      );

      const exerciseJson = {
        'name': 'name',
        'aliases': ['name2'],
        'primaryMuscles': ['abdominals'],
        'secondaryMuscles': ['abdominals'],
        'force': 'pull',
        'level': 'beginner',
        'mechanic': 'isolation',
        'equipment': 'barbell',
        'category': 'strength',
        'instructions': ['test'],
        'description': 'description',
        'tips': ['tip'],
      };

      expect(exercise.toJson(), equals(exerciseJson));
    });
  });
}
