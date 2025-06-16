import * as admin from "firebase-admin";

// Initialize Firebase Admin SDK
admin.initializeApp();

export const sendPushNotification = async (fcmToken: string, title: string, body: string, data: object = {}) => {
  if (!fcmToken) {
    console.error("No FCM token found");
    return;
  }

  const message = {
    token: fcmToken,
    notification: {title, body},
    data: {...data, click_action: "FLUTTER_NOTIFICATION_CLICK"},
  };

  try {
    await admin.messaging().send(message);
    console.log("Notification sent successfully:", title);
  } catch (error) {
    console.error("Error sending push notification:", error);
  }
};
