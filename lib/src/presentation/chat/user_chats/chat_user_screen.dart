import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travel_hero/src/application/chat/chat_users_cubit.dart';
import 'package:travel_hero/src/infrastructure/chat/message_repository.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_app_bar.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class ChatUsersScreen extends StatelessWidget {
  const ChatUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: CustomAppBar(
        title: Text("All Messages",
            style: titleXSmallWhite?.copyWith(
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ChatUsersCubit(
          messageRepository: context.read<MessageRepository>(),
        ),
        child: BlocBuilder<ChatUsersCubit, ChatUsersState>(
          builder: (context, state) {
            if (state is ChatUsersLoading) {
              return Center(
                  child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is ChatUsersLoaded) {
              return Padding(
                padding: const EdgeInsets.only(top: 46.0),
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];

                    return Padding(
                      padding: EdgeInsets.only(left: 17, right: 17,bottom: 27),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CustomImageView(
                            imagePath: user['pictureUrl'],
                            height: 44,
                            width: 44,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            user['username'] ?? '',
                            style: titleXSmallWhite?.copyWith(
                                fontSize: 19.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            user['lastMessage'] ?? '',
                            style: titleXSmallWhite?.copyWith(
                                fontSize: 13.sp,
                                color: AppColors.spanishGrey,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        trailing: Text(
                          formatTime(user['lastMessageTime']),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          context.pushNamed(
                            NavigationPath.chatRouteUri,
                            pathParameters: {
                              'chatRoomId': user['chatRoomId'] ?? '',
                              'receiverName':
                                  Uri.encodeComponent(user['username'] ?? ''),
                              'receiverAvatar':
                                  Uri.encodeComponent(user['pictureUrl'] ?? ''),
                              'receiverId': user['userId'] ?? '',
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else if (state is ChatUsersError) {
              return Center(child: Text("Error: ${state.errorMessage}"));
            }
            return Container();
          },
        ),
      ),
    );
  }

  /// Formats timestamp into readable date (Today, Yesterday, Date) with AM/PM format.
  String formatTime(dynamic timestamp) {
    if (timestamp == null) return '';

    final DateTime dateTime =
        (timestamp is String) ? DateTime.parse(timestamp) : timestamp.toDate();
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return DateFormat('hh:mm a')
          .format(dateTime); // 12-hour format with AM/PM
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE')
          .format(dateTime); // Shows weekday (e.g., Monday)
    } else {
      return DateFormat('MM/dd/yy').format(dateTime); // Shows date (MM/DD/YY)
    }
  }
}
