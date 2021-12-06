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
          const ColorDisplay(
            title: 'AppColors.primary',
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
          ),
          ColorDisplay(
            title: 'AppColors.primary[50]',
            decoration: BoxDecoration(
              color: AppColors.primary[50],
            ),
          ),
          ColorDisplay(
            title: 'AppColors.primary[400]',
            decoration: BoxDecoration(
              color: AppColors.primary[400],
            ),
          ),
          ColorDisplay(
            title: 'AppColors.primary[900]',
            decoration: BoxDecoration(
              color: AppColors.primary[900],
            ),
          ),
          const ColorTitle('accent'),
          const ColorDisplay(
            title: 'AppColors.accent',
            decoration: BoxDecoration(
              color: AppColors.accent,
            ),
          ),
          ColorDisplay(
            title: 'AppColors.accent[300]',
            decoration: BoxDecoration(
              color: AppColors.accent[300],
            ),
          ),
          ColorDisplay(
            title: 'AppColors.accent[900]',
            decoration: BoxDecoration(
              color: AppColors.accent[900],
            ),
          ),
          const ColorTitle('secondaryAccent'),
          const ColorDisplay(
            title: 'AppColors.accent',
            decoration: BoxDecoration(
              color: AppColors.secondaryAccent,
            ),
          ),
          ColorDisplay(
            title: 'AppColors.accent[400]',
            decoration: BoxDecoration(
              color: AppColors.secondaryAccent[400],
            ),
          ),
          const ColorTitle('white'),
          ColorDisplay(
            title: 'AppColors.white',
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(),
            ),
          ),
          const ColorTitle('black'),
          const ColorDisplay(
            title: 'AppColors.black',
            decoration: BoxDecoration(
              color: AppColors.black,
            ),
          ),
          ColorDisplay(
            title: 'AppColors.black[50]',
            decoration: BoxDecoration(
              color: AppColors.black[50],
            ),
          ),
          ColorDisplay(
            title: 'AppColors.black[100]',
            decoration: BoxDecoration(
              color: AppColors.black[100],
            ),
          ),
          ColorDisplay(
            title: 'AppColors.black[900]',
            decoration: BoxDecoration(
              color: AppColors.black[900],
            ),
          ),
        ],
      ),
    );
  }
}

class ColorTitle extends StatelessWidget {
  const ColorTitle(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 16,
      ),
      child: Text(text,
          style: const TextStyle(
            fontSize: 21,
          )),
    );
  }
}

class ColorDisplay extends StatelessWidget {
  const ColorDisplay({
    required this.title,
    required this.decoration,
    Key? key,
  }) : super(key: key);

  final String title;
  final BoxDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: SizedBox(
        width: 42,
        height: 42,
        child: DecoratedBox(
          decoration: decoration,
        ),
      ),
    );
  }
}
