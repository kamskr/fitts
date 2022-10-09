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
  Map<String, BehaviorSubject<WorkoutTemplate?>> _workoutTemplatesSubjectMap =
      {};

  BehaviorSubject<List<WorkoutLog>?>? _workoutLogsSubject;
  Map<String, BehaviorSubject<WorkoutLog?>> _workoutLogsSubjectMap = {};

  /// Returns a stream of workout templates for a given user id.
  /// Currently user can only access his own templates.
  Stream<List<WorkoutTemplate>?> getWorkoutTemplates(String userId) {
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
    required String userId,
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
          .handleError(_handleWorkoutTemplateStreamError)
          .listen(workoutTemplateSubject.add);

      _workoutTemplatesSubjectMap[workoutTemplateId] = workoutTemplateSubject;
    }
    return _workoutTemplatesSubjectMap[workoutTemplateId]!.stream;
  }

  void _handleWorkoutTemplateStreamError(Object error, StackTrace stackTrace) {
    _workoutTemplatesSubject
        ?.addError(WorkoutTemplateStreamFailure(error, stackTrace));
  }

  /// Creates workout template for a given user id.
  /// Currently user can only create his own templates.
  Future<void> createWorkoutTemplate({
    required String userId,
    required WorkoutTemplate workoutTemplate,
  }) async {
    final workoutTemplatesResource = _apiClient.workoutTemplatesResource;
    await workoutTemplatesResource.createUserWorkoutTemplate(
      userId: userId,
      payload: workoutTemplate,
    );
  }

  /// Updates workout template for a given user id and workout template id.
  /// Currently user can only update his own templates.
  Future<void> updateWorkoutTemplate({
    required String userId,
    required String workoutTemplateId,
    required WorkoutTemplate workoutTemplate,
  }) async {
    final workoutTemplatesResource = _apiClient.workoutTemplatesResource;
    await workoutTemplatesResource.updateUserWorkoutTemplate(
      userId: userId,
      workoutTemplateId: workoutTemplateId,
      payload: workoutTemplate,
    );
  }

  /// Deletes workout template for a given user id and workout template id.
  /// Currently user can only delete his own templates.
  Future<void> deleteWorkoutTemplate({
    required String userId,
    required String workoutTemplateId,
  }) async {
    final workoutTemplatesResource = _apiClient.workoutTemplatesResource;
    await workoutTemplatesResource.deleteUserWorkoutTemplate(
      userId: userId,
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
    _workoutTemplatesSubject
        ?.addError(WorkoutTemplatesStreamFailure(error, stackTrace));
  }

  /// Stream workout log by id.
  Stream<WorkoutLog?> getWorkoutLogById({
    required String userId,
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
          .handleError(_handleWorkoutLogStreamError)
          .listen(workoutLogSubject.add);

      _workoutLogsSubjectMap[workoutLogId] = workoutLogSubject;
    }
    return _workoutLogsSubjectMap[workoutLogId]!.stream;
  }

  void _handleWorkoutLogStreamError(Object error, StackTrace stackTrace) {
    _workoutLogsSubject?.addError(WorkoutLogStreamFailure(error, stackTrace));
  }

  /// Create workout log and update related workout template.
  Future<void> createWorkoutLog({
    required String userId,
    required WorkoutLog workoutLog,
  }) async {
    final workoutLogsResource = _apiClient.workoutLogsResource;
    await workoutLogsResource.createUserWorkoutLog(
      userId: userId,
      payload: workoutLog,
    );
  }

  /// Update workout log and update related workout template.
  /// Currently user can only update his own workout logs.
  Future<void> updateWorkoutLog({
    required String userId,
    required String workoutLogId,
    required WorkoutLog workoutLog,
  }) async {
    final workoutLogsResource = _apiClient.workoutLogsResource;
    await workoutLogsResource.updateUserWorkoutLog(
      userId: userId,
      workoutLogId: workoutLogId,
      payload: workoutLog,
    );
  }

  /// Delete workout log and update related workout template.
  /// Currently user can only delete his own workout logs.
  Future<void> deleteWorkoutLog({
    required String userId,
    required String workoutLogId,
  }) async {
    final workoutLogsResource = _apiClient.workoutLogsResource;
    await workoutLogsResource.deleteUserWorkoutLog(
      userId: userId,
      workoutLogId: workoutLogId,
    );
  }
}
