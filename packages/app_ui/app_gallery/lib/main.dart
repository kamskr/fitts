import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gallery',
          ),
        ),
        body: const ListScreen(),
      ),
    );
  }
}
