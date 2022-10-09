import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workouts_repository/workouts_repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockWorkoutTemplatesResource extends Mock
    implements WorkoutTemplatesResource {}

class MockWorkoutLogsResource extends Mock implements WorkoutLogsResource {}

class MockWorkoutTemplate extends Mock implements WorkoutTemplate {}

class MockWorkoutLog extends Mock implements WorkoutLog {}

class MockUser extends Mock implements User {
  @override
  String get id => 'id';

  @override
  String get email => 'email';
}

void main() {
  group('WorkoutsRepository', () {
    late ApiClient apiClient;
    late AuthenticationClient authenticationClient;

    late WorkoutTemplatesResource workoutTemplatesResource;
    late WorkoutLogsResource workoutLogsResource;
    late WorkoutTemplate workoutTemplate;
    late WorkoutLog workoutLog;

    late User user;

    const userId = 'email';
    const workoutTemplateId = 'workoutTemplateId';
    const workoutLogId = 'workoutLogId';

    setUp(() {
      apiClient = MockApiClient();
      authenticationClient = MockAuthenticationClient();
      workoutTemplatesResource = MockWorkoutTemplatesResource();
      workoutLogsResource = MockWorkoutLogsResource();
      workoutTemplate = MockWorkoutTemplate();
      workoutLog = MockWorkoutLog();

      user = MockUser();

      when(() => apiClient.workoutTemplatesResource)
          .thenReturn(workoutTemplatesResource);
      when(() => apiClient.workoutLogsResource).thenReturn(workoutLogsResource);
      when(() => workoutTemplatesResource.getUserWorkoutTemplates(any()))
          .thenAnswer((_) => Stream.value([workoutTemplate]));

      when(
        () => workoutTemplatesResource.getUserWorkoutTemplateById(
          userId: userId,
          workoutTemplateId: workoutTemplateId,
        ),
      ).thenAnswer((_) => Stream.value(workoutTemplate));

      when(() => workoutLogsResource.getUserWorkoutLogs(any()))
          .thenAnswer((_) => Stream.value([workoutLog]));

      when(
        () => workoutLogsResource.getUserWorkoutLogById(
          userId: userId,
          workoutLogId: workoutLogId,
        ),
      ).thenAnswer((_) => Stream.value(workoutLog));

      when(() => authenticationClient.user)
          .thenAnswer((_) => Stream.value(user));
    });

    test('can be instantiated', () {
      expect(
        WorkoutsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        ),
        isNotNull,
      );
    });

    group('workout templates related methods', () {
      group('getWorkoutTemplates', () {
        test('returns correct stream subscription.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription = repository.getWorkoutTemplates();

          expect(subscription, isNotNull);
        });
        test('is cached when called on the same user identifier.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription1 = repository.getWorkoutTemplates();
          final subscription2 = repository.getWorkoutTemplates();

          expect(subscription1, subscription2);
        });
        test(
          'reports WorkoutTemplatesStreamFailure'
          ' when user workout templates stream reports an error.',
          () {
            final repository = WorkoutsRepository(
              apiClient: apiClient,
              authenticationClient: authenticationClient,
            );
            final workoutTemplatesController =
                StreamController<List<WorkoutTemplate>?>();

            when(() => workoutTemplatesResource.getUserWorkoutTemplates(any()))
                .thenAnswer(
              (_) => workoutTemplatesController.stream,
            );

            workoutTemplatesController.addError(Exception());

            expectLater(
              repository.getWorkoutTemplates(),
              emitsError(isA<WorkoutTemplatesStreamFailure>()),
            );
          },
        );
      });
      group('getWorkoutTemplateById', () {
        test('returns correct stream subscription.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription = repository.getWorkoutTemplateById(
            workoutTemplateId: workoutTemplateId,
          );

          expect(subscription, isNotNull);
        });
        test('is cached when called on the same user identifier.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription1 = repository.getWorkoutTemplateById(
            workoutTemplateId: workoutTemplateId,
          );
          final subscription2 = repository.getWorkoutTemplateById(
            workoutTemplateId: workoutTemplateId,
          );

          expect(subscription1, subscription2);
        });
        test(
          'reports WorkoutTemplateStreamFailure'
          ' when user workout template stream reports an error.',
          () {
            final workoutTemplateController =
                StreamController<WorkoutTemplate?>();

            when(
              () => workoutTemplatesResource.getUserWorkoutTemplateById(
                userId: userId,
                workoutTemplateId: workoutTemplateId,
              ),
            ).thenAnswer(
              (_) => workoutTemplateController.stream,
            );

            final repository = WorkoutsRepository(
              apiClient: apiClient,
              authenticationClient: authenticationClient,
            );

            workoutTemplateController.addError(Exception());

            expectLater(
              repository.getWorkoutTemplateById(
                workoutTemplateId: workoutTemplateId,
              ),
              emitsError(isA<WorkoutTemplateStreamFailure>()),
            );
          },
        );
      });

      group('createWorkoutTemplate', () {
        test('returns normally when successful.', () async {
          when(() => workoutTemplatesResource.createUserWorkoutTemplate(
                userId: userId,
                payload: workoutTemplate,
              )).thenAnswer((_) async => {});
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          await repository.createWorkoutTemplate(
            workoutTemplate: workoutTemplate,
          );
        });
        test('passes through error from API', () {
          when(() => workoutTemplatesResource.createUserWorkoutTemplate(
                userId: userId,
                payload: workoutTemplate,
              )).thenThrow(Exception());
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          expect(
            () => repository.createWorkoutTemplate(
              workoutTemplate: workoutTemplate,
            ),
            throwsException,
          );
        });
      });

      group('updateWorkoutTemplate', () {
        test('returns normally when successful.', () async {
          when(() => workoutTemplatesResource.updateUserWorkoutTemplate(
                userId: userId,
                workoutTemplateId: workoutTemplateId,
                payload: workoutTemplate,
              )).thenAnswer((_) async => {});
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          await repository.updateWorkoutTemplate(
            workoutTemplateId: workoutTemplateId,
            workoutTemplate: workoutTemplate,
          );
        });
        test('passes through error from API', () {
          when(() => workoutTemplatesResource.updateUserWorkoutTemplate(
                userId: userId,
                workoutTemplateId: workoutTemplateId,
                payload: workoutTemplate,
              )).thenThrow(Exception());
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          expect(
            () => repository.updateWorkoutTemplate(
              workoutTemplateId: workoutTemplateId,
              workoutTemplate: workoutTemplate,
            ),
            throwsException,
          );
        });
      });
    });

    group('deleteWorkoutTemplate', () {
      test('returns normally when successful.', () async {
        when(() => workoutTemplatesResource.deleteUserWorkoutTemplate(
              userId: userId,
              workoutTemplateId: workoutTemplateId,
            )).thenAnswer((_) async => {});
        final repository = WorkoutsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        );

        await repository.deleteWorkoutTemplate(
          workoutTemplateId: workoutTemplateId,
        );
      });
      test('passes through error from API', () {
        when(() => workoutTemplatesResource.deleteUserWorkoutTemplate(
              userId: userId,
              workoutTemplateId: workoutTemplateId,
            )).thenThrow(Exception());
        final repository = WorkoutsRepository(
          apiClient: apiClient,
          authenticationClient: authenticationClient,
        );

        expect(
          () => repository.deleteWorkoutTemplate(
            workoutTemplateId: workoutTemplateId,
          ),
          throwsException,
        );
      });
    });

    group('workout logs related methods', () {
      group('getWorkoutLogs', () {
        test('returns correct stream subscription.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription = repository.getWorkoutLogs();

          expect(subscription, isNotNull);
        });
        test('is cached when called on the same user identifier.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription1 = repository.getWorkoutLogs();
          final subscription2 = repository.getWorkoutLogs();

          expect(subscription1, subscription2);
        });
        test(
          'reports WorkoutLogsStreamFailure'
          ' when user workout logs stream reports an error.',
          () {
            final repository = WorkoutsRepository(
              apiClient: apiClient,
              authenticationClient: authenticationClient,
            );
            final workoutLogsController = StreamController<List<WorkoutLog>?>();

            when(() => workoutLogsResource.getUserWorkoutLogs(any()))
                .thenAnswer(
              (_) => workoutLogsController.stream,
            );

            workoutLogsController.addError(Exception());

            expectLater(
              repository.getWorkoutLogs(),
              emitsError(isA<WorkoutLogsStreamFailure>()),
            );
          },
        );
      });
      group('getWorkoutLogById', () {
        test('returns correct stream subscription.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription = repository.getWorkoutLogById(
            workoutLogId: workoutLogId,
          );

          expect(subscription, isNotNull);
        });
        test('is cached when called on the same user identifier.', () {
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          final subscription1 = repository.getWorkoutLogById(
            workoutLogId: workoutLogId,
          );
          final subscription2 = repository.getWorkoutLogById(
            workoutLogId: workoutLogId,
          );

          expect(subscription1, subscription2);
        });

        test(
          'reports WorkoutLogStreamFailure'
          ' when user workout log stream reports an error.',
          () {
            final workoutLogController = StreamController<WorkoutLog?>();

            when(
              () => workoutLogsResource.getUserWorkoutLogById(
                userId: userId,
                workoutLogId: workoutLogId,
              ),
            ).thenAnswer(
              (_) => workoutLogController.stream,
            );

            final repository = WorkoutsRepository(
              apiClient: apiClient,
              authenticationClient: authenticationClient,
            );

            workoutLogController.addError(Exception());

            expectLater(
              repository.getWorkoutLogById(
                workoutLogId: workoutLogId,
              ),
              emitsError(isA<WorkoutLogStreamFailure>()),
            );
          },
        );
      });

      group('createWorkoutLog', () {
        test('returns normally when successful.', () async {
          when(() => workoutLogsResource.createUserWorkoutLog(
                userId: userId,
                payload: workoutLog,
              )).thenAnswer((_) async => {});
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          await repository.createWorkoutLog(workoutLog: workoutLog);
        });
        test('passes through error from API', () {
          when(() => workoutLogsResource.createUserWorkoutLog(
                userId: userId,
                payload: workoutLog,
              )).thenThrow(Exception());
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          expect(
            () => repository.createWorkoutLog(workoutLog: workoutLog),
            throwsException,
          );
        });
      });

      group('updateWorkoutLog', () {
        test('returns normally when successful.', () async {
          when(() => workoutLogsResource.updateUserWorkoutLog(
                userId: userId,
                workoutLogId: workoutLogId,
                payload: workoutLog,
              )).thenAnswer((_) async => {});
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          await repository.updateWorkoutLog(
            workoutLogId: workoutLogId,
            workoutLog: workoutLog,
          );
        });
        test('passes through error from API', () {
          when(() => workoutLogsResource.updateUserWorkoutLog(
                userId: userId,
                workoutLogId: workoutLogId,
                payload: workoutLog,
              )).thenThrow(Exception());
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          expect(
            () => repository.updateWorkoutLog(
              workoutLogId: workoutLogId,
              workoutLog: workoutLog,
            ),
            throwsException,
          );
        });
      });

      group('deleteWorkoutLog', () {
        test('returns normally when successful.', () async {
          when(() => workoutLogsResource.deleteUserWorkoutLog(
                userId: userId,
                workoutLogId: workoutLogId,
              )).thenAnswer((_) async => {});
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          await repository.deleteWorkoutLog(
            workoutLogId: workoutLogId,
          );
        });
        test('passes through error from API', () {
          when(() => workoutLogsResource.deleteUserWorkoutLog(
                userId: userId,
                workoutLogId: workoutLogId,
              )).thenThrow(Exception());
          final repository = WorkoutsRepository(
            apiClient: apiClient,
            authenticationClient: authenticationClient,
          );

          expect(
            () => repository.deleteWorkoutLog(
              workoutLogId: workoutLogId,
            ),
            throwsException,
          );
        });
      });
    });
  });
}
