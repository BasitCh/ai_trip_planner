import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_hero/blocs/app_config/app_mode_cubit.dart';
import 'package:travel_hero/blocs/modal/modal_bloc.dart';
import 'package:travel_hero/blocs/notification/notification_cubit.dart';
import 'package:travel_hero/blocs/places/place_cubit.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/repositories/app_config/app_config_repository.dart';
import 'package:travel_hero/repositories/google_places/google_places_repository.dart';
import 'package:travel_hero/repositories/google_places/google_places_service.dart';
import 'package:travel_hero/repositories/offline_itinerary_repository.dart';
import 'package:travel_hero/repositories/user_repository.dart';
import 'package:travel_hero/src/application/chat/unread_message_count_cubit.dart';
import 'package:travel_hero/src/application/create_trip_plan/edit_trip_plan_cubit.dart';
import 'package:travel_hero/src/application/favorites/collection_itineraries_cubit/collection_itinerary_cubit.dart';
import 'package:travel_hero/src/application/favorites/favorites_cubit/favorites_cubit.dart';
import 'package:travel_hero/src/application/intro/carousel_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart'
    show MainNavBarCubit;
import 'package:travel_hero/src/application/profile/update_profile_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/filter_traveler_itinerary_cubit/filter_traveler_itinerary_cubit.dart';
import 'package:travel_hero/src/infrastructure/chat/message_repository.dart';
import 'package:travel_hero/src/infrastructure/favorites/favorites_repository.dart';
import 'package:travel_hero/src/infrastructure/itinerary/filtered_itinerary_repository.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_service.dart';
import 'package:travel_hero/src/infrastructure/login_register/login_register_repository.dart';
import 'package:travel_hero/src/infrastructure/services/network_service.dart';
import 'package:travel_hero/src/infrastructure/social_login/social_login_repository.dart';
import 'package:travel_hero/src/infrastructure/upload/upload_repository.dart';

import 'src/application/profile/image_picker_cubit.dart';

class AppBlocProviders extends StatelessWidget {
  const AppBlocProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String mapsApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'] ?? '';
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => GooglePlacesRepository(
                  GooglePlacesService(
                    NetworkService.instance(),
                  ),
                  mapsApiKey,
                )),
        RepositoryProvider(
            create: (context) =>
                LoginRegisterRepository(FirebaseAuth.instance)),
        RepositoryProvider(
            create: (context) =>
                AppConfigRepository(FirebaseFirestore.instance)),
        RepositoryProvider(
            create: (context) => MessageRepository(
                  firebaseAuth: FirebaseAuth.instance,
                  firebaseFireStore: FirebaseFirestore.instance,
                )),
        RepositoryProvider(
          create: (context) => SocialLoginRepository(
              FirebaseAuth.instance,
              GoogleSignIn(scopes: ["profile", "email"]),
              FacebookAuth.instance),
        ),
        RepositoryProvider(
            create: (context) =>
                UploadRepository(firebaseStorage: FirebaseStorage.instance)),
        RepositoryProvider(
          create: (context) => OfflineItineraryRepository(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider(
            create: (context) => FavoritesRepository(
                FirebaseAuth.instance, FirebaseFirestore.instance)),
        RepositoryProvider(
            create: (context) => UserRepository(
                FirebaseAuth.instance, FirebaseFirestore.instance)),
        RepositoryProvider(
          create: (context) => ItineraryRepository(
            itineraryService: ItineraryService(
              NetworkService.instance(),
            ),
            firebaseAuth: FirebaseAuth.instance,
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider(create: (context) {
          return FilteredItineraryRepository(
            firestore: FirebaseFirestore.instance,
            auth: FirebaseAuth.instance,
          );
        })
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SnackBarCubit>(
            create: (context) => SnackBarCubit(),
          ),
          BlocProvider<AppModeCubit>(
            create: (context) => AppModeCubit(
                appConfigRepository:
                    RepositoryProvider.of<AppConfigRepository>(context)),
          ),
          BlocProvider<ItineraryRequestCubit>(
            create: (context) => ItineraryRequestCubit(
                itineraryRepository:
                    RepositoryProvider.of<ItineraryRepository>(context),
                snackBarCubit: context.read<SnackBarCubit>()),
          ),
          BlocProvider<ModalBloc>(
            create: (context) => ModalBloc(),
          ),
          BlocProvider<CarouselCubit>(create: (context) => CarouselCubit()),
          BlocProvider<UnreadMessageCountCubit>(
            create: (context) => UnreadMessageCountCubit(
                RepositoryProvider.of<MessageRepository>(context)),
          ),
          BlocProvider<AppUserCubit>(
            create: (context) => AppUserCubit(),
          ),
          BlocProvider<ImagePickerCubit>(
            create: (BuildContext context) => ImagePickerCubit(),
          ),
          BlocProvider(
            create: (context) => PlaceCubit(
              placeRepository:
                  RepositoryProvider.of<GooglePlacesRepository>(context),
            ),
          ),
          BlocProvider(create: (_) => NotificationCubit()),
          BlocProvider<UpdateProfileCubit>(
            create: (BuildContext context) =>
                UpdateProfileCubit(context.read<UserRepository>()),
          ),
          BlocProvider<MainNavBarCubit>(create: (context) => MainNavBarCubit()),
          BlocProvider<CreateItineraryCubit>(
            create: (context) => CreateItineraryCubit(
              itineraryRepository:
                  RepositoryProvider.of<ItineraryRepository>(context),
              offlineItineraryRepository:
                  RepositoryProvider.of<OfflineItineraryRepository>(context),
              placesRepository:
                  RepositoryProvider.of<GooglePlacesRepository>(context),
              snackBarCubit: BlocProvider.of<SnackBarCubit>(context),
              modalBloc: BlocProvider.of<ModalBloc>(context),
              mainNavBarCubit: BlocProvider.of<MainNavBarCubit>(context),
              uploadRepository:
                  RepositoryProvider.of<UploadRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => EditTripPlanCubit(),
          ),
          BlocProvider<FavoritesCubit>(
            create: (context) => FavoritesCubit(
              favoritesRepository:
                  RepositoryProvider.of<FavoritesRepository>(context),
              snackBarCubit: BlocProvider.of<SnackBarCubit>(context),
            ),
          ),
          BlocProvider<CollectionItineraryCubit>(
            create: (context) => CollectionItineraryCubit(
              favoritesRepository:
                  RepositoryProvider.of<FavoritesRepository>(context),
              favoritesCubit: BlocProvider.of<FavoritesCubit>(context),
              modalBloc: BlocProvider.of<ModalBloc>(context),
              snackBarCubit: BlocProvider.of<SnackBarCubit>(context),
            ),
          ),
          BlocProvider<FilterTravelerItineraryCubit>(create: (context) {
            return FilterTravelerItineraryCubit(
                filterItineraryRepository:
                    RepositoryProvider.of<FilteredItineraryRepository>(
                        context));
          })
        ],
        child: child,
      ),
    );
  }
}
