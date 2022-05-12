import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension AppWidgetTester on WidgetTester {
  Future<void> pumpIt(
    Widget widget, {
    ThemeData? theme,
  }) async {
    await pumpWidget(
      MaterialApp(
        theme: theme ?? AppTheme.lightTheme,
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }
}
