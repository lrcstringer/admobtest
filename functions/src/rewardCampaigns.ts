/**
 * Reward Campaign Management Cloud Functions
 *
 * CRUD operations for reward campaigns (non-fungible inventory items).
 * Admin functions require admin auth; getActiveRewardCampaigns is user-facing.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import { requireAdminPermission, logAdminAction } from "./adminAuth";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

// Valid reward types
const VALID_REWARD_TYPES = [
  "qr_code",
  "voucher_code",
  "discount_code",
  "digital_content",
] as const;

// Valid campaign statuses
const VALID_STATUSES = [
  "draft",
  "active",
  "paused",
  "exhausted",
  "expired",
  "cancelled",
] as const;

type RewardType = (typeof VALID_REWARD_TYPES)[number];
type CampaignStatus = (typeof VALID_STATUSES)[number];


// ============================================================================
// CREATE REWARD CAMPAIGN
// ============================================================================

export const createRewardCampaign = onCall(
  { labels: { area: "rewards" } },
  async (
    request
  ) => {
    requireAppCheck(request, "createRewardCampaign");
    const adminCtx = await requireAdminPermission(request, "rewards:createCampaign", "createRewardCampaign");

    const {
      clientId,
      name,
      description,
      rewardType,
      startsAt,
      endsAt,
      itemExpiresAt,
      maxPerUser,
      displayImageUrl,
      displayPriority,
      metadata,
      abTest,
    } = request.data;

    // Validate required fields
    if (!clientId || !name || !rewardType || !startsAt || !endsAt) {
      throw new HttpsError(
        "invalid-argument",
        "clientId, name, rewardType, startsAt, and endsAt are required"
      );
    }

    // Validate reward type
    if (!VALID_REWARD_TYPES.includes(rewardType as RewardType)) {
      throw new HttpsError(
        "invalid-argument",
        `Invalid rewardType. Must be one of: ${VALID_REWARD_TYPES.join(", ")}`
      );
    }

    // Validate dates
    const startsAtDate = new Date(startsAt);
    const endsAtDate = new Date(endsAt);
    if (isNaN(startsAtDate.getTime()) || isNaN(endsAtDate.getTime())) {
      throw new HttpsError(
        "invalid-argument",
        "Invalid date format for startsAt or endsAt"
      );
    }
    if (endsAtDate <= startsAtDate) {
      throw new HttpsError(
        "invalid-argument",
        "endsAt must be after startsAt"
      );
    }

    // Validate client exists and is not deleted
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (!clientDoc.exists) {
      throw new HttpsError("not-found", "Client not found");
    }
    const clientData = clientDoc.data()!;
    if (clientData.isDeleted === true) {
      throw new HttpsError(
        "failed-precondition",
        "Cannot create campaign for a deleted client"
      );
    }

    // Validate A/B test if provided
    if (abTest?.enabled && Array.isArray(abTest.variants)) {
      if (abTest.variants.length < 2 || abTest.variants.length > 4) {
        throw new HttpsError(
          "invalid-argument",
          "A/B test must have 2-4 variants"
        );
      }
      // #12 — Variant IDs must be unique
      const variantIds = abTest.variants.map((v: { id: string }) => v.id);
      if (new Set(variantIds).size !== variantIds.length) {
        throw new HttpsError(
          "invalid-argument",
          "A/B test variant IDs must be unique"
        );
      }
      const totalWeight = abTest.variants.reduce(
        (sum: number, v: { weight?: number }) => sum + (v.weight || 0),
        0
      );
      if (totalWeight !== 100) {
        throw new HttpsError(
          "invalid-argument",
          "A/B test variant weights must sum to 100"
        );
      }
    }

    // #9 — Validate maxPerUser if provided
    if (maxPerUser !== undefined && maxPerUser !== null) {
      if (typeof maxPerUser !== 'number' || maxPerUser < 1 || !Number.isInteger(maxPerUser)) {
        throw new HttpsError(
          "invalid-argument",
          "maxPerUser must be a positive integer (minimum 1)"
        );
      }
    }

    // #13 — Validate displayPriority bounds if provided
    if (displayPriority !== undefined && displayPriority !== null) {
      if (typeof displayPriority !== 'number' || displayPriority < -1000 || displayPriority > 1000) {
        throw new HttpsError(
          "invalid-argument",
          "displayPriority must be between -1000 and 1000"
        );
      }
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const campaignRef = db.collection("rewardCampaigns").doc();

    const campaignData = {
      id: campaignRef.id,
      clientId,
      clientName: clientData.displayName || clientData.companyName,
      clientAvatarImage: clientData.avatarImage || null,
      clientAvatarColor: clientData.avatarColor || null,
      name,
      description: description || null,
      rewardType,
      linkedOpportunityIds: [] as string[],
      totalQuantity: 0,
      remainingQuantity: 0,
      reservedCount: 0,
      allocatedQuantity: 0,
      redeemedQuantity: 0,
      expiredCount: 0,
      revokedCount: 0,
      maxPerUser: maxPerUser ?? 1,
      startsAt: admin.firestore.Timestamp.fromDate(startsAtDate),
      endsAt: admin.firestore.Timestamp.fromDate(endsAtDate),
      itemExpiresAt: itemExpiresAt
        ? admin.firestore.Timestamp.fromDate(new Date(itemExpiresAt))
        : null,
      displayImageUrl: displayImageUrl || null,
      displayPriority: displayPriority ?? 0,
      status: "draft" as CampaignStatus,
      metadata: metadata || {},
      abTest: abTest?.enabled
        ? { enabled: true, variants: abTest.variants }
        : { enabled: false, variants: [] },
      isDeleted: false,
      createdAt: now,
      updatedAt: now,
      createdBy: request.auth!.uid,
    };

    await campaignRef.set(campaignData);

    logAdminAction(adminCtx.uid, "createRewardCampaign", "success", { campaignId: campaignRef.id, clientId, name, rewardType }).catch(() => {});

    return {
      success: true,
      campaignId: campaignRef.id,
    };
  }
);

// ============================================================================
// UPDATE REWARD CAMPAIGN
// ============================================================================

export const updateRewardCampaign = onCall(
  { labels: { area: "rewards" } },
  async (
    request
  ) => {
    requireAppCheck(request, "updateRewardCampaign");
    const adminCtx = await requireAdminPermission(request, "rewards:updateCampaign", "updateRewardCampaign");

    const { campaignId, updates } = request.data;

    if (!campaignId) {
      throw new HttpsError(
        "invalid-argument",
        "campaignId is required"
      );
    }

    const campaignRef = db.collection("rewardCampaigns").doc(campaignId);
    const campaignDoc = await campaignRef.get();

    if (!campaignDoc.exists) {
      throw new HttpsError("not-found", "Campaign not found");
    }

    const campaign = campaignDoc.data()!;
    if (campaign.isDeleted === true) {
      throw new HttpsError(
        "failed-precondition",
        "Cannot update a deleted campaign"
      );
    }

    // #6 — rewardType is immutable after creation
    if ((updates as Record<string, unknown>).rewardType !== undefined) {
      throw new HttpsError(
        "invalid-argument",
        "rewardType cannot be changed after campaign creation"
      );
    }

    // Validate status transition (#5 — state machine enforcement)
    if (updates.status) {
      if (!VALID_STATUSES.includes(updates.status as CampaignStatus)) {
        throw new HttpsError(
          "invalid-argument",
          `Invalid status. Must be one of: ${VALID_STATUSES.join(", ")}`
        );
      }

      const VALID_TRANSITIONS: Record<string, string[]> = {
        draft: ["active"],
        active: ["paused", "cancelled"],
        paused: ["active", "cancelled"],
        cancelled: [],   // terminal
        exhausted: [],   // terminal (set by system)
        expired: [],     // terminal (set by system)
      };

      const currentStatus = campaign.status as string;
      const allowed = VALID_TRANSITIONS[currentStatus] || [];
      if (!allowed.includes(updates.status)) {
        throw new HttpsError(
          "failed-precondition",
          `Cannot transition from '${currentStatus}' to '${updates.status}'`
        );
      }

      // #18 — Guard against activating campaign with 0 items
      if (updates.status === "active" && (campaign.totalQuantity ?? 0) === 0) {
        throw new HttpsError(
          "failed-precondition",
          "Cannot activate campaign with 0 items. Import items first."
        );
      }
    }

    // Validate dates if provided
    const updateData: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    if (updates.name !== undefined) updateData.name = updates.name;
    if (updates.description !== undefined)
      updateData.description = updates.description;
    if (updates.maxPerUser !== undefined) {
      // #9 — Validate maxPerUser >= 1
      if (typeof updates.maxPerUser !== 'number' || updates.maxPerUser < 1 || !Number.isInteger(updates.maxPerUser)) {
        throw new HttpsError(
          "invalid-argument",
          "maxPerUser must be a positive integer (minimum 1)"
        );
      }
      updateData.maxPerUser = updates.maxPerUser;
    }
    if (updates.displayImageUrl !== undefined)
      updateData.displayImageUrl = updates.displayImageUrl;
    if (updates.displayPriority !== undefined) {
      // #13 — Enforce displayPriority bounds
      if (typeof updates.displayPriority !== 'number' || updates.displayPriority < -1000 || updates.displayPriority > 1000) {
        throw new HttpsError(
          "invalid-argument",
          "displayPriority must be between -1000 and 1000"
        );
      }
      updateData.displayPriority = updates.displayPriority;
    }
    if (updates.status !== undefined) updateData.status = updates.status;
    // #5 — Use FieldValue.delete() for null metadata keys so they're properly removed
    if (updates.metadata !== undefined) {
      if (updates.metadata === null) {
        updateData.metadata = admin.firestore.FieldValue.delete();
      } else {
        for (const [key, value] of Object.entries(updates.metadata)) {
          if (value === null || value === undefined) {
            updateData[`metadata.${key}`] = admin.firestore.FieldValue.delete();
          } else {
            updateData[`metadata.${key}`] = value;
          }
        }
      }
    }
    if (updates.abTest !== undefined) {
      // #11 — Block A/B test modification on active campaigns
      if (campaign.status === "active") {
        throw new HttpsError(
          "failed-precondition",
          "Cannot modify A/B test configuration on an active campaign. Pause the campaign first."
        );
      }
      if (updates.abTest.enabled && Array.isArray(updates.abTest.variants)) {
        if (updates.abTest.variants.length < 2 || updates.abTest.variants.length > 4) {
          throw new HttpsError(
            "invalid-argument",
            "A/B test requires 2-4 variants"
          );
        }
        // #12 — Variant IDs must be unique
        const variantIds = updates.abTest.variants.map((v: { id: string }) => v.id);
        if (new Set(variantIds).size !== variantIds.length) {
          throw new HttpsError(
            "invalid-argument",
            "A/B test variant IDs must be unique"
          );
        }
        const totalWeight = updates.abTest.variants.reduce(
          (sum: number, v: { weight?: number }) => sum + (v.weight || 0),
          0
        );
        if (totalWeight !== 100) {
          throw new HttpsError(
            "invalid-argument",
            "A/B test variant weights must sum to 100"
          );
        }
      }
      updateData.abTest = updates.abTest;
    }

    if (updates.startsAt) {
      const d = new Date(updates.startsAt);
      if (isNaN(d.getTime())) {
        throw new HttpsError(
          "invalid-argument",
          "Invalid startsAt date"
        );
      }
      updateData.startsAt = admin.firestore.Timestamp.fromDate(d);
    }
    if (updates.endsAt) {
      const d = new Date(updates.endsAt);
      if (isNaN(d.getTime())) {
        throw new HttpsError(
          "invalid-argument",
          "Invalid endsAt date"
        );
      }
      updateData.endsAt = admin.firestore.Timestamp.fromDate(d);
    }
    if (updates.itemExpiresAt) {
      const d = new Date(updates.itemExpiresAt);
      if (isNaN(d.getTime())) {
        throw new HttpsError(
          "invalid-argument",
          "Invalid itemExpiresAt date"
        );
      }
      updateData.itemExpiresAt = admin.firestore.Timestamp.fromDate(d);
    }

    await campaignRef.update(updateData);

    // Send push notification when campaign transitions to active
    if (
      updates.status === "active" &&
      campaign.status !== "active"
    ) {
      try {
        await notifyNewCampaign(
          campaignId,
          campaign.name,
          campaign.clientName
        );
      } catch (notifErr) {
        logger.warn("Failed to send new campaign notifications", {
          campaignId,
          error: notifErr,
        });
        // Don't fail the update for notification errors
      }
    }

    logAdminAction(adminCtx.uid, "updateRewardCampaign", "success", { campaignId, updatedFields: Object.keys(updates) }).catch(() => {});

    return { success: true };
  }
);

// ============================================================================
// NEW CAMPAIGN NOTIFICATION HELPER
// ============================================================================

/**
 * Send FCM notification to all users with tokens when a new campaign goes active.
 * Batched in groups of 500 (sendEachForMulticast limit).
 */
async function notifyNewCampaign(
  campaignId: string,
  campaignName: string,
  clientName: string
): Promise<void> {
  const usersSnapshot = await db
    .collection("users")
    .where("fcmToken", "!=", null)
    .select("fcmToken")
    .get();

  if (usersSnapshot.empty) return;

  const tokens = usersSnapshot.docs
    .map((doc) => doc.data().fcmToken as string)
    .filter(Boolean);

  // Batch in groups of 500
  for (let i = 0; i < tokens.length; i += 500) {
    const batch = tokens.slice(i, i + 500);
    try {
      await admin.messaging().sendEachForMulticast({
        tokens: batch,
        notification: {
          title: "New Reward Available!",
          body: `Complete an activity to earn ${campaignName} from ${clientName}!`,
        },
        data: {
          type: "new_reward_campaign",
          campaignId,
        },
      });
    } catch (batchErr) {
      logger.warn("FCM batch send failed", {
        batchStart: i,
        error: batchErr,
      });
    }
  }

  logger.info("New campaign notifications sent", {
    campaignId,
    totalTokens: tokens.length,
  });
}

// ============================================================================
// GET ADMIN REWARD CAMPAIGNS (with filters)
// ============================================================================

export const getAdminRewardCampaigns = onCall(
  { labels: { area: "rewards" } },
  async (
    request
  ) => {
    requireAppCheck(request, "getAdminRewardCampaigns");
    await requireAdminPermission(request, "rewards:getCampaigns", "getAdminRewardCampaigns");

    const data = request.data;

    let query: FirebaseFirestore.Query = db
      .collection("rewardCampaigns")
      .where("isDeleted", "==", false);

    if (data.clientId) {
      query = query.where("clientId", "==", data.clientId);
    }
    if (data.status) {
      query = query.where("status", "==", data.status);
    }

    query = query.orderBy("createdAt", "desc").limit(data.limit || 100);

    const snapshot = await query.get();
    const campaigns = snapshot.docs.map((doc) => {
      const d = doc.data();
      return {
        ...d,
        startsAt: d.startsAt?.toDate?.()?.toISOString() || null,
        endsAt: d.endsAt?.toDate?.()?.toISOString() || null,
        itemExpiresAt: d.itemExpiresAt?.toDate?.()?.toISOString() || null,
        createdAt: d.createdAt?.toDate?.()?.toISOString() || null,
        updatedAt: d.updatedAt?.toDate?.()?.toISOString() || null,
      };
    });

    return { campaigns };
  }
);

// ============================================================================
// GET ACTIVE REWARD CAMPAIGNS (user-facing)
// ============================================================================

export const getActiveRewardCampaigns = onCall(
  { labels: { area: "rewards" } },
  async (request) => {
    requireAppCheck(request, "getActiveRewardCampaigns");

    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = request.auth.uid;
    const now = admin.firestore.Timestamp.now();

    // Get active campaigns with remaining items
    const snapshot = await db
      .collection("rewardCampaigns")
      .where("status", "==", "active")
      .where("isDeleted", "==", false)
      .limit(200)
      .get();

    // Filter by date range client-side (Firestore can't do range on two fields with equality)
    const activeCampaigns = snapshot.docs
      .map((doc) => doc.data())
      .filter((c) => {
        const starts = c.startsAt?.toDate?.() || new Date(0);
        const ends = c.endsAt?.toDate?.() || new Date(0);
        const nowDate = now.toDate();
        return starts <= nowDate && ends > nowDate && c.remainingQuantity > 0;
      });

    // Check per-user limits (parallelized)
    const userItemCounts = await Promise.all(
      activeCampaigns.map((campaign) =>
        db
          .collection("rewardItems")
          .where("campaignId", "==", campaign.id)
          .where("allocatedToUserId", "==", userId)
          .count()
          .get()
      )
    );

    const result = [];
    for (let i = 0; i < activeCampaigns.length; i++) {
      const campaign = activeCampaigns[i];
      const userItemCount = userItemCounts[i].data().count;
      if (userItemCount < (campaign.maxPerUser || 1)) {
        result.push({
          id: campaign.id,
          clientId: campaign.clientId,
          clientName: campaign.clientName,
          clientAvatarImage: campaign.clientAvatarImage,
          clientAvatarColor: campaign.clientAvatarColor,
          name: campaign.name,
          description: campaign.description,
          rewardType: campaign.rewardType,
          remainingQuantity: campaign.remainingQuantity,
          displayImageUrl: campaign.displayImageUrl,
          displayPriority: campaign.displayPriority,
          startsAt: campaign.startsAt?.toDate?.()?.toISOString() || null,
          endsAt: campaign.endsAt?.toDate?.()?.toISOString() || null,
          metadata: {
            redemption_instructions:
              campaign.metadata?.redemption_instructions || null,
          },
          userAllocated: userItemCount,
          maxPerUser: campaign.maxPerUser || 1,
        });
      }
    }

    // Sort by display priority descending
    result.sort((a, b) => (b.displayPriority || 0) - (a.displayPriority || 0));

    return { campaigns: result };
  }
);

// ============================================================================
// SOFT-DELETE REWARD CAMPAIGN
// ============================================================================

export const deleteRewardCampaign = onCall(
  { labels: { area: "rewards" } },
  async (request) => {
    requireAppCheck(request, "deleteRewardCampaign");
    const adminCtx = await requireAdminPermission(request, "rewards:deleteCampaign", "deleteRewardCampaign");

    const { campaignId, reason } = request.data;
    if (!campaignId) {
      throw new HttpsError(
        "invalid-argument",
        "campaignId is required"
      );
    }

    const campaignRef = db.collection("rewardCampaigns").doc(campaignId);
    const campaignDoc = await campaignRef.get();

    if (!campaignDoc.exists) {
      throw new HttpsError("not-found", "Campaign not found");
    }
    if (campaignDoc.data()?.isDeleted === true) {
      throw new HttpsError(
        "failed-precondition",
        "Campaign is already deleted"
      );
    }

    await campaignRef.update({
      isDeleted: true,
      status: "cancelled",
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletedBy: request.auth!.uid,
      deletionReason: reason || null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    logAdminAction(adminCtx.uid, "deleteRewardCampaign", "success", { campaignId, reason: reason || null }).catch(() => {});

    return { success: true };
  }
);

// ============================================================================
// A/B TEST RESULTS
// ============================================================================

/**
 * Get A/B test results for a campaign.
 * Returns per-variant allocation and redemption counts with rates.
 */
export const getRewardCampaignAbResults = onCall(
  { labels: { area: "rewards" } },
  async (request) => {
    requireAppCheck(request, "getRewardCampaignAbResults");
    await requireAdminPermission(request, "rewards:getAbResults", "getRewardCampaignAbResults");

    const { campaignId } = request.data;
    if (!campaignId) {
      throw new HttpsError(
        "invalid-argument",
        "campaignId is required"
      );
    }

    const campaignDoc = await db
      .collection("rewardCampaigns")
      .doc(campaignId)
      .get();

    if (!campaignDoc.exists) {
      throw new HttpsError("not-found", "Campaign not found");
    }

    const campaign = campaignDoc.data()!;
    if (!campaign.abTest?.enabled) {
      return {
        abTest: null,
        message: "A/B testing not enabled for this campaign",
      };
    }

    // Get all items for this campaign
    const itemsSnapshot = await db
      .collection("rewardItems")
      .where("campaignId", "==", campaignId)
      .where("status", "in", ["allocated", "redeemed", "expired"])
      .limit(500)
      .get();

    // Count per variant
    const variantStats = new Map<
      string,
      { allocations: number; redemptions: number }
    >();

    for (const variant of campaign.abTest.variants) {
      variantStats.set(variant.id, { allocations: 0, redemptions: 0 });
    }

    for (const doc of itemsSnapshot.docs) {
      const item = doc.data();
      const variant = item.metadata?.abVariant as string | undefined;
      if (variant && variantStats.has(variant)) {
        const stats = variantStats.get(variant)!;
        stats.allocations++;
        if (item.status === "redeemed") {
          stats.redemptions++;
        }
      }
    }

    const variants = campaign.abTest.variants.map(
      (v: { id: string; weight: number }) => {
        const stats = variantStats.get(v.id) || {
          allocations: 0,
          redemptions: 0,
        };
        return {
          id: v.id,
          weight: v.weight,
          allocations: stats.allocations,
          redemptions: stats.redemptions,
          redemptionRate:
            stats.allocations > 0
              ? Math.round(
                  (stats.redemptions / stats.allocations) * 10000
                ) / 100
              : 0,
        };
      }
    );

    return { abTest: { enabled: true, variants } };
  }
);
