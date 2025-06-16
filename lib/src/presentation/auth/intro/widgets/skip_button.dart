
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onSkip(context),
      child: Container(
        width: 63.h,
        height: 32.h,
        alignment: Alignment.center,
        child: AutoSizeText(localizations.skip, style: titleSmall?.copyWith(color: AppColors.white,fontFamily: FontFamily.inter,fontSize: 15)),
      ),
    );
  }

  void _onSkip(BuildContext context) => context.pushReplacementNamed(NavigationPath.loginRouteUri);
}
