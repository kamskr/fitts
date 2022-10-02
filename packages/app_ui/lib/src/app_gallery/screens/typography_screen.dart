// ignore_for_file: public_member_api_docs
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
      body: ListView(
        children: [
          Text(
            'headline1',
            style: AppTypography.headline1,
          ),
          Text(
            'headline2',
            style: AppTypography.headline2,
          ),
          Text(
            'headline3',
            style: AppTypography.headline3,
          ),
          Text(
            'headline4',
            style: AppTypography.headline4,
          ),
          Text(
            'headline5',
            style: AppTypography.headline5,
          ),
          Text(
            'headline6',
            style: AppTypography.headline6,
          ),
          Text(
            'subtitle1',
            style: AppTypography.subtitle1,
          ),
          Text(
            'subtitle2',
            style: AppTypography.subtitle2,
          ),
          Text(
            'body1',
            style: AppTypography.body1,
          ),
          Text(
            'body2',
            style: AppTypography.body2,
          ),
          Text(
            'button',
            style: AppTypography.button,
          ),
          Text(
            'caption',
            style: AppTypography.caption,
          ),
          Text(
            'overline',
            style: AppTypography.overline,
          ),
        ],
      ),
    );
  }
}
