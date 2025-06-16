part of 'place_cubit.dart';

abstract class PlaceState {}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final List<Prediction> places;

  PlaceLoaded(this.places);
}

class PlaceError extends PlaceState {
  final String message;

  PlaceError(this.message);
}