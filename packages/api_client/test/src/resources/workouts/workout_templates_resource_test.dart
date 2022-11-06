// ignore_for_file: subtype_of_sealed_class
import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockUserTemplatesCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

void main() {
  group('WorkoutTemplatesResource', () {
    late FirebaseFirestore firebaseFirestore;
    late WorkoutTemplatesResource workoutTemplatesResource;
    late CollectionReference<Map<String, dynamic>> collectionReference;
    late CollectionReference<Map<String, dynamic>>
        userTemplatesCollectionReference;
    late DocumentReference<Map<String, dynamic>> documentReference;
    late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
    late QuerySnapshot<Map<String, dynamic>> querySnapshot;
    late QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot;

    const collectionName = 'WorkoutTemplates';
    const userTemplatesCollectionName = 'UserTemplates';

    const userId = 'userId';
    const templateId = 'templateId';

    final workoutTemplateData = {
      'id': templateId,
      'name': 'Test Workout',
      'notes': 'notes',
      'tonnageLifted': 1,
      'workoutsCompleted': 1,
      'averageWorkoutLength': 1,
      'lastAverageRestTime': 1,
      'lastPerformed': DateTime(2020).toIso8601String(),
      'recentTotalTonnageLifted': [
        {
          'timePerformed': DateTime(2020).toIso8601String(),
          'weight': 1,
        }
      ],
      'exercises': [
        {
          'exerciseId': 'Squat',
          'notes': 'notes',
          'restTime': 1,
          'sets': [
            {'repetitions': 5, 'weight': 100},
            {'repetitions': 5, 'weight': 100},
            {'repetitions': 5, 'weight': 100},
          ],
        },
        {
          'exerciseId': 'Bench Press',
          'notes': 'notes',
          'restTime': 1,
          'sets': [
            {'repetitions': 5, 'weight': 100},
            {'repetitions': 5, 'weight': 100},
            {'repetitions': 5, 'weight': 100},
          ],
        },
      ],
    };

    setUp(() {
      firebaseFirestore = FirebaseFirestoreMock();
      workoutTemplatesResource = WorkoutTemplatesResource(firebaseFirestore);
      collectionReference = MockCollectionReference();
      userTemplatesCollectionReference = MockCollectionReference();
      documentReference = MockDocumentReference();
      documentSnapshot = MockDocumentSnapshot();
      querySnapshot = MockQuerySnapshot();
      queryDocumentSnapshot = MockQueryDocumentSnapshot();

      when(() => firebaseFirestore.collection(collectionName))
          .thenReturn(collectionReference);

      when(() => collectionReference.doc(userId)).thenReturn(documentReference);

      when(() => documentReference.collection(userTemplatesCollectionName))
          .thenReturn(userTemplatesCollectionReference);

      when(() => userTemplatesCollectionReference.doc(templateId))
          .thenReturn(documentReference);

      when(() => documentReference.snapshots())
          .thenAnswer((_) => Stream.value(documentSnapshot));

      when(() => documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data).thenReturn(workoutTemplateData);
      when(() => documentSnapshot.id).thenReturn(templateId);
      when(() => userTemplatesCollectionReference.add(any()))
          .thenAnswer((_) async => documentReference);
      when(() => documentReference.set(any())).thenAnswer((_) async {});
      when(() => documentReference.update(any())).thenAnswer((_) async {});
      when(() => documentReference.delete()).thenAnswer((_) async {});

      when(() => userTemplatesCollectionReference.snapshots())
          .thenAnswer((_) => Stream.value(querySnapshot));

      when(() => querySnapshot.docs).thenReturn([queryDocumentSnapshot]);

      when(() => queryDocumentSnapshot.data()).thenReturn(workoutTemplateData);

      when(() => queryDocumentSnapshot.id).thenReturn(templateId);
    });

    test('can be instantiated', () {
      expect(WorkoutTemplatesResource(firebaseFirestore), isNotNull);
    });
    group('getUserWorkoutTemplates', () {
      test('returns Stream<List<WorkoutTemplate>?> with correct data', () {
        final result = workoutTemplatesResource.getUserWorkoutTemplates(userId);

        expect(result, isA<Stream<List<WorkoutTemplate>?>>());

        result.listen((event) {
          expect(event, isA<List<WorkoutTemplate>>());
          expect(event!.length, 1);

          expect(event.first.name, workoutTemplateData['name']);
          expect(event.first.notes, workoutTemplateData['notes']);
          expect(
            event.first.tonnageLifted,
            workoutTemplateData['tonnageLifted'],
          );
          expect(
            event.first.workoutsCompleted,
            workoutTemplateData['workoutsCompleted'],
          );
          expect(
            event.first.averageWorkoutLength,
            workoutTemplateData['averageWorkoutLength'],
          );
          expect(
            event.first.lastAverageRestTime,
            workoutTemplateData['lastAverageRestTime'],
          );
          expect(event.first.exercises, isA<List<WorkoutExercise>>());
          expect(event.first.exercises.length, 2);

          expect(event.first.exercises.length, 2);
        });
      });

      test(
        'returns null if list of templates is empty.',
        () {
          when(() => querySnapshot.docs).thenReturn([]);

          final result =
              workoutTemplatesResource.getUserWorkoutTemplates(userId);

          expect(result, isA<Stream<List<WorkoutTemplate>?>>());

          result.listen((event) {
            expect(event, isNull);
          });
        },
      );
      test(
        'throws ApiException when failed to get data from Firestore',
        () {
          when(() => userTemplatesCollectionReference.snapshots())
              .thenThrow(Exception());

          expect(
            () => workoutTemplatesResource.getUserWorkoutTemplates(userId),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('getUserWorkoutTemplateById', () {
      test('returns Stream<WorkoutTemplate?> with correct data', () {
        final result = workoutTemplatesResource.getUserWorkoutTemplateById(
          userId: userId,
          workoutTemplateId: templateId,
        );

        expect(result, isA<Stream<WorkoutTemplate?>>());

        result.listen((event) {
          expect(event, isA<WorkoutTemplate>());

          expect(event!.name, workoutTemplateData['name']);
          expect(event.notes, workoutTemplateData['notes']);
          expect(event.tonnageLifted, workoutTemplateData['tonnageLifted']);
          expect(
            event.workoutsCompleted,
            workoutTemplateData['workoutsCompleted'],
          );
          expect(
            event.averageWorkoutLength,
            workoutTemplateData['averageWorkoutLength'],
          );
          expect(
            event.lastAverageRestTime,
            workoutTemplateData['lastAverageRestTime'],
          );
          expect(event.exercises, isA<List<WorkoutExercise>>());
          expect(event.exercises.length, 2);

          expect(event.exercises.length, 2);
        });
      });

      test(
        'throws ApiException when failed to get data from Firestore',
        () {
          when(() => documentReference.snapshots()).thenThrow(Exception());

          expect(
            () => workoutTemplatesResource.getUserWorkoutTemplateById(
              userId: userId,
              workoutTemplateId: templateId,
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('createUserWorkoutTemplate', () {
      test(
        'sends correct data to Firestore to create document',
        () {
          workoutTemplatesResource.createUserWorkoutTemplate(
            userId: userId,
            payload: WorkoutTemplate(
              id: templateId,
              name: 'name',
              notes: 'notes',
              tonnageLifted: 1,
              workoutsCompleted: 2,
              averageWorkoutLength: 3,
              lastAverageRestTime: 4,
              lastPerformed: DateTime(2020),
              recentTotalTonnageLifted: [
                RecentTonnage(timePerformed: DateTime(2020), weight: 1)
              ],
              exercises: const [
                WorkoutExercise(
                  exerciseId: 'exerciseId',
                  notes: 'notes',
                  restTime: 1,
                  sets: [
                    ExerciseSet(
                      repetitions: 1,
                      weight: 1,
                    ),
                  ],
                ),
              ],
            ),
          );

          verify(
            () => userTemplatesCollectionReference.doc(templateId).set(any()),
          ).called(1);
        },
      );
      test(
        'throws ApiException when failed to create document in Firestore',
        () {
          when(
            () => userTemplatesCollectionReference.doc(templateId).set(any()),
          ).thenThrow(Exception());

          expect(
            () => workoutTemplatesResource.createUserWorkoutTemplate(
              userId: userId,
              payload: WorkoutTemplate(
                id: templateId,
                name: 'name',
                notes: 'notes',
                tonnageLifted: 1,
                workoutsCompleted: 2,
                averageWorkoutLength: 3,
                lastAverageRestTime: 4,
                lastPerformed: DateTime(2020),
                recentTotalTonnageLifted: [
                  RecentTonnage(timePerformed: DateTime(2020), weight: 1)
                ],
                exercises: const [
                  WorkoutExercise(
                    exerciseId: 'exerciseId',
                    notes: 'notes',
                    restTime: 1,
                    sets: [
                      ExerciseSet(
                        repetitions: 1,
                        weight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('updateUserWorkoutTemplate', () {
      test(
        'sends correct data to Firestore to update document',
        () {
          workoutTemplatesResource.updateUserWorkoutTemplate(
            userId: userId,
            workoutTemplateId: templateId,
            payload: WorkoutTemplate(
              id: templateId,
              name: 'name',
              notes: 'notes',
              tonnageLifted: 1,
              workoutsCompleted: 2,
              averageWorkoutLength: 3,
              lastAverageRestTime: 4,
              lastPerformed: DateTime(2020),
              recentTotalTonnageLifted: [
                RecentTonnage(timePerformed: DateTime(2020), weight: 1)
              ],
              exercises: const [
                WorkoutExercise(
                  exerciseId: 'exerciseId',
                  notes: 'notes',
                  restTime: 1,
                  sets: [
                    ExerciseSet(
                      repetitions: 1,
                      weight: 1,
                    ),
                  ],
                ),
              ],
            ),
          );

          verify(
            () => documentReference.update(any()),
          ).called(1);
        },
      );
      test(
        'throws ApiException when failed to update document in Firestore',
        () {
          when(() => documentReference.update(any())).thenThrow(Exception());

          expect(
            () => workoutTemplatesResource.updateUserWorkoutTemplate(
              userId: userId,
              workoutTemplateId: templateId,
              payload: WorkoutTemplate(
                id: templateId,
                name: 'name',
                notes: 'notes',
                tonnageLifted: 1,
                workoutsCompleted: 2,
                averageWorkoutLength: 3,
                lastAverageRestTime: 4,
                lastPerformed: DateTime(2020),
                recentTotalTonnageLifted: [
                  RecentTonnage(timePerformed: DateTime(2020), weight: 1)
                ],
                exercises: const [
                  WorkoutExercise(
                    exerciseId: 'exerciseId',
                    notes: 'notes',
                    restTime: 1,
                    sets: [
                      ExerciseSet(
                        repetitions: 1,
                        weight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('deleteUserWorkoutTemplate', () {
      test(
        'sends correct data to Firestore to delete document',
        () {
          workoutTemplatesResource.deleteUserWorkoutTemplate(
            userId: userId,
            workoutTemplateId: templateId,
          );

          verify(
            () => documentReference.delete(),
          ).called(1);
        },
      );
      test(
        'throws ApiException when failed to delete document in Firestore',
        () {
          when(() => documentReference.delete()).thenThrow(Exception());

          expect(
            () => workoutTemplatesResource.deleteUserWorkoutTemplate(
              userId: userId,
              workoutTemplateId: templateId,
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
  });
}
