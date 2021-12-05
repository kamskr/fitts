import 'package:flutter/material.dart';
import 'package:pr_fit_ui/pr_fit_ui.dart';

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRFit Colors'),
      ),
      body: ListView(
        children: const <Widget>[
          ColorDisplay(
            title: 'PRColor.primary',
            decoration: BoxDecoration(
              color: PRColors.primary,
            ),
          )
        ],
      ),
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
