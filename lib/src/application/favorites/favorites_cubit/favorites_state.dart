part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final bool isLoading;
  final Set<String> favoriteIds;
  final String? errorMessage;

  const FavoritesState({
    this.isLoading = false,
    this.favoriteIds = const {},
    this.errorMessage,
  });

  /// ✅ `copyWith` function to update only specific fields
  FavoritesState copyWith({
    bool? isLoading,
    bool? loadingCollection,
    bool? creatingCollection,
    bool? assigningToCollection,
    Set<String>? favoriteIds,
    List<Collection>? collections,
    String? errorMessage,
  }) {
    return FavoritesState(
      isLoading: isLoading ?? this.isLoading,

      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMessage: errorMessage, // Can be explicitly set to null
    );
  }

  @override
  List<Object?> get props => [isLoading, favoriteIds, errorMessage];
}
