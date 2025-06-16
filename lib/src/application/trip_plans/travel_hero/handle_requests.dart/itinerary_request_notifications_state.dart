import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';

class ItineraryNotificationRequestState extends Equatable {
  final List<ItineraryRequest> requests;
  final DocumentSnapshot? lastDocument;
  final bool isLoadingMore;
  final bool hasMoreData;
  final int unreadCount;
  final String searchQuery; // <-- Added searchQuery field

  const ItineraryNotificationRequestState({
    required this.requests,
    this.lastDocument,
    this.isLoadingMore = false,
    this.hasMoreData = true,
    this.unreadCount = 0,
    this.searchQuery = '', // Default to empty string
  });

  factory ItineraryNotificationRequestState.initial() {
    return ItineraryNotificationRequestState(
      requests: [],
      lastDocument: null,
      isLoadingMore: false,
      hasMoreData: true,
      unreadCount: 0,
      searchQuery: '',
    );
  }

  ItineraryNotificationRequestState copyWith({
    List<ItineraryRequest>? requests,
    DocumentSnapshot? lastDocument,
    bool? isLoadingMore,
    bool? hasMoreData,
    int? unreadCount,
    String? searchQuery, // <-- Added searchQuery parameter
  }) {
    return ItineraryNotificationRequestState(
      requests: requests ?? this.requests,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      unreadCount: unreadCount ?? this.unreadCount,
      searchQuery: searchQuery ?? this.searchQuery, // <-- Assign new search query
    );
  }

  @override
  List<Object?> get props => [requests, lastDocument, isLoadingMore, hasMoreData, unreadCount, searchQuery];
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
//
// class ItineraryNotificationRequestState extends Equatable {
// final List<ItineraryRequest> requests;
//   final DocumentSnapshot? lastDocument;
//   final bool isLoadingMore;
//   final bool hasMoreData;
//   final int unreadCount;
//
//   const ItineraryNotificationRequestState({
//     required this.requests,
//     this.lastDocument,
//     this.isLoadingMore = false,
//     this.hasMoreData = true,
//     this.unreadCount = 0,
//   });
//
//   factory ItineraryNotificationRequestState.initial() {
//     return ItineraryNotificationRequestState(
//       requests: [],
//       lastDocument: null,
//       isLoadingMore: false,
//       hasMoreData: true,
//       unreadCount: 0,
//     );
//   }
//
//   ItineraryNotificationRequestState copyWith({
//     List<ItineraryRequest>? requests,
//     DocumentSnapshot? lastDocument,
//     bool? isLoadingMore,
//     bool? hasMoreData,
//     int? unreadCount,
//   }) {
//     return ItineraryNotificationRequestState(
//       requests: requests ?? this.requests,
//       lastDocument: lastDocument ?? this.lastDocument,
//       isLoadingMore: isLoadingMore ?? this.isLoadingMore,
//       hasMoreData: hasMoreData ?? this.hasMoreData,
//       unreadCount: unreadCount ?? this.unreadCount,
//     );
//   }
//
//   @override
//   List<Object?> get props => [requests, lastDocument, isLoadingMore, hasMoreData, unreadCount];
// }