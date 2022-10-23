import 'dart:math' as math;
import 'package:flutter/services.dart';

/// {@template decimal_text_input_formatter}
/// A [TextInputFormatter] that allows only a certain number of decimal places.
/// {@endtemplate}
class DecimalTextInputFormatter extends TextInputFormatter {
  /// {@macro decimal_text_input_formatter}
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0, 'decimalRange must be greater than 0');

  /// The maximum number of decimal places allowed.
  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    var newSelection = newValue.selection;
    var truncated = newValue.text;

    final value = newValue.text;

    if (value.contains('.') &&
        value.substring(value.indexOf('.') + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == '.') {
      truncated = '0.';

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}
