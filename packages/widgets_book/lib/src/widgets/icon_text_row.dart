import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class IconTextRow extends StatelessWidget {
  const IconTextRow({
    required this.icon,
    required this.desc,
    this.maxLine = 1,
    this.circleSize = 20,
    this.textStyle,
    this.circleColor = AppColors.white,
    this.showTooltip = false,
    this.tooltipWidget,
    super.key,
  });

  final Widget icon;
  final String desc;
  final int maxLine;
  final double circleSize;
  final TextStyle? textStyle;
  final Color circleColor;
  final bool showTooltip;
  final Widget? tooltipWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIcon(
          width: circleSize,
          height: circleSize,
          icon: icon,
          color: circleColor,
        ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            desc,
            // maxLines: maxLine,
            softWrap: true,

            style: textStyle ??
                Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w300,
                      color: AppColors.white700,
                      fontSize: 14.sp,
                    ),
          ),
        ),
        if (showTooltip) tooltipWidget!,
      ],
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    required this.icon,
    super.key,
    this.width = 50,
    this.height = 50,
    this.color = AppColors.white,
    this.imageUrl,
  });

  final double width;
  final double height;
  final Color? color;
  final String? imageUrl;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}
