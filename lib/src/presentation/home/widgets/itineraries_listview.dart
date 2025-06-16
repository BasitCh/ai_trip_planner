import 'package:flutter/material.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/presentation/home/widgets/itinerary_card.dart';
import 'package:widgets_book/widgets_book.dart';

class ItinerariesListview extends StatelessWidget {
  const ItinerariesListview({
    super.key,
    required this.itineraries,
    required this.isLoadingMore,
  });

  final List<TravelItinerary> itineraries;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itineraries.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= itineraries.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
                child: AppButtonLoading(
              color: AppColors.primary,
            )),
          );
        }
        return ItineraryCard(itinerary: itineraries[index]);
      },
    );
  }
}
