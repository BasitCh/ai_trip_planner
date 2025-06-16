part of 'destination_search_cubit.dart';

abstract class DestinationSearchState {}

class DestinationSearchInitial extends DestinationSearchState {}

class DestinationSearchLoading extends DestinationSearchState {}

class DestinationSearchLoaded extends DestinationSearchState {
  final List<Place> places;

  DestinationSearchLoaded(this.places);
}

class DestinationSearchError extends DestinationSearchState {
  final String message;

  DestinationSearchError(this.message);
}