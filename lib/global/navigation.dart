import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';

class Navigation {
  static GoRouter get router => AppRoutes.instance.goRouter;

  static pushAndRemoveUntil(String name) {
    while (router.canPop()) {
      router.pop();
    }
    router.replace(name);
  }
}
