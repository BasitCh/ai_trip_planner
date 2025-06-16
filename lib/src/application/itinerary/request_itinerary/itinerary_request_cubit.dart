// request_trip_plan_cubit.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/destination_search_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
part 'itinerary_request_state.dart';

enum DateSelectionMethod {
  range, // startDate & endDate
  length, // month & total days
}

enum ItineraryRequestStatus {
  pending,
  inProgress,
  accepted,
  rejected;

  String get text => name;
}

class ItineraryRequestCubit extends Cubit<ItineraryRequestState> {
  final ItineraryRepository itineraryRepository;
  final SnackBarCubit snackBarCubit;

  ItineraryRequestCubit({
    required this.itineraryRepository,
    required this.snackBarCubit,
  }) : super(ItineraryRequestState(
          itineraryRequest: ItineraryRequest(
              id: "",
              travellerId: '',
              travellerName: '',
              placeImage: "",
              placeName: "",
              placeDescription: '',
              people: 1,
              duration: 1,
              mood: "",
              startDate: Timestamp.now(),
              endDate: Timestamp.now(),
              selectedMonth: '',
              status: ItineraryRequestStatus.pending.name,
              createdAt: Timestamp.now(),
              travelHeroId: "",
              travelHeroName: "",
              travelHeroProfileUrl: '',
              isRead: false,
              dateSelectionMethod: DateSelectionMethod.range.name),
        ));

  TextEditingController noOfGuestController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // **Update Selected Destination**
  void updateSelectedPlace(Place place) {
    emit(state.copyWith(
      itineraryRequest: state.itineraryRequest.copyWith(
          placeName: place.placeName,
          placeImage: place.imageUrl,
          placeDescription: place.description),
    ));
  }

  // **Update Selected Mood**
  void updateSelectedMood(String mood) {
    emit(state.copyWith(
      itineraryRequest: state.itineraryRequest.copyWith(mood: mood),
    ));
  }

  // **Switch Between Date Selection & Trip Length Mode**
  void toggleDateSelectionMethod(DateSelectionMethod method) {
    emit(state.copyWith(
      dateSelectionMethod: method,
      itineraryRequest: method == DateSelectionMethod.range
          ? state.itineraryRequest.copyWith(
              duration: null,
              selectedMonth: null,
              dateSelectionMethod: DateSelectionMethod.range.name)
          : state.itineraryRequest.copyWith(
              startDate: null,
              endDate: null,
              dateSelectionMethod: DateSelectionMethod.length.name),
    ));
  }

  // **Update Start & End Dates (Date Range Mode)**
  void updateDates(DateTime? startDate, DateTime? endDate) {
    if (state.dateSelectionMethod == DateSelectionMethod.range) {
      emit(state.copyWith(
        itineraryRequest: state.itineraryRequest.copyWith(
          startDate: Timestamp.fromDate(startDate ?? DateTime.now()),
          endDate: Timestamp.fromDate(endDate ?? DateTime.now()),
          duration: endDate
              ?.difference(startDate ?? DateTime.now())
              .inDays, // Auto-calculate duration
        ),
      ));
    }
  }

  // **Update Selected Month**
  void updateSelectedMonth(String month) {
    if (state.dateSelectionMethod == DateSelectionMethod.length) {
      emit(state.copyWith(
        itineraryRequest: state.itineraryRequest.copyWith(selectedMonth: month),
      ));
    }
  }

  // **Update Trip Length & Selected Month (Trip Length Mode)**
  void updateTripLength(int length) {
    if (state.dateSelectionMethod == DateSelectionMethod.length) {
      emit(state.copyWith(
        itineraryRequest: state.itineraryRequest.copyWith(
          duration: length,
        ),
      ));
    }
  }

  // **Update Number of Guests**
  void updateGuest(String count) {
    noOfGuestController.text = count;
    emit(state.copyWith(
      itineraryRequest:
          state.itineraryRequest.copyWith(people: int.parse(count)),
    ));
  }

  // **Update Name**
  void updateName(String name) {
    nameController.text = name;
    emit(state.copyWith(
      itineraryRequest: state.itineraryRequest.copyWith(travellerName: name),
    ));
  }

  // **Submit itinerary request to travel hero**
  Future<void> submitRequest({
    required String? travelHeroId,
    required String? travelHeroName,
    required String travelHeroProfileUrl,
  }) async {
    emit(state.copyWith(submittingRequest: true));
    final response = await itineraryRepository.submitTripRequest(
        request: state.itineraryRequest.copyWith(
      travelHeroId: travelHeroId,
      travelHeroName: travelHeroName,
      travelHeroProfileUrl: travelHeroProfileUrl,
    ));
    response.fold(
      (exception) {
        snackBarCubit.showSnackBar(exception.toString());
        emit(state.copyWith(submittingRequest: false));
      },
      (itineraryRequest) async {
        emit(state.copyWith(submittingRequest: false));
        final currentContext =
            Navigation.router.routerDelegate.navigatorKey.currentContext;
        if (currentContext != null && currentContext.mounted) {
          currentContext.read<MainNavBarCubit>().changeBottomNavBar(0);
          currentContext.goNamed(NavigationPath.homeRouteUri);
        }
      },
    );
  }

  // **Clear State**
  void clearState() {
    emit(ItineraryRequestState(
      itineraryRequest: ItineraryRequest(
          id: "",
          travellerId: '',
          travellerName: '',
          placeImage: "",
          placeName: "",
          placeDescription: '',
          people: 1,
          duration: 1,
          mood: "",
          startDate: Timestamp.now(),
          endDate: Timestamp.now(),
          travelHeroId: '',
          travelHeroName: '',
          travelHeroProfileUrl: '',
          selectedMonth: '',
          status: ItineraryRequestStatus.pending.name,
          createdAt: Timestamp.now(),
          isRead: false,
          dateSelectionMethod: DateSelectionMethod.range.name),
    ));
  }

  @override
  Future<void> close() {
    noOfGuestController.dispose();
    nameController.dispose();
    return super.close();
  }
}
