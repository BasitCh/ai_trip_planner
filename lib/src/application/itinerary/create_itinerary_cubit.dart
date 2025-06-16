import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/blocs/modal/modal_bloc.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/global/global.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/repositories/google_places/google_places_repository.dart';
import 'package:travel_hero/repositories/offline_itinerary_repository.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_state.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/src/domain/itinerary/ai_request_message.dart';
import 'package:travel_hero/src/domain/itinerary/day_plan.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request_body.dart';
import 'package:travel_hero/src/domain/itinerary/requester.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/domain/itinerary/visibility.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/upload/upload_repository.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/image_upload_dialog.dart';
import 'package:widgets_book/widgets_book.dart';

class CreateItineraryCubit extends Cubit<CreateItineraryState?> {
  late TextEditingController promptController;
  final ItineraryRepository itineraryRepository;
  final OfflineItineraryRepository offlineItineraryRepository;
  final GooglePlacesRepository placesRepository;
  final UploadRepository uploadRepository;
  final MainNavBarCubit mainNavBarCubit;
  final SnackBarCubit snackBarCubit;
  final ModalBloc modalBloc;
  late GlobalKey<FormState> formKey;

  CreateItineraryCubit({
    required this.itineraryRepository,
    required this.offlineItineraryRepository,
    required this.placesRepository,
    required this.uploadRepository,
    required this.snackBarCubit,
    required this.mainNavBarCubit,
    required this.modalBloc,
  }) : super(CreateItineraryState(
            travelItinerary: TravelItinerary(dayPlans: []))) {
    formKey = GlobalKey<FormState>();
    promptController = TextEditingController();
    promptController.text =
        'Create a hiking and camping Trip Plan for two in the Bangkok, Thailand. The trip should be for 2 days, starting from 15th Oct 2024';
  }

  Future<void> loadItineraryDetails({required String? itineraryId}) async {
    emit(state?.copyWith(loadingItinerary: true));

    final result = await offlineItineraryRepository.fetchItineraryDetails(
        itineraryId: itineraryId);

    result.fold(
      (error) {
        snackBarCubit
            .showSnackBar("Failed to load itinerary: ${error.toString()}");
        emit(state?.copyWith(loadingItinerary: false));
      },
      (itinerary) {
        emit(state?.copyWith(
          travelItinerary: itinerary,
          loadingItinerary: false,
        ));
      },
    );
  }

  void togglePlan(bool isPaid) {
    final updatedTravelItinerary =
        state?.travelItinerary?.copyWith(isPaidPlan: isPaid);
    emit(state?.copyWith(travelItinerary: updatedTravelItinerary));
  }

  void updateMood(String selectedMood) {
    final updatedTravelItinerary =
        state?.travelItinerary?.copyWith(mood: selectedMood);
    emit(state?.copyWith(travelItinerary: updatedTravelItinerary));
  }

  void updateActivity({
    required Activity? activity,
    required int dayIndex,
    required int activityIndex,
  }) {
    if (state == null || state!.travelItinerary == null) return;

    final currentItinerary = state!.travelItinerary!;

    if (dayIndex < 0 || dayIndex >= currentItinerary.dayPlans.length) return;
    if (activityIndex < 0 ||
        activityIndex >=
            currentItinerary.dayPlans[dayIndex].activities.length) {
      return;
    }

    final updatedActivities =
        List<Activity>.from(currentItinerary.dayPlans[dayIndex].activities);

    updatedActivities[activityIndex] = activity!;

    final updatedDayPlans = List<DayPlan>.from(currentItinerary.dayPlans)
      ..[dayIndex] = currentItinerary.dayPlans[dayIndex]
          .copyWith(activities: updatedActivities);

    final updatedItinerary =
        currentItinerary.copyWith(dayPlans: updatedDayPlans);

    emit(state!.copyWith(travelItinerary: updatedItinerary));
  }

  Future<void> createOpenAiItinerary() async {
    emit(state?.copyWith(creatingItinerary: true));

    final mood = state?.travelItinerary?.mood ?? '';
    final userPrompt = promptController.text;
    final modifiedPrompt = mood.isNotEmpty
        ? "$userPrompt The overall mood of the trip should be ${mood.toLowerCase()}."
        : userPrompt;

    final response = await itineraryRepository.generateItinerary(
      itineraryRequestBody: ItineraryRequestBody(
        model: 'gpt-4o',
        messages: [
          AiRequestMessage(role: "system", content: ApiConstant.systemPrompt),
          AiRequestMessage(role: "user", content: modifiedPrompt),
        ],
      ),
    );
    final currentContext =
        Navigation.router.routerDelegate.navigatorKey.currentContext;
    response.fold((exception) {
      snackBarCubit.showSnackBar(exception.toString());
      if (currentContext != null) {
        currentContext.pop();
      }
      emit(state?.copyWith(creatingItinerary: false));
    }, (itineraryResponse) async {
      if (itineraryResponse.travelItinerary?.dayPlans != null) {
        for (final day in itineraryResponse.travelItinerary!.dayPlans) {
          for (final activity in day.activities) {
            final query = activity.address;
            final images = await placesRepository.fetchMultipleImages(query);
            activity.images = images.isNotEmpty ? images : [];
          }
        }
      }
      var isPaidPlan = state?.travelItinerary?.isPaidPlan ?? false;
      var mood = state?.travelItinerary?.mood ?? '';
      if (state?.itineraryRequest != null) {
        // if it is coming from
        // itinerary request then it is already paid
        isPaidPlan = false;
      }
      emit(
        state?.copyWith(
            travelItinerary: itineraryResponse.travelItinerary
                ?.copyWith(isPaidPlan: isPaidPlan, mood: mood),
            creatingItinerary: false),
      );
      if (currentContext != null && currentContext.mounted) {
        moveToItineraryDetailsPage(state!.travelItinerary!,
            openedFromHome: false, replaceRoute: true);
      }
    });
  }

  Future<void> saveItinerary() async {
    emit(state?.copyWith(savingItinerary: true));
    if (state?.travelItinerary != null) {
      final currentUser = FirebaseAuth.instance.currentUser;
      final currentContext =
          Navigation.router.routerDelegate.navigatorKey.currentContext;

      final updatedItinerary = await _processImages(state!.travelItinerary!);
      String? uid = currentUser?.uid;
      String? createdBy = currentUser?.displayName;
      String? profileUrl = currentUser?.photoURL;
      TravelVisibility visibility =
          updatedItinerary.visibility ?? TravelVisibility.public();
      String? mood = updatedItinerary.mood;

      if (state?.itineraryRequest != null) {
        final request = state?.itineraryRequest;
        uid = request?.travelHeroId;
        createdBy = request?.travelHeroName;
        profileUrl = request?.travelHeroProfileUrl;
        mood = request?.mood;
        List<Requester> requesters = List.from(visibility.requesters);
        List<String> allowedUsers = List.from(visibility.allowedUsers);

        // ✅ Add the requester if not already in list
        if (!requesters.any((r) => r.id == request?.travellerId)) {
          requesters.add(Requester(
            id: request?.travellerId,
            name: request?.travellerName,
            profileUrl: request?.travellerProfileUrl,
          ));
        }

        // ✅ Ensure the traveler is in allowedUsers
        if (!allowedUsers.contains(request?.travellerId)) {
          allowedUsers.add(request!.travellerId);
        }

        visibility = TravelVisibility(
          type: VisibilityStatus.private.name,
          allowedUsers: allowedUsers,
          requesters: requesters,
        );
      }

      final coverUrls = getItineraryImages(itinerary: updatedItinerary);

      final response = await itineraryRepository.saveItinerary(
        uid: uid,
        travelItinerary: updatedItinerary.copyWith(
          rating: 3.0,
          isLiked: false,
          reviewCount: 4,
          price: 50.0,
          currency: 'USD',
          symbol: '\$',
          coverUrls: coverUrls,
          mood: mood,
          createdBy: createdBy ?? 'Muli Mobile',
          profileUrl: profileUrl ?? ApiConstant.paddyDoyleProfileUrl,
          isRequestedItinerary: state?.itineraryRequest != null,
          visibility: visibility,
        ),
      );

      response.fold((exception) {
        emit(
          state?.copyWith(savingItinerary: false),
        );
        snackBarCubit.showSnackBar(exception.toString());
      }, (travelItinerary) {
        offlineItineraryRepository.resetData();
        // if creating itinerary from review request screen then update the status
        if (state?.itineraryRequest != null) {
          itineraryRepository.updateRequest(
              request: state!.itineraryRequest!
                  .copyWith(status: ItineraryRequestStatus.accepted.name));

          resetItineraryRequest();
        }
        emit(state?.copyWith(
            travelItinerary: travelItinerary,
            savingItinerary: false,
            creatingItinerary: false));
        if (currentContext != null) {
          mainNavBarCubit.changeBottomNavBar(0);
          currentContext.goNamed(NavigationPath.homeRouteUri);
        }
      });
    }
  }

  Future<void> updateItinerary() async {
    emit(state?.copyWith(updatingItinerary: true));
    if (state?.travelItinerary != null) {
      final currentContext =
          Navigation.router.routerDelegate.navigatorKey.currentContext;

      final updatedItinerary = await _processImages(state!.travelItinerary!);
      final coverUrls = getItineraryImages(itinerary: updatedItinerary);

      final response = await itineraryRepository.updateItinerary(
          travelItinerary: updatedItinerary.copyWith(coverUrls: coverUrls));
      response.fold((exception) {
        emit(
          state?.copyWith(updatingItinerary: false),
        );
        snackBarCubit.showSnackBar(exception.toString());
      }, (itinerary) {
        offlineItineraryRepository.resetData();
        emit(state?.copyWith(
            travelItinerary: itinerary,
            updatingItinerary: false,
            savingItinerary: false,
            creatingItinerary: false));
        if (currentContext != null) {
          currentContext.goNamed(NavigationPath.homeRouteUri);
        }
      });
    }
  }

  Future<void> unlockItinerary() async {
    String? itineraryId = state?.travelItinerary?.id;
    if (itineraryId == null || itineraryId.isEmpty) return;
    emit(state?.copyWith(unlockingItinerary: true));
    final response =
        await itineraryRepository.unlockItinerary(itineraryId: itineraryId);
    response.fold(
      (exception) {
        snackBarCubit.showSnackBar(exception.toString());
        emit(state?.copyWith(unlockingItinerary: false));
      },
      (_) async {
        final updatedItinerary = state?.travelItinerary
            ?.copyWith(isPaidPlan: true, isUnlockedForCurrentUser: true);
        final currentContext =
            Navigation.router.routerDelegate.navigatorKey.currentContext;
        if (currentContext != null && currentContext.mounted) {
          currentContext.pop();
        }
        emit(state?.copyWith(
            travelItinerary: updatedItinerary, unlockingItinerary: false));
        offlineItineraryRepository.resetData();
      },
    );
  }

  String? validateValue(String? val, {String? message}) =>
      validateString(val, message: message);

  Future<TravelItinerary> _processImages(TravelItinerary itinerary) async {
    List<Future<List<String>>> uploadTasks = [];
    bool hasLocalFiles = false;
    List<List<String>> validUrlsList = [];

    // **Iterate through activities and prepare upload tasks**
    for (int i = 0; i < itinerary.dayPlans.length; i++) {
      for (int j = 0; j < itinerary.dayPlans[i].activities.length; j++) {
        final activity = itinerary.dayPlans[i].activities[j];

        // **Separate Valid URLs & Local Files**
        List<String> validUrls = [];
        List<File> localFiles = [];

        for (var img in activity.images) {
          if (img is String && img.startsWith("http")) {
            validUrls.add(img); // **Already a valid URL**
          } else if (img is File) {
            hasLocalFiles = true;
            localFiles.add(img); // **Local file, needs uploading**
          }
        }

        validUrlsList.add(validUrls); // Store valid URLs separately

        // **Create Upload Task for Local Files**
        if (localFiles.isNotEmpty) {
          uploadTasks.add(
            uploadRepository
                .uploadImages(
                  basePath:
                      "itineraries/${FirebaseAuth.instance.currentUser!.uid}/${itinerary.id}/day${i + 1}/activity${j + 1}",
                  images: localFiles,
                )
                .then((result) =>
                    Future.value(result.fold((error) => [], (urls) => urls))),
          );
        } else {
          uploadTasks
              .add(Future.value([])); // ✅ Fix: No duplicates if no local files
        }
      }
    }

    if (hasLocalFiles) {
      modalBloc.add(ShowGeneralDialogEvent(ImageUploadDialog()));
    }

    // **Wait for all uploads to complete**
    List<List<String>> uploadedImageLists = await Future.wait(uploadTasks);

    // **Update itinerary with merged valid & uploaded images**
    int index = 0;
    for (int i = 0; i < itinerary.dayPlans.length; i++) {
      for (int j = 0; j < itinerary.dayPlans[i].activities.length; j++) {
        // ✅ Fix: Merge valid & uploaded images correctly
        List<String> mergedImages =
            validUrlsList[index] + uploadedImageLists[index];

        itinerary = _updateActivityImages(itinerary, i, j, mergedImages);
        index++;
      }
    }

    // **CLOSE THE DIALOG ONLY IF IT WAS SHOWN**
    if (hasLocalFiles) {
      modalBloc.add(ModalPopped()); // Reset the state to ModalInitial
    }

    return itinerary;
  }

  /// **Update Activity with Processed Images**
  TravelItinerary _updateActivityImages(TravelItinerary itinerary, int dayIndex,
      int activityIndex, List<String> newImages) {
    return itinerary.copyWith(
      dayPlans: List.from(itinerary.dayPlans)
        ..[dayIndex] = itinerary.dayPlans[dayIndex].copyWith(
          activities: List.from(itinerary.dayPlans[dayIndex].activities)
            ..[activityIndex] =
                itinerary.dayPlans[dayIndex].activities[activityIndex].copyWith(
              images: newImages,
            ),
        ),
    );
  }

  void setItineraryRequest({
    required ItineraryRequest? request,
  }) {
    emit(state?.copyWith(
      itineraryRequest: request,
    ));
  }

  void resetItineraryRequest() {
    emit(state?.copyWith(
      itineraryRequest: null,
    ));
  }

  void navigateBack() {
    resetItineraryRequest();
    final currentContext =
        Navigation.router.routerDelegate.navigatorKey.currentContext;
    if (currentContext != null && currentContext.mounted) {
      currentContext.pop();
    }
  }

  bool isFormValid() {
    final formState = formKey.currentState;
    return formState != null && formState.validate();
  }

  bool isPaidWidget({required TravelItinerary? itinerary}) {
    if (itinerary == null) return false;
    if (itinerary.isPaidPlan) {
      if (isTravelerMode && itinerary.isUnlockedForCurrentUser == true) {
        return false;
      }
      return true;
    }
    return false;
  }

  void moveToItineraryDetailsPage(
    TravelItinerary itinerary, {
    bool openedFromHome = false,
    bool replaceRoute = false,
    bool isViewOnly = false,
  }) {
    emit(state?.copyWith(
      travelItinerary: itinerary,
      openedFromHome: openedFromHome,
      isViewOnly: isViewOnly,
    ));
    final currentContext =
        Navigation.router.routerDelegate.navigatorKey.currentContext;
    if (currentContext != null && currentContext.mounted) {
      replaceRoute
          ? currentContext.replaceNamed(NavigationPath.itineraryDetailRouteUri)
          : currentContext.pushNamed(
              NavigationPath.itineraryDetailRouteUri,
            );
    }
  }

  bool isFromHome(BuildContext context) {
    return context.read<CreateItineraryCubit>().state?.openedFromHome ?? false;
  }

  @override
  Future<void> close() {
    promptController.dispose();
    uploadProgressNotifier.dispose();
    return super.close();
  }
}
