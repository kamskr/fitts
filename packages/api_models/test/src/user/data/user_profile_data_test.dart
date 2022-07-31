import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserProfileData', () {
    test('can be instantiated.', () {
      final userProfileData = UserProfileData.empty;
      expect(userProfileData, isNotNull);
    });

    test('supports value equality.', () {
      final user = UserProfileData.empty;
      final user2 = UserProfileData.empty;

      expect(user, equals(user2));
    });

    test('has correct props', () {
      final userProfileData = UserProfileData.empty;
      expect(
        userProfileData.props,
        equals([
          userProfileData.email,
          userProfileData.photoUrl,
          userProfileData.displayName,
          userProfileData.goal,
          userProfileData.gender,
          userProfileData.dateOfBirth,
          userProfileData.height,
          userProfileData.weight,
          userProfileData.profileStatus,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final userProfileData = UserProfileData.empty;
      final now = DateTime.now();

      final copy = userProfileData.copyWith(
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

      final userProfileDataCompare = UserProfileData(
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

      expect(copy, equals(userProfileDataCompare));
    });
    test('can be created from json', () {
      const json = {
        'email': 'email',
        'photoUrl': 'photoUrl',
        'displayName': 'displayName',
        'goal': 'goal',
        'gender': 'female',
        'height': 180,
        'weight': 80,
        'profileStatus': 'onboardingRequired',
      };

      final userProfileData = UserProfileData.fromJson(json);

      const userProfileDataCompare = UserProfileData(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: 'female',
        height: 180,
        weight: 80,
        profileStatus: 'onboardingRequired',
      );

      expect(userProfileData, equals(userProfileDataCompare));
    });
    test('can be converted to json', () {
      const json = {
        'email': 'email',
        'photoUrl': 'photoUrl',
        'displayName': 'displayName',
        'goal': 'goal',
        'gender': 'female',
        'dateOfBirth': null,
        'height': 180,
        'weight': 80,
        'profileStatus': 'onboardingRequired',
      };

      const userProfileDataCompare = UserProfileData(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: 'female',
        height: 180,
        weight: 80,
        profileStatus: 'onboardingRequired',
      );

      final finalJson = userProfileDataCompare.toJson();

      expect(json, equals(finalJson));
    });
  });
}
