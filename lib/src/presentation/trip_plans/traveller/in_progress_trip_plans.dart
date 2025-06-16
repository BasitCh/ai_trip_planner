import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/traveler_inprogress_trip_plan/inprogress_trips_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/traveler_inprogress_trip_plan/inprogress_trips_state.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class InProgressTripPlans extends StatefulWidget {
  const InProgressTripPlans({super.key,required this.state});
  final InProgressTripsState state;
  @override
  State<InProgressTripPlans> createState() => _InProgressTripPlansState();
}

class _InProgressTripPlansState extends State<InProgressTripPlans> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<InProgressTripsCubit>();
    final state = cubit.state;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !state.loadingMore &&
        state.hasMoreData) {
      cubit.loadMoreRequests();
    }
  }

  @override
  Widget build(BuildContext context) {
      if (widget.state.initialLoading) {
        return const Center(
          child: AppButtonLoading(color: AppColors.primary),
        );
      }

      if (widget.state.trips.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: widget.state.trips.length + (widget.state.loadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.state.trips.length && widget.state.loadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: AppButtonLoading(color: AppColors.primary),
              ),
            );
          }

          final trip = widget.state.trips[index];
          return _buildTripCard(
            trip,
            widget.state.trips.length > 1 ? 329.w : 360.w,
            context,
          );
        },
      );
  }
}

/// Helper method to create each column
Widget _buildDetailColumn(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: titleXSmallWhite?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.jetGrey5),
      ),
      Gap(4.h), // Small gap between title and value
      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: titleXSmallWhite?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: AppColors.black),
      ),
    ],
  );
}

/// Extracted method for reusability
Widget _buildTripCard(trip, double width, BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    color: AppColors.white,
    elevation: 4,
    child: Stack(
      children: [
        Container(
          width: width,
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CustomImageView(
                    imagePath: trip.travelHeroProfileUrl ?? "",
                    radius: BorderRadius.circular(50),
                    height: 40,
                    width: 40,
                  ),
                  Spacer(),
                  SizedBox(
                    height: 35.h,
                    width: 106.w,
                    child: AppButton.lightRed(
                      onPressed: () {
                        context.pushNamed(NavigationPath.tripPreviewTraveller,
                            extra: trip);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'View Details',
                            textAlign: TextAlign.center,
                            style: buttonStyle?.copyWith(
                                fontSize: 10.sp, fontWeight: FontWeight.w400),
                          ),
                          Assets.icons.icArrowRight.svg(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Gap(12.h),
              Text("${trip.duration} Days trip to",
                  style: titleXSmallWhite?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                      color: AppColors.jetGrey)),
              Gap(5.h),
              Text("${trip.placeName}",
                  style: titleMediumSaira?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 36.sp,
                      color: AppColors.black)),
              Gap(12.h),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Divider(
                  color: AppColors.lightGrey5,
                ),
              ),
              Gap(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: _buildDetailColumn(
                          "Duration", "${trip.duration} Days")),
                  Expanded(
                      flex: 3,
                      child: _buildDetailColumn(
                          "Persons", "${trip.people} Adults")),
                  Expanded(
                      flex: 4,
                      child: _buildDetailColumn("Mood", trip.mood ?? '')),
                ],
              ),
              Gap(5.h),
              Row(
                children: [
                  Assets.icons.icInprogress.svg(),
                  Gap(8),
                  Text("In Progress",
                      style: titleXSmallWhite?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.jetGrey5)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
            ),
            child: Assets.icons.icProgressBack.svg(),
          ),
        ),
      ],
    ),
  );
}
