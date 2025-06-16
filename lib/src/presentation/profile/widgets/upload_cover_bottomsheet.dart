import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/profile/image_picker_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

void showUploadOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Transparent background
    isScrollControlled: true, // Allows the sheet to cover more area
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(bottom: 50,left: 30,right: 30), // Adjust to position above navigation bar
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        color: AppColors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.85),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Center(
                    child: Text(
                      "Photo Gallery",
                      style: titleXSmallWhite?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.iosBlue,
                        fontSize: 18.sp,
                      )
                    ),
                  ),
                  onTap: () {
                    context.read<ImagePickerCubit>().pickImageFromGallery();
                    Navigator.pop(context);
                  },
                ),
                Divider(color: AppColors.grey,),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Center(
                    child: Text(
                      "Camera",
                      style: titleXSmallWhite?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.iosBlue,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<ImagePickerCubit>().pickImageFromCamera();
                    Navigator.pop(context);
                  },
                ),
              ],),
            ),

            Gap(20.h),
            Container(
              height: 61.h,
              width: 355.w,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.85),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Cancel",
                  textAlign: TextAlign.center,
                  style: titleXSmallWhite?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.iosBlue,
                    fontSize: 18.sp,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
  }