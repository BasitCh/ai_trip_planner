// global functions will come here

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:widgets_book/widgets_book.dart';

// Enum for Menu Options
enum MenuOptionType {
  tripPlans,
  tripPlanRequests,
  settings,
  payments,
  logOut,
  contactUs,
}

bool isChatScreenOpen = false;

// Extension to get icon, label, and navigation route for each enum value
extension MenuOptionExtension on MenuOptionType {
  String get label {
    switch (this) {
      case MenuOptionType.tripPlans:
        return "Your Trip Plans";
      case MenuOptionType.tripPlanRequests:
        return "Trip Plans Requests";
      case MenuOptionType.settings:
        return "Settings";
      case MenuOptionType.payments:
        return "Payments";
      case MenuOptionType.logOut:
        return "Log Out";
      case MenuOptionType.contactUs:
        return "Contact Us";
    }
  }

  Widget get icon {
    switch (this) {
      case MenuOptionType.tripPlans:
        return Assets.icons.icHeart.svg();
      case MenuOptionType.tripPlanRequests:
        return Assets.icons.icTripPlanRequest.svg();
      case MenuOptionType.settings:
        return Assets.icons.icSettings.svg();
      case MenuOptionType.payments:
        return Assets.icons.icPaymentsProfile.svg();
      case MenuOptionType.logOut:
        return Assets.icons.icLogout.svg();
      case MenuOptionType.contactUs:
        return Assets.icons.icContactUs.svg();
    }
  }

  String get route {
    switch (this) {
      case MenuOptionType.tripPlans:
        return '/tripPlans';
      case MenuOptionType.tripPlanRequests:
        return '/tripPlanRequests';
      case MenuOptionType.settings:
        return '/settings';
      case MenuOptionType.payments:
        return '/payments';
      case MenuOptionType.logOut:
        return '/logOut';
      case MenuOptionType.contactUs:
        return '/contactUs';
    }
  }
}

String getFormatTimestamp(dynamic timestamp) {
  DateTime dateTime;

  if (timestamp is int) {
    // Convert int (UNIX timestamp) to DateTime
    dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  } else if (timestamp is Timestamp) {
    dateTime = timestamp.toDate();
  } else if (timestamp is DateTime) {
    dateTime = timestamp;
  } else {
    return "--:--"; // Invalid format
  }

  // Format the date into 12-hour format
  int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  String period = dateTime.hour >= 12 ? "PM" : "AM";

  return "$hour:${dateTime.minute.toString().padLeft(2, '0')} $period";
}

bool shouldShowDateChip(int currentTimestamp, int? nextTimestamp) {
  // Ensure the timestamp is valid (greater than a reasonable threshold)
  if (currentTimestamp < 1000000000) {
    // Ignore timestamps before the year ~2001
    return false;
  }

  DateTime currentDate = DateTime.fromMillisecondsSinceEpoch(currentTimestamp);
  DateTime? nextDate = nextTimestamp != null && nextTimestamp > 1000000000
      ? DateTime.fromMillisecondsSinceEpoch(nextTimestamp)
      : null;

  return nextDate == null ||
      currentDate.year != nextDate.year ||
      currentDate.month != nextDate.month ||
      currentDate.day != nextDate.day;
}

/// Returns:
/// - `true` if the string is a valid URL, otherwise `false`.
bool isUrl(String input) {
  // Try to parse the input as a URI
  Uri? uri = Uri.tryParse(input);

  // Check if the URI is valid and has a scheme (e.g., http, https)
  return uri != null &&
      uri.hasAbsolutePath &&
      (uri.scheme == 'http' || uri.scheme == 'https');
}

List<dynamic> getItineraryImages({required TravelItinerary? itinerary}) {
  if (itinerary == null) return [];
  // Filter activities that contain images
  final activitiesWithImages = itinerary.dayPlans.first.activities
      .where((activity) => activity.images.isNotEmpty)
      .toList();
  var images = [];
  // If no activities have images, return a placeholder or empty widget
  if (activitiesWithImages.isNotEmpty) {
    images = activitiesWithImages.first.images;
  }
  return images;
}
