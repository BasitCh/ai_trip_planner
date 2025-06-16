import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/destination_search_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/request_itinerary_bloc_provider.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/bottom_button.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/destination_loaded.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/top_text.dart';
import 'package:travel_hero/widgets/custom_app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class DestinationSearchScreen extends StatelessWidget {
  const DestinationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ItineraryRequestBlocProvider(child: DestinationSearchUi());
  }
}

class DestinationSearchUi extends StatelessWidget {
  const DestinationSearchUi({super.key});

  @override
  Widget build(BuildContext context) {
    final destinationSearchCubit = context.read<DestinationSearchCubit>();
    return BaseScaffold(
        appBar: CustomAppBar(
          title: Text(
            'Select Destination',
            style: titleXSmallWhite?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TopText(),
                Gap(26.h),
                AppTextField(
                  controller: destinationSearchCubit.searchController,
                  hintText: 'Search for cities, regions, and places',
                  hintStyle: titleXSmallWhite?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: AppColors.textfieldBorder),
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Assets.icons.icSearch.svg(),
                  ),
                  borderRadius: 30,
                  bordersidecolor: BorderSide(color: AppColors.textfieldBorder),
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      context
                          .read<DestinationSearchCubit>()
                          .searchPlaces(query, null);
                    } else {
                      context.read<DestinationSearchCubit>().clearState();
                    }
                  },
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: BlocBuilder<DestinationSearchCubit,
                      DestinationSearchState>(
                    builder: (context, state) {
                      if (state is DestinationSearchLoading) {
                        return Center(
                            child: AppButtonLoading(
                          color: AppColors.primary,
                        ));
                      } else if (state is DestinationSearchLoaded &&
                          destinationSearchCubit
                              .searchController.text.isNotEmpty) {
                        return DestinationLoaded(
                          destinationSearchCubit: destinationSearchCubit,
                          destinationSearchLoaded: state,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
                Gap(16.0.h),
                BlocBuilder<DestinationSearchCubit, DestinationSearchState>(
                    builder: (context, state) {
                  return BottomButton(
                    onPressedNext: context
                            .read<DestinationSearchCubit>()
                            .isDestinationSelectDone
                        ? () => context
                            .pushNamed(NavigationPath.demographicScreenRouteUri)
                        : null,
                  );
                }),
                Gap(50.0.h),
              ],
            ),
          ),
        ));
  }
}
