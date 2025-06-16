import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {sendPushNotification} from "./notificationService";

export const sendNotificationOnRequest = functions.firestore
  .document("itinerary_requests/{requestId}")
  .onCreate(async (snap, context) => {
    const requestData = snap.data();
    const travelHeroId = requestData.travelHeroId;
    const travellerName = requestData.travellerName;

    if (!travelHeroId) {
      console.warn("Request document missing travel hero Id");
      return;
    }

    // Fetch Travel Hero's FCM Token
    const travelHeroDoc = await admin.firestore().collection("users").doc(travelHeroId).get();
    const travelHeroToken = travelHeroDoc.data()?.deviceToken;

    if (!travelHeroToken) {
      console.warn(`No FCM token found for Travel Hero (${travelHeroId})`);
      return;
    }

    // Send Notification
    await sendPushNotification(travelHeroToken, "New Itinerary Request", `${travellerName} has requested an itinerary from you!`, {
      type: "request_received",
      requestId: context.params.requestId,
    });
  });
