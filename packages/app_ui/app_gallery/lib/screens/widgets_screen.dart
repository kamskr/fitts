import 'package:app_gallery/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widget_screens/widget_screens.dart';

class WidgetsScreen extends StatefulWidget {
  const WidgetsScreen({Key? key}) : super(key: key);

  @override
  State<WidgetsScreen> createState() => _WidgetsScreenState();
}

class _WidgetsScreenState extends State<WidgetsScreen> {
  int currentIndex = 0;

  static const Map<String, Widget> _tileTitles = {
    'AppBottomNavigationBar': AppBottomNavigationBarScreen(),
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
