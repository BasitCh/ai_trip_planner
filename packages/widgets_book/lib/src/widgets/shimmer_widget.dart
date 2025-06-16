import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as shimmer;
import 'package:widgets_book/src/colors/app_colors.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    required this.type,
    super.key,
    this.width = double.infinity,
    this.height = 60,
    this.borderRadius = 5,
    this.child,
  });
  final ShimmerType type;
  final double width;
  final double height;
  final Widget? child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return shimmer.Shimmer.fromColors(
      highlightColor: AppColors.white800,
      baseColor: AppColors.gray,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(.10),
          borderRadius: type == ShimmerType.circle
              ? BorderRadius.circular(width)
              : BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}

enum ShimmerType { circle, square }
