
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:widgets_book/widgets_book.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(80),
          Assets.icons.circleGif.image(height: 294, width: 300),
          Gap(50),
          Padding(
            padding: EdgeInsets.only(right: 30.w, left: 30.w),
            child: Text('Discover global trip plans to',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22,
                    fontFamily: FontFamily.inter,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: EdgeInsets.only(right: 37.w, left: 37.w),
            child: Text('fuel your next adventure',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22,
                    fontFamily: FontFamily.inter,
                    fontWeight: FontWeight.w700)),
          ),
          Gap(50),
          Expanded(child: Assets.icons.countryCaroiusal.image()),
        ],
      ),
    );
  }
}
