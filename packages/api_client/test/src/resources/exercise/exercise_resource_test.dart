// ignore_for_file: subtype_of_sealed_class
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

    const exercisesData = {
      'wide_stance_barbell_squat': {
        'id': 'id',
        'name': 'Wide Stance Barbell Squat',
        'force': 'push',
        'level': 'intermediate',
        'mechanic': 'compound',
        'equipment': 'barbell',
        'primaryMuscles': ['quadriceps'],
        'secondaryMuscles': ['calves', 'glutes', 'hamstrings', 'lower back'],
        'instructions': [
          'This exercise is best performed inside a squat rack for safety purposes. To begin, first set the bar on a rack that best matches your height. Once the correct height is chosen and the bar is loaded, step under the bar and place the back of your shoulders (slightly below the neck) across it.',
          'Hold on to the bar using both arms at each side and lift it off the rack by first pushing with your legs and at the same time straightening your torso.',
          'Step away from the rack and position your legs using a wider-than-shoulder-width stance with the toes slightly pointed out. Keep your head up at all times as looking down will get you off balance, and also maintain a straight back. This will be your starting position.',
          'Begin to slowly lower the bar by bending the knees as you maintain a straight posture with the head up. Continue down until the angle between the upper leg and the calves becomes slightly less than 90-degrees (which is the point in which the upper legs are below parallel to the floor). Inhale as you perform this portion of the movement. Tip: If you performed the exercise correctly, the front of the knees should make an imaginary straight line with the toes that is perpendicular to the front. If your knees are past that imaginary line (if they are past your toes) then you are placing undue stress on the knee and the exercise has been performed incorrectly.',
          'Begin to raise the bar as you exhale by pushing the floor with the heel of your foot as you straighten the legs again and go back to the starting position.',
          'Repeat for the recommended amount of repetitions.'
        ],
        'category': 'strength'
      },
      'wide_stance stiff legs': {
        'id': 'id',
        'name': 'Wide Stance Stiff Legs',
        'force': 'pull',
        'level': 'intermediate',
        'mechanic': 'compound',
        'equipment': 'barbell',
        'primaryMuscles': ['hamstrings'],
        'secondaryMuscles': ['adductors', 'glutes', 'lower back'],
        'instructions': [
          'Begin with a barbell loaded on the floor. Adopt a wide stance, and then bend at the hips to grab the bar. Your hips should be as far back as possible, and your legs nearly straight. Keep your back straight, and your head and chest up. This will be your starting position.',
          'Begin the movement be engaging the hips, driving them forward as you allow the arms to hang straight. Continue until you are standing straight up, and then slowly return the weight to the starting position. For successive reps, the weight need not touch the floor.'
        ],
        'category': 'olympic weightlifting'
      },
      'wind_sprints': {
        'id': 'id',
        'name': 'Wind Sprints',
        'force': 'pull',
        'level': 'beginner',
        'mechanic': 'compound',
        'equipment': 'body only',
        'primaryMuscles': ['abdominals'],
        'secondaryMuscles': [],
        'instructions': [
          'Hang from a pull-up bar using a pronated grip. Your arms and legs should be extended. This will be your starting position.',
          'Begin by quickly raising one knee as high as you can. Do not swing your body or your legs. 3',
          'Immediately reverse the motion, returning that leg to the starting position. Simultaneously raise the opposite knee as high as possible.',
          'Continue alternating between legs until the set is complete.'
        ],
        'category': 'strength'
      },
      'windmills': {
        'id': 'id',
        'name': 'Windmills',
        'force': 'pull',
        'level': 'intermediate',
        'mechanic': null,
        'equipment': null,
        'primaryMuscles': ['abductors'],
        'secondaryMuscles': ['glutes', 'hamstrings', 'lower back'],
        'instructions': [
          'Lie on your back with your arms extended out to the sides and your legs straight. This will be your starting position.',
          'Lift one leg and quickly cross it over your body, attempting to touch the ground near the opposite hand.',
          'Return to the starting position, and repeat with the opposite leg. Continue to alternate for 10-20 repetitions.'
        ],
        'category': 'stretching'
      },
      'world_s_greatest_stretch': {
        'id': 'id',
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
      },
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
