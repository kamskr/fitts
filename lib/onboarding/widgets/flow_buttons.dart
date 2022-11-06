import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template flow_buttons}
///  Buttons used in onboarding flow for changing current step.
/// {@endtemplate}
class FlowButtons extends StatelessWidget {
  /// {@macro flow_buttons}
  const FlowButtons({
    Key? key,
    required this.buttons,
    this.onBackButton,
  }) : super(key: key);

  /// Buttons used in onboarding flow for changing current step.
  final List<Widget> buttons;

  /// Callback for back button.
  final VoidCallback? onBackButton;

  static const _buttonHeight = 56;

  @override
  Widget build(BuildContext context) {
    final mainColors = context.colorScheme;
    final additionalColors = context.appColorScheme;

    const buttonPadding = AppSpacing.md;
    const height = _buttonHeight + 2 * buttonPadding;

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
                  color: additionalColors.black100,
                ),
                child: const SizedBox(
                  height: 1,
                  width: double.infinity,
                ),
              ),
              Row(
                children: [
                  const AppGap.xs(),
                  AppTextButton(
                    key: const Key('flowButtonsBackButton'),
                    onPressed: onBackButton,
                    child: Assets.icons.icBack.svg(
                      alignment: Alignment.centerLeft,
                      width: 22,
                      height: 22,
                      color: onBackButton != null
                          ? mainColors.primary
                          : additionalColors.black100,
                    ),
                  ),
                  const AppGap.xs(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: additionalColors.black100,
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
