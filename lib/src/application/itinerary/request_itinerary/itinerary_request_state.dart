part of 'itinerary_request_cubit.dart';

class ItineraryRequestState extends Equatable {
  final ItineraryRequest itineraryRequest;
  final DateSelectionMethod
      dateSelectionMethod; // Determines if range or length is selected

  final bool? submittingRequest;

  const ItineraryRequestState({
    required this.itineraryRequest,
    this.dateSelectionMethod = DateSelectionMethod.range,
    this.submittingRequest = false,
  });

  ItineraryRequestState copyWith({
    ItineraryRequest? itineraryRequest,
    DateSelectionMethod? dateSelectionMethod,
    bool? submittingRequest 
  }) {
    return ItineraryRequestState(
      itineraryRequest: itineraryRequest ?? this.itineraryRequest,
      dateSelectionMethod: dateSelectionMethod ?? this.dateSelectionMethod,
      submittingRequest: submittingRequest ?? this.submittingRequest,
    );
  }

  @override
  List<Object?> get props => [itineraryRequest, dateSelectionMethod, submittingRequest];
}
