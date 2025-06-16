// ignore_for_file: always_specify_types, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SvgPicture.asset(BlackBullIcons.icNoWifi,fit: BoxFit.contain,),

          StandardText.headline1(
            'Device not connected',
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: AppColors.white,
          ),

          StandardText.headline1(
            'Please make sure that you are connected to a data or wifi connection in order to use app.',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
