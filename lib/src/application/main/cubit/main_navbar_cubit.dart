import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';

class MainNavBarCubit extends Cubit<int> {
  MainNavBarCubit() : super(0);
  void changeBottomNavBar(int index) => emit(index);
  void switchToHome(){
    changeBottomNavBar(0);
    final context = Navigation.router.routerDelegate.navigatorKey.currentContext;
    if(context!=null && context.mounted){
      context.replaceNamed(
        NavigationPath.homeRouteUri
      );
    }
  }
}
