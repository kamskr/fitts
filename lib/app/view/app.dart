import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout tracker',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PRFit'),
        ),
        body: const Center(
          child: Text('Setup'),
        ),
      ),
    );
  }
}
