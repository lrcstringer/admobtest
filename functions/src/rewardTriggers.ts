/**
 * Reward Item Firestore Trigger — Centralized Counter Management
 *
 * Single onWrite trigger on rewardItems/{itemId} that maintains
 * all counter fields on the parent rewardCampaigns document.
 * Replaces 8 scattered inline counter updates.
 *
 * Counter invariant:
 *   totalQuantity = remainingQuantity + reservedCount + allocatedQuantity
 *                 + redeemedQuantity + expiredCount + revokedCount
 *
 * Status-to-counter mapping:
 *   available  → remainingQuantity
 *   reserved   → reservedCount
 *   allocated  → allocatedQuantity
 *   redeemed   → redeemedQuantity
 *   expired    → expiredCount
 *   revoked    → revokedCount
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/** Map each item status to its corresponding campaign counter field */
const STATUS_COUNTER_MAP: Record<string, string> = {
  available: "remainingQuantity",
  reserved: "reservedCount",
  allocated: "allocatedQuantity",
  redeemed: "redeemedQuantity",
  expired: "expiredCount",
  revoked: "revokedCount",
};

/**
 * Firestore trigger that fires on every rewardItems document write.
 * Maintains campaign-level counter fields by reacting to status transitions.
 */
export const onRewardItemWritten = functions.firestore
  .document("rewardItems/{itemId}")
  .onWrite(async (change, context) => {
    const before = change.before.exists ? change.before.data()! : null;
    const after = change.after.exists ? change.after.data()! : null;

    // Determine campaign ID (set at creation, never changes)
    const campaignId = (after || before)?.campaignId as string | undefined;
    if (!campaignId) {
      functions.logger.warn("rewardItem has no campaignId", {
        itemId: context.params.itemId,
      });
      return;
    }

    const oldStatus: string | null = before?.status || null;
    const newStatus: string | null = after?.status || null;

    // Skip if status didn't change (e.g. metadata-only update like warning flags)
    if (oldStatus === newStatus) {
      return;
    }

    // Build the counter update object
    const updates: Record<string, admin.firestore.FieldValue> = {};

    if (!before && after) {
      // CASE 1: Item CREATED (import)
      // Increment totalQuantity and the counter for the initial status
      updates.totalQuantity = admin.firestore.FieldValue.increment(1);
      const counterField = newStatus ? STATUS_COUNTER_MAP[newStatus] : null;
      if (counterField) {
        updates[counterField] = admin.firestore.FieldValue.increment(1);
      }
    } else if (before && !after) {
      // CASE 2: Item DELETED (defensive — items shouldn't be deleted in normal operation)
      updates.totalQuantity = admin.firestore.FieldValue.increment(-1);
      const counterField = oldStatus ? STATUS_COUNTER_MAP[oldStatus] : null;
      if (counterField) {
        updates[counterField] = admin.firestore.FieldValue.increment(-1);
      }
    } else if (before && after && oldStatus !== newStatus) {
      // CASE 3: Status TRANSITION
      const oldCounterField = oldStatus ? STATUS_COUNTER_MAP[oldStatus] : null;
      const newCounterField = newStatus ? STATUS_COUNTER_MAP[newStatus] : null;
      if (oldCounterField) {
        updates[oldCounterField] = admin.firestore.FieldValue.increment(-1);
      }
      if (newCounterField) {
        updates[newCounterField] = admin.firestore.FieldValue.increment(1);
      }
    }

    // Only write if there are actual counter changes
    if (Object.keys(updates).length === 0) {
      return;
    }

    const campaignRef = db.collection("rewardCampaigns").doc(campaignId);

    try {
      await campaignRef.update(updates);
    } catch (err) {
      functions.logger.error("Failed to update campaign counters via trigger", {
        campaignId,
        itemId: context.params.itemId,
        oldStatus,
        newStatus,
        error: err,
      });
      return;
    }

    // Auto-exhaustion detection: when an item leaves "available" status,
    // check if the campaign has no more available or reserved items.
    if (oldStatus === "available" && newStatus && newStatus !== "available") {
      try {
        const campaignDoc = await campaignRef.get();
        if (campaignDoc.exists) {
          const data = campaignDoc.data()!;
          if (
            (data.remainingQuantity ?? 0) <= 0 &&
            (data.reservedCount ?? 0) <= 0 &&
            data.status === "active"
          ) {
            await campaignRef.update({
              status: "exhausted",
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
            functions.logger.info("Campaign auto-exhausted via trigger", {
              campaignId,
            });
          }
        }
      } catch (err) {
        // Non-critical — reconciler will catch this
        functions.logger.warn("Failed to check campaign exhaustion", {
          campaignId,
          error: err,
        });
      }
    }
  });
