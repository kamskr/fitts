import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    Key? key,
    this.textAlign,
    this.style,
    this.inputType,
    this.initialValue,
    this.onChanged,
    this.isDecimal = false,
  }) : super(key: key);

  final TextInputType? inputType;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool isDecimal;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign ?? TextAlign.start,
      style: style,
      initialValue: initialValue,
      keyboardType: inputType,
      onChanged: onChanged,
      inputFormatters: isDecimal
          ? [
              FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              TextInputFormatter.withFunction(
                (oldValue, newValue) {
                  try {
                    final text = newValue.text;
                    if (text.isNotEmpty) double.parse(text);
                    return newValue;
                  } catch (e) {
                    return oldValue;
                  }
                },
              ),
            ]
          : null,
    );
  }
}
