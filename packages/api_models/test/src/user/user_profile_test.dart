import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserProfile', () {
    test('can be instantiated.', () {
      final userProfile = UserProfile.empty;
      expect(userProfile, isNotNull);
    });

    test('supports value equality.', () {
      final user = UserProfile.empty;
      final user2 = UserProfile.empty;

      expect(user, equals(user2));
    });

    test('has correct props', () {
      final userProfile = UserProfile.empty;
      expect(
        userProfile.props,
        equals([
          userProfile.email,
          userProfile.photoUrl,
          userProfile.displayName,
          userProfile.goal,
          userProfile.gender,
          userProfile.dateOfBirth,
          userProfile.height,
          userProfile.weight,
          userProfile.profileStatus,
        ]),
      );
    });

    test('can be copyWith with changed properties', () {
      final userProfile = UserProfile.empty;
      final now = DateTime.now();

      final copy = userProfile.copyWith(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: Gender.female,
        dateOfBirth: now,
        height: 180,
        weight: 80,
        profileStatus: ProfileStatus.onboardingRequired,
      );

      final userProfileCompare = UserProfile(
        email: 'email',
        photoUrl: 'photoUrl',
        displayName: 'displayName',
        goal: 'goal',
        gender: Gender.female,
        dateOfBirth: now,
        height: 180,
        weight: 80,
        profileStatus: ProfileStatus.onboardingRequired,
      );

      expect(copy, equals(userProfileCompare));
      expect(userProfileCompare, equals(userProfileCompare.copyWith()));
    });
    test('can be converted to String', () {
      expect(UserProfile.empty.toString(), isA<String>());
    });
  });
}
