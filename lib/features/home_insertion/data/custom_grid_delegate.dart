import 'package:flutter/rendering.dart';

import 'custom_grid_layout.dart';

class CustomGridDelegate extends SliverGridDelegate {
  CustomGridDelegate({required this.dimension});

  final double dimension;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    int count = constraints.viewportMainAxisExtent ~/ dimension;
    if (count < 1) {
      count = 1;
    }
    final double squareDimension = constraints.viewportMainAxisExtent / count;
    return CustomGridLayout(
      crossAxisCount: count,
      dimension: squareDimension,
      fullRowPeriod: 3, // Number of rows per block (one of which is the full row).
    );
  }

  @override
  bool shouldRelayout(CustomGridDelegate oldDelegate) {
    return dimension != oldDelegate.dimension;
  }
}