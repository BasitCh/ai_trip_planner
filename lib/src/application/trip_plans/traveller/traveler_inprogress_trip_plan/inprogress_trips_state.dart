import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';

class InProgressTripsState {
  final List<ItineraryRequest> trips;
  final bool initialLoading;
  final bool loadingMore;
  final bool hasMoreData;
  final DocumentSnapshot? lastDocument;

  const InProgressTripsState({
    required this.trips,
    required this.initialLoading,
    required this.loadingMore,
    required this.hasMoreData,
    required this.lastDocument,
  });

  factory InProgressTripsState.initial() => InProgressTripsState(
        trips: [],
        initialLoading: false,
        loadingMore: false,
        hasMoreData: true,
        lastDocument: null,
      );

  InProgressTripsState copyWith({
    List<ItineraryRequest>? trips,
    bool? initialLoading,
    bool? loadingMore,
    bool? hasMoreData,
    DocumentSnapshot? lastDocument,
  }) {
    return InProgressTripsState(
      trips: trips ?? this.trips,
      initialLoading: initialLoading ?? this.initialLoading,
      loadingMore: loadingMore ?? this.loadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }
}
