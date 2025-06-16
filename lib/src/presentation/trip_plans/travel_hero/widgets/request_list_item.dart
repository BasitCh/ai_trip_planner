import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notification_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/infrastructure/utils/base_date_picker.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class RequestListItem extends StatelessWidget {
  const RequestListItem({
    required this.request,
    required this.context,
    super.key,
  });

  final ItineraryRequest request;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ItineraryRequestNotificationCubit>().markAsRead(request);
      },
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        margin: const EdgeInsets.only(top: 10),
        color: request.isRead! ? AppColors.white : AppColors.orange20,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          leading: CircleAvatar(
            child: CustomImageView(
              imagePath: request.travellerProfileUrl,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(50),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(left: 12)
            ,child: RichText(
              text: TextSpan(
                text: request.travellerName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textNormal,
                      fontWeight: FontWeight.w600,
                    ),
                children: [
                  const TextSpan(
                    text: ' has requested to ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: 'Create a trip plan',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeAgo(request.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textNormalSmall,
                    ),
              ),
              Assets.icons.icMore.svg(),
            ],
          ),
        ),
      ),
    );
  }
}
