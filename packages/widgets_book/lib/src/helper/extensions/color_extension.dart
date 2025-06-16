import 'dart:ui';

import 'package:widgets_book/src/colors/app_colors.dart';

extension ColorExtension on Color {
  Color textLuminanceColor(){
    return computeLuminance() > 0.5 ? AppColors.textPrimary : AppColors.white;
  }
}