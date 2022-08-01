import 'package:app_ui/app_ui.dart';
import 'package:fitts/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template onboarding_step}
/// Widget used for showing single onboarding step.
/// {@endtemplate}
class OnboardingStep extends StatelessWidget {
  /// {@macro onboarding_step}
  const OnboardingStep({
    Key? key,
    required this.child,
    required this.headerText,
    required this.text,
  }) : super(key: key);

  /// Child widget.
  final Widget child;

  /// Header text - title.
  final String headerText;

  /// Text shown below the header.
  final String text;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OnboardingBloc>();
    final currentStep = bloc.state.currentStep;
    const totalSteps = OnboardingState.totalSteps;

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
