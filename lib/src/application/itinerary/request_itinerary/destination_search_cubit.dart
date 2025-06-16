import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/repositories/google_places/google_places_repository.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
part 'destination_search_states.dart';

class Place {
  final String placeName;
  final String description;
  final String? placeId;
  final String? imageUrl;
  Place(
      {required this.description,
      this.placeId,
      this.imageUrl,
      required this.placeName});
}

class DestinationSearchCubit extends Cubit<DestinationSearchState> {
  final GooglePlacesRepository placeRepository;
  DestinationSearchCubit({required this.placeRepository})
      : super(DestinationSearchInitial());
  final TextEditingController searchController = TextEditingController();
  bool isDestinationSelectDone = false;
  void searchPlaces(String input, String? isoCountryCode) async {
    isDestinationSelectDone = false;
    emit(DestinationSearchLoading());
    try {
      placeRepository.searchPlaces(input, isoCountryCode).then((place) async {
        List<Place> places = [];
        for (var prediction in place) {
          String? imageUrl =
              await placeRepository.fetchSingleImage(prediction.place_id);
          places.add(Place(
            description: prediction.description,
            placeId: prediction.place_id,
            imageUrl: imageUrl,
            placeName: prediction.structuredFormatting.mainText,
          ));
        }
        emit(DestinationSearchLoaded(places));
      });
    } catch (e) {
      emit(DestinationSearchError('Failed to load places'));
    }
  }

  void clearState() {
    isDestinationSelectDone = false;
    searchController.clear();
    emit(DestinationSearchInitial());
  }

  void selectedDestination(Place selectedPlace, BuildContext context) {
    isDestinationSelectDone = true;
    searchController.text = selectedPlace.placeName;
    context.read<ItineraryRequestCubit>().updateSelectedPlace(selectedPlace);
    emit(DestinationSearchInitial());
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
