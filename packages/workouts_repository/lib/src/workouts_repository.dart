import 'package:api_client/api_client.dart';
import 'package:app_models/app_models.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template workouts_repository}
/// Repository which exposes workout related resources.
/// {@endtemplate}
class WorkoutsRepository {
  /// {@macro workouts_repository}
  WorkoutsRepository({
    required ApiClient apiClient,
    required AuthenticationClient authenticationClient,
  })  : _apiClient = apiClient,
        _authenticationClient = authenticationClient;

  final ApiClient _apiClient;
  final AuthenticationClient _authenticationClient;

  BehaviorSubject<List<WorkoutTemplate>?>? _workoutTemplatesSubject;
  final Map<String, BehaviorSubject<WorkoutTemplate?>>
      _workoutTemplatesSubjectMap = {};

  BehaviorSubject<List<WorkoutLog>?>? _workoutLogsSubject;
  final Map<String, BehaviorSubject<WorkoutLog?>> _workoutLogsSubjectMap = {};

  /// Returns a stream of workout templates for a given user id.
  /// Currently user can only access his own templates.
  Stream<List<WorkoutTemplate>?> getWorkoutTemplates() {
    if (_workoutTemplatesSubject == null) {
      _workoutTemplatesSubject = BehaviorSubject();

      final workoutTemplatesResource = _apiClient.workoutTemplatesResource;

      final workoutTemplatesStream = _authenticationClient.user
          .distinct((user1, user2) => user1.id == user2.id)
          .switchMap(
            (user) => workoutTemplatesResource.getUserWorkoutTemplates(
              user.email!,
            ),
          );

      workoutTemplatesStream
          .handleError(_handleWorkoutTemplatesStreamError)
          .listen(_workoutTemplatesSubject!.add);
    }
    return _workoutTemplatesSubject!.stream;
  }

  void _handleWorkoutTemplatesStreamError(Object error, StackTrace stackTrace) {
    _workoutTemplatesSubject
        ?.addError(WorkoutTemplatesStreamFailure(error, stackTrace));
  }

  /// Returns a stream of workout template for a given user id and workout
  /// template id.
  /// Currently user can only access his own templates.
  Stream<WorkoutTemplate?> getWorkoutTemplateById({
    required String workoutTemplateId,
  }) {
    if (!_workoutTemplatesSubjectMap.containsKey(workoutTemplateId)) {
      final workoutTemplatesResource = _apiClient.workoutTemplatesResource;

      final workoutTemplateStream = _authenticationClient.user
          .distinct((user1, user2) => user1.id == user2.id)
          .switchMap(
            (user) => workoutTemplatesResource.getUserWorkoutTemplateById(
              userId: user.email!,
              workoutTemplateId: workoutTemplateId,
            ),
          );

      final workoutTemplateSubject = BehaviorSubject<WorkoutTemplate?>();

      workoutTemplateStream
          .handleError(
            (Object e, StackTrace st) => _handleWorkoutTemplateStreamError(
              workoutTemplateId,
              e,
              st,
            ),
          )
          .listen(workoutTemplateSubject.add);

      _workoutTemplatesSubjectMap[workoutTemplateId] = workoutTemplateSubject;
    }
    return _workoutTemplatesSubjectMap[workoutTemplateId]!.stream;
  }

  void _handleWorkoutTemplateStreamError(
    String workoutTemplateId,
    Object error,
    StackTrace stackTrace,
  ) {
    _workoutTemplatesSubjectMap[workoutTemplateId]
        ?.addError(WorkoutTemplateStreamFailure(error, stackTrace));
  }

  /// Creates workout template for a given user id.
  /// Currently user can only create his own templates.
  Future<void> createWorkoutTemplate({
    required WorkoutTemplate workoutTemplate,
  }) async {
    final user = await _authenticationClient.user.first;

    final workoutTemplatesResource = _apiClient.workoutTemplatesResource;
    await workoutTemplatesResource.createUserWorkoutTemplate(
      userId: user.email!,
      payload: workoutTemplate,
    );
  }

  /// Updates workout template for a given user id and workout template id.
  /// Currently user can only update his own templates.
  Future<void> updateWorkoutTemplate({
    required String workoutTemplateId,
    required WorkoutTemplate workoutTemplate,
  }) async {
    final user = await _authenticationClient.user.first;

    final workoutTemplatesResource = _apiClient.workoutTemplatesResource;
    await workoutTemplatesResource.updateUserWorkoutTemplate(
      userId: user.email!,
      workoutTemplateId: workoutTemplateId,
      payload: workoutTemplate,
    );
  }

  /// Deletes workout template for a given user id and workout template id.
  /// Currently user can only delete his own templates.
  Future<void> deleteWorkoutTemplate({
    required String workoutTemplateId,
  }) async {
    final user = await _authenticationClient.user.first;
    final workoutTemplatesResource = _apiClient.workoutTemplatesResource;

    await workoutTemplatesResource.deleteUserWorkoutTemplate(
      userId: user.email!,
      workoutTemplateId: workoutTemplateId,
    );
  }

  /// Stream all workout logs.
  Stream<List<WorkoutLog>?> getWorkoutLogs() {
    if (_workoutLogsSubject == null) {
      _workoutLogsSubject = BehaviorSubject();

      final workoutLogsResource = _apiClient.workoutLogsResource;

      final workoutLogsStream = _authenticationClient.user
          .distinct((user1, user2) => user1.id == user2.id)
          .switchMap(
            (user) => workoutLogsResource.getUserWorkoutLogs(
              user.email!,
            ),
          );

      workoutLogsStream
          .handleError(_handleWorkoutLogsStreamError)
          .listen(_workoutLogsSubject!.add);
    }
    return _workoutLogsSubject!.stream;
  }

  void _handleWorkoutLogsStreamError(Object error, StackTrace stackTrace) {
    _workoutLogsSubject?.addError(WorkoutLogsStreamFailure(error, stackTrace));
  }

  /// Stream workout log by id.
  Stream<WorkoutLog?> getWorkoutLogById({
    required String workoutLogId,
  }) {
    if (!_workoutLogsSubjectMap.containsKey(workoutLogId)) {
      final workoutLogsResource = _apiClient.workoutLogsResource;

      final workoutLogStream = _authenticationClient.user
          .distinct((user1, user2) => user1.id == user2.id)
          .switchMap(
            (user) => workoutLogsResource.getUserWorkoutLogById(
              userId: user.email!,
              workoutLogId: workoutLogId,
            ),
          );

      final workoutLogSubject = BehaviorSubject<WorkoutLog?>();

      workoutLogStream
          .handleError(
            (Object e, StackTrace st) =>
                _handleWorkoutLogStreamError(workoutLogId, e, st),
          )
          .listen(workoutLogSubject.add);

      _workoutLogsSubjectMap[workoutLogId] = workoutLogSubject;
    }
    return _workoutLogsSubjectMap[workoutLogId]!.stream;
  }

  void _handleWorkoutLogStreamError(
    String workoutLogId,
    Object error,
    StackTrace stackTrace,
  ) {
    _workoutLogsSubjectMap[workoutLogId]
        ?.addError(WorkoutLogStreamFailure(error, stackTrace));
  }

  /// Create workout log and update related workout template.
  Future<void> createWorkoutLog({
    required WorkoutLog workoutLog,
  }) async {
    final user = await _authenticationClient.user.first;

    final workoutLogsResource = _apiClient.workoutLogsResource;
    await workoutLogsResource.createUserWorkoutLog(
      userId: user.email!,
      payload: workoutLog,
    );
  }

  /// Update workout log and update related workout template.
  /// Currently user can only update his own workout logs.
  Future<void> updateWorkoutLog({
    required String workoutLogId,
    required WorkoutLog workoutLog,
  }) async {
    final user = await _authenticationClient.user.first;

    final workoutLogsResource = _apiClient.workoutLogsResource;
    await workoutLogsResource.updateUserWorkoutLog(
      userId: user.email!,
      workoutLogId: workoutLogId,
      payload: workoutLog,
    );
  }

  /// Delete workout log and update related workout template.
  /// Currently user can only delete his own workout logs.
  Future<void> deleteWorkoutLog({
    required String workoutLogId,
  }) async {
    final user = await _authenticationClient.user.first;
    final workoutLogsResource = _apiClient.workoutLogsResource;

    await workoutLogsResource.deleteUserWorkoutLog(
      userId: user.email!,
      workoutLogId: workoutLogId,
    );
  }
}
