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

class MockUserLogsCollectionReference extends Mock
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
  group('WorkoutLogsResource', () {
    late FirebaseFirestore firebaseFirestore;
    late WorkoutLogsResource workoutLogsResource;
    late CollectionReference<Map<String, dynamic>> collectionReference;
    late CollectionReference<Map<String, dynamic>> userLogsCollectionReference;
    late DocumentReference<Map<String, dynamic>> documentReference;
    late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
    late QuerySnapshot<Map<String, dynamic>> querySnapshot;
    late QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot;

    const collectionName = 'WorkoutLogs';
    const userLogsCollectionName = 'UserLogs';

    final workoutLogData = {
      'duration': 1,
      'datePerformed': DateTime.now().toString(),
      'workoutTemplateId': 'id',
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

    const userId = 'userId';
    const templateId = 'templateId';

    setUp(() {
      firebaseFirestore = FirebaseFirestoreMock();
      workoutLogsResource = WorkoutLogsResource(firebaseFirestore);
      collectionReference = MockCollectionReference();
      userLogsCollectionReference = MockCollectionReference();
      documentReference = MockDocumentReference();
      documentSnapshot = MockDocumentSnapshot();
      querySnapshot = MockQuerySnapshot();
      queryDocumentSnapshot = MockQueryDocumentSnapshot();

      when(() => firebaseFirestore.collection(collectionName))
          .thenReturn(collectionReference);

      when(() => collectionReference.doc(userId)).thenReturn(documentReference);

      when(() => documentReference.collection(userLogsCollectionName))
          .thenReturn(userLogsCollectionReference);

      when(() => userLogsCollectionReference.doc(templateId))
          .thenReturn(documentReference);

      when(() => documentReference.snapshots())
          .thenAnswer((_) => Stream.value(documentSnapshot));

      when(() => documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data).thenReturn(workoutLogData);
      when(() => documentSnapshot.id).thenReturn(templateId);
      when(() => userLogsCollectionReference.add(any()))
          .thenAnswer((_) async => documentReference);
      when(() => documentReference.set(any())).thenAnswer((_) async {});
      when(() => documentReference.update(any())).thenAnswer((_) async {});
      when(() => documentReference.delete()).thenAnswer((_) async {});

      when(() => userLogsCollectionReference.snapshots())
          .thenAnswer((_) => Stream.value(querySnapshot));

      when(() => querySnapshot.docs).thenReturn([queryDocumentSnapshot]);

      when(() => queryDocumentSnapshot.data()).thenReturn(workoutLogData);

      when(() => queryDocumentSnapshot.id).thenReturn(templateId);
    });

    test('can be instantiated', () {
      expect(WorkoutLogsResource(firebaseFirestore), isNotNull);
    });
    group('getUserWorkoutLogs', () {
      test('returns Stream<List<WorkoutLog>?> with correct data', () {
        final result = workoutLogsResource.getUserWorkoutLogs(userId);

        expect(result, isA<Stream<List<WorkoutLog>?>>());

        result.listen((event) {
          expect(event, isA<List<WorkoutLog>>());
          expect(event!.length, 1);

          expect(event.first.exercises, isA<List<WorkoutExercise>>());
          expect(event.first.exercises.length, 2);

          expect(event.first.exercises.length, 2);
        });
      });

      test(
        'returns null if list of templates is empty.',
        () {
          when(() => querySnapshot.docs).thenReturn([]);

          final result = workoutLogsResource.getUserWorkoutLogs(userId);

          expect(result, isA<Stream<List<WorkoutLog>?>>());

          result.listen((event) {
            expect(event, isNull);
          });
        },
      );
      test(
        'throws ApiException when failed to get data from Firestore',
        () {
          when(() => userLogsCollectionReference.snapshots())
              .thenThrow(Exception());

          expect(
            () => workoutLogsResource.getUserWorkoutLogs(userId),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('getUserWorkoutLogById', () {
      test('returns Stream<WorkoutLog?> with correct data', () {
        final result = workoutLogsResource.getUserWorkoutLogById(
          userId: userId,
          workoutLogId: templateId,
        );

        expect(result, isA<Stream<WorkoutLog?>>());

        result.listen((event) {
          expect(event, isA<WorkoutLog>());

          expect(event!.exercises, isA<List<WorkoutExercise>>());
          expect(event.exercises.length, 2);

          expect(event.exercises.length, 2);
        });
      });

      test(
        'throws ApiException when failed to get data from Firestore',
        () {
          when(() => documentReference.snapshots()).thenThrow(Exception());

          expect(
            () => workoutLogsResource.getUserWorkoutLogById(
              userId: userId,
              workoutLogId: templateId,
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('createUserWorkoutLog', () {
      test(
        'sends correct data to Firestore to create document',
        () {
          workoutLogsResource.createUserWorkoutLog(
            userId: userId,
            payload: WorkoutLog(
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
            ),
          );

          verify(
            () => userLogsCollectionReference.add(any()),
          ).called(1);
        },
      );
      test(
        'throws ApiException when failed to create document in Firestore',
        () {
          when(() => userLogsCollectionReference.add(any()))
              .thenThrow(Exception());

          expect(
            () => workoutLogsResource.createUserWorkoutLog(
              userId: userId,
              payload: WorkoutLog(
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
              ),
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('updateUserWorkoutLog', () {
      test(
        'sends correct data to Firestore to update document',
        () {
          workoutLogsResource.updateUserWorkoutLog(
            userId: userId,
            workoutLogId: templateId,
            payload: WorkoutLog(
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
            () => workoutLogsResource.updateUserWorkoutLog(
              userId: userId,
              workoutLogId: templateId,
              payload: WorkoutLog(
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
              ),
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('deleteUserWorkoutLog', () {
      test(
        'sends correct data to Firestore to delete document',
        () {
          workoutLogsResource.deleteUserWorkoutLog(
            userId: userId,
            workoutLogId: templateId,
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
            () => workoutLogsResource.deleteUserWorkoutLog(
              userId: userId,
              workoutLogId: templateId,
            ),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
  });
}
