import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/favorites/collection_itineraries_cubit/collection_itinerary_cubit.dart';
import 'package:travel_hero/src/application/favorites/favorites_cubit/favorites_cubit.dart';
import 'package:travel_hero/src/application/intro/carousel_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/favorites/widgets/favorite_button.dart';
import 'package:travel_hero/src/presentation/home/widgets/paid_widget.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class ItineraryCard extends StatelessWidget {
  final TravelItinerary itinerary;
  final bool? isViewOnly;

  const ItineraryCard({
    super.key,
    required this.itinerary,
    this.isViewOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final createItineraryCubit = context.read<CreateItineraryCubit>();
    final images = itinerary.coverUrls ?? [];
    return InkWell(
      onTap: () {
        createItineraryCubit.moveToItineraryDetailsPage(
          itinerary,
          openedFromHome: true,
          isViewOnly: isViewOnly ?? false,
        );
        // load itinerary details after navigation
        createItineraryCubit.loadItineraryDetails(itineraryId: itinerary.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: AppColors.white,
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                images.isNotEmpty
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14)), // Only top rounded
                            child: CarouselSlider.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index, realIndex) {
                                return CustomImageView(
                                  imagePath:
                                      images.isNotEmpty ? images[index] : '',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              },
                              options: CarouselOptions(
                                height: 240,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  context
                                      .read<CarouselCubit>()
                                      .updateIndex(index);
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: BlocBuilder<CarouselCubit, int>(
                              builder: (context, activeIndex) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: images.asMap().entries.map((entry) {
                                    return Container(
                                      width:
                                          activeIndex == entry.key ? 13.0 : 9.0,
                                      height:
                                          activeIndex == entry.key ? 13.0 : 9.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: activeIndex == entry.key
                                            ? AppColors.primary
                                            : AppColors.white,
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                if (createItineraryCubit.isPaidWidget(
                    itinerary: itinerary)) ...[
                  Positioned(top: 15, left: 15, child: PaidWidget()),
                ],
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(itinerary.profileUrl ?? ''),
                      ),
                      Gap(8.w),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${itinerary.duration} to ${itinerary.destination}',
                                      style: headerStyle,
                                    ),
                                    TextSpan(
                                      text: ' by ${itinerary.createdBy}',
                                      style: headerStyle?.copyWith(
                                          color: AppColors.primary,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Text(
                    itinerary.description ?? '',
                    style: subTitleStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(8.h),
                  Text(itinerary.duration ?? '',
                      style: subTitleStyle?.copyWith(
                          color: AppColors.textSecondary2, fontSize: 13)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 6,
              ),
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: index < itinerary.rating!.floor()
                            ? Assets.icons.filledStar.svg()
                            : Assets.icons.emptyStar.svg(),
                      ),
                    ),
                  ),
                  Gap(5.w),
                  Text(
                    '(${itinerary.reviewCount} reviews)',
                    style: bodySmall?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 8),
                  ),
                  const Spacer(),
                  isTravelerMode
                      ? FavoriteButton(
                          itinerary: itinerary,
                          onPressed: () => toggleFavorite(context),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            Gap(12.h),
          ],
        ),
      ),
    );
  }

  void toggleFavorite(BuildContext context) {
    if (itinerary.isLiked ?? false) {
      context
          .read<CollectionItineraryCubit>()
          .showItineraryCollectionSheet(itinerary: itinerary);
    } else {
      context.read<FavoritesCubit>().toggleFavorite(
            itinerary: itinerary,
          );
      context
          .read<CollectionItineraryCubit>()
          .showItineraryCollectionSheet(itinerary: itinerary);
    }
  }
}
