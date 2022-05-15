import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockUserProfileResource extends Mock implements UserProfileResource {}

void main() {
  group('UserProfileRepository.', () {
    late ApiClient apiClient;
    late UserProfileResource resource;

    const user1Id = 'user1@email.com';

    setUp(() {
      apiClient = MockApiClient();
      resource = MockUserProfileResource();

      when(() => apiClient.userProfileResource).thenReturn(resource);
    });

    group('updateUserProfile', () {
      final payload = UserProfileUpdatePayload(
        email: user1Id,
        displayName: 'displayName',
        height: 180,
        goal: 'goal',
        weight: 80,
        dateOfBirth: DateTime(1990),
        gender: 'female',
        photoUrl: 'photoUrl',
        isNewUser: false,
      );

      test('Calls appointmentsResource.updateUserProfile with proper payload',
          () async {
        when(() => resource.updateUserProfile(
              payload: payload,
            )).thenAnswer((_) async {});

        final repository = UserProfileRepository(apiClient);
        await repository.updateUserProfile(
          payload: payload,
        );

        verify(
          () => resource.updateUserProfile(payload: payload),
        ).called(1);
      });

      test(
          'throws [UpdateUserProfileFailure] '
          'when fetching user profile from resource fails', () async {
        when(() => resource.updateUserProfile(
              payload: payload,
            )).thenThrow(Exception());
        final repository = UserProfileRepository(apiClient);

        expect(
          () => repository.updateUserProfile(
            payload: payload,
          ),
          throwsA(isA<UpdateUserProfileFailure>()),
        );
      });
    });
  });
}
