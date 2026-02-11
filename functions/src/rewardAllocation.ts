/**
 * Reward Allocation Engine
 *
 * Processes allocation of non-fungible reward items to users.
 *
 * Allocation flow:
 * 1. processEngagement completes → calls enqueueRewardAllocation()
 * 2. Core logic runs: idempotency check → campaign validation → per-user limit → random item selection
 * 3. Firestore transaction to atomically assign item → update campaign counters
 * 4. Push notification to user
 *
 * The core logic is extracted into allocateRewardItem() so it can be called:
 * - Directly from processEngagement via enqueueRewardAllocation() (fire-and-forget)
 * - Via the processRewardAllocation onCall for admin or retry scenarios
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as crypto from "crypto";
import { checkRateLimit, checkRewardFraud } from "./security";

const db = admin.firestore();

// ============================================================================
// CORE ALLOCATION LOGIC
// ============================================================================

interface AllocationResult {
  success: boolean;
  alreadyAllocated?: boolean;
  itemId?: string;
  reason?: string;
}

/**
 * Core reward allocation logic.
 * Idempotent: safe to call multiple times for the same engagement.
 */
async function allocateRewardItem(
  userId: string,
  campaignId: string,
  engagementId: string
): Promise<AllocationResult> {
  functions.logger.info("Processing reward allocation", {
    userId,
    campaignId,
    engagementId,
  });

  // Step 0: Feature flag check
  const flagDoc = await db.collection("platformSettings").doc("rewards").get();
  const flagData = flagDoc.exists ? flagDoc.data() : {};
  if (flagData?.rewardsEnabled === false) {
    functions.logger.info("Reward allocation disabled via feature flag");
    return { success: false, reason: "rewards_disabled" };
  }

  // Step 0a: Granular earn-integration flag
  if (flagData?.rewardsEarnIntegrationEnabled === false) {
    functions.logger.info("Reward earn integration disabled via feature flag");
    return { success: false, reason: "earn_integration_disabled" };
  }

  // Step 0b: POPIA consent check
  const userDoc = await db.collection("users").doc(userId).get();
  if (!userDoc.exists || userDoc.data()?.rewardConsent !== true) {
    functions.logger.info("User has not given reward consent", { userId });
    return { success: false, reason: "consent_not_given" };
  }

  // Step 0c: Fraud / rate-limit checks
  const rateCheck = await checkRateLimit(userId, "reward_claim");
  if (!rateCheck.allowed) {
    functions.logger.warn("Reward claim rate limited", { userId });
    return { success: false, reason: "rate_limited" };
  }

  const fraudCheck = await checkRewardFraud(userId);
  if (!fraudCheck.allowed) {
    functions.logger.warn("Reward claim blocked by fraud check", {
      userId,
      alerts: fraudCheck.alerts,
    });
    return { success: false, reason: "fraud_check_failed" };
  }

  // Step 1: Idempotency check — has this engagement already been allocated?
  const existingItems = await db
    .collection("rewardItems")
    .where("allocatedToUserId", "==", userId)
    .where("campaignId", "==", campaignId)
    .limit(10)
    .get();

  for (const doc of existingItems.docs) {
    const itemData = doc.data();
    if (itemData.metadata?.engagementId === engagementId) {
      functions.logger.info("Reward already allocated for this engagement", {
        engagementId,
        itemId: doc.id,
      });
      return { success: true, alreadyAllocated: true, itemId: doc.id };
    }
  }

  // Step 2: Campaign validation
  const campaignDoc = await db
    .collection("rewardCampaigns")
    .doc(campaignId)
    .get();

  if (!campaignDoc.exists) {
    functions.logger.error("Campaign not found", { campaignId });
    return { success: false, reason: "campaign_not_found" };
  }

  const campaign = campaignDoc.data()!;

  if (campaign.isDeleted === true) {
    return { success: false, reason: "campaign_deleted" };
  }

  if (campaign.status !== "active") {
    return { success: false, reason: `campaign_status_${campaign.status}` };
  }

  const now = new Date();
  const startsAt = campaign.startsAt?.toDate?.() || new Date(0);
  const endsAt = campaign.endsAt?.toDate?.() || new Date(0);

  if (now < startsAt || now > endsAt) {
    return { success: false, reason: "campaign_outside_date_range" };
  }

  if (campaign.remainingQuantity <= 0) {
    return { success: false, reason: "campaign_exhausted" };
  }

  // Step 3: Per-user limit check
  const maxPerUser = campaign.maxPerUser || 1;
  if (existingItems.size >= maxPerUser) {
    functions.logger.info("User has reached max allocations for campaign", {
      userId,
      campaignId,
      maxPerUser,
      currentCount: existingItems.size,
    });
    return { success: false, reason: "user_limit_reached" };
  }

  // Step 3b: A/B variant assignment (if campaign has A/B test enabled)
  let abVariant: string | null = null;
  if (campaign.abTest?.enabled && Array.isArray(campaign.abTest.variants)) {
    const hash = crypto
      .createHash("md5")
      .update(`${userId}:${campaignId}`)
      .digest();
    const bucket = hash.readUInt16BE(0) % 100; // 0-99
    let cumulative = 0;
    for (const variant of campaign.abTest.variants) {
      cumulative += variant.weight || 0;
      if (bucket < cumulative) {
        abVariant = variant.id;
        break;
      }
    }
    if (!abVariant) {
      abVariant = campaign.abTest.variants[0]?.id || "control";
    }
  }

  // Step 4: Random item selection + atomic allocation
  // Query 20 available items and pick randomly to reduce contention
  const availableItems = await db
    .collection("rewardItems")
    .where("campaignId", "==", campaignId)
    .where("status", "==", "available")
    .limit(20)
    .get();

  if (availableItems.empty) {
    functions.logger.warn("No available items found", { campaignId });
    return { success: false, reason: "no_available_items" };
  }

  // Pick a random item from results
  const randomIndex = Math.floor(Math.random() * availableItems.size);
  const candidates = availableItems.docs;

  // Try up to 3 times with different random picks
  const maxRetries = 3;
  let allocatedItemId: string | null = null;

  for (let attempt = 0; attempt < maxRetries; attempt++) {
    const pickIndex = (randomIndex + attempt) % candidates.length;
    const candidate = candidates[pickIndex];
    const itemRef = db.collection("rewardItems").doc(candidate.id);
    const campaignRef = db.collection("rewardCampaigns").doc(campaignId);

    try {
      await db.runTransaction(async (txn) => {
        const itemDoc = await txn.get(itemRef);
        if (!itemDoc.exists || itemDoc.data()?.status !== "available") {
          throw new Error("Item no longer available");
        }

        const nowTimestamp = admin.firestore.FieldValue.serverTimestamp();

        // Allocate the item
        txn.update(itemRef, {
          status: "allocated",
          allocatedToUserId: userId,
          allocatedAt: nowTimestamp,
          expiresAt: campaign.itemExpiresAt || null,
          metadata: {
            ...itemDoc.data()?.metadata,
            engagementId,
            ...(abVariant ? { abVariant } : {}),
          },
          updatedAt: nowTimestamp,
        });

        // Update campaign counters
        txn.update(campaignRef, {
          remainingQuantity: admin.firestore.FieldValue.increment(-1),
          allocatedQuantity: admin.firestore.FieldValue.increment(1),
          updatedAt: nowTimestamp,
        });
      });

      allocatedItemId = candidate.id;
      break; // Success
    } catch (txnError) {
      functions.logger.warn(
        `Allocation attempt ${attempt + 1} failed, retrying`,
        { itemId: candidate.id, error: txnError }
      );
      if (attempt === maxRetries - 1) {
        functions.logger.error("All allocation attempts failed", {
          userId,
          campaignId,
          engagementId,
        });
        return { success: false, reason: "allocation_contention" };
      }
    }
  }

  if (!allocatedItemId) {
    return { success: false, reason: "allocation_failed" };
  }

  // Step 5: Activity log
  await db.collection("rewardActivityLog").add({
    itemId: allocatedItemId,
    campaignId,
    userId,
    action: "allocated",
    previousStatus: "available",
    newStatus: "allocated",
    performedBy: "system",
    notes: `Allocated via engagement ${engagementId}`,
    metadata: { engagementId, ...(abVariant ? { abVariant } : {}) },
    ipAddress: null, // System-triggered allocation — no client IP available
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Step 6: Check if campaign is now exhausted
  const updatedCampaign = await db
    .collection("rewardCampaigns")
    .doc(campaignId)
    .get();
  if (
    updatedCampaign.exists &&
    (updatedCampaign.data()?.remainingQuantity ?? 0) <= 0
  ) {
    await db.collection("rewardCampaigns").doc(campaignId).update({
      status: "exhausted",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  // Step 7: Push notification
  try {
    const userDoc = await db.collection("users").doc(userId).get();
    const fcmToken = userDoc.data()?.fcmToken;

    if (fcmToken) {
      await admin.messaging().send({
        token: fcmToken,
        notification: {
          title: "New Reward!",
          body: `You earned a ${campaign.name} from ${campaign.clientName}! Check your rewards.`,
        },
        data: {
          type: "reward_allocated",
          itemId: allocatedItemId,
          campaignId,
        },
      });
    }
  } catch (notifError) {
    functions.logger.warn("Failed to send allocation notification", {
      userId,
      error: notifError,
    });
    // Don't fail allocation for notification errors
  }

  functions.logger.info("Reward allocated successfully", {
    userId,
    campaignId,
    engagementId,
    itemId: allocatedItemId,
  });

  return { success: true, itemId: allocatedItemId };
}

// ============================================================================
// ENQUEUE REWARD ALLOCATION (called from processEngagement)
// ============================================================================

/**
 * Trigger reward allocation for a completed engagement.
 * Runs the allocation logic directly (fire-and-forget from caller's perspective).
 * The caller should wrap this in try/catch so allocation failures don't
 * block the main engagement completion flow.
 */
export async function enqueueRewardAllocation(
  userId: string,
  campaignId: string,
  engagementId: string
): Promise<void> {
  try {
    const result = await allocateRewardItem(userId, campaignId, engagementId);
    if (!result.success) {
      functions.logger.warn("Reward allocation did not succeed", {
        userId,
        campaignId,
        engagementId,
        reason: result.reason,
      });
    }
  } catch (err) {
    functions.logger.error("Failed to process reward allocation", {
      userId,
      campaignId,
      engagementId,
      error: err,
    });
    throw err;
  }
}

// ============================================================================
// PROCESS REWARD ALLOCATION (callable endpoint for admin/retry)
// ============================================================================

/**
 * Callable endpoint for manually triggering or retrying reward allocation.
 * Can be called by admins or used for retry scenarios.
 */
export const processRewardAllocation = functions.https.onCall(
  async (
    data: {
      userId: string;
      campaignId: string;
      engagementId: string;
    },
    context
  ) => {
    // Allow both admin calls and authenticated user calls
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const { userId, campaignId, engagementId } = data;

    if (!userId || !campaignId || !engagementId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId, campaignId, and engagementId are required"
      );
    }

    return allocateRewardItem(userId, campaignId, engagementId);
  }
);
