import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/trip_plans/travel_hero/handle_requests.dart/itinerary_request_notification_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class UndoBannerWidget extends StatelessWidget {
  const UndoBannerWidget({
    super.key,
    required this.request,
  });

  final ItineraryRequest request;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ItineraryRequestNotificationCubit>();
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.only(top: 10),
      color: AppColors.red800,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        leading: CircleAvatar(
          child: CustomImageView(
            imagePath: request.travellerProfileUrl,
            fit: BoxFit.cover,
          ),
        ),
        title: RichText(
          text: TextSpan(
            text: 'You declined the request from ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
            children: [
              TextSpan(
                text: request.travellerName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        trailing: TextButton(
          onPressed: () {
            cubit.undoReject(
              request: request,
            );
          },
          child: Text(
            'Undo',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
