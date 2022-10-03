// ignore_for_file: subtype_of_sealed_class

import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
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

void main() {
  group('UserStatsResource', () {
    late FirebaseFirestore firebaseFirestore;
    late UserStatsResource userStatsResource;
    late CollectionReference<Map<String, dynamic>> collectionReference;
    late DocumentReference<Map<String, dynamic>> documentReference;
    late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

    const collectionName = 'UserStats';

    const userId = 'user@email.com';

    const userStatsData = {
      'global': {
        'keyLifts': ['flat_bench_press'],
        'liftingTimeSpent': 120,
        'totalKgLifted': 5000,
        'workoutsCompleted': 2,
      },
      'exercises': {
        'flat_bench_press': {
          'highestWeight': 120,
          'repetitionsDone': 2000,
          'timesPerformed': 100,
          'overallBest': {'repetitions': 1, 'weight': 120},
        },
      }
    };

    const userStatsMalformed = {
      'global': {
        'keyLifts': ['flat_bench_press'],
        'liftingTimeSpent': 120,
        'totalKgLifted': 5000,
        'workoutsCompleted': 2,
      },
      'exercises': [
        {
          'highestWeight': 120,
          'repetitionsDone': 2000,
          'timesPerformed': 100,
          'overallBest': {'repetitions': 1, 'weight': 120},
        },
      ]
    };

    const userStats = UserStats(
      globalStats: GlobalStats(
        keyLifts: ['flat_bench_press'],
        liftingTimeSpent: 120,
        totalKgLifted: 5000,
        workoutsCompleted: 2,
      ),
      exercisesStats: {
        'flat_bench_press': ExerciseStats(
          highestWeight: 120,
          repetitionsDone: 2000,
          timesPerformed: 100,
          overallBest: OverallBest(repetitions: 1, weight: 120),
        ),
      },
    );

    setUp(() {
      firebaseFirestore = FirebaseFirestoreMock();
      userStatsResource = UserStatsResource(firebaseFirestore);
      collectionReference = MockCollectionReference();
      documentReference = MockDocumentReference();
      documentSnapshot = MockDocumentSnapshot();

      when(() => firebaseFirestore.collection(collectionName))
          .thenReturn(collectionReference);

      when(() => collectionReference.doc(userId)).thenReturn(documentReference);

      when(() => documentReference.snapshots())
          .thenAnswer((_) => Stream.value(documentSnapshot));

      when(() => documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data).thenReturn(userStatsData);
    });

    test('can be instantiated', () {
      expect(
        UserStatsResource(firebaseFirestore),
        isNotNull,
      );
    });

    test('userStars stream emits value', () async {
      final userStatsStream = userStatsResource.userStats(userId);

      expect(userStatsStream, emits(userStats));
    });

    test(
      'throws a [DeserializationException] '
      'when data is malformed.',
      () async {
        when(documentSnapshot.data).thenReturn(userStatsMalformed);

        expect(
          userStatsResource.userStats(userId),
          emitsError(isA<DeserializationException>()),
        );
      },
    );

    test(
        'throws a [ApiException] when Exception '
        'occurs when trying to receive data from database', () async {
      when(() => firebaseFirestore.collection(collectionName))
          .thenThrow(Exception());

      expect(
        () => userStatsResource.userStats(userId),
        throwsA(isA<ApiException>()),
      );
    });

    test('userStars stream emits empty value when userStars is empty', () {
      when(documentSnapshot.data).thenReturn(null);

      expect(
        userStatsResource.userStats(userId),
        emits(null),
      );
    });

    test("doesn't throw error when user profile updated", () async {
      expect(
        () => userStatsResource.updateUserStats(
          userId: userId,
          payload: userStats,
        ),
        isNot(isException),
      );
    });
    test('throws error when user profile update failed', () async {
      when(() => firebaseFirestore.collection(collectionName))
          .thenThrow(Exception());

      expect(
        () => userStatsResource.updateUserStats(
          userId: userId,
          payload: userStats,
        ),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
