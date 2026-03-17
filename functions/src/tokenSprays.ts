/**
 * Token Sprays Cloud Functions
 *
 * Community celebration feature — members contribute tokens to celebrate
 * another member. Uses a collective pot pattern where contributions are
 * transferred directly via the ledger.
 *
 * Collection: /tokenSprays/{sprayId}
 *
 * Lifecycle: active → closed → claimed | expired
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processP2PTransfer,
  validateMainWalletBalance,
} from "./ledger";

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

async function requireCommunityMember(communityId: string, userId: string) {
  const communityDoc = await db.collection("communities").doc(communityId).get();
  if (!communityDoc.exists) {
    throw new HttpsError("not-found", "Community not found");
  }
  const community = communityDoc.data()!;
  const memberIds: string[] = community.memberIds || [];
  if (!memberIds.includes(userId)) {
    throw new HttpsError("permission-denied", "You are not a member of this community");
  }
  return community;
}

const VALID_OCCASIONS = ["new_job", "birthday", "graduation", "new_baby", "wedding", "achievement", "custom"];
const MIN_CONTRIBUTION = 10; // 10 tokens minimum
const SPRAY_EXPIRY_HOURS = 24;

function getOccasionDisplayText(occasion: string): string {
  switch (occasion) {
    case "new_job": return "New Job";
    case "birthday": return "Birthday";
    case "graduation": return "Graduation";
    case "new_baby": return "New Baby";
    case "wedding": return "Wedding";
    case "achievement": return "Achievement";
    case "custom": return "Celebration";
    default: return "Celebration";
  }
}

// ============================================================================
// CREATE TOKEN SPRAY
// ============================================================================

/**
 * Create a new token spray celebration in a community.
 * The creator chooses a recipient and occasion. No upfront payment —
 * contributions come from community members.
 */
export const createTokenSpray = onCall({ labels: { area: "gifts" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "createTokenSpray");

  const { communityId, recipientId, occasion, message, targetAmount } = request.data;

  // Validate inputs
  if (!communityId || typeof communityId !== "string") {
    throw new HttpsError("invalid-argument", "communityId is required");
  }
  if (!recipientId || typeof recipientId !== "string") {
    throw new HttpsError("invalid-argument", "recipientId is required");
  }
  if (!occasion || !VALID_OCCASIONS.includes(occasion)) {
    throw new HttpsError("invalid-argument", `Invalid occasion. Must be one of: ${VALID_OCCASIONS.join(", ")}`);
  }
  if (!message || typeof message !== "string" || message.trim().length === 0) {
    throw new HttpsError("invalid-argument", "Celebration message is required");
  }
  if (targetAmount !== undefined && targetAmount !== null && (typeof targetAmount !== "number" || targetAmount < MIN_CONTRIBUTION)) {
    throw new HttpsError("invalid-argument", `Target amount must be at least ${MIN_CONTRIBUTION} tokens`);
  }

  // Validate community membership for both creator and recipient
  const community = await requireCommunityMember(communityId, userId);
  const memberIds: string[] = community.memberIds || [];
  if (!memberIds.includes(recipientId)) {
    throw new HttpsError("invalid-argument", "Recipient must be a member of the community");
  }

  // Get user profiles
  const [creator, recipient] = await Promise.all([
    getUserProfile(userId),
    getUserProfile(recipientId),
  ]);

  // Generate IDs
  const sprayRef = db.collection("tokenSprays").doc();
  const sprayId = sprayRef.id;
  const msgRef = db.collection("communities").doc(communityId).collection("messages").doc();

  const expiresAt = new Date();
  expiresAt.setHours(expiresAt.getHours() + SPRAY_EXPIRY_HOURS);

  const occasionText = getOccasionDisplayText(occasion);

  // Construct spray document
  const sprayDoc = {
    id: sprayId,
    communityId,
    communityName: community.name || "Community",
    messageId: msgRef.id,
    creatorId: userId,
    creatorName: creator.displayName || "Unknown",
    recipientId,
    recipientName: recipient.displayName || "Unknown",
    occasion,
    occasionText,
    message: message.trim().substring(0, 200),
    targetAmount: targetAmount || null,
    currentTotal: 0,
    contributions: {},
    contributorCount: 0,
    topContributors: [],
    status: "active",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    closedAt: null,
    claimedAt: null,
    expiresAt: admin.firestore.Timestamp.fromDate(expiresAt),
    debitTransactionIds: [],
    creditTransactionId: null,
  };

  // Construct the spray message
  const sprayMessage: Record<string, unknown> = {
    id: msgRef.id,
    communityId,
    senderId: userId,
    senderName: creator.displayName || "Unknown",
    senderAvatarUrl: creator.avatarUrl || creator.profilePicThumbUrl || null,
    type: "tokenSpray",
    status: "sent",
    textContent: null,
    tokenSpray: {
      sprayId,
      recipientId,
      recipientName: recipient.displayName || "Unknown",
      occasion,
      currentTotal: 0,
      contributorCount: 0,
      status: "active",
      targetAmount: targetAmount || null,
      expiresAt: expiresAt.toISOString(),
    },
    reactions: {},
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    deletedFor: [],
    deletedForEveryone: false,
  };

  // Update community lastMessage + unread counts
  const parentUpdate: Record<string, unknown> = {
    lastMessage: {
      text: `Started a token spray for ${recipient.displayName || "a member"}!`,
      senderId: userId,
      senderName: creator.displayName || "Unknown",
      type: "tokenSpray",
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    },
    lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
  };
  for (const memberId of memberIds) {
    if (memberId !== userId) {
      parentUpdate[`unreadCounts.${memberId}`] = admin.firestore.FieldValue.increment(1);
    }
  }

  // Batch write
  const batch = db.batch();
  batch.set(sprayRef, sprayDoc);
  batch.set(msgRef, sprayMessage);
  batch.update(db.collection("communities").doc(communityId), parentUpdate);
  await batch.commit();

  return {
    id: sprayId,
    communityId,
    communityName: community.name || "Community",
    messageId: msgRef.id,
    creatorId: userId,
    creatorName: creator.displayName || "Unknown",
    recipientId,
    recipientName: recipient.displayName || "Unknown",
    occasion,
    occasionText,
    message: message.trim().substring(0, 200),
    targetAmount: targetAmount || null,
    currentTotal: 0,
    contributions: {},
    contributorCount: 0,
    topContributors: [],
    status: "active",
    createdAt: new Date().toISOString(),
    closedAt: null,
    claimedAt: null,
    expiresAt: expiresAt.toISOString(),
  };
});

// ============================================================================
// CONTRIBUTE TO SPRAY
// ============================================================================

/**
 * Contribute tokens to an active spray.
 * Debits the contributor and credits the recipient directly.
 * Updates spray totals and leaderboard.
 */
export const contributeToSpray = onCall({ labels: { area: "gifts" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "contributeToSpray");
  await requirePlayIntegrity(request.data, request, "contributeToSpray", "HIGHEST");

  const { sprayId, amount, message } = request.data;

  if (!sprayId || typeof sprayId !== "string") {
    throw new HttpsError("invalid-argument", "sprayId is required");
  }
  if (!amount || typeof amount !== "number" || amount < MIN_CONTRIBUTION) {
    throw new HttpsError("invalid-argument", `Minimum contribution is ${MIN_CONTRIBUTION} tokens`);
  }

  // Get spray
  const sprayRef = db.collection("tokenSprays").doc(sprayId);
  const sprayDoc = await sprayRef.get();
  if (!sprayDoc.exists) {
    throw new HttpsError("not-found", "Spray not found");
  }
  const spray = sprayDoc.data()!;

  // Validate spray state
  if (spray.status !== "active") {
    throw new HttpsError("failed-precondition", "Spray is not active");
  }
  const expiresAt = spray.expiresAt?.toDate ? spray.expiresAt.toDate() : new Date(spray.expiresAt);
  if (new Date() > expiresAt) {
    throw new HttpsError("failed-precondition", "Spray has expired");
  }
  if (userId === spray.recipientId) {
    throw new HttpsError("permission-denied", "The recipient cannot contribute to their own spray");
  }

  // Verify community membership
  await requireCommunityMember(spray.communityId, userId);

  // Validate contributor balance (main ledger account IS the default wallet)
  await validateMainWalletBalance(userId, amount);

  // Get contributor info
  const contributor = await getUserProfile(userId);

  // Process transfer via ledger (contributor → recipient)
  const idempotencyKey = `spray:contribute:${sprayId}:${userId}:${Date.now()}`;
  const transferResult = await processP2PTransfer(
    userId,
    spray.recipientId,
    amount,
    `Token spray contribution for ${spray.recipientName}`,
    undefined, // main wallet — no sub-account needed
    undefined,
    idempotencyKey,
  );

  // Calculate new totals
  const existingContribution = spray.contributions?.[userId];
  const newAmount = (existingContribution?.amount || 0) + amount;
  const newTotal = spray.currentTotal + amount;
  const newContributorCount = existingContribution
    ? spray.contributorCount
    : spray.contributorCount + 1;

  // Update spray document
  const sprayUpdate: Record<string, unknown> = {
    [`contributions.${userId}`]: {
      amount: newAmount,
      contributedAt: admin.firestore.FieldValue.serverTimestamp(),
      displayName: contributor.displayName || "Unknown",
      message: message || existingContribution?.message || null,
    },
    currentTotal: admin.firestore.FieldValue.increment(amount),
    contributorCount: newContributorCount,
    debitTransactionIds: admin.firestore.FieldValue.arrayUnion(transferResult.journalId || ""),
  };

  // Recalculate top 5 leaderboard
  const allContributions = { ...spray.contributions };
  allContributions[userId] = {
    ...(allContributions[userId] || {}),
    amount: newAmount,
    displayName: contributor.displayName || "Unknown",
  };

  const sortedContributors = Object.entries(allContributions)
    .map(([uid, contrib]: [string, any]) => ({
      userId: uid,
      displayName: contrib.displayName || "Unknown",
      amount: contrib.amount || 0,
    }))
    .sort((a, b) => b.amount - a.amount)
    .slice(0, 5)
    .map((c, index) => ({ ...c, rank: index + 1 }));

  sprayUpdate.topContributors = sortedContributors;

  await sprayRef.update(sprayUpdate);

  // Update the spray message in community chat
  try {
    await db.collection("communities").doc(spray.communityId)
      .collection("messages").doc(spray.messageId)
      .update({
        "tokenSpray.currentTotal": newTotal,
        "tokenSpray.contributorCount": newContributorCount,
      });
  } catch (e) {
    logger.warn("Failed to update spray message:", e);
  }

  // Return updated spray data
  return {
    ...spray,
    id: sprayId,
    currentTotal: newTotal,
    contributorCount: newContributorCount,
    topContributors: sortedContributors,
    createdAt: spray.createdAt?.toDate ? spray.createdAt.toDate().toISOString() : spray.createdAt,
    expiresAt: expiresAt.toISOString(),
  };
});

// ============================================================================
// CLOSE SPRAY
// ============================================================================

/**
 * Manually close a spray. Only the creator or community admin can close.
 * Tokens have already been transferred to the recipient on each contribution.
 */
export const closeTokenSpray = onCall({ labels: { area: "gifts" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "closeTokenSpray");

  const { sprayId } = request.data;
  if (!sprayId || typeof sprayId !== "string") {
    throw new HttpsError("invalid-argument", "sprayId is required");
  }

  const sprayRef = db.collection("tokenSprays").doc(sprayId);
  const sprayDoc = await sprayRef.get();
  if (!sprayDoc.exists) {
    throw new HttpsError("not-found", "Spray not found");
  }
  const spray = sprayDoc.data()!;

  if (spray.status !== "active") {
    throw new HttpsError("failed-precondition", `Spray is already ${spray.status}`);
  }

  // Only creator or community admin can close
  const community = await requireCommunityMember(spray.communityId, userId);
  const adminIds: string[] = community.adminIds || [];
  if (spray.creatorId !== userId && !adminIds.includes(userId)) {
    throw new HttpsError("permission-denied", "Only the creator or community admin can close this spray");
  }

  // Update spray status
  await sprayRef.update({
    status: "closed",
    closedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update the message embed
  try {
    await db.collection("communities").doc(spray.communityId)
      .collection("messages").doc(spray.messageId)
      .update({ "tokenSpray.status": "closed" });
  } catch (e) {
    logger.warn("Failed to update spray message:", e);
  }

  // Post system message
  const sysMsgRef = db.collection("communities").doc(spray.communityId).collection("messages").doc();
  await sysMsgRef.set({
    id: sysMsgRef.id,
    communityId: spray.communityId,
    senderId: "system",
    senderName: "System",
    type: "system",
    status: "sent",
    textContent: `The token spray for ${spray.recipientName} has been closed! ${spray.currentTotal} tokens from ${spray.contributorCount} contributors.`,
    systemEventType: "spray_closed",
    systemEventData: { sprayId, recipientId: spray.recipientId, total: spray.currentTotal },
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    deletedFor: [],
    deletedForEveryone: false,
  });

  return {
    ...spray,
    id: sprayId,
    status: "closed",
    closedAt: new Date().toISOString(),
    createdAt: spray.createdAt?.toDate ? spray.createdAt.toDate().toISOString() : spray.createdAt,
    expiresAt: spray.expiresAt?.toDate ? spray.expiresAt.toDate().toISOString() : spray.expiresAt,
  };
});

// ============================================================================
// CLAIM SPRAY
// ============================================================================

/**
 * Recipient acknowledges the spray. Tokens were already transferred
 * on each contribution, so this is just a status update.
 */
export const claimTokenSpray = onCall({ labels: { area: "gifts" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "claimTokenSpray");

  const { sprayId } = request.data;
  if (!sprayId || typeof sprayId !== "string") {
    throw new HttpsError("invalid-argument", "sprayId is required");
  }

  const sprayRef = db.collection("tokenSprays").doc(sprayId);
  const sprayDoc = await sprayRef.get();
  if (!sprayDoc.exists) {
    throw new HttpsError("not-found", "Spray not found");
  }
  const spray = sprayDoc.data()!;

  if (spray.recipientId !== userId) {
    throw new HttpsError("permission-denied", "Only the recipient can claim this spray");
  }

  if (spray.status !== "closed" && spray.status !== "active") {
    throw new HttpsError("failed-precondition", `Spray cannot be claimed — status is ${spray.status}`);
  }

  await sprayRef.update({
    status: "claimed",
    claimedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update the message embed
  try {
    await db.collection("communities").doc(spray.communityId)
      .collection("messages").doc(spray.messageId)
      .update({ "tokenSpray.status": "claimed" });
  } catch (e) {
    logger.warn("Failed to update spray message:", e);
  }

  return {
    ...spray,
    id: sprayId,
    status: "claimed",
    claimedAt: new Date().toISOString(),
    createdAt: spray.createdAt?.toDate ? spray.createdAt.toDate().toISOString() : spray.createdAt,
    expiresAt: spray.expiresAt?.toDate ? spray.expiresAt.toDate().toISOString() : spray.expiresAt,
  };
});

// ============================================================================
// SCHEDULED: AUTO-CLOSE EXPIRED SPRAYS
// ============================================================================

/**
 * Hourly job: find active sprays past their expiresAt and auto-close them.
 * Tokens have already been transferred to the recipient, so just update status.
 */
export const closeExpiredSprays = onSchedule(
  { schedule: "0 * * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "gifts" } },
  async () => {
    const now = admin.firestore.Timestamp.now();

    const expiredSprays = await db.collection("tokenSprays")
      .where("status", "==", "active")
      .where("expiresAt", "<", now)
      .limit(100)
      .get();

    if (expiredSprays.empty) {
      logger.info("No sprays to auto-close");
      return;
    }

    logger.info(`Auto-closing ${expiredSprays.size} expired sprays`);

    for (const doc of expiredSprays.docs) {
      const spray = doc.data();

      const batch = db.batch();

      // Update spray status
      batch.update(doc.ref, {
        status: "closed",
        closedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Update message embed
      if (spray.messageId) {
        const msgRef = db.collection("communities").doc(spray.communityId)
          .collection("messages").doc(spray.messageId);
        batch.update(msgRef, { "tokenSpray.status": "closed" });
      }

      // Post system message
      const sysMsgRef = db.collection("communities").doc(spray.communityId).collection("messages").doc();
      batch.set(sysMsgRef, {
        id: sysMsgRef.id,
        communityId: spray.communityId,
        senderId: "system",
        senderName: "System",
        type: "system",
        status: "sent",
        textContent: `The token spray for ${spray.recipientName} has ended! ${spray.currentTotal} tokens from ${spray.contributorCount} contributors.`,
        systemEventType: "spray_expired",
        systemEventData: { sprayId: doc.id, recipientId: spray.recipientId, total: spray.currentTotal },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        deletedFor: [],
        deletedForEveryone: false,
      });

      await batch.commit();
    }

    logger.info(`Auto-closed ${expiredSprays.size} sprays`);
  }
);
