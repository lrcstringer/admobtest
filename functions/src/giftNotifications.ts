/**
 * Gift & Token Spray Notification Triggers
 *
 * Firestore triggers that send FCM push notifications for gift and spray events.
 */

import { onDocumentCreated, onDocumentUpdated } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";

const db = admin.firestore();

/** Get a user's FCM token from their profile document. */
async function getFcmToken(userId: string): Promise<string | null> {
  const doc = await db.collection("users").doc(userId).get();
  return doc.data()?.fcmToken || null;
}

// ============================================================================
// GIFT NOTIFICATIONS
// ============================================================================

/**
 * Trigger: Gift created → notify recipient
 */
export const onGiftCreated = onDocumentCreated({ document: "gifts/{giftId}", retry: true, labels: { area: "gifts" } }, async (event) => {
  const snap = event.data;
  if (!snap) return;

  const gift = snap.data();

  const fcmToken = await getFcmToken(gift.recipientId);
  if (!fcmToken) return;

  try {
    await admin.messaging().send({
      token: fcmToken,
      notification: {
        title: `${gift.senderName} sent you a gift!`,
        body: `Tap to open your ${gift.amount} token gift`,
      },
      data: {
        type: "gift_received",
        giftId: snap.id,
        conversationId: gift.conversationId || "",
        communityId: gift.communityId || "",
      },
      android: {
        priority: "high",
        notification: { channelId: "gifts", sound: "default" },
      },
      apns: {
        headers: { "apns-priority": "10" },
        payload: { aps: { sound: "default", badge: 1 } },
      },
    });
  } catch (error) {
    logger.warn(`Failed to send gift notification to ${gift.recipientId}:`, error);
  }

  // Mark notification as sent
  await snap.ref.update({ notificationSent: true });
});

/**
 * Trigger: Gift status changes → notify relevant party
 *   pending → opened: notify sender
 *   opened → claimed: notify sender
 */
export const onGiftUpdated = onDocumentUpdated({ document: "gifts/{giftId}", retry: true, labels: { area: "gifts" } }, async (event) => {
  if (!event.data) return;

  const before = event.data.before.data();
  const after = event.data.after.data();

  // Only react to status changes
  if (before.status === after.status) return;

  // Gift opened → notify sender
  if (before.status === "pending" && after.status === "opened") {
    const fcmToken = await getFcmToken(after.senderId);
    if (fcmToken) {
      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: `${after.recipientName} opened your gift!`,
            body: `Your ${after.amount} token gift was opened`,
          },
          data: {
            type: "gift_opened",
            giftId: event.data.after.id,
          },
          android: {
            priority: "high",
            notification: { channelId: "gifts", sound: "default" },
          },
          apns: {
            headers: { "apns-priority": "10" },
            payload: { aps: { sound: "default", badge: 1 } },
          },
        });
      } catch (error) {
        logger.warn(`Failed to send gift opened notification to ${after.senderId}:`, error);
      }
    }
  }

  // Gift claimed → notify sender
  if (before.status === "opened" && after.status === "claimed") {
    const fcmToken = await getFcmToken(after.senderId);
    if (fcmToken) {
      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: `${after.recipientName} claimed your gift!`,
            body: `Your ${after.amount} token gift has been claimed`,
          },
          data: {
            type: "gift_claimed",
            giftId: event.data.after.id,
          },
          android: {
            priority: "high",
            notification: { channelId: "gifts", sound: "default" },
          },
          apns: {
            headers: { "apns-priority": "10" },
            payload: { aps: { sound: "default", badge: 1 } },
          },
        });
      } catch (error) {
        logger.warn(`Failed to send gift claimed notification to ${after.senderId}:`, error);
      }
    }
  }
});

// ============================================================================
// TOKEN SPRAY NOTIFICATIONS
// ============================================================================

/**
 * Trigger: Token spray status changes → notify relevant parties
 *   active → closed: notify recipient + top contributor
 */
export const onSprayUpdated = onDocumentUpdated({ document: "tokenSprays/{sprayId}", retry: true, labels: { area: "gifts" } }, async (event) => {
  if (!event.data) return;

  const before = event.data.before.data();
  const after = event.data.after.data();

  // Only react to status changes
  if (before.status === after.status) return;

  // Spray closed → notify recipient
  if (before.status === "active" && after.status === "closed") {
    // Notify recipient
    const recipientToken = await getFcmToken(after.recipientId);
    if (recipientToken) {
      try {
        await admin.messaging().send({
          token: recipientToken,
          notification: {
            title: "You received a Token Spray!",
            body: `The community celebrated with ${after.currentTotal} tokens!`,
          },
          data: {
            type: "spray_received",
            sprayId: event.data.after.id,
            communityId: after.communityId || "",
          },
          android: {
            priority: "high",
            notification: { channelId: "gifts", sound: "default" },
          },
          apns: {
            headers: { "apns-priority": "10" },
            payload: { aps: { sound: "default", badge: 1 } },
          },
        });
      } catch (error) {
        logger.warn(`Failed to send spray notification to ${after.recipientId}:`, error);
      }
    }

    // Notify top contributor
    const topContributors: any[] = after.topContributors || [];
    if (topContributors.length > 0) {
      const topContributor = topContributors[0];
      if (topContributor.userId !== after.recipientId) {
        const topToken = await getFcmToken(topContributor.userId);
        if (topToken) {
          try {
            await admin.messaging().send({
              token: topToken,
              notification: {
                title: "You're the Top Donor!",
                body: `You contributed the most to ${after.recipientName}'s celebration!`,
              },
              data: {
                type: "spray_top_contributor",
                sprayId: event.data.after.id,
                communityId: after.communityId || "",
              },
              android: {
                priority: "high",
                notification: { channelId: "gifts", sound: "default" },
              },
              apns: {
                headers: { "apns-priority": "10" },
                payload: { aps: { sound: "default", badge: 1 } },
              },
            });
          } catch (error) {
            logger.warn(`Failed to send top contributor notification:`, error);
          }
        }
      }
    }
  }
});
