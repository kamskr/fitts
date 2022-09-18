// ignore_for_file: subtype_of_sealed_class, lines_longer_than_80_chars
import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
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
  group('ExerciseResource', () {
    late FirebaseFirestore firebaseFirestore;
    late ExerciseResource exerciseResource;
    late CollectionReference<Map<String, dynamic>> collectionReference;
    late DocumentReference<Map<String, dynamic>> documentReference;
    late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
    late QuerySnapshot<Map<String, dynamic>> querySnapshot;
    late QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot;

    const collectionName = 'Exercises';

    const exerciseId = 'exerciseId';

    const exerciseData = {
      'id': exerciseId,
      'name': "World's Greatest Stretch",
      'force': 'static',
      'level': 'intermediate',
      'mechanic': null,
      'equipment': null,
      'primaryMuscles': ['hamstrings'],
      'secondaryMuscles': ['calves', 'glutes', 'quadriceps'],
      'instructions': [
        'This is a three-part stretch. Begin by lunging forward, with your front foot flat on the ground and on the toes of your back foot. With your knees bent, squat down until your knee is almost touching the ground. Keep your torso erect, and hold this position for 10-20 seconds.',
        'Now, place the arm on the same side as your front leg on the ground, with the elbow next to the foot. Your other hand should be placed on the ground, parallel to your lead leg, to help support you during this portion of the stretch.',
        'After 10-20 seconds, place your hands on either side of your front foot. Raise the toes of the front foot off of the ground, and straighten your leg. You may need to reposition your rear leg to do so. Hold for 10-20 seconds, and then repeat the entire sequence for the other side.'
      ],
      'category': 'stretching'
    };

    setUp(() {
      firebaseFirestore = FirebaseFirestoreMock();
      exerciseResource = ExerciseResource(firebaseFirestore);
      collectionReference = MockCollectionReference();
      documentReference = MockDocumentReference();
      documentSnapshot = MockDocumentSnapshot();
      querySnapshot = MockQuerySnapshot();
      queryDocumentSnapshot = MockQueryDocumentSnapshot();

      when(() => firebaseFirestore.collection(collectionName))
          .thenReturn(collectionReference);

      when(() => collectionReference.get())
          .thenAnswer((_) async => Future.value(querySnapshot));

      when(() => collectionReference.doc(exerciseId))
          .thenReturn(documentReference);

      when(() => documentReference.get())
          .thenAnswer((_) => Future.value(documentSnapshot));

      when(() => documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data).thenReturn(exerciseData);

      when(() => querySnapshot.docs).thenReturn([queryDocumentSnapshot]);

      when(queryDocumentSnapshot.data).thenReturn(exerciseData);
      when(() => queryDocumentSnapshot.id).thenReturn(exerciseId);
      when(() => queryDocumentSnapshot.exists).thenReturn(true);
    });

    test('can be instantiated', () {
      expect(
        ExerciseResource(firebaseFirestore),
        isInstanceOf<ExerciseResource>(),
      );
    });
    group('getExercise', () {
      test('returns an exercise with given id', () async {
        final exercise = await exerciseResource.getExercise(exerciseId);
        expect(exercise, isInstanceOf<Exercise>());
        expect(exercise.id, exerciseId);
      });

      test(
        'throws a [DeserializationException] when Exception '
        'occurs during deserialization.',
        () async {
          when(documentSnapshot.data).thenReturn({'test': 'test'});
          expect(
            () => exerciseResource.getExercise(exerciseId),
            throwsA(isInstanceOf<DeserializationException>()),
          );
        },
      );
      test(
        'throws a [NotFoundException] when no item found.',
        () async {
          when(() => documentSnapshot.exists).thenReturn(false);
          expect(
            () => exerciseResource.getExercise(exerciseId),
            throwsA(isInstanceOf<NotFoundException>()),
          );
        },
      );

      test(
        'throws a [ApiException] when Exception '
        'occurs when trying to retrieve information from database.',
        () async {
          when(() => documentReference.get())
              .thenAnswer((_) => Future.error(Exception()));
          expect(
            () => exerciseResource.getExercise(exerciseId),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
    group('getAllExercises', () {
      test('returns all exercises as a Map', () async {
        final exercises = await exerciseResource.getAllExercises();
        expect(exercises, isInstanceOf<Map<String, Exercise>>());
        expect(exercises.length, 1);
      });

      test(
        'throws a [DeserializationException] when Exception '
        'occurs during deserialization.',
        () async {
          when(queryDocumentSnapshot.data).thenReturn({'test': 'test'});
          expect(
            () => exerciseResource.getAllExercises(),
            throwsA(isInstanceOf<DeserializationException>()),
          );
        },
      );

      test(
        'throws a [ApiException] when Exception '
        'occurs when trying to retrieve information from database.',
        () async {
          when(() => collectionReference.get())
              .thenAnswer((_) => Future.error(Exception()));
          expect(
            () => exerciseResource.getAllExercises(),
            throwsA(isInstanceOf<ApiException>()),
          );
        },
      );
    });
  });
}
