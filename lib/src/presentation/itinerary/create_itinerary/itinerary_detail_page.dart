import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/blocs/modal/modal_widget.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_state.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/days_widget.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/google_map.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/trip_plan_card_header.dart';
import 'package:travel_hero/widgets/create_trip_plan_app_bar.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class ItineraryDetailPage extends StatefulWidget {
  const ItineraryDetailPage({
    super.key,
  });

  @override
  State<ItineraryDetailPage> createState() => _ItineraryDetailPageState();
}

class _ItineraryDetailPageState extends State<ItineraryDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createItineraryCubit = context.read<CreateItineraryCubit>();
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          createItineraryCubit.resetItineraryRequest();
        }
      },
      child: BaseScaffold(
        body: ModalWidget(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<CreateItineraryCubit, CreateItineraryState?>(
                  builder: (context, state) {
                    var images = state?.travelItinerary?.coverUrls ?? [];

                    return NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        if (createItineraryCubit.isFromHome(context))
                          SliverAppBar(
                            expandedHeight: 300.0,
                            floating: false,
                            pinned: true,
                            snap: false,
                            centerTitle: true,
                            backgroundColor: innerBoxIsScrolled
                                ? AppColors.primary
                                : AppColors.transparent,
                            title: createItineraryCubit.isFromHome(context)
                                ? Text(
                                    'Trip Plan',
                                    style: titleXSmallWhite?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                    ),
                                  )
                                : null,
                            flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.parallax,
                                background: createItineraryCubit
                                        .isFromHome(context)
                                    ? images.isNotEmpty
                                        ? images.first is String
                                            ? CustomImageView(
                                                radius:
                                                    BorderRadius.circular(12),
                                                imagePath: images.first,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                images.first,
                                                height: 150,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              )
                                        : SizedBox.shrink()
                                    : SizedBox.shrink()),
                            leading: IconButton(
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () {
                                createItineraryCubit.navigateBack();
                              },
                            ),
                            actions: [],
                          ),
                      ],
                      body: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.only(
                                top: createItineraryCubit.isFromHome(context)
                                    ? 10
                                    : 50),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                createItineraryCubit.isFromHome(context)
                                    ? SizedBox.shrink()
                                    : CreateTripPlanAppBar(
                                        showProgressBar: true,
                                        current: 4,
                                        stepText: 'Review Trip Plan',
                                        titleText: 'Create a Trip Plan',
                                        subTitleText:
                                            'Review the Trip Plan before publishing it.\nYou can edit the details manually if needed.',
                                        max: 4,
                                      ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: TripPlanCardHeader(
                                    travelItinerary: state?.travelItinerary,
                                  ),
                                ),
                                Gap(20.h),
                                GoogleMapWidget(),
                                if (state?.travelItinerary?.dayPlans !=
                                    null) ...[
                                  Gap(10.h),
                                  DaysWidget(
                                    travelItinerary: state?.travelItinerary,
                                    isViewOnly: state?.isViewOnly ?? false,
                                  ),
                                  Gap(20.h),
                                ]
                              ]),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child:
                      BlocBuilder<CreateItineraryCubit, CreateItineraryState?>(
                    builder: (context, state) {
                      if (state == null) return SizedBox.shrink();
                      if ((state.isViewOnly ?? false)) {
                        return helpMePlanMyTrip(state: state, context: context);
                      }
                      return state.openedFromHome!
                          ? isTravelerMode
                              ? helpMePlanMyTrip(state: state, context: context)
                              : saveButton(state: state, context: context)
                          : publishButton(state: state, context: context);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget helpMePlanMyTrip(
    {required CreateItineraryState? state, required BuildContext context}) {
  return AppButton.lightRed(
    onPressed: () {
      context.pushNamed(NavigationPath.destinationScreenRouteUri);
    },
    radius: 30,
    child: state!.savingItinerary!
        ? AppButtonLoading()
        : Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.icTakeoff.svg(),
              Text(
                'Help me plan my trip',
                style: titleMediumSaira?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
  );
}

Widget publishButton(
    {required CreateItineraryState? state, required BuildContext context}) {
  return IgnorePointer(
    ignoring: state?.savingItinerary ?? false,
    child: AppButton.lightRed(
      onPressed: () {
        context.read<CreateItineraryCubit>().saveItinerary();
      },
      radius: 30,
      child: state!.savingItinerary!
          ? AppButtonLoading()
          : Text(
              'Great, Publish It',
              style: titleMediumSaira?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
    ),
  );
}

Widget saveButton(
    {required CreateItineraryState? state, required BuildContext context}) {
  return IgnorePointer(
    ignoring: state?.updatingItinerary ?? false,
    child: AppButton.lightRed(
      onPressed: () {
        context.read<CreateItineraryCubit>().updateItinerary();
      },
      radius: 30,
      child: state!.updatingItinerary!
          ? AppButtonLoading()
          : Text(
              'Save',
              style: titleMediumSaira?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
    ),
  );
}
