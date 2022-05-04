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
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.black[100],
                ),
                child: const SizedBox(
                  height: 1,
                  width: double.infinity,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: AppSpacing.xs),
                  AppTextButton(
                    onPressed: () {},
                    child: Assets.icons.icBack.svg(
                      alignment: Alignment.centerLeft,
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.black[100],
                    ),
                    child: const SizedBox(
                      height: 24,
                      width: 1,
                    ),
                  ),
                  const Spacer(),
                  ...buttons.map(
                    (button) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: buttonPadding,
                      ),
                      child: button,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
