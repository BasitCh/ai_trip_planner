import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/filter_traveler_itinerary_cubit/filter_traveler_itinerary_cubit.dart';
import 'package:travel_hero/src/application/trip_plans/traveller/filter_traveler_itinerary_cubit/filter_traveler_itinerary_state.dart';
import 'package:travel_hero/src/infrastructure/itinerary/filtered_itinerary_repository.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/trip_plans/traveller/widgets/trip_list_item.dart';
import 'package:widgets_book/widgets_book.dart';

class TravelerFilteredItineraries extends StatefulWidget {
  const TravelerFilteredItineraries({super.key});

  @override
  State<TravelerFilteredItineraries> createState() =>
      _TravelerFilteredItinerariesState();
}

class _TravelerFilteredItinerariesState
    extends State<TravelerFilteredItineraries> {
  late ScrollController _scrollController;
  ItineraryFilterType selectedFilter = ItineraryFilterType.all;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<FilterTravelerItineraryCubit>().loadInitial(selectedFilter);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FilterTravelerItineraryCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterTravelerItineraryCubit,
        FilterTravelerItineraryState>(
      builder: (context, state) {
        final filteredList =
            state.filter == selectedFilter ? state.itineraries : [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10.h),
            Text(
              'Completed Trip Plans',
              style: titleMediumSaira?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            _buildFilterChips(context, state),
            Expanded(
              child: state.isLoading
                  ? Center(
                      child: AppButtonLoading(
                        color: AppColors.primary,
                      ),
                    )
                  : state.error != null
                      ? Center(
                          child: Text(
                            state.error ?? '',
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () => context
                              .read<FilterTravelerItineraryCubit>()
                              .loadInitial(selectedFilter),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            itemCount:
                                filteredList.length + (state.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == filteredList.length) {
                                return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: AppButtonLoading(
                                      color: AppColors.primary,
                                    ));
                              }
                              return TripListItem(
                                travelItinerary: filteredList[index],
                                context: context,
                              );
                            },
                          ),
                        ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChips(
      BuildContext context, FilterTravelerItineraryState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Wrap(
        spacing: 12,
        children: ItineraryFilterType.values.map((filter) {
          final isSelected = selectedFilter == filter;
          return ChoiceChip(
            showCheckmark: false,
            padding: EdgeInsets.symmetric(horizontal: 20),
            label: Text(
              _filterLabel(filter),
              textAlign: TextAlign.center,
              style: titleXSmallWhite?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.white
                    : AppColors.shadeColor.withValues(alpha: 0.90),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17), // ✅ Rounded edges
              side: BorderSide(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.platinumGrey, // ✅ Border color
              ),
            ),
            color: WidgetStatePropertyAll(
              isSelected ? AppColors.primary : Colors.white,
            ),
            selected: isSelected,
            onSelected: (_) {
              setState(() => selectedFilter = filter);
              context
                  .read<FilterTravelerItineraryCubit>()
                  .loadInitial(selectedFilter);
            },
          );
        }).toList(),
      ),
    );
  }

  String _filterLabel(ItineraryFilterType filter) {
    switch (filter) {
      case ItineraryFilterType.all:
        return 'All';
      case ItineraryFilterType.custom:
        return 'Custom';
      case ItineraryFilterType.unlocked:
        return 'Unlocked';
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
