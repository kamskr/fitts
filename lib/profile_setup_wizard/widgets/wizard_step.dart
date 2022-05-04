import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class WizardStep extends StatelessWidget {
  const WizardStep({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  static const isLastStep = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
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
