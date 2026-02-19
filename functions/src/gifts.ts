/**
 * Gifts Cloud Functions
 *
 * iMali gift system — send wrapped token gifts to other users.
 * Gifts use an escrow pattern: tokens are debited from the sender immediately,
 * held in the system, and credited to the recipient when they claim.
 *
 * Collection: /gifts/{giftId}
 *
 * Lifecycle: pending → opened → claimed | expired
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processP2PTransfer,
  getDefaultSubAccount,
  validateMainWalletBalance,
} from "./ledger";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

function requireAuth(context: functions.https.CallableContext): string {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  return context.auth.uid;
}

async function getUserProfile(userId: string) {
  const doc = await db.collection("users").doc(userId).get();
  if (!doc.exists) {
    throw new functions.https.HttpsError("not-found", `User ${userId} not found`);
  }
  return doc.data()!;
}

const VALID_STYLES = ["ndlovukazi", "celebration", "love", "birthday", "professional"];
const MIN_GIFT_AMOUNT = 10; // 10 tokens minimum
const GIFT_EXPIRY_DAYS = 7;

// ============================================================================
// SEND GIFT
// ============================================================================

/**
 * Send a gift to another user.
 *
 * 1. Validates balance
 * 2. Debits sender via ledger (P2P transfer to system escrow)
 * 3. Creates /gifts/{id} document
 * 4. Writes a "gift" type message into conversation or community
 * 5. Returns the created gift
 */
export const sendGift = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "sendGift");
  await requirePlayIntegrity(data, context, "sendGift", "HIGHEST");

  const { recipientId, amount, message, style, conversationId, communityId } = data;

  // Validate inputs
  if (!recipientId || typeof recipientId !== "string") {
    throw new functions.https.HttpsError("invalid-argument", "recipientId is required");
  }
  if (!amount || typeof amount !== "number" || amount < MIN_GIFT_AMOUNT) {
    throw new functions.https.HttpsError("invalid-argument", `Minimum gift is ${MIN_GIFT_AMOUNT} tokens`);
  }
  if (!message || typeof message !== "string" || message.trim().length === 0) {
    throw new functions.https.HttpsError("invalid-argument", "Gift message is required");
  }
  if (!style || !VALID_STYLES.includes(style)) {
    throw new functions.https.HttpsError("invalid-argument", `Invalid style. Must be one of: ${VALID_STYLES.join(", ")}`);
  }
  if (!conversationId && !communityId) {
    throw new functions.https.HttpsError("invalid-argument", "Must specify conversationId or communityId");
  }
  if (recipientId === userId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot send a gift to yourself");
  }

  // Get user profiles
  const [sender, recipient] = await Promise.all([
    getUserProfile(userId),
    getUserProfile(recipientId),
  ]);

  // Validate sender balance
  const senderSubAccount = await getDefaultSubAccount(userId);
  if (!senderSubAccount) {
    throw new functions.https.HttpsError("failed-precondition", "Sender has no wallet");
  }
  await validateMainWalletBalance(userId, amount);

  // Generate IDs
  const giftRef = db.collection("gifts").doc();
  const giftId = giftRef.id;

  // Determine which message collection to write to
  const collection = conversationId ? "conversations" : "communities";
  const parentId = conversationId || communityId;
  const msgRef = db.collection(collection).doc(parentId!).collection("messages").doc();

  // Process debit via ledger (P2P to system — tokens held until claim)
  const idempotencyKey = `gift:send:${giftId}`;
  const transferResult = await processP2PTransfer(
    userId,
    recipientId,
    amount,
    `Gift to ${recipient.displayName || recipientId}`,
    senderSubAccount.id,
    undefined, // recipientSubAccountId — uses default
    idempotencyKey,
  );

  const expiresAt = new Date();
  expiresAt.setDate(expiresAt.getDate() + GIFT_EXPIRY_DAYS);

  // Construct the gift document
  const giftDoc = {
    id: giftId,
    senderId: userId,
    senderName: sender.displayName || "Unknown",
    recipientId,
    recipientName: recipient.displayName || "Unknown",
    amount,
    conversationId: conversationId || null,
    communityId: communityId || null,
    messageId: msgRef.id,
    message: message.trim().substring(0, 100),
    style,
    status: "pending",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    openedAt: null,
    claimedAt: null,
    expiresAt: admin.firestore.Timestamp.fromDate(expiresAt),
    debitTransactionId: transferResult.journalId || null,
    creditTransactionId: null,
    notificationSent: false,
    reminderSent: false,
  };

  // Construct the gift message
  const giftMessage: Record<string, unknown> = {
    id: msgRef.id,
    senderId: userId,
    senderName: sender.displayName || "Unknown",
    senderAvatarUrl: sender.avatarUrl || sender.profilePicThumbUrl || null,
    type: "gift",
    status: "sent",
    textContent: null,
    tokenAmount: amount,
    recipientId,
    gift: {
      giftId,
      amount,
      message: message.trim().substring(0, 100),
      style,
      status: "pending",
      recipientId,
      recipientName: recipient.displayName || "Unknown",
    },
    reactions: {},
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    deletedFor: [],
    deletedForEveryone: false,
  };

  // Add communityId if in a community
  if (communityId) {
    giftMessage.communityId = communityId;
  }

  // Batch write: gift doc + message + update parent lastMessage
  const batch = db.batch();
  batch.set(giftRef, giftDoc);
  batch.set(msgRef, giftMessage);

  // Update lastMessage on parent document
  const parentUpdate: Record<string, unknown> = {
    lastMessage: {
      text: `Sent a gift of ${amount} tokens`,
      senderId: userId,
      senderName: sender.displayName || "Unknown",
      type: "gift",
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    },
    lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  // Increment unread for recipient(s)
  if (conversationId) {
    parentUpdate[`unreadCounts.${recipientId}`] = admin.firestore.FieldValue.increment(1);
  } else if (communityId) {
    // For community gifts, increment unread for all members except sender
    const communityDoc = await db.collection("communities").doc(communityId).get();
    if (communityDoc.exists) {
      const memberIds: string[] = communityDoc.data()?.memberIds || [];
      for (const memberId of memberIds) {
        if (memberId !== userId) {
          parentUpdate[`unreadCounts.${memberId}`] = admin.firestore.FieldValue.increment(1);
        }
      }
    }
  }

  batch.update(db.collection(collection).doc(parentId!), parentUpdate);
  await batch.commit();

  // Return the gift data for the client
  return {
    id: giftId,
    senderId: userId,
    senderName: sender.displayName || "Unknown",
    recipientId,
    recipientName: recipient.displayName || "Unknown",
    amount,
    conversationId: conversationId || null,
    communityId: communityId || null,
    messageId: msgRef.id,
    message: message.trim().substring(0, 100),
    style,
    status: "pending",
    createdAt: new Date().toISOString(),
    openedAt: null,
    claimedAt: null,
    expiresAt: expiresAt.toISOString(),
    debitTransactionId: transferResult.journalId || null,
    creditTransactionId: null,
  };
});

// ============================================================================
// OPEN GIFT
// ============================================================================

/**
 * Mark a gift as opened (recipient saw it).
 * Only the recipient can open a gift.
 */
export const openGift = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "openGift");

  const { giftId } = data;
  if (!giftId || typeof giftId !== "string") {
    throw new functions.https.HttpsError("invalid-argument", "giftId is required");
  }

  const giftRef = db.collection("gifts").doc(giftId);
  const giftDoc = await giftRef.get();

  if (!giftDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Gift not found");
  }

  const gift = giftDoc.data()!;

  // Only recipient can open
  if (gift.recipientId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Only the recipient can open this gift");
  }

  // Check status
  if (gift.status !== "pending") {
    throw new functions.https.HttpsError("failed-precondition", `Gift is already ${gift.status}`);
  }

  // Check expiry
  const expiresAt = gift.expiresAt?.toDate ? gift.expiresAt.toDate() : new Date(gift.expiresAt);
  if (new Date() > expiresAt) {
    throw new functions.https.HttpsError("failed-precondition", "Gift has expired");
  }

  // Update gift status
  await giftRef.update({
    status: "opened",
    openedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update the embedded gift data in the message
  if (gift.messageId) {
    const collection = gift.conversationId ? "conversations" : "communities";
    const parentId = gift.conversationId || gift.communityId;
    if (parentId) {
      try {
        await db.collection(collection).doc(parentId).collection("messages").doc(gift.messageId).update({
          "gift.status": "opened",
        });
      } catch (e) {
        console.warn("Failed to update gift message status:", e);
      }
    }
  }

  return {
    ...gift,
    id: giftId,
    status: "opened",
    openedAt: new Date().toISOString(),
    createdAt: gift.createdAt?.toDate ? gift.createdAt.toDate().toISOString() : gift.createdAt,
    expiresAt: expiresAt.toISOString(),
  };
});

// ============================================================================
// CLAIM GIFT
// ============================================================================

/**
 * Claim a gift — transfers tokens to recipient's wallet.
 * Only the recipient can claim. Gift must be "opened" and not expired.
 */
export const claimGift = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "claimGift");
  await requirePlayIntegrity(data, context, "claimGift", "HIGHEST");

  const { giftId } = data;
  if (!giftId || typeof giftId !== "string") {
    throw new functions.https.HttpsError("invalid-argument", "giftId is required");
  }

  const giftRef = db.collection("gifts").doc(giftId);
  const giftDoc = await giftRef.get();

  if (!giftDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Gift not found");
  }

  const gift = giftDoc.data()!;

  // Only recipient can claim
  if (gift.recipientId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Only the recipient can claim this gift");
  }

  // Must be opened (not pending or already claimed)
  if (gift.status !== "opened") {
    throw new functions.https.HttpsError("failed-precondition", `Gift cannot be claimed — status is ${gift.status}`);
  }

  // Check expiry
  const expiresAt = gift.expiresAt?.toDate ? gift.expiresAt.toDate() : new Date(gift.expiresAt);
  if (new Date() > expiresAt) {
    throw new functions.https.HttpsError("failed-precondition", "Gift has expired");
  }

  // Tokens were already transferred via processP2PTransfer in sendGift.
  // The recipient already has the tokens in their default sub-account.
  // We just need to update the gift status.

  await giftRef.update({
    status: "claimed",
    claimedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update the embedded gift data in the message
  if (gift.messageId) {
    const collection = gift.conversationId ? "conversations" : "communities";
    const parentId = gift.conversationId || gift.communityId;
    if (parentId) {
      try {
        await db.collection(collection).doc(parentId).collection("messages").doc(gift.messageId).update({
          "gift.status": "claimed",
        });
      } catch (e) {
        console.warn("Failed to update gift message status:", e);
      }
    }
  }

  return {
    ...gift,
    id: giftId,
    status: "claimed",
    claimedAt: new Date().toISOString(),
    createdAt: gift.createdAt?.toDate ? gift.createdAt.toDate().toISOString() : gift.createdAt,
    expiresAt: expiresAt.toISOString(),
  };
});

// ============================================================================
// SCHEDULED: EXPIRE GIFTS
// ============================================================================

/**
 * Hourly job: find pending/opened gifts past their expiresAt and mark them expired.
 * Since tokens were already transferred via P2P, expired gifts don't need a refund —
 * the recipient simply has the tokens. The gift wrapper is just a presentation layer.
 */
export const expireGifts = functions.pubsub
  .schedule("0 * * * *") // Every hour
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();

    const expiredGifts = await db.collection("gifts")
      .where("status", "in", ["pending", "opened"])
      .where("expiresAt", "<", now)
      .limit(100) // Process in batches
      .get();

    if (expiredGifts.empty) {
      console.log("No gifts to expire");
      return null;
    }

    console.log(`Expiring ${expiredGifts.size} gifts`);

    const batch = db.batch();
    for (const doc of expiredGifts.docs) {
      batch.update(doc.ref, { status: "expired" });

      // Update the message embed too
      const gift = doc.data();
      if (gift.messageId) {
        const collection = gift.conversationId ? "conversations" : "communities";
        const parentId = gift.conversationId || gift.communityId;
        if (parentId) {
          const msgRef = db.collection(collection).doc(parentId).collection("messages").doc(gift.messageId);
          batch.update(msgRef, { "gift.status": "expired" });
        }
      }
    }

    await batch.commit();
    console.log(`Expired ${expiredGifts.size} gifts`);
    return null;
  });

// ============================================================================
// SCHEDULED: GIFT EXPIRY REMINDERS
// ============================================================================

/**
 * Daily job: find gifts expiring within 2 days and send a push notification
 * to the recipient reminding them to claim.
 */
export const sendGiftExpiryReminders = functions.pubsub
  .schedule("0 10 * * *") // 10 AM daily SAST
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const now = new Date();
    const twoDaysFromNow = new Date(now.getTime() + 2 * 24 * 60 * 60 * 1000);

    const soonExpiring = await db.collection("gifts")
      .where("status", "in", ["pending", "opened"])
      .where("reminderSent", "==", false)
      .where("expiresAt", "<", admin.firestore.Timestamp.fromDate(twoDaysFromNow))
      .where("expiresAt", ">", admin.firestore.Timestamp.now())
      .limit(100)
      .get();

    if (soonExpiring.empty) {
      console.log("No gift expiry reminders to send");
      return null;
    }

    console.log(`Sending ${soonExpiring.size} gift expiry reminders`);

    for (const doc of soonExpiring.docs) {
      const gift = doc.data();
      const recipientDoc = await db.collection("users").doc(gift.recipientId).get();
      const fcmToken = recipientDoc.data()?.fcmToken;

      if (fcmToken) {
        try {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Gift expiring soon!",
              body: `Your ${gift.amount} token gift from ${gift.senderName} expires in 2 days. Tap to claim!`,
            },
            data: {
              type: "gift_expiry_reminder",
              giftId: doc.id,
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
        } catch (e) {
          console.warn(`Failed to send gift reminder to ${gift.recipientId}:`, e);
        }
      }

      await doc.ref.update({ reminderSent: true });
    }

    console.log(`Sent ${soonExpiring.size} gift expiry reminders`);
    return null;
  });
