/**
 * Gifts Cloud Functions
 *
 * iMali gift system — send wrapped token gifts to other users.
 * Gifts use a true escrow pattern: tokens are debited from sender into
 * GIFT_ESCROW on send, credited from GIFT_ESCROW to recipient on claim,
 * and refunded from GIFT_ESCROW to sender on expiry.
 *
 * Collection: /gifts/{giftId}
 *
 * Lifecycle: pending → opened → claimed | expired
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import { validateMainWalletBalance } from "./ledger";
import {
  processGiftDebit,
  processGiftCredit,
  processGiftRefund,
} from "./ledger/giftSprayEscrow";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

function requireAuth(request: { auth?: { uid: string } }): string {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  return request.auth.uid;
}

async function getUserProfile(userId: string) {
  const doc = await db.collection("users").doc(userId).get();
  if (!doc.exists) {
    throw new HttpsError("not-found", `User ${userId} not found`);
  }
  return doc.data()!;
}

const VALID_STYLES = ["ndlovukazi", "celebration", "love", "birthday", "professional"];
const MIN_GIFT_AMOUNT = 10; // 10 tokens minimum
const MAX_GIFT_AMOUNT = 100000; // 100k tokens maximum
const GIFT_EXPIRY_DAYS = 7;

// ============================================================================
// SEND GIFT
// ============================================================================

/**
 * Send a gift to another user.
 *
 * 1. Validates inputs (integer, range, parent doc exists)
 * 2. Validates sender balance
 * 3. Debits sender → GIFT_ESCROW via processGiftDebit
 * 4. Creates /gifts/{id} document
 * 5. Writes a "gift" type message into conversation or community
 * 6. Sends FCM push to recipient
 * 7. Returns the created gift
 */
export const sendGift = onCall({ labels: { area: "gifts" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "sendGift");
  // Advisory mode (enforce=false): fire-and-forget — don't block the request
  // with the 1-3s Google Play Integrity API decode + Firestore audit log.
  requirePlayIntegrity(request.data, request, "sendGift", "HIGHEST")
    .catch((e) => logger.warn("[sendGift] Play integrity check error:", e));

  const { recipientId, amount, message, style, conversationId, communityId } = request.data;

  // --- Input validation ---
  if (!recipientId || typeof recipientId !== "string") {
    throw new HttpsError("invalid-argument", "recipientId is required");
  }
  if (typeof amount !== "number" || !Number.isInteger(amount)) {
    throw new HttpsError("invalid-argument", "amount must be an integer");
  }
  if (amount < MIN_GIFT_AMOUNT) {
    throw new HttpsError("invalid-argument", `Minimum gift is ${MIN_GIFT_AMOUNT} tokens`);
  }
  if (amount > MAX_GIFT_AMOUNT) {
    throw new HttpsError("invalid-argument", `Maximum gift is ${MAX_GIFT_AMOUNT} tokens`);
  }
  if (!message || typeof message !== "string" || message.trim().length === 0) {
    throw new HttpsError("invalid-argument", "Gift message is required");
  }
  if (!style || !VALID_STYLES.includes(style)) {
    throw new HttpsError("invalid-argument", `Invalid style. Must be one of: ${VALID_STYLES.join(", ")}`);
  }
  if (recipientId === userId) {
    throw new HttpsError("invalid-argument", "Cannot send a gift to yourself");
  }

  // --- Fetch profiles + check balance in parallel (single round-trip) ---
  // Profiles are needed both for conversation resolution (P2P) and for the
  // gift document, so we fetch them once and reuse.
  const [sender, recipient, balanceCheck] = await Promise.all([
    getUserProfile(userId),
    getUserProfile(recipientId),
    validateMainWalletBalance(userId, amount),
  ]);
  if (!balanceCheck.sufficient) {
    throw new HttpsError(
      "failed-precondition",
      `Insufficient balance. You have ${balanceCheck.available} tokens but need ${amount}.`
    );
  }

  // --- Resolve conversation for P2P gifts ---
  // When launched standalone (no conversationId), find or create the conversation.
  let resolvedConversationId = conversationId as string | undefined;
  if (!resolvedConversationId && !communityId) {
    const sortedIds = [userId, recipientId].sort();
    const deterministicId = `p2p_${sortedIds[0]}_${sortedIds[1]}`;
    const convRef = db.collection("conversations").doc(deterministicId);
    try {
      const now = admin.firestore.FieldValue.serverTimestamp();
      await convRef.create({
        id: deterministicId,
        type: "p2p",
        participantIds: [userId, recipientId],
        participants: {
          [userId]: {
            displayName: sender.displayName || "Unknown",
            avatarUrl: sender.avatarUrl || sender.profilePicThumbUrl || null,
          },
          [recipientId]: {
            displayName: recipient.displayName || "Unknown",
            avatarUrl: recipient.avatarUrl || recipient.profilePicThumbUrl || null,
          },
        },
        lastMessageText: null,
        lastMessageSenderId: null,
        lastMessageSenderName: null,
        lastMessageType: null,
        lastMessageAt: null,
        unreadCounts: { [userId]: 0, [recipientId]: 0 },
        accepted: { [userId]: true, [recipientId]: false },
        archived: { [userId]: false, [recipientId]: false },
        pinned: { [userId]: false, [recipientId]: false },
        muted: { [userId]: false, [recipientId]: false },
        disappearingMessagesDurationMs: null,
        createdAt: now,
        updatedAt: null,
      });
    } catch (e: any) {
      // Already exists (concurrent create or prior call) — safe to proceed
      if (e.code !== 6 /* ALREADY_EXISTS */) throw e;
    }
    resolvedConversationId = deterministicId;
  }

  // --- Validate parent doc exists ---
  const collection = resolvedConversationId ? "conversations" : "communities";
  const parentId = resolvedConversationId || communityId;
  const parentDoc = await db.collection(collection).doc(parentId!).get();
  if (!parentDoc.exists) {
    throw new HttpsError("not-found", `${collection === "conversations" ? "Conversation" : "Community"} not found`);
  }

  // --- Generate IDs ---
  const giftRef = db.collection("gifts").doc();
  const giftId = giftRef.id;
  const msgRef = db.collection(collection).doc(parentId!).collection("messages").doc();

  // --- Debit sender → GIFT_ESCROW ---
  let debitJournalId: string;
  try {
    debitJournalId = await processGiftDebit(
      userId,
      amount,
      giftId,
      `Sasaza to ${recipient.displayName || recipientId}`,
    );
  } catch (e: unknown) {
    const errMsg = e instanceof Error ? e.message : String(e);
    logger.error(`Gift debit failed for ${giftId}:`, e);
    if (errMsg.includes("INSUFFICIENT_BALANCE")) {
      throw new HttpsError("failed-precondition", "Insufficient balance to send this gift");
    }
    throw new HttpsError("internal", "Failed to process gift payment");
  }

  const expiresAt = new Date();
  expiresAt.setDate(expiresAt.getDate() + GIFT_EXPIRY_DAYS);

  // --- Construct the gift document ---
  const giftDoc = {
    id: giftId,
    senderId: userId,
    senderName: sender.displayName || "Unknown",
    recipientId,
    recipientName: recipient.displayName || "Unknown",
    amount,
    conversationId: resolvedConversationId || null,
    communityId: communityId || null,
    messageId: msgRef.id,
    message: message.trim().substring(0, 100),
    style,
    status: "pending",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    openedAt: null,
    claimedAt: null,
    expiresAt: admin.firestore.Timestamp.fromDate(expiresAt),
    debitTransactionId: debitJournalId,
    creditTransactionId: null,
    notificationSent: false,
    reminderSent: false,
  };

  // --- Construct the gift message ---
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
      expiresAt: expiresAt.toISOString(),
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

  // --- Batch write: gift doc + message + update parent lastMessage ---
  const batch = db.batch();
  batch.set(giftRef, giftDoc);
  batch.set(msgRef, giftMessage);

  // Update lastMessage on parent document
  const parentUpdate: Record<string, unknown> = {
    lastMessage: {
      text: `Sent a Sasaza of ${amount} tokens`,
      senderId: userId,
      senderName: sender.displayName || "Unknown",
      type: "gift",
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    },
    lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  // Increment unread for recipient(s)
  if (resolvedConversationId) {
    parentUpdate[`unreadCounts.${recipientId}`] = admin.firestore.FieldValue.increment(1);
  } else if (communityId) {
    const memberIds: string[] = parentDoc.data()?.memberIds || [];
    for (const memberId of memberIds) {
      if (memberId !== userId) {
        parentUpdate[`unreadCounts.${memberId}`] = admin.firestore.FieldValue.increment(1);
      }
    }
  }

  batch.update(db.collection(collection).doc(parentId!), parentUpdate);

  try {
    await batch.commit();
  } catch (batchErr) {
    // Batch write failed after debit succeeded — refund tokens from GIFT_ESCROW.
    // processGiftRefund is idempotent via giftRefund:${giftId} key.
    logger.error(`sendGift batch write failed for ${giftId}, initiating refund:`, batchErr);
    try {
      await processGiftRefund(
        userId, amount, giftId, "Auto-refund: gift creation failed"
      );
    } catch (refundErr) {
      logger.error(
        `CRITICAL: sendGift refund also failed for ${giftId}. ` +
        `${amount} tokens stuck in GIFT_ESCROW for user ${userId}. Manual intervention required.`,
        refundErr
      );
    }
    throw new HttpsError("internal", "Failed to create gift. Your tokens have been refunded.");
  }

  // --- Send FCM push to recipient (fire-and-forget — don't block response) ---
  const recipientFcmToken = recipient.fcmToken;
  if (recipientFcmToken) {
    admin.messaging().send({
      token: recipientFcmToken,
      notification: {
        title: "You received a Sasaza!",
        body: `${sender.displayName || "Someone"} sent you ${amount} tokens`,
      },
      data: {
        type: "gift_received",
        giftId,
        senderId: userId,
        conversationId: resolvedConversationId || "",
        communityId: communityId || "",
      },
      android: {
        priority: "high",
        notification: { channelId: "gifts", sound: "default" },
      },
      apns: {
        headers: { "apns-priority": "10" },
        payload: { aps: { sound: "default", badge: 1 } },
      },
    }).catch((e) => logger.warn("Failed to send gift FCM notification:", e));
  }

  // --- Return the gift data for the client ---
  return {
    id: giftId,
    senderId: userId,
    senderName: sender.displayName || "Unknown",
    recipientId,
    recipientName: recipient.displayName || "Unknown",
    amount,
    conversationId: resolvedConversationId || null,
    communityId: communityId || null,
    messageId: msgRef.id,
    message: message.trim().substring(0, 100),
    style,
    status: "pending",
    createdAt: new Date().toISOString(),
    openedAt: null,
    claimedAt: null,
    expiresAt: expiresAt.toISOString(),
    debitTransactionId: debitJournalId,
    creditTransactionId: null,
  };
});

// ============================================================================
// OPEN GIFT
// ============================================================================

/**
 * Mark a gift as opened (recipient saw it).
 * Only the recipient can open a gift.
 * Uses a Firestore transaction to prevent TOCTOU races.
 */
export const openGift = onCall({ labels: { area: "gifts" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "openGift");

  const { giftId } = request.data;
  if (!giftId || typeof giftId !== "string") {
    throw new HttpsError("invalid-argument", "giftId is required");
  }

  const giftRef = db.collection("gifts").doc(giftId);

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const result: Record<string, any> = await db.runTransaction(async (tx) => {
    const giftDoc = await tx.get(giftRef);

    if (!giftDoc.exists) {
      throw new HttpsError("not-found", "Gift not found");
    }

    const gift = giftDoc.data()!;

    // Only recipient can open
    if (gift.recipientId !== userId) {
      throw new HttpsError("permission-denied", "Only the recipient can open this gift");
    }

    // Already opened or claimed — return current state (idempotent)
    if (gift.status === "opened" || gift.status === "claimed") {
      return { ...gift, id: giftId };
    }

    // Check status — must be pending
    if (gift.status !== "pending") {
      throw new HttpsError("failed-precondition", `Gift is already ${gift.status}`);
    }

    // Check expiry
    const expiresAt = gift.expiresAt?.toDate ? gift.expiresAt.toDate() : new Date(gift.expiresAt);
    if (new Date() > expiresAt) {
      throw new HttpsError("failed-precondition", "Gift has expired");
    }

    // Update gift status within transaction
    tx.update(giftRef, {
      status: "opened",
      openedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update the embedded gift data in the message
    if (gift.messageId) {
      const msgCollection = gift.conversationId ? "conversations" : "communities";
      const msgParentId = gift.conversationId || gift.communityId;
      if (msgParentId) {
        const msgRef = db.collection(msgCollection).doc(msgParentId).collection("messages").doc(gift.messageId);
        tx.update(msgRef, { "gift.status": "opened" });
      }
    }

    return { ...gift, id: giftId, status: "opened" };
  });

  const expiresAt = result.expiresAt?.toDate ? result.expiresAt.toDate() : new Date(result.expiresAt);

  return {
    ...result,
    status: "opened",
    openedAt: new Date().toISOString(),
    createdAt: result.createdAt?.toDate ? result.createdAt.toDate().toISOString() : result.createdAt,
    expiresAt: expiresAt.toISOString(),
  };
});

// ============================================================================
// CLAIM GIFT
// ============================================================================

/**
 * Claim a gift — transfers tokens from GIFT_ESCROW to recipient's wallet.
 * Only the recipient can claim. Gift must be "opened" and not expired.
 * Uses a Firestore transaction to prevent TOCTOU races + double-claim.
 */
export const claimGift = onCall({ labels: { area: "gifts" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "claimGift");
  // Advisory mode (enforce=false): fire-and-forget — don't block the request.
  requirePlayIntegrity(request.data, request, "claimGift", "HIGHEST")
    .catch((e) => logger.warn("[claimGift] Play integrity check error:", e));

  const { giftId } = request.data;
  if (!giftId || typeof giftId !== "string") {
    throw new HttpsError("invalid-argument", "giftId is required");
  }

  const giftRef = db.collection("gifts").doc(giftId);

  // Phase 1: Validate and mark as claimed in a transaction
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const gift: Record<string, any> = await db.runTransaction(async (tx) => {
    const giftDoc = await tx.get(giftRef);

    if (!giftDoc.exists) {
      throw new HttpsError("not-found", "Gift not found");
    }

    const data = giftDoc.data()!;

    // Only recipient can claim
    if (data.recipientId !== userId) {
      throw new HttpsError("permission-denied", "Only the recipient can claim this gift");
    }

    // Already claimed — idempotent return
    if (data.status === "claimed") {
      return { ...data, id: giftId, alreadyClaimed: true };
    }

    // Must be opened (not pending or expired)
    if (data.status !== "opened") {
      throw new HttpsError("failed-precondition", `Gift cannot be claimed — status is ${data.status}`);
    }

    // Check expiry
    const expiresAt = data.expiresAt?.toDate ? data.expiresAt.toDate() : new Date(data.expiresAt);
    if (new Date() > expiresAt) {
      throw new HttpsError("failed-precondition", "Gift has expired");
    }

    // Mark as claimed within the transaction to prevent double-claim
    tx.update(giftRef, {
      status: "claimed",
      claimedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update the embedded gift data in the message
    if (data.messageId) {
      const msgCollection = data.conversationId ? "conversations" : "communities";
      const msgParentId = data.conversationId || data.communityId;
      if (msgParentId) {
        const msgRef = db.collection(msgCollection).doc(msgParentId).collection("messages").doc(data.messageId);
        tx.update(msgRef, { "gift.status": "claimed" });
      }
    }

    return { ...data, id: giftId, alreadyClaimed: false };
  });

  // Phase 2: Transfer tokens from GIFT_ESCROW → recipient (idempotent via idempotency key)
  if (!gift.alreadyClaimed) {
    let creditJournalId: string;
    try {
      creditJournalId = await processGiftCredit(
        userId,
        gift.amount,
        giftId,
        `Sasaza claimed from ${gift.senderName}`,
      );

      // Update gift with credit transaction ID (fire-and-forget — just metadata)
      giftRef.update({ creditTransactionId: creditJournalId })
        .catch((e) => logger.warn("Failed to update creditTransactionId:", e));
    } catch (e) {
      // Credit failed — roll back status and message embed.
      // Wrap entire rollback in try-catch: if rollback also fails,
      // log CRITICAL so a reconciliation process can find stuck gifts.
      logger.error(`Gift credit failed for ${giftId}, rolling back status:`, e);
      try {
        await giftRef.update({ status: "opened", claimedAt: null });
        if (gift.messageId) {
          const msgCollection = gift.conversationId ? "conversations" : "communities";
          const msgParentId = gift.conversationId || gift.communityId;
          if (msgParentId) {
            await db.collection(msgCollection).doc(msgParentId)
              .collection("messages").doc(gift.messageId)
              .update({ "gift.status": "opened" });
          }
        }
      } catch (rollbackErr) {
        logger.error(
          `CRITICAL: claimGift rollback ALSO failed for ${giftId}. ` +
          `Gift stuck as "claimed" without credit. Manual intervention required.`,
          rollbackErr
        );
      }
      throw new HttpsError("internal", "Failed to transfer tokens. Please try again.");
    }
  }

  const expiresAt = gift.expiresAt?.toDate ? gift.expiresAt.toDate() : new Date(gift.expiresAt);

  return {
    ...gift,
    status: "claimed",
    claimedAt: new Date().toISOString(),
    createdAt: gift.createdAt?.toDate ? gift.createdAt.toDate().toISOString() : gift.createdAt,
    expiresAt: expiresAt.toISOString(),
    alreadyClaimed: undefined,
  };
});

// ============================================================================
// SCHEDULED: EXPIRE GIFTS
// ============================================================================

/**
 * Hourly job: find pending/opened gifts past their expiresAt, refund from
 * GIFT_ESCROW back to sender, and mark them expired.
 */
export const expireGifts = onSchedule(
  { schedule: "0 * * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "gifts" } },
  async () => {
    const now = admin.firestore.Timestamp.now();

    const expiredGifts = await db.collection("gifts")
      .where("status", "in", ["pending", "opened"])
      .where("expiresAt", "<", now)
      .limit(100) // Process in batches
      .get();

    if (expiredGifts.empty) {
      logger.info("No gifts to expire");
      return;
    }

    logger.info(`Expiring ${expiredGifts.size} gifts`);

    let successCount = 0;
    let failCount = 0;

    for (const doc of expiredGifts.docs) {
      try {
        // Use a transaction to atomically verify status and mark expired.
        // Prevents race with concurrent claimGift (which also uses a
        // transaction on the same doc). Firestore serializes them.
        const txResult = await db.runTransaction(async (tx) => {
          const freshDoc = await tx.get(doc.ref);
          if (!freshDoc.exists) return null;
          const freshGift = freshDoc.data()!;

          // Re-check status — may have been claimed concurrently
          if (!["pending", "opened"].includes(freshGift.status)) {
            return null;
          }

          tx.update(doc.ref, { status: "expired" });

          // Update message embed in the same transaction
          if (freshGift.messageId) {
            const msgCollection = freshGift.conversationId ? "conversations" : "communities";
            const msgParentId = freshGift.conversationId || freshGift.communityId;
            if (msgParentId) {
              const msgRef = db.collection(msgCollection).doc(msgParentId)
                .collection("messages").doc(freshGift.messageId);
              tx.set(msgRef, { gift: { status: "expired" } }, { merge: true });
            }
          }

          return {
            originalStatus: freshGift.status as string,
            senderId: freshGift.senderId as string,
            senderName: freshGift.senderName as string,
            amount: freshGift.amount as number,
          };
        });

        if (!txResult) {
          continue; // Status changed concurrently (e.g., claimed), skip
        }

        // Refund sender from GIFT_ESCROW (idempotent via giftRefund:giftId key).
        // Done outside transaction because postJournal does its own writes.
        try {
          await processGiftRefund(
            txResult.senderId,
            txResult.amount,
            doc.id,
            `Sasaza expired — refund to ${txResult.senderName}`,
          );
        } catch (refundErr) {
          // Refund failed — revert status so next hourly run retries
          logger.error(`Refund failed for gift ${doc.id}, reverting status:`, refundErr);
          try {
            await doc.ref.update({ status: txResult.originalStatus });
          } catch (revertErr) {
            logger.error(
              `CRITICAL: Gift ${doc.id} stuck as expired without refund. ` +
              `${txResult.amount} tokens in GIFT_ESCROW for ${txResult.senderId}. Manual intervention needed.`,
              revertErr
            );
          }
          failCount++;
          continue;
        }

        successCount++;
      } catch (e) {
        logger.error(`Failed to expire gift ${doc.id}:`, e);
        failCount++;
      }
    }

    logger.info(`Expired ${successCount} gifts, ${failCount} failures`);
  }
);

// ============================================================================
// SCHEDULED: GIFT EXPIRY REMINDERS
// ============================================================================

/**
 * Daily job: find gifts expiring within 2 days and send a push notification
 * to the recipient reminding them to claim.
 */
export const sendGiftExpiryReminders = onSchedule(
  { schedule: "0 10 * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "gifts" } },
  async () => {
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
      logger.info("No gift expiry reminders to send");
      return;
    }

    logger.info(`Sending ${soonExpiring.size} gift expiry reminders`);

    const reminderBatch = db.batch();

    for (const doc of soonExpiring.docs) {
      const gift = doc.data();
      const recipientDoc = await db.collection("users").doc(gift.recipientId).get();
      const fcmToken = recipientDoc.data()?.fcmToken;

      if (fcmToken) {
        try {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Sasaza expiring soon!",
              body: `Your ${gift.amount} token Sasaza from ${gift.senderName} expires in 2 days. Tap to claim!`,
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
          logger.warn(`Failed to send gift reminder to ${gift.recipientId}:`, e);
        }
      }

      reminderBatch.update(doc.ref, { reminderSent: true });
    }

    await reminderBatch.commit();
    logger.info(`Sent ${soonExpiring.size} gift expiry reminders`);
  }
);
