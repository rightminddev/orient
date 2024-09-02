import 'dart:math';
import 'delegate.config.dart';
import 'package:flutter/material.dart';

class FixedDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double elevation;
  final double height;
  final Color? color;

  const FixedDelegate({
    required this.child,
    required this.height,
    this.color,
    this.elevation = 0.0,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = min(shrinkOffset, minExtent) / minExtent;
    return Material(
      color: color,
      elevation: DelegateConfig.elevationValue(progress, elevation),
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
