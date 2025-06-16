import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/application/favorites/collection_itineraries_cubit/collection_itinerary_cubit.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/favorites/favorites_repository.dart';
part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;
  final SnackBarCubit snackBarCubit;
  StreamSubscription<Set<String>>? _favoritesSubscription;

  FavoritesCubit({
    required this.favoritesRepository,
    required this.snackBarCubit,
  }) : super(const FavoritesState()) {
    _favoritesSubscription =
        favoritesRepository.watchUserFavorites().listen((favoriteIds) {
      log("Favorites updated: $favoriteIds");
      emit(state.copyWith(favoriteIds: favoriteIds));
    });
  }

  /// ✅ Toggle favorite status & notify other cubits
  Future<void> toggleFavorite({required TravelItinerary itinerary}) async {
    emit(state.copyWith(isLoading: true));

    final bool isRemoving = itinerary.isLiked ?? false;

    try {
      await favoritesRepository.toggleFavorite(
        itineraryId: itinerary.id,
        isLiked: isRemoving,
      );

      if (isRemoving) {
        final currentContext =
            Navigation.router.routerDelegate.navigatorKey.currentContext;
        if (currentContext != null && currentContext.mounted) {
          // ✅ If unfavoriting, remove from all collections
          currentContext
              .read<CollectionItineraryCubit>()
              .removeItineraryFromAllCollections(itinerary.id!);
        }
      }

      snackBarCubit.showSnackBar(
        isRemoving ? 'Removed from Favorites' : 'Added to Favorites',
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }

    emit(state.copyWith(isLoading: false));
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
