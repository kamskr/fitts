import 'package:flutter/material.dart';

import 'screens/screens.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  static const Map<String, Widget> _tileTitles = {
    'Colors': ColorsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: _tileTitles.entries
            .map(
              (entry) => ListTile(
                onTap: () => Navigator.of(context).push<MaterialPageRoute>(
                  MaterialPageRoute(
                    builder: (context) => entry.value,
                  ),
                ),
                title: Text(entry.key),
              ),
            )
            .toList(),
      ),
    );
  }
}
