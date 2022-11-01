import 'package:flutter/material.dart';

/// {@template exercise_stats_page}
/// Page used to display statistics for an exercise.
/// {@endtemplate}
class ExerciseStatsPage extends StatelessWidget {
  /// {@macro exercise_stats_page}
  const ExerciseStatsPage({Key? key}) : super(key: key);

  /// Route helper.
  static Route<dynamic> route() =>
      MaterialPageRoute<void>(builder: (_) => const ExerciseStatsPage());

  @override
  Widget build(BuildContext context) {
    return const _ExerciseStatsPageView();
  }
}

class _ExerciseStatsPageView extends StatelessWidget {
  const _ExerciseStatsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
