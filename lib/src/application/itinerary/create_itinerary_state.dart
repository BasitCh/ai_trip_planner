import 'package:equatable/equatable.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';

class CreateItineraryState extends Equatable {
  final TravelItinerary? travelItinerary;
  final ItineraryRequest? itineraryRequest;
  final bool? creatingItinerary;
  final bool? savingItinerary;
  final bool? openedFromHome;
  final bool? isViewOnly;
  final bool? loadingItinerary;
  final bool? updatingItinerary;
  final bool? unlockingItinerary;

  @override
  List<Object?> get props => [
        travelItinerary,
        creatingItinerary,
        savingItinerary,
        openedFromHome,
        updatingItinerary,
        unlockingItinerary,
        loadingItinerary,
        isViewOnly,
      ];

  const CreateItineraryState({
    this.travelItinerary,
    this.itineraryRequest,
    this.creatingItinerary = false,
    this.savingItinerary = false,
    this.openedFromHome = false,
    this.loadingItinerary = false,
    this.isViewOnly,
    this.updatingItinerary = false,
    this.unlockingItinerary = false,
  });

  CreateItineraryState copyWith({
    TravelItinerary? travelItinerary,
    ItineraryRequest? itineraryRequest,
    bool? creatingItinerary,
    bool? savingItinerary,
    bool? openedFromHome,
    bool? updatingItinerary,
    bool? unlockingItinerary,
    bool? loadingItinerary,
    bool? isViewOnly,
  }) {
    return CreateItineraryState(
      travelItinerary: travelItinerary ?? this.travelItinerary,
      itineraryRequest: itineraryRequest ?? this.itineraryRequest,
      creatingItinerary: creatingItinerary ?? this.creatingItinerary,
      savingItinerary: savingItinerary ?? this.savingItinerary,
      openedFromHome: openedFromHome ?? this.openedFromHome,
      updatingItinerary: updatingItinerary ?? this.updatingItinerary,
      unlockingItinerary: unlockingItinerary ?? this.unlockingItinerary,
      loadingItinerary: loadingItinerary ?? this.loadingItinerary,
      isViewOnly: isViewOnly ?? this.isViewOnly,
    );
  }
}
