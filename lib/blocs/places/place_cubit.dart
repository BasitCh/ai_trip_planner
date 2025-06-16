// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:travel_hero/repositories/google_places/google_places_repository.dart';
import 'package:travel_hero/repositories/google_places/models/place_autocomplete_response.dart';
part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  final GooglePlacesRepository placeRepository;

  PlaceCubit({required this.placeRepository}) : super(PlaceInitial());

  void searchPlaces(String query, String? isoCountryCode) async {
    emit(PlaceLoading());
    try {

      final places = await placeRepository.searchPlaces(query,isoCountryCode);
      emit(PlaceLoaded(places));
    } catch (e) {
      emit(PlaceError('Failed to load places'));
    }
  }

  void clearState() {
    emit(PlaceInitial());
  }
}
