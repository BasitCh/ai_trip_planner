import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/src/domain/itinerary/coordinates.dart';

String mapsApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'] ?? '';

class EditTripPlanCubit extends Cubit<Activity?> {
  EditTripPlanCubit()
      : super(Activity(name: "name", description: "description", address: "address", coordinates: Coordinates(lat: 0, lng: 0), images: []));

  /// Update the trip title
  void updateTitle(String title) {
    emit(state!.copyWith(name: title));
  }
  void updateActivity(Activity? activity) {
  emit(activity);
  }
  /// Fetch coordinates for a selected address
  Future<void> fetchCoordinatesFromAddress(String address,TextEditingController loc) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$mapsApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final location = data['results'][0]['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];
      loc.text = address;
      updateTitle(address);
      //state!.copyWith(name: address);
      emit(state!.copyWith(coordinates:Coordinates(lat: lat, lng: lng)));
    } else {
      throw Exception('Failed to fetch coordinates');
    }
  }

  /// Fetch address for given coordinates
  // Future<void> fetchAddressFromCoordinates(double latitude, double longitude) async {
  //   final url =
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$mapsApiKey';
  //   final response = await http.get(Uri.parse(url));
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final address = data['results'][0]['formatted_address'];
  //
  //     emit(state.copyWith(location: address, latitude: latitude, longitude: longitude));
  //   } else {
  //     throw Exception('Failed to fetch address');
  //   }
  // }

  /// Update trip description
  void updateDescription(String description) {
    emit(state!.copyWith(description: description));
  }
  // void clearPredication() {
  //   emit(state.copyWith(predication: []));
  // }
  /// Add an image to the list
  void addImage(dynamic image) {
    final updatedImages = List<dynamic>.from(state!.images)..add(image);
    emit(state!.copyWith(images: updatedImages));
  }

  /// Remove an image from the list
  void removeImage(dynamic image) {
    final updatedImages = List<dynamic>.from(state!.images)..remove(image);
    emit(state!.copyWith(images: updatedImages));
  }
  // void setCameraPosition(LatLng position) {
  //   emit(state.copyWith(latitude: position.latitude, longitude: position.longitude));
  // }
}
