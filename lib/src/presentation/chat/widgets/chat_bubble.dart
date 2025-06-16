import 'package:flutter/material.dart';
import "package:flutter_chat_types/src/preview_data.dart" show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:travel_hero/global/global.dart';
import 'package:travel_hero/src/application/chat/message_cubit.dart';
import 'package:travel_hero/src/domain/chat/message.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/chat/widgets/chat_bubble_tail_painter.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final dynamic messageState;
  final MessageCubit messageCubit;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageState,
    required this.messageCubit,
  });

  @override
  Widget build(BuildContext context) {
    String? url = messageCubit.extractUrl(message.text);
    final previewData = messageState.previewData[url];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            CustomImageView(
              imagePath: message.senderAvatar,
              radius: BorderRadius.circular(50),
              height: 32,
              width: 32,
            ),
            SizedBox(width: 10),
          ],
          BubbleSpecialOne(
            text: url == null ? message.text : "",
            // Hide text if preview exists
            isSender: isCurrentUser,
            color: isCurrentUser ? AppColors.primary : AppColors.greyNewChat,
            tail: !isCurrentUser,
            textStyle: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black,
              fontSize: 16,
            ),
            child: url != null && previewData != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinkPreview(
                        enableAnimation: true,
                        previewData: previewData,
                        text: message.text,
                        width: context.width,
                        linkStyle: titleXSmallWhite?.copyWith(
                            fontSize: 14.sp,
                            color: !isCurrentUser
                                ? AppColors.darkGray2
                                : AppColors.white,
                            fontWeight: FontWeight.w900),
                        metadataTextStyle: titleXSmallWhite?.copyWith(
                            fontSize: 12.sp,
                            color: !isCurrentUser
                                ? AppColors.darkGray2
                                : AppColors.white,
                            fontWeight: FontWeight.w400),
                        metadataTitleStyle: titleMediumSaira?.copyWith(
                            fontSize: 16.sp,
                            color: !isCurrentUser
                                ? AppColors.darkGray2
                                : AppColors.white,
                            fontWeight: FontWeight.w700),
                        textStyle: titleXSmallWhite?.copyWith(
                            fontSize: 14.sp,
                            color: !isCurrentUser
                                ? AppColors.darkGray2
                                : AppColors.white,
                            fontWeight: FontWeight.w900),
                        onPreviewDataFetched: (PreviewData previewData) {},
                      ),
                    ),
                  )
                : SizedBox(
                    width: context.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        !isCurrentUser
                            ? Text(
                                message.senderName,
                                style: titleXSmallWhite?.copyWith(
                                    fontSize: 14.sp,
                                    color: !isCurrentUser
                                        ? AppColors.darkGray2
                                        : AppColors.white,
                                    fontWeight: FontWeight.w900),
                              )
                            : SizedBox.shrink(),
                        Text(
                          message.text,
                          style: titleXSmallWhite?.copyWith(
                              fontSize: 14.sp,
                              color: !isCurrentUser
                                  ? AppColors.darkGray2
                                  : AppColors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              getFormatTimestamp(message.timestamp),
                              style: titleXSmallWhite?.copyWith(
                                  fontSize: 12.sp,
                                  color: !isCurrentUser
                                      ? AppColors.textGreyChat
                                      : AppColors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            _buildMessageStatusIcon(message)
                          ],
                        ),

                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
  /// Builds the message status icon (sent, delivered, read).
  Widget _buildMessageStatusIcon(Message message) {
    if (!isCurrentUser) return SizedBox.shrink(); // Show only for sender

    if (!message.isRead) {
      return Icon(Icons.check, color: Colors.white, size: 16); // Delivered but not read
    } else {
      return Icon(Icons.done_all, color: Colors.white, size: 16); // Read
    }
  }
}
