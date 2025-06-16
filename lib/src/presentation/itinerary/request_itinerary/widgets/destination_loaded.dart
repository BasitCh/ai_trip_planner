
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/destination_search_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class DestinationLoaded extends StatelessWidget {
  const DestinationLoaded({super.key, required this.destinationSearchLoaded, required this.destinationSearchCubit});
  final DestinationSearchLoaded destinationSearchLoaded;
  final DestinationSearchCubit destinationSearchCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: destinationSearchLoaded.places.length,
      itemBuilder: (context, index) {
        var place = destinationSearchLoaded.places[index];
        return Column(
          children: [
            ListTile(
              dense: false,
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.black,
                size: 20,
              ),
              leading: place.imageUrl != null && place.imageUrl!.isNotEmpty
                  ? CustomImageView(
                  imagePath: place.imageUrl!,
                  radius: BorderRadius.circular(12),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover)
                  : Assets.icons.icLocation.svg(),
              title: Row(
                children: [
                  Gap(14),
                  Expanded(
                    child: Text(
                      place.placeName,
                      maxLines: 1,
                      style: titleXSmallWhite?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              subtitle: Row(
                children: [
                  Gap(14),
                  Expanded(
                    child: Text(
                      place.description,
                      style: titleXSmallWhite?.copyWith(
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                destinationSearchCubit.selectedDestination(place, context);
              },
            ),
            Gap(18.h),
            index != destinationSearchLoaded.places.length - 1
                ? Divider(
              color: AppColors.textfieldBorder,
            )
                : SizedBox.shrink(),
            index != destinationSearchLoaded.places.length - 1
                ? Gap(18.h)
                : Gap(0),
          ],
        );
      },
    );
  }
}
