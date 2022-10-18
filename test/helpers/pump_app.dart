import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_profile_repository/user_profile_repository.dart';
import 'package:user_stats_repository/user_stats_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

class FakeAppState extends Fake implements AppState {}

class FakeAppEvent extends Fake implements AppEvent {}

void registerFallbackValues() {
  registerFallbackValue(FakeAppEvent());
  registerFallbackValue(FakeAppState());
}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {
  @override
  AppState get state => AppState.initial(
        userProfile: UserProfile.empty,
      );
}

class MockHomeBloc extends Mock implements HomeBloc {}

class MockAuthenticationClient extends Mock implements AuthenticationClient {
  @override
  Stream<User> get user => Stream.value(User.empty);
}

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

class MockUserStatsRepository extends Mock implements UserStatsRepository {
  @override
  Stream<UserStats> get userStats => Stream.value(UserStats.empty);
}

class MockWorkoutsRepository extends Mock implements WorkoutsRepository {}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    AppBloc? appBloc,
    HomeBloc? homeBloc,
    AuthenticationClient? authenticationClient,
    UserProfileRepository? userProfileRepository,
    UserStatsRepository? userStatsRepository,
    MockWorkoutsRepository? workoutsRepository,
  }) async {
    await pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: authenticationClient ?? MockAuthenticationClient(),
          ),
          RepositoryProvider.value(
            value: userProfileRepository ?? MockUserProfileRepository(),
          ),
          RepositoryProvider.value(
            value: userStatsRepository ?? MockUserStatsRepository(),
          ),
          RepositoryProvider.value(
            value: workoutsRepository ?? MockWorkoutsRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: appBloc ?? MockAppBloc(),
            ),
            BlocProvider.value(
              value: homeBloc ?? MockHomeBloc(),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Scaffold(
              body: widgetUnderTest,
            ),
          ),
        ),
      ),
    );
    await pump();
  }
}
