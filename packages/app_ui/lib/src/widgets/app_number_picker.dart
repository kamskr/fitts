import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

class AppNumberPicker extends StatelessWidget {
  const AppNumberPicker({
    Key? key,
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.isHorizontal = false,
    this.textMapper,
  }) : super(key: key);

  final int currentValue;
  final int minValue;
  final int maxValue;
  final void Function(int) onChanged;
  final bool isHorizontal;
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
                fontSize: 20, color: AppColors.black[500]!.withOpacity(0.5)),
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
