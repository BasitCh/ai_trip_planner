import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/global/pair.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notifications_state.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';

class ItineraryRequestNotificationCubit
    extends Cubit<ItineraryNotificationRequestState> {
  final ItineraryRepository repository;
  StreamSubscription? _subscription;

  // Store all requests for search purposes
  final List<ItineraryRequest> _allRequests = [];

  ItineraryRequestNotificationCubit({required this.repository})
      : super(ItineraryNotificationRequestState.initial()) {
    loadRequests();
    loadUnreadCount();
  }

  Future<void> loadRequests({DocumentSnapshot? lastDoc}) async {
    if (state.isLoadingMore || !state.hasMoreData) return;

    emit(state.copyWith(isLoadingMore: true));
    try {
      _subscription?.cancel(); // Cancel previous subscription to prevent memory leaks

      _subscription = repository.watchRequests(lastDocument: lastDoc).listen(
            (Pair<List<ItineraryRequest>, DocumentSnapshot?> result) {
          final newRequests = result.first;
          final lastDocument = result.second; // Extract last document
          _allRequests.clear();
          if (newRequests.isNotEmpty) {
            _allRequests.addAll(newRequests); // Store all requests for searching
            emit(state.copyWith(
              requests: _filteredRequests(state.searchQuery), // Apply search filter
              lastDocument: lastDocument, // Store last document correctly
              isLoadingMore: false,
              hasMoreData: newRequests.length == requestsPageLimit, // If <10, no more data
            ));
          } else {
            emit(state.copyWith(isLoadingMore: false, hasMoreData: false));
          }
        },
      );
    } catch (ex) {
      emit(state.copyWith(
        isLoadingMore: false,
        hasMoreData: false,
      ));
    }
  }

  Future<void> loadMoreRequests() async {
    if (state.lastDocument != null) {
      await loadRequests(lastDoc: state.lastDocument);
    }
  }

  Future<void> loadUnreadCount() async {
    int unreadCount = await repository.fetchUnreadRequestCount();
    emit(state.copyWith(unreadCount: unreadCount));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> _updateRequestStatus(
      ItineraryRequest request,
      String status,
      ) async {
    final result = await repository.updateRequest(
      request: request.copyWith(status: status),
    );

    result.fold(
          (error) => emit(state.copyWith(requests: state.requests)),
          (_) => null,
    );
  }

  void rejectRequestWithUndo(ItineraryRequest request) async {
    // Update Firestore
    await _updateRequestStatus(request, ItineraryRequestStatus.rejected.name);
    // Update UI immediately
    emit(state.copyWith(
      requests: state.requests
          .map((r) => r.id == request.id
          ? r.copyWith(status: ItineraryRequestStatus.rejected.name)
          : r)
          .toList(),
    ));
  }

  void undoReject({required ItineraryRequest request}) async {
    await _updateRequestStatus(request, ItineraryRequestStatus.pending.name);

    // Update UI immediately
    emit(state.copyWith(
      requests: state.requests
          .map((r) => r.id == request.id
          ? r.copyWith(status: ItineraryRequestStatus.pending.name)
          : r)
          .toList(),
    ));
  }

  Future<void> acceptRequest(ItineraryRequest request) async {
    await _updateRequestStatus(request, ItineraryRequestStatus.accepted.name);
  }

  Future<void> markAsRead(ItineraryRequest request) async {
    final currentContext =
        Navigation.router.routerDelegate.navigatorKey.currentContext;
    if (request.isRead ?? true)
    {
      if (currentContext != null && currentContext.mounted) {
        currentContext.pushNamed(NavigationPath.reviewRequestRouteUri,
            extra: request);
      }
    } else {
      final result = await repository.updateRequest(
        request: request.copyWith(isRead: true),
      );
      result.fold((error) {}, (_) {
        emit(state.copyWith(
          requests: state.requests
              .map((r) => r.id == request.id ? r.copyWith(isRead: true) : r)
              .toList(),
          unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
        ));
        if (currentContext != null && currentContext.mounted) {
          currentContext.pushNamed(NavigationPath.reviewRequestRouteUri,
              extra: request);
        }
      });
    }
  }

  /// Search Functionality
  void searchRequests(String query) {
    emit(state.copyWith(
      searchQuery: query,
      requests: _filteredRequests(query),
    ));
  }

  /// Helper function to filter the requests list based on the search query
  List<ItineraryRequest> _filteredRequests(String query) {
    if (query.isEmpty) {
      return _allRequests;
    }

    return _allRequests
        .where((request) =>
    request.travellerName!.toLowerCase().contains(query.toLowerCase()) ||
        request.status!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}




// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:travel_hero/global/navigation.dart';
// import 'package:travel_hero/global/pair.dart';
// import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
// import 'package:travel_hero/src/application/itinerary_request_notifications/itinerary_request_notifications_state.dart';
// import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
// import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';
// import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
//
// class ItineraryRequestNotificationCubit
//     extends Cubit<ItineraryNotificationRequestState> {
//   final ItineraryRepository repository;
//   StreamSubscription? _subscription;
//
//   ItineraryRequestNotificationCubit({required this.repository})
//       : super(ItineraryNotificationRequestState.initial()) {
//     loadRequests();
//     loadUnreadCount();
//   }
//
//   Future<void> loadRequests({DocumentSnapshot? lastDoc}) async {
//     if (state.isLoadingMore || !state.hasMoreData) return;
//
//     emit(state.copyWith(isLoadingMore: true));
//     try {
//       _subscription
//           ?.cancel(); // Cancel previous subscription to prevent memory leaks
//
//       _subscription = repository.watchRequests(lastDocument: lastDoc).listen(
//         (Pair<List<ItineraryRequest>, DocumentSnapshot?> result) {
//           final newRequests = result.first;
//           final lastDocument = result.second; // Extract last document
//
//           if (newRequests.isNotEmpty) {
//             emit(state.copyWith(
//               requests: [...state.requests, ...newRequests],
//               lastDocument: lastDocument, // Store last document correctly
//               isLoadingMore: false,
//               hasMoreData: newRequests.length ==
//                   requestsPageLimit, // If <10, no more data
//             ));
//           } else {
//             emit(state.copyWith(isLoadingMore: false, hasMoreData: false));
//           }
//         },
//       );
//     } catch (ex) {
//       emit(state.copyWith(
//         isLoadingMore: false,
//         hasMoreData: false,
//       ));
//     }
//   }
//
//   Future<void> loadMoreRequests() async {
//     if (state.lastDocument != null) {
//       await loadRequests(lastDoc: state.lastDocument);
//     }
//   }
//
//   Future<void> loadUnreadCount() async {
//     int unreadCount = await repository.fetchUnreadRequestCount();
//     emit(state.copyWith(unreadCount: unreadCount));
//   }
//
//   @override
//   Future<void> close() {
//     _subscription?.cancel();
//     return super.close();
//   }
//
//   Future<void> _updateRequestStatus(
//     ItineraryRequest request,
//     String status,
//   ) async {
//     final result = await repository.updateRequest(
//       request: request.copyWith(status: status),
//     );
//
//     result.fold(
//       (error) => emit(state.copyWith(requests: state.requests)),
//       (_) => null,
//     );
//   }
//
//   void rejectRequestWithUndo(ItineraryRequest request) async {
//     // Update Firestore
//     await _updateRequestStatus(request, ItineraryRequestStatus.rejected.name);
//     // Update UI immediately
//     emit(state.copyWith(
//       requests: state.requests
//           .map((r) => r.id == request.id
//               ? r.copyWith(status: ItineraryRequestStatus.rejected.name)
//               : r)
//           .toList(),
//     ));
//   }
//
//   void undoReject({required ItineraryRequest request}) async {
//     await _updateRequestStatus(request, ItineraryRequestStatus.pending.name);
//
//     // Update UI immediately
//     emit(state.copyWith(
//       requests: state.requests
//           .map((r) => r.id == request.id
//               ? r.copyWith(status: ItineraryRequestStatus.pending.name)
//               : r)
//           .toList(),
//     ));
//   }
//
//   Future<void> acceptRequest(ItineraryRequest request) async {
//     await _updateRequestStatus(request, ItineraryRequestStatus.accepted.name);
//   }
//
//   Future<void> markAsRead(ItineraryRequest request) async {
//     final currentContext =
//         Navigation.router.routerDelegate.navigatorKey.currentContext;
//     if (request.isRead ?? true) {
//       if (currentContext != null && currentContext.mounted) {
//         currentContext.pushNamed(NavigationPath.reviewRequestRouteUri,
//             extra: request);
//       }
//     } else {
//       final result = await repository.updateRequest(
//         request: request.copyWith(isRead: true),
//       );
//       result.fold((error) {}, (_) {
//         emit(state.copyWith(
//           requests: state.requests
//               .map((r) => r.id == request.id ? r.copyWith(isRead: true) : r)
//               .toList(),
//           unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
//         ));
//         if (currentContext != null && currentContext.mounted) {
//           currentContext.pushNamed(NavigationPath.reviewRequestRouteUri,
//               extra: request);
//         }
//       });
//     }
//   }
// }
