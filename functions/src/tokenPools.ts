/**
 * Token Pools Cloud Functions
 *
 * Collection Room system for group token pooling.
 * Two modes:
 * - "sasaza": Group gift for an external recipient (Group Sasaza)
 * - "save": Group savings for participants (Group Save)
 *
 * Uses group ledger accounts (group:{poolId}) for escrow.
 * Contributions: user → group:{poolId} via processGroupContribution
 * Payouts: group:{poolId} → user(s) via processGroupPayout
 *
 * Collection: /tokenPools/{poolId}
 *
 * Lifecycle (sasaza): collecting → sent → completed | expired | cancelled
 * Lifecycle (save): collecting → completed | cancelled
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import {
  getOrCreateGroupAccount,
  processGroupContribution,
  processGroupPayout,
  processGroupWithdrawal,
} from "./ledger/groupAccounts";
import { validateMainWalletBalance } from "./ledger";

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

async function getFcmToken(userId: string): Promise<string | null> {
  const doc = await db.collection("users").doc(userId).get();
  return doc.data()?.fcmToken || null;
}

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

async function postSystemMessage(
  conversationId: string,
  text: string,
  eventType: string,
  eventData?: Record<string, unknown>
): Promise<string> {
  const msgRef = db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc();

  const now = admin.firestore.FieldValue.serverTimestamp();
  await msgRef.set({
    id: msgRef.id,
    senderId: "system",
    senderName: "System",
    type: "system",
    status: "sent",
    textContent: text,
    systemEventType: eventType,
    systemEventData: eventData || {},
    createdAt: now,
    reactions: {},
    readBy: {},
    deletedFor: [],
    deletedForEveryone: false,
  });

  // Update conversation last message preview
  await db.collection("conversations").doc(conversationId).update({
    lastMessageId: msgRef.id,
    "lastMessage.text": text,
    "lastMessage.senderId": "system",
    "lastMessage.senderName": "System",
    "lastMessage.type": "system",
    "lastMessage.timestamp": now,
    lastMessageText: text,
    lastMessageSenderId: "system",
    lastMessageSenderName: "System",
    lastMessageType: "system",
    lastMessageAt: now,
    updatedAt: now,
  });

  return msgRef.id;
}

async function sendFcmNotification(
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
// CONSTANTS
// ============================================================================

const VALID_STYLES = ["ndlovukazi", "celebration", "love", "birthday", "professional"];
const MIN_CONTRIBUTION = 10;
const MAX_CONTRIBUTION = 100000;
const MAX_INVITEES = 50;
const POOL_COLLECTION_EXPIRY_DAYS = 30;
const GIFT_CLAIM_EXPIRY_DAYS = 7;

// ============================================================================
// CREATE TOKEN POOL
// ============================================================================

/**
 * Create a new token pool (Collection Room).
 *
 * Creates:
 * 1. Group ledger account (group:{poolId})
 * 2. tokenPools/{poolId} document
 * 3. conversations/{convId} document (type: 'collection')
 * 4. System message in the collection room
 * 5. FCM notifications to invitees
 */
export const createTokenPool = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "createTokenPool");

    const { mode, title, purpose, message, style, recipientId, inviteeIds, communityId } = request.data;

    // --- Validation ---
    if (!mode || !["sasaza", "save"].includes(mode)) {
      throw new HttpsError("invalid-argument", "mode must be 'sasaza' or 'save'");
    }

    if (!title || typeof title !== "string" || title.trim().length === 0 || title.length > 100) {
      throw new HttpsError("invalid-argument", "title must be 1-100 characters");
    }

    if (purpose !== undefined && purpose !== null && typeof purpose === "string" && purpose.length > 200) {
      throw new HttpsError("invalid-argument", "purpose must be 0-200 characters");
    }

    if (message !== undefined && message !== null && typeof message === "string" && message.length > 200) {
      throw new HttpsError("invalid-argument", "message must be 0-200 characters");
    }

    if (!style || !VALID_STYLES.includes(style)) {
      throw new HttpsError("invalid-argument", `style must be one of: ${VALID_STYLES.join(", ")}`);
    }

    if (!Array.isArray(inviteeIds) || inviteeIds.length === 0 || inviteeIds.length > MAX_INVITEES) {
      throw new HttpsError("invalid-argument", `inviteeIds must have 1-${MAX_INVITEES} entries`);
    }

    // Sasaza-specific validation
    if (mode === "sasaza") {
      if (!recipientId || typeof recipientId !== "string") {
        throw new HttpsError("invalid-argument", "recipientId is required for sasaza mode");
      }
      if (recipientId === userId) {
        throw new HttpsError("invalid-argument", "Cannot send a Group Sasaza to yourself");
      }
      if (inviteeIds.includes(recipientId)) {
        throw new HttpsError("invalid-argument", "Recipient cannot be an invitee");
      }
    }

    // Remove organizer from invitees if accidentally included
    const filteredInviteeIds = inviteeIds.filter((id: string) => id !== userId);

    if (filteredInviteeIds.length === 0) {
      throw new HttpsError("invalid-argument", "Must invite at least one other person");
    }

    // Verify all invitees exist
    const allUserIds = mode === "sasaza" && recipientId
      ? [...filteredInviteeIds, recipientId]
      : [...filteredInviteeIds];

    for (let i = 0; i < allUserIds.length; i += 30) {
      const batch = allUserIds.slice(i, i + 30);
      const refs = batch.map((id: string) => db.collection("users").doc(id));
      const docs = await db.getAll(...refs);
      for (const doc of docs) {
        if (!doc.exists) {
          throw new HttpsError("not-found", `User ${doc.id} not found`);
        }
      }
    }

    // --- Create pool ---
    const poolRef = db.collection("tokenPools").doc();
    const poolId = poolRef.id;
    const now = admin.firestore.FieldValue.serverTimestamp();

    // 1. Create group ledger account
    const { accountId: groupAccountId } = await getOrCreateGroupAccount(poolId);

    // 2. Get organizer profile
    const organizerProfile = await getUserProfile(userId);
    const organizerName = organizerProfile.displayName || "Unknown";

    // Get recipient profile (sasaza mode)
    let recipientName: string | null = null;
    if (mode === "sasaza" && recipientId) {
      const recipientProfile = await getUserProfile(recipientId);
      recipientName = recipientProfile.displayName || "Unknown";
    }

    // 3. Create conversation (collection room)
    const convId = `collection_${poolId}`;
    const convRef = db.collection("conversations").doc(convId);

    const participantIds = [userId, ...filteredInviteeIds];

    // Build participants map
    const participantsMap: Record<string, unknown> = {};
    participantsMap[userId] = {
      displayName: organizerName,
      avatarUrl: organizerProfile.avatarUrl || organizerProfile.profilePicThumbUrl || null,
    };

    // Fetch invitee profiles for denormalized data
    for (let i = 0; i < filteredInviteeIds.length; i += 30) {
      const batch = filteredInviteeIds.slice(i, i + 30);
      const refs = batch.map((id: string) => db.collection("users").doc(id));
      const docs = await db.getAll(...refs);
      for (const doc of docs) {
        if (doc.exists) {
          const data = doc.data()!;
          participantsMap[doc.id] = {
            displayName: data.displayName || "Unknown",
            avatarUrl: data.avatarUrl || data.profilePicThumbUrl || null,
          };
        }
      }
    }

    const unreadCounts: Record<string, number> = {};
    const archived: Record<string, boolean> = {};
    const pinned: Record<string, boolean> = {};
    const muted: Record<string, boolean> = {};
    const accepted: Record<string, boolean> = {};

    for (const pid of participantIds) {
      unreadCounts[pid] = 0;
      archived[pid] = false;
      pinned[pid] = false;
      muted[pid] = false;
      accepted[pid] = true; // Collection rooms are auto-accepted
    }

    // Calculate expiry (sasaza: 30 days, save: no expiry)
    const expiresAt = mode === "sasaza"
      ? admin.firestore.Timestamp.fromDate(
          new Date(Date.now() + POOL_COLLECTION_EXPIRY_DAYS * 24 * 60 * 60 * 1000)
        )
      : null;

    // Write conversation and pool in a batch
    const writeBatch = db.batch();

    writeBatch.set(convRef, {
      id: convId,
      type: "collection",
      tokenPoolId: poolId,
      poolTitle: title.trim(),
      poolMode: mode,
      participantIds,
      participants: participantsMap,
      lastMessageText: null,
      lastMessageSenderId: null,
      lastMessageSenderName: null,
      lastMessageType: null,
      lastMessageAt: null,
      unreadCounts,
      archived,
      pinned,
      muted,
      accepted,
      disappearingMessagesDurationMs: null,
      createdAt: now,
      updatedAt: null,
    });

    writeBatch.set(poolRef, {
      id: poolId,
      mode,
      status: "collecting",
      organizerId: userId,
      organizerName,
      recipientId: recipientId || null,
      recipientName: recipientName || null,
      communityId: communityId || null,
      conversationId: convId,
      title: title.trim(),
      purpose: (purpose || "").trim(),
      message: (message || "").trim(),
      style,
      totalAmount: 0,
      contributionCount: 0,
      contributorCount: 0,
      contributions: {},
      payouts: [],
      giftMessageId: null,
      giftConversationId: null,
      inviteeIds: filteredInviteeIds,
      expiresAt,
      createdAt: now,
      updatedAt: now,
      sentAt: null,
      openedAt: null,
      completedAt: null,
      cancelledAt: null,
      groupAccountId,
      reminderSent: false,
    });

    await writeBatch.commit();

    // 4. Post system message
    const purposeTrimmed = (purpose || "").trim();
    const systemText = mode === "sasaza"
      ? `${organizerName} started a Group Sasaza for ${recipientName}`
      : purposeTrimmed
        ? `${organizerName} started a Group Save: ${purposeTrimmed}`
        : `${organizerName} started a Group Save`;

    await postSystemMessage(convId, systemText, "pool_created", {
      poolId,
      mode,
      organizerName,
      recipientName,
    });

    // 5. FCM notifications to invitees (fire-and-forget — don't block response)
    getFcmTokens(filteredInviteeIds).then((fcmTokens) => {
      const fcmTitle = mode === "sasaza"
        ? `Group Sasaza for ${recipientName}`
        : "Group Save invitation";
      const fcmBody = `${organizerName} invited you to contribute`;
      for (const token of fcmTokens) {
        sendFcmNotification(token, fcmTitle, fcmBody, {
          type: "pool_invite",
          poolId,
          conversationId: convId,
        });
      }
    }).catch((e) => logger.warn("FCM notify failed for pool creation:", e));

    logger.info(`Created token pool ${poolId} (${mode}) by ${userId}`);

    // Return the pool data (read back to get server timestamps)
    const poolDoc = await poolRef.get();
    return { success: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// CONTRIBUTE TO POOL
// ============================================================================

/**
 * Contribute tokens to a pool.
 *
 * Phase 1: Firestore transaction (validate + update pool counters)
 * Phase 2: Ledger operation (processGroupContribution)
 * Phase 3: Side effects (system message, FCM)
 * Rollback: Revert pool counters on Phase 2 failure
 */
export const contributeToPool = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "contributeToPool");

    const { poolId, amount, anonymous } = request.data;

    if (!poolId || typeof poolId !== "string") {
      throw new HttpsError("invalid-argument", "poolId is required");
    }

    if (!Number.isInteger(amount) || amount < MIN_CONTRIBUTION || amount > MAX_CONTRIBUTION) {
      throw new HttpsError(
        "invalid-argument",
        `Amount must be an integer between ${MIN_CONTRIBUTION} and ${MAX_CONTRIBUTION}`
      );
    }

    // Pre-check balance before transaction
    const balanceCheck = await validateMainWalletBalance(userId, amount);
    if (!balanceCheck.sufficient) {
      throw new HttpsError(
        "failed-precondition",
        `Insufficient balance: have ${balanceCheck.available}, need ${amount}`
      );
    }

    const poolRef = db.collection("tokenPools").doc(poolId);
    const contributionId = db.collection("_ids").doc().id; // unique ID for idempotency

    // Phase 1: Firestore transaction — validate and update pool
    const txResult: Record<string, any> = await db.runTransaction(async (tx) => {
      const poolDoc = await tx.get(poolRef);

      if (!poolDoc.exists) {
        throw new HttpsError("not-found", "Pool not found");
      }

      const pool = poolDoc.data()!;

      if (pool.status !== "collecting") {
        throw new HttpsError("failed-precondition", "Pool is no longer accepting contributions");
      }

      // Must be organizer or invitee
      if (pool.organizerId !== userId && !pool.inviteeIds.includes(userId)) {
        throw new HttpsError("permission-denied", "You are not a participant in this pool");
      }

      // Get user profile for display name
      const userProfile = await getUserProfile(userId);
      const displayName = userProfile.displayName || "Unknown";

      // Build updated contribution data
      const existingContrib = pool.contributions?.[userId];
      const updatedContrib = {
        userId,
        displayName,
        totalAmount: (existingContrib?.totalAmount || 0) + amount,
        contributionCount: (existingContrib?.contributionCount || 0) + 1,
        anonymous: anonymous === true,
        lastContributedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      const newContributorCount = existingContrib
        ? pool.contributorCount
        : (pool.contributorCount || 0) + 1;

      tx.update(poolRef, {
        [`contributions.${userId}`]: updatedContrib,
        totalAmount: admin.firestore.FieldValue.increment(amount),
        contributionCount: admin.firestore.FieldValue.increment(1),
        contributorCount: newContributorCount,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        displayName,
        conversationId: pool.conversationId,
        organizerId: pool.organizerId,
        mode: pool.mode,
        recipientName: pool.recipientName,
        wasNewContributor: !existingContrib,
      };
    });

    // Phase 2: Ledger operation
    let ledgerResult;
    try {
      ledgerResult = await processGroupContribution(poolId, userId, amount, contributionId);
      if (!ledgerResult.success) {
        // Rollback pool counters
        await poolRef.update({
          [`contributions.${userId}.totalAmount`]: admin.firestore.FieldValue.increment(-amount),
          [`contributions.${userId}.contributionCount`]: admin.firestore.FieldValue.increment(-1),
          totalAmount: admin.firestore.FieldValue.increment(-amount),
          contributionCount: admin.firestore.FieldValue.increment(-1),
          ...(txResult.wasNewContributor ? { contributorCount: admin.firestore.FieldValue.increment(-1) } : {}),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        throw new HttpsError("internal", ledgerResult.error || "Failed to process contribution");
      }
    } catch (e) {
      if (e instanceof HttpsError) throw e;
      // Rollback pool counters
      await poolRef.update({
        [`contributions.${userId}.totalAmount`]: admin.firestore.FieldValue.increment(-amount),
        [`contributions.${userId}.contributionCount`]: admin.firestore.FieldValue.increment(-1),
        totalAmount: admin.firestore.FieldValue.increment(-amount),
        contributionCount: admin.firestore.FieldValue.increment(-1),
        ...(txResult.wasNewContributor ? { contributorCount: admin.firestore.FieldValue.increment(-1) } : {}),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      logger.error("Contribution ledger error:", e);
      throw new HttpsError("internal", "Failed to process contribution");
    }

    // Phase 3: Side effects
    const contributorLabel = anonymous === true ? "Someone" : txResult.displayName;
    await postSystemMessage(
      txResult.conversationId,
      `${contributorLabel} contributed ${amount} tokens`,
      "pool_contribution",
      { poolId, userId, amount, anonymous: anonymous === true }
    );

    // FCM to organizer (if contributor is not the organizer)
    if (userId !== txResult.organizerId) {
      const organizerToken = await getFcmToken(txResult.organizerId);
      if (organizerToken) {
        await sendFcmNotification(
          organizerToken,
          "New contribution",
          `${contributorLabel} contributed ${amount} tokens`,
          { type: "pool_contribution", poolId, conversationId: txResult.conversationId }
        );
      }
    }

    logger.info(`Contribution ${contributionId}: ${amount} tokens from ${userId} to pool ${poolId}`);

    const poolDoc = await poolRef.get();
    return { success: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// SEND GROUP GIFT (sasaza mode)
// ============================================================================

/**
 * Send the group gift to the recipient.
 *
 * Transfers all pooled tokens from group account to recipient.
 * Creates a groupGift message in the organizer↔recipient P2P conversation.
 */
export const sendGroupGift = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "sendGroupGift");

    const { poolId } = request.data;

    if (!poolId || typeof poolId !== "string") {
      throw new HttpsError("invalid-argument", "poolId is required");
    }

    const poolRef = db.collection("tokenPools").doc(poolId);
    const sendTxId = `send_${poolId}_${Date.now()}`;

    // Phase 1: Firestore transaction — validate and update status
    const txResult: Record<string, any> = await db.runTransaction(async (tx) => {
      const poolDoc = await tx.get(poolRef);

      if (!poolDoc.exists) {
        throw new HttpsError("not-found", "Pool not found");
      }

      const pool = poolDoc.data()!;

      if (pool.mode !== "sasaza") {
        throw new HttpsError("failed-precondition", "Only sasaza pools can send a group gift");
      }

      if (pool.status !== "collecting") {
        throw new HttpsError("failed-precondition", "Pool is not in collecting status");
      }

      if (pool.organizerId !== userId) {
        throw new HttpsError("permission-denied", "Only the organizer can send the gift");
      }

      if (pool.totalAmount <= 0) {
        throw new HttpsError("failed-precondition", "Pool has no contributions");
      }

      const claimExpiresAt = admin.firestore.Timestamp.fromDate(
        new Date(Date.now() + GIFT_CLAIM_EXPIRY_DAYS * 24 * 60 * 60 * 1000)
      );

      tx.update(poolRef, {
        status: "sent",
        sentAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: claimExpiresAt,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        recipientId: pool.recipientId,
        recipientName: pool.recipientName,
        organizerName: pool.organizerName,
        totalAmount: pool.totalAmount,
        contributorCount: pool.contributorCount,
        contributions: pool.contributions || {},
        conversationId: pool.conversationId,
        message: pool.message,
        style: pool.style,
        title: pool.title,
      };
    });

    // Phase 2: Ledger payout — group → recipient
    try {
      const payoutResult = await processGroupPayout(
        poolId,
        [{ memberId: txResult.recipientId, amount: txResult.totalAmount }],
        sendTxId
      );

      if (!payoutResult.success) {
        // Rollback status
        await poolRef.update({
          status: "collecting",
          sentAt: null,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        throw new HttpsError("internal", payoutResult.error || "Failed to transfer tokens");
      }
    } catch (e) {
      if (e instanceof HttpsError) throw e;
      // Rollback status
      await poolRef.update({
        status: "collecting",
        sentAt: null,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      logger.error("Send group gift ledger error:", e);
      throw new HttpsError("internal", "Failed to transfer tokens");
    }

    // Phase 3: Side effects

    // 3a. Get or create organizer↔recipient P2P conversation
    const sortedIds = [userId, txResult.recipientId].sort();
    const deterministicConvId = `p2p_${sortedIds[0]}_${sortedIds[1]}`;
    const p2pConvRef = db.collection("conversations").doc(deterministicConvId);

    // Use create() to avoid race conditions — if doc already exists, catch and proceed.
    try {
      const organizerProfile = await getUserProfile(userId);
      const recipientProfile = await getUserProfile(txResult.recipientId);
      const now = admin.firestore.FieldValue.serverTimestamp();

      await p2pConvRef.create({
        id: deterministicConvId,
        type: "p2p",
        participantIds: [userId, txResult.recipientId],
        participants: {
          [userId]: {
            displayName: organizerProfile.displayName || "Unknown",
            avatarUrl: organizerProfile.avatarUrl || organizerProfile.profilePicThumbUrl || null,
          },
          [txResult.recipientId]: {
            displayName: recipientProfile.displayName || "Unknown",
            avatarUrl: recipientProfile.avatarUrl || recipientProfile.profilePicThumbUrl || null,
          },
        },
        lastMessageText: null,
        lastMessageSenderId: null,
        lastMessageSenderName: null,
        lastMessageType: null,
        lastMessageAt: null,
        unreadCounts: { [userId]: 0, [txResult.recipientId]: 0 },
        accepted: { [userId]: true, [txResult.recipientId]: true },
        archived: { [userId]: false, [txResult.recipientId]: false },
        pinned: { [userId]: false, [txResult.recipientId]: false },
        muted: { [userId]: false, [txResult.recipientId]: false },
        disappearingMessagesDurationMs: null,
        createdAt: now,
        updatedAt: null,
      });
    } catch (e: any) {
      // Already exists (concurrent create or prior call) — safe to proceed
      if (e.code !== 6 /* ALREADY_EXISTS */) throw e;
    }

    // 3b. Build visible contributor names (non-anonymous)
    const contributions = txResult.contributions as Record<string, any>;
    const visibleContributorNames: string[] = [];
    let anonymousCount = 0;
    for (const contrib of Object.values(contributions)) {
      if (contrib.anonymous) {
        anonymousCount++;
      } else {
        visibleContributorNames.push(contrib.displayName || "Unknown");
      }
    }

    // 3c. Write groupGift message in P2P conversation
    const giftMsgRef = p2pConvRef.collection("messages").doc();
    const msgNow = admin.firestore.FieldValue.serverTimestamp();

    await giftMsgRef.set({
      id: giftMsgRef.id,
      senderId: userId,
      senderName: txResult.organizerName,
      type: "groupGift",
      status: "sent",
      textContent: txResult.message || null,
      groupGift: {
        poolId,
        amount: txResult.totalAmount,
        message: txResult.message || "",
        style: txResult.style,
        organizerId: userId,
        organizerName: txResult.organizerName,
        contributorCount: txResult.contributorCount,
        visibleContributorNames,
        anonymousCount,
        status: "sent",
      },
      createdAt: msgNow,
      reactions: {},
      readBy: {},
      deletedFor: [],
      deletedForEveryone: false,
    });

    // Update P2P conversation last message
    const othersText = txResult.contributorCount > 1
      ? ` and ${txResult.contributorCount - 1} others`
      : "";
    const previewText = `Group Sasaza from ${txResult.organizerName}${othersText}`;
    await p2pConvRef.update({
      lastMessageId: giftMsgRef.id,
      "lastMessage.text": previewText,
      "lastMessage.senderId": userId,
      "lastMessage.senderName": txResult.organizerName,
      "lastMessage.type": "groupGift",
      "lastMessage.timestamp": msgNow,
      lastMessageText: previewText,
      lastMessageSenderId: userId,
      lastMessageSenderName: txResult.organizerName,
      lastMessageType: "groupGift",
      lastMessageAt: msgNow,
      [`unreadCounts.${txResult.recipientId}`]: admin.firestore.FieldValue.increment(1),
      updatedAt: msgNow,
    });

    // 3d. Update pool with delivery references
    await poolRef.update({
      giftConversationId: deterministicConvId,
      giftMessageId: giftMsgRef.id,
    });

    // 3e. System message in collection room
    await postSystemMessage(
      txResult.conversationId,
      `Group Sasaza sent to ${txResult.recipientName}! ${txResult.totalAmount} tokens`,
      "pool_sasaza_sent",
      { poolId, recipientName: txResult.recipientName, amount: txResult.totalAmount }
    );

    // 3f. FCM to recipient
    const recipientToken = await getFcmToken(txResult.recipientId);
    if (recipientToken) {
      await sendFcmNotification(
        recipientToken,
        "You received a Group Sasaza!",
        `${txResult.organizerName}${othersText} sent you ${txResult.totalAmount} tokens`,
        {
          type: "group_gift_received",
          poolId,
          conversationId: deterministicConvId,
        }
      );
    }

    // 3g. FCM to contributors
    const contributorIds = Object.keys(contributions).filter((id) => id !== userId);
    const contributorTokens = await getFcmTokens(contributorIds);
    for (const token of contributorTokens) {
      await sendFcmNotification(
        token,
        "Group Sasaza sent!",
        `The Group Sasaza for ${txResult.recipientName} has been sent!`,
        { type: "pool_sasaza_sent", poolId, conversationId: txResult.conversationId }
      );
    }

    logger.info(`Group gift sent: pool ${poolId}, ${txResult.totalAmount} tokens to ${txResult.recipientId}`);

    const poolDoc = await poolRef.get();
    return { success: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// OPEN GROUP GIFT (recipient)
// ============================================================================

/**
 * Recipient opens the group gift. Purely a status update — no ledger operation.
 */
export const openGroupGift = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "openGroupGift");

    const { poolId } = request.data;

    if (!poolId || typeof poolId !== "string") {
      throw new HttpsError("invalid-argument", "poolId is required");
    }

    const poolRef = db.collection("tokenPools").doc(poolId);

    await db.runTransaction(async (tx) => {
      const poolDoc = await tx.get(poolRef);

      if (!poolDoc.exists) {
        throw new HttpsError("not-found", "Pool not found");
      }

      const pool = poolDoc.data()!;

      if (pool.recipientId !== userId) {
        throw new HttpsError("permission-denied", "Only the recipient can open the gift");
      }

      if (pool.status !== "sent") {
        throw new HttpsError("failed-precondition", "Gift is not in sent status");
      }

      // Idempotent: already opened
      if (pool.openedAt) {
        return;
      }

      tx.update(poolRef, {
        openedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    logger.info(`Group gift opened: pool ${poolId} by ${userId}`);

    const poolDoc = await poolRef.get();
    return { success: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// CLAIM GROUP GIFT (recipient)
// ============================================================================

/**
 * Recipient claims the group gift. Status update only — tokens already transferred during send.
 */
export const claimGroupGift = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "claimGroupGift");

    const { poolId } = request.data;

    if (!poolId || typeof poolId !== "string") {
      throw new HttpsError("invalid-argument", "poolId is required");
    }

    const poolRef = db.collection("tokenPools").doc(poolId);

    const txResult: Record<string, any> = await db.runTransaction(async (tx) => {
      const poolDoc = await tx.get(poolRef);

      if (!poolDoc.exists) {
        throw new HttpsError("not-found", "Pool not found");
      }

      const pool = poolDoc.data()!;

      if (pool.recipientId !== userId) {
        throw new HttpsError("permission-denied", "Only the recipient can claim the gift");
      }

      if (pool.status !== "sent") {
        throw new HttpsError("failed-precondition", "Gift is not in sent status");
      }

      if (!pool.openedAt) {
        throw new HttpsError("failed-precondition", "Gift must be opened before claiming");
      }

      tx.update(poolRef, {
        status: "completed",
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        conversationId: pool.conversationId,
        organizerId: pool.organizerId,
        recipientName: pool.recipientName,
        totalAmount: pool.totalAmount,
        giftConversationId: pool.giftConversationId,
        giftMessageId: pool.giftMessageId,
        contributions: pool.contributions || {},
      };
    });

    // Update the groupGift message embed status
    if (txResult.giftConversationId && txResult.giftMessageId) {
      await db
        .collection("conversations")
        .doc(txResult.giftConversationId)
        .collection("messages")
        .doc(txResult.giftMessageId)
        .update({ "groupGift.status": "completed" });
    }

    // System message in collection room
    await postSystemMessage(
      txResult.conversationId,
      `${txResult.recipientName} claimed the Group Sasaza! ${txResult.totalAmount} tokens`,
      "pool_sasaza_claimed",
      { poolId, recipientName: txResult.recipientName, amount: txResult.totalAmount }
    );

    // FCM to organizer + contributors
    const allContributorIds = Object.keys(txResult.contributions);
    if (!allContributorIds.includes(txResult.organizerId)) {
      allContributorIds.push(txResult.organizerId);
    }
    const fcmTokens = await getFcmTokens(allContributorIds);
    for (const token of fcmTokens) {
      await sendFcmNotification(
        token,
        "Group Sasaza claimed!",
        `${txResult.recipientName} claimed the ${txResult.totalAmount} token gift!`,
        { type: "pool_sasaza_claimed", poolId, conversationId: txResult.conversationId }
      );
    }

    logger.info(`Group gift claimed: pool ${poolId} by ${userId}`);

    const poolDoc = await poolRef.get();
    return { success: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// DISTRIBUTE POOL (save mode)
// ============================================================================

/**
 * Distribute pool tokens among participants (save mode).
 *
 * Organizer specifies payout amounts per participant.
 * Sum must equal totalAmount exactly.
 */
export const distributePool = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "distributePool");

    const { poolId, payouts, keepOpen = false } = request.data;

    if (!poolId || typeof poolId !== "string") {
      throw new HttpsError("invalid-argument", "poolId is required");
    }

    if (!Array.isArray(payouts) || payouts.length === 0) {
      throw new HttpsError("invalid-argument", "payouts must be a non-empty array");
    }

    // Validate each payout entry
    for (const p of payouts) {
      if (!p.userId || typeof p.userId !== "string") {
        throw new HttpsError("invalid-argument", "Each payout must have a userId");
      }
      if (!Number.isInteger(p.amount) || p.amount <= 0) {
        throw new HttpsError("invalid-argument", "Each payout amount must be a positive integer");
      }
    }

    const poolRef = db.collection("tokenPools").doc(poolId);
    const distributeTxId = `distribute_${poolId}_${Date.now()}`;

    // Phase 1: Validate and update status
    const txResult: Record<string, any> = await db.runTransaction(async (tx) => {
      const poolDoc = await tx.get(poolRef);

      if (!poolDoc.exists) {
        throw new HttpsError("not-found", "Pool not found");
      }

      const pool = poolDoc.data()!;

      if (pool.mode !== "save") {
        throw new HttpsError("failed-precondition", "Only save pools can be distributed");
      }

      if (pool.status !== "collecting") {
        throw new HttpsError("failed-precondition", "Pool is not in collecting status");
      }

      if (pool.organizerId !== userId) {
        throw new HttpsError("permission-denied", "Only the organizer can distribute");
      }

      if (pool.totalAmount <= 0) {
        throw new HttpsError("failed-precondition", "Pool has no contributions");
      }

      // Validate payout sum against available balance
      const payoutSum = payouts.reduce((sum: number, p: { amount: number }) => sum + p.amount, 0);
      const totalDistributed = pool.totalDistributed || 0;
      const availableBalance = pool.totalAmount - totalDistributed;
      if (payoutSum <= 0 || payoutSum > availableBalance) {
        throw new HttpsError(
          "invalid-argument",
          `Payout sum (${payoutSum}) must be between 1 and available balance (${availableBalance})`
        );
      }

      const isFullDistribution = payoutSum === availableBalance;
      const newStatus = (isFullDistribution && !keepOpen) ? "completed" : "collecting";

      // Validate all payout recipients are participants
      const allParticipants = [pool.organizerId, ...pool.inviteeIds];
      for (const p of payouts) {
        if (!allParticipants.includes(p.userId)) {
          throw new HttpsError("invalid-argument", `User ${p.userId} is not a pool participant`);
        }
      }

      // Get display names for payouts
      const payoutRecords = [];
      for (const p of payouts) {
        const profile = await getUserProfile(p.userId);
        payoutRecords.push({
          userId: p.userId,
          displayName: profile.displayName || "Unknown",
          amount: p.amount,
        });
      }

      const existingPayouts = pool.payouts || [];
      const allPayouts = [...existingPayouts, ...payoutRecords];
      const newTotalDistributed = totalDistributed + payoutSum;

      const updateData: Record<string, any> = {
        status: newStatus,
        payouts: allPayouts,
        totalDistributed: newTotalDistributed,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      if (newStatus === "completed") {
        updateData.completedAt = admin.firestore.FieldValue.serverTimestamp();
      }

      tx.update(poolRef, updateData);

      return {
        conversationId: pool.conversationId,
        totalAmount: pool.totalAmount,
        inviteeIds: pool.inviteeIds,
        payoutRecords,
        payoutSum,
        isFullDistribution,
        newStatus,
        previousStatus: pool.status,
        previousTotalDistributed: totalDistributed,
        previousPayouts: existingPayouts,
      };
    });

    // Phase 2: Ledger payout
    try {
      const payoutEntries = payouts.map((p: { userId: string; amount: number }) => ({
        memberId: p.userId,
        amount: p.amount,
      }));

      const payoutResult = await processGroupPayout(poolId, payoutEntries, distributeTxId);

      if (!payoutResult.success) {
        // Rollback to previous state
        await poolRef.update({
          status: txResult.previousStatus,
          payouts: txResult.previousPayouts,
          totalDistributed: txResult.previousTotalDistributed,
          completedAt: null,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        throw new HttpsError("internal", payoutResult.error || "Failed to distribute tokens");
      }
    } catch (e) {
      if (e instanceof HttpsError) throw e;
      await poolRef.update({
        status: txResult.previousStatus,
        payouts: txResult.previousPayouts,
        totalDistributed: txResult.previousTotalDistributed,
        completedAt: null,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      logger.error("Distribute pool ledger error:", e);
      throw new HttpsError("internal", "Failed to distribute tokens");
    }

    // Phase 3: Side effects
    const payoutLines = txResult.payoutRecords
      .map((p: { displayName: string; amount: number }) => `${p.displayName}: ${p.amount} tokens`)
      .join(", ");

    const isPartial = !txResult.isFullDistribution || keepOpen;
    const messagePrefix = isPartial ? "Partial distribution" : "Pool distributed!";
    const messageType = isPartial ? "pool_partially_distributed" : "pool_distributed";

    await postSystemMessage(
      txResult.conversationId,
      `${messagePrefix} ${payoutLines}`,
      messageType,
      { poolId, payouts: txResult.payoutRecords, isPartial }
    );

    // FCM to all participants
    const allParticipantIds = [userId, ...txResult.inviteeIds];
    const fcmTokens = await getFcmTokens(allParticipantIds.filter((id: string) => id !== userId));
    const fcmTitle = isPartial ? "Partial distribution" : "Pool distributed!";
    const fcmBody = isPartial
      ? `${txResult.payoutSum} tokens distributed (pool remains open)`
      : `${txResult.totalAmount} tokens have been distributed`;
    for (const token of fcmTokens) {
      await sendFcmNotification(
        token,
        fcmTitle,
        fcmBody,
        { type: messageType, poolId, conversationId: txResult.conversationId }
      );
    }

    logger.info(`Pool ${isPartial ? "partially " : ""}distributed: ${poolId}, ${txResult.payoutSum} tokens to ${payouts.length} recipients`);

    const poolDoc = await poolRef.get();
    return { success: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// REQUEST POOL WITHDRAWAL
// ============================================================================

/**
 * Request a withdrawal from a Group Save pool.
 *
 * Auto-approved up to the member's own contribution total.
 * Only available for save-mode pools in collecting status.
 */
export const requestPoolWithdrawal = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "requestPoolWithdrawal");

    const { poolId, amount } = request.data;

    if (!poolId || typeof poolId !== "string") {
      throw new HttpsError("invalid-argument", "poolId is required");
    }

    if (!Number.isInteger(amount) || amount <= 0) {
      throw new HttpsError("invalid-argument", "amount must be a positive integer");
    }

    const poolRef = db.collection("tokenPools").doc(poolId);
    const withdrawTxId = `withdraw_${poolId}_${userId}_${Date.now()}`;

    // Phase 1: Validate and update pool
    const txResult = await db.runTransaction(async (tx) => {
      const poolDoc = await tx.get(poolRef);

      if (!poolDoc.exists) {
        throw new HttpsError("not-found", "Pool not found");
      }

      const pool = poolDoc.data()!;

      if (pool.mode !== "save") {
        throw new HttpsError("failed-precondition", "Withdrawals are only available for Group Save pools");
      }

      if (pool.status !== "collecting") {
        throw new HttpsError("failed-precondition", "Pool is not in collecting status");
      }

      // Validate user is a participant
      const allParticipants = [pool.organizerId, ...pool.inviteeIds];
      if (!allParticipants.includes(userId)) {
        throw new HttpsError("permission-denied", "You are not a participant in this pool");
      }

      // Validate withdrawal amount against user's contribution total
      const userContrib = pool.contributions?.[userId];
      const userContribTotal = userContrib?.totalAmount || 0;

      if (userContribTotal <= 0) {
        throw new HttpsError("failed-precondition", "You have no contributions to withdraw");
      }

      if (amount > userContribTotal) {
        throw new HttpsError(
          "invalid-argument",
          `Withdrawal amount (${amount}) exceeds your contribution total (${userContribTotal})`
        );
      }

      // Auto-approve: update pool balances
      const newUserTotal = userContribTotal - amount;
      const newContributorCount = newUserTotal === 0
        ? Math.max((pool.contributorCount || 1) - 1, 0)
        : pool.contributorCount;

      tx.update(poolRef, {
        [`contributions.${userId}.totalAmount`]: newUserTotal,
        totalAmount: admin.firestore.FieldValue.increment(-amount),
        contributorCount: newContributorCount,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        conversationId: pool.conversationId,
        inviteeIds: pool.inviteeIds,
        organizerId: pool.organizerId,
        previousTotalAmount: pool.totalAmount,
        previousUserTotal: userContribTotal,
        previousContributorCount: pool.contributorCount,
      };
    });

    // Phase 2: Ledger withdrawal
    try {
      const result = await processGroupWithdrawal(poolId, userId, amount, withdrawTxId);

      if (!result.success) {
        // Rollback pool balances
        await poolRef.update({
          [`contributions.${userId}.totalAmount`]: txResult.previousUserTotal,
          totalAmount: txResult.previousTotalAmount,
          contributorCount: txResult.previousContributorCount,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        throw new HttpsError("internal", result.error || "Failed to process withdrawal");
      }
    } catch (e) {
      if (e instanceof HttpsError) throw e;
      await poolRef.update({
        [`contributions.${userId}.totalAmount`]: txResult.previousUserTotal,
        totalAmount: txResult.previousTotalAmount,
        contributorCount: txResult.previousContributorCount,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      logger.error("Pool withdrawal ledger error:", e);
      throw new HttpsError("internal", "Failed to process withdrawal");
    }

    // Phase 3: Side effects
    const profile = await getUserProfile(userId);
    const displayName = profile.displayName || "A member";

    await postSystemMessage(
      txResult.conversationId,
      `${displayName} withdrew ${amount} tokens`,
      "pool_withdrawal",
      { poolId, userId, amount }
    );

    // FCM to organizer (if not the withdrawer)
    if (txResult.organizerId !== userId) {
      const fcmTokens = await getFcmTokens([txResult.organizerId]);
      for (const token of fcmTokens) {
        await sendFcmNotification(
          token,
          "Pool withdrawal",
          `${displayName} withdrew ${amount} tokens`,
          { type: "pool_withdrawal", poolId, conversationId: txResult.conversationId }
        );
      }
    }

    logger.info(`Pool withdrawal: ${poolId}, ${amount} tokens by ${userId}`);

    const poolDoc = await poolRef.get();
    return { success: true, autoApproved: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// CANCEL POOL
// ============================================================================

/**
 * Cancel a pool and refund all contributions.
 *
 * Only the organizer can cancel while pool is in 'collecting' status.
 */
export const cancelPool = onCall(
  { labels: { area: "pools" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "cancelPool");

    const { poolId } = request.data;

    if (!poolId || typeof poolId !== "string") {
      throw new HttpsError("invalid-argument", "poolId is required");
    }

    const poolRef = db.collection("tokenPools").doc(poolId);
    const cancelTxId = `cancel_${poolId}_${Date.now()}`;

    // Phase 1: Validate and update status
    const txResult: Record<string, any> = await db.runTransaction(async (tx) => {
      const poolDoc = await tx.get(poolRef);

      if (!poolDoc.exists) {
        throw new HttpsError("not-found", "Pool not found");
      }

      const pool = poolDoc.data()!;

      if (pool.status !== "collecting") {
        throw new HttpsError("failed-precondition", "Pool can only be cancelled while collecting");
      }

      if (pool.organizerId !== userId) {
        throw new HttpsError("permission-denied", "Only the organizer can cancel the pool");
      }

      tx.update(poolRef, {
        status: "cancelled",
        cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        conversationId: pool.conversationId,
        totalAmount: pool.totalAmount,
        contributions: pool.contributions || {},
        inviteeIds: pool.inviteeIds,
      };
    });

    // Phase 2: Refund all contributions (if any)
    if (txResult.totalAmount > 0) {
      const refundPayouts: Array<{ memberId: string; amount: number }> = [];
      for (const [uid, contrib] of Object.entries(txResult.contributions)) {
        const c = contrib as { totalAmount: number };
        if (c.totalAmount > 0) {
          refundPayouts.push({ memberId: uid, amount: c.totalAmount });
        }
      }

      if (refundPayouts.length > 0) {
        try {
          const refundResult = await processGroupPayout(poolId, refundPayouts, cancelTxId);
          if (!refundResult.success) {
            // Rollback status
            await poolRef.update({
              status: "collecting",
              cancelledAt: null,
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
            throw new HttpsError("internal", refundResult.error || "Failed to refund contributions");
          }
        } catch (e) {
          if (e instanceof HttpsError) throw e;
          await poolRef.update({
            status: "collecting",
            cancelledAt: null,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          logger.error("Cancel pool refund error:", e);
          throw new HttpsError("internal", "Failed to refund contributions");
        }
      }
    }

    // Phase 3: Side effects
    const refundMsg = txResult.totalAmount > 0
      ? ` ${txResult.totalAmount} tokens refunded.`
      : "";
    await postSystemMessage(
      txResult.conversationId,
      `Collection cancelled.${refundMsg}`,
      "pool_cancelled",
      { poolId }
    );

    // FCM to participants
    const fcmTokens = await getFcmTokens(txResult.inviteeIds);
    for (const token of fcmTokens) {
      await sendFcmNotification(
        token,
        "Collection cancelled",
        `The collection has been cancelled.${refundMsg}`,
        { type: "pool_cancelled", poolId, conversationId: txResult.conversationId }
      );
    }

    logger.info(`Pool cancelled: ${poolId}, refunded ${txResult.totalAmount} tokens`);

    const poolDoc = await poolRef.get();
    return { success: true, pool: { ...poolDoc.data(), id: poolId } };
  }
);

// ============================================================================
// EXPIRE TOKEN POOLS (scheduled, hourly)
// ============================================================================

/**
 * Expire token pools that have passed their expiry date.
 *
 * - 'collecting' pools (30-day window): refund all contributions
 * - 'sent' pools (7-day gift claim): mark expired (tokens already with recipient)
 */
export const expireTokenPools = onSchedule(
  {
    schedule: "0 * * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 300,
    memory: "512MiB",
    labels: { area: "pools" },
  },
  async () => {
    const now = admin.firestore.Timestamp.now();

    // Query pools that need expiring
    const expiredSnap = await db
      .collection("tokenPools")
      .where("expiresAt", "<=", now)
      .get();

    if (expiredSnap.empty) {
      logger.info("No expired token pools found");
      return;
    }

    let processedCount = 0;
    let errorCount = 0;

    for (const doc of expiredSnap.docs) {
      const pool = doc.data();
      const pId = doc.id;

      // Skip already-terminal pools
      if (["completed", "cancelled", "expired"].includes(pool.status)) {
        continue;
      }

      try {
        if (pool.status === "collecting") {
          // 30-day collection window expired — refund all
          const contributions = pool.contributions || {};
          const refundPayouts: Array<{ memberId: string; amount: number }> = [];

          for (const [uid, contrib] of Object.entries(contributions)) {
            const c = contrib as { totalAmount: number };
            if (c.totalAmount > 0) {
              refundPayouts.push({ memberId: uid, amount: c.totalAmount });
            }
          }

          if (refundPayouts.length > 0) {
            const expireTxId = `expire_${pId}_${Date.now()}`;
            const refundResult = await processGroupPayout(pId, refundPayouts, expireTxId);
            if (!refundResult.success) {
              logger.error(`Failed to refund pool ${pId}: ${refundResult.error}`);
              errorCount++;
              continue;
            }
          }

          await doc.ref.update({
            status: "expired",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });

          // System message
          const refundMsg = pool.totalAmount > 0
            ? ` ${pool.totalAmount} tokens refunded.`
            : "";
          await postSystemMessage(
            pool.conversationId,
            `Collection expired.${refundMsg}`,
            "pool_expired",
            { poolId: pId }
          );

        } else if (pool.status === "sent") {
          // 7-day gift claim expired — tokens already with recipient, no refund
          await doc.ref.update({
            status: "expired",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });

          // Update message embed
          if (pool.giftConversationId && pool.giftMessageId) {
            await db
              .collection("conversations")
              .doc(pool.giftConversationId)
              .collection("messages")
              .doc(pool.giftMessageId)
              .update({ "groupGift.status": "expired" });
          }

          await postSystemMessage(
            pool.conversationId,
            "The Group Sasaza expired. Tokens were already transferred to the recipient.",
            "pool_expired",
            { poolId: pId }
          );
        }

        processedCount++;
      } catch (e) {
        logger.error(`Error expiring pool ${pId}:`, e);
        errorCount++;
      }
    }

    logger.info(`Token pool expiry: processed ${processedCount}, errors ${errorCount}`);
  }
);

// ============================================================================
// SEND POOL EXPIRY REMINDERS (scheduled, daily 10 AM SAST)
// ============================================================================

/**
 * Send reminders for pools expiring within 3 days.
 */
export const sendPoolExpiryReminders = onSchedule(
  {
    schedule: "0 10 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "pools" },
  },
  async () => {
    const threeDaysFromNow = admin.firestore.Timestamp.fromDate(
      new Date(Date.now() + 3 * 24 * 60 * 60 * 1000)
    );
    const now = admin.firestore.Timestamp.now();

    const poolsSnap = await db
      .collection("tokenPools")
      .where("status", "==", "collecting")
      .where("expiresAt", "<=", threeDaysFromNow)
      .where("expiresAt", ">", now)
      .where("reminderSent", "==", false)
      .get();

    if (poolsSnap.empty) {
      logger.info("No pool expiry reminders to send");
      return;
    }

    let sentCount = 0;
    for (const doc of poolsSnap.docs) {
      const pool = doc.data();
      try {
        const organizerToken = await getFcmToken(pool.organizerId);
        if (organizerToken) {
          await sendFcmNotification(
            organizerToken,
            "Collection expiring soon!",
            `Your "${pool.title}" collection expires in 3 days. Send it or it will expire.`,
            {
              type: "pool_expiry_reminder",
              poolId: doc.id,
              conversationId: pool.conversationId,
            }
          );
        }

        await doc.ref.update({ reminderSent: true });
        sentCount++;
      } catch (e) {
        logger.error(`Error sending reminder for pool ${doc.id}:`, e);
      }
    }

    logger.info(`Pool expiry reminders sent: ${sentCount}`);
  }
);
