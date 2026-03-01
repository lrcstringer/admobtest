/**
 * Token Pool Notification Triggers
 *
 * Firestore triggers for token pool status transitions.
 * Most FCM notifications are sent inline by callable functions in tokenPools.ts.
 * These triggers serve as:
 *  1. Status transition logging / audit trail
 *  2. Backup notifications for scheduled jobs (expiry) that don't have a caller
 *  3. Real-time status change propagation (e.g., updating groupGift message embeds)
 */

import { onDocumentUpdated } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";

const db = admin.firestore();

/** Get a user's FCM token from their profile document. */
async function getFcmToken(userId: string): Promise<string | null> {
  const doc = await db.collection("users").doc(userId).get();
  return doc.data()?.fcmToken || null;
}

/** Get FCM tokens for multiple users. */
async function getFcmTokens(userIds: string[]): Promise<string[]> {
  if (userIds.length === 0) return [];
  const tokens: string[] = [];
  for (let i = 0; i < userIds.length; i += 30) {
    const batch = userIds.slice(i, i + 30);
    const refs = batch.map((id) => db.collection("users").doc(id));
    const docs = await db.getAll(...refs);
    for (const doc of docs) {
      const token = doc.data()?.fcmToken;
      if (token) tokens.push(token);
    }
  }
  return tokens;
}

/** Send a single FCM push notification. */
async function sendFcm(
  token: string,
  title: string,
  body: string,
  data: Record<string, string>
): Promise<void> {
  try {
    await admin.messaging().send({
      token,
      notification: { title, body },
      data: { ...data, type: data.type || "pool_notification" },
      android: {
        priority: "high",
        notification: { channelId: "pools" },
      },
      apns: {
        headers: { "apns-priority": "10" },
        payload: { aps: { sound: "default", badge: 1 } },
      },
    });
  } catch (e) {
    logger.warn("FCM send failed:", e);
  }
}

// ============================================================================
// ON TOKEN POOL UPDATED — status transition handler
// ============================================================================

/**
 * Firestore trigger: tokenPools/{poolId} updated
 *
 * Handles:
 * - Status transition logging for audit
 * - Backup FCM for expiry transitions (scheduled job sets status but
 *   doesn't send per-user FCM to all participants)
 */
export const onTokenPoolUpdated = onDocumentUpdated(
  { document: "tokenPools/{poolId}", retry: true, labels: { area: "pools" } },
  async (event) => {
    if (!event.data) return;

    const before = event.data.before.data();
    const after = event.data.after.data();
    const poolId = event.params.poolId;

    // Only react to status changes
    if (before.status === after.status) return;

    const transition = `${before.status} → ${after.status}`;
    logger.info(`Token pool ${poolId} status: ${transition}`);

    // --- Expiry notifications (scheduled job sets status but we send FCM here) ---

    if (after.status === "expired" && before.status === "collecting") {
      // Collection expired — notify all participants about refund
      const allIds = [after.organizerId, ...(after.inviteeIds || [])];
      const uniqueIds = [...new Set(allIds)];
      const tokens = await getFcmTokens(uniqueIds);

      const refundMsg = after.totalAmount > 0
        ? ` ${after.totalAmount} tokens refunded.`
        : "";

      for (const token of tokens) {
        await sendFcm(
          token,
          "Collection expired",
          `"${after.title}" has expired.${refundMsg}`,
          { type: "pool_expired", poolId, conversationId: after.conversationId || "" }
        );
      }
    }

    if (after.status === "expired" && before.status === "sent") {
      // Gift claim window expired — notify organizer + contributors
      const contributorIds = Object.keys(after.contributions || {});
      if (!contributorIds.includes(after.organizerId)) {
        contributorIds.push(after.organizerId);
      }
      const tokens = await getFcmTokens(contributorIds);

      for (const token of tokens) {
        await sendFcm(
          token,
          "Group Sasaza expired",
          `${after.recipientName} did not claim the gift. Tokens were already transferred.`,
          { type: "pool_expired", poolId, conversationId: after.conversationId || "" }
        );
      }

      // Also notify recipient
      const recipientToken = await getFcmToken(after.recipientId);
      if (recipientToken) {
        await sendFcm(
          recipientToken,
          "Group Sasaza expired",
          `Your Group Sasaza from ${after.organizerName} has expired. Tokens are in your balance.`,
          { type: "pool_expired", poolId }
        );
      }
    }
  }
);
