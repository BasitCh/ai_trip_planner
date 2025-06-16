import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/blocs/modal/modal_widget.dart';
import 'package:travel_hero/src/application/home/home_cubit.dart';
import 'package:travel_hero/src/application/home/home_state.dart';
import 'package:travel_hero/src/application/main/cubit/account_type_cubit.dart';
import 'package:travel_hero/src/presentation/home/home_bloc_provider.dart';
import 'package:travel_hero/src/presentation/home/widgets/itineraries_listview.dart';
import 'package:travel_hero/widgets/no_trip_plan.dart';
import 'package:travel_hero/widgets/profile_top_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
    context.read<HomeCubit>().fetchTravelItineraries();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBlocProvider(
      child: BlocListener<AccountTypeCubit, AccountType>(
        listener: (context, state) {
          if (state == AccountType.traveler ||
              state == AccountType.travelHero) {
            context.read<HomeCubit>().fetchTravelItineraries();
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ModalWidget(
            child: Column(
              children: [
                ProfileTopBar(
                  key: Key('1'),
                ),
                Gap(10.h),
                BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) {
                  return previous != current;
                }, builder: (context, state) {
                  if (state is HomeLoaded) {
                    if (state.itineraries.isNotEmpty) {
                      return ItinerariesListview(
                        itineraries: state.itineraries,
                        isLoadingMore: state.isLoadingMore,
                      );
                    } else {
                      return NoTripPlan();
                    }
                  } else if (state is HomeLoading) {
                    return AppButtonLoading(
                      color: AppColors.primary,
                    );
                  } else if (state is HomeError) {
                    return NoTripPlan();
                  }

                  return const SizedBox.shrink();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<HomeCubit>().fetchMoreItineraries();
    }
  }
}
