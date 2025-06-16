import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/filter_traveler_itinerary_cubit/filter_traveler_itinerary_state.dart';
import 'package:travel_hero/src/infrastructure/itinerary/filtered_itinerary_repository.dart';


class FilterTravelerItineraryCubit extends Cubit<FilterTravelerItineraryState> {
  final FilteredItineraryRepository filterItineraryRepository;

  FilterTravelerItineraryCubit({required this.filterItineraryRepository}) : super(FilterTravelerItineraryState.initial());

  Future<void> loadInitial(ItineraryFilterType filter) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await filterItineraryRepository.fetchFilteredItineraries(
      filterType: filter,
      isRefresh: true,
    );

    result.fold(
      (e) => emit(state.copyWith(isLoading: false, error: e.toString())),
      (filtered) => emit(state.copyWith(
        itineraries: filtered,
        filter: filter,
        isLoading: false,
        hasMore: filterItineraryRepository.hasMore,
      )),
    );
  }

  Future<void> loadNextPage() async {
    if (!state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    final result = await filterItineraryRepository.fetchFilteredItineraries(
      filterType: state.filter,
      isRefresh: false,
    );

    result.fold(
      (e) => emit(state.copyWith(isLoading: false, error: e.toString())),
      (next) => emit(state.copyWith(
        itineraries: [...state.itineraries, ...next],
        hasMore: filterItineraryRepository.hasMore,
        isLoading: false,
      )),
    );
  }

  void resetTravelerFilterPlan() {
    loadInitial(ItineraryFilterType.all);
  }
}
