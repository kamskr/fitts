// import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  // final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Text(text),
      ),
    );
  }
}
