import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

/// {@template app_number_picker}
/// Widget used for picking numbers with simple scrolling UI.
/// {@endtemplate}
class AppNumberPicker extends StatelessWidget {
  /// {@macro app_number_picker}
  const AppNumberPicker({
    Key? key,
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.isHorizontal = false,
    this.textMapper,
  }) : super(key: key);

  /// Current value of the picker.
  final int currentValue;

  /// Minimum value of the picker.
  final int minValue;

  /// Maximum value of the picker.
  final int maxValue;

  /// Callback for when the value changes.
  final void Function(int) onChanged;

  /// Whether the picker is horizontal or vertical.
  final bool isHorizontal;

  /// Function that maps the value to a string.
  final TextMapper? textMapper;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: NumberPicker(
            textMapper: textMapper,
            itemHeight: 60,
            value: currentValue,
            haptics: true,
            minValue: minValue,
            maxValue: maxValue,
            onChanged: onChanged,
            axis: isHorizontal ? Axis.horizontal : Axis.vertical,
            textStyle: TextStyle(
              fontSize: 20,
              color: AppColors.black[500]!.withOpacity(0.5),
            ),
            selectedTextStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        const Positioned.fill(
          child: Align(
            child: IgnorePointer(
              child: SizedBox(
                width: 150,
                height: 72,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.primary,
                      ),
                      bottom: BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
