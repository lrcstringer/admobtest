/**
 * Scheduled Cloud Functions
 * Regular maintenance and cleanup tasks
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { reverseJournal } from "./ledger";
import { EscrowConfig } from "./ledger/types";

const db = admin.firestore();

/**
 * Update all-time leaderboard rankings daily at midnight
 * Uses leaderboards/allTime/scores subcollection for Flutter compatibility
 */
export const updateLeaderboard = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
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

    // Update scores in the subcollection
    for (let index = 0; index < walletsSnapshot.docs.length; index++) {
      const doc = walletsSnapshot.docs[index];
      const data = doc.data();

      // Get user profile for display name
      let displayName = "User";
      let username: string | null = null;
      let avatarUrl: string | null = null;

      try {
        const userDoc = await db.collection("users").doc(data.userId).get();
        if (userDoc.exists) {
          const userData = userDoc.data();
          displayName = userData?.profile?.displayName || userData?.displayName || "User";
          username = userData?.profile?.username || userData?.username || null;
          avatarUrl = userData?.profile?.avatarUrl || userData?.avatarUrl || null;
        }
      } catch (e) {
        console.log(`Could not fetch user profile for ${data.userId}`);
      }

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
    console.log(`Updated allTime leaderboard with ${walletsSnapshot.size} entries`);
    return null;
  });

/**
 * Cleanup old pot entries (older than 30 days)
 */
export const cleanupOldPotEntries = functions.pubsub
  .schedule("0 2 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    const cutoffDate = thirtyDaysAgo.toISOString().split("T")[0];

    const oldEntries = await db.collection("potEntries")
      .where("date", "<", cutoffDate)
      .limit(500)
      .get();

    if (oldEntries.empty) {
      console.log("No old pot entries to clean up");
      return null;
    }

    const batch = db.batch();
    oldEntries.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });

    await batch.commit();
    console.log(`Cleaned up ${oldEntries.size} old pot entries`);
    return null;
  });

/**
 * Process pending cashouts (run every hour)
 * In production, this would integrate with a payment provider
 */
export const processPendingCashouts = functions.pubsub
  .schedule("0 * * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const pendingCashouts = await db.collection("cashouts")
      .where("status", "==", "pending")
      .limit(50)
      .get();

    if (pendingCashouts.empty) {
      console.log("No pending cashouts to process");
      return null;
    }

    for (const doc of pendingCashouts.docs) {
      const cashout = doc.data();

      try {
        // In production, this would call a payment API
        // For now, we'll simulate processing
        await simulateCashoutProcessing(doc.ref, cashout);
      } catch (error) {
        console.error(`Failed to process cashout ${doc.id}:`, error);
      }
    }

    return null;
  });

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

  console.log(`Processed cashout ${cashoutRef.id} for ${cashout.zarAmount} ZAR`);
}

/**
 * Send daily earning reminder at 6 PM
 */
export const sendEarningReminder = functions.pubsub
  .schedule("0 18 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    // Get users who haven't earned today
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const walletsWithoutEarnings = await db.collection("wallets")
      .where("lastEarnedAt", "<", admin.firestore.Timestamp.fromDate(today))
      .limit(1000)
      .get();

    // In production, send push notifications
    // For now, just log
    console.log(`${walletsWithoutEarnings.size} users haven't earned today`);

    // TODO: Integrate with FCM to send push notifications

    return null;
  });

/**
 * Generate weekly statistics report
 */
export const generateWeeklyStats = functions.pubsub
  .schedule("0 0 * * 1") // Monday at midnight
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
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

    console.log(`Weekly stats generated: ${transactionsSnapshot.size} transactions`);
    return null;
  });

/**
 * Cleanup abandoned escrows — auto-abandon stale engagements and reverse
 * their escrow reservations so tokens return to the campaign source account.
 *
 * Runs every 15 minutes. Processes engagements that have been in an active
 * status for longer than the escrow TTL (2 hours).
 */
export const cleanupAbandonedEscrows = functions.pubsub
  .schedule(EscrowConfig.CLEANUP_INTERVAL_CRON)
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
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

            await doc.ref.update({
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
              console.warn(
                `Escrow reversal returned failure for engagement ${doc.id}: ${reversalResult.error}`
              );
            }
          } catch (error) {
            totalFailed++;
            console.error(
              `Failed to reverse escrow for engagement ${doc.id}:`,
              error
            );
            // Still mark as abandoned so it doesn't keep retrying forever
            await doc.ref.update({
              status: "abandoned",
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
              escrowReversalFailed: true,
              escrowReversalReason: "ttl_expired_error",
            });
          }
        } else {
          // No escrow or already reversed — just abandon
          await doc.ref.update({
            status: "abandoned",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            escrowReversalReason: engagement.escrowJournalId
              ? "ttl_expired_already_reversed"
              : "ttl_expired_no_escrow",
          });
        }
      }
    }

    console.log(
      `Escrow cleanup: processed=${totalProcessed}, reversed=${totalReversed}, failed=${totalFailed}`
    );
    return null;
  });
