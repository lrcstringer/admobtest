/**
 * Daily Scores Management
 *
 * Handles per-user daily scoring for pot draw rankings.
 * Stored in users/{userId}/dailyScores/{YYYY-MM-DD} subcollection.
 *
 * Score Formula:
 * finalScore = (engagementsCompleted × streakMultiplier) + assistScore
 *
 * Assist Score:
 * - Referrer gets 10% of referee's earned tokens added to their assistScore
 * - This incentivizes referrers to encourage their referees to stay active
 *
 * Pot Leaderboards:
 * - Built at draw time from dailyScores using collection group query
 * - Stored in potLeaderboards/{potId}/entries/{rank}
 * - Rankings are by finalScore DESC, then updatedAt ASC (tiebreaker)
 */

import * as admin from "firebase-admin";
import {
  DailyScore,
  PotLeaderboardEntry,
  SubAccountConfig,
} from "./ledger/types";
import { getSASTDateString } from "./engagementStats";

const db = admin.firestore();

/**
 * Get user's daily score for a specific date
 */
export async function getDailyScore(
  userId: string,
  date?: string
): Promise<DailyScore | null> {
  const dateKey = date || getSASTDateString();

  const doc = await db
    .collection("users")
    .doc(userId)
    .collection("dailyScores")
    .doc(dateKey)
    .get();

  if (!doc.exists) {
    return null;
  }

  return doc.data() as DailyScore;
}

/**
 * Calculate final score from components
 */
function calculateFinalScore(
  engagementsCompleted: number,
  streakMultiplier: number,
  assistScore: number
): number {
  return Math.floor(engagementsCompleted * streakMultiplier) + assistScore;
}

/**
 * Update user's daily score after completing an engagement
 *
 * @param userId - The user's ID
 * @param tokensEarned - Tokens earned from this engagement
 * @param streakDay - Current streak day count
 * @param streakMultiplier - Current streak multiplier
 * @param profile - User profile info for caching
 */
export async function updateDailyScore(
  userId: string,
  tokensEarned: number,
  streakDay: number,
  streakMultiplier: number,
  profile: {
    displayName: string;
    username?: string | null;
    avatarUrl?: string | null;
  }
): Promise<DailyScore> {
  const today = getSASTDateString();
  const now = admin.firestore.Timestamp.now();

  const scoreRef = db
    .collection("users")
    .doc(userId)
    .collection("dailyScores")
    .doc(today);

  return await db.runTransaction(async (tx) => {
    const doc = await tx.get(scoreRef);

    if (!doc.exists) {
      // Create new daily score
      const newScore: DailyScore = {
        date: today,
        engagementsCompleted: 1,
        tokensEarned: tokensEarned,
        streakDay: streakDay,
        streakMultiplier: streakMultiplier,
        assistScore: 0,
        finalScore: calculateFinalScore(1, streakMultiplier, 0),
        displayName: profile.displayName,
        username: profile.username || null,
        avatarUrl: profile.avatarUrl || null,
        updatedAt: now,
      };

      tx.set(scoreRef, newScore);
      return newScore;
    }

    // Update existing score
    const existingScore = doc.data() as DailyScore;
    const newEngagements = existingScore.engagementsCompleted + 1;
    const newTokens = existingScore.tokensEarned + tokensEarned;
    const newFinalScore = calculateFinalScore(
      newEngagements,
      streakMultiplier,
      existingScore.assistScore
    );

    const updatedScore: Partial<DailyScore> = {
      engagementsCompleted: newEngagements,
      tokensEarned: newTokens,
      streakDay: streakDay,
      streakMultiplier: streakMultiplier,
      finalScore: newFinalScore,
      displayName: profile.displayName,
      username: profile.username || null,
      avatarUrl: profile.avatarUrl || null,
      updatedAt: now,
    };

    tx.update(scoreRef, updatedScore);

    return {
      ...existingScore,
      ...updatedScore,
    } as DailyScore;
  });
}

/**
 * Update referrer's assist score when their referee earns tokens
 *
 * @param referrerId - The referrer's user ID
 * @param refereeTokensEarned - Tokens earned by the referee
 */
export async function updateReferrerAssistScore(
  referrerId: string,
  refereeTokensEarned: number
): Promise<void> {
  const today = getSASTDateString();
  const now = admin.firestore.Timestamp.now();

  // Calculate assist bonus (10% of referee's earnings)
  const assistBonus = Math.floor(
    refereeTokensEarned * SubAccountConfig.ASSIST_SCORE_PERCENTAGE
  );

  if (assistBonus <= 0) {
    return;
  }

  const scoreRef = db
    .collection("users")
    .doc(referrerId)
    .collection("dailyScores")
    .doc(today);

  await db.runTransaction(async (tx) => {
    const doc = await tx.get(scoreRef);

    if (!doc.exists) {
      // Referrer hasn't played today - create score with only assist
      // Get referrer's profile for display name
      const userDoc = await tx.get(db.collection("users").doc(referrerId));
      const userData = userDoc.data();

      const newScore: DailyScore = {
        date: today,
        engagementsCompleted: 0,
        tokensEarned: 0,
        streakDay: 0,
        streakMultiplier: 1.0,
        assistScore: assistBonus,
        finalScore: assistBonus, // Just the assist score
        displayName: userData?.displayName || `User ${referrerId.substring(0, 8)}`,
        username: userData?.username || null,
        avatarUrl: userData?.avatarUrl || null,
        updatedAt: now,
      };

      tx.set(scoreRef, newScore);
      return;
    }

    // Update existing score
    const existingScore = doc.data() as DailyScore;
    const newAssistScore = existingScore.assistScore + assistBonus;
    const newFinalScore = calculateFinalScore(
      existingScore.engagementsCompleted,
      existingScore.streakMultiplier,
      newAssistScore
    );

    tx.update(scoreRef, {
      assistScore: newAssistScore,
      finalScore: newFinalScore,
      updatedAt: now,
    });
  });

  console.log(
    `Added ${assistBonus} assist score to referrer ${referrerId} for today`
  );
}

/**
 * Build pot leaderboard from daily scores at draw time
 *
 * Uses collection group query to get all dailyScores for the given date,
 * orders by finalScore DESC, then updatedAt ASC (tiebreaker),
 * and writes to potLeaderboards/{potId}/entries/{rank}
 *
 * @param potId - The pot document ID
 * @param potType - "daily" or "weekly"
 * @param dateKey - The date or week key (e.g., "2024-01-15" or "2024-W03")
 * @param topN - How many top entries to include (default 100)
 */
export async function buildPotLeaderboard(
  potId: string,
  potType: "daily" | "weekly",
  dateKey: string,
  topN: number = 100
): Promise<{ total: number; entries: PotLeaderboardEntry[] }> {
  const now = admin.firestore.Timestamp.now();

  // For daily pots, dateKey is "YYYY-MM-DD"
  // For weekly pots, we need to query all days in the week
  let dateFilter: string;
  if (potType === "weekly") {
    // Weekly pot - dateKey is like "2024-W03"
    // We need to get the Monday of that week and query 7 days
    // For simplicity, use the dateKey as-is for weekly (requires different query)
    // For now, assume weekly pot uses a different aggregation approach
    dateFilter = dateKey; // This will need special handling
  } else {
    dateFilter = dateKey;
  }

  // Query all dailyScores for this date using collection group query
  // Note: This requires a composite index on dailyScores
  const snapshot = await db
    .collectionGroup("dailyScores")
    .where("date", "==", dateFilter)
    .where("finalScore", ">", 0)
    .orderBy("finalScore", "desc")
    .orderBy("updatedAt", "asc")
    .limit(topN)
    .get();

  const entries: PotLeaderboardEntry[] = [];
  let rank = 1;

  for (const doc of snapshot.docs) {
    const score = doc.data() as DailyScore;
    const userId = doc.ref.parent.parent?.id;

    if (!userId) {
      console.warn(`Could not extract userId from path: ${doc.ref.path}`);
      continue;
    }

    entries.push({
      rank,
      userId,
      displayName: score.displayName,
      username: score.username,
      avatarUrl: score.avatarUrl,
      finalScore: score.finalScore,
      engagementsCompleted: score.engagementsCompleted,
      createdAt: now,
    });

    rank++;
  }

  // Create pot leaderboard document
  const leaderboardRef = db.collection("potLeaderboards").doc(potId);

  await leaderboardRef.set({
    potId,
    potType,
    dateKey,
    totalParticipants: entries.length,
    createdAt: now,
  });

  // Write entries to subcollection
  const batch = db.batch();

  for (const entry of entries) {
    const rankStr = entry.rank.toString().padStart(4, "0"); // "0001", "0002", etc.
    const entryRef = leaderboardRef.collection("entries").doc(rankStr);
    batch.set(entryRef, entry);
  }

  await batch.commit();

  console.log(
    `Built pot leaderboard ${potId}: ${entries.length} entries for ${dateKey}`
  );

  return { total: entries.length, entries };
}

/**
 * Get pot leaderboard entries
 */
export async function getPotLeaderboardEntries(
  potId: string,
  limit: number = 10
): Promise<PotLeaderboardEntry[]> {
  const snapshot = await db
    .collection("potLeaderboards")
    .doc(potId)
    .collection("entries")
    .orderBy("rank", "asc")
    .limit(limit)
    .get();

  return snapshot.docs.map((doc) => doc.data() as PotLeaderboardEntry);
}

/**
 * Get user's rank in a pot leaderboard
 */
export async function getUserPotRank(
  potId: string,
  userId: string
): Promise<PotLeaderboardEntry | null> {
  const snapshot = await db
    .collection("potLeaderboards")
    .doc(potId)
    .collection("entries")
    .where("userId", "==", userId)
    .limit(1)
    .get();

  if (snapshot.empty) {
    return null;
  }

  return snapshot.docs[0].data() as PotLeaderboardEntry;
}

/**
 * Delete all daily scores for a user (used during account deletion)
 */
export async function deleteAllDailyScores(userId: string): Promise<void> {
  const scoresRef = db
    .collection("users")
    .doc(userId)
    .collection("dailyScores");

  const snapshot = await scoresRef.get();

  const batch = db.batch();
  for (const doc of snapshot.docs) {
    batch.delete(doc.ref);
  }
  await batch.commit();

  console.log(`Deleted all daily scores for user ${userId}`);
}

/**
 * Get user's score history (for profile display)
 */
export async function getUserScoreHistory(
  userId: string,
  limit: number = 30
): Promise<DailyScore[]> {
  const snapshot = await db
    .collection("users")
    .doc(userId)
    .collection("dailyScores")
    .orderBy("date", "desc")
    .limit(limit)
    .get();

  return snapshot.docs.map((doc) => doc.data() as DailyScore);
}

/**
 * Get today's leaderboard preview (top users by score today)
 * This is a live view, not the final pot leaderboard
 */
export async function getTodayLeaderboardPreview(
  limit: number = 50
): Promise<Array<DailyScore & { userId: string }>> {
  const today = getSASTDateString();

  const snapshot = await db
    .collectionGroup("dailyScores")
    .where("date", "==", today)
    .where("finalScore", ">", 0)
    .orderBy("finalScore", "desc")
    .orderBy("updatedAt", "asc")
    .limit(limit)
    .get();

  return snapshot.docs.map((doc) => {
    const userId = doc.ref.parent.parent?.id || "unknown";
    return {
      ...(doc.data() as DailyScore),
      userId,
    };
  });
}

/**
 * For weekly pots: aggregate a week's worth of daily scores
 * This sums up all scores from Monday to Sunday of the given week
 */
export async function aggregateWeeklyScores(
  weekStartDate: string // Monday of the week in YYYY-MM-DD format
): Promise<Map<string, { totalScore: number; totalEngagements: number }>> {
  const aggregated = new Map<
    string,
    { totalScore: number; totalEngagements: number }
  >();

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

      const score = doc.data() as DailyScore;
      const existing = aggregated.get(userId) || {
        totalScore: 0,
        totalEngagements: 0,
      };

      aggregated.set(userId, {
        totalScore: existing.totalScore + score.finalScore,
        totalEngagements: existing.totalEngagements + score.engagementsCompleted,
      });
    }
  }

  return aggregated;
}
