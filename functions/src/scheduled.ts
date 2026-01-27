/**
 * Scheduled Cloud Functions
 * Regular maintenance and cleanup tasks
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Update leaderboard rankings daily at midnight
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

    walletsSnapshot.docs.forEach((doc, index) => {
      const data = doc.data();
      const scoreRef = db.collection("leaderboard").doc(data.oddienceUserId);

      batch.set(scoreRef, {
        oddienceUserId: data.oddienceUserId,
        totalScore: data.lifetimeEarned || 0,
        rank: index + 1,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });
    });

    await batch.commit();
    console.log(`Updated leaderboard with ${walletsSnapshot.size} entries`);
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
      .where("oddienceUserId", "==", cashout.oddienceUserId)
      .limit(1)
      .get();

    if (!walletQuery.empty) {
      transaction.update(walletQuery.docs[0].ref, {
        pendingCashout: admin.firestore.FieldValue.increment(-cashout.tokenAmount),
        lifetimeCashout: admin.firestore.FieldValue.increment(cashout.tokenAmount),
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
