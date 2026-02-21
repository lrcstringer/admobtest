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

/** Get a user's FCM token from their profile document. */
async function getFcmToken(userId: string): Promise<string | null> {
  const doc = await db.collection("users").doc(userId).get();
  return doc.data()?.fcmToken || null;
}

/** Get multiple users' FCM tokens. Returns only valid tokens. */
async function getFcmTokens(userIds: string[]): Promise<string[]> {
  if (userIds.length === 0) return [];

  // Read in batches of 30 (Firestore getAll limit per call)
  const tokens: string[] = [];
  for (let i = 0; i < userIds.length; i += 30) {
    const batch = userIds.slice(i, i + 30);
    const refs = batch.map((uid) => db.collection("users").doc(uid));
    const docs = await db.getAll(...refs);

    for (const doc of docs) {
      const token = doc.data()?.fcmToken;
      if (token) tokens.push(token);
    }
  }
  return tokens;
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

    // Get FCM tokens for all recipients
    const tokens = await getFcmTokens(recipientIds);
    if (tokens.length === 0) return;

    const senderName = message.senderName || "Someone";
    const communityName = community.name || "Community";
    const body = `${senderName}: ${getMessagePreview(message)}`;

    // Send in batches of 500 (FCM multicast limit)
    for (let i = 0; i < tokens.length; i += 500) {
      const batch = tokens.slice(i, i + 500);

      try {
        await admin.messaging().sendEachForMulticast({
          tokens: batch,
          notification: {
            title: communityName,
            body,
          },
          data: {
            type: "new_community_message",
            communityId,
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
      } catch (error) {
        logger.warn(`Failed to send community notification batch for ${communityId}:`, error);
      }
    }
  }
);
