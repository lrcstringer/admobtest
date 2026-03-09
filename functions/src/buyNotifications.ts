/**
 * Buy / Marketplace Notification Triggers
 *
 * Firestore triggers that send FCM push notifications for marketplace events:
 * - Order status changes (created, escrowed, fulfilled, completed, disputed, cancelled)
 * - Provider approval/rejection
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
// ORDER NOTIFICATIONS
// ============================================================================

/**
 * Trigger: Order created → notify seller
 */
export const onMarketplaceOrderCreated = onDocumentCreated(
  { document: "buyOrders/{orderId}", retry: true, labels: { area: "marketplace" } },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const order = snap.data();

    const fcmToken = await getFcmToken(order.sellerId);
    if (!fcmToken) return;

    try {
      await admin.messaging().send({
        token: fcmToken,
        notification: {
          title: "New order received!",
          body: `${order.buyerName || "A buyer"} ordered "${order.listingTitle}"`,
        },
        data: {
          type: "marketplace_order",
          orderId: snap.id,
        },
        android: {
          priority: "high",
          notification: { channelId: "marketplace", sound: "default" },
        },
        apns: {
          headers: { "apns-priority": "10" },
          payload: { aps: { sound: "default", badge: 1 } },
        },
      });
    } catch (error) {
      logger.warn(`Failed to send order created notification to seller ${order.sellerId}:`, error);
    }
  }
);

/**
 * Trigger: Order status changes → notify relevant party
 */
export const onMarketplaceOrderUpdated = onDocumentUpdated(
  { document: "buyOrders/{orderId}", retry: true, labels: { area: "marketplace" } },
  async (event) => {
    if (!event.data) return;

    const before = event.data.before.data();
    const after = event.data.after.data();

    // Only react to status changes
    if (before.status === after.status) return;

    const orderId = event.data.after.id;

    // escrowed → notify buyer + seller that payment is held
    if (after.status === "escrowed" && before.status !== "escrowed") {
      const [buyerToken, sellerToken] = await Promise.all([
        getFcmToken(after.buyerId),
        getFcmToken(after.sellerId),
      ]);

      if (buyerToken) {
        try {
          await admin.messaging().send({
            token: buyerToken,
            notification: {
              title: "Payment held safely",
              body: `Your ${after.amount} token payment for "${after.listingTitle}" is in escrow`,
            },
            data: { type: "marketplace_order", orderId },
            android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
            apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
          });
        } catch (error) {
          logger.warn(`Failed to send escrow notification to buyer ${after.buyerId}:`, error);
        }
      }

      if (sellerToken) {
        try {
          await admin.messaging().send({
            token: sellerToken,
            notification: {
              title: "Payment secured",
              body: `Buyer's payment for "${after.listingTitle}" is in escrow. Fulfil the order to proceed.`,
            },
            data: { type: "marketplace_order", orderId },
            android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
            apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
          });
        } catch (error) {
          logger.warn(`Failed to send escrow notification to seller ${after.sellerId}:`, error);
        }
      }
    }

    // fulfilled → notify buyer
    if (after.status === "fulfilled" && before.status !== "fulfilled") {
      const fcmToken = await getFcmToken(after.buyerId);
      if (fcmToken) {
        try {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Your order is ready!",
              body: `"${after.listingTitle}" has been marked as fulfilled. Confirm receipt to release payment.`,
            },
            data: { type: "marketplace_order", orderId },
            android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
            apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
          });
        } catch (error) {
          logger.warn(`Failed to send fulfilled notification to buyer ${after.buyerId}:`, error);
        }
      }
    }

    // completed → notify seller (payment released)
    if (after.status === "completed" && before.status !== "completed") {
      const fcmToken = await getFcmToken(after.sellerId);
      if (fcmToken) {
        try {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Payment released!",
              body: `You received ${after.amount} tokens for "${after.listingTitle}"`,
            },
            data: { type: "marketplace_order", orderId },
            android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
            apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
          });
        } catch (error) {
          logger.warn(`Failed to send payment released notification to seller ${after.sellerId}:`, error);
        }
      }
    }

    // disputed → notify other party
    if (after.status === "disputed" && before.status !== "disputed") {
      // Determine who raised the dispute (the party whose action changed status)
      // Notify the other party
      const [buyerToken, sellerToken] = await Promise.all([
        getFcmToken(after.buyerId),
        getFcmToken(after.sellerId),
      ]);

      // Notify both parties about the dispute
      for (const [token, label] of [[buyerToken, "buyer"], [sellerToken, "seller"]] as const) {
        if (token) {
          try {
            await admin.messaging().send({
              token,
              notification: {
                title: "Dispute raised",
                body: `A dispute has been raised on order "${after.listingTitle}"`,
              },
              data: { type: "marketplace_dispute", orderId },
              android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
              apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
            });
          } catch (error) {
            logger.warn(`Failed to send dispute notification to ${label}:`, error);
          }
        }
      }
    }

    // cancelled/refunded → notify other party
    if ((after.status === "cancelled" || after.status === "refunded") &&
        before.status !== "cancelled" && before.status !== "refunded") {
      // Notify seller about cancellation
      const sellerToken = await getFcmToken(after.sellerId);
      if (sellerToken) {
        try {
          await admin.messaging().send({
            token: sellerToken,
            notification: {
              title: "Order cancelled",
              body: `Order for "${after.listingTitle}" has been cancelled`,
            },
            data: { type: "marketplace_order", orderId },
            android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
            apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
          });
        } catch (error) {
          logger.warn(`Failed to send cancellation notification to seller ${after.sellerId}:`, error);
        }
      }
    }
  }
);

// ============================================================================
// PROVIDER NOTIFICATIONS
// ============================================================================

/**
 * Trigger: Provider status changes → notify provider
 */
export const onProviderStatusChanged = onDocumentUpdated(
  { document: "providers/{providerId}", retry: true, labels: { area: "marketplace" } },
  async (event) => {
    if (!event.data) return;

    const before = event.data.before.data();
    const after = event.data.after.data();

    // Only react to status changes
    if (before.status === after.status) return;

    const fcmToken = await getFcmToken(after.userId);
    if (!fcmToken) return;

    // Approved
    if (after.status === "approved" && before.status === "pending") {
      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: "You're approved to sell!",
            body: "Your marketplace seller registration has been approved. Start listing your products!",
          },
          data: { type: "provider_status", providerId: event.data.after.id },
          android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
          apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
        });
      } catch (error) {
        logger.warn(`Failed to send provider approved notification to ${after.userId}:`, error);
      }
    }

    // Rejected
    if (after.status === "rejected" && before.status === "pending") {
      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: "Registration not approved",
            body: "Your marketplace seller registration was not approved. Please contact support for details.",
          },
          data: { type: "provider_status", providerId: event.data.after.id },
          android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
          apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
        });
      } catch (error) {
        logger.warn(`Failed to send provider rejected notification to ${after.userId}:`, error);
      }
    }

    // Suspended
    if (after.status === "suspended") {
      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: "Account suspended",
            body: "Your marketplace seller account has been suspended. Please contact support.",
          },
          data: { type: "provider_status", providerId: event.data.after.id },
          android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
          apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
        });
      } catch (error) {
        logger.warn(`Failed to send provider suspended notification to ${after.userId}:`, error);
      }
    }
  }
);

// ============================================================================
// GROUP BUY NOTIFICATIONS
// ============================================================================

/**
 * Send FCM notification to all participants of a group buy.
 */
async function notifyGroupBuyParticipants(
  groupBuyId: string,
  title: string,
  body: string,
  excludeUserId?: string,
): Promise<void> {
  const contribSnap = await db
    .collection("groupBuys")
    .doc(groupBuyId)
    .collection("contributions")
    .get();

  const userIds = new Set<string>();
  for (const doc of contribSnap.docs) {
    const userId = doc.data().userId;
    if (userId && userId !== excludeUserId) {
      userIds.add(userId);
    }
  }

  // Parallelize FCM sends for better latency
  const sendPromises = Array.from(userIds).map(async (userId) => {
    const fcmToken = await getFcmToken(userId);
    if (!fcmToken) return;

    try {
      await admin.messaging().send({
        token: fcmToken,
        notification: { title, body },
        data: { type: "group_buy_milestone", groupBuyId },
        android: {
          priority: "high",
          notification: { channelId: "group_buy", sound: "default" },
        },
        apns: {
          headers: { "apns-priority": "10" },
          payload: { aps: { sound: "default", badge: 1 } },
        },
      });
    } catch (error) {
      logger.warn(`Failed to send group buy notification to ${userId}:`, error);
    }
  });

  await Promise.allSettled(sendPromises);
}

/**
 * Trigger: Group buy status changes → notify participants
 */
export const onGroupBuyUpdated = onDocumentUpdated(
  { document: "groupBuys/{groupBuyId}", retry: true, labels: { area: "group_buy" } },
  async (event) => {
    if (!event.data) return;

    const before = event.data.before.data();
    const after = event.data.after.data();
    const groupBuyId = event.data.after.id;

    // React to status changes
    if (before.status !== after.status) {
      // Target met → notify all participants
      if (after.status === "targetMet") {
        await notifyGroupBuyParticipants(
          groupBuyId,
          "Target reached! 🎉",
          `"${after.title}" has hit its target! The deal is completing...`,
        );
      }

      // Completed → notify all participants
      if (after.status === "completed") {
        await notifyGroupBuyParticipants(
          groupBuyId,
          "Group buy completed!",
          `"${after.title}" is complete. Tokens have been released.`,
        );
      }

      // Expired → notify all participants
      if (after.status === "expired") {
        await notifyGroupBuyParticipants(
          groupBuyId,
          "Group buy expired",
          `"${after.title}" didn't reach its target. Your tokens have been refunded.`,
        );
      }

      // Cancelled → notify all participants
      if (after.status === "cancelled") {
        await notifyGroupBuyParticipants(
          groupBuyId,
          "Group buy cancelled",
          `"${after.title}" has been cancelled. Your tokens have been refunded.`,
        );
      }
    }

    // React to progress milestones (50%, 75%)
    if (before.currentAmount !== after.currentAmount && after.targetAmount > 0) {
      const prevPercent = Math.floor((before.currentAmount / after.targetAmount) * 100);
      const currPercent = Math.floor((after.currentAmount / after.targetAmount) * 100);

      if (prevPercent < 50 && currPercent >= 50) {
        await notifyGroupBuyParticipants(
          groupBuyId,
          "Halfway there! 🔥",
          `"${after.title}" is 50% funded — keep sharing!`,
        );
      }

      if (prevPercent < 75 && currPercent >= 75) {
        const spotsLeft = (after.maxParticipants || 0) -
          (after.participantCount || 0);
        const spotsText = spotsLeft > 0 ? ` ${spotsLeft} spots left!` : "";
        await notifyGroupBuyParticipants(
          groupBuyId,
          "Almost there! 💪",
          `"${after.title}" is 75% funded.${spotsText}`,
        );
      }
    }
  }
);
