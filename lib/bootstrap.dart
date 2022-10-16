import 'package:api_client/api_client.dart';
import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercises_repository/exercises_repository.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_repository/user_profile_repository.dart';
import 'package:user_stats_repository/user_stats_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template bootstrap}
/// Bootstrap method used for generating all global providers and DI.
/// {@endtemplate}
Future<Widget> bootstrap() async {
  final firestore = FirebaseFirestore.instance;

  final _authenticationClient = AuthenticationClient();
  final _apiClient = ApiClient(firebaseFirestore: firestore);
  final _exercisesRepository = ExercisesRepository(apiClient: _apiClient);

  final lightThemeData = AppTheme.lightTheme;

  // Preload all exercises at start time.
  await _exercisesRepository.getExercises();

  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: _authenticationClient),
      RepositoryProvider(
        create: (_) => UserProfileRepository(_apiClient),
      ),
      RepositoryProvider(
        create: (_) => UserStatsRepository(
          apiClient: _apiClient,
          authenticationClient: _authenticationClient,
        ),
      ),
      RepositoryProvider(
        create: (_) => WorkoutsRepository(
          apiClient: _apiClient,
          authenticationClient: _authenticationClient,
        ),
      ),
    ],
    child: App(
      lightThemeData: lightThemeData,
    ),
  );
}
