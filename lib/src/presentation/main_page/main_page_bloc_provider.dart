import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/repositories/offline_itinerary_repository.dart';
import 'package:travel_hero/src/application/favorites/favorites_cubit/favorites_cubit.dart';
import 'package:travel_hero/src/application/home/home_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notification_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/account_type_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/traveler_inprogress_trip_plan/inprogress_trips_cubit.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';

class MainPageBlocProvider extends StatelessWidget {
  const MainPageBlocProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InProgressTripsCubit(
            repository: RepositoryProvider.of<ItineraryRepository>(
              context,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ItineraryRequestNotificationCubit(
            repository: RepositoryProvider.of<ItineraryRepository>(
              context,
            ),
          ),
        ),
        BlocProvider(create: (_) => DrawerCubit()),
        BlocProvider(
          create: (_) => AccountTypeCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(
              itineraryRepository:
                  RepositoryProvider.of<OfflineItineraryRepository>(context),
              favoritesCubit: BlocProvider.of<FavoritesCubit>(context)),
        ),
      ],
      child: child,
    );
  }
}
