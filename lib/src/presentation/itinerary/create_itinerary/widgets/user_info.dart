
import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text("Paddy Doyle",
            style: titleMediumSaira?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            )),
        Text(
          "Access the prebuilt trip plan\nor request a personalised trip plan",
          textAlign: TextAlign.center,
          style: titleXSmallWhite?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
