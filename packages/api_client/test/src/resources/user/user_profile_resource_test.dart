// ignore_for_file: subtype_of_sealed_class

import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  group('UserProfileResource', () {
    const userProfileId = 'user@email.te';

    late UserProfileResource userProfileResource;
    late FirebaseFirestore firebaseFirestore;
    late CollectionReference<Map<String, dynamic>> collectionReference;
    late DocumentReference<Map<String, dynamic>> documentReference;
    late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

    final userProfileData = {
      'email': 'test@email.com',
      'photoUrl': 'www.test-url.te',
      'displayName': 'displayName',
      'goal': 'goal',
      'gender': 'male',
      'dateOfBirth': '1974-03-20 00:00:00.000',
      'height': 180,
      'weight': 85.5,
      'profileStatus': ProfileStatusStringValue.active,
    };

    final userProfileDataMalformed = {
      'email': 'test@email.com',
      'photoUrl': 'www.test-url.te',
      'displayName': 'displayName',
      'goal': 'goal',
      'gender': 'not-male',
      'dateOfBirth': 'data',
      'height': '180',
      'weight': '85.5',
      'profileStatus': ProfileStatusStringValue.active,
    };

    final userProfile = UserProfile(
      email: 'test@email.com',
      photoUrl: 'www.test-url.te',
      displayName: 'displayName',
      goal: 'goal',
      gender: Gender.male,
      dateOfBirth: DateTime.parse('1974-03-20 00:00:00.000'),
      height: 180,
      weight: 85.5,
      profileStatus: ProfileStatus.active,
    );
    final userProfilePayload = UserProfileUpdatePayload(
      email: 'test@email.com',
      photoUrl: 'www.test-url.te',
      displayName: 'displayName',
      goal: 'goal',
      gender: 'male',
      dateOfBirth: DateTime.parse('1974-03-20 00:00:00.000'),
      height: 180,
      weight: 85.5,
      profileStatus: ProfileStatusStringValue.active,
    );

    setUp(() {
      firebaseFirestore = MockFirebaseFirestore();
      collectionReference = MockCollectionReference();
      documentReference = MockDocumentReference();
      documentSnapshot = MockDocumentSnapshot();

      when(() => firebaseFirestore.collection('UserProfiles'))
          .thenReturn(collectionReference);

      when(() => collectionReference.doc(userProfileId))
          .thenReturn(documentReference);

      when(documentReference.snapshots)
          .thenAnswer((_) => Stream.value(documentSnapshot));

      when(() => documentSnapshot.exists).thenReturn(true);
      when(() => documentSnapshot.data()).thenReturn(userProfileData);

      userProfileResource = UserProfileResource(firebaseFirestore);
    });

    test('can be instantiated', () {
      expect(
        UserProfileResource(firebaseFirestore),
        isNotNull,
      );
    });

    group('userProfile', () {
      test('userProfile stream emits value', () async {
        // Get data from DataRepository's noteStream i.e the method being tested
        final userProfileStream =
            userProfileResource.userProfile(userProfileId);

        expect(userProfileStream, emits(userProfile));
      });
      test('userProfile stream emits correct user', () async {
        // Get data from DataRepository's noteStream i.e the method being tested
        final userProfileStream =
            userProfileResource.userProfile(userProfileId);

        final user = await userProfileStream.first;

        expect(user, userProfile);
      });
      test(
          'emits DeserializationException '
          'when malformed user profile is emitted by the database', () {
        when(() => documentSnapshot.data())
            .thenReturn(userProfileDataMalformed);

        expectLater(
          userProfileResource.userProfile(userProfileId),
          emitsError(isA<DeserializationException>()),
        );
      });
    });

    group('updateUserProfile', () {
      test("doesn't throw error when user profile updated", () async {
        expect(
          () => userProfileResource.updateUserProfile(
              payload: userProfilePayload),
          isNot(isException),
        );
      });
    });
  });
}
