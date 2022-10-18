// ignore_for_file: public_member_api_docs, strict_raw_type
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({required this.tileTitles, Key? key}) : super(key: key);

  final Map<String, Widget> tileTitles;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: tileTitles.entries
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
