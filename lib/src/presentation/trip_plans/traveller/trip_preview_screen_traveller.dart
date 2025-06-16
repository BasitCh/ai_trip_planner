import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/date_selection_calender_read_only.dart';
import 'package:travel_hero/widgets/custom_app_bar.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:travel_hero/widgets/text_field_with_label.dart';
import 'package:widgets_book/widgets_book.dart';

class TripPreviewScreenTraveller extends StatefulWidget {
  const TripPreviewScreenTraveller({super.key, required this.itineraryRequest});
  final ItineraryRequest itineraryRequest;

  @override
  State<TripPreviewScreenTraveller> createState() => _TripPreviewScreenTravellerState();
}

class _TripPreviewScreenTravellerState extends State<TripPreviewScreenTraveller> {
  late TextEditingController _noOfGuestController;
  // late TextEditingController _nameController;
  @override
  void initState() {
    print("asd${widget.itineraryRequest.dateSelectionMethod}");
    _noOfGuestController = TextEditingController(text: widget.itineraryRequest.people.toString());
    // _nameController = TextEditingController(text:  widget.itineraryRequest.);
    super.initState();
  }
  @override
  void dispose() {
    _noOfGuestController.dispose();
    // _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        title: Text(
          'Trip Plan (In Progress)',
          style: titleXSmallWhite?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 40.h,
                  width: 117.w,
                  child: AppButton.lightRed(
                    onPressed: () {
                    },
                    child: Text(
                      'In Progress',
                      style: buttonStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Gap(27.h),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomImageView(
                    height: 361.h,
                    width: context.width,
                    fit: BoxFit.cover,
                    imagePath: widget.itineraryRequest.placeImage ?? '',
                  )),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.itineraryRequest.placeName ?? '',
                          style: titleXSmallWhite?.copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          widget.itineraryRequest.placeDescription ?? '',
                          style: titleXSmallWhite?.copyWith(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomImageView(
                    radius: BorderRadius.circular(50),
                    height: 48,
                    width: 48,
                    imagePath:
                    widget.itineraryRequest.travelHeroProfileUrl ?? '',
                  ),
                ],
              ),
              Gap(14.h),
              Divider(
                color: AppColors.borderColorTextFiled.withValues(alpha: 0.25),
              ),
              Gap(24.h),
              Text(
                'Month & Dates',
                style: titleXSmallWhite?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color:
                  AppColors.borderColorTextFiled.withValues(alpha: 0.85),
                ),
              ),
              Gap(10.h),
              TextFieldWithLabel(
                readOnly: true,
                margin: EdgeInsets.all(0),
                controller:
                _noOfGuestController,
                labelTitle: 'Number of guests',
                hintText: 'xyz',
              ),
              SizedBox(height: 8),
              Text(
                'Trip length',
                style: titleXSmallWhite?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color:
                  AppColors.borderColorTextFiled.withValues(alpha: 0.85),
                ),
              ),
              if (widget.itineraryRequest.dateSelectionMethod ==
                  'length') ...[
                Column(
                  children: [
                    Gap(32.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Days',
                          style: titleXSmallWhite?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Assets.icons.icMinusCounter.svg(),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                '${widget.itineraryRequest.duration ?? 1}',
                                style: titleXSmallWhite?.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            Assets.icons.icPlushCounter.svg(),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
              if (widget.itineraryRequest.dateSelectionMethod ==
                  'range') ...[
                Text(
                  widget.itineraryRequest.selectedMonth??'',
                  style: titleMediumSaira?.copyWith(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
              if (widget.itineraryRequest.dateSelectionMethod == 'range') ...[
                DateSelectionCalenderReadOnly(
                  itineraryRequest: widget.itineraryRequest,
                )
              ],
              Gap(32.h),
              Text(
                "Mood",
                style: titleMediumSaira?.copyWith(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
              Gap(20.h),
              Text(
                widget.itineraryRequest.mood??'',
                style: titleMediumSaira?.copyWith(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              Gap(40.h),
              // Divider(
              //   color: AppColors.borderColorTextFiled.withValues(alpha: 0.25),
              // ),
              // Gap(40.h),
              // ProfileCard(),
              // Gap(50.h),
            ],
          )

      ),
    );
  }
}
