import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class WidgetsScreen extends StatefulWidget {
  const WidgetsScreen({Key? key}) : super(key: key);

  @override
  State<WidgetsScreen> createState() => _WidgetsScreenState();
}

class _WidgetsScreenState extends State<WidgetsScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets')),
      bottomNavigationBar: AppBottomNavigationBar(
        menuItems: const [
          AppMenuItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          AppMenuItem(
            icon: Icon(Icons.query_stats),
            label: 'Stats',
          ),
          AppMenuItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          AppMenuItem(
            icon: Icon(Icons.note_add_outlined),
            label: 'Notes',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: ListView(children: const [
        Text('Widgets'),
      ]),
    );
  }
}
