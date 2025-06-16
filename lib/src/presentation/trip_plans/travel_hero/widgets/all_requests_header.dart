import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notification_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class AllRequestsHeader extends StatelessWidget {
  const AllRequestsHeader({required this.unreadCount, super.key});

  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF2F2F2), // Border color
            width: 1.5, // Border width
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "All Requests" with badge
          Row(
            children: [
              Text(
                'All Requests',
                style: titleMediumSaira?.copyWith(
                  color: AppColors.textSecondary4,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                )
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryNormal,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$unreadCount',
                  style: bodySmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500
                )
                ),
              ),
            ],
          ),

          // "Show Completed" with icons
          // Row(
          //   children: [
          //     InkWell(
          //       onTap: (){
          //         context.read<ItineraryRequestNotificationCubit>().searchRequests('accepted');
          //       },
          //       child: Text(
          //         'Show Completed',
          //         style: bodySmall?.copyWith(
          //             color: AppColors.black,
          //             fontWeight: FontWeight.w600
          //         ),
          //       ),
          //     ),
          //     Gap(4),
          //     Assets.icons.icCompleted.svg(),
          //     Gap(16),
          //     Assets.icons.icSort.svg(),
          //   ],
          // ),
        ],
      ),
    );
  }
}