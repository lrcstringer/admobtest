/**
 * Reward Campaign Management Cloud Functions
 *
 * CRUD operations for reward campaigns (non-fungible inventory items).
 * Admin functions require admin auth; getActiveRewardCampaigns is user-facing.
 */

import * as functions from "firebase-functions";
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

export const createRewardCampaign = functions.https.onCall(
  async (
    data: {
      clientId: string;
      name: string;
      description?: string;
      rewardType: string;
      startsAt: string; // ISO date string
      endsAt: string;
      itemExpiresAt?: string;
      maxPerUser?: number;
      displayImageUrl?: string;
      displayPriority?: number;
      metadata?: Record<string, unknown>;
      abTest?: {
        enabled: boolean;
        variants: Array<{
          id: string;
          weight: number;
          metadata?: Record<string, unknown>;
        }>;
      };
    },
    context
  ) => {
    requireAppCheck(context, "createRewardCampaign");
    const adminCtx = await requireAdminPermission(context, "rewards:createCampaign", "createRewardCampaign");

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
    } = data;

    // Validate required fields
    if (!clientId || !name || !rewardType || !startsAt || !endsAt) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "clientId, name, rewardType, startsAt, and endsAt are required"
      );
    }

    // Validate reward type
    if (!VALID_REWARD_TYPES.includes(rewardType as RewardType)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Invalid rewardType. Must be one of: ${VALID_REWARD_TYPES.join(", ")}`
      );
    }

    // Validate dates
    const startsAtDate = new Date(startsAt);
    const endsAtDate = new Date(endsAt);
    if (isNaN(startsAtDate.getTime()) || isNaN(endsAtDate.getTime())) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Invalid date format for startsAt or endsAt"
      );
    }
    if (endsAtDate <= startsAtDate) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "endsAt must be after startsAt"
      );
    }

    // Validate client exists and is not deleted
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (!clientDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Client not found");
    }
    const clientData = clientDoc.data()!;
    if (clientData.isDeleted === true) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Cannot create campaign for a deleted client"
      );
    }

    // Validate A/B test if provided
    if (abTest?.enabled && Array.isArray(abTest.variants)) {
      if (abTest.variants.length < 2 || abTest.variants.length > 4) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "A/B test must have 2-4 variants"
        );
      }
      const totalWeight = abTest.variants.reduce(
        (sum, v) => sum + (v.weight || 0),
        0
      );
      if (totalWeight !== 100) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "A/B test variant weights must sum to 100"
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
      allocatedQuantity: 0,
      redeemedQuantity: 0,
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
      createdBy: context.auth!.uid,
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

export const updateRewardCampaign = functions.https.onCall(
  async (
    data: {
      campaignId: string;
      updates: {
        name?: string;
        description?: string;
        startsAt?: string;
        endsAt?: string;
        itemExpiresAt?: string;
        maxPerUser?: number;
        displayImageUrl?: string;
        displayPriority?: number;
        status?: string;
        metadata?: Record<string, unknown>;
        abTest?: {
          enabled: boolean;
          variants: Array<{
            id: string;
            weight: number;
            metadata?: Record<string, unknown>;
          }>;
        };
      };
    },
    context
  ) => {
    requireAppCheck(context, "updateRewardCampaign");
    const adminCtx = await requireAdminPermission(context, "rewards:updateCampaign", "updateRewardCampaign");

    const { campaignId, updates } = data;

    if (!campaignId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "campaignId is required"
      );
    }

    const campaignRef = db.collection("rewardCampaigns").doc(campaignId);
    const campaignDoc = await campaignRef.get();

    if (!campaignDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Campaign not found");
    }

    const campaign = campaignDoc.data()!;
    if (campaign.isDeleted === true) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Cannot update a deleted campaign"
      );
    }

    // Validate status transition
    if (updates.status) {
      if (!VALID_STATUSES.includes(updates.status as CampaignStatus)) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          `Invalid status. Must be one of: ${VALID_STATUSES.join(", ")}`
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
    if (updates.maxPerUser !== undefined)
      updateData.maxPerUser = updates.maxPerUser;
    if (updates.displayImageUrl !== undefined)
      updateData.displayImageUrl = updates.displayImageUrl;
    if (updates.displayPriority !== undefined)
      updateData.displayPriority = updates.displayPriority;
    if (updates.status !== undefined) updateData.status = updates.status;
    if (updates.metadata !== undefined) updateData.metadata = updates.metadata;
    if (updates.abTest !== undefined) {
      if (updates.abTest.enabled && Array.isArray(updates.abTest.variants)) {
        const totalWeight = updates.abTest.variants.reduce(
          (sum, v) => sum + (v.weight || 0),
          0
        );
        if (
          updates.abTest.variants.length < 2 ||
          updates.abTest.variants.length > 4 ||
          totalWeight !== 100
        ) {
          throw new functions.https.HttpsError(
            "invalid-argument",
            "A/B test requires 2-4 variants with weights summing to 100"
          );
        }
      }
      updateData.abTest = updates.abTest;
    }

    if (updates.startsAt) {
      const d = new Date(updates.startsAt);
      if (isNaN(d.getTime())) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Invalid startsAt date"
        );
      }
      updateData.startsAt = admin.firestore.Timestamp.fromDate(d);
    }
    if (updates.endsAt) {
      const d = new Date(updates.endsAt);
      if (isNaN(d.getTime())) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Invalid endsAt date"
        );
      }
      updateData.endsAt = admin.firestore.Timestamp.fromDate(d);
    }
    if (updates.itemExpiresAt) {
      const d = new Date(updates.itemExpiresAt);
      if (isNaN(d.getTime())) {
        throw new functions.https.HttpsError(
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
        functions.logger.warn("Failed to send new campaign notifications", {
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
      functions.logger.warn("FCM batch send failed", {
        batchStart: i,
        error: batchErr,
      });
    }
  }

  functions.logger.info("New campaign notifications sent", {
    campaignId,
    totalTokens: tokens.length,
  });
}

// ============================================================================
// GET ADMIN REWARD CAMPAIGNS (with filters)
// ============================================================================

export const getAdminRewardCampaigns = functions.https.onCall(
  async (
    data: {
      clientId?: string;
      status?: string;
      limit?: number;
    },
    context
  ) => {
    requireAppCheck(context, "getAdminRewardCampaigns");
    await requireAdminPermission(context, "rewards:getCampaigns", "getAdminRewardCampaigns");

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

export const getActiveRewardCampaigns = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "getActiveRewardCampaigns");

    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    // Feature flag check
    const flagDoc = await db.collection("platformSettings").doc("rewards").get();
    if (flagDoc.exists && flagDoc.data()?.rewardsEnabled === false) {
      return { campaigns: [] };
    }

    const userId = context.auth.uid;
    const now = admin.firestore.Timestamp.now();

    // Get active campaigns with remaining items
    const snapshot = await db
      .collection("rewardCampaigns")
      .where("status", "==", "active")
      .where("isDeleted", "==", false)
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

    // Check per-user limits
    const result = [];
    for (const campaign of activeCampaigns) {
      const userItemsSnapshot = await db
        .collection("rewardItems")
        .where("campaignId", "==", campaign.id)
        .where("allocatedToUserId", "==", userId)
        .get();

      const userItemCount = userItemsSnapshot.size;
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

export const deleteRewardCampaign = functions.https.onCall(
  async (data: { campaignId: string; reason?: string }, context) => {
    requireAppCheck(context, "deleteRewardCampaign");
    const adminCtx = await requireAdminPermission(context, "rewards:deleteCampaign", "deleteRewardCampaign");

    const { campaignId, reason } = data;
    if (!campaignId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "campaignId is required"
      );
    }

    const campaignRef = db.collection("rewardCampaigns").doc(campaignId);
    const campaignDoc = await campaignRef.get();

    if (!campaignDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Campaign not found");
    }
    if (campaignDoc.data()?.isDeleted === true) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Campaign is already deleted"
      );
    }

    await campaignRef.update({
      isDeleted: true,
      status: "cancelled",
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletedBy: context.auth!.uid,
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
export const getRewardCampaignAbResults = functions.https.onCall(
  async (data: { campaignId: string }, context) => {
    requireAppCheck(context, "getRewardCampaignAbResults");
    await requireAdminPermission(context, "rewards:getAbResults", "getRewardCampaignAbResults");

    const { campaignId } = data;
    if (!campaignId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "campaignId is required"
      );
    }

    const campaignDoc = await db
      .collection("rewardCampaigns")
      .doc(campaignId)
      .get();

    if (!campaignDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Campaign not found");
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
