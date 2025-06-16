import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class ChatNowProfile extends StatelessWidget {
  const ChatNowProfile(
      {required this.request, super.key, this.chatOnPressed});

  final ItineraryRequest request;
  final VoidCallback? chatOnPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 4),
      leading: CustomImageView(
        radius: BorderRadius.circular(50),
        imagePath: request.travellerProfileUrl
            ),
      title: Text(
        request.travellerName ?? '',
        style: titleXSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
      ),
      subtitle: Text(
        'Trip Plan to ${request.placeName} for ${request.duration} days, ${request.people} persons',
        style: titleXSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          fontSize: 12.sp,
        ),
      ),
      trailing: AppButton.outlineGreySmall(
        onPressed: chatOnPressed ??
            () {
              context.pushNamed(
                NavigationPath.chatRouteUri,
                pathParameters: {
                  //'chatRoomId':'plf0zkAiCAcyBmceSkQvRQv7w6E2',
                  'chatRoomId': request.travellerId,
                  'receiverName': Uri.encodeComponent(request.travellerName??''),
                  'receiverAvatar': Uri.encodeComponent(request.travellerProfileUrl??''),
                  'receiverId':request.travellerId??'',
                },
              );
            },
        child: Text(
          'Chat Now',
          style: titleXSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textNormalSmall,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
