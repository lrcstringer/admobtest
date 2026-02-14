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
  processPotResidual,
  getBalance,
  SystemAccounts,
  getOrCreateDefaultSubAccount,
} from "./ledger";
import { buildPotLeaderboard, getPotLeaderboardEntries } from "./dailyScores";
import { getSASTDateString } from "./engagementStats";
import { requireAppCheck } from "./security";
import { requireAdminPermission } from "./adminAuth";

const db = admin.firestore();

/**
 * Initialize daily pot at midnight SAST
 */
export const initializeDailyPot = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    return executeInitializeDailyPot();
  });

/**
 * Initialize weekly pot on Monday at midnight SAST
 */
export const initializeWeeklyPot = functions.pubsub
  .schedule("0 0 * * 1") // Monday at midnight
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    return executeInitializeWeeklyPot();
  });

/**
 * Core daily pot initialization logic, shared by the scheduled job and the admin manual trigger.
 * Returns 'created' | 'exists' | 'skipped'.
 */
async function executeInitializeDailyPot(): Promise<string> {
  const today = getSASTDayStart();
  const tomorrow = new Date(today.getTime() + 24 * 60 * 60 * 1000);

  const potId = `daily_${today.getTime()}`;
  const potRef = db.collection("pots").doc(potId);

  // Check if pot already exists
  const existing = await potRef.get();
  if (existing.exists) {
    console.log(`Daily pot ${potId} already exists`);
    return "exists";
  }

  // Deactivate any stale active daily pots (e.g. from failed draws)
  const stalePots = await db.collection("pots")
    .where("type", "==", "daily")
    .where("isActive", "==", true)
    .get();
  if (stalePots.size > 0) {
    const batch = db.batch();
    for (const doc of stalePots.docs) {
      batch.update(doc.ref, {
        isActive: false,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
    console.log(`Deactivated ${stalePots.size} stale daily pot(s)`);
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
  return "created";
}

/**
 * Core weekly pot initialization logic, shared by the scheduled job and the admin manual trigger.
 * Returns 'created' | 'exists' | 'skipped'.
 */
async function executeInitializeWeeklyPot(): Promise<string> {
  const weekStart = getSASTWeekStart();
  const weekEnd = new Date(weekStart.getTime() + 7 * 24 * 60 * 60 * 1000);

  const potId = `weekly_${weekStart.getTime()}`;
  const potRef = db.collection("pots").doc(potId);

  // Check if pot already exists
  const existing = await potRef.get();
  if (existing.exists) {
    console.log(`Weekly pot ${potId} already exists`);
    return "exists";
  }

  // Deactivate any stale active weekly pots (e.g. from failed draws)
  const stalePots = await db.collection("pots")
    .where("type", "==", "weekly")
    .where("isActive", "==", true)
    .get();
  if (stalePots.size > 0) {
    const batch = db.batch();
    for (const doc of stalePots.docs) {
      batch.update(doc.ref, {
        isActive: false,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
    console.log(`Deactivated ${stalePots.size} stale weekly pot(s)`);
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
  return "created";
}

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
    const flagDoc = await db.collection("platformSettings").doc("pots").get();
    if (flagDoc.exists && flagDoc.data()?.dailyPotAutoDistribute === false) {
      console.log("Daily pot auto-distribute disabled — skipping scheduled draw");
      return null;
    }
    return executeDailyPotDraw();
  });

/**
 * Core daily pot draw logic, shared by the scheduled job and the admin manual trigger.
 * @param potId Optional: target a specific pot by ID (admin manual trigger).
 *              When omitted, queries for today's active daily pot (scheduled trigger).
 */
async function executeDailyPotDraw(potId?: string): Promise<{ winnersCount: number; totalTokens: number } | null> {
    let potDoc: admin.firestore.QueryDocumentSnapshot | admin.firestore.DocumentSnapshot;

    if (potId) {
      // Admin manual trigger: target a specific pot
      const doc = await db.collection("pots").doc(potId).get();
      if (!doc.exists || doc.data()?.type !== "daily" || doc.data()?.isActive !== true) {
        console.log(`Pot ${potId} not found, not daily, or not active`);
        return null;
      }
      potDoc = doc;
    } else {
      // Scheduled trigger: find today's active pot
      const today = getSASTDayStart();
      const tomorrow = new Date(today.getTime() + 24 * 60 * 60 * 1000);

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
      potDoc = potQuery.docs[0];
    }
    const potData = potDoc.data()!;

    // Get the date key from the pot's periodStart (handles stale pots correctly)
    const potPeriodStart = (potData.periodStart as admin.firestore.Timestamp).toDate();
    const sastPotStart = new Date(potPeriodStart.getTime() + SAST_OFFSET_MS);
    const dateKey = `${sastPotStart.getUTCFullYear()}-${String(sastPotStart.getUTCMonth() + 1).padStart(2, "0")}-${String(sastPotStart.getUTCDate()).padStart(2, "0")}`;

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

    // Get actual pot balance from the ledger (accumulated from unrounded 5% earnings split)
    const ledgerPotBalance = await getBalance(SystemAccounts.DAILY_POT);
    // Use ledger balance if available, otherwise use tracked total or base prize
    const totalTokens = ledgerPotBalance > 0 ? ledgerPotBalance : (potData.totalTokens || 10000);

    // Distribution percentages for top 10
    const percentages = [30.0, 20.0, 15.0, 10.0, 8.0, 6.0, 5.0, 3.0, 2.0, 1.0];

    // Build winners array and process through ledger
    // Floor each winner's share — residual swept to pot:residual account after loop
    const winners: PotWinner[] = [];
    const batch = db.batch();
    let totalDistributed = 0;

    for (let i = 0; i < topEntries.length && i < 10; i++) {
      const entry = topEntries[i];
      const percentage = percentages[i];
      const tokensWon = Math.floor(totalTokens * percentage / 100);

      if (tokensWon <= 0) continue;

      totalDistributed += tokensWon;

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
        totalDistributed -= tokensWon; // Undo count for failed payout
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

    // Sweep rounding residual to pot:residual account
    const residual = totalTokens - totalDistributed;
    if (residual > 0) {
      const residualResult = await processPotResidual("daily", residual, potDoc.id, {
        totalTokens,
        totalDistributed,
        winnersCount: winners.length,
      });
      if (!residualResult.success) {
        console.error(`Failed to sweep daily pot residual: ${residualResult.error}`);
      } else {
        console.log(`Daily pot residual swept: ${residual} tokens`);
      }
    }

    // Update pot with winners
    batch.update(potDoc.ref, {
      isActive: false,
      isDistributed: true,
      distributedAt: admin.firestore.FieldValue.serverTimestamp(),
      winners: winners,
      totalParticipants: leaderboardResult.total,
      ledgerProcessed: true,
      residualTokens: residual,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();

    console.log(`Daily pot draw completed. ${winners.length} winners, ${totalDistributed} tokens distributed, ${residual} residual`);
    return { winnersCount: winners.length, totalTokens: totalDistributed };
}

/**
 * Admin-triggered manual daily pot distribution.
 * Uses the same logic as the scheduled runDailyPotDraw.
 */
export const adminDistributeDailyPot = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminDistributeDailyPot");
    await requireAdminPermission(context, "pots:distribute", "adminDistributeDailyPot");

    const { potId } = (data || {}) as { potId?: string };
    const result = await executeDailyPotDraw(potId);

    if (!result) {
      return { success: true, message: "No active daily pot or no participants" };
    }

    // Auto-initialize a new daily pot for the current period after distribution
    const initResult = await executeInitializeDailyPot();
    console.log(`Post-distribution daily pot init: ${initResult}`);

    return {
      success: true,
      message: `Daily pot distributed: ${result.winnersCount} winners, ${result.totalTokens} tokens. New daily pot: ${initResult}`,
      winnersCount: result.winnersCount,
      totalTokens: result.totalTokens,
    };
  }
);

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
    const flagDoc = await db.collection("platformSettings").doc("pots").get();
    if (flagDoc.exists && flagDoc.data()?.weeklyPotAutoDistribute === false) {
      console.log("Weekly pot auto-distribute disabled — skipping scheduled draw");
      return null;
    }
    return executeWeeklyPotDraw();
  });

/**
 * Core weekly pot draw logic, shared by the scheduled job and the admin manual trigger.
 * @param potId Optional: target a specific pot by ID (admin manual trigger).
 *              When omitted, queries for this week's active weekly pot (scheduled trigger).
 */
async function executeWeeklyPotDraw(potId?: string): Promise<{ winnersCount: number; totalTokens: number } | null> {
    let potDoc: admin.firestore.QueryDocumentSnapshot | admin.firestore.DocumentSnapshot;

    if (potId) {
      // Admin manual trigger: target a specific pot
      const doc = await db.collection("pots").doc(potId).get();
      if (!doc.exists || doc.data()?.type !== "weekly" || doc.data()?.isActive !== true) {
        console.log(`Pot ${potId} not found, not weekly, or not active`);
        return null;
      }
      potDoc = doc;
    } else {
      // Scheduled trigger: find this week's active pot
      const weekStart = getSASTWeekStart();
      const weekEnd = new Date(weekStart.getTime() + 7 * 24 * 60 * 60 * 1000);

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
      potDoc = potQuery.docs[0];
    }

    const potData = potDoc.data()!;

    // Derive week start from pot's periodStart (handles stale pots correctly)
    const potPeriodStart = (potData.periodStart as admin.firestore.Timestamp).toDate();
    const weekKey = getWeekKey(potPeriodStart);

    // Build weekly pot leaderboard by aggregating daily scores
    // For weekly, we query all dailyScores from Mon-Sun and aggregate
    const weekStartStr = getSASTDateString(potPeriodStart);
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

    // Get actual pot balance from the ledger (accumulated from unrounded 5% earnings split)
    const ledgerPotBalance = await getBalance(SystemAccounts.WEEKLY_POT);
    // Use ledger balance if available, otherwise use tracked total or base prize
    const totalTokens = ledgerPotBalance > 0 ? ledgerPotBalance : (potData.totalTokens || 50000);

    // Distribution percentages for top 10
    const percentages = [30.0, 20.0, 15.0, 10.0, 8.0, 6.0, 5.0, 3.0, 2.0, 1.0];

    // Build winners array and process through ledger
    // Floor each winner's share — residual swept to pot:residual account after loop
    const winners: PotWinner[] = [];
    const batch = db.batch();
    let totalDistributed = 0;

    const topEntries = aggregatedScores.slice(0, 10);
    for (let i = 0; i < topEntries.length; i++) {
      const entry = topEntries[i];
      const percentage = percentages[i];
      const tokensWon = Math.floor(totalTokens * percentage / 100);

      if (tokensWon <= 0) continue;

      totalDistributed += tokensWon;

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
        totalDistributed -= tokensWon; // Undo count for failed payout
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

    // Sweep rounding residual to pot:residual account
    const residual = totalTokens - totalDistributed;
    if (residual > 0) {
      const residualResult = await processPotResidual("weekly", residual, potDoc.id, {
        totalTokens,
        totalDistributed,
        winnersCount: winners.length,
      });
      if (!residualResult.success) {
        console.error(`Failed to sweep weekly pot residual: ${residualResult.error}`);
      } else {
        console.log(`Weekly pot residual swept: ${residual} tokens`);
      }
    }

    // Update pot with winners
    batch.update(potDoc.ref, {
      isActive: false,
      isDistributed: true,
      distributedAt: admin.firestore.FieldValue.serverTimestamp(),
      winners: winners,
      totalParticipants: aggregatedScores.length,
      ledgerProcessed: true,
      residualTokens: residual,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();

    console.log(`Weekly pot draw completed. ${winners.length} winners, ${totalDistributed} tokens distributed, ${residual} residual`);
    return { winnersCount: winners.length, totalTokens: totalDistributed };
}

/**
 * Admin-triggered manual weekly pot distribution.
 * Uses the same logic as the scheduled runWeeklyPotDraw.
 */
export const adminDistributeWeeklyPot = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminDistributeWeeklyPot");
    await requireAdminPermission(context, "pots:distribute", "adminDistributeWeeklyPot");

    const { potId } = (data || {}) as { potId?: string };
    const result = await executeWeeklyPotDraw(potId);

    if (!result) {
      return { success: true, message: "No active weekly pot or no participants" };
    }

    // Auto-initialize a new weekly pot for the current period after distribution
    const initResult = await executeInitializeWeeklyPot();
    console.log(`Post-distribution weekly pot init: ${initResult}`);

    return {
      success: true,
      message: `Weekly pot distributed: ${result.winnersCount} winners, ${result.totalTokens} tokens. New weekly pot: ${initResult}`,
      winnersCount: result.winnersCount,
      totalTokens: result.totalTokens,
    };
  }
);

/**
 * Admin callable: Initialize pots for the current day/week if they don't exist.
 * Safe to call multiple times — skips if pots already exist.
 */
export const adminInitializePots = functions.https.onCall(
  async (_data, context) => {
    requireAppCheck(context, "adminInitializePots");
    await requireAdminPermission(context, "pots:distribute", "adminInitializePots");

    const dailyResult = await executeInitializeDailyPot();
    const weeklyResult = await executeInitializeWeeklyPot();

    const parts: string[] = [];
    if (dailyResult === "created") parts.push("Daily pot created");
    else parts.push("Daily pot already exists");
    if (weeklyResult === "created") parts.push("Weekly pot created");
    else parts.push("Weekly pot already exists");

    return {
      success: true,
      daily: dailyResult,
      weekly: weeklyResult,
      message: parts.join(". "),
    };
  }
);

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

// ── SAST-aware date helpers ────────────────────────────────────────
// Cloud Functions scheduled with timeZone("Africa/Johannesburg") fire
// at SAST wall-clock times, but `new Date()` returns UTC.  All pot
// boundary calculations must use the SAST calendar day / week.

export const SAST_OFFSET_MS = 2 * 60 * 60 * 1000; // UTC+2

/**
 * Start of the current SAST day, returned as a UTC Date.
 * E.g. midnight SAST Feb 9 → Feb 8 22:00 UTC.
 */
export function getSASTDayStart(): Date {
  const sastNow = new Date(Date.now() + SAST_OFFSET_MS);
  return new Date(
    Date.UTC(sastNow.getUTCFullYear(), sastNow.getUTCMonth(), sastNow.getUTCDate())
      - SAST_OFFSET_MS
  );
}

/**
 * Start of the current SAST week (Monday 00:00 SAST), returned as UTC Date.
 * E.g. Monday midnight SAST → Sunday 22:00 UTC.
 */
export function getSASTWeekStart(): Date {
  const sastNow = new Date(Date.now() + SAST_OFFSET_MS);
  const day = sastNow.getUTCDay(); // 0=Sun … 6=Sat
  const diff = day === 0 ? -6 : 1 - day; // back to Monday
  return new Date(
    Date.UTC(
      sastNow.getUTCFullYear(),
      sastNow.getUTCMonth(),
      sastNow.getUTCDate() + diff,
    ) - SAST_OFFSET_MS
  );
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
  // Uses the same composite index as adminGetPotEntries: date + finalScore (COLLECTION_GROUP)
  for (const date of dates) {
    const snapshot = await db
      .collectionGroup("dailyScores")
      .where("date", "==", date)
      .where("finalScore", ">", 0)
      .orderBy("finalScore", "desc")
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

/**
 * Admin endpoint: get all participant entries for a given pot.
 * Queries dailyScores (the same data the draw uses) so we get
 * displayName/username/avatarUrl without extra user fetches.
 *
 * Daily pot  → flat list for the single date.
 * Weekly pot → entries grouped per day (client does the grouping/UI).
 */
export const adminGetPotEntries = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminGetPotEntries");
    await requireAdminPermission(
      context,
      "pots:viewEntries",
      "adminGetPotEntries",
    );

    const { potId } = data as { potId?: string };
    if (!potId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "potId is required",
      );
    }

    // 1. Read the pot document
    const potDoc = await db.collection("pots").doc(potId).get();
    if (!potDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Pot not found");
    }

    const potData = potDoc.data()!;
    const potType: string = potData.type; // "daily" or "weekly"
    const periodStart = (potData.periodStart as admin.firestore.Timestamp).toDate();
    const periodEnd = (potData.periodEnd as admin.firestore.Timestamp).toDate();

    // 2. Compute YYYY-MM-DD strings for each day in the pot period (SAST-aware)
    const dates: string[] = [];
    const startMs = periodStart.getTime() + SAST_OFFSET_MS; // to SAST
    const endMs = periodEnd.getTime() + SAST_OFFSET_MS;
    let cursor = new Date(startMs);
    while (cursor.getTime() < endMs) {
      const y = cursor.getUTCFullYear();
      const m = String(cursor.getUTCMonth() + 1).padStart(2, "0");
      const d = String(cursor.getUTCDate()).padStart(2, "0");
      dates.push(`${y}-${m}-${d}`);
      cursor = new Date(cursor.getTime() + 24 * 60 * 60 * 1000);
    }

    // 3. Query dailyScores for each date
    interface EntryRow {
      userId: string;
      displayName: string;
      username: string | null;
      avatarUrl: string | null;
      finalScore: number;
      engagementsCompleted: number;
      date: string;
    }

    const entries: EntryRow[] = [];

    for (const dateStr of dates) {
      const snapshot = await db
        .collectionGroup("dailyScores")
        .where("date", "==", dateStr)
        .where("finalScore", ">", 0)
        .orderBy("finalScore", "desc")
        .limit(500)
        .get();

      for (const doc of snapshot.docs) {
        const userId = doc.ref.parent.parent?.id;
        if (!userId) continue;
        const s = doc.data();
        entries.push({
          userId,
          displayName: s.displayName || "User",
          username: s.username || null,
          avatarUrl: s.avatarUrl || null,
          finalScore: s.finalScore || 0,
          engagementsCompleted: s.engagementsCompleted || 0,
          date: dateStr,
        });
      }
    }

    return {
      potType,
      periodStart: periodStart.toISOString(),
      periodEnd: periodEnd.toISOString(),
      totalEntries: entries.length,
      entries,
    };
  },
);

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
