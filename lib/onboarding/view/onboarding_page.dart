import 'package:app_ui/app_ui.dart';
import 'package:fitts/app/bloc/app_bloc.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/onboarding/onboarding.dart';
import 'package:fitts/onboarding/widgets/wizard_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  static Route route() =>
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

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingListener(
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

class OnboardingListener extends StatelessWidget {
  const OnboardingListener({
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
        return AnimatedSwitcher(
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
        );
      },
    );
  }
}

class _GenderStep extends StatelessWidget {
  const _GenderStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final gender = context.watch<OnboardingBloc>().state.gender;

    return WizardStep(
      headerText: l10n.onboardingGenderSelectionTitle,
      text: l10n.onboardingGenderSelectionDescription,
      canGoNext: gender != null,
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
  const _DateOfBirth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final dateOfBirth = context.watch<OnboardingBloc>().state.dateOfBirth;
    final dateTimeNow = DateTime.now();
    final dateValue = dateOfBirth ?? dateTimeNow;
    final maxNumberOfDaysInCurrentMonth =
        DateTime(dateValue.year, dateValue.month + 1, 0).day;

    return WizardStep(
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
            ],
          ),
        ],
      ),
    );
  }
}

class _WeightStep extends StatelessWidget {
  const _WeightStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final weight = context.watch<OnboardingBloc>().state.weight;

    return WizardStep(
      headerText: l10n.onboardingWeightSelectionTitle,
      text: l10n.onboardingWeightSelectionDescription,
      canGoNext: weight > 0,
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
  const _HeightStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final height = context.watch<OnboardingBloc>().state.height;

    return WizardStep(
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
