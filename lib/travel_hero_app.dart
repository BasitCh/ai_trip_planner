import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_widget.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:widgets_book/widgets_book.dart';
import 'app_bloc_providers.dart';

class TravelHeroApp extends StatelessWidget {
  const TravelHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerGlobalKey,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.instance.goRouter,
        supportedLocales: const [
          Locale('en'),
          Locale('nl'),
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)?.appName ?? 'App',
        // Fallback to avoid null errors
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        themeMode: ThemeMode.light,
        theme: const AppTheme().themeData,
        darkTheme: const AppDarkTheme().themeData,
        builder: (context, Widget? child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: AppColors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: ScreenUtilSetup(
              child: Directionality(
                textDirection: ui.TextDirection.ltr,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1),
                  ),
                  child: SnackBarWidget(
                      child:  Stack(
                            children: [
                              child ?? const SizedBox.shrink(),
                              // BlocListener<NotificationCubit, NotificationState>(
                              //   listener: (context, state) {
                              //     if (state.hasNotification) {
                              //       NotificationService.showCustomNotification(
                              //           context,
                              //           'Your trip plan for 3 days to Thailand is ready to be viewed.',
                              //           '1m ago');
                              //     }
                              //   },child: Container(),
                              // ),
                            ],
                          ))),
                ),
              ),
          );
        },
      ),
    );
  }
}
