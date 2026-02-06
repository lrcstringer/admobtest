/**
 * Engagement Stats Management
 *
 * Handles streak tracking, multiplier calculation, and engagement metrics.
 * Stored in userEngagementStats/{userId} collection.
 *
 * Streak Rules:
 * - Streak starts at 1 on first engagement
 * - Streak increments if user engages on consecutive days (SAST timezone)
 * - Streak resets to 1 if user misses a day
 * - Same day engagements don't change streak
 *
 * Streak Multipliers:
 * - Days 1-2: ×1.00
 * - Days 3-6: ×1.20
 * - Days 7-9: ×1.35
 * - Days 10+: ×1.50
 */

import * as admin from "firebase-admin";
import {
  UserEngagementStats,
  StreakInfo,
  SubAccountConfig,
} from "./ledger/types";

const db = admin.firestore();

// SAST timezone offset (+2 hours from UTC)
const SAST_OFFSET_HOURS = 2;

/**
 * Get current date in SAST timezone as "YYYY-MM-DD"
 */
export function getSASTDateString(date?: Date): string {
  const d = date || new Date();
  // Add SAST offset to UTC time
  const sastTime = new Date(d.getTime() + SAST_OFFSET_HOURS * 60 * 60 * 1000);
  return sastTime.toISOString().split("T")[0];
}

/**
 * Calculate days between two SAST date strings
 * Returns positive number if date2 is after date1
 */
function daysBetween(date1: string, date2: string): number {
  const d1 = new Date(date1 + "T00:00:00Z");
  const d2 = new Date(date2 + "T00:00:00Z");
  const diffTime = d2.getTime() - d1.getTime();
  return Math.floor(diffTime / (1000 * 60 * 60 * 24));
}

/**
 * Calculate streak multiplier based on streak day count
 *
 * @param streakDays - Number of consecutive days
 * @returns Multiplier value (1.0, 1.2, 1.35, or 1.5)
 */
export function getStreakMultiplier(streakDays: number): number {
  if (streakDays >= 10) {
    return SubAccountConfig.STREAK_MULTIPLIER_TIER_4; // 1.5
  } else if (streakDays >= 7) {
    return SubAccountConfig.STREAK_MULTIPLIER_TIER_3; // 1.35
  } else if (streakDays >= 3) {
    return SubAccountConfig.STREAK_MULTIPLIER_TIER_2; // 1.2
  } else {
    return SubAccountConfig.STREAK_MULTIPLIER_TIER_1; // 1.0
  }
}

/**
 * Get user's engagement stats
 */
export async function getEngagementStats(
  userId: string
): Promise<UserEngagementStats | null> {
  const doc = await db
    .collection(SubAccountConfig.COLLECTION_ENGAGEMENT_STATS)
    .doc(userId)
    .get();

  if (!doc.exists) {
    return null;
  }

  return doc.data() as UserEngagementStats;
}

/**
 * Get user's current streak info (without updating)
 */
export async function getStreakInfo(userId: string): Promise<StreakInfo> {
  const stats = await getEngagementStats(userId);
  const today = getSASTDateString();

  if (!stats) {
    return {
      currentStreak: 0,
      longestStreak: 0,
      multiplier: 1.0,
      isNewDay: true,
      streakBroken: false,
    };
  }

  const lastEarnedDate = stats.lastEarnedDate;
  const daysSinceLastEarn = daysBetween(lastEarnedDate, today);

  // Check if streak is still valid
  if (daysSinceLastEarn > 1) {
    // Streak is broken
    return {
      currentStreak: 0,
      longestStreak: stats.longestStreak,
      multiplier: 1.0,
      isNewDay: true,
      streakBroken: true,
    };
  } else if (daysSinceLastEarn === 1) {
    // New day, streak continues
    const newStreak = stats.currentStreak + 1;
    return {
      currentStreak: newStreak,
      longestStreak: Math.max(newStreak, stats.longestStreak),
      multiplier: getStreakMultiplier(newStreak),
      isNewDay: true,
      streakBroken: false,
    };
  } else {
    // Same day
    return {
      currentStreak: stats.currentStreak,
      longestStreak: stats.longestStreak,
      multiplier: getStreakMultiplier(stats.currentStreak),
      isNewDay: false,
      streakBroken: false,
    };
  }
}

/**
 * Update user's engagement stats after completing an engagement
 *
 * @param userId - The user's ID
 * @param tokensEarned - Tokens earned from this engagement
 * @param streakPoints - Streak points earned from this engagement (defaults to 1)
 * @returns Updated streak info
 */
export async function updateEngagementStats(
  userId: string,
  tokensEarned: number,
  streakPoints: number = 1
): Promise<StreakInfo> {
  const statsRef = db
    .collection(SubAccountConfig.COLLECTION_ENGAGEMENT_STATS)
    .doc(userId);

  const today = getSASTDateString();
  const now = admin.firestore.Timestamp.now();

  return await db.runTransaction(async (tx) => {
    const doc = await tx.get(statsRef);

    if (!doc.exists) {
      // First ever engagement - create new stats
      const newStats: UserEngagementStats = {
        userId,
        currentStreak: 1,
        longestStreak: 1,
        streakStartedAt: now,
        lastEarnedDate: today,
        totalEngagementsCompleted: streakPoints,
        totalTokensEarned: tokensEarned,
        updatedAt: now,
      };

      tx.set(statsRef, newStats);

      return {
        currentStreak: 1,
        longestStreak: 1,
        multiplier: getStreakMultiplier(1),
        isNewDay: true,
        streakBroken: false,
      };
    }

    const stats = doc.data() as UserEngagementStats;
    const lastEarnedDate = stats.lastEarnedDate;
    const daysSinceLastEarn = daysBetween(lastEarnedDate, today);

    let newStreak: number;
    let newLongestStreak: number;
    let streakBroken = false;
    let isNewDay = false;
    let streakStartedAt = stats.streakStartedAt;

    if (daysSinceLastEarn > 1) {
      // Streak broken - reset
      newStreak = 1;
      newLongestStreak = stats.longestStreak;
      streakBroken = true;
      isNewDay = true;
      streakStartedAt = now;
    } else if (daysSinceLastEarn === 1) {
      // New day - increment streak
      newStreak = stats.currentStreak + 1;
      newLongestStreak = Math.max(newStreak, stats.longestStreak);
      isNewDay = true;
    } else {
      // Same day - no streak change
      newStreak = stats.currentStreak;
      newLongestStreak = stats.longestStreak;
      isNewDay = false;
    }

    // Update stats
    tx.update(statsRef, {
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
      streakStartedAt: streakStartedAt,
      lastEarnedDate: today,
      totalEngagementsCompleted: admin.firestore.FieldValue.increment(streakPoints),
      totalTokensEarned: admin.firestore.FieldValue.increment(tokensEarned),
      updatedAt: now,
    });

    return {
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
      multiplier: getStreakMultiplier(newStreak),
      isNewDay,
      streakBroken,
    };
  });
}

/**
 * Create initial engagement stats for a new user
 */
export async function createEngagementStats(userId: string): Promise<void> {
  const statsRef = db
    .collection(SubAccountConfig.COLLECTION_ENGAGEMENT_STATS)
    .doc(userId);

  const doc = await statsRef.get();
  if (doc.exists) {
    // Already exists, don't overwrite
    return;
  }

  const now = admin.firestore.Timestamp.now();
  const stats: UserEngagementStats = {
    userId,
    currentStreak: 0,
    longestStreak: 0,
    streakStartedAt: null,
    lastEarnedDate: "", // Empty string indicates never earned
    totalEngagementsCompleted: 0,
    totalTokensEarned: 0,
    updatedAt: now,
  };

  await statsRef.set(stats);
  console.log(`Created engagement stats for user ${userId}`);
}

/**
 * Delete engagement stats for a user (used during account deletion)
 */
export async function deleteEngagementStats(userId: string): Promise<void> {
  await db
    .collection(SubAccountConfig.COLLECTION_ENGAGEMENT_STATS)
    .doc(userId)
    .delete();

  console.log(`Deleted engagement stats for user ${userId}`);
}

/**
 * Reset user's streak (admin function)
 */
export async function resetUserStreak(
  userId: string,
  reason: string
): Promise<void> {
  const statsRef = db
    .collection(SubAccountConfig.COLLECTION_ENGAGEMENT_STATS)
    .doc(userId);

  await statsRef.update({
    currentStreak: 0,
    streakStartedAt: null,
    updatedAt: admin.firestore.Timestamp.now(),
  });

  console.log(`Reset streak for user ${userId}: ${reason}`);
}

/**
 * Get top users by streak (for leaderboard)
 */
export async function getTopStreakUsers(
  limit: number = 10
): Promise<UserEngagementStats[]> {
  const snapshot = await db
    .collection(SubAccountConfig.COLLECTION_ENGAGEMENT_STATS)
    .orderBy("currentStreak", "desc")
    .limit(limit)
    .get();

  return snapshot.docs.map((doc) => doc.data() as UserEngagementStats);
}
