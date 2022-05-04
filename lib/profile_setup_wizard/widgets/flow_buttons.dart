import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class FlowButtons extends StatelessWidget {
  const FlowButtons({Key? key, required this.buttons}) : super(key: key);

  final List<Widget> buttons;
  static const buttonHeight = 56;

  @override
  Widget build(BuildContext context) {
    const buttonPadding = AppSpacing.md;

    const height = buttonHeight + 2 * buttonPadding;

    return Align(
      alignment: Alignment.bottomCenter,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              Assets.icons.appLogo.svg(
                alignment: Alignment.centerLeft,
                width: 22,
                height: 22,
              ),
              ...buttons.map(
                (button) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: buttonPadding,
                  ),
                  child: button,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
