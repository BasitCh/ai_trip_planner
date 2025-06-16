import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/trip_card.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/unlocked_overlay.dart';

class DaysWidget extends StatelessWidget {
  const DaysWidget({super.key, this.travelItinerary, this.isViewOnly = false,});
  final TravelItinerary? travelItinerary;
  final bool isViewOnly;

  @override
  Widget build(BuildContext context) {
    final createItineraryCubit = context.read<CreateItineraryCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Stack(
        children: [
          ListView.builder(
            itemCount: travelItinerary?.dayPlans.length ?? 0,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day ${travelItinerary?.dayPlans[index].day.toString() ?? ''}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount:
                        travelItinerary?.dayPlans[index].activities.length ?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, innerIndex) {
                      return TripCard(
                        isPaid: createItineraryCubit.isPaidWidget(
                            itinerary: travelItinerary),
                        innerIndex: innerIndex,
                        dayIndex: index,
                        isViewOnly: isViewOnly,
                        activity: travelItinerary!
                            .dayPlans[index].activities[innerIndex],
                      );
                    },
                  ),
                ],
              );
            },
          ),
          UnlockedOverlay(
            travelItinerary: travelItinerary,
          ),
        ],
      ),
    );
  }
}
