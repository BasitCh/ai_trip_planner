import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/favorites/collection_itineraries_cubit/collection_itinerary_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class CreateListUi extends StatelessWidget {
  CreateListUi({required this.onAddPressed, super.key});
  final TextEditingController listNameController = TextEditingController();
  final Function(String) onAddPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionItineraryCubit, CollectionItineraryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            AppTextField(
              controller: listNameController,
              hintText: 'Name',
              hintStyle: titleXSmallWhite?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: AppColors.textfieldBorder),
              borderRadius: 30,
              bordersidecolor: BorderSide(color: AppColors.textfieldBorder),
            ),
            Gap(20.h),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 36,
                  child: AppButton.outlinedDarkGrayish(
                    onPressed: () {
                      listNameController.clear();
                    },
                    child: Text(
                      'Clear',
                      style: titleMediumSaira?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.textfieldBorder,
                      ),
                    ),
                  ),
                ),
                Gap(10.w),
                SizedBox(
                  width: 215,
                  height: 36,
                  child: AppButton.lightRed(
                      onPressed: () {
                        if (listNameController.text.trim().isNotEmpty) {
                          onAddPressed(listNameController.text.trim());
                        }
                      },
                      child: state.creatingCollection
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: AppButtonLoading(
                                color: AppColors.white,
                              ),
                            )
                          : Text(
                              'Save',
                              style: titleMediumSaira?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: AppColors.white,
                              ),
                            )),
                )
              ],
            ),
          ]),
        );
      },
    );
  }
}
