import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/favorites/collection_itineraries_cubit/collection_itinerary_cubit.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/home/widgets/itinerary_card.dart';
import 'package:widgets_book/widgets_book.dart';

class CollectionItinerariesPage extends StatefulWidget {
  const CollectionItinerariesPage({required this.collection, super.key});

  final Collection collection;

  @override
  State<CollectionItinerariesPage> createState() =>
      _CollectionItinerariesPageState();
}

class _CollectionItinerariesPageState extends State<CollectionItinerariesPage> {
  final ScrollController _scrollController = ScrollController();
  late final CollectionItineraryCubit collectionItineraryCubit;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
    collectionItineraryCubit = context.read<CollectionItineraryCubit>()
      ..fetchCollectionItineraries(itineraryIds: widget.collection.itineraries);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionItineraryCubit, CollectionItineraryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.collection.name,
              style: titleXSmallWhite?.copyWith(color: AppColors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: state.deletingCollection
                    ? AppButtonLoading(
                        color: AppColors.black,
                      )
                    : IconButton(
                        onPressed: () {
                          collectionItineraryCubit.deleteCollection(
                              collectionId: widget.collection.id);
                        },
                        icon: Assets.icons.icDeleteBlack.svg(),
                      ),
              )
            ],
          ),
          body: state.isLoading
              ? Center(
                  child: AppButtonLoading(
                    color: AppColors.primary,
                  ),
                )
              : state.itineraries.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: state.itineraries.length +
                          (state.isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.itineraries.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                                child: AppButtonLoading(
                              color: AppColors.primary,
                            )),
                          );
                        }
                        return ItineraryCard(
                          itinerary: state.itineraries[index],
                          isViewOnly: true,
                        );
                      },
                    )
                  : const Center(child: Text('No itineraries found')),
        );
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context
          .read<CollectionItineraryCubit>()
          .loadMoreCollectionItineraries(widget.collection.itineraries);
    }
  }
}
