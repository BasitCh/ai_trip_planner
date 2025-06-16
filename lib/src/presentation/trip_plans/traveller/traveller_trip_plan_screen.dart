import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/traveler_inprogress_trip_plan/inprogress_trips_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/traveler_inprogress_trip_plan/inprogress_trips_state.dart';
import 'package:travel_hero/src/presentation/trip_plans/traveller/traveler_filtered_itineraries.dart';
import 'package:widgets_book/widgets_book.dart';

import 'in_progress_trip_plans.dart';

class TravellerTripPlanScreen extends StatefulWidget {
  const TravellerTripPlanScreen({super.key});

  @override
  State<TravellerTripPlanScreen> createState() =>
      _TravellerTripPlanScreenState();
}

class _TravellerTripPlanScreenState extends State<TravellerTripPlanScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  /// Section: In Progress List
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BlocBuilder<InProgressTripsCubit, InProgressTripsState>(
                            builder: (context, state) {
                          return state.trips.isNotEmpty
                              ? Column(
                                  children: [
                                    Gap(10.h),
                                    SizedBox(
                                      height: 335.h,
                                      child: InProgressTripPlans(
                                        state: state,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink();
                        }),
                      ],
                    ),
                  ),
                ],
            body: TravelerFilteredItineraries()),
      ),
    );
  }
}
