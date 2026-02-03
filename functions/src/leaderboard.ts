/**
 * Leaderboard Cloud Functions
 * Manages daily, weekly, and all-time leaderboard scores
 *
 * Collections:
 * - leaderboards/daily/scores/{userId}
 * - leaderboards/weekly/scores/{userId}
 * - leaderboards/allTime/scores/{userId}
 * - pots (updated with participantCount and totalTokens)
 */

import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Update leaderboard scores when a user earns tokens
 * Called from processEngagement
 */
export async function updateLeaderboardScores(
  userId: string,
  tokensEarned: number,
  userProfile: {
    displayName?: string;
    username?: string;
    avatarUrl?: string;
    avatarColor?: string;
  }
): Promise<void> {
  const now = new Date();

  // Calculate period boundaries
  const today = new Date(now);
  today.setHours(0, 0, 0, 0);
  const tomorrow = new Date(today);
  tomorrow.setDate(tomorrow.getDate() + 1);

  const weekStart = getWeekStart(now);
  weekStart.setHours(0, 0, 0, 0);
  const weekEnd = new Date(weekStart);
  weekEnd.setDate(weekEnd.getDate() + 7);

  const batch = db.batch();

  // Prepare common score data
  const displayName = userProfile.displayName || "User";
  const username = userProfile.username || null;
  const avatarUrl = userProfile.avatarUrl || null;
  const avatarColor = userProfile.avatarColor || null;

  // 1. Update daily leaderboard score
  const dailyScoreRef = db.collection("leaderboards")
    .doc("daily")
    .collection("scores")
    .doc(userId);

  batch.set(dailyScoreRef, {
    userId: userId,
    displayName: displayName,
    username: username,
    avatarUrl: avatarUrl,
    avatarColor: avatarColor,
    totalTokensEarned: admin.firestore.FieldValue.increment(tokensEarned),
    engagementsCompleted: admin.firestore.FieldValue.increment(1),
    periodStart: admin.firestore.Timestamp.fromDate(today),
    periodEnd: admin.firestore.Timestamp.fromDate(tomorrow),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });

  // 2. Update weekly leaderboard score
  const weeklyScoreRef = db.collection("leaderboards")
    .doc("weekly")
    .collection("scores")
    .doc(userId);

  batch.set(weeklyScoreRef, {
    userId: userId,
    displayName: displayName,
    username: username,
    avatarUrl: avatarUrl,
    avatarColor: avatarColor,
    totalTokensEarned: admin.firestore.FieldValue.increment(tokensEarned),
    engagementsCompleted: admin.firestore.FieldValue.increment(1),
    periodStart: admin.firestore.Timestamp.fromDate(weekStart),
    periodEnd: admin.firestore.Timestamp.fromDate(weekEnd),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });

  // 3. Update all-time leaderboard score
  const allTimeScoreRef = db.collection("leaderboards")
    .doc("allTime")
    .collection("scores")
    .doc(userId);

  batch.set(allTimeScoreRef, {
    userId: userId,
    displayName: displayName,
    username: username,
    avatarUrl: avatarUrl,
    avatarColor: avatarColor,
    totalTokensEarned: admin.firestore.FieldValue.increment(tokensEarned),
    engagementsCompleted: admin.firestore.FieldValue.increment(1),
    periodStart: admin.firestore.Timestamp.fromDate(new Date(0)),
    periodEnd: admin.firestore.Timestamp.fromDate(now),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });

  // 4. Update daily pot totals and participant count
  const dailyPotId = `daily_${today.getTime()}`;
  const dailyPotRef = db.collection("pots").doc(dailyPotId);
  const dailyPotDoc = await dailyPotRef.get();

  if (dailyPotDoc.exists) {
    // Check if user is a new participant
    const existingDailyScore = await dailyScoreRef.get();
    const isNewParticipant = !existingDailyScore.exists ||
      (existingDailyScore.data()?.totalTokensEarned || 0) === tokensEarned;

    batch.update(dailyPotRef, {
      totalTokens: admin.firestore.FieldValue.increment(Math.round(tokensEarned * 0.1)), // 10% contribution
      participantCount: isNewParticipant ?
        admin.firestore.FieldValue.increment(1) :
        admin.firestore.FieldValue.increment(0),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  // 5. Update weekly pot totals and participant count
  const weeklyPotId = `weekly_${weekStart.getTime()}`;
  const weeklyPotRef = db.collection("pots").doc(weeklyPotId);
  const weeklyPotDoc = await weeklyPotRef.get();

  if (weeklyPotDoc.exists) {
    // Check if user is a new participant for the week
    const existingWeeklyScore = await weeklyScoreRef.get();
    const isNewWeeklyParticipant = !existingWeeklyScore.exists ||
      (existingWeeklyScore.data()?.totalTokensEarned || 0) === tokensEarned;

    batch.update(weeklyPotRef, {
      totalTokens: admin.firestore.FieldValue.increment(Math.round(tokensEarned * 0.05)), // 5% to weekly
      participantCount: isNewWeeklyParticipant ?
        admin.firestore.FieldValue.increment(1) :
        admin.firestore.FieldValue.increment(0),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();
}

/**
 * Update user streak information
 * Called after engagement completion
 */
export async function updateUserStreak(userId: string): Promise<{
  currentStreak: number;
  longestStreak: number;
}> {
  const now = new Date();
  const today = new Date(now);
  today.setHours(0, 0, 0, 0);
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);

  // Get wallet to check last earned date
  const walletQuery = await db.collection("wallets")
    .where("userId", "==", userId)
    .limit(1)
    .get();

  if (walletQuery.empty) {
    return { currentStreak: 1, longestStreak: 1 };
  }

  const walletDoc = walletQuery.docs[0];
  const walletData = walletDoc.data();

  const lastEarnedAt = walletData.lastEarnedAt?.toDate();
  let currentStreak = walletData.currentStreak || 0;
  let longestStreak = walletData.longestStreak || 0;

  if (lastEarnedAt) {
    const lastEarnedDate = new Date(lastEarnedAt);
    lastEarnedDate.setHours(0, 0, 0, 0);

    if (lastEarnedDate.getTime() === yesterday.getTime()) {
      // Consecutive day - increment streak
      currentStreak += 1;
    } else if (lastEarnedDate.getTime() === today.getTime()) {
      // Same day - streak unchanged (already counted)
    } else {
      // Streak broken - reset to 1
      currentStreak = 1;
    }
  } else {
    // First earning ever
    currentStreak = 1;
  }

  // Update longest streak if needed
  if (currentStreak > longestStreak) {
    longestStreak = currentStreak;
  }

  // Update wallet with streak info
  await walletDoc.ref.update({
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update leaderboard scores with streak info
  const dailyScoreRef = db.collection("leaderboards")
    .doc("daily")
    .collection("scores")
    .doc(userId);

  const weeklyScoreRef = db.collection("leaderboards")
    .doc("weekly")
    .collection("scores")
    .doc(userId);

  const allTimeScoreRef = db.collection("leaderboards")
    .doc("allTime")
    .collection("scores")
    .doc(userId);

  const batch = db.batch();
  batch.set(dailyScoreRef, {
    currentStreak: currentStreak,
    longestStreak: longestStreak,
  }, { merge: true });

  batch.set(weeklyScoreRef, {
    currentStreak: currentStreak,
    longestStreak: longestStreak,
  }, { merge: true });

  batch.set(allTimeScoreRef, {
    currentStreak: currentStreak,
    longestStreak: longestStreak,
  }, { merge: true });

  await batch.commit();

  return { currentStreak, longestStreak };
}

/**
 * Get user's current rank in a leaderboard
 */
export async function getUserRank(
  userId: string,
  leaderboardType: "daily" | "weekly" | "allTime"
): Promise<number> {
  const scoreRef = db.collection("leaderboards")
    .doc(leaderboardType)
    .collection("scores")
    .doc(userId);

  const scoreDoc = await scoreRef.get();
  if (!scoreDoc.exists) {
    return 0;
  }

  const userScore = scoreDoc.data()?.totalTokensEarned || 0;

  // Count users with higher scores
  const higherScoresCount = await db.collection("leaderboards")
    .doc(leaderboardType)
    .collection("scores")
    .where("totalTokensEarned", ">", userScore)
    .count()
    .get();

  return (higherScoresCount.data().count || 0) + 1;
}

// Helper function
function getWeekStart(date: Date): Date {
  const d = new Date(date);
  const day = d.getDay();
  const diff = d.getDate() - day + (day === 0 ? -6 : 1); // Monday
  return new Date(d.setDate(diff));
}
