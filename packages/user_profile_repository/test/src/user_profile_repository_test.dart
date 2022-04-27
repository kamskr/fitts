import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:api_models/api_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockUserProfileResource extends Mock implements UserProfileResource {}

void main() {
  group('UserProfileRepository.', () {
    late ApiClient apiClient;
    late UserProfileResource resource;

    const user1Id = 'user1@email.com';
    const user2Id = 'user2@email.com';

    final userProfile1 = UserProfile(
      email: user1Id,
      displayName: 'displayName',
      height: 180,
      goal: 'goal',
      weight: 80,
      dateOfBirth: DateTime(1990),
      gender: Gender.male,
      photoUrl: 'photoUrl',
      isNewUser: false,
    );

    final userProfile2 = UserProfile(
      email: user2Id,
      displayName: 'displayName',
      height: 160,
      goal: 'goal',
      weight: 80,
      dateOfBirth: DateTime(1990),
      gender: Gender.female,
      photoUrl: 'photoUrl',
      isNewUser: false,
    );

    setUp(() {
      apiClient = MockApiClient();
      resource = MockUserProfileResource();

      when(() => apiClient.userProfileResource).thenReturn(resource);
    });

    group('userProfile', () {
      test(
          'emits UserProfileStreamFailure if user profile stream '
          'throws an error', () {
        final repository = UserProfileRepository(apiClient);
        final userProfileController = StreamController<UserProfile>();

        when(() => resource.userProfile(user1Id)).thenAnswer(
          (_) => userProfileController.stream,
        );

        expectLater(
          repository.userProfile(user1Id),
          emitsInOrder(
            <dynamic>[
              emits(UserProfile.empty),
              emitsError(isA<UserProfileStreamFailure>()),
            ],
          ),
        );

        userProfileController.addError(Exception());
      });

      test('is cached when called with the same user identifier', () async {
        final repository = UserProfileRepository(apiClient);

        final userProfileController1 = BehaviorSubject.seeded(userProfile1);
        final userProfileController2 = BehaviorSubject.seeded(userProfile2);

        when(() => resource.userProfile(user1Id)).thenAnswer(
          (_) => userProfileController1.stream,
        );
        when(() => resource.userProfile(user2Id)).thenAnswer(
          (_) => userProfileController2.stream,
        );

        final userProfile1Stream1 = repository.userProfile(user1Id);

        await expectLater(
          userProfile1Stream1,
          emitsInOrder(<dynamic>[
            emits(UserProfile.empty),
            emits(userProfile1),
          ]),
        );

        final userProfile1Stream2 = repository.userProfile(user1Id);
        await expectLater(
          userProfile1Stream2,
          emitsInOrder(<dynamic>[
            emits(userProfile1),
          ]),
        );

        expect(userProfile1Stream1, equals(userProfile1Stream2));

        final userProfile2Stream1 = repository.userProfile(user2Id);
        await expectLater(
          userProfile2Stream1,
          emitsInOrder(<dynamic>[
            emits(UserProfile.empty),
            emits(userProfile2),
          ]),
        );

        final userProfile2Stream2 = repository.userProfile(user2Id);
        await expectLater(
          userProfile2Stream1,
          emitsInOrder(<dynamic>[
            emits(userProfile2),
          ]),
        );

        expect(userProfile2Stream1, equals(userProfile2Stream2));
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
