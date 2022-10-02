import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/app_gallery/screens/screens.dart';
import 'package:app_ui/src/app_gallery/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template app_gallery}
/// Demo app for the app_ui package.
/// {@endtemplate}
class AppGallery extends StatelessWidget {
  /// {@macro app_gallery}
  const AppGallery({Key? key}) : super(key: key);

  static const Map<String, Widget> _tileTitles = {
    'Colors': ColorsScreen(),
    'Typography': TypographyScreen(),
    'Spacings': SpacingsScreen(),
    'Widgets': WidgetsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gallery',
          ),
        ),
        body: const ListScreen(
          tileTitles: _tileTitles,
        ),
      ),
    );
  }
}
