import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'widgets/list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const Map<String, Widget> _tileTitles = {
    'Colors': ColorsScreen(),
    'Typography': TypographyScreen(),
    'Spacings': SpacingsScreen(),
    'Widgets': WidgetsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemeFactory.lightTheme.materialThemeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gallery',
          ),
        ),
        body: const ListScreen(
          tileTitles: _tileTitles,
        ),
      ),
    );
  }
}
