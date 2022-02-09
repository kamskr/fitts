import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/app/app.dart';
import 'package:prfit/l10n/l10n.dart';

class FakeAppState extends Fake implements AppState {}

class FakeAppEvent extends Fake implements AppEvent {}

void registerFallbackValues() {
  registerFallbackValue(FakeAppEvent());
  registerFallbackValue(FakeAppState());
}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {
  @override
  AppState get state => const AppState.unauthenticated();
}

class MockAuthenticationClient extends Mock implements AuthenticationClient {
  @override
  Stream<User> get user => Stream.value(User.empty);
}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    AppBloc? appBloc,
    AuthenticationClient? authenticationClient,
  }) async {
    await pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: authenticationClient ?? MockAuthenticationClient(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: appBloc ?? MockAppBloc(),
            ),
          ],
          child: MaterialApp(
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
