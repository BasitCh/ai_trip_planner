import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/global/global.dart';
import 'package:travel_hero/src/application/chat/message_cubit.dart';
import 'package:travel_hero/src/domain/chat/message.dart';
import 'package:travel_hero/src/infrastructure/chat/message_repository.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/chat/widgets/chat_bubble.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:travel_hero/src/presentation/chat/widgets/date_chip/date_chip.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatelessWidget {
  final String chatRoomId;
  final String receiverName;
  final String receiverAvatar;
  final String receiverId;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageCubit(
        messageRepository: context.read<MessageRepository>(),
        chatRoomId: chatRoomId, // Pass receiver ID
        receiverId: receiverId,
        context: context,
      ),
      child: BaseScaffold(
        backgroundColor: AppColors.backGroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          title: receiverAvatar.isNotEmpty && isUrl(receiverAvatar)?CustomImageView(
            width: 40,
            height: 40,
            radius: BorderRadius.circular(50),
            imagePath: receiverAvatar,
          ):Assets.icons.icProfile.svg(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child:
                  InkWell(onTap: () {}, child: Assets.icons.icHomeChat.svg()),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<MessageCubit, MessageState>(
                builder: (context, state) {
                  if (state is MessageLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ));
                  }

                  // Extract messages based on the state type
                  List<Message> messages = [];
                  Map<String, PreviewData> previewData = {};

                  if (state is MessageLoaded) {
                    messages = state.messages;
                    previewData = state.previewData;
                  } else if (state is MessageTyping) {
                    messages =
                        state.messages; // Ensure messages persist while typing
                    previewData = state.previewData;
                  }

                  if (messages.isEmpty) {
                    return Center(
                        child: Text(
                      "No messages yet.",
                      style: titleMediumSaira?.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.darkGray2,
                          fontWeight: FontWeight.w400),
                    ));
                  }

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      bool showDateChip = shouldShowDateChip(
                        messages[index].timestamp,
                        index < messages.length - 1
                            ? messages[index + 1].timestamp
                            : null, // Use next message for comparison
                      );
                      return Column(
                        key: ValueKey(message.senderId),
                        // Unique key for each message
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showDateChip) // Place DateChip before the first message of the day
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: DateChip(
                                  date: DateTime.fromMillisecondsSinceEpoch(
                                      messages[index].timestamp),
                                  color: Color(0x558AD3D5),
                                ),
                              ),
                            ),
                          ChatBubble(
                            message: message,
                            messageState: state is MessageLoaded ? state : null,
                            // Pass only if it's MessageLoaded
                            messageCubit: context.read<MessageCubit>(),
                            isCurrentUser: message.senderId ==
                                FirebaseAuth.instance.currentUser!.uid,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        final messageCubit = context.read<MessageCubit>();

        return Column(
          children: [
            // Show emoji picker when toggled
            if (state is MessageLoaded && state.isEmojiPickerVisible)
              SizedBox(
                height: 250,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    messageCubit.messageController.text += emoji.emoji;

                    // Hide emoji picker after selecting an emoji
                    messageCubit.toggleEmojiPicker();
                  },
                  config: Config(
                    height: 256,
                    checkPlatformCompatibility: true,
                    viewOrderConfig: const ViewOrderConfig(),
                    emojiViewConfig: EmojiViewConfig(
                      emojiSizeMax: 28 *
                          (foundation.defaultTargetPlatform ==
                                  TargetPlatform.iOS
                              ? 1.2
                              : 1.0),
                    ),
                    skinToneConfig: const SkinToneConfig(),
                    categoryViewConfig: const CategoryViewConfig(),
                    bottomActionBarConfig: const BottomActionBarConfig(),
                    searchViewConfig: const SearchViewConfig(),
                  ),
                ),
              ),

            Container(
              padding:
                  EdgeInsets.only(left: 19, right: 30, top: 14, bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white, // Equivalent to #FFF
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE5E5EA), // Equivalent to #E5E5EA
                    offset: Offset(0, -1), // Top shadow
                    blurRadius: 0, // No blur, similar to the CSS
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: AppTextField(
                controller: messageCubit.messageController,
                onChanged: (_) => messageCubit.onTextChanged(),
                bordersidecolor: BorderSide(color: AppColors.transparent),
                fillcolor: AppColors.white,
                borderRadius: 0,
                focusedcolor: BorderSide(color: AppColors.transparent),
                hintText: 'See you all then!',
                hintStyle: titleMediumSaira?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onyx),
                suffix: InkWell(
                  onTap: () => messageCubit.sendMessage(),
                  child: Assets.icons.icSend.svg(),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   // Even spacing
                //   mainAxisSize: MainAxisSize.min,
                //   // Avoid excess width
                //   children: [
                //     Expanded(
                //       flex: 5,
                //       child: InkWell(
                //         onTap: () {
                //           final textController = messageCubit.messageController;
                //           final cursorPos = textController.selection.baseOffset;
                //
                //           if (cursorPos < 0) {
                //             textController.text += "@";
                //           } else {
                //             final text = textController.text;
                //             textController.text =
                //                 "${text.substring(0, cursorPos)}@${text.substring(cursorPos)}";
                //             textController.selection =
                //                 TextSelection.fromPosition(
                //               TextPosition(offset: cursorPos + 1),
                //             );
                //           }
                //         },
                //         child: Assets.icons.icAtTheRate.svg(),
                //       ),
                //     ),
                //     Gap(5), // Reduce gap if necessary
                //     Expanded(
                //       flex: 5,
                //       child: InkWell(
                //         onTap: () => messageCubit.sendMessage(),
                //         child: Assets.icons.icSend.svg(),
                //       ),
                //     ),
                //   ],
                // ),
                prefix: InkWell(
                  onTap: () => messageCubit.toggleEmojiPicker(),
                  child: Assets.icons.icEmoji.svg(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
