import 'package:flutter/material.dart';

/// {@template my_workouts_page}
/// Page with list of user's workout templates.
/// {@endtemplate}
class MyWorkoutsPage extends StatelessWidget {
  /// {@macro my_workouts_page}
  const MyWorkoutsPage({Key? key}) : super(key: key);

  /// Route helper for creating routes.
  static Route<dynamic> route() =>
      MaterialPageRoute<void>(builder: (_) => const MyWorkoutsPage());

  @override
  Widget build(BuildContext context) {
    return const _MyWorkoutsPageView();
  }
}

class _MyWorkoutsPageView extends StatelessWidget {
  const _MyWorkoutsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('my workouts'),
      ),
    );
  }
}
