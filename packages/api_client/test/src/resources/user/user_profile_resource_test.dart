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
    const userProfileIdMale = 'userMale@email.te';
    const userProfileIdFemale = 'userFemale@email.te';

    late UserProfileResource userProfileResource;
    late FirebaseFirestore firebaseFirestore;
    late CollectionReference<Map<String, dynamic>> collectionReference;
    late DocumentReference<Map<String, dynamic>> documentReferenceMale;
    late DocumentSnapshot<Map<String, dynamic>> documentSnapshotMale;
    late DocumentReference<Map<String, dynamic>> documentReferenceFemale;
    late DocumentSnapshot<Map<String, dynamic>> documentSnapshotFemale;

    final userProfileDataMale = {
      'email': userProfileIdMale,
      'photoUrl': 'www.test-url.te',
      'displayName': 'displayName',
      'goal': 'goal',
      'gender': 'male',
      'dateOfBirth': '1974-03-20 00:00:00.000',
      'height': 180,
      'weight': 85.5,
      'profileStatus': ProfileStatusStringValue.active,
    };

    final userProfileDataOnboarding = {
      'email': userProfileIdMale,
      'photoUrl': 'www.test-url.te',
      'displayName': 'displayName',
      'goal': 'goal',
      'gender': 'male',
      'dateOfBirth': '1974-03-20 00:00:00.000',
      'height': 180,
      'weight': 85.5,
      'profileStatus': ProfileStatusStringValue.onboardingRequired,
    };

    final userProfileDataBlocked = {
      'email': userProfileIdMale,
      'photoUrl': 'www.test-url.te',
      'displayName': 'displayName',
      'goal': 'goal',
      'gender': 'male',
      'dateOfBirth': '1974-03-20 00:00:00.000',
      'height': 180,
      'weight': 85.5,
      'profileStatus': ProfileStatusStringValue.blocked,
    };

    final userProfileDataFemale = {
      'email': userProfileIdFemale,
      'photoUrl': 'www.test-url.te',
      'displayName': 'displayName',
      'goal': 'goal',
      'gender': 'female',
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

    final userProfileMale = UserProfile(
      email: userProfileIdMale,
      photoUrl: 'www.test-url.te',
      displayName: 'displayName',
      goal: 'goal',
      gender: Gender.male,
      dateOfBirth: DateTime.parse('1974-03-20 00:00:00.000'),
      height: 180,
      weight: 85.5,
      profileStatus: ProfileStatus.active,
    );

    final userProfileFemale = UserProfile(
      email: userProfileIdFemale,
      photoUrl: 'www.test-url.te',
      displayName: 'displayName',
      goal: 'goal',
      gender: Gender.female,
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
      documentReferenceMale = MockDocumentReference();
      documentSnapshotMale = MockDocumentSnapshot();
      documentReferenceFemale = MockDocumentReference();
      documentSnapshotFemale = MockDocumentSnapshot();

      when(() => firebaseFirestore.collection('UserProfiles'))
          .thenReturn(collectionReference);

      when(() => collectionReference.doc(userProfileIdMale))
          .thenReturn(documentReferenceMale);

      when(() => collectionReference.doc(userProfileIdFemale))
          .thenReturn(documentReferenceFemale);

      when(documentReferenceMale.snapshots)
          .thenAnswer((_) => Stream.value(documentSnapshotMale));

      when(() => documentReferenceMale.set(any())).thenAnswer((_) async {});

      when(documentReferenceFemale.snapshots)
          .thenAnswer((_) => Stream.value(documentSnapshotFemale));

      when(() => documentReferenceFemale.set(any())).thenAnswer((_) async {});

      when(() => documentSnapshotMale.exists).thenReturn(true);
      when(() => documentSnapshotFemale.exists).thenReturn(true);

      when(documentSnapshotMale.data).thenReturn(userProfileDataMale);
      when(documentSnapshotFemale.data).thenReturn(userProfileDataFemale);

      userProfileResource = UserProfileResource(firebaseFirestore);
    });

    test('can be instantiated', () {
      expect(
        UserProfileResource(firebaseFirestore),
        isNotNull,
      );
    });

    group('userProfile', () {
      test('userProfile stream emits correct value', () async {
        var userProfileStream =
            userProfileResource.userProfile(userProfileIdMale);

        expect(userProfileStream, emits(userProfileMale));

        userProfileStream =
            userProfileResource.userProfile(userProfileIdFemale);

        expect(userProfileStream, emits(userProfileFemale));
      });

      test("emits UserProfile.empty if snapshot doesn't exist", () async {
        when(() => documentSnapshotMale.exists).thenReturn(false);
        final userProfileStream =
            userProfileResource.userProfile(userProfileIdMale);

        final user = await userProfileStream.first;

        expect(user, UserProfile.empty);
      });

      test('userProfile stream emits correct user', () async {
        var userProfileStream =
            userProfileResource.userProfile(userProfileIdMale);

        var user = await userProfileStream.first;

        expect(user, userProfileMale);

        userProfileStream =
            userProfileResource.userProfile(userProfileIdFemale);

        user = await userProfileStream.first;

        expect(user, userProfileFemale);
      });
      test('correctly maps user with status onboarding.', () async {
        when(documentSnapshotMale.data).thenReturn(userProfileDataOnboarding);

        final userProfileStream =
            userProfileResource.userProfile(userProfileIdMale);

        final user = await userProfileStream.first;

        expect(
          user,
          userProfileMale.copyWith(
            profileStatus: ProfileStatus.onboardingRequired,
          ),
        );
      });

      test('correctly maps user with status blocked.', () async {
        when(documentSnapshotMale.data).thenReturn(userProfileDataBlocked);

        final userProfileStream =
            userProfileResource.userProfile(userProfileIdMale);

        final user = await userProfileStream.first;

        expect(
          user,
          userProfileMale.copyWith(
            profileStatus: ProfileStatus.blocked,
          ),
        );
      });

      test('userProfile stream emits correct user', () async {
        var userProfileStream =
            userProfileResource.userProfile(userProfileIdMale);

        var user = await userProfileStream.first;

        expect(user, userProfileMale);

        userProfileStream =
            userProfileResource.userProfile(userProfileIdFemale);

        user = await userProfileStream.first;

        expect(user, userProfileFemale);
      });
      test(
          'emits DeserializationException '
          'when malformed user profile is emitted by the database', () {
        when(documentSnapshotMale.data).thenReturn(userProfileDataMalformed);

        expectLater(
          userProfileResource.userProfile(userProfileIdMale),
          emitsError(isA<DeserializationException>()),
        );
      });
    });

    group('updateUserProfile', () {
      test("doesn't throw error when user profile updated", () async {
        await expectLater(
          () => userProfileResource.updateUserProfile(
            payload: userProfilePayload,
          ),
          isNot(isException),
        );
      });
    });
  });
}
