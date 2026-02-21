/**
 * Scheduled Reward Functions
 *
 * Handles automated maintenance of the reward inventory system:
 * 1. processRewardExpiries — Expire allocated items past their expiresAt date
 * 2. reconcileRewardCounts — Daily reconciliation of campaign counters
 * 3. sendExpiryWarnings — Push notifications for items expiring soon
 */

import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { releaseRewardReservation } from "./rewardAllocation";

const db = admin.firestore();

// ============================================================================
// 1. PROCESS REWARD EXPIRIES (every 15 minutes)
// ============================================================================

/**
 * Expire allocated items past their expiresAt date.
 * Also expire campaigns past their endsAt date.
 * Runs every 15 minutes.
 */
export const processRewardExpiries = onSchedule(
  { schedule: "*/15 * * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "rewards" } },
  async () => {
    const now = admin.firestore.Timestamp.now();
    let expiredItems = 0;
    let expiredCampaigns = 0;

    // ──────────────────────────────────────────────────────────────────────
    // 1a. Expire allocated items past their expiresAt
    // ──────────────────────────────────────────────────────────────────────
    const expiredItemsSnapshot = await db
      .collection("rewardItems")
      .where("status", "==", "allocated")
      .where("expiresAt", "<=", now)
      .limit(500) // Process in batches
      .get();

    if (!expiredItemsSnapshot.empty) {
      const batch = db.batch();
      for (const doc of expiredItemsSnapshot.docs) {
        batch.update(doc.ref, {
          status: "expired",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        expiredItems++;
      }
      await batch.commit();
      // Campaign counters updated by onRewardItemWritten trigger per item

      // Write activity log entries
      const logBatch = db.batch();
      for (const doc of expiredItemsSnapshot.docs) {
        const data = doc.data();
        const logRef = db.collection("rewardActivityLog").doc();
        logBatch.set(logRef, {
          itemId: doc.id,
          campaignId: data.campaignId,
          userId: data.allocatedToUserId,
          action: "expired",
          previousStatus: "allocated",
          newStatus: "expired",
          performedBy: "system",
          notes: "Auto-expired: past expiresAt date",
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      await logBatch.commit();
    }

    // ──────────────────────────────────────────────────────────────────────
    // 1b. Expire campaigns past their endsAt date
    // ──────────────────────────────────────────────────────────────────────
    const expiredCampaignsSnapshot = await db
      .collection("rewardCampaigns")
      .where("status", "==", "active")
      .where("endsAt", "<=", now)
      .limit(100)
      .get();

    if (!expiredCampaignsSnapshot.empty) {
      const batch = db.batch();
      for (const doc of expiredCampaignsSnapshot.docs) {
        batch.update(doc.ref, {
          status: "expired",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        expiredCampaigns++;
      }
      await batch.commit();

      // Bulk-expire unclaimed items from these campaigns
      for (const campaignDoc of expiredCampaignsSnapshot.docs) {
        const unclaimedItems = await db
          .collection("rewardItems")
          .where("campaignId", "==", campaignDoc.id)
          .where("status", "==", "available")
          .limit(500)
          .get();

        if (!unclaimedItems.empty) {
          const itemBatch = db.batch();
          for (const itemDoc of unclaimedItems.docs) {
            itemBatch.update(itemDoc.ref, {
              status: "expired",
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
          }
          await itemBatch.commit();

          logger.info(
            `Expired ${unclaimedItems.size} unclaimed items from campaign ${campaignDoc.id}`
          );
        }
      }
    }

    if (expiredItems > 0 || expiredCampaigns > 0) {
      logger.info("Reward expiry processing complete", {
        expiredItems,
        expiredCampaigns,
      });
    }

  }
);

// ============================================================================
// 2. RECONCILE REWARD COUNTS (daily at 5 AM)
// ============================================================================

/**
 * Weekly verification audit — count actual items by status and compare
 * against trigger-maintained counters. Fix mismatches and log discrepancies.
 * Reconciles all 7 counter fields: totalQuantity, remainingQuantity,
 * reservedCount, allocatedQuantity, redeemedQuantity, expiredCount, revokedCount.
 */
export const reconcileRewardCounts = onSchedule(
  { schedule: "0 5 * * 1", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "rewards" } },
  async () => {
    // Only reconcile campaigns with recent activity (updated in the last 7 days)
    const oneWeekAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
    const campaigns = await db
      .collection("rewardCampaigns")
      .where("isDeleted", "==", false)
      .where("updatedAt", ">=", admin.firestore.Timestamp.fromDate(oneWeekAgo))
      .limit(500)
      .get();

    let checkedCampaigns = 0;
    let fixedCampaigns = 0;

    for (const campaignDoc of campaigns.docs) {
      const campaign = campaignDoc.data();
      checkedCampaigns++;

      // Count actual items by all 6 statuses
      const [
        availableCount, reservedCount, allocatedCount,
        redeemedCount, expiredCount, revokedCount,
      ] = await Promise.all([
        db.collection("rewardItems")
          .where("campaignId", "==", campaignDoc.id)
          .where("status", "==", "available").count().get(),
        db.collection("rewardItems")
          .where("campaignId", "==", campaignDoc.id)
          .where("status", "==", "reserved").count().get(),
        db.collection("rewardItems")
          .where("campaignId", "==", campaignDoc.id)
          .where("status", "==", "allocated").count().get(),
        db.collection("rewardItems")
          .where("campaignId", "==", campaignDoc.id)
          .where("status", "==", "redeemed").count().get(),
        db.collection("rewardItems")
          .where("campaignId", "==", campaignDoc.id)
          .where("status", "==", "expired").count().get(),
        db.collection("rewardItems")
          .where("campaignId", "==", campaignDoc.id)
          .where("status", "==", "revoked").count().get(),
      ]);

      const actualAvailable = availableCount.data().count;
      const actualReserved = reservedCount.data().count;
      const actualAllocated = allocatedCount.data().count;
      const actualRedeemed = redeemedCount.data().count;
      const actualExpired = expiredCount.data().count;
      const actualRevoked = revokedCount.data().count;
      const actualTotal = actualAvailable + actualReserved + actualAllocated
        + actualRedeemed + actualExpired + actualRevoked;

      // Read stored counter values
      const storedRemaining = campaign.remainingQuantity ?? 0;
      const storedReserved = campaign.reservedCount ?? 0;
      const storedAllocated = campaign.allocatedQuantity ?? 0;
      const storedRedeemed = campaign.redeemedQuantity ?? 0;
      const storedExpired = campaign.expiredCount ?? 0;
      const storedRevoked = campaign.revokedCount ?? 0;
      const storedTotal = campaign.totalQuantity ?? 0;

      // Check for mismatches across all 7 fields
      const hasMismatch =
        actualAvailable !== storedRemaining ||
        actualReserved !== storedReserved ||
        actualAllocated !== storedAllocated ||
        actualRedeemed !== storedRedeemed ||
        actualExpired !== storedExpired ||
        actualRevoked !== storedRevoked ||
        actualTotal !== storedTotal;

      if (hasMismatch) {
        // Fix all counters
        await campaignDoc.ref.update({
          totalQuantity: actualTotal,
          remainingQuantity: actualAvailable,
          reservedCount: actualReserved,
          allocatedQuantity: actualAllocated,
          redeemedQuantity: actualRedeemed,
          expiredCount: actualExpired,
          revokedCount: actualRevoked,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Log the discrepancy
        await db.collection("rewardActivityLog").add({
          campaignId: campaignDoc.id,
          action: "reconciled",
          performedBy: "system",
          notes: "Weekly counter reconciliation audit",
          metadata: {
            stored: {
              total: storedTotal,
              remaining: storedRemaining,
              reserved: storedReserved,
              allocated: storedAllocated,
              redeemed: storedRedeemed,
              expired: storedExpired,
              revoked: storedRevoked,
            },
            actual: {
              total: actualTotal,
              remaining: actualAvailable,
              reserved: actualReserved,
              allocated: actualAllocated,
              redeemed: actualRedeemed,
              expired: actualExpired,
              revoked: actualRevoked,
            },
          },
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        fixedCampaigns++;

        logger.warn("Campaign counter mismatch fixed", {
          campaignId: campaignDoc.id,
          campaignName: campaign.name,
          stored: {
            total: storedTotal, remaining: storedRemaining,
            reserved: storedReserved, allocated: storedAllocated,
            redeemed: storedRedeemed, expired: storedExpired,
            revoked: storedRevoked,
          },
          actual: {
            total: actualTotal, remaining: actualAvailable,
            reserved: actualReserved, allocated: actualAllocated,
            redeemed: actualRedeemed, expired: actualExpired,
            revoked: actualRevoked,
          },
        });

        // If remaining went to 0, check if campaign should be exhausted
        if (
          actualAvailable === 0 &&
          actualReserved === 0 &&
          campaign.status === "active"
        ) {
          await campaignDoc.ref.update({
            status: "exhausted",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      }
    }

    logger.info("Reward count reconciliation complete", {
      checkedCampaigns,
      fixedCampaigns,
    });

  }
);

// ============================================================================
// 3. SEND EXPIRY WARNINGS (hourly)
// ============================================================================

/**
 * Find allocated items expiring within 48h and 4h.
 * Send push notifications and track sent warnings in item metadata.
 */
export const sendExpiryWarnings = onSchedule(
  { schedule: "0 * * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "rewards" } },
  async () => {
    const now = new Date();

    // 48-hour window
    const in48h = new Date(now.getTime() + 48 * 60 * 60 * 1000);
    const in47h = new Date(now.getTime() + 47 * 60 * 60 * 1000);

    // 4-hour window
    const in4h = new Date(now.getTime() + 4 * 60 * 60 * 1000);
    const in3h = new Date(now.getTime() + 3 * 60 * 60 * 1000);

    let sent48h = 0;
    let sent4h = 0;

    // ──────────────────────────────────────────────────────────────────────
    // 48-hour warning
    // ──────────────────────────────────────────────────────────────────────
    const items48h = await db
      .collection("rewardItems")
      .where("status", "==", "allocated")
      .where("expiresAt", ">=", admin.firestore.Timestamp.fromDate(in47h))
      .where("expiresAt", "<=", admin.firestore.Timestamp.fromDate(in48h))
      .limit(200)
      .get();

    // Batch-fetch unique campaignIds and userIds for 48h items
    const campaignIds48h = new Set<string>();
    const userIds48h = new Set<string>();
    for (const doc of items48h.docs) {
      const data = doc.data();
      if (data.metadata?.warning48hSent) continue;
      if (!data.allocatedToUserId) continue;
      if (data.campaignId) campaignIds48h.add(data.campaignId);
      userIds48h.add(data.allocatedToUserId);
    }

    const campaignMap48h = new Map<string, admin.firestore.DocumentData | undefined>();
    if (campaignIds48h.size > 0) {
      const campaignRefs = Array.from(campaignIds48h).map((id) => db.collection("rewardCampaigns").doc(id));
      const campaignDocs = await db.getAll(...campaignRefs);
      for (const cDoc of campaignDocs) {
        campaignMap48h.set(cDoc.id, cDoc.exists ? cDoc.data() : undefined);
      }
    }

    const userMap48h = new Map<string, admin.firestore.DocumentData | undefined>();
    if (userIds48h.size > 0) {
      const userRefs = Array.from(userIds48h).map((id) => db.collection("users").doc(id));
      const userDocs = await db.getAll(...userRefs);
      for (const uDoc of userDocs) {
        userMap48h.set(uDoc.id, uDoc.exists ? uDoc.data() : undefined);
      }
    }

    for (const doc of items48h.docs) {
      const data = doc.data();

      // Skip if 48h warning already sent
      if (data.metadata?.warning48hSent) continue;

      const userId = data.allocatedToUserId;
      if (!userId) continue;

      try {
        // Get campaign name from batch-fetched map
        const campaignData = campaignMap48h.get(data.campaignId);
        const campaignName = campaignData?.name || "your reward";

        // Get FCM token from batch-fetched map
        const userData = userMap48h.get(userId);
        const fcmToken = userData?.fcmToken;

        if (fcmToken) {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Reward Expiring Soon",
              body: `Your ${campaignName} expires in 2 days. Don't forget to use it!`,
            },
            data: {
              type: "reward_expiry_warning",
              itemId: doc.id,
              campaignId: data.campaignId,
            },
          });
        }

        // Mark as sent
        await doc.ref.update({
          "metadata.warning48hSent": true,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        sent48h++;
      } catch (err) {
        logger.warn("Failed to send 48h expiry warning", {
          itemId: doc.id,
          error: err,
        });
      }
    }

    // ──────────────────────────────────────────────────────────────────────
    // 4-hour warning
    // ──────────────────────────────────────────────────────────────────────
    const items4h = await db
      .collection("rewardItems")
      .where("status", "==", "allocated")
      .where("expiresAt", ">=", admin.firestore.Timestamp.fromDate(in3h))
      .where("expiresAt", "<=", admin.firestore.Timestamp.fromDate(in4h))
      .limit(200)
      .get();

    // Batch-fetch unique campaignIds and userIds for 4h items
    const campaignIds4h = new Set<string>();
    const userIds4h = new Set<string>();
    for (const doc of items4h.docs) {
      const data = doc.data();
      if (data.metadata?.warning4hSent) continue;
      if (!data.allocatedToUserId) continue;
      if (data.campaignId) campaignIds4h.add(data.campaignId);
      userIds4h.add(data.allocatedToUserId);
    }

    const campaignMap4h = new Map<string, admin.firestore.DocumentData | undefined>();
    if (campaignIds4h.size > 0) {
      const campaignRefs = Array.from(campaignIds4h).map((id) => db.collection("rewardCampaigns").doc(id));
      const campaignDocs = await db.getAll(...campaignRefs);
      for (const cDoc of campaignDocs) {
        campaignMap4h.set(cDoc.id, cDoc.exists ? cDoc.data() : undefined);
      }
    }

    const userMap4h = new Map<string, admin.firestore.DocumentData | undefined>();
    if (userIds4h.size > 0) {
      const userRefs = Array.from(userIds4h).map((id) => db.collection("users").doc(id));
      const userDocs = await db.getAll(...userRefs);
      for (const uDoc of userDocs) {
        userMap4h.set(uDoc.id, uDoc.exists ? uDoc.data() : undefined);
      }
    }

    for (const doc of items4h.docs) {
      const data = doc.data();

      // Skip if 4h warning already sent
      if (data.metadata?.warning4hSent) continue;

      const userId = data.allocatedToUserId;
      if (!userId) continue;

      try {
        // Get campaign name from batch-fetched map
        const campaignData = campaignMap4h.get(data.campaignId);
        const campaignName = campaignData?.name || "your reward";

        // Get FCM token from batch-fetched map
        const userData = userMap4h.get(userId);
        const fcmToken = userData?.fcmToken;

        if (fcmToken) {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Last Chance!",
              body: `Your ${campaignName} expires in 4 hours. Use it now!`,
            },
            data: {
              type: "reward_expiry_urgent",
              itemId: doc.id,
              campaignId: data.campaignId,
            },
          });
        }

        await doc.ref.update({
          "metadata.warning4hSent": true,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        sent4h++;
      } catch (err) {
        logger.warn("Failed to send 4h expiry warning", {
          itemId: doc.id,
          error: err,
        });
      }
    }

    if (sent48h > 0 || sent4h > 0) {
      logger.info("Expiry warnings sent", { sent48h, sent4h });
    }

  }
);

// ============================================================================
// 4. RELEASE STALE RESERVATIONS (every 15 minutes)
// ============================================================================

/**
 * Release reward reservations for engagements that are stale (>30 min, not completed).
 * Handles edge cases: user starts engagement, app crashes, reservation sits forever.
 * Same concept as escrow timeout for tokens.
 */
export const releaseStaleRewardReservations = onSchedule(
  { schedule: "*/15 * * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "rewards" } },
  async () => {
    const staleThreshold = new Date(Date.now() - 30 * 60 * 1000);
    let releasedCount = 0;

    const staleReserved = await db
      .collection("rewardItems")
      .where("status", "==", "reserved")
      .where("reservedAt", "<", admin.firestore.Timestamp.fromDate(staleThreshold))
      .limit(100)
      .get();

    for (const doc of staleReserved.docs) {
      const data = doc.data();
      try {
        await releaseRewardReservation(
          doc.id,
          data.reservedForEngagementId
        );
        releasedCount++;
      } catch (err) {
        logger.warn("Failed to release stale reservation", {
          itemId: doc.id,
          error: err,
        });
      }
    }

    if (releasedCount > 0) {
      logger.info("Released stale reward reservations", {
        releasedCount,
      });
    }

  }
);
