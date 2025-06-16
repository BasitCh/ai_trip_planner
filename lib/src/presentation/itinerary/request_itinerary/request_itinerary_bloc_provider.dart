import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/repositories/google_places/google_places_repository.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/destination_search_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/mood_cubit.dart';

class ItineraryRequestBlocProvider extends StatelessWidget {
  const ItineraryRequestBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => DestinationSearchCubit(
                placeRepository: context.read<GooglePlacesRepository>(),
              )),
      BlocProvider<MoodCubit>(create: (_) => MoodCubit(context)),
      BlocProvider<DateSelectionCubit>(create: (_) => DateSelectionCubit()),
    ], child: child);
  }
}
