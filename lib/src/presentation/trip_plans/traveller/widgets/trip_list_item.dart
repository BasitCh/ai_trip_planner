import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/utils/base_date_picker.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class TripListItem extends StatelessWidget {
  const TripListItem({
    required this.travelItinerary,
    required this.context,
    super.key,
  });

  final TravelItinerary travelItinerary;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final cubit = context.read<CreateItineraryCubit>();

        cubit.moveToItineraryDetailsPage(travelItinerary, openedFromHome: true);
        cubit.loadItineraryDetails(itineraryId: travelItinerary.id);
      },
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        margin: const EdgeInsets.only(top: 10),
        color: AppColors.white,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Ensures the Row takes minimal space
            children: [
              CircleAvatar(
                child: CustomImageView(
                  imagePath: travelItinerary.coverUrls?.first,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(50),
                ),
              ),
              Gap(12),
              Assets.icons.leftRightArrow
                  .svg(), // SvgPicture directly next to CircleAvatar
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Ensures the Row takes minimal space
            children: [
              Gap(12),
              CircleAvatar(
                child: CustomImageView(
                  imagePath: travelItinerary.profileUrl ??
                      context.read<AppUserCubit>().state?.pictureUrl,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(50),
                ),
              ),
              Gap(12),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Trip Plan by ',
                    style: titleXSmallWhite?.copyWith(
                      color: AppColors.textNormal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    children: [
                      TextSpan(
                        text: travelItinerary.createdBy ?? 'test',
                        style: titleXSmallWhite?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text:
                            '\n${travelItinerary.duration ?? '0'} - ${travelItinerary.destination ?? ''}',
                        style: titleXSmallWhite?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          trailing: Text(
            timeAgoCompleted(travelItinerary.createdAt ?? DateTime.now()),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textNormalSmall,
                ),
          ),
        ),
      ),
    );
  }
}
