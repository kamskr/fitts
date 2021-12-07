import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppColors'),
      ),
      body: ListView(
        children: <Widget>[
          const ColorTitle('primary'),
        ],
      ),
    );
  }
}
