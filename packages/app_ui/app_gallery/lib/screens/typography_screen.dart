import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppTypography'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Text(
              'title1',
              style: AppTypography.title1,
            ),
            Text(
              'title2',
              style: AppTypography.title2,
            ),
            Text(
              'title3',
              style: AppTypography.title3,
            ),
            Text(
              'title4',
              style: AppTypography.title4,
            ),
            Text(
              'title5',
              style: AppTypography.title5,
            ),
            Text(
              'headline',
              style: AppTypography.headline,
            ),
            Text(
              'body',
              style: AppTypography.body,
            ),
            Text(
              'subhead',
              style: AppTypography.subhead,
            ),
            Text(
              'footnote',
              style: AppTypography.footnote,
            ),
            Text(
              'caption1',
              style: AppTypography.caption1,
            ),
            Text(
              'caption2',
              style: AppTypography.caption2,
            ),
          ],
        ),
      ),
    );
  }
}
