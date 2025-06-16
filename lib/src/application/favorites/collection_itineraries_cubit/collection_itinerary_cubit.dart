import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/blocs/modal/modal_bloc.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/application/favorites/favorites_cubit/favorites_cubit.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/favorites/favorites_repository.dart';
import 'package:travel_hero/src/presentation/favorites/widgets/collection_grid_view.dart';
import 'package:travel_hero/src/presentation/favorites/widgets/create_list_button.dart';
import 'package:travel_hero/src/presentation/favorites/widgets/create_list_ui.dart';
import 'package:travel_hero/src/presentation/favorites/widgets/delete_collection_popup.dart';
import 'package:travel_hero/src/presentation/favorites/widgets/favorite_button.dart';
import 'package:widgets_book/widgets_book.dart';

part 'collection_itinerary_state.dart';

class CollectionItineraryCubit extends Cubit<CollectionItineraryState> {
  final FavoritesRepository favoritesRepository;
  final FavoritesCubit favoritesCubit;
  final SnackBarCubit snackBarCubit;
  final ModalBloc modalBloc;
  StreamSubscription<FavoritesState>? _favoritesSubscription;
  final int pageLimit = 10;

  CollectionItineraryCubit({
    required this.favoritesRepository,
    required this.favoritesCubit,
    required this.snackBarCubit,
    required this.modalBloc,
  }) : super(const CollectionItineraryState()) {
    _subscribeToFavorites();
  }

  /// ✅ Subscribe to favorite updates
  void _subscribeToFavorites() {
    _favoritesSubscription = favoritesCubit.stream.listen((favoriteState) {
      log("CollectionItineraryCubit: Received favorite update");
      _updateItineraryFavorites(favoriteState.favoriteIds);
    });
  }

  /// ✅ Load collections with separate state tracking
  Future<void> loadCollections() async {
    emit(state.copyWith(loadingCollection: true));

    final result = await favoritesRepository.fetchAllCollections();
    result.fold(
      (failure) {
        emit(state.copyWith(
            loadingCollection: false, errorMessage: failure.toString()));
      },
      (collections) {
        emit(
            state.copyWith(loadingCollection: false, collections: collections));
      },
    );
  }

  /// ✅ Assign itinerary to an existing collection
  Future<void> assignToCollection({
    required Collection? collection,
    required String? itineraryId,
    required String? imageUrl,
  }) async {
    emit(state.copyWith(assigningToCollection: true));

    final result = await favoritesRepository.addItineraryToCollection(
      collectionId: collection?.id,
      itineraryId: itineraryId,
      imageUrl: imageUrl,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          assigningToCollection: false, errorMessage: failure.toString())),
      (_) {
        final updatedCollections = state.collections.map((coll) {
          if (coll.id == collection!.id) {
            return coll.copyWith(
              itineraries: coll.itineraries.contains(itineraryId)
                  ? coll.itineraries // 🔥 Prevent duplicate addition
                  : [...coll.itineraries, itineraryId ?? ''],
              image: coll.image.isEmpty ? imageUrl : coll.image,
            );
          }
          return coll; // 🔥 Fix: Return `coll` instead of `collection`
        }).toList();
        snackBarCubit.showSnackBar('Saved to ${collection?.name}');
        emit(state.copyWith(
            assigningToCollection: false, collections: updatedCollections));
      },
    );
    modalBloc.add(ModalPopped());
  }

  /// ✅ Create a new collection and assign itinerary
  Future<void> createCollectionAndAssign({
    required String? collectionName,
    required String? itineraryId,
    required String? imageUrl,
  }) async {
    emit(state.copyWith(creatingCollection: true));

    final result = await favoritesRepository.createCollection(
      collectionName: collectionName,
      imageUrl: imageUrl,
    );

    result.fold(
        (failure) => emit(state.copyWith(
            creatingCollection: false,
            errorMessage: failure.toString())), (collection) {
      emit(
        state.copyWith(creatingCollection: false),
      );
      assignToCollection(
        collection: collection,
        itineraryId: itineraryId,
        imageUrl: imageUrl,
      );
      loadCollections();
    });
  }

  /// ✅ Delete a collection and update UI
  Future<void> deleteCollection({required String? collectionId}) async {
    if (collectionId == null) return;

    modalBloc.add(ShowGeneralDialogEvent(DeleteCollectionPopup(
      onCancel: () {
        modalBloc.add(ModalPopped());
      },
      onConfirm: () async {
        modalBloc.add(ModalPopped());
        emit(state.copyWith(deletingCollection: true));

        final result = await favoritesRepository.deleteCollection(
            collectionId: collectionId);

        result.fold(
          (failure) {
            emit(state.copyWith(
                deletingCollection: false, errorMessage: failure.toString()));
          },
          (_) {
            final updatedCollections = state.collections
                .where((collection) => collection.id != collectionId)
                .toList();

            final currentContext =
                Navigation.router.routerDelegate.navigatorKey.currentContext;
            if (currentContext != null && currentContext.mounted) {
              currentContext.pop();
            }

            emit(state.copyWith(
              deletingCollection: false,
              collections: updatedCollections,
            ));
          },
        );
      },
    )));
  }

  /// ✅ Remove itinerary from collection
  Future<void> removeItineraryFromCollection({
    required Collection? collection,
    required String itineraryId,
  }) async {
    emit(state.copyWith(removingFromCollection: true));

    final result = await favoritesRepository.removeItineraryFromCollection(
      collectionId: collection?.id,
      itineraryId: itineraryId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          removingFromCollection: false, errorMessage: failure.toString())),
      (_) {
        final updatedCollections = state.collections.map((collect) {
          if (collect.id == collection?.id) {
            return collect.copyWith(
              itineraries:
                  collect.itineraries.where((id) => id != itineraryId).toList(),
            );
          }
          return collect;
        }).toList();

        // ✅ Remove itinerary from collection list view
        final updatedItineraries = state.itineraries
            .where((itinerary) => itinerary.id != itineraryId)
            .toList();

        emit(state.copyWith(
          removingFromCollection: false,
          collections: updatedCollections,
          itineraries: updatedItineraries,
        ));
        snackBarCubit
            .showSnackBar('Itinerary removed from ${collection?.name}');
      },
    );
    modalBloc.add(ModalPopped());
  }

  /// ✅ Remove itinerary from all collections when unfavorited
  Future<void> removeItineraryFromAllCollections(String itineraryId) async {
    emit(state.copyWith(removingFromCollection: true));

    final List<Collection> updatedCollections = [];

    for (final collection in state.collections) {
      if (collection.itineraries.contains(itineraryId)) {
        final result = await favoritesRepository.removeItineraryFromCollection(
          collectionId: collection.id,
          itineraryId: itineraryId,
        );

        result.fold(
          (failure) =>
              log("❌ Failed to remove from collection: ${collection.id}"),
          (_) {
            log("✅ Removed itinerary from collection: ${collection.id}");
            updatedCollections.add(
              collection.copyWith(
                itineraries: collection.itineraries
                    .where((id) => id != itineraryId)
                    .toList(),
              ),
            );
          },
        );
      } else {
        updatedCollections.add(collection);
      }
    }

    final updatedItineraries = state.itineraries
        .where((itinerary) => itinerary.id != itineraryId)
        .toList();

    emit(state.copyWith(
      removingFromCollection: false,
      collections: updatedCollections,
      itineraries: updatedItineraries,
    ));
    modalBloc.add(ModalPopped());
  }

  void showItineraryCollectionSheet({required TravelItinerary itinerary}) {
    final currentContext =
        Navigation.router.routerDelegate.navigatorKey.currentContext;
    if (currentContext != null && currentContext.mounted) {
      modalBloc.add(
        ShowBaseBottomSheetEvent(
            'Add to Favorites',
            CollectionGridView(
              itinerary: itinerary,
              onCollectionTap: ({collection, needToRemove}) {
                if (needToRemove ?? false) {
                  removeItineraryFromCollection(
                    collection: collection,
                    itineraryId: itinerary.id!,
                  );
                } else {
                  String image = itinerary.coverUrls?.first;
                  assignToCollection(
                      collection: collection,
                      itineraryId: itinerary.id,
                      imageUrl: image);
                }
              },
              physics: const NeverScrollableScrollPhysics(),
            ),
            trailingWidget: FavoriteButton(
              itinerary: itinerary,
              onPressed: () {
                favoritesCubit.toggleFavorite(itinerary: itinerary);
              },
            ),
            bottomSheetHeight: currentContext.height * 0.6,
            bottomWidget: CreateListButton(
          onCreatePressed: () {
            modalBloc.add(ModalPopped());
            // Delay opening the second sheet to ensure the first one is closed
            Future.delayed(Duration(milliseconds: 200), () {
              modalBloc.add(
                ShowBaseBottomSheetEvent(
                  '',
                  // ignore: use_build_context_synchronously
                  bottomSheetHeight: currentContext.height * 0.3,
                  onClose: () {
                    modalBloc.add(ModalPopped());
                  },
                  CreateListUi(
                    onAddPressed: (collectionName) {
                      final image = itinerary.coverUrls?.first;
                      createCollectionAndAssign(
                          collectionName: collectionName,
                          itineraryId: itinerary.id,
                          imageUrl: image);
                    },
                  ),
                ),
              );
            });
          },
        )),
      );
    }
  }

  /// ✅ Fetch initial itineraries for a collection
  Future<void> fetchCollectionItineraries({
    required List<String>? itineraryIds,
  }) async {
    if (itineraryIds == null || itineraryIds.isEmpty) {
      emit(state.copyWith(isLoading: false, itineraries: []));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final result = await favoritesRepository.fetchItinerariesForCollection(
      itineraryIds: itineraryIds,
      lastDocument: null,
      limit: pageLimit,
    );

    result.fold(
      (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.toString())),
      (data) {
        final updatedItineraries =
            _applyFavorites(favoritesCubit.state.favoriteIds, data.itineraries);

        emit(state.copyWith(
          isLoading: false,
          itineraries: updatedItineraries,
          lastFetchedDocument: data.lastDocument,
          hasMoreData: data.itineraries.length == pageLimit,
        ));
      },
    );
  }

  /// ✅ Load more itineraries (Pagination)
  Future<void> loadMoreCollectionItineraries(List<String> itineraryIds) async {
    if (!state.hasMoreData) return;

    emit(state.copyWith(isPaginating: true));

    final result = await favoritesRepository.fetchItinerariesForCollection(
      itineraryIds: itineraryIds,
      lastDocument: state.lastFetchedDocument,
      limit: pageLimit,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          isPaginating: false, errorMessage: failure.toString())),
      (data) {
        final updatedList = [
          ...state.itineraries,
          ..._applyFavorites(favoritesCubit.state.favoriteIds, data.itineraries)
        ];

        emit(state.copyWith(
          isPaginating: false,
          itineraries: updatedList,
          lastFetchedDocument: data.lastDocument,
          hasMoreData: data.itineraries.length == pageLimit,
        ));
      },
    );
  }

  /// ✅ Updates `isLiked` when favorites update
  void _updateItineraryFavorites(Set<String> favoriteIds) {
    if (state.itineraries.isEmpty) return;

    final updatedItineraries = _applyFavorites(favoriteIds, state.itineraries);
    emit(state.copyWith(itineraries: updatedItineraries));
  }

  /// ✅ Apply favorites to itineraries
  List<TravelItinerary> _applyFavorites(
      Set<String> favoriteIds, List<TravelItinerary> itineraries) {
    return itineraries.map((itinerary) {
      return itinerary.copyWith(isLiked: favoriteIds.contains(itinerary.id));
    }).toList();
  }

  @override
  Future<void> close() async {
    await _favoritesSubscription?.cancel();
    return super.close();
  }
}
