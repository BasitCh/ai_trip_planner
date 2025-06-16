import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/intro/onboarding_cubit.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/presentation/auth/intro/loading_page.dart';
import 'package:travel_hero/src/presentation/auth/intro/onboarding_page.dart';
import 'package:travel_hero/src/presentation/auth/intro/wizard_page.dart';
import 'package:travel_hero/src/presentation/auth/intro/splash_page.dart';
import 'package:travel_hero/src/presentation/auth/login-register/login_register.dart';
import 'package:travel_hero/src/presentation/chat/chat_screen.dart';
import 'package:travel_hero/src/presentation/chat/user_chats/chat_user_screen.dart';
import 'package:travel_hero/src/presentation/favorites/collection_itineraries_page.dart';
import 'package:travel_hero/src/presentation/favorites/favorites_page.dart';
import 'package:travel_hero/src/presentation/home/home_page.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/create_itinerary_bloc_provider.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/itinerary_detail_page.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/generating_trip_plan_page.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/promp_page.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/date_selection_screen.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/demographic_screen.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/destination_search_screen.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/request_itinerary_bloc_provider.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/trip_preview_screen.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/upgrade_plan_screen.dart';
import 'package:travel_hero/src/presentation/main_page/main_page.dart';
import 'package:travel_hero/src/presentation/main_page/main_page_bloc_provider.dart';
import 'package:travel_hero/src/presentation/trip_plans/travel_hero/requested_trip_screen.dart';
import 'package:travel_hero/src/presentation/trip_plans/travel_hero/review_request_screen.dart';
import 'package:travel_hero/src/presentation/profile/profile_page.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/review_page.dart';
import 'package:travel_hero/src/presentation/profile/profile_setting.dart';
import 'package:travel_hero/src/presentation/trip_plans/traveller/traveller_trip_plan_screen.dart';
import 'package:travel_hero/src/presentation/trip_plans/traveller/trip_preview_screen_traveller.dart';

class NavigationPath {
  static const String splashRouteUri = '/';
  static const String mainRouteUri = 'main';

  static const String homeRouteUri = 'home';

  static const String loginRouteUri = 'login';
  static const String wizardRouteUri = 'wizard';
  static const String forgotPasswordRouteUri = 'forgot-password';
  static const String onboardingRouteUri = 'onboarding';
  static const String loadingPageRouteUri = 'loading-page';
  static const String promptPageRouteUri = 'prompt';
  static const String reviewTripRouteUri = 'review-trip';
  static const String itineraryDetailRouteUri = 'itinerary-detail';
  static const String travelHeroRequestedTripPlansRouteUri =
      'travel-hero-requested-trip-plans';
  static const String reviewRequestRouteUri = 'review-request';
  static const String favoritesRouteUri = 'favorites';
  static const String collectionItinerariesUri = 'collection-itineraries';
  static const String generatingTripPlanRouteUri = 'generate-trip-plan';

  static const String myProfileRouteUri = 'my-profile';
  static const String deceasedCatRouteUri = 'deceased-cat';
  static const String vetCheckCatDetailRouteUri = 'vet-check-cat-detail';
  static const String pregnancyCalculatorRouteUri = 'pregnancy-calculator';
  static const String cameraRouteUri = 'camera';
  static const String profileSetting = 'profile-setting';
  static const String upgradePlanRouteUri = 'upgrade-plan';
  static const String destinationScreenRouteUri = 'destination_search_screen';
  static const String demographicScreenRouteUri = 'demographic_screen';
  static const String dateSelectionScreenRouteUri = 'date_selection_screen';
  static const String tripPlanReviewScreenRouteUri = 'trip_plan_review_screen';
  static const String chatRouteUri = 'chat_screen';
  static const String chatListScreenRouteUri = 'chat_list_screen';
  static const String tripPreviewTraveller = 'trip_preview_traveller';
  static const String travellerTripPlanScreenRouteUri =
      'traveller_trip_plan_screen';
}

class AppRoutes {
  factory AppRoutes() => instance;

  AppRoutes._constructor() : goRouter = _router;
  final GoRouter goRouter;
  static final AppRoutes instance = AppRoutes._constructor();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellHomeNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellVetCheckNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellTravellerTripPlanNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellChatNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellProfileNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get _router => GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: NavigationPath.splashRouteUri,
        debugLogDiagnostics: true,
        routes: [
          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.splashRouteUri,
            path: NavigationPath.splashRouteUri,
            builder: (BuildContext context, GoRouterState state) =>
                const SplashPage(),
          ),
          GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: NavigationPath.loginRouteUri,
              path: '/${NavigationPath.loginRouteUri}',
              builder: (BuildContext context, GoRouterState state) =>
                  LoginRegister()),
          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.wizardRouteUri,
            path: '/${NavigationPath.wizardRouteUri}',
            builder: (BuildContext context, GoRouterState state) =>
                WizardPage(),
          ),

          // GoRoute(
          //   parentNavigatorKey: rootNavigatorKey,
          //   name: NavigationPath.forgotPasswordRouteUri,
          //   path: '/${NavigationPath.forgotPasswordRouteUri}',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const ForgotPasswordPage(),
          // ),
          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.onboardingRouteUri,
            path: '/${NavigationPath.onboardingRouteUri}',
            builder: (BuildContext context, GoRouterState state) =>
                BlocProvider<OnboardingCubit>(
                    create: (context) => OnboardingCubit(),
                    child: OnboardingPage()),
          ),
          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.loadingPageRouteUri,
            path: '/${NavigationPath.loadingPageRouteUri}',
            builder: (BuildContext context, GoRouterState state) =>
                LoadingPage(),
          ),
          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.profileSetting,
            path: '/${NavigationPath.profileSetting}',
            builder: (BuildContext context, GoRouterState state) =>
                ProfileSettingsPage(),
          ),
          GoRoute(
              name: NavigationPath.reviewRequestRouteUri,
              path: '/${NavigationPath.reviewRequestRouteUri}',
              builder: (context, routerState) {
                final request = routerState.extra as ItineraryRequest;
                return ReviewRequestScreen(
                  request: request,
                );
              }),
          GoRoute(
              name: NavigationPath.tripPreviewTraveller,
              path: '/${NavigationPath.tripPreviewTraveller}',
              builder: (context, routerState) {
                final request = routerState.extra as ItineraryRequest;
                return TripPreviewScreenTraveller(
                  itineraryRequest: request,
                );
              }),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return MainPage(
                navigationShell: navigationShell,
              );
            },
            branches: [
              StatefulShellBranch(
                navigatorKey: shellHomeNavigatorKey,
                routes: [
                  GoRoute(
                    name: NavigationPath.homeRouteUri,
                    path: '/${NavigationPath.homeRouteUri}',
                    builder: (context, routerState) => const HomePage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: shellVetCheckNavigatorKey,
                routes: [
                  GoRoute(
                      name: NavigationPath.travelHeroRequestedTripPlansRouteUri,
                      path:
                          '/${NavigationPath.travelHeroRequestedTripPlansRouteUri}',
                      builder: (context, routerState) =>
                          const RequestedTripScreen()),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: shellTravellerTripPlanNavigatorKey,
                routes: [
                  GoRoute(
                      name: NavigationPath.travellerTripPlanScreenRouteUri,
                      path:
                          '/${NavigationPath.travellerTripPlanScreenRouteUri}',
                      builder: (context, routerState) =>
                          const TravellerTripPlanScreen()),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: shellChatNavigatorKey,
                routes: [
                  GoRoute(
                      name: NavigationPath.favoritesRouteUri,
                      path: '/${NavigationPath.favoritesRouteUri}',
                      builder: (context, routerState) => FavoritesPage()),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: shellProfileNavigatorKey,
                routes: [
                  GoRoute(
                      name: NavigationPath.myProfileRouteUri,
                      path: '/${NavigationPath.myProfileRouteUri}',
                      builder: (context, routerState) => const ProfilePage()),
                ],
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.promptPageRouteUri,
            path: '/${NavigationPath.promptPageRouteUri}',
            builder: (BuildContext context, GoRouterState state) =>
                PromptPage(),
          ),
          GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: NavigationPath.reviewTripRouteUri,
              path: '/${NavigationPath.reviewTripRouteUri}',
              builder: (BuildContext context, GoRouterState state) {
                return ReviewPage();
              }),
          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.generatingTripPlanRouteUri,
            path: '/${NavigationPath.generatingTripPlanRouteUri}',
            builder: (BuildContext context, GoRouterState state) =>
                GeneratingTripPlanPage(),
          ),

          GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: NavigationPath.itineraryDetailRouteUri,
              path: '/${NavigationPath.itineraryDetailRouteUri}',
              builder: (BuildContext context, GoRouterState state) {
                return MainPageBlocProvider(child: ItineraryDetailPage());
              }),

          GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: NavigationPath.collectionItinerariesUri,
              path: '/${NavigationPath.collectionItinerariesUri}',
              builder: (BuildContext context, GoRouterState state) {
                final collection = state.extra as Collection;
                return CollectionItinerariesPage(
                  collection: collection,
                );
              }),

          GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: NavigationPath.chatRouteUri,
            path:
                '/${NavigationPath.chatRouteUri}/:chatRoomId/:receiverName/:receiverAvatar/:receiverId',
            builder: (BuildContext context, GoRouterState state) {
              final chatRoomId = state.pathParameters['chatRoomId']!;
              final receiverName =
                  Uri.decodeComponent(state.pathParameters['receiverName']!);
              final receiverAvatar =
                  Uri.decodeComponent(state.pathParameters['receiverAvatar']!);
              final receiverId = state.pathParameters['receiverId']!;

              return ChatScreen(
                chatRoomId: chatRoomId,
                receiverId: receiverId,
                receiverName: receiverName,
                receiverAvatar: receiverAvatar,
              );
            },
          ),
          GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: NavigationPath.upgradePlanRouteUri,
              path: '/${NavigationPath.upgradePlanRouteUri}',
              builder: (BuildContext context, GoRouterState state) {
                return UpgradePlanScreen();
              }),
          GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: NavigationPath.chatListScreenRouteUri,
              path: '/${NavigationPath.chatListScreenRouteUri}',
              builder: (BuildContext context, GoRouterState state) {
                return ChatUsersScreen();
              }),
          ShellRoute(
              parentNavigatorKey: rootNavigatorKey,
              navigatorKey: GlobalKey<NavigatorState>(),
              builder: (context, state, child) {
                return ItineraryRequestBlocProvider(child: child);
              },
              routes: [
                GoRoute(
                    // parentNavigatorKey: rootNavigatorKey,
                    name: NavigationPath.destinationScreenRouteUri,
                    path: '/${NavigationPath.destinationScreenRouteUri}',
                    builder: (BuildContext context, GoRouterState state) {
                      return DestinationSearchScreen();
                    }),
                GoRoute(
                    // parentNavigatorKey: rootNavigatorKey,
                    name: NavigationPath.demographicScreenRouteUri,
                    path: '/${NavigationPath.demographicScreenRouteUri}',
                    builder: (BuildContext context, GoRouterState state) {
                      return DemographicScreen();
                    }),
                GoRoute(
                    // parentNavigatorKey: rootNavigatorKey,
                    name: NavigationPath.dateSelectionScreenRouteUri,
                    path: '/${NavigationPath.dateSelectionScreenRouteUri}',
                    builder: (BuildContext context, GoRouterState state) {
                      return DateSelectionScreen();
                    }),
                GoRoute(
                    // parentNavigatorKey: rootNavigatorKey,
                    name: NavigationPath.tripPlanReviewScreenRouteUri,
                    path: '/${NavigationPath.tripPlanReviewScreenRouteUri}',
                    builder: (BuildContext context, GoRouterState state) {
                      return TripPreviewScreen();
                    }),
              ]),

          // GoRoute(
          //     parentNavigatorKey: rootNavigatorKey,
          //     name: NavigationPath.deceasedCatRouteUri,
          //     path: '/${NavigationPath.deceasedCatRouteUri}',
          //     builder: (BuildContext context, GoRouterState state) {
          //       final catId = state.extra as String?;
          //       return BlocProvider(
          //         create: (context) => DeceasedCatDetailCubit(
          //             context.read<CatRepository>(), catId),
          //         child: const DeceasedCatDetailPage(),
          //       );
          //     }),
          // GoRoute(
          //     parentNavigatorKey: rootNavigatorKey,
          //     name: NavigationPath.pregnancyCalculatorRouteUri,
          //     path: '/${NavigationPath.pregnancyCalculatorRouteUri}',
          //     builder: (BuildContext context, GoRouterState state) {
          //       final cat = state.extra as Cat?;
          //       return PregnancyCalculatorPage(cat: cat);
          //     }),
          // GoRoute(
          //     parentNavigatorKey: rootNavigatorKey,
          //     name: NavigationPath.cameraRouteUri,
          //     path: '/${NavigationPath.cameraRouteUri}',
          //     builder: (BuildContext context, GoRouterState state) {
          //       final cat = state.extra as Cat?;
          //       return CameraWithGallery();
          //     }),
        ],
      );
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('Pushed route: ${route.str}');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('didPop route: ${route.str}');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('Removed route: ${route.str}');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (kDebugMode) {
      print('Replaced newRoute: ${newRoute!.str}');
    }
  }
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}

extension GoRouterExtension on GoRouter {
  void clearStackAndNavigate(String location, {Object? extra}) {
    while (canPop()) {
      pop();
    }
    pushReplacement(location, extra: extra);
  }
}
