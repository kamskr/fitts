import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class WizardStep extends StatelessWidget {
  const WizardStep({
    Key? key,
    required this.child,
    required this.headerText,
    required this.text,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  final Widget child;
  final String headerText;
  final String text;
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final isLastStep = currentStep == totalSteps;

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: AppSpacing.xlg),
            _StepIndicator(
              currentStep: currentStep,
              totalSteps: totalSteps,
            ),
            const SizedBox(height: AppSpacing.lg),
            _Header(headerText),
            const SizedBox(height: AppSpacing.md),
            _Text(text),
            child,
          ],
        ),
        FlowButtons(
          buttons: [
            if (isLastStep)
              AppTextButton(
                onPressed: () {
                  // context.read<ProfileWizardBloc>().add(
                  //       ProfileWizardEvent.stepChanged(
                  //         nextStep: stepInfo.stepNumber + 1,
                  //       ),
                  //     );
                },
                child: const Text('FINISH'),
              ),
            if (!isLastStep)
              AppTextButton(
                onPressed: () {
                  // context.read<ProfileWizardBloc>().add(
                  //       ProfileWizardEvent.stepChanged(
                  //         nextStep: stepInfo.stepNumber + 1,
                  //       ),
                  //     );
                },
                child: const Text('CONTINUE'),
              ),
          ],
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      child: Text(
        text,
        style: AppTypography.body1,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(
    this.headerText, {
    Key? key,
  }) : super(key: key);

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: AppTypography.headline4,
      textAlign: TextAlign.center,
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Text('$currentStep of $totalSteps');
  }
}
