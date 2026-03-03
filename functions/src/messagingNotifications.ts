/**
 * Messaging Notifications
 *
 * Firestore triggers that send FCM push notifications for new messages
 * in conversations (P2P) and communities.
 */

import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

/**
 * HIGH-10: Get a user's FCM tokens from their trusted devices subcollection.
 * Tokens live at users/{userId}/devices/{deviceId}.fcmToken, NOT on the
 * user profile document.
 */
async function getFcmToken(userId: string): Promise<string | null> {
  const devices = await db
    .collection("users")
    .doc(userId)
    .collection("devices")
    .where("trusted", "==", true)
    .where("revoked", "==", false)
    .limit(1)
    .get();
  if (devices.empty) return null;
  return devices.docs[0].data()?.fcmToken || null;
}

/**
 * HIGH-10: Get multiple users' FCM tokens from trusted devices.
 * Returns a map of token → { userId, deviceId } for stale token cleanup.
 */
interface TokenInfo {
  token: string;
  userId: string;
  deviceId: string;
}

async function getFcmTokensWithInfo(userIds: string[]): Promise<TokenInfo[]> {
  if (userIds.length === 0) return [];

  const tokenInfos: TokenInfo[] = [];
  for (const userId of userIds) {
    try {
      const devices = await db
        .collection("users")
        .doc(userId)
        .collection("devices")
        .where("trusted", "==", true)
        .where("revoked", "==", false)
        .get();

      for (const doc of devices.docs) {
        const token = doc.data()?.fcmToken;
        if (token) {
          tokenInfos.push({ token, userId, deviceId: doc.id });
        }
      }
    } catch (e) {
      logger.warn(`Failed to get FCM tokens for user ${userId}:`, e);
    }
  }
  return tokenInfos;
}

/**
 * M19: Clean up stale/invalid FCM tokens after a failed send.
 * Removes the fcmToken field from the device document so it won't be
 * retried on future notifications.
 */
async function cleanupStaleTokens(
  tokenInfos: TokenInfo[],
  responses: admin.messaging.SendResponse[]
): Promise<void> {
  const staleErrors = new Set([
    "messaging/invalid-registration-token",
    "messaging/registration-token-not-registered",
  ]);

  for (let i = 0; i < responses.length; i++) {
    const resp = responses[i];
    if (!resp.success && resp.error && staleErrors.has(resp.error.code)) {
      const info = tokenInfos[i];
      if (!info) continue;
      try {
        await db
          .collection("users")
          .doc(info.userId)
          .collection("devices")
          .doc(info.deviceId)
          .update({ fcmToken: admin.firestore.FieldValue.delete() });
        logger.info(
          `Cleaned up stale FCM token for user ${info.userId}, device ${info.deviceId}`
        );
      } catch (e) {
        logger.warn(`Failed to clean stale token for ${info.userId}:`, e);
      }
    }
  }
}

/** Build a human-readable preview string from a message document. */
function getMessagePreview(data: FirebaseFirestore.DocumentData): string {
  // E2EE messages: never leak plaintext in push notifications
  if (data.ciphertext || data.e2ee) {
    return getE2EENotificationBody(data.type || "text");
  }

  const type = data.type || "text";
  const tokenAmount = data.tokenAmount;
  const textContent = data.textContent;

  switch (type) {
  case "tokenSend":
    return `Sent ${tokenAmount} tokens`;
  case "tokenRequest":
    return `Requested ${tokenAmount} tokens`;
  case "image":
    return textContent ? `📷 ${textContent}` : "Sent a photo";
  case "voice":
    return "Sent a voice message";
  case "gift":
    return `Sent you a gift of ${tokenAmount || ""} tokens`;
  case "tokenSpray":
    return "Started a token spray!";
  case "system":
    return textContent || "System message";
  default:
    return textContent || "New message";
  }
}

/** Generic notification body for encrypted messages — no plaintext leakage. */
function getE2EENotificationBody(type: string): string {
  switch (type) {
  case "image":
    return "Sent a photo";
  case "voice":
    return "Sent a voice message";
  case "gift":
    return "Sent you a gift";
  case "tokenSpray":
    return "Started a token spray!";
  case "tokenSend":
    return "Sent you tokens";
  case "tokenRequest":
    return "Requested tokens";
  default:
    return "New message";
  }
}

// ============================================================================
// CONVERSATION MESSAGE NOTIFICATION (P2P)
// ============================================================================

/**
 * Trigger: new message written to conversations/{convId}/messages/{msgId}
 *
 * Sends a push notification to the OTHER participant in the P2P conversation,
 * unless they have muted the conversation.
 */
export const onConversationMessageCreated = onDocumentCreated(
  { document: "conversations/{convId}/messages/{msgId}", labels: { area: "notifications" } },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const message = snap.data();
    const conversationId = event.params.convId;

    // System messages don't trigger notifications
    if (message.type === "system") return;

    // Get conversation document
    const convDoc = await db.collection("conversations").doc(conversationId).get();
    if (!convDoc.exists) {
      logger.warn(`Conversation ${conversationId} not found for notification`);
      return;
    }

    const conv = convDoc.data()!;
    const participantIds: string[] = conv.participantIds || [];

    // Find recipient (the OTHER participant)
    const recipientId = participantIds.find((id: string) => id !== message.senderId);
    if (!recipientId) return;

    // Check if recipient has muted this conversation
    if (conv.muted?.[recipientId] === true) return;

    // Get recipient's FCM token
    const fcmToken = await getFcmToken(recipientId);
    if (!fcmToken) return;

    const senderName = message.senderName || "Someone";
    const body = getMessagePreview(message);

    try {
      await admin.messaging().send({
        token: fcmToken,
        notification: {
          title: senderName,
          body,
        },
        data: {
          type: "new_message",
          conversationId,
          senderId: message.senderId || "",
          messageType: message.type || "text",
        },
        android: {
          priority: "high",
          notification: {
            channelId: "chat_messages",
            sound: "default",
          },
        },
        apns: {
          headers: { "apns-priority": "10" },
          payload: {
            aps: {
              sound: "default",
              badge: 1,
            },
          },
        },
      });
    } catch (error) {
      // Non-fatal — log and move on
      logger.warn(`Failed to send conversation notification to ${recipientId}:`, error);
    }
  }
);

// ============================================================================
// COMMUNITY MESSAGE NOTIFICATION
// ============================================================================

/**
 * Trigger: new message written to communities/{commId}/messages/{msgId}
 *
 * Sends a push notification to ALL members except the sender,
 * respecting individual mute preferences.
 */
export const onCommunityMessageCreated = onDocumentCreated(
  { document: "communities/{commId}/messages/{msgId}", labels: { area: "notifications" } },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const message = snap.data();
    const communityId = event.params.commId;

    // System messages don't trigger push notifications
    if (message.type === "system") return;

    // Get community document
    const commDoc = await db.collection("communities").doc(communityId).get();
    if (!commDoc.exists) {
      logger.warn(`Community ${communityId} not found for notification`);
      return;
    }

    const community = commDoc.data()!;
    const memberIds: string[] = community.memberIds || [];
    const mutedMap: Record<string, boolean> = community.muted || {};

    // Filter: exclude sender + muted members
    const recipientIds = memberIds.filter(
      (id: string) => id !== message.senderId && !mutedMap[id]
    );

    if (recipientIds.length === 0) return;

    // HIGH-10: Get FCM tokens from trusted devices subcollection
    const tokenInfos = await getFcmTokensWithInfo(recipientIds);
    if (tokenInfos.length === 0) return;

    const senderName = message.senderName || "Someone";
    const communityName = community.name || "Community";
    const body = `${senderName}: ${getMessagePreview(message)}`;

    // Send in batches of 500 (FCM multicast limit)
    for (let i = 0; i < tokenInfos.length; i += 500) {
      const batchInfos = tokenInfos.slice(i, i + 500);
      const batchTokens = batchInfos.map((t) => t.token);

      try {
        const response = await admin.messaging().sendEachForMulticast({
          tokens: batchTokens,
          notification: {
            title: communityName,
            body,
          },
          data: {
            type: "new_community_message",
            communityId,
            messageId: event.params.msgId,
            senderId: message.senderId || "",
            messageType: message.type || "text",
          },
          android: {
            priority: "high",
            notification: {
              channelId: "community_messages",
              sound: "default",
            },
          },
          apns: {
            headers: { "apns-priority": "10" },
            payload: {
              aps: {
                sound: "default",
                badge: 1,
              },
            },
          },
        });
        // M19: Clean up stale/invalid FCM tokens
        if (response.failureCount > 0) {
          await cleanupStaleTokens(batchInfos, response.responses);
        }
      } catch (error) {
        logger.warn(`Failed to send community notification batch for ${communityId}:`, error);
      }
    }
  }
);
