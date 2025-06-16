import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({required this.currentIndex, super.key});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: _navigationBarButtons(currentIndex),
      onTap: (index) => _onItemTapped(index, context),
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.unSelectedLabel,
      selectedLabelStyle: selectedLabel,
      unselectedLabelStyle: unselectedLabel,
      enableFeedback: false,
    );
  }

  List<BottomNavigationBarItem> _navigationBarButtons(int currentIndex) {
    return [
      BottomNavigationBarItem(
        icon: currentIndex == 0
            ? Assets.icons.filledHome.svg()
            : Assets.icons.unfilledHome.svg(),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: currentIndex == 1
            ? Assets.icons.filledTripPlan.svg()
            : Assets.icons.unfilledTripPlan.svg(),
        label: 'Trip Plans',
      ),
      BottomNavigationBarItem(
        icon: currentIndex == 2
            ? Assets.icons.filledHeart.svg()
            : Assets.icons.unfilledHeart.svg(),
        label: 'Favorites',
      ),
      BottomNavigationBarItem(
        icon: currentIndex == 3
            ? Assets.icons.filledProfile.svg()
            : Assets.icons.unfilledProfile.svg(),
        label: 'Profile',
      ),
    ];
  }

  void _onItemTapped(int index, BuildContext context) {
    context.read<MainNavBarCubit>().changeBottomNavBar(index);
    context.replaceNamed(
      _getRoute(index),
    );
  }

  String _getRoute(int index) {
    String path = NavigationPath.homeRouteUri;

    switch (index) {
      case 0:
        path = NavigationPath.homeRouteUri;
        break;
      case 1:
        path = isTravelerMode?NavigationPath.travellerTripPlanScreenRouteUri:NavigationPath.travelHeroRequestedTripPlansRouteUri;
        break;
      case 2:
        path = NavigationPath.favoritesRouteUri;
        break;
      case 3:
        path = NavigationPath.myProfileRouteUri;
        break;
    }
    return path;
  }
}
