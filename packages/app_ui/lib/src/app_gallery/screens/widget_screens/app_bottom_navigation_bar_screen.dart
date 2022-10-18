// ignore_for_file: public_member_api_docs

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBarScreen extends StatefulWidget {
  const AppBottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<AppBottomNavigationBarScreen> createState() =>
      _AppBottomNavigationBarScreenState();
}

class _AppBottomNavigationBarScreenState
    extends State<AppBottomNavigationBarScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBottomNavigationBar'),
      ),
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
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
