import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:travel_hero/global/internet.dart';
import 'package:travel_hero/repositories/offline_itinerary_repository.dart';
import 'package:travel_hero/src/application/favorites/favorites_cubit/favorites_cubit.dart';
import 'package:travel_hero/src/application/home/home_state.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';

class HomeCubit extends Cubit<HomeState> {
  final OfflineItineraryRepository itineraryRepository;
  final FavoritesCubit favoritesCubit;

  late final StreamSubscription<List<TravelItinerary>> _itinerarySubscription;
  StreamSubscription<FavoritesState>? _favoritesSubscription;

  HomeCubit({required this.itineraryRepository, required this.favoritesCubit})
      : super(HomeInitial()) {
    _subscribeToItineraryUpdates();
    _subscribeToFavorites();
  }

  /// ✅ Subscribes to itinerary updates from repository
  void _subscribeToItineraryUpdates() {
    _itinerarySubscription = itineraryRepository.data
        .startWith(itineraryRepository.currentData ?? [])
        .debounceTime(const Duration(milliseconds: 100))
        .listen(_handleItineraryUpdate, onError: _handleError);
  }

  /// ✅ Subscribes to favorite updates from `FavoritesCubit`
  void _subscribeToFavorites() {
    _favoritesSubscription = favoritesCubit.stream.listen((favoriteState) {
      log("HomeCubit received favorite IDs: ${favoriteState.favoriteIds}");

      if (state is HomeLoaded) {
        // Apply favorites immediately to the existing itineraries
        _updateItineraryFavorites(favoriteState.favoriteIds);
      }
    });
  }

  /// ✅ Fetches itineraries and ensures `isLiked` updates correctly
  Future<void> fetchTravelItineraries() async {
    if (state is HomeLoading) return;

    try {
      emit(HomeLoading());

      final isInternetAvailable = await Internet.hasInternetConnection();
      final result = await itineraryRepository.fetchFromApi(
        isInternetReconnected: isInternetAvailable,
      );

      result.fold(
        (exception) => _emitError(exception.toString()),
        (itineraries) {
          // Apply favorites while loading itineraries
          final updatedItineraries =
              _applyFavorites(favoritesCubit.state.favoriteIds, itineraries);
          emit(HomeLoaded(itineraries: updatedItineraries));
        },
      );
    } catch (e) {
      _emitError("Unexpected error occurred: $e");
    }
  }

  Future<void> fetchMoreItineraries() async {
    if (state is HomeLoaded && !(state as HomeLoaded).isLoadingMore) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(isLoadingMore: true));

      final result = await itineraryRepository.fetchNextPage();

      result.fold(
        (exception) => emit(HomeError(message: exception.toString())),
        (newItineraries) {
          final updatedList =
              List<TravelItinerary>.from(currentState.itineraries)
                ..addAll(newItineraries);
          final finalUpdatedList =
              _applyFavorites(favoritesCubit.state.favoriteIds, updatedList);

          emit(HomeLoaded(itineraries: finalUpdatedList, isLoadingMore: false));
        },
      );
    }
  }

  /// ✅ Updates `isLiked` when either itineraries or favorites update
  void _updateItineraryFavorites(Set<String> favoriteIds) {
    if (state is! HomeLoaded) return;

    final currentItineraries = (state as HomeLoaded).itineraries;
    final updatedItineraries = _applyFavorites(favoriteIds, currentItineraries);

    emit(HomeLoaded(itineraries: updatedItineraries));
  }

  /// ✅ Applies `isLiked` based on favorites and returns updated itineraries
  List<TravelItinerary> _applyFavorites(
      Set<String> favoriteIds, List<TravelItinerary> itineraries) {
    log("Applying favorites to itineraries: $favoriteIds");

    return itineraries.map((itinerary) {
      bool isLiked = favoriteIds.contains(itinerary.id);
      log("Itinerary ID: ${itinerary.id} -> isLiked: $isLiked");
      return itinerary.copyWith(isLiked: isLiked);
    }).toList();
  }

  void _handleItineraryUpdate(List<TravelItinerary> itineraries) {
    if (itineraries.isNotEmpty) {
      final updatedItineraries =
          _applyFavorites(favoritesCubit.state.favoriteIds, itineraries);
      emit(HomeLoaded(itineraries: updatedItineraries));
    }
  }

  void _handleError(dynamic error) {
    emit(HomeError(message: error.toString()));
  }

  void _emitError(String message) {
    emit(HomeError(message: message));
  }

  @override
  Future<void> close() async {
    await _itinerarySubscription.cancel();
    await _favoritesSubscription?.cancel();
    return super.close();
  }
}
