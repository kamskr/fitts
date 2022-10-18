import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
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

    group('userProfile', () {
      test('is cached when called with the same user identifier', () async {
        final repository = UserProfileRepository(apiClient);

        final stream1 = repository.userProfile;
        final stream2 = repository.userProfile;

        expect(stream1, equals(stream2));
      });

      test(
          'reports UserProfileStreamFailure '
          'when user profile stream reports an error', () {
        final repository = UserProfileRepository(apiClient);
        final userProfileController = BehaviorSubject<UserProfile>();
        when(() => resource.userProfile(user1Id)).thenAnswer(
          (_) => userProfileController.stream,
        );

        expectLater(
          repository.userProfile(user1Id),
          emitsInOrder(
            <dynamic>[
              emits(UserProfile.empty.copyWith(email: 'waiting')),
              emitsError(isA<UserProfileStreamFailure>()),
            ],
          ),
        );

        userProfileController.addError(Exception());
      });
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
        profileStatus: ProfileStatusStringValue.active,
      );

      test('Calls appointmentsResource.updateUserProfile with proper payload',
          () async {
        when(
          () => resource.updateUserProfile(
            payload: payload,
          ),
        ).thenAnswer((_) async {});

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
        when(
          () => resource.updateUserProfile(
            payload: payload,
          ),
        ).thenThrow(Exception());
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
