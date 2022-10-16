import 'package:app_models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkoutTemplate', () {
    test('can be instantiated.', () {
      final workoutTemplate = WorkoutTemplate(
        id: 'id',
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        lastPerformed: DateTime(2020),
        recentTotalTonnageLifted: const [1],
        exercises: const [
          WorkoutExercise(
            exerciseId: 'bench-press',
            notes: 'notes',
            sets: [
              ExerciseSet(
                weight: 100,
                repetitions: 10,
              ),
            ],
            restTime: 100,
          ),
        ],
      );
      expect(workoutTemplate, isNotNull);
    });

    test('supports value equality.', () {
      final workoutTemplate1 = WorkoutTemplate(
        id: 'id',
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        lastPerformed: DateTime(2020),
        recentTotalTonnageLifted: const [1],
        exercises: const [
          WorkoutExercise(
            exerciseId: 'bench-press',
            notes: 'notes',
            sets: [
              ExerciseSet(
                weight: 100,
                repetitions: 10,
              ),
            ],
            restTime: 100,
          ),
        ],
      );
      final workoutTemplate2 = WorkoutTemplate(
        id: 'id',
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        lastPerformed: DateTime(2020),
        recentTotalTonnageLifted: const [1],
        exercises: const [
          WorkoutExercise(
            exerciseId: 'bench-press',
            notes: 'notes',
            sets: [
              ExerciseSet(
                weight: 100,
                repetitions: 10,
              ),
            ],
            restTime: 100,
          ),
        ],
      );
      expect(workoutTemplate1, workoutTemplate2);
    });

    test('has correct props', () {
      final workoutTemplate = WorkoutTemplate(
        id: 'id',
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        lastPerformed: DateTime(2020),
        recentTotalTonnageLifted: const [1],
        exercises: const [
          WorkoutExercise(
            exerciseId: 'bench-press',
            notes: 'notes',
            sets: [
              ExerciseSet(
                weight: 100,
                repetitions: 10,
              ),
            ],
            restTime: 100,
          ),
        ],
      );
      expect(workoutTemplate.props, [
        'id',
        'name',
        'notes',
        1,
        1,
        1,
        1,
        [
          const WorkoutExercise(
            exerciseId: 'bench-press',
            notes: 'notes',
            sets: [
              ExerciseSet(
                weight: 100,
                repetitions: 10,
              ),
            ],
            restTime: 100,
          ),
        ],
        DateTime(2020),
        const [1]
      ]);
    });

    test('can be copyWith with changed properties', () {
      final workoutTemplate = WorkoutTemplate(
        id: 'id',
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        lastPerformed: DateTime(2020),
        recentTotalTonnageLifted: const [1],
        exercises: const [
          WorkoutExercise(
            exerciseId: 'bench-press',
            notes: 'notes',
            sets: [
              ExerciseSet(
                weight: 100,
                repetitions: 10,
              ),
            ],
            restTime: 100,
          ),
        ],
      );
      final newWorkoutTemplate = WorkoutTemplate(
        id: 'id',
        name: 'new-name',
        notes: 'new-notes',
        tonnageLifted: 2,
        workoutsCompleted: 2,
        averageWorkoutLength: 2,
        lastAverageRestTime: 2,
        lastPerformed: DateTime(2020),
        recentTotalTonnageLifted: const [1],
        exercises: const [
          WorkoutExercise(
            exerciseId: 'new-bench-press',
            notes: 'new-notes',
            sets: [
              ExerciseSet(
                weight: 200,
                repetitions: 20,
              ),
            ],
            restTime: 200,
          ),
        ],
      );
      expect(
        workoutTemplate.copyWith(
          name: 'new-name',
          notes: 'new-notes',
          tonnageLifted: 2,
          workoutsCompleted: 2,
          averageWorkoutLength: 2,
          lastAverageRestTime: 2,
          lastPerformed: DateTime(2020),
          recentTotalTonnageLifted: const [1],
          exercises: [
            const WorkoutExercise(
              exerciseId: 'new-bench-press',
              notes: 'new-notes',
              sets: [
                ExerciseSet(
                  weight: 200,
                  repetitions: 20,
                ),
              ],
              restTime: 200,
            ),
          ],
        ),
        newWorkoutTemplate,
      );
    });
    test('can be created from json', () {
      final workoutTemplate = WorkoutTemplate(
        id: 'id',
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        lastPerformed: DateTime(2020),
        recentTotalTonnageLifted: const [1],
        exercises: const [
          WorkoutExercise(
            exerciseId: 'bench-press',
            notes: 'notes',
            sets: [
              ExerciseSet(
                weight: 100,
                repetitions: 10,
              ),
            ],
            restTime: 100,
          ),
        ],
      );
      expect(
        WorkoutTemplate.fromJson(workoutTemplate.toJson()),
        workoutTemplate,
      );
    });
  });
}
