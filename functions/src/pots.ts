/**
 * Pot-related Cloud Functions
 * Handles daily and weekly pot draws
 *
 * Collections used:
 * - pots: Main pot pool documents
 * - potEntries: User entries for weighted random selection
 * - potWinners: Historical winner records
 * - leaderboards/{type}/scores: User scores for daily/weekly/allTime
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Initialize daily pot at midnight SAST
 */
export const initializeDailyPot = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const potId = `daily_${today.getTime()}`;
    const potRef = db.collection("pots").doc(potId);

    // Check if pot already exists
    const existing = await potRef.get();
    if (existing.exists) {
      console.log(`Daily pot ${potId} already exists`);
      return null;
    }

    // Create new daily pot with Flutter-compatible structure
    await potRef.set({
      id: potId,
      type: "daily",
      totalTokens: 0,
      participantCount: 0,
      periodStart: admin.firestore.Timestamp.fromDate(today),
      periodEnd: admin.firestore.Timestamp.fromDate(tomorrow),
      isActive: true,
      isDistributed: false,
      distributedAt: null,
      winners: [],
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Reset daily leaderboard scores
    await resetDailyLeaderboard(today, tomorrow);

    console.log(`Created daily pot: ${potId}`);
    return null;
  });

/**
 * Initialize weekly pot on Monday at midnight SAST
 */
export const initializeWeeklyPot = functions.pubsub
  .schedule("0 0 * * 1") // Monday at midnight
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const today = new Date();
    const weekStart = getWeekStart(today);
    weekStart.setHours(0, 0, 0, 0);
    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekEnd.getDate() + 7);

    const potId = `weekly_${weekStart.getTime()}`;
    const potRef = db.collection("pots").doc(potId);

    // Check if pot already exists
    const existing = await potRef.get();
    if (existing.exists) {
      console.log(`Weekly pot ${potId} already exists`);
      return null;
    }

    // Create new weekly pot with Flutter-compatible structure
    await potRef.set({
      id: potId,
      type: "weekly",
      totalTokens: 0,
      participantCount: 0,
      periodStart: admin.firestore.Timestamp.fromDate(weekStart),
      periodEnd: admin.firestore.Timestamp.fromDate(weekEnd),
      isActive: true,
      isDistributed: false,
      distributedAt: null,
      winners: [],
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Reset weekly leaderboard scores
    await resetWeeklyLeaderboard(weekStart, weekEnd);

    console.log(`Created weekly pot: ${potId}`);
    return null;
  });

/**
 * Run daily pot draw at 8 PM SAST
 */
export const runDailyPotDraw = functions.pubsub
  .schedule("0 20 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    // Find today's active pot
    const potQuery = await db.collection("pots")
      .where("type", "==", "daily")
      .where("isActive", "==", true)
      .where("periodStart", ">=", admin.firestore.Timestamp.fromDate(today))
      .where("periodStart", "<", admin.firestore.Timestamp.fromDate(tomorrow))
      .limit(1)
      .get();

    if (potQuery.empty) {
      console.log("No active daily pot found for today");
      return null;
    }

    const potDoc = potQuery.docs[0];
    const potData = potDoc.data();

    // Get leaderboard scores for today
    const scoresSnapshot = await db.collection("leaderboards")
      .doc("daily")
      .collection("scores")
      .where("periodStart", ">=", admin.firestore.Timestamp.fromDate(today))
      .where("periodStart", "<", admin.firestore.Timestamp.fromDate(tomorrow))
      .orderBy("periodStart")
      .orderBy("totalTokensEarned", "desc")
      .limit(10)
      .get();

    if (scoresSnapshot.empty) {
      console.log("No participants in daily pot");
      await potDoc.ref.update({
        isActive: false,
        isDistributed: true,
        distributedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return null;
    }

    // Calculate pot total from all participants
    const totalTokens = potData.totalTokens || 10000; // Base prize if no contributions

    // Distribution percentages for top 10
    const percentages = [30.0, 20.0, 15.0, 10.0, 8.0, 6.0, 5.0, 3.0, 2.0, 1.0];

    // Build winners array
    const winners: PotWinner[] = [];
    const batch = db.batch();

    for (let i = 0; i < scoresSnapshot.docs.length && i < 10; i++) {
      const scoreDoc = scoresSnapshot.docs[i];
      const scoreData = scoreDoc.data();
      const percentage = percentages[i];
      const tokensWon = Math.round(totalTokens * percentage / 100);

      const winner: PotWinner = {
        userId: scoreData.userId,
        displayName: scoreData.displayName || "User",
        username: scoreData.username || null,
        rank: i + 1,
        tokensWon: tokensWon,
        percentage: percentage,
      };
      winners.push(winner);

      // Credit winner's wallet
      const walletQuery = await db.collection("wallets")
        .where("userId", "==", scoreData.userId)
        .limit(1)
        .get();

      if (!walletQuery.empty) {
        const walletDoc = walletQuery.docs[0];
        batch.update(walletDoc.ref, {
          tokenBalance: admin.firestore.FieldValue.increment(tokensWon),
          lifetimeEarned: admin.firestore.FieldValue.increment(tokensWon),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Create transaction record
        const txRef = db.collection("transactions").doc();
        batch.set(txRef, {
          id: txRef.id,
          walletId: walletDoc.id,
          userId: scoreData.userId,
          type: "potWin",
          tokenAmount: tokensWon,
          zarAmount: tokensWon * 0.01,
          description: `Daily pot winner - Rank #${i + 1}`,
          status: "completed",
          referenceId: potDoc.id,
          referenceType: "pot",
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Create pot winner record
        const winnerRef = db.collection("potWinners").doc();
        batch.set(winnerRef, {
          id: winnerRef.id,
          potId: potDoc.id,
          potType: "daily",
          userId: scoreData.userId,
          displayName: scoreData.displayName,
          rank: i + 1,
          tokensWon: tokensWon,
          percentage: percentage,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    }

    // Update pot with winners
    batch.update(potDoc.ref, {
      isActive: false,
      isDistributed: true,
      distributedAt: admin.firestore.FieldValue.serverTimestamp(),
      winners: winners,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();

    console.log(`Daily pot draw completed. ${winners.length} winners, ${totalTokens} tokens distributed`);
    return null;
  });

/**
 * Run weekly pot draw on Sundays at 8 PM SAST
 */
export const runWeeklyPotDraw = functions.pubsub
  .schedule("0 20 * * 0")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const today = new Date();
    const weekStart = getWeekStart(today);
    weekStart.setHours(0, 0, 0, 0);
    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekEnd.getDate() + 7);

    // Find this week's active pot
    const potQuery = await db.collection("pots")
      .where("type", "==", "weekly")
      .where("isActive", "==", true)
      .where("periodStart", ">=", admin.firestore.Timestamp.fromDate(weekStart))
      .where("periodStart", "<", admin.firestore.Timestamp.fromDate(weekEnd))
      .limit(1)
      .get();

    if (potQuery.empty) {
      console.log("No active weekly pot found");
      return null;
    }

    const potDoc = potQuery.docs[0];
    const potData = potDoc.data();

    // Get leaderboard scores for this week
    const scoresSnapshot = await db.collection("leaderboards")
      .doc("weekly")
      .collection("scores")
      .where("periodStart", ">=", admin.firestore.Timestamp.fromDate(weekStart))
      .where("periodStart", "<", admin.firestore.Timestamp.fromDate(weekEnd))
      .orderBy("periodStart")
      .orderBy("totalTokensEarned", "desc")
      .limit(10)
      .get();

    if (scoresSnapshot.empty) {
      console.log("No participants in weekly pot");
      await potDoc.ref.update({
        isActive: false,
        isDistributed: true,
        distributedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return null;
    }

    // Calculate pot total
    const totalTokens = potData.totalTokens || 50000; // Base prize for weekly

    // Distribution percentages for top 10
    const percentages = [30.0, 20.0, 15.0, 10.0, 8.0, 6.0, 5.0, 3.0, 2.0, 1.0];

    // Build winners array
    const winners: PotWinner[] = [];
    const batch = db.batch();

    for (let i = 0; i < scoresSnapshot.docs.length && i < 10; i++) {
      const scoreDoc = scoresSnapshot.docs[i];
      const scoreData = scoreDoc.data();
      const percentage = percentages[i];
      const tokensWon = Math.round(totalTokens * percentage / 100);

      const winner: PotWinner = {
        userId: scoreData.userId,
        displayName: scoreData.displayName || "User",
        username: scoreData.username || null,
        rank: i + 1,
        tokensWon: tokensWon,
        percentage: percentage,
      };
      winners.push(winner);

      // Credit winner's wallet
      const walletQuery = await db.collection("wallets")
        .where("userId", "==", scoreData.userId)
        .limit(1)
        .get();

      if (!walletQuery.empty) {
        const walletDoc = walletQuery.docs[0];
        batch.update(walletDoc.ref, {
          tokenBalance: admin.firestore.FieldValue.increment(tokensWon),
          lifetimeEarned: admin.firestore.FieldValue.increment(tokensWon),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Create transaction record
        const txRef = db.collection("transactions").doc();
        batch.set(txRef, {
          id: txRef.id,
          walletId: walletDoc.id,
          userId: scoreData.userId,
          type: "potWin",
          tokenAmount: tokensWon,
          zarAmount: tokensWon * 0.01,
          description: `Weekly pot winner - Rank #${i + 1}`,
          status: "completed",
          referenceId: potDoc.id,
          referenceType: "pot",
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Create pot winner record
        const winnerRef = db.collection("potWinners").doc();
        batch.set(winnerRef, {
          id: winnerRef.id,
          potId: potDoc.id,
          potType: "weekly",
          userId: scoreData.userId,
          displayName: scoreData.displayName,
          rank: i + 1,
          tokensWon: tokensWon,
          percentage: percentage,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    }

    // Update pot with winners
    batch.update(potDoc.ref, {
      isActive: false,
      isDistributed: true,
      distributedAt: admin.firestore.FieldValue.serverTimestamp(),
      winners: winners,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();

    console.log(`Weekly pot draw completed. ${winners.length} winners, ${totalTokens} tokens distributed`);
    return null;
  });

/**
 * Reset daily leaderboard scores for a new day
 */
async function resetDailyLeaderboard(periodStart: Date, periodEnd: Date): Promise<void> {
  // The daily leaderboard will be populated as users earn tokens
  // This just ensures the structure exists
  const dailyRef = db.collection("leaderboards").doc("daily");
  await dailyRef.set({
    type: "daily",
    periodStart: admin.firestore.Timestamp.fromDate(periodStart),
    periodEnd: admin.firestore.Timestamp.fromDate(periodEnd),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });
}

/**
 * Reset weekly leaderboard scores for a new week
 */
async function resetWeeklyLeaderboard(periodStart: Date, periodEnd: Date): Promise<void> {
  const weeklyRef = db.collection("leaderboards").doc("weekly");
  await weeklyRef.set({
    type: "weekly",
    periodStart: admin.firestore.Timestamp.fromDate(periodStart),
    periodEnd: admin.firestore.Timestamp.fromDate(periodEnd),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });
}

// Helper functions
function getWeekStart(date: Date): Date {
  const d = new Date(date);
  const day = d.getDay();
  const diff = d.getDate() - day + (day === 0 ? -6 : 1); // Monday
  return new Date(d.setDate(diff));
}

// Types
interface PotWinner {
  userId: string;
  displayName: string;
  username: string | null;
  rank: number;
  tokensWon: number;
  percentage: number;
}
