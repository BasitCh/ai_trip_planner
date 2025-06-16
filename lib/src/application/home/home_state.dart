import 'package:equatable/equatable.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<TravelItinerary> itineraries;
  final bool isLoadingMore;

  const HomeLoaded({required this.itineraries, this.isLoadingMore = false});

  HomeLoaded copyWith({
    List<TravelItinerary>? itineraries,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      itineraries: itineraries ?? this.itineraries,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [itineraries, isLoadingMore];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
