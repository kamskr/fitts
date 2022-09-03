import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserProfileUpdatePayload', () {
    test('can be instantiated.', () {
      final userProfileUpdatePayload = UserProfileUpdatePayload.empty;
      expect(userProfileUpdatePayload, isNotNull);
    });

    test('supports value equality.', () {
      final user = UserProfileUpdatePayload.empty;
      final user2 = UserProfileUpdatePayload.empty;

      expect(user, equals(user2));
    });

    test('has correct props', () {
      final userProfileUpdatePayload = UserProfileUpdatePayload.empty;
      expect(
        userProfileUpdatePayload.props,
        equals([
          userProfileUpdatePayload.email,
          userProfileUpdatePayload.photoUrl,
          userProfileUpdatePayload.displayName,
          userProfileUpdatePayload.goal,
          userProfileUpdatePayload.gender,
          userProfileUpdatePayload.dateOfBirth,
          userProfileUpdatePayload.height,
          userProfileUpdatePayload.weight,
          userProfileUpdatePayload.profileStatus,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final userProfileUpdatePayload = UserProfileUpdatePayload.empty;
      final now = DateTime.now();

      final copy = userProfileUpdatePayload.copyWith(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: 'female',
        dateOfBirth: now,
        height: 180,
        weight: 80,
        profileStatus: 'onboardingRequired',
      );

      final userProfileUpdatePayloadCompare = UserProfileUpdatePayload(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: 'female',
        dateOfBirth: now,
        height: 180,
        weight: 80,
        profileStatus: 'onboardingRequired',
      );

      expect(copy, equals(userProfileUpdatePayloadCompare));
      expect(copy, equals(copy.copyWith()));
    });
    test('can be created from json', () {
      const json = {
        'email': 'email',
        'photoUrl': 'photoUrl',
        'displayName': 'displayName',
        'goal': 'goal',
        'gender': 'female',
        'dateOfBirth': '2000-01-01T00:00:00.000',
        'height': 180,
        'weight': 80,
        'profileStatus': 'onboardingRequired',
      };

      final userProfileUpdatePayload = UserProfileUpdatePayload.fromJson(json);

      final userProfileUpdatePayloadCompare = UserProfileUpdatePayload(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: 'female',
        dateOfBirth: DateTime(2000),
        height: 180,
        weight: 80,
        profileStatus: 'onboardingRequired',
      );

      expect(userProfileUpdatePayload, equals(userProfileUpdatePayloadCompare));
    });
    test('can be converted to json', () {
      const json = {
        'email': 'email',
        'photoUrl': 'photoUrl',
        'displayName': 'displayName',
        'goal': 'goal',
        'gender': 'female',
        'dateOfBirth': '2000-01-01T00:00:00.000',
        'height': 180,
        'weight': 80,
        'profileStatus': 'onboardingRequired',
      };

      final userProfileUpdatePayloadCompare = UserProfileUpdatePayload(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: 'female',
        dateOfBirth: DateTime(2000),
        height: 180,
        weight: 80,
        profileStatus: 'onboardingRequired',
      );

      final finalJson = userProfileUpdatePayloadCompare.toJson();

      expect(json, equals(finalJson));
    });
  });
  test('can be converted to String', () {
    expect(UserProfileUpdatePayload.empty.toString(), isA<String>());
  });
}
