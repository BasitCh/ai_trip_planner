import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notification_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notifications_state.dart';
import 'package:widgets_book/widgets_book.dart';
import 'widgets/widgets.dart';

class RequestedTripScreen extends StatefulWidget {
  const RequestedTripScreen({super.key});

  @override
  State<RequestedTripScreen> createState() =>
      _RequestedTripScreenState();
}

class _RequestedTripScreenState extends State<RequestedTripScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocConsumer<ItineraryRequestNotificationCubit,
              ItineraryNotificationRequestState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24),
                child: AppTextField(
                  onChanged:(value){
                    context.read<ItineraryRequestNotificationCubit>().searchRequests(value);
                  },
                  hintText: 'Search requested items',
                  suffix: Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: Assets.icons.icSearch.svg(),
                  ),
                ),
              ),
              const Gap(14),
              AllRequestsHeader(unreadCount: state.unreadCount,),
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount:
                        state.requests.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.requests.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                              child: AppButtonLoading(
                            color: AppColors.primary,
                          )),
                        );
                      }
                      final request = state.requests[index];
                      return request.status ==
                              ItineraryRequestStatus.rejected.name
                          ? UndoBannerWidget(
                              request: request,
                            )
                          : RequestListItem(
                              request: state.requests[index],
                              context: context,
                            );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !context
            .read<ItineraryRequestNotificationCubit>()
            .state
            .isLoadingMore &&
        context.read<ItineraryRequestNotificationCubit>().state.hasMoreData) {
      context.read<ItineraryRequestNotificationCubit>().loadMoreRequests();
    }
  }
}
