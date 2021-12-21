import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/app/app.dart';

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

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    AppBloc? appBloc,
  }) async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: appBloc ?? MockAppBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: widgetUnderTest,
          ),
        ),
      ),
    );
    await pump();
  }
}
