import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {sendPushNotification} from "./notificationService";

export const sendNotificationOnRequestAccepted = functions.firestore
  .document("itinerary_requests/{requestId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    const requestId = context.params.requestId;

    if (before.status === after.status) return; // No status change

    if (after.status === "accepted") {
      const travellerId = after.travellerId;
      const travelHeroName = after.travelHeroName;

      // Fetch Traveler's FCM Token
      const travelerDoc = await admin.firestore().collection("users").doc(travellerId).get();
      const travellerToken = travelerDoc.data()?.deviceToken;

      if (!travellerToken) {
        console.warn(`No FCM token found for Traveler (${travellerId})`);
        return;
      }

      // Send Notification
      await sendPushNotification(travellerToken, "Your Request is Accepted", `${travelHeroName} has accepted your itinerary request!`, {
        type: "request_accepted",
        requestId: requestId,
      });
    }
  });