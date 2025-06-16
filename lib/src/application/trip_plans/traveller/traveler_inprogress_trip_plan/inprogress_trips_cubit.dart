import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';
import 'inprogress_trips_state.dart';

class InProgressTripsCubit extends Cubit<InProgressTripsState> {
  final ItineraryRepository repository;
  StreamSubscription? _subscription;

  InProgressTripsCubit({required this.repository})
      : super(InProgressTripsState.initial()) {
    loadInprogressRequests();
  }

Future<void> loadInprogressRequests() async {
  if (state.initialLoading) return;

  emit(state.copyWith(initialLoading: true));

  try {
    _subscription?.cancel();

    _subscription =
        repository.watchInProgressRequests().listen((result) {
      final newRequests = result.first;
      final lastDoc = result.second;

      emit(state.copyWith(
        trips: newRequests,
        lastDocument: lastDoc,
        hasMoreData: newRequests.length == requestsPageLimit,
        initialLoading: false,
        loadingMore: false,
      ));
    });
  } catch (e) {
    emit(state.copyWith(initialLoading: false));
  }
}


Future<void> loadMoreRequests() async {
  if (state.loadingMore || !state.hasMoreData || state.lastDocument == null) return;

  emit(state.copyWith(loadingMore: true));

  try {
    final result = await repository
        .fetchInProgressRequests(lastDocument: state.lastDocument!);

    final newRequests = result.first;
    final lastDoc = result.second;

    emit(state.copyWith(
      trips: [...state.trips, ...newRequests],
      lastDocument: lastDoc,
      hasMoreData: newRequests.length == requestsPageLimit,
      loadingMore: false,
    ));
  } catch (e) {
    emit(state.copyWith(loadingMore: false));
  }
}


  
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
