part of 'collection_itinerary_cubit.dart';

class CollectionItineraryState extends Equatable {
  final bool isLoading;
  final bool isPaginating;
  final bool hasMoreData;
  final List<TravelItinerary> itineraries;
  final DocumentSnapshot? lastFetchedDocument;
  final String? errorMessage;
  final bool loadingCollection;
  final bool creatingCollection;
  final bool assigningToCollection;
  final bool removingFromCollection;
  final bool deletingCollection;
  final List<Collection> collections;

  const CollectionItineraryState({
    this.isLoading = false,
    this.isPaginating = false,
    this.hasMoreData = true,
    this.itineraries = const [],
    this.lastFetchedDocument,
    this.errorMessage,
    this.loadingCollection = false,
    this.creatingCollection = false,
    this.assigningToCollection = false,
    this.removingFromCollection = false,
    this.deletingCollection = false,
    this.collections = const [],
  });

  CollectionItineraryState copyWith({
    bool? isLoading,
    bool? isPaginating,
    bool? hasMoreData,
    List<TravelItinerary>? itineraries,
    DocumentSnapshot? lastFetchedDocument,
    String? errorMessage,
    bool? loadingCollection,
    bool? creatingCollection,
    bool? assigningToCollection,
    bool? removingFromCollection,
    bool? deletingCollection,
    List<Collection>? collections,
  }) {
    return CollectionItineraryState(
      isLoading: isLoading ?? this.isLoading,
      isPaginating: isPaginating ?? this.isPaginating,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      itineraries: itineraries ?? this.itineraries,
      lastFetchedDocument: lastFetchedDocument,
      errorMessage: errorMessage,
      loadingCollection: loadingCollection ?? this.loadingCollection,
      creatingCollection: creatingCollection ?? this.creatingCollection,
      assigningToCollection:
          assigningToCollection ?? this.assigningToCollection,
      removingFromCollection:
          removingFromCollection ?? this.removingFromCollection,
          deletingCollection: deletingCollection ?? this.deletingCollection,
      collections: collections ?? this.collections,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isPaginating,
        hasMoreData,
        itineraries,
        lastFetchedDocument,
        errorMessage,
        loadingCollection,
        creatingCollection,
        assigningToCollection,
        deletingCollection,
        collections
      ];
}
