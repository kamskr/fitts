import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prfit/app/app.dart';

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    required AppBloc appBloc,
  }) async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: appBloc,
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
