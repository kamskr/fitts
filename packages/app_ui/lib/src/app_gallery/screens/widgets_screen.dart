// ignore_for_file: public_member_api_docs
import 'package:app_ui/src/app_gallery/screens/widget_screens/widget_screens.dart';
import 'package:app_ui/src/app_gallery/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({Key? key}) : super(key: key);

  static const Map<String, Widget> _tileTitles = {
    'AppBottomNavigationBar': AppBottomNavigationBarScreen(),
    'App Buttons': AppButtonsScreen(),
    'App Form Fields': AppFormFields(),
    'App SnackBar': AppSnackBarScreen(),
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
