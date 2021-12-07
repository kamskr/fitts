import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets')),
      bottomNavigationBar: const AppBottomNavigationBar(
          menuItems: ['Test', 'Test2'], onTap: print),
      body: ListView(children: const [
        Text('Widgets'),
      ]),
    );
  }
}
