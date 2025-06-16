import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/review_requests/review_request_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_repository.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/info_tile_trip.dart';
import 'package:travel_hero/widgets/create_trip_plan_app_bar.dart';
import 'package:travel_hero/widgets/chat_now_profile.dart';
import 'package:widgets_book/widgets_book.dart';

class ReviewRequestScreen extends StatelessWidget {
  const ReviewRequestScreen({
    super.key,
    required this.request,
  });

  final ItineraryRequest request;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewRequestCubit(
          request: request,
          repository: RepositoryProvider.of<ItineraryRepository>(context),
          snackBarCubit: BlocProvider.of<SnackBarCubit>(context)),
      child: _ReviewRequestView(),
    );
  }
}

class _ReviewRequestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createItineraryCubit = context.read<CreateItineraryCubit>();
    return BaseScaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backGroundColor,
      body: BlocBuilder<ReviewRequestCubit, ReviewRequestState>(
        builder: (context, state) {
          final cubit = context.read<ReviewRequestCubit>();
          final request = state.request;
          if (request?.status == ItineraryRequestStatus.inProgress.name) {
            createItineraryCubit.promptController.text =
                cubit.generateTripPrompt();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(90.h),
              const CreateTripPlanAppBar(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: ChatNowProfile(
                  request: cubit.request,
                ),
              ),
              Gap(16.h),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cubit.tripInfo.length,
                  itemBuilder: (context, index) {
                    return InfoTileTrip(
                        label: cubit.tripInfo[index]['label']!,
                        value: cubit.tripInfo[index]['value']!);
                  },
                ),
              ),
              Gap(16.h),
              request?.status == ItineraryRequestStatus.accepted.name
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: request?.status ==
                              ItineraryRequestStatus.inProgress.name
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10.0,
                              children: [
                                AppTextField(
                                  controller:
                                      createItineraryCubit.promptController,
                                  maxLines: 3,
                                  borderRadius: 20,
                                  textInputAction: TextInputAction.done,
                                  validator: (text) {
                                    return createItineraryCubit.validateValue(
                                        text,
                                        message: 'Please enter prompt');
                                  },
                                  contentPadding: EdgeInsets.only(
                                      left: 27, right: 80, top: 20, bottom: 20),
                                  hintText:
                                      'Create a hiking and camping Trip Plan for two in the Bangkok, Thailand. The trip should be for 2 days, starting from 3rd August 2024',
                                  bordersidecolor: BorderSide(
                                      color: AppColors.borderColorTextFiled
                                          .withAlpha((.35 * 255).toInt())),
                                  labelText: 'Write your prompt',
                                  hintStyle: subTitleStyle?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.hintTextFiled
                                          .withAlpha((.64 * 255).toInt())),
                                ),
                                SizedBox(
                                  height: 55.h,
                                  child: AppButton.lightRed(
                                    onPressed: () {
                                      createItineraryCubit.setItineraryRequest(
                                          request: request);
                                      context.pushNamed(NavigationPath
                                          .generatingTripPlanRouteUri);
                                    },
                                    child: Text(
                                      'Good to go',
                                      style: buttonStyle,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : SizedBox(
                              height: 55.h,
                              child: IgnorePointer(
                                ignoring: state.decliningRequest! ||
                                    state.progressingRequest!,
                                child: AppButton.lightRed(
                                  onPressed: () {
                                    cubit.addRequestToInProgress(
                                        controller: createItineraryCubit
                                            .promptController);
                                  },
                                  child: state.progressingRequest!
                                      ? AppButtonLoading()
                                      : Text(
                                          'Create Trip Plan for Request',
                                          style: buttonStyle,
                                        ),
                                ),
                              ),
                            ),
                    ),
              Gap(8.h),
              request?.status == ItineraryRequestStatus.accepted.name
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: SizedBox(
                        height: 55.h,
                        child: IgnorePointer(
                          ignoring: state.decliningRequest! ||
                              state.progressingRequest!,
                          child: AppButton.outlinedBlack(
                            onPressed: () {
                              cubit.declineRequest();
                            },
                            child: state.decliningRequest!
                                ? AppButtonLoading(
                                    color: AppColors.primary,
                                  )
                                : Text(
                                    'Decline Request',
                                    style: buttonStyle?.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
