import 'package:app_models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkoutLog', () {
    test('can be instantiated.', () {
      final workoutLog = WorkoutLog(
        id: 'id',
        duration: 3600,
        datePerformed: DateTime(2020),
        workoutTemplateId: 'template-id',
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
      expect(workoutLog, isNotNull);
    });

    test('supports value equality.', () {
      final workoutLog1 = WorkoutLog(
        id: 'id',
        duration: 3600,
        datePerformed: DateTime(2020),
        workoutTemplateId: 'template-id',
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
      final workoutLog2 = WorkoutLog(
        id: 'id',
        duration: 3600,
        datePerformed: DateTime(2020),
        workoutTemplateId: 'template-id',
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
      expect(workoutLog1, workoutLog2);
    });

    test('has correct props', () {
      final workoutLog = WorkoutLog(
        id: 'id',
        duration: 3600,
        datePerformed: DateTime(2020),
        workoutTemplateId: 'template-id',
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
      expect(workoutLog.props, [
        3600,
        DateTime(2020),
        'template-id',
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
      final workoutLog = WorkoutLog(
        id: 'id',
        duration: 3600,
        datePerformed: DateTime(2020),
        workoutTemplateId: 'template-id',
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
      final copy = workoutLog.copyWith(
        id: 'id2',
        duration: 7200,
        datePerformed: DateTime(2021),
        workoutTemplateId: 'template-id2',
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
      expect(copy, isNot(workoutLog));

      expect(copy.duration, 7200);
      expect(copy.datePerformed, DateTime(2021));
      expect(copy.workoutTemplateId, 'template-id2');
      expect(copy.exercises, const [
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
      ]);
    });
    test('can be created from json', () {
      final workoutLog = WorkoutLog.fromJson({
        'id': 'id',
        'duration': 3600,
        'datePerformed': DateTime(2020).toIso8601String(),
        'workoutTemplateId': 'template-id',
        'exercises': const [
          {
            'exerciseId': 'bench-press',
            'notes': 'notes',
            'sets': [
              {
                'weight': 100,
                'repetitions': 10,
              },
            ],
            'restTime': 100,
          },
        ],
      });
      expect(workoutLog, isNotNull);

      expect(workoutLog.duration, 3600);
      expect(workoutLog.datePerformed, DateTime(2020));
      expect(workoutLog.workoutTemplateId, 'template-id');
      expect(workoutLog.exercises, const [
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
      ]);
    });
  });
}
