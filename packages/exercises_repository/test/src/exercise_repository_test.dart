import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:exercises_repository/src/exceptions.dart';
import 'package:exercises_repository/src/exercise_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockExerciseResource extends Mock implements ExerciseResource {}

void main() {
  const exercise = Exercise(
    id: 'id',
    name: 'name',
    description: 'description',
    primaryMuscles: [Muscle.abdominals],
    secondaryMuscles: [Muscle.abdominals],
    level: Level.beginner,
    category: ExerciseCategory.cardio,
    instructions: ['instructions'],
  );

  group('ExerciseRepository', () {
    late ApiClient apiClient;
    late ExerciseResource resource;

    setUp(() {
      apiClient = MockApiClient();
      resource = MockExerciseResource();

      when(() => apiClient.exerciseResource).thenReturn(resource);
    });

    group('getExercises', () {
      test('returns a map of exercises from API if cache is empty', () async {
        final repository = ExerciseRepository(apiClient: apiClient);

        final exercises = <String, Exercise>{
          'id': exercise,
        };

        when(() => resource.getAllExercises()).thenAnswer(
          (_) => Future.value(exercises),
        );

        expect(await repository.getExercises(), equals(exercises));
      });

      test('returns a list of exercises from cache first', () async {
        final repository = ExerciseRepository(apiClient: apiClient);

        final exercises = <String, Exercise>{
          'id': exercise,
        };

        when(() => resource.getAllExercises()).thenAnswer(
          (_) => Future.value(exercises),
        );

        expect(await repository.getExercises(), equals(exercises));

        await repository.getExercises();

        verify(() => resource.getAllExercises()).called(1);
      });
      test(
        'returns ExercisesFetchFailure if failed to fetch exercises',
        () async {
          final repository = ExerciseRepository(apiClient: apiClient);

          when(() => resource.getAllExercises()).thenThrow(Exception());

          expect(
            repository.getExercises(),
            throwsA(isA<ExercisesFetchFailure>()),
          );
        },
      );
    });
    group('getExercise', () {
      test('returns an exercise from API if cache is empty', () async {
        final repository = ExerciseRepository(apiClient: apiClient);

        when(() => resource.getExercise(any())).thenAnswer(
          (_) => Future.value(exercise),
        );

        expect(await repository.getExercise('id'), equals(exercise));
      });
      test('returns an exercise from cache first', () async {
        final repository = ExerciseRepository(apiClient: apiClient);

        when(() => resource.getExercise(any())).thenAnswer(
          (_) => Future.value(exercise),
        );

        expect(await repository.getExercise('id'), equals(exercise));
        await repository.getExercise('id');

        verify(() => resource.getExercise('id')).called(1);
      });

      test(
        'returns ExercisesFetchFailure if failed to fetch exercise',
        () async {
          final repository = ExerciseRepository(apiClient: apiClient);

          when(() => resource.getExercise(any())).thenThrow(Exception());

          expect(
            repository.getExercise('id'),
            throwsA(isA<ExercisesFetchFailure>()),
          );
        },
      );
    });
  });
}
