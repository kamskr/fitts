// ignore_for_file: unused_field

import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template api_client}
/// A client to retrieve information from API.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  ApiClient({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  /// {@macro user_profile_resource}
  late final UserProfileResource userProfileResource = UserProfileResource(
    _firebaseFirestore,
  );

  /// {@macro user_stats_resource}
  late final UserStatsResource userStatsResource = UserStatsResource(
    _firebaseFirestore,
  );

  /// {@macro user_stats_resource}
  late final ExerciseResource exerciseResource = ExerciseResource(
    _firebaseFirestore,
  );

  /// {@macro workout_templates_resource}
  late final WorkoutTemplatesResource workoutTemplatesResource =
      WorkoutTemplatesResource(
    _firebaseFirestore,
  );

  /// {@macro workout_logs_resource}
  late final WorkoutLogsResource workoutLogsResource = WorkoutLogsResource(
    _firebaseFirestore,
  );
}
