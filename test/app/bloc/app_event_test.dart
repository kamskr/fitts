import 'package:api_models/api_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements User {}

class MockUserProfile extends Mock implements UserProfile {}

void main() {
  group('AppEvent', () {
    group('AppUserChanged', () {
      final user = MockUser();
      test('supports value comparisons', () {
        expect(
          AppUserChanged(user),
          AppUserChanged(user),
        );
      });
    });
    group('AppUserProfileChanged', () {
      final userProfile = MockUserProfile();

      test('supports value comparisons', () {
        expect(
          AppUserProfileChanged(userProfile),
          AppUserProfileChanged(userProfile),
        );
      });
    });
  });
}
