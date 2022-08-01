import 'package:app_ui/app_ui.dart';
import 'package:fitts/app/bloc/app_bloc.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/onboarding/onboarding.dart';
import 'package:fitts/onboarding/widgets/wizard_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

/// {@template onboarding_page}
/// Onboarding page widget.
/// {@endtemplate}
class OnboardingPage extends StatelessWidget {
  /// {@macro onboarding_page}
  const OnboardingPage({Key? key}) : super(key: key);

  /// Page helper for creating routes.
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const OnboardingPage());

  @override
  Widget build(BuildContext context) {
    final userProfile = context.watch<AppBloc>().state.userProfile;

    return BlocProvider(
      create: (context) => OnboardingBloc(
        userProfileRepository: context.read<UserProfileRepository>(),
        userProfile: userProfile,
      ),
      child: const OnboardingPageView(),
    );
  }
}

@visibleForTesting
// ignore: public_member_api_docs
class OnboardingPageView extends StatelessWidget {
// ignore: public_member_api_docs
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _OnboardingListener(
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status == OnboardingStatus.submitting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SafeArea(
              child: _OnboardingPageBody(),
            );
          },
        ),
      ),
    );
  }
}

class _OnboardingListener extends StatelessWidget {
  const _OnboardingListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.submitFailed) {
          AppSnackBar.show(
            context,
            const Text('Failed to submit'),
          );
        }
        if (state.status == OnboardingStatus.submitSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }
}

class _OnboardingPageBody extends StatelessWidget {
  const _OnboardingPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      builder: (context, state) {
        return Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: IndexedStack(
                key: Key(state.currentStep.toString()),
                index: state.currentStep - 1,
                children: const [
                  _GenderStep(),
                  _DateOfBirth(),
                  _WeightStep(),
                  _HeightStep(),
                ],
              ),
            ),
            const _FormFlowButtons(),
          ],
        );
      },
    );
  }
}

class _FormFlowButtons extends StatelessWidget {
  const _FormFlowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.watch<OnboardingBloc>();
    final currentStep = bloc.state.currentStep;
    const totalSteps = OnboardingState.totalSteps;
    final isLastStep = currentStep == totalSteps;
    const canGoNext = true;

    return FlowButtons(
      onBackButton: currentStep != 1
          ? () {
              bloc.add(StepChanged(currentStep - 1));
            }
          : null,
      buttons: [
        if (isLastStep)
          AppTextButton(
            key: const Key('onboarding_finish_button'),
            onPressed: () {
              bloc.add(const ProfileSubmitted());
            },
            child: Text(l10n.onboardingFinishButton),
          ),
        if (!isLastStep)
          AppTextButton(
            key: const Key('onboarding_continue_button'),
            onPressed: canGoNext
                ? () {
                    bloc.add(StepChanged(currentStep + 1));
                  }
                : null,
            child: Text(l10n.onboardingContinueButton),
          ),
      ],
    );
  }
}

class _GenderStep extends StatelessWidget {
  const _GenderStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OnboardingStep(
      headerText: l10n.onboardingGenderSelectionTitle,
      text: l10n.onboardingGenderSelectionDescription,
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          Center(
            child: GenderPicker(
              selected: context.watch<OnboardingBloc>().state.gender,
              onChange: (gender) {
                context.read<OnboardingBloc>().add(GenderChanged(gender));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DateOfBirth extends StatelessWidget {
  const _DateOfBirth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final dateOfBirth = context.watch<OnboardingBloc>().state.dateOfBirth;
    final dateTimeNow = DateTime.now();
    final dateValue = dateOfBirth ?? dateTimeNow;
    final maxNumberOfDaysInCurrentMonth =
        DateTime(dateValue.year, dateValue.month + 1, 0).day;

    return OnboardingStep(
      headerText: l10n.onboardingBirthDateSelectionTitle,
      text: l10n.onboardingBirthDateSelectionDescription,
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppNumberPicker(
                currentValue: dateValue.day,
                onChanged: (value) => context.read<OnboardingBloc>().add(
                      DateOfBirthChanged(
                        DateTime(
                          dateValue.year,
                          dateValue.month,
                          value,
                        ),
                      ),
                    ),
                minValue: 1,
                maxValue: maxNumberOfDaysInCurrentMonth,
              ),
              AppNumberPicker(
                currentValue: dateValue.month,
                onChanged: (value) => context.read<OnboardingBloc>().add(
                      DateOfBirthChanged(
                        DateTime(
                          dateValue.year,
                          value,
                          dateValue.day,
                        ),
                      ),
                    ),
                minValue: 1,
                maxValue: 12,
              ),
              AppNumberPicker(
                currentValue: dateValue.year,
                onChanged: (value) => context.read<OnboardingBloc>().add(
                      DateOfBirthChanged(
                        DateTime(
                          value,
                          dateValue.month,
                          dateValue.day,
                        ),
                      ),
                    ),
                minValue: 1900,
                maxValue: dateTimeNow.year,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeightStep extends StatelessWidget {
  const _WeightStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final weight = context.watch<OnboardingBloc>().state.weight;

    return OnboardingStep(
      headerText: l10n.onboardingWeightSelectionTitle,
      text: l10n.onboardingWeightSelectionDescription,
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                width: 80,
                child: AppTextInput(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  initialValue: weight.toString(),
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    final newWeight = double.tryParse(value);

                    context.read<OnboardingBloc>().add(
                          WeightChanged(newWeight ?? 0),
                        );
                  },
                  isDecimal: true,
                ),
              ),
              Text('kg', style: AppTypography.headline6),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeightStep extends StatelessWidget {
  const _HeightStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final height = context.watch<OnboardingBloc>().state.height;

    return OnboardingStep(
      headerText: l10n.onboardingHeightSelectionTitle,
      text: l10n.onboardingHeightSelectionDescription,
      child: Column(
        children: [
          const AppGap.xxxlg(),
          const AppGap.xxxlg(),
          AppNumberPicker(
            currentValue: height,
            onChanged: (value) => context.read<OnboardingBloc>().add(
                  HeightChanged(value),
                ),
            textMapper: (value) => '$value cm',
            minValue: 1,
            maxValue: 300,
          ),
        ],
      ),
    );
  }
}
