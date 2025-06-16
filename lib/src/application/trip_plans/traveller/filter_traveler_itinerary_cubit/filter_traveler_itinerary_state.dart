import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/itinerary/filtered_itinerary_repository.dart';

class FilterTravelerItineraryState {
  final List<TravelItinerary> itineraries;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final ItineraryFilterType filter;

  FilterTravelerItineraryState({
    required this.itineraries,
    required this.isLoading,
    required this.hasMore,
    required this.filter,
    this.error,
  });

  factory FilterTravelerItineraryState.initial() =>
      FilterTravelerItineraryState(
        itineraries: [],
        isLoading: false,
        hasMore: true,
        filter: ItineraryFilterType.all,
        error: null,
      );

  FilterTravelerItineraryState copyWith({
    List<TravelItinerary>? itineraries,
    bool? isLoading,
    bool? hasMore,
    String? error,
    ItineraryFilterType? filter,
  }) {
    return FilterTravelerItineraryState(
      itineraries: itineraries ?? this.itineraries,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      filter: filter ?? this.filter,
      error: error,
    );
  }
}
