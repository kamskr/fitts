import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:flutter/material.dart';

/// {@template workout_date_chip}
/// Chip displaying date.
/// {@endtemplate}
class WorkoutDateChip extends StatelessWidget {
  /// {@macro workout_date_chip}
  const WorkoutDateChip({
    Key? key,
    required this.date,
  }) : super(key: key);

  /// Date to display
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 39,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateTimeFormatters.day(date),
            style: context.textTheme.headline6!.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            DateTimeFormatters.month(date),
            style: context.textTheme.overline!.copyWith(
              color: Colors.white.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }
}
