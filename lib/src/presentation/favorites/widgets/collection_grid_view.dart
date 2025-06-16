import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/favorites/collection_itineraries_cubit/collection_itinerary_cubit.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/presentation/favorites/widgets/collection_item_card.dart';
import 'package:widgets_book/widgets_book.dart';

class CollectionGridView extends StatefulWidget {
  const CollectionGridView(
      {required this.onCollectionTap, this.itinerary, this.physics, super.key});

  final ScrollPhysics? physics;
  final TravelItinerary? itinerary;
  final Function({Collection? collection, bool? needToRemove}) onCollectionTap;

  @override
  State<CollectionGridView> createState() => _CollectionGridViewState();
}

class _CollectionGridViewState extends State<CollectionGridView> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionItineraryCubit>().loadCollections();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectionItineraryCubit, CollectionItineraryState>(
      listener: (context, state) {
        log("FavoritesCubit State Updated: collections=${state.collections.length}");
      },
      builder: (context, state) {
        return state.loadingCollection
            ? Center(
                child: AppButtonLoading(
                  color: AppColors.primary,
                ),
              )
            : state.collections.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    physics: widget.physics,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: state.collections.length,
                    itemBuilder: (context, index) {
                      final collection = state.collections[index];
                      final bool isItineraryInCollection =
                          collection.itineraries.contains(widget.itinerary?.id);

                      return CollectionItemCard(
                        collection: collection,
                        isSelected: isItineraryInCollection,
                        onTap: () {
                          widget.onCollectionTap(
                              collection: collection,
                              needToRemove: isItineraryInCollection);
                        },
                      );
                    })
                : Center(
                    child: Text('No Collection Found'),
                  );
      },
    );
  }
}
