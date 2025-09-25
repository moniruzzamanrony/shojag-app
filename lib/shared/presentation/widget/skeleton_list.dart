import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// [SkeletonList] : widget for skeleton list
/// It will show skeleton list of [itemCount]
/// And skeleton will be provide for [child]
/// This will generate by [Skeletonizer]
class SkeletonList extends StatelessWidget {
  final double separator;
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  const SkeletonList({
    super.key,
    required this.separator,
    this.itemCount = 10,
    required this.padding,
    required this.child,
    this.physics,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.separated(
        physics: physics,
        controller: scrollController,
        separatorBuilder: (_, __) => SizedBox(height: separator),
        padding: padding,
        itemBuilder: (_, __) {
          return child;
        },
        itemCount: 10,
      ),
    );
  }
}
