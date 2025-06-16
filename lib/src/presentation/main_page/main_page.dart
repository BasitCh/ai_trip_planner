import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/blocs/app_config/app_mode_cubit.dart';
import 'package:travel_hero/global/services/device_token_manager.dart';
import 'package:travel_hero/repositories/user_repository.dart';
import 'package:travel_hero/src/application/chat/unread_message_count_cubit.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/main_page/main_bottom_navigation_bar.dart';
import 'package:travel_hero/src/presentation/main_page/main_page_bloc_provider.dart';
import 'package:travel_hero/widgets/app_custom_drawer.dart';
import 'package:widgets_book/widgets_book.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<AppModeCubit>().loadAppModes();
    initiateDeviceToken();
    context.read<UnreadMessageCountCubit>().loadUnreadMessage();
    super.initState();
  }

  initiateDeviceToken() {
    final tokenService = DeviceTokenManager(
      RepositoryProvider.of<UserRepository>(context),
    );
    tokenService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MainPageBlocProvider(
      child: Scaffold(
        extendBody: true,
        drawer: Theme(
            data: Theme.of(context).copyWith(
              drawerTheme: DrawerThemeData(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
            child: AppCustomDrawer()),
        key: scaffoldKey,
        body: widget.navigationShell,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Assets.icons.drawer.svg(),
                onPressed: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    Navigator.of(context).pop(); // Close the drawer
                  } else {
                    scaffoldKey.currentState!.openDrawer(); // Open the drawer
                  }
                },
              ),
              Expanded(
                child: Text(
                  context.read<AppUserCubit>().state?.username ?? '',
                  style: appBarLabel,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Assets.icons.notification.svg(),
                onPressed: () {},
              ),
            ],
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        bottomNavigationBar: BlocBuilder<MainNavBarCubit, int>(
          builder: (context, index) {
            return MainBottomNavigationBar(currentIndex: index);
          },
        ),
      ),
    );
  }
}
