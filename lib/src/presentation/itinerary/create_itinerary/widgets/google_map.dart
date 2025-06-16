import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_state.dart';
import 'package:travel_hero/src/application/itinerary/google_map_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});


  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget>
    with AutomaticKeepAliveClientMixin {
  late CreateItineraryCubit createItineraryCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    createItineraryCubit = context.read<CreateItineraryCubit>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Needed because of AutomaticKeepAliveClientMixin
    return BlocProvider(
      create: (context) =>
          GoogleMapCubit(createItineraryCubit.isFromHome(context)),
      child: BlocBuilder<CreateItineraryCubit, CreateItineraryState?>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: AspectRatio(
              aspectRatio: 1,
              child: BlocBuilder<GoogleMapCubit, GoogleMapState>(
                  builder: (context, mapState) {
                if (state?.loadingItinerary ?? false) {
                  return Center(
                    child: AppButtonLoading(
                      color: AppColors.primary,
                    ),
                  );
                } else if (state?.travelItinerary == null ||
                    state?.travelItinerary?.dayPlans == null || (state?.travelItinerary?.dayPlans.isEmpty ?? true) ) {
                  return const Center(
                      child: Text('No itinerary data available'));
                } else {
                  final List<Map<String, dynamic>> itineraryPoints = state!.travelItinerary!.dayPlans
                      .expand(
                          (dayPlan) => dayPlan.activities.map((activity) => {
                                "name": activity.name,
                                "location": LatLng(activity.coordinates.lat,
                                    activity.coordinates.lng),
                              }))
                      .toList();

                  if (itineraryPoints.isEmpty) {
                    return const Center(
                        child: Text('No itinerary points found'));
                  }

                  final BitmapDescriptor markerIcon =
                      BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure);

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context
                        .read<GoogleMapCubit>()
                        .zoomToFitPolyline(itineraryPoints);
                  });

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: itineraryPoints.first["location"] as LatLng,
                        zoom: 5.5,
                      ),
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        context
                            .read<GoogleMapCubit>()
                            .setMapController(controller);
                        context
                            .read<GoogleMapCubit>()
                            .zoomToFitPolyline(itineraryPoints);
                      },
                      markers: itineraryPoints
                          .map((point) => Marker(
                                markerId: MarkerId(point.toString()),
                                position: point["location"] as LatLng,
                                infoWindow: InfoWindow(title: point["name"]),
                                icon: markerIcon,
                              ))
                          .toSet(),
                      polylines: {
                        Polyline(
                          polylineId: PolylineId("trip_route"),
                          points: itineraryPoints
                              .map((point) => point["location"] as LatLng)
                              .toList(),
                          color: Colors.black,
                          width: 4,
                        ),
                      },
                    ),
                  );
                }
              }),
            ),
          );
        },
      ),
    );
  }
}
