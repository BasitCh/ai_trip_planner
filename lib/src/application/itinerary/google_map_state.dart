
part of 'google_map_cubit.dart';

class GoogleMapState {
  final GoogleMapController? mapController;
  final BitmapDescriptor? customMarkerIcon;
  final bool isFromHome;

  GoogleMapState({
    this.mapController,
    this.customMarkerIcon,
    required this.isFromHome,
  });

  GoogleMapState copyWith({
    GoogleMapController? mapController,
    BitmapDescriptor? customMarkerIcon,
    bool? isFromHome,
    Future<BitmapDescriptor>? markerFuture,
  }) {
    return GoogleMapState(
      mapController: mapController ?? this.mapController,
      customMarkerIcon: customMarkerIcon ?? this.customMarkerIcon,
      isFromHome: isFromHome ?? this.isFromHome,
    );
  }
}