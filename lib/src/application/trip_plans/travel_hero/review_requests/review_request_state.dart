part of 'review_request_cubit.dart';

class ReviewRequestState {
  final bool? decliningRequest;
  final bool? progressingRequest;
  final ItineraryRequest? request;
  const ReviewRequestState({
    this.decliningRequest = false,
    this.progressingRequest = false,
    this.request,
  });

  ReviewRequestState copyWith({
    bool? decliningRequest,
    bool? progressingRequest,
    ItineraryRequest? request,
  }) {
    return ReviewRequestState(
      decliningRequest: decliningRequest ?? this.decliningRequest,
      progressingRequest: progressingRequest ?? this.progressingRequest,
      request: request ?? this.request,
    );
  }
}
