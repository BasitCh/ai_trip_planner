import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart'; // Assuming you have a repository

part 'review_request_state.dart';

class ReviewRequestCubit extends Cubit<ReviewRequestState> {
  ReviewRequestCubit({
    required this.request,
    required this.repository,
    required this.snackBarCubit,
  }) : super(ReviewRequestState(
          progressingRequest: false,
          decliningRequest: false,
          request: request,
        )) {
    dateFormat = DateFormat('yyyy-MM-dd');
    _initializeTripInfo();
  }

  final ItineraryRequest request;
  late List<Map<String, String>> tripInfo;
  final ItineraryRepository repository;
  late DateFormat dateFormat;
  final SnackBarCubit snackBarCubit;

  void _initializeTripInfo() {
    tripInfo = [
      {'label': 'Duration', 'value': '${request.duration} days'},
      {'label': 'Mood', 'value': request.mood ?? ''},
      {'label': 'Destination', 'value': request.placeName ?? ''},
      {'label': 'Persons', 'value': '${request.people} People'},
    ];

    if (request.dateSelectionMethod == 'range') {
      tripInfo.addAll([
        {
          'label': 'Start Date',
          'value':
              dateFormat.format(request.startDate?.toDate() ?? DateTime.now())
        },
        {
          'label': 'End Date',
          'value':
              dateFormat.format(request.endDate?.toDate() ?? DateTime.now())
        },
      ]);
    } else {
      tripInfo.add(
          {'label': 'Selected Month', 'value': request.selectedMonth ?? ''});
    }
  }

  Future<void> addRequestToInProgress(
      {required TextEditingController controller}) async {
    emit(state.copyWith(progressingRequest: true));
    final result = await repository.updateRequest(
        request:
            request.copyWith(status: ItineraryRequestStatus.inProgress.name));
    result.fold(
      (error) {
        emit(state.copyWith(progressingRequest: false));
        snackBarCubit.showSnackBar(error.toString());
      },
      (_) {
        controller.text = generateTripPrompt();
        emit(state.copyWith(
            progressingRequest: false,
            request: state.request
                ?.copyWith(status: ItineraryRequestStatus.inProgress.name)));
      },
    );
  }

  Future<void> declineRequest() async {
    emit(state.copyWith(decliningRequest: true));
    final result = await repository.updateRequest(
        request:
            request.copyWith(status: ItineraryRequestStatus.rejected.name));
    result.fold(
      (error) {
        emit(state.copyWith(decliningRequest: false));
        snackBarCubit.showSnackBar(error.toString());
      },
      (_) {
        emit(state.copyWith(decliningRequest: false));
        final currentContext =
            Navigation.router.routerDelegate.navigatorKey.currentContext;
        if (currentContext != null && currentContext.mounted) {
          currentContext.pop();
        }
      },
    );
  }

  String generateTripPrompt() {
    String destination = request.placeName ?? 'a destination of your choice';
    String mood = request.mood != null && request.mood!.isNotEmpty
        ? ' with a ${request.mood} experience'
        : '';
    String duration = request.duration != null
        ? '${request.duration} days'
        : 'a flexible number of days';
    String persons =
        request.people != null ? '${request.people} people' : 'a small group';

    String dateInfo = '';
    if (request.dateSelectionMethod == DateSelectionMethod.range.name &&
        request.startDate != null &&
        request.endDate != null) {
      dateInfo =
          " starting from ${dateFormat.format(request.startDate?.toDate() ?? DateTime.now())} to ${dateFormat.format(request.endDate?.toDate() ?? DateTime.now())}.";
    } else if (request.selectedMonth != null) {
      dateInfo = " sometime in ${request.selectedMonth}.";
    }

    return "Plan a trip to $destination for $persons$dateInfo The trip should last for $duration$mood.";
  }
}
