import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {sendPushNotification} from "./notificationService";

export const sendNotificationOnNewMessage = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snap, context) => {
    const messageData = snap.data();
    const senderId = messageData.senderId;
    const receiverId = messageData.receiverId;
    const senderName = messageData.senderName;
    const messageText = messageData.text || "New message"; // Use message text or default text

    if (!receiverId) {
      console.warn("Message document is missing receiverId");
      return;
    }

    // Fetch Receiver's FCM Token
    const receiverDoc = await admin.firestore().collection("users").doc(receiverId).get();
    const receiverToken = receiverDoc.data()?.deviceToken;

    if (!receiverToken) {
      console.warn(`No FCM token found for Receiver (${receiverId})`);
      return;
    }

    // Send Notification
    await sendPushNotification(receiverToken, `New message from ${senderName}`, messageText, {
      type: "new_message",
      chatId: context.params.chatId,
      messageId: context.params.messageId,
      senderId,
      receiverId,
    });

    console.log(`Notification sent for new message in chat: ${context.params.chatId}`);
  });
