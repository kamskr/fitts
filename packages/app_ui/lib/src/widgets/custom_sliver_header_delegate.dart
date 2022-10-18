import 'dart:math' as math;

import 'package:flutter/material.dart';

/// {@template custom_sliver_header_delegate}
/// A sliver helper for persistent headers.
/// It can be used if you want a widget to stick to the top of the view.
/// {@endtemplate}
class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// {@macro custom_sliver_header_delegate}
  CustomSliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  /// Minimum height of the header.
  final double minHeight;

  /// Maximum height of the header.
  final double maxHeight;

  /// Widget to be displayed in the header.
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(CustomSliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
