import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/destination_search_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    this.onPressedBack,
    this.onPressedNext,
    this.nextButtonText,
    this.isLoading = false,
  });
  final VoidCallback? onPressedBack;
  final VoidCallback? onPressedNext;
  final String? nextButtonText;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 35.h,
            child: AppButton.outlinedDarkGrayish(
              onPressed: onPressedBack ??
                  () {
                    context.read<DestinationSearchCubit>().clearState();
                  },
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.textfieldBorder,
                    size: 10,
                  ),
                  Gap(5),
                  Text(
                    'Back',
                    style: titleMediumSaira?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.textfieldBorder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(20),
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 35.h,
            child: AppButton.lightRed(
              onPressed: onPressedNext,
              // disabled: false,
              // radius: 30,

              child: isLoading!
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: AppButtonLoading(),
                    )
                  : Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nextButtonText ?? 'Next',
                          style: titleMediumSaira?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.white,
                          ),
                        ),
                        Gap(5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                          size: 10,
                        )
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
