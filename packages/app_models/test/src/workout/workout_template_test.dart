import 'package:app_models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkoutTemplate', () {
    test('can be instantiated.', () {
      const workoutTemplate = WorkoutTemplate(
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        exercises: [
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
      const workoutTemplate1 = WorkoutTemplate(
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        exercises: [
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
      const workoutTemplate2 = WorkoutTemplate(
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        exercises: [
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
      const workoutTemplate = WorkoutTemplate(
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        exercises: [
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
      ]);
    });

    test('can be copyWith with changed properties', () {
      const workoutTemplate = WorkoutTemplate(
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        exercises: [
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
      const newWorkoutTemplate = WorkoutTemplate(
        name: 'new-name',
        notes: 'new-notes',
        tonnageLifted: 2,
        workoutsCompleted: 2,
        averageWorkoutLength: 2,
        lastAverageRestTime: 2,
        exercises: [
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
      const workoutTemplate = WorkoutTemplate(
        name: 'name',
        notes: 'notes',
        tonnageLifted: 1,
        workoutsCompleted: 1,
        averageWorkoutLength: 1,
        lastAverageRestTime: 1,
        exercises: [
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
