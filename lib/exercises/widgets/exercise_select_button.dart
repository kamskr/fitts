import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template exercise_select_button}
/// Button used for adding exercise to selected exercises.
/// {@endtemplate}
class ExerciseSelectButton extends StatelessWidget {
  /// {@macro exercise_select_button}
  const ExerciseSelectButton({
    Key? key,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  /// Whether the exercise is selected.
  final bool isSelected;

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? context.colorScheme.primary : null,
          border: Border.all(
            color: context.colorScheme.primary,
            width: 2,
          ),
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: context.colorScheme.onPrimary,
              )
            : const Icon(Icons.add),
      ),
    );
  }
}
