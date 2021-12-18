import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'widget_screens/widget_screens.dart';

class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({Key? key}) : super(key: key);

  static const Map<String, Widget> _tileTitles = {
    'AppBottomNavigationBar': AppBottomNavigationBarScreen(),
    'App Buttons': AppButtonsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets'),
      ),
      body: const ListScreen(
        tileTitles: _tileTitles,
      ),
    );
  }
}
