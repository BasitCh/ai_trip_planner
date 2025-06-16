import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/src/domain/itinerary/coordinates.dart';
import 'package:travel_hero/src/domain/itinerary/day_plan.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/domain/login_register/app_user.dart';
import 'package:travel_hero/src/infrastructure/services/navigation_service.dart';
import 'package:travel_hero/src/infrastructure/utils/adapters/timestamp_adapter.dart';
import 'package:travel_hero/src/infrastructure/utils/enum.dart';

final GetIt getIt = GetIt.instance;

Future<void> registerServices() async {
  getIt.registerSingleton<NavigationService>(GoRouterNavigationService());
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive
    ..registerAdapter(LoginRegisterMethodAdapter())
    ..registerAdapter(TimestampAdapter())
    ..registerAdapter(AppUserAdapter())
    ..registerAdapter(GenderAdapter())
    ..registerAdapter(TravelItineraryAdapter())
    ..registerAdapter(DayPlanAdapter())
    ..registerAdapter(ActivityAdapter())
    ..registerAdapter(CoordinatesAdapter());
  //   ..registerAdapter(CatActiveStatusAdapter())
  //   ..registerAdapter(CatAdapter())
  //   ..registerAdapter(SalesOptionAdapter())
  //   ..registerAdapter(PedigreeAdapter())
  //   ..registerAdapter(BreedInfoAdapter())
  //   ..registerAdapter(ChampionshipAdapter())
  //   ..registerAdapter(OwnerInformationAdapter())
  //   ..registerAdapter(TimestampAdapter())
  //   ..registerAdapter(SignupMethodAdapter())
  //   ..registerAdapter(ColorAdapter())
  //   ..registerAdapter(ColoursAdapter())
  //   ..registerAdapter(DeathTypeAdapter())
  //   ..registerAdapter(DeceasedInformationAdapter()
}
