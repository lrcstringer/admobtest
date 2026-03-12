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

/**
 * Send an FCM notification. Re-throws non-token errors so Firebase retries the trigger.
 * Silently ignores stale/unregistered tokens (no point retrying those).
 */
async function sendFcm(message: admin.messaging.Message, context: string): Promise<void> {
  try {
    await admin.messaging().send(message);
  } catch (error: unknown) {
    const msg = error instanceof Error ? error.message : String(error);
    // Stale/invalid token — don't retry, just log
    if (msg.includes("not-registered") || msg.includes("invalid-registration-token")) {
      logger.warn(`${context}: token invalid/unregistered, skipping`);
      return;
    }
    logger.error(`${context}:`, error);
    throw error;
  }
}

/** Get a user's FCM token from their profile document. Skips soft-deleted users. */
async function getFcmToken(userId: string): Promise<string | null> {
  const doc = await db.collection("users").doc(userId).get();
  if (!doc.exists) return null;
  const data = doc.data();
  if (data?.isDeleted === true) return null;
  return data?.fcmToken || null;
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

    await sendFcm({
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
    }, `Order created notification to seller ${order.sellerId}`);
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
    const androidMp = { priority: "high" as const, notification: { channelId: "marketplace", sound: "default" } };
    const apnsMp = { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } };

    // escrowed → notify buyer + seller that payment is held
    if (after.status === "escrowed" && before.status !== "escrowed") {
      const [buyerToken, sellerToken] = await Promise.all([
        getFcmToken(after.buyerId),
        getFcmToken(after.sellerId),
      ]);

      if (buyerToken) {
        await sendFcm({
          token: buyerToken,
          notification: {
            title: "Payment held safely",
            body: `Your ${after.amount} token payment for "${after.listingTitle}" is in escrow`,
          },
          data: { type: "marketplace_order", orderId },
          android: androidMp, apns: apnsMp,
        }, `Escrow notification to buyer ${after.buyerId}`);
      }

      if (sellerToken) {
        await sendFcm({
          token: sellerToken,
          notification: {
            title: "Payment secured",
            body: `Buyer's payment for "${after.listingTitle}" is in escrow. Fulfil the order to proceed.`,
          },
          data: { type: "marketplace_order", orderId },
          android: androidMp, apns: apnsMp,
        }, `Escrow notification to seller ${after.sellerId}`);
      }
    }

    // fulfilled → notify buyer
    if (after.status === "fulfilled" && before.status !== "fulfilled") {
      const fcmToken = await getFcmToken(after.buyerId);
      if (fcmToken) {
        await sendFcm({
          token: fcmToken,
          notification: {
            title: "Your order is ready!",
            body: `"${after.listingTitle}" has been marked as fulfilled. Confirm receipt to release payment.`,
          },
          data: { type: "marketplace_order", orderId },
          android: androidMp, apns: apnsMp,
        }, `Fulfilled notification to buyer ${after.buyerId}`);
      }
    }

    // completed → notify seller (payment released)
    if (after.status === "completed" && before.status !== "completed") {
      const fcmToken = await getFcmToken(after.sellerId);
      if (fcmToken) {
        await sendFcm({
          token: fcmToken,
          notification: {
            title: "Payment released!",
            body: `You received ${after.amount} tokens for "${after.listingTitle}"`,
          },
          data: { type: "marketplace_order", orderId },
          android: androidMp, apns: apnsMp,
        }, `Payment released notification to seller ${after.sellerId}`);
      }
    }

    // failed → notify buyer (H13: missing trigger)
    if (after.status === "failed" && before.status !== "failed") {
      const fcmToken = await getFcmToken(after.buyerId);
      if (fcmToken) {
        await sendFcm({
          token: fcmToken,
          notification: {
            title: "Order failed",
            body: `Your order for "${after.listingTitle}" could not be processed. Your tokens have been refunded.`,
          },
          data: { type: "marketplace_order", orderId, screen: "buy_order_detail" },
          android: androidMp, apns: apnsMp,
        }, `Order failed notification to buyer ${after.buyerId}`);
      }
    }

    // disputed → notify both parties
    if (after.status === "disputed" && before.status !== "disputed") {
      const [buyerToken, sellerToken] = await Promise.all([
        getFcmToken(after.buyerId),
        getFcmToken(after.sellerId),
      ]);

      for (const [token, label] of [[buyerToken, "buyer"], [sellerToken, "seller"]] as const) {
        if (token) {
          await sendFcm({
            token,
            notification: {
              title: "Dispute raised",
              body: `A dispute has been raised on order "${after.listingTitle}"`,
            },
            data: { type: "marketplace_dispute", orderId },
            android: androidMp, apns: apnsMp,
          }, `Dispute notification to ${label}`);
        }
      }
    }

    // cancelled/refunded → notify both parties
    if ((after.status === "cancelled" || after.status === "refunded") &&
        before.status !== "cancelled" && before.status !== "refunded") {
      const [buyerToken, sellerToken] = await Promise.all([
        getFcmToken(after.buyerId),
        getFcmToken(after.sellerId),
      ]);

      if (buyerToken) {
        await sendFcm({
          token: buyerToken,
          notification: {
            title: after.status === "refunded" ? "Refund processed" : "Order cancelled",
            body: after.status === "refunded"
              ? `Your ${after.amount} tokens for "${after.listingTitle}" have been refunded`
              : `Your order for "${after.listingTitle}" has been cancelled. Tokens refunded.`,
          },
          data: { type: "marketplace_order", orderId, screen: "buy_order_detail" },
          android: androidMp, apns: apnsMp,
        }, `Refund notification to buyer ${after.buyerId}`);
      }

      if (sellerToken) {
        await sendFcm({
          token: sellerToken,
          notification: {
            title: "Order cancelled",
            body: `Order for "${after.listingTitle}" has been cancelled`,
          },
          data: { type: "marketplace_order", orderId, screen: "seller_orders" },
          android: androidMp, apns: apnsMp,
        }, `Cancellation notification to seller ${after.sellerId}`);
      }
    }

    // resolved (dispute resolved) → notify both parties
    if (after.status === "resolved" && before.status !== "resolved") {
      const [buyerToken, sellerToken] = await Promise.all([
        getFcmToken(after.buyerId),
        getFcmToken(after.sellerId),
      ]);

      const resolution = after.disputeResolution || "resolved";
      const resolutionText = resolution === "partial_refund"
        ? `Partial refund of ${after.disputeResolutionAmount || 0} tokens`
        : resolution === "full_refund" ? "Full refund issued"
        : resolution === "return_required" ? "Return required — check order details"
        : "Dispute has been resolved";

      for (const [token, label] of [[buyerToken, "buyer"], [sellerToken, "seller"]] as const) {
        if (token) {
          await sendFcm({
            token,
            notification: {
              title: "Dispute resolved",
              body: `"${after.listingTitle}": ${resolutionText}`,
            },
            data: { type: "marketplace_dispute_resolved", orderId, screen: "buy_order_detail" },
            android: androidMp, apns: apnsMp,
          }, `Dispute resolved notification to ${label}`);
        }
      }
    }
  }
);

// ============================================================================
// OFFER NOTIFICATIONS
// ============================================================================

/**
 * Trigger: Marketplace offer created → notify seller
 */
export const onMarketplaceOfferCreated = onDocumentCreated(
  { document: "marketplaceOffers/{offerId}", retry: true, labels: { area: "marketplace" } },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const offer = snap.data();
    if (!offer.sellerId) return;

    const fcmToken = await getFcmToken(offer.sellerId);
    if (!fcmToken) return;

    await sendFcm({
      token: fcmToken,
      notification: {
        title: "New offer received!",
        body: `${offer.buyerName || "A buyer"} offered ${offer.offerAmount} tokens for "${offer.listingTitle}"`,
      },
      data: {
        type: "marketplace_offer",
        offerId: snap.id,
        listingId: offer.listingId || "",
        screen: "seller_offers",
      },
      android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
      apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
    }, `Offer notification to seller ${offer.sellerId}`);
  }
);

/**
 * Trigger: Offer status changed → notify buyer
 */
export const onMarketplaceOfferUpdated = onDocumentUpdated(
  { document: "marketplaceOffers/{offerId}", retry: true, labels: { area: "marketplace" } },
  async (event) => {
    if (!event.data) return;

    const before = event.data.before.data();
    const after = event.data.after.data();

    if (before.status === after.status) return;

    const offerId = event.data.after.id;

    // Notify buyer about offer response
    const buyerToken = await getFcmToken(after.buyerId);
    if (!buyerToken) return;

    let title = "";
    let body = "";

    switch (after.status) {
      case "accepted":
        title = "Offer accepted!";
        body = `Your offer of ${after.offerAmount} tokens for "${after.listingTitle}" was accepted`;
        break;
      case "declined":
        title = "Offer declined";
        body = `Your offer for "${after.listingTitle}" was declined`;
        break;
      case "countered":
        title = "Counter offer received";
        body = `Seller countered with ${after.counterAmount} tokens for "${after.listingTitle}"`;
        break;
      case "expired":
        title = "Offer expired";
        body = `Your offer for "${after.listingTitle}" has expired`;
        break;
      default:
        return;
    }

    await sendFcm({
      token: buyerToken,
      notification: { title, body },
      data: {
        type: "marketplace_offer_response",
        offerId,
        listingId: after.listingId || "",
        screen: "marketplace_listing_detail",
      },
      android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
      apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
    }, `Offer response notification to buyer ${after.buyerId}`);
  }
);

// ============================================================================
// LISTING NOTIFICATIONS
// ============================================================================

/**
 * Trigger: Listing status changed → notify provider
 */
export const onListingStatusChanged = onDocumentUpdated(
  { document: "marketplaceListings/{listingId}", retry: true, labels: { area: "marketplace" } },
  async (event) => {
    if (!event.data) return;

    const before = event.data.before.data();
    const after = event.data.after.data();
    const listingId = event.data.after.id;

    if (before.status === after.status) return;

    // Get provider's user ID
    const providerDoc = await db.collection("providers").doc(after.providerId).get();
    if (!providerDoc.exists) return;

    const fcmToken = await getFcmToken(providerDoc.data()!.userId);
    if (!fcmToken) return;

    let title = "";
    let body = "";

    if (after.status === "flagged") {
      title = "Listing flagged";
      body = `Your listing "${after.title}" has been flagged for review`;
    } else if (after.status === "removed") {
      title = "Listing removed";
      body = `Your listing "${after.title}" has been removed by a moderator`;
    } else if (after.status === "expired") {
      title = "Listing expired";
      body = `Your listing "${after.title}" has expired. Renew it to keep selling!`;
    } else if (after.status === "paused") {
      title = "Listing paused";
      body = `Your listing "${after.title}" has been paused by an admin`;
    } else {
      return; // Don't notify for other status changes
    }

    await sendFcm({
      token: fcmToken,
      notification: { title, body },
      data: {
        type: "listing_status",
        listingId,
        screen: "my_listings",
      },
      android: { priority: "high", notification: { channelId: "marketplace", sound: "default" } },
      apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
    }, `Listing status notification for ${listingId}`);
  }
);

// ============================================================================
// PURCHASE NOTIFICATIONS
// ============================================================================

/**
 * Trigger: VAS Purchase status changes → notify buyer
 */
export const onPurchaseStatusChanged = onDocumentUpdated(
  { document: "purchases/{purchaseId}", retry: true, labels: { area: "buy" } },
  async (event) => {
    if (!event.data) return;

    const before = event.data.before.data();
    const after = event.data.after.data();
    const purchaseId = event.data.after.id;

    if (before.status === after.status) return;

    const fcmToken = await getFcmToken(after.userId);
    if (!fcmToken) return;

    let title = "";
    let body = "";

    if (after.status === "completed") {
      title = "Purchase successful";
      body = `Your ${after.productName || "purchase"} for ${after.recipientNumber || ""} is ready. Ref: #PUR-${purchaseId.substring(0, 8)}`;
    } else if (after.status === "failed") {
      title = "Purchase failed";
      body = `Your ${after.productName || "purchase"} failed. Your ${after.tokenAmount || 0} tokens have been refunded.`;
    } else if (after.status === "processing" && before.status === "pending") {
      // Don't send notification for processing — too noisy
      return;
    } else {
      return;
    }

    await sendFcm({
      token: fcmToken,
      notification: { title, body },
      data: {
        type: "purchase_status",
        purchaseId,
        screen: "buy_purchase_history",
      },
      android: { priority: "high", notification: { channelId: "buy", sound: "default" } },
      apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
    }, `Purchase notification for ${purchaseId}`);
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

    const providerId = event.data.after.id;
    const androidMp = { priority: "high" as const, notification: { channelId: "marketplace", sound: "default" } };
    const apnsMp = { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } };

    // Approved
    if (after.status === "approved" && before.status === "pending") {
      await sendFcm({
        token: fcmToken,
        notification: {
          title: "You're approved to sell!",
          body: "Your marketplace seller registration has been approved. Start listing your products!",
        },
        data: { type: "provider_status", providerId },
        android: androidMp, apns: apnsMp,
      }, `Provider approved notification to ${after.userId}`);
    }

    // Rejected
    if (after.status === "rejected" && before.status === "pending") {
      await sendFcm({
        token: fcmToken,
        notification: {
          title: "Registration not approved",
          body: "Your marketplace seller registration was not approved. Please contact support for details.",
        },
        data: { type: "provider_status", providerId },
        android: androidMp, apns: apnsMp,
      }, `Provider rejected notification to ${after.userId}`);
    }

    // Suspended
    if (after.status === "suspended") {
      await sendFcm({
        token: fcmToken,
        notification: {
          title: "Account suspended",
          body: "Your marketplace seller account has been suspended. Please contact support.",
        },
        data: { type: "provider_status", providerId },
        android: androidMp, apns: apnsMp,
      }, `Provider suspended notification to ${after.userId}`);
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

    await sendFcm({
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
    }, `Group buy notification to ${userId}`);
  });

  await Promise.allSettled(sendPromises);
}

/**
 * Trigger: New contribution → notify organizer
 */
export const onGroupBuyContributionCreated = onDocumentCreated(
  { document: "groupBuys/{groupBuyId}/contributions/{contribId}", retry: true, labels: { area: "group_buy" } },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const contrib = snap.data();
    const groupBuyId = event.params.groupBuyId;

    // Get group buy to find organizer
    const groupBuyDoc = await db.collection("groupBuys").doc(groupBuyId).get();
    if (!groupBuyDoc.exists) return;

    const groupBuy = groupBuyDoc.data()!;

    // Don't notify organizer about their own contribution
    if (contrib.userId === groupBuy.organizerId) return;

    const fcmToken = await getFcmToken(groupBuy.organizerId);
    if (!fcmToken) return;

    await sendFcm({
      token: fcmToken,
      notification: {
        title: "Someone joined your group buy!",
        body: `${contrib.userName || "A user"} contributed ${contrib.amount} tokens to "${groupBuy.title}"`,
      },
      data: {
        type: "group_buy_join",
        groupBuyId,
        screen: "group_buy_detail",
      },
      android: { priority: "high", notification: { channelId: "group_buy", sound: "default" } },
      apns: { headers: { "apns-priority": "10" }, payload: { aps: { sound: "default", badge: 1 } } },
    }, `Join notification to organizer ${groupBuy.organizerId}`);
  }
);

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
