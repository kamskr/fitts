import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_stats_repository/user_stats_repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockUserStatsResource extends Mock implements UserStatsResource {}

class MockUserStats extends Mock implements UserStats {}

void main() {
  group('UserStatsRepository', () {
    late ApiClient apiClient;
    late AuthenticationClient authenticationClient;

    late UserStatsResource resource;
    late UserStats userStats;

    const user1Id = '1';

    final userSubject = BehaviorSubject<User>()
      ..add(
        const User(id: user1Id),
      );

    setUp(() {
      apiClient = MockApiClient();
      authenticationClient = MockAuthenticationClient();
      resource = MockUserStatsResource();
      userStats = MockUserStats();

      when(() => apiClient.userStatsResource).thenReturn(resource);
      when(() => resource.userStats(any()))
          .thenAnswer((_) => const Stream<UserStats?>.empty());
      when(() => authenticationClient.user)
          .thenAnswer((_) => userSubject.stream);
    });

    test('can be instantiated', () {
      expect(
        UserStatsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        ),
        isNotNull,
      );
    });

    group('userStats', () {
      test(
          'reports UserStatsStreamFailure '
          'when user stars stream reports an error', () {
        final repository = UserStatsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        );
        final userStatsController = StreamController<UserStats>();
        when(() => resource.userStats(any())).thenAnswer(
          (_) => userStatsController.stream,
        );

        userStatsController.addError(Exception());

        expectLater(
          repository.userStats,
          emitsError(isA<UserStatsStreamFailure>()),
        );
      });

      test('is cached when called with the same user identifier', () async {
        final repository = UserStatsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        );

        final stream1 = repository.userStats;
        final stream2 = repository.userStats;

        expect(stream1, equals(stream2));
      });
    });
    group('updateUserStats', () {
      test(
          'reports UserStatsStreamFailure '
          'when failed to update user stats', () {
        final repository = UserStatsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        );
        when(
          () => resource.updateUserStats(
            userId: 'userId',
            payload: userStats,
          ),
        ).thenThrow(ApiException);

        expect(
          () => repository.updateUserStats(
            payload: userStats,
          ),
          throwsA(isA<UpdateUserStatsFailure>()),
        );
      });

      test('can update without error', () async {
        final repository = UserStatsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        );
        expect(
          () => repository.updateUserStats(
            payload: userStats,
          ),
          isNot(isException),
        );
      });
    });
  });
}
