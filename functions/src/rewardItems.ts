/**
 * Reward Item Management Cloud Functions
 *
 * Handles bulk import, user queries, code decryption, redemption, and revocation
 * of non-fungible reward items (QR codes, voucher codes, etc.).
 */

import * as functions from "firebase-functions";
import { requireAdminPermission, logAdminAction } from "./adminAuth";
import * as admin from "firebase-admin";
import { requireAppCheck, checkRateLimit } from "./security";
import { encryptCode, decryptCode, hashCode } from "./encryption";

const db = admin.firestore();


// ============================================================================
// BULK IMPORT REWARD ITEMS
// ============================================================================

/**
 * Import reward codes in bulk for a campaign.
 * Encrypts each code, hashes for uniqueness, and creates rewardItem docs.
 * Max 500 codes per call.
 */
export const importRewardItems = functions.https.onCall(
  async (
    data: {
      campaignId: string;
      codes: Array<{
        code: string;
        metadata?: Record<string, unknown>;
      }>;
    },
    context
  ) => {
    requireAppCheck(context, "importRewardItems");
    const adminCtx = await requireAdminPermission(context, "rewards:importItems", "importRewardItems");

    const { campaignId, codes } = data;

    if (!campaignId || !codes || !Array.isArray(codes) || codes.length === 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "campaignId and a non-empty codes array are required"
      );
    }

    if (codes.length > 500) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Maximum 500 codes per import call"
      );
    }

    // Validate campaign exists and is not deleted
    const campaignRef = db.collection("rewardCampaigns").doc(campaignId);
    const campaignDoc = await campaignRef.get();

    if (!campaignDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Campaign not found");
    }
    const campaign = campaignDoc.data()!;
    if (campaign.isDeleted === true) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Cannot import items into a deleted campaign"
      );
    }

    // #19 — Check campaign status (not just isDeleted)
    if (!["draft", "active", "paused"].includes(campaign.status)) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Cannot import items into a ${campaign.status} campaign`
      );
    }

    // Hash all codes first to check for duplicates
    const codeHashes = codes.map((c) => ({
      code: c.code,
      hash: hashCode(c.code),
      metadata: c.metadata || {},
    }));

    // Check for duplicates within the import batch
    const hashSet = new Set<string>();
    const batchDuplicates: string[] = [];
    for (const item of codeHashes) {
      if (hashSet.has(item.hash)) {
        batchDuplicates.push(item.code.substring(0, 4) + "...");
      }
      hashSet.add(item.hash);
    }
    if (batchDuplicates.length > 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Duplicate codes found within import batch: ${batchDuplicates.length} duplicates`
      );
    }

    // Check for existing codes in Firestore (by hash)
    const existingHashes = new Set<string>();
    const allHashes = codeHashes.map((c) => c.hash);

    // #7 — Scope dedup query to this campaign (same code CAN exist in different campaigns)
    // Firestore IN query supports max 30 values, so batch the checks
    for (let i = 0; i < allHashes.length; i += 30) {
      const batch = allHashes.slice(i, i + 30);
      const existing = await db
        .collection("rewardItems")
        .where("campaignId", "==", campaignId)
        .where("codeHash", "in", batch)
        .get();
      existing.docs.forEach((doc) => {
        existingHashes.add(doc.data().codeHash);
      });
    }

    const newCodes = codeHashes.filter((c) => !existingHashes.has(c.hash));
    const skippedCount = codeHashes.length - newCodes.length;

    if (newCodes.length === 0) {
      return {
        success: true,
        imported: 0,
        skipped: skippedCount,
        message: "All codes already exist",
      };
    }

    // Batch write new items (Firestore batch max 500)
    const now = admin.firestore.FieldValue.serverTimestamp();
    const writeBatch = db.batch();
    const activityBatch = db.batch();

    for (const item of newCodes) {
      const { encrypted, iv } = encryptCode(item.code);

      const itemRef = db.collection("rewardItems").doc();
      writeBatch.set(itemRef, {
        id: itemRef.id,
        campaignId,
        codeValueEncrypted: encrypted,
        codeIv: iv,
        codeHash: item.hash,
        status: "available",
        allocatedToUserId: null,
        allocatedAt: null,
        redeemedAt: null,
        expiresAt: null,
        redemptionLocation: null,
        metadata: item.metadata,
        createdAt: now,
        updatedAt: now,
      });

      // Activity log entry
      const logRef = db.collection("rewardActivityLog").doc();
      activityBatch.set(logRef, {
        id: logRef.id,
        itemId: itemRef.id,
        campaignId,
        userId: null,
        action: "imported",
        previousStatus: null,
        newStatus: "available",
        performedBy: `admin:${context.auth!.uid}`,
        notes: null,
        metadata: item.metadata,
        createdAt: now,
      });
    }

    // Campaign counters (totalQuantity, remainingQuantity) updated by onRewardItemWritten trigger

    await writeBatch.commit();
    await activityBatch.commit();

    logAdminAction(adminCtx.uid, "importRewardItems", "success", { campaignId, imported: newCodes.length, skipped: skippedCount }).catch(() => {});

    return {
      success: true,
      imported: newCodes.length,
      skipped: skippedCount,
    };
  }
);

// ============================================================================
// GET USER REWARD ITEMS
// ============================================================================

/**
 * Get all reward items allocated to the calling user.
 * Returns items WITHOUT decrypted code values (use getRewardItemDetail for that).
 */
export const getUserRewardItems = functions.https.onCall(
  async (data: { status?: string; limit?: number; startAfter?: number; startAfterId?: string }, context) => {
    requireAppCheck(context, "getUserRewardItems");

    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = context.auth.uid;
    // #7 — Add pagination (max 50 per page)
    const pageLimit = Math.min(data.limit || 20, 50);

    let query: FirebaseFirestore.Query = db
      .collection("rewardItems")
      .where("allocatedToUserId", "==", userId);

    if (data.status) {
      query = query.where("status", "==", data.status);
    }

    query = query.orderBy("allocatedAt", "desc").limit(pageLimit);

    // #2 — Fix pagination: use composite cursor (allocatedAt + docId) to avoid
    // skipping items with identical allocatedAt timestamps
    if (data.startAfter && data.startAfterId) {
      const cursorTimestamp = admin.firestore.Timestamp.fromMillis(data.startAfter);
      const cursorDoc = await db.collection("rewardItems").doc(data.startAfterId).get();
      if (cursorDoc.exists) {
        query = query.startAfter(cursorDoc);
      } else {
        // Fallback to timestamp-only cursor if doc no longer exists
        query = query.startAfter(cursorTimestamp);
      }
    } else if (data.startAfter) {
      // Legacy: timestamp-only cursor for backward compatibility
      query = query.startAfter(
        admin.firestore.Timestamp.fromMillis(data.startAfter)
      );
    }

    const snapshot = await query.get();

    // Batch-fetch campaign data for enrichment
    const campaignIds = [
      ...new Set(snapshot.docs.map((d) => d.data().campaignId)),
    ];
    const campaignMap = new Map<string, FirebaseFirestore.DocumentData>();
    for (const cId of campaignIds) {
      const cDoc = await db.collection("rewardCampaigns").doc(cId).get();
      if (cDoc.exists) campaignMap.set(cId, cDoc.data()!);
    }

    const items = snapshot.docs.map((doc) => {
      const d = doc.data();
      const campaign = campaignMap.get(d.campaignId);
      return {
        id: d.id,
        campaignId: d.campaignId,
        campaignName: campaign?.name || null,
        clientName: campaign?.clientName || null,
        clientAvatarImage: campaign?.clientAvatarImage || null,
        clientAvatarColor: campaign?.clientAvatarColor || null,
        rewardType: campaign?.rewardType || null,
        status: d.status,
        allocatedAt: d.allocatedAt?.toDate?.()?.toISOString() || null,
        redeemedAt: d.redeemedAt?.toDate?.()?.toISOString() || null,
        expiresAt: d.expiresAt?.toDate?.()?.toISOString() || null,
        campaignMetadata: {
          redemption_instructions:
            campaign?.metadata?.redemption_instructions || null,
          terms_and_conditions:
            campaign?.metadata?.terms_and_conditions || null,
          brand_colour: campaign?.metadata?.brand_colour || null,
        },
        itemMetadata: d.metadata || {},
      };
    });

    // Return lastDocId for composite cursor pagination
    const lastDoc = snapshot.docs[snapshot.docs.length - 1];
    return {
      items,
      hasMore: snapshot.size === pageLimit,
      lastAllocatedAt: lastDoc?.data()?.allocatedAt?.toMillis?.() || null,
      lastDocId: lastDoc?.id || null,
    };
  }
);

// ============================================================================
// GET REWARD ITEM DETAIL (with decrypted code)
// ============================================================================

/**
 * Get a single reward item WITH the decrypted code value.
 * Only accessible by the item's allocated user.
 * Rate-limited to 10 calls per minute per user.
 */
export const getRewardItemDetail = functions.https.onCall(
  async (data: { itemId: string }, context) => {
    requireAppCheck(context, "getRewardItemDetail");

    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const { itemId } = data;
    if (!itemId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "itemId is required"
      );
    }

    const userId = context.auth.uid;

    // Rate limiting: max 10 per minute
    const rateLimitRef = db
      .collection("rateLimits")
      .doc(`${userId}_rewardDetail`);
    const rateLimitDoc = await rateLimitRef.get();
    const now = Date.now();

    if (rateLimitDoc.exists) {
      const rlData = rateLimitDoc.data()!;
      const windowStart = rlData.windowStart || 0;
      const count = rlData.count || 0;

      if (now - windowStart < 60000 && count >= 10) {
        throw new functions.https.HttpsError(
          "resource-exhausted",
          "Rate limit exceeded. Try again in a minute."
        );
      }

      if (now - windowStart >= 60000) {
        // Reset window
        await rateLimitRef.set({ windowStart: now, count: 1 });
      } else {
        await rateLimitRef.update({
          count: admin.firestore.FieldValue.increment(1),
        });
      }
    } else {
      await rateLimitRef.set({ windowStart: now, count: 1 });
    }

    // Fetch item
    const itemDoc = await db.collection("rewardItems").doc(itemId).get();
    if (!itemDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Reward item not found");
    }

    const item = itemDoc.data()!;

    // Verify ownership
    if (item.allocatedToUserId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You do not own this reward item"
      );
    }

    // Decrypt code
    let codeValue: string | null = null;
    if (item.codeValueEncrypted && item.codeIv) {
      try {
        codeValue = decryptCode(item.codeValueEncrypted, item.codeIv);
      } catch (err) {
        functions.logger.error("Failed to decrypt reward code", {
          itemId,
          error: err,
        });
        throw new functions.https.HttpsError(
          "internal",
          "Failed to decrypt code"
        );
      }
    }

    // Fetch campaign for enrichment
    const campaignDoc = await db
      .collection("rewardCampaigns")
      .doc(item.campaignId)
      .get();
    const campaign = campaignDoc.data();

    return {
      item: {
        id: item.id,
        campaignId: item.campaignId,
        campaignName: campaign?.name || null,
        clientName: campaign?.clientName || null,
        clientAvatarImage: campaign?.clientAvatarImage || null,
        clientAvatarColor: campaign?.clientAvatarColor || null,
        rewardType: campaign?.rewardType || null,
        status: item.status,
        codeValue,
        allocatedAt: item.allocatedAt?.toDate?.()?.toISOString() || null,
        redeemedAt: item.redeemedAt?.toDate?.()?.toISOString() || null,
        expiresAt: item.expiresAt?.toDate?.()?.toISOString() || null,
        redemptionLocation: item.redemptionLocation || null,
        campaignMetadata: campaign?.metadata || {},
        itemMetadata: item.metadata || {},
      },
    };
  }
);

// ============================================================================
// REDEEM REWARD ITEM
// ============================================================================

/**
 * Mark a reward item as redeemed (used) by the user.
 * Transitions: allocated → redeemed.
 */
export const redeemRewardItem = functions.https.onCall(
  async (
    data: { itemId: string; location?: string },
    context
  ) => {
    requireAppCheck(context, "redeemRewardItem");

    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const { itemId, location } = data;
    if (!itemId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "itemId is required"
      );
    }

    const userId = context.auth.uid;

    // Rate limit check before transaction
    const rateCheck = await checkRateLimit(userId, "reward_redeem");
    if (!rateCheck.allowed) {
      throw new functions.https.HttpsError(
        "resource-exhausted",
        rateCheck.message || "Rate limit exceeded. Try again later."
      );
    }

    const itemRef = db.collection("rewardItems").doc(itemId);

    const result = await db.runTransaction(async (txn) => {
      const itemDoc = await txn.get(itemRef);
      if (!itemDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Reward item not found"
        );
      }

      const item = itemDoc.data()!;

      if (item.allocatedToUserId !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You do not own this reward item"
        );
      }

      if (item.status !== "allocated") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          `Item cannot be redeemed (current status: ${item.status})`
        );
      }

      // #16 — Check if campaign is deleted before allowing redemption
      const campaignDoc = await txn.get(
        db.collection("rewardCampaigns").doc(item.campaignId)
      );
      if (!campaignDoc.exists || campaignDoc.data()?.isDeleted === true) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "This reward campaign is no longer available"
        );
      }

      // Auto-expire check: if item has expired, mark it and reject
      if (item.expiresAt && item.expiresAt.toDate() < new Date()) {
        const expireNow = admin.firestore.FieldValue.serverTimestamp();
        txn.update(itemRef, {
          status: "expired",
          updatedAt: expireNow,
        });
        throw new functions.https.HttpsError(
          "failed-precondition",
          "This reward has expired"
        );
      }

      const now = admin.firestore.FieldValue.serverTimestamp();

      txn.update(itemRef, {
        status: "redeemed",
        redeemedAt: now,
        redemptionLocation: location || null,
        updatedAt: now,
      });

      // Campaign counter update handled by onRewardItemWritten trigger

      return { campaignId: item.campaignId };
    });

    // Activity log (outside transaction)
    await db.collection("rewardActivityLog").add({
      itemId,
      campaignId: result.campaignId,
      userId,
      action: "redeemed",
      previousStatus: "allocated",
      newStatus: "redeemed",
      performedBy: `user:${userId}`,
      notes: location ? `Location: ${location}` : null,
      metadata: {},
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);

// ============================================================================
// REVOKE REWARD ITEM (admin)
// ============================================================================

/**
 * Revoke a reward item from a user. Admin-only.
 * Transitions: allocated → revoked. Increments campaign remainingQuantity.
 */
export const revokeRewardItem = functions.https.onCall(
  async (
    data: { itemId: string; reason: string },
    context
  ) => {
    requireAppCheck(context, "revokeRewardItem");
    const adminCtx = await requireAdminPermission(context, "rewards:revokeItem", "revokeRewardItem");

    const { itemId, reason } = data;
    if (!itemId || !reason) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "itemId and reason are required"
      );
    }

    const itemRef = db.collection("rewardItems").doc(itemId);

    const result = await db.runTransaction(async (txn) => {
      const itemDoc = await txn.get(itemRef);
      if (!itemDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Reward item not found"
        );
      }

      const item = itemDoc.data()!;

      if (item.status !== "allocated") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          `Item cannot be revoked (current status: ${item.status})`
        );
      }

      const now = admin.firestore.FieldValue.serverTimestamp();

      txn.update(itemRef, {
        status: "revoked",
        updatedAt: now,
      });

      // Campaign counter update handled by onRewardItemWritten trigger

      return {
        campaignId: item.campaignId,
        userId: item.allocatedToUserId,
      };
    });

    // Activity log (outside transaction)
    await db.collection("rewardActivityLog").add({
      itemId,
      campaignId: result.campaignId,
      userId: result.userId,
      action: "revoked",
      previousStatus: "allocated",
      newStatus: "revoked",
      performedBy: `admin:${context.auth!.uid}`,
      notes: reason,
      metadata: {},
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    logAdminAction(adminCtx.uid, "revokeRewardItem", "success", { itemId, reason, campaignId: result.campaignId, userId: result.userId }).catch(() => {});

    return { success: true };
  }
);

// ============================================================================
// GET ADMIN REWARD ITEMS (for campaign detail view)
// ============================================================================

/**
 * List reward items for a specific campaign. Admin-only.
 */
export const getAdminRewardItems = functions.https.onCall(
  async (
    data: {
      campaignId: string;
      status?: string;
      limit?: number;
    },
    context
  ) => {
    requireAppCheck(context, "getAdminRewardItems");
    await requireAdminPermission(context, "rewards:getItems", "getAdminRewardItems");

    const { campaignId, status, limit: queryLimit } = data;

    if (!campaignId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "campaignId is required"
      );
    }

    let query: FirebaseFirestore.Query = db
      .collection("rewardItems")
      .where("campaignId", "==", campaignId);

    if (status) {
      query = query.where("status", "==", status);
    }

    query = query.limit(queryLimit || 100);

    const snapshot = await query.get();
    const items = snapshot.docs.map((doc) => {
      const d = doc.data();
      return {
        id: d.id,
        status: d.status,
        allocatedToUserId: d.allocatedToUserId,
        allocatedAt: d.allocatedAt?.toDate?.()?.toISOString() || null,
        redeemedAt: d.redeemedAt?.toDate?.()?.toISOString() || null,
        expiresAt: d.expiresAt?.toDate?.()?.toISOString() || null,
        metadata: d.metadata || {},
        createdAt: d.createdAt?.toDate?.()?.toISOString() || null,
      };
    });

    return { items };
  }
);

// updateRewardConsent removed — POPIA consent gate no longer needed.
// Rewards are now allocated via the escrow pattern (reserve/confirm/release)
// without requiring explicit consent.
