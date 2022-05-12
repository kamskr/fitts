import 'package:app_ui/app_ui.dart';
import 'package:fitts/profile_setup_wizard/bloc/profile_setup_wizard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class WizardStep extends StatelessWidget {
  const WizardStep({
    Key? key,
    required this.child,
    required this.headerText,
    required this.text,
    this.canGoNext = true,
  }) : super(key: key);

  final Widget child;
  final String headerText;
  final String text;
  final bool canGoNext;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileSetupWizardBloc>();
    final currentStep = bloc.state.currentStep;
    const totalSteps = ProfileSetupWizardState.totalSteps;
    final isLastStep = currentStep == totalSteps;

    return Stack(
      children: [
        Column(
          children: [
            const AppGap.xlg(),
            _StepIndicator(
              currentStep: currentStep,
              totalSteps: totalSteps,
            ),
            const AppGap.lg(),
            _Header(headerText),
            const AppGap.md(),
            _Text(text),
            child,
          ],
        ),
        FlowButtons(
          onBackButton: currentStep != 1
              ? () {
                  bloc.add(StepChanged(currentStep - 1));
                }
              : null,
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
                onPressed: canGoNext
                    ? () {
                        bloc.add(StepChanged(currentStep + 1));
                      }
                    : null,
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
