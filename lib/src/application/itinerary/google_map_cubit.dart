import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part  'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit(bool openedFromHome)
      : super(GoogleMapState(
    isFromHome: openedFromHome,
  ));

  void setMapController(GoogleMapController controller) {
    emit(state.copyWith(mapController: controller));
  }

  void zoomToFitPolyline(List<Map<String, dynamic>> points) {
    if (points.isEmpty || state.mapController == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        points.map((p) => (p["location"] as LatLng).latitude).reduce((a, b) => a < b ? a : b),
        points.map((p) => (p["location"] as LatLng).longitude).reduce((a, b) => a < b ? a : b),
      ),
      northeast: LatLng(
        points.map((p) => (p["location"] as LatLng).latitude).reduce((a, b) => a > b ? a : b),
        points.map((p) => (p["location"] as LatLng).longitude).reduce((a, b) => a > b ? a : b),
      ),
    );

    state.mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  @override
  Future<void> close() {
    state.mapController?.dispose();
    return super.close();
  }
}