import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_hero/src/domain/chat/message.dart';

class MessageRepository {
  final FirebaseFirestore firebaseFireStore;
  final FirebaseAuth firebaseAuth;

  MessageRepository({
    required this.firebaseAuth,
    required this.firebaseFireStore,
  });

  Future<void> createChatRoom(
      String chatRoomId, List<String> participants) async {
    await firebaseFireStore.collection('chats').doc(chatRoomId).set({
      'participants': participants,
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp()
    }, SetOptions(merge: true));
  }

  Stream<List<String>> getUserChatRooms({required String currentUserId}) {
    return firebaseFireStore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  // Future<Map<String, dynamic>> getChatRoomDetails(String chatRoomId) async {
  //   final chatDoc =
  //       await firebaseFireStore.collection('chats').doc(chatRoomId).get();
  //   if (!chatDoc.exists || !chatDoc.data()!.containsKey('participants'))
  //     return {};
  //
  //   final participants = List<String>.from(chatDoc['participants']);
  //   final currentUserId = firebaseAuth.currentUser?.uid;
  //
  //   if (currentUserId == null || participants.length < 2) return {};
  //   final otherUserId =
  //       participants.firstWhere((id) => id != currentUserId, orElse: () => "");
  //
  //   if (otherUserId.isEmpty) return {};
  //
  //   final userDoc =
  //       await firebaseFireStore.collection('users').doc(otherUserId).get();
  //   final lastMessageQuery = await firebaseFireStore
  //       .collection('chats')
  //       .doc(chatRoomId)
  //       .collection('messages')
  //       .orderBy('timestamp', descending: true)
  //       .limit(1)
  //       .get();
  //
  //   final lastMessage = lastMessageQuery.docs.isNotEmpty
  //       ? lastMessageQuery.docs.first['text'] as String
  //       : "No messages yet";
  //
  //   final hasUnread = lastMessageQuery.docs.isNotEmpty
  //       ? !(lastMessageQuery.docs.first['isRead'] as bool)
  //       : false;
  //
  //
  //   return {
  //     'chatRoomId': chatRoomId,
  //     'userId': otherUserId,
  //     'username': userDoc.get('username') ?? 'Unknown',
  //     'pictureUrl': userDoc.get('pictureUrl') ?? '',
  //     'lastMessage': lastMessage,
  //     'hasUnread': hasUnread,
  //   };
  // }
  Stream<List<Map<String, dynamic>>> getChatRoomsStream() {
    final String? currentUserId = firebaseAuth.currentUser?.uid;

    if (currentUserId == null) {
      return Stream.value([]); // Return an empty stream if the user is not logged in
    }

    return firebaseFireStore
        .collection('chats')
        .where('participants', arrayContains: currentUserId) // Get only current user's chats
        .orderBy('lastMessageTime', descending: true) // Latest chats first
        .snapshots()
        .asyncMap((snapshot) async {
      List<Map<String, dynamic>> chatRooms = [];

      for (var chatDoc in snapshot.docs) {
        final chatData = chatDoc.data();
        final List<String> participants = List<String>.from(chatData['participants']);

        final otherUserId =
        participants.firstWhere((id) => id != currentUserId, orElse: () => "");

        if (otherUserId.isEmpty) continue;

        final userDoc =
        await firebaseFireStore.collection('users').doc(otherUserId).get();

        chatRooms.add({
          'chatRoomId': chatDoc.id,
          'userId': otherUserId,
          'username': userDoc.get('username') ?? 'Unknown',
          'pictureUrl': userDoc.get('pictureUrl') ?? '',
          'lastMessage': chatData['lastMessage'] ?? "No messages yet",
          'lastMessageTime': chatData['lastMessageTime'],
        });
      }

      return chatRooms;
    });
  }


  Future<void> sendMessage({
    required String chatRoomId,
    required String receiverId,
    required String text,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) return;

    if (user.uid != chatRoomId) {
      createChatRoom(chatRoomId, [user.uid, chatRoomId]);
    }
    // Create message object with server timestamp placeholder
    final message = Message(
      receiverId: receiverId,
      senderId: user.uid,
      senderName: user.displayName ?? 'Unknown',
      senderAvatar: user.photoURL ?? '',
      text: text,
      timestamp: 0,
      // Will be replaced by server timestamp
      isLink: text.contains(RegExp(r'https?://')),
      isRead: false,
    );

    // Convert to JSON and add server timestamp
    final messageJson = message.toMap();
    messageJson['timestamp'] = FieldValue.serverTimestamp();

    // Batch write for atomic operations
    final batch = firebaseFireStore.batch();
    final chatRoomRef = firebaseFireStore.collection('chats').doc(chatRoomId);
    final messageRef = chatRoomRef.collection('messages').doc();

    // Batch operations
    batch.set(messageRef, messageJson);
    batch.update(chatRoomRef, {
      'lastMessage': text,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'participants': FieldValue.arrayUnion([user.uid, chatRoomId]),
    });

    await batch.commit();
  }

  Stream<List<Message>> getMessages({required String chatRoomId}) {
    return firebaseFireStore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
  }

  Stream<int> getUnreadMessagesCount() {
    String currentUserId = firebaseAuth.currentUser?.uid ?? '';

    return firebaseFireStore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .snapshots()
        .asyncMap((chatSnapshot) async {
      int totalUnread = 0;

      for (var chat in chatSnapshot.docs) {
        var unreadMessagesSnapshot = await firebaseFireStore
            .collection('chats')
            .doc(chat.id)
            .collection('messages')
            .where('senderId', isNotEqualTo: currentUserId)
            .where('isRead', isEqualTo: false)
            .get();

        totalUnread += unreadMessagesSnapshot.docs.length;
      }

      return totalUnread;
    });
  }

  Future<void> markMessagesAsRead({required String chatRoomId}) async {
    final user = firebaseAuth.currentUser;
    if (user == null) return;

    final querySnapshot = await firebaseFireStore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .where('receiverId', isEqualTo: user.uid)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = firebaseFireStore.batch();
    for (final doc in querySnapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }
}
