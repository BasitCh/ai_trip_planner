import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notification_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:widgets_book/widgets_book.dart';

enum NavigationItem {
  notifications,
  tripPlans,
  library,
  payments,
  chats,
  profile,
}

bool isTravelerMode = false;

class DrawerCubit extends Cubit<NavigationItem> {
  DrawerCubit() : super(NavigationItem.notifications);
  // Default mode can be either true (Traveler) or false (Hero)
  final Map<NavigationItem, Map<String, dynamic>> heroNavItems = {
    NavigationItem.notifications: {
      "icon": Assets.icons.icNotification,
      "title": "Notifications",
      "badge": 3
    },
    NavigationItem.tripPlans: {
      "icon": Assets.icons.icTripPlan,
      "title": "Trip Plans",
      "badge": 2
    },
    NavigationItem.library: {
      "icon": Assets.icons.icLibrary,
      "title": "Library",
      "badge": 0
    },
    NavigationItem.payments: {
      "icon": Assets.icons.icPayments,
      "title": "Payments",
      "badge": 0
    },
    NavigationItem.chats: {
      "icon": Assets.icons.icChat,
      "title": "Chats",
      "badge": 2
    },
    NavigationItem.profile: {
      "icon": Assets.icons.icProfile,
      "title": "Profile",
      "badge": 0
    },
  };
  final Map<NavigationItem, Map<String, dynamic>> travelerNavItems = {
    NavigationItem.notifications: {
      "icon": Assets.icons.icNotification,
      "title": "Notifications",
      "badge": 3
    },
    NavigationItem.tripPlans: {
      "icon": Assets.icons.icTripPlan,
      "title": "Trip Plans Requests",
      "badge": 0
    },
    NavigationItem.payments: {
      "icon": Assets.icons.icPayments,
      "title": "Payments History",
      "badge": 0
    },
    NavigationItem.chats: {
      "icon": Assets.icons.icChat,
      "title": "Chats",
      "badge": 2
    },
    NavigationItem.profile: {
      "icon": Assets.icons.icProfile,
      "title": "Profile",
      "badge": 0
    },
  };

  void selectItem(NavigationItem item, BuildContext context) {
    Navigator.pop(context);
    Future.delayed(const Duration(seconds: 2), () {});
    if (item == NavigationItem.tripPlans) {
      context.read<MainNavBarCubit>().changeBottomNavBar(1);
      context.replaceNamed(_getRoute(1));
    } else if (item == NavigationItem.chats) {
      context.pushNamed(
        _getRoute(2),
      );
    } else if (item == NavigationItem.profile) {
      context.read<MainNavBarCubit>().changeBottomNavBar(3);
      context.replaceNamed(
        _getRoute(3),
      );
    }
    emit(item);
  }

  void toggleMode() {
    isTravelerMode = !isTravelerMode;
    // Emit a temporary intermediate state and then reset to maintain responsiveness

    isTravelerMode
        ? emit(NavigationItem.notifications)
        : emit(NavigationItem.tripPlans);
    emit(state);
  }

  String _getRoute(int index) {
    String path = NavigationPath.homeRouteUri;

    switch (index) {
      case 0:
        path = NavigationPath.homeRouteUri;
        break;
      case 1:
        path = isTravelerMode?NavigationPath.travellerTripPlanScreenRouteUri:NavigationPath.travelHeroRequestedTripPlansRouteUri;
        break;
      case 2:
        path = NavigationPath.chatListScreenRouteUri;
        break;
      case 3:
        path = NavigationPath.myProfileRouteUri;
        break;
    }
    return path;
  }

  void countRequestsUnreadCount(BuildContext context) {
    context.read<ItineraryRequestNotificationCubit>().stream.listen((state) {
      heroNavItems[NavigationItem.tripPlans]?["badge"] = state.unreadCount;
      travelerNavItems[NavigationItem.tripPlans]?["badge"] = state.unreadCount;
      emit(this.state);
    });
  }
}
