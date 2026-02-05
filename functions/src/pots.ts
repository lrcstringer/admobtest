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
import {
  processPotWin,
  getBalance,
  SystemAccounts,
  getOrCreateDefaultSubAccount,
} from "./ledger";
import { buildPotLeaderboard, getPotLeaderboardEntries } from "./dailyScores";
import { getSASTDateString } from "./engagementStats";

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
 *
 * NEW FLOW:
 * 1. Build pot leaderboard from dailyScores (ordered by finalScore DESC, updatedAt ASC)
 * 2. Get top 10 entries from the leaderboard
 * 3. Credit winner's default sub-accounts through the ledger
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

    // Get today's date in SAST format for the dailyScores query
    const dateKey = getSASTDateString();

    // Build the pot leaderboard from dailyScores
    // This queries users/{}/dailyScores/{date} ordered by finalScore DESC, updatedAt ASC
    const leaderboardResult = await buildPotLeaderboard(
      potDoc.id,
      "daily",
      dateKey,
      100 // Build top 100 for the leaderboard
    );

    if (leaderboardResult.total === 0) {
      console.log("No participants in daily pot");
      await potDoc.ref.update({
        isActive: false,
        isDistributed: true,
        distributedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return null;
    }

    // Get top 10 entries from the pot leaderboard
    const topEntries = await getPotLeaderboardEntries(potDoc.id, 10);

    // Get actual pot balance from the ledger (accumulated from 5% earnings split)
    const ledgerPotBalance = await getBalance(SystemAccounts.DAILY_POT);
    // Use ledger balance if available, otherwise use tracked total or base prize
    const totalTokens = ledgerPotBalance > 0 ? ledgerPotBalance : (potData.totalTokens || 10000);

    // Distribution percentages for top 10
    const percentages = [30.0, 20.0, 15.0, 10.0, 8.0, 6.0, 5.0, 3.0, 2.0, 1.0];

    // Build winners array and process through ledger
    const winners: PotWinner[] = [];
    const batch = db.batch();

    for (let i = 0; i < topEntries.length && i < 10; i++) {
      const entry = topEntries[i];
      const percentage = percentages[i];
      const tokensWon = Math.round(totalTokens * percentage / 100);

      if (tokensWon <= 0) continue;

      const winner: PotWinner = {
        userId: entry.userId,
        displayName: entry.displayName || "User",
        username: entry.username || null,
        rank: i + 1,
        tokensWon: tokensWon,
        percentage: percentage,
        finalScore: entry.finalScore,
      };
      winners.push(winner);

      // Get or create winner's default sub-account
      const { subAccountId } = await getOrCreateDefaultSubAccount(entry.userId);

      // Process pot win through the Trust Ledger system
      // This transfers tokens from pot:daily account to user's sub-account
      const ledgerResult = await processPotWin(
        "daily",
        entry.userId,
        tokensWon,
        potDoc.id,
        subAccountId, // Credit to winner's default sub-account
        {
          rank: i + 1,
          percentage: percentage,
          displayName: entry.displayName,
          finalScore: entry.finalScore,
        }
      );

      if (!ledgerResult.success) {
        console.error(`Failed to process pot win for user ${entry.userId}:`, ledgerResult.error);
        continue;
      }

      // Create pot winner record with ledger reference
      const winnerRef = db.collection("potWinners").doc();
      batch.set(winnerRef, {
        id: winnerRef.id,
        potId: potDoc.id,
        potType: "daily",
        userId: entry.userId,
        displayName: entry.displayName,
        rank: i + 1,
        tokensWon: tokensWon,
        percentage: percentage,
        finalScore: entry.finalScore,
        subAccountId: subAccountId,
        ledgerJournalId: ledgerResult.journalId,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // Update pot with winners
    batch.update(potDoc.ref, {
      isActive: false,
      isDistributed: true,
      distributedAt: admin.firestore.FieldValue.serverTimestamp(),
      winners: winners,
      totalParticipants: leaderboardResult.total,
      ledgerProcessed: true,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();

    console.log(`Daily pot draw completed. ${winners.length} winners, ${totalTokens} tokens distributed via ledger`);
    return null;
  });

/**
 * Run weekly pot draw on Sundays at 8 PM SAST
 *
 * NEW FLOW:
 * 1. Aggregate weekly scores from dailyScores
 * 2. Build pot leaderboard
 * 3. Credit winner's default sub-accounts through the ledger
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

    // Get the week key for leaderboard
    const weekKey = getWeekKey(weekStart);

    // Build weekly pot leaderboard by aggregating daily scores
    // For weekly, we query all dailyScores from Mon-Sun and aggregate
    const weekStartStr = weekStart.toISOString().split("T")[0];
    const aggregatedScores = await aggregateWeeklyScoresFromDailyScores(weekStartStr);

    if (aggregatedScores.length === 0) {
      console.log("No participants in weekly pot");
      await potDoc.ref.update({
        isActive: false,
        isDistributed: true,
        distributedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return null;
    }

    // Create weekly pot leaderboard document
    const leaderboardRef = db.collection("potLeaderboards").doc(potDoc.id);
    const now = admin.firestore.Timestamp.now();

    await leaderboardRef.set({
      potId: potDoc.id,
      potType: "weekly",
      dateKey: weekKey,
      totalParticipants: aggregatedScores.length,
      createdAt: now,
    });

    // Write top 100 entries to leaderboard
    const leaderboardBatch = db.batch();
    for (let i = 0; i < Math.min(aggregatedScores.length, 100); i++) {
      const entry = aggregatedScores[i];
      const rankStr = (i + 1).toString().padStart(4, "0");
      const entryRef = leaderboardRef.collection("entries").doc(rankStr);
      leaderboardBatch.set(entryRef, {
        rank: i + 1,
        userId: entry.userId,
        displayName: entry.displayName,
        username: entry.username,
        avatarUrl: entry.avatarUrl,
        finalScore: entry.totalScore,
        engagementsCompleted: entry.totalEngagements,
        createdAt: now,
      });
    }
    await leaderboardBatch.commit();

    // Get actual pot balance from the ledger (accumulated from 5% earnings split)
    const ledgerPotBalance = await getBalance(SystemAccounts.WEEKLY_POT);
    // Use ledger balance if available, otherwise use tracked total or base prize
    const totalTokens = ledgerPotBalance > 0 ? ledgerPotBalance : (potData.totalTokens || 50000);

    // Distribution percentages for top 10
    const percentages = [30.0, 20.0, 15.0, 10.0, 8.0, 6.0, 5.0, 3.0, 2.0, 1.0];

    // Build winners array and process through ledger
    const winners: PotWinner[] = [];
    const batch = db.batch();

    const topEntries = aggregatedScores.slice(0, 10);
    for (let i = 0; i < topEntries.length; i++) {
      const entry = topEntries[i];
      const percentage = percentages[i];
      const tokensWon = Math.round(totalTokens * percentage / 100);

      if (tokensWon <= 0) continue;

      const winner: PotWinner = {
        userId: entry.userId,
        displayName: entry.displayName || "User",
        username: entry.username || null,
        rank: i + 1,
        tokensWon: tokensWon,
        percentage: percentage,
        finalScore: entry.totalScore,
      };
      winners.push(winner);

      // Get or create winner's default sub-account
      const { subAccountId } = await getOrCreateDefaultSubAccount(entry.userId);

      // Process pot win through the Trust Ledger system
      // This transfers tokens from pot:weekly account to user's sub-account
      const ledgerResult = await processPotWin(
        "weekly",
        entry.userId,
        tokensWon,
        potDoc.id,
        subAccountId, // Credit to winner's default sub-account
        {
          rank: i + 1,
          percentage: percentage,
          displayName: entry.displayName,
          finalScore: entry.totalScore,
        }
      );

      if (!ledgerResult.success) {
        console.error(`Failed to process pot win for user ${entry.userId}:`, ledgerResult.error);
        continue;
      }

      // Create pot winner record with ledger reference
      const winnerRef = db.collection("potWinners").doc();
      batch.set(winnerRef, {
        id: winnerRef.id,
        potId: potDoc.id,
        potType: "weekly",
        userId: entry.userId,
        displayName: entry.displayName,
        rank: i + 1,
        tokensWon: tokensWon,
        percentage: percentage,
        finalScore: entry.totalScore,
        subAccountId: subAccountId,
        ledgerJournalId: ledgerResult.journalId,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // Update pot with winners
    batch.update(potDoc.ref, {
      isActive: false,
      isDistributed: true,
      distributedAt: admin.firestore.FieldValue.serverTimestamp(),
      winners: winners,
      totalParticipants: aggregatedScores.length,
      ledgerProcessed: true,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();

    console.log(`Weekly pot draw completed. ${winners.length} winners, ${totalTokens} tokens distributed via ledger`);
    return null;
  });

/**
 * Reset daily leaderboard scores for a new day
 * Clears all previous scores so rankings start fresh
 */
async function resetDailyLeaderboard(periodStart: Date, periodEnd: Date): Promise<void> {
  const dailyRef = db.collection("leaderboards").doc("daily");

  // Delete all previous day's scores
  const oldScores = await dailyRef.collection("scores").limit(500).get();
  if (!oldScores.empty) {
    const batch = db.batch();
    oldScores.docs.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
    console.log(`Cleared ${oldScores.size} daily leaderboard scores`);
  }

  await dailyRef.set({
    type: "daily",
    periodStart: admin.firestore.Timestamp.fromDate(periodStart),
    periodEnd: admin.firestore.Timestamp.fromDate(periodEnd),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });
}

/**
 * Reset weekly leaderboard scores for a new week
 * Clears all previous scores so rankings start fresh
 */
async function resetWeeklyLeaderboard(periodStart: Date, periodEnd: Date): Promise<void> {
  const weeklyRef = db.collection("leaderboards").doc("weekly");

  // Delete all previous week's scores
  const oldScores = await weeklyRef.collection("scores").limit(500).get();
  if (!oldScores.empty) {
    const batch = db.batch();
    oldScores.docs.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
    console.log(`Cleared ${oldScores.size} weekly leaderboard scores`);
  }

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

/**
 * Get week key in ISO format (e.g., "2024-W03")
 */
function getWeekKey(date: Date): string {
  const year = date.getFullYear();
  const firstDayOfYear = new Date(year, 0, 1);
  const daysSinceStart = Math.floor(
    (date.getTime() - firstDayOfYear.getTime()) / (24 * 60 * 60 * 1000)
  );
  const weekNumber = Math.ceil((daysSinceStart + firstDayOfYear.getDay() + 1) / 7);
  return `${year}-W${weekNumber.toString().padStart(2, "0")}`;
}

/**
 * Aggregate weekly scores from dailyScores collection
 * Queries all 7 days of the week and sums up finalScores
 */
async function aggregateWeeklyScoresFromDailyScores(
  weekStartDate: string
): Promise<AggregatedScore[]> {
  const aggregated = new Map<string, {
    userId: string;
    totalScore: number;
    totalEngagements: number;
    displayName: string;
    username: string | null;
    avatarUrl: string | null;
  }>();

  // Get all 7 days of the week
  const startDate = new Date(weekStartDate + "T00:00:00Z");
  const dates: string[] = [];
  for (let i = 0; i < 7; i++) {
    const d = new Date(startDate.getTime() + i * 24 * 60 * 60 * 1000);
    dates.push(d.toISOString().split("T")[0]);
  }

  // Query each day and aggregate
  for (const date of dates) {
    const snapshot = await db
      .collectionGroup("dailyScores")
      .where("date", "==", date)
      .get();

    for (const doc of snapshot.docs) {
      const userId = doc.ref.parent.parent?.id;
      if (!userId) continue;

      const score = doc.data();
      const existing = aggregated.get(userId) || {
        userId,
        totalScore: 0,
        totalEngagements: 0,
        displayName: score.displayName || "User",
        username: score.username || null,
        avatarUrl: score.avatarUrl || null,
      };

      aggregated.set(userId, {
        userId,
        totalScore: existing.totalScore + (score.finalScore || 0),
        totalEngagements: existing.totalEngagements + (score.engagementsCompleted || 0),
        displayName: score.displayName || existing.displayName,
        username: score.username || existing.username,
        avatarUrl: score.avatarUrl || existing.avatarUrl,
      });
    }
  }

  // Sort by totalScore DESC
  const sorted = Array.from(aggregated.values())
    .filter((s) => s.totalScore > 0)
    .sort((a, b) => b.totalScore - a.totalScore);

  return sorted;
}

// Types
interface PotWinner {
  userId: string;
  displayName: string;
  username: string | null;
  rank: number;
  tokensWon: number;
  percentage: number;
  finalScore?: number;
}

interface AggregatedScore {
  userId: string;
  totalScore: number;
  totalEngagements: number;
  displayName: string;
  username: string | null;
  avatarUrl: string | null;
}
