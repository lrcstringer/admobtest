/**
 * Scheduled Cloud Functions
 * Regular maintenance and cleanup tasks
 */

import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { reverseJournal } from "./ledger";
import { EscrowConfig } from "./ledger/types";

const db = admin.firestore();

/**
 * Update all-time leaderboard rankings daily at midnight
 * Uses leaderboards/allTime/scores subcollection for Flutter compatibility
 */
export const updateLeaderboard = onSchedule(
  { schedule: "0 0 * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", timeoutSeconds: 180, labels: { area: "lifecycle" } },
  async () => {
    // Get all users with their lifetime earnings
    const walletsSnapshot = await db.collection("wallets")
      .orderBy("lifetimeEarned", "desc")
      .limit(100)
      .get();

    const batch = db.batch();
    const now = new Date();

    // Ensure the allTime leaderboard document exists
    const allTimeRef = db.collection("leaderboards").doc("allTime");
    batch.set(allTimeRef, {
      type: "allTime",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });

    // Fetch all user profiles in parallel (was serial — saves ~2-5s for 100 users)
    const userRefs = walletsSnapshot.docs.map((doc) =>
      db.collection("users").doc(doc.data().userId)
    );
    const userDocs = userRefs.length > 0 ? await db.getAll(...userRefs) : [];
    const userDataMap = new Map<string, FirebaseFirestore.DocumentData>();
    for (const userDoc of userDocs) {
      if (userDoc.exists) {
        userDataMap.set(userDoc.id, userDoc.data()!);
      }
    }

    // Update scores in the subcollection
    for (let index = 0; index < walletsSnapshot.docs.length; index++) {
      const doc = walletsSnapshot.docs[index];
      const data = doc.data();
      const userData = userDataMap.get(data.userId);

      const displayName = userData?.profile?.displayName || userData?.displayName || "User";
      const username = userData?.profile?.username || userData?.username || null;
      const avatarUrl = userData?.profile?.avatarUrl || userData?.avatarUrl || null;

      const scoreRef = db.collection("leaderboards")
        .doc("allTime")
        .collection("scores")
        .doc(data.userId);

      batch.set(scoreRef, {
        userId: data.userId,
        displayName: displayName,
        username: username,
        avatarUrl: avatarUrl,
        totalTokensEarned: data.lifetimeEarned || 0,
        rank: index + 1,
        engagementsCompleted: data.totalEngagements || 0,
        currentStreak: data.currentStreak || 0,
        longestStreak: data.longestStreak || 0,
        periodStart: admin.firestore.Timestamp.fromDate(new Date(0)), // Epoch for all-time
        periodEnd: admin.firestore.Timestamp.fromDate(now),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });
    }

    await batch.commit();
    logger.info(`Updated allTime leaderboard with ${walletsSnapshot.size} entries`);
  }
);

/**
 * Cleanup old pot entries (older than 30 days)
 */
export const cleanupOldPotEntries = onSchedule(
  { schedule: "0 2 * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "lifecycle" } },
  async () => {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    const cutoffDate = thirtyDaysAgo.toISOString().split("T")[0];

    const oldEntries = await db.collection("potEntries")
      .where("date", "<", cutoffDate)
      .limit(500)
      .get();

    if (oldEntries.empty) {
      logger.info("No old pot entries to clean up");
      return;
    }

    const batch = db.batch();
    oldEntries.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });

    await batch.commit();
    logger.info(`Cleaned up ${oldEntries.size} old pot entries`);
  }
);

/**
 * Process pending cashouts (run every hour)
 * In production, this would integrate with a payment provider
 */
export const processPendingCashouts = onSchedule(
  { schedule: "0 * * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "lifecycle" } },
  async () => {
    const pendingCashouts = await db.collection("cashouts")
      .where("status", "==", "pending")
      .limit(50)
      .get();

    if (pendingCashouts.empty) {
      logger.info("No pending cashouts to process");
      return;
    }

    for (const doc of pendingCashouts.docs) {
      const cashout = doc.data();

      try {
        // In production, this would call a payment API
        // For now, we'll simulate processing
        await simulateCashoutProcessing(doc.ref, cashout);
      } catch (error) {
        logger.error(`Failed to process cashout ${doc.id}:`, error);
      }
    }
  }
);

async function simulateCashoutProcessing(
  cashoutRef: FirebaseFirestore.DocumentReference,
  cashout: FirebaseFirestore.DocumentData
) {
  // Simulate processing delay
  await new Promise((resolve) => setTimeout(resolve, 100));

  // Update cashout status
  await db.runTransaction(async (transaction) => {
    transaction.update(cashoutRef, {
      status: "completed",
      processedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update wallet pending cashout
    const walletQuery = await db.collection("wallets")
      .where("userId", "==", cashout.userId)
      .limit(1)
      .get();

    if (!walletQuery.empty) {
      transaction.update(walletQuery.docs[0].ref, {
        pendingWithdrawal: admin.firestore.FieldValue.increment(-cashout.tokenAmount),
        lifetimeWithdrawn: admin.firestore.FieldValue.increment(cashout.tokenAmount),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // Update transaction status
    const txQuery = await db.collection("transactions")
      .where("referenceId", "==", cashoutRef.id)
      .where("referenceType", "==", "cashout")
      .limit(1)
      .get();

    if (!txQuery.empty) {
      transaction.update(txQuery.docs[0].ref, {
        status: "completed",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
  });

  logger.info(`Processed cashout ${cashoutRef.id} for ${cashout.zarAmount} ZAR`);
}

/**
 * Send daily earning reminder at 6 PM
 */
export const sendEarningReminder = onSchedule(
  { schedule: "0 18 * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "lifecycle" } },
  async () => {
    // Get users who haven't earned today
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const walletsWithoutEarnings = await db.collection("wallets")
      .where("lastEarnedAt", "<", admin.firestore.Timestamp.fromDate(today))
      .limit(1000)
      .get();

    // In production, send push notifications
    // For now, just log
    logger.info(`${walletsWithoutEarnings.size} users haven't earned today`);

    // TODO: Integrate with FCM to send push notifications
  }
);

/**
 * Generate weekly statistics report
 */
export const generateWeeklyStats = onSchedule(
  { schedule: "0 0 * * 1", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "lifecycle" } }, // Monday at midnight
  async () => {
    const weekAgo = new Date();
    weekAgo.setDate(weekAgo.getDate() - 7);

    // Count transactions in the last week
    const transactionsSnapshot = await db.collection("transactions")
      .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(weekAgo))
      .get();

    let totalEarned = 0;
    let totalCashout = 0;
    let totalPurchases = 0;

    transactionsSnapshot.docs.forEach((doc) => {
      const data = doc.data();
      if (data.type === "earn") {
        totalEarned += data.tokenAmount || 0;
      } else if (data.type === "cashout") {
        totalCashout += Math.abs(data.tokenAmount || 0);
      } else if (data.type === "purchase") {
        totalPurchases += Math.abs(data.tokenAmount || 0);
      }
    });

    // Store weekly stats
    const statsRef = db.collection("platformStats").doc(`week_${new Date().toISOString().split("T")[0]}`);
    await statsRef.set({
      weekEnding: new Date().toISOString().split("T")[0],
      totalTransactions: transactionsSnapshot.size,
      totalTokensEarned: totalEarned,
      totalTokensCashedOut: totalCashout,
      totalTokensPurchased: totalPurchases,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    logger.info(`Weekly stats generated: ${transactionsSnapshot.size} transactions`);
  }
);

/**
 * Cleanup abandoned escrows — auto-abandon stale engagements and reverse
 * their escrow reservations so tokens return to the campaign source account.
 *
 * Runs every 15 minutes. Processes engagements that have been in an active
 * status for longer than the escrow TTL (2 hours).
 */
export const cleanupAbandonedEscrows = onSchedule(
  { schedule: EscrowConfig.CLEANUP_INTERVAL_CRON, timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "lifecycle" } },
  async () => {
    const cutoff = admin.firestore.Timestamp.fromMillis(
      Date.now() - EscrowConfig.ESCROW_TTL_MS
    );

    const activeStatuses = ["started", "watching", "surveying", "in_progress"];
    let totalProcessed = 0;
    let totalReversed = 0;
    let totalFailed = 0;

    for (const status of activeStatuses) {
      const staleEngagements = await db
        .collection("engagements")
        .where("status", "==", status)
        .where("createdAt", "<", cutoff)
        .limit(EscrowConfig.CLEANUP_BATCH_SIZE)
        .get();

      // Accumulate batch writes for status updates (up to 500 per batch)
      let batch = db.batch();
      let batchCount = 0;

      for (const doc of staleEngagements.docs) {
        const engagement = doc.data();
        totalProcessed++;

        // Only reverse escrow if one was reserved and not yet reversed
        if (engagement.escrowJournalId && !engagement.escrowReversedAt) {
          try {
            const reversalResult = await reverseJournal(
              engagement.escrowJournalId,
              "Escrow auto-expired after TTL",
              "system"
            );

            batch.update(doc.ref, {
              status: "abandoned",
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
              escrowReversedAt: admin.firestore.FieldValue.serverTimestamp(),
              escrowReversalJournalId: reversalResult.journalId || null,
              escrowReversalFailed: !reversalResult.success,
              escrowReversalReason: "ttl_expired",
            });

            if (reversalResult.success) {
              totalReversed++;
            } else {
              totalFailed++;
              logger.warn(
                `Escrow reversal returned failure for engagement ${doc.id}: ${reversalResult.error}`
              );
            }
          } catch (error) {
            totalFailed++;
            logger.error(
              `Failed to reverse escrow for engagement ${doc.id}:`,
              error
            );
            // Still mark as abandoned so it doesn't keep retrying forever
            batch.update(doc.ref, {
              status: "abandoned",
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
              escrowReversalFailed: true,
              escrowReversalReason: "ttl_expired_error",
            });
          }
        } else {
          // No escrow or already reversed — just abandon
          batch.update(doc.ref, {
            status: "abandoned",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            escrowReversalReason: engagement.escrowJournalId
              ? "ttl_expired_already_reversed"
              : "ttl_expired_no_escrow",
          });
        }

        batchCount++;
        if (batchCount >= 500) {
          await batch.commit();
          batch = db.batch();
          batchCount = 0;
        }
      }

      if (batchCount > 0) {
        await batch.commit();
      }
    }

    logger.info(
      `Escrow cleanup: processed=${totalProcessed}, reversed=${totalReversed}, failed=${totalFailed}`
    );
  }
);

/**
 * Cleanup expired disappearing messages.
 * Runs every 15 minutes. Queries messages where expiresAt < now and
 * deletedForEveryone == false, then soft-deletes them (clears content
 * and media) so they render as "This message was deleted" on clients.
 */
export const cleanupExpiredMessages = onSchedule(
  { schedule: "*/15 * * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", timeoutSeconds: 300, labels: { area: "lifecycle" } },
  async () => {
    const now = admin.firestore.Timestamp.now();
    let totalCleaned = 0;
    let totalMediaDeleted = 0;

    // Query messages with expiresAt <= now that haven't been soft-deleted yet
    const expiredMessages = await db.collectionGroup("messages")
      .where("deletedForEveryone", "==", false)
      .where("expiresAt", "<=", now)
      .limit(500)
      .get();

    if (expiredMessages.empty) {
      logger.info("cleanupExpiredMessages: no expired messages to clean");
      return;
    }

    const bucket = admin.storage().bucket();

    for (const doc of expiredMessages.docs) {
      try {
        const msgData = doc.data();
        // Extract conversationId from document path: conversations/{convId}/messages/{msgId}
        const pathParts = doc.ref.path.split("/");
        const conversationId = pathParts[1];
        const messageId = doc.id;

        // Delete media from Storage (best-effort)
        if (msgData.media) {
          const prefix = `conversations/${conversationId}`;
          const possiblePaths = [
            `${prefix}/images/${messageId}_full.jpg`,
            `${prefix}/images/${messageId}_thumb.jpg`,
            `${prefix}/images/${messageId}_full.enc`,
            `${prefix}/images/${messageId}_thumb.enc`,
            `${prefix}/voice/${messageId}.m4a`,
            `${prefix}/voice/${messageId}.enc`,
          ];
          for (const path of possiblePaths) {
            try {
              const file = bucket.file(path);
              const [exists] = await file.exists();
              if (exists) {
                await file.delete();
                totalMediaDeleted++;
              }
            } catch (err: unknown) {
              const errMsg = err instanceof Error ? err.message : String(err);
              logger.warn(`cleanupExpiredMessages: Failed to delete ${path}: ${errMsg}`);
            }
          }
        }

        // Soft-delete: clear content, mark as deleted
        await doc.ref.update({
          deletedForEveryone: true,
          deletedAt: admin.firestore.FieldValue.serverTimestamp(),
          textContent: null,
          ciphertext: null,
          media: null,
          e2ee: null,
          x3dhHeader: null,
        });

        totalCleaned++;
      } catch (err: unknown) {
        const errMsg = err instanceof Error ? err.message : String(err);
        logger.error(`cleanupExpiredMessages: Failed to clean message ${doc.id}: ${errMsg}`);
      }
    }

    logger.info(
      `cleanupExpiredMessages: cleaned=${totalCleaned}, mediaDeleted=${totalMediaDeleted}`
    );
  }
);
