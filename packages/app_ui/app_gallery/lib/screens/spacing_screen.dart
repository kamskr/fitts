import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class SpacingScreen extends StatelessWidget {
  const SpacingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _items = [
      _SpacingDisplay(spacing: AppSpacing.xxxs, name: 'xxxs'),
      _SpacingDisplay(spacing: AppSpacing.xxs, name: 'xxs'),
      _SpacingDisplay(spacing: AppSpacing.xs, name: 'xs'),
      _SpacingDisplay(spacing: AppSpacing.xxxs, name: 'xxxs'),
      _SpacingDisplay(spacing: AppSpacing.sm, name: 'sm'),
      _SpacingDisplay(spacing: AppSpacing.md, name: 'md'),
      _SpacingDisplay(spacing: AppSpacing.lg, name: 'lg'),
      _SpacingDisplay(spacing: AppSpacing.xlg, name: 'xlg'),
      _SpacingDisplay(spacing: AppSpacing.xxlg, name: 'xxlg'),
      _SpacingDisplay(spacing: AppSpacing.xxxlg, name: 'xxxlg'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spacing'),
      ),
      body: ListView(children: _items),
    );
  }
}

class _SpacingDisplay extends StatelessWidget {
  const _SpacingDisplay({
    required this.spacing,
    required this.name,
    Key? key,
  }) : super(key: key);

  final double spacing;
  final String name;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(),
      child: SizedBox(
        height: 20,
        width: spacing,
        child: Text('test'),
      ),
    );
  }
}
