/**
 * Engagement Cloud Functions
 * Track and process user engagements with ads/surveys
 *
 * Collections involved:
 * - earnOpportunities: Individual earn tasks (videos/surveys)
 * - earnThreads: Brand groupings for opportunities
 * - engagements: User engagement records
 * - campaigns: Campaign configuration (optional, for backward compatibility)
 * - wallets: User token balances
 * - transactions: Transaction records
 * - potEntries: Pot eligibility entries
 * - leaderboards/{type}/scores: Leaderboard scores
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processEarningWithSplit,
  LedgerConfig,
  getOrCreateDefaultSubAccount,
} from "./ledger";
import { updateEngagementStats } from "./engagementStats";
import { updateDailyScore, updateReferrerAssistScore } from "./dailyScores";

const db = admin.firestore();

// Status values aligned with Flutter client
const EngagementStatus = {
  STARTED: "started",
  WATCHING: "watching",
  SURVEYING: "surveying",
  COMPLETED: "completed",
  FAILED: "failed",
  ABANDONED: "abandoned",
  REWARDED: "rewarded",
  REJECTED: "rejected",
  // Legacy status for backward compatibility
  IN_PROGRESS: "in_progress",
} as const;

/**
 * Start a new engagement (ad view or survey)
 *
 * Accepts either:
 * - earnOpportunityId: References earnOpportunities collection (preferred)
 * - campaignId + type: Legacy format for campaigns collection
 */
export const startEngagement = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  requireAppCheck(context, "startEngagement");

  const userId = context.auth.uid;
  const { earnOpportunityId, campaignId, type, threadId } = data;

  // Support both earnOpportunityId (preferred) and campaignId (legacy)
  let rewardAmount: number;
  let engagementType: string;
  let resolvedCampaignId: string | null = null;
  let resolvedOpportunityId: string | null = earnOpportunityId || null;
  let resolvedThreadId: string | null = threadId || null;

  if (earnOpportunityId) {
    // New flow: Get opportunity from earnOpportunities collection
    const opportunityDoc = await db
      .collection("earnOpportunities")
      .doc(earnOpportunityId)
      .get();

    if (!opportunityDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Opportunity not found");
    }

    const opportunity = opportunityDoc.data()!;

    if (!opportunity.isActive) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Opportunity is not active"
      );
    }

    // Check expiry
    if (opportunity.expiresAt && opportunity.expiresAt.toDate() < new Date()) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Opportunity has expired"
      );
    }

    rewardAmount = opportunity.tokenReward;
    engagementType = opportunity.mediaType || "video";
    resolvedCampaignId = opportunity.campaignId || null;
    resolvedThreadId = opportunity.threadId || threadId || null;

    // Check if user has already completed this opportunity
    const existingEngagement = await db
      .collection("engagements")
      .where("userId", "==", userId)
      .where("earnOpportunityId", "==", earnOpportunityId)
      .where("status", "==", EngagementStatus.COMPLETED)
      .limit(1)
      .get();

    if (!existingEngagement.empty) {
      throw new functions.https.HttpsError(
        "already-exists",
        "Already completed this opportunity"
      );
    }
  } else if (campaignId) {
    // Legacy flow: Get campaign from campaigns collection
    if (!type) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing required fields: type is required when using campaignId"
      );
    }

    const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

    if (!campaignDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Campaign not found");
    }

    const campaign = campaignDoc.data()!;

    if (campaign.status !== "active") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Campaign is not active"
      );
    }

    rewardAmount = campaign.rewardPerEngagement;
    engagementType = type;
    resolvedCampaignId = campaignId;

    // Check max engagements per user
    const existingEngagement = await db
      .collection("engagements")
      .where("userId", "==", userId)
      .where("campaignId", "==", campaignId)
      .where("status", "==", EngagementStatus.COMPLETED)
      .limit(1)
      .get();

    if (!existingEngagement.empty && campaign.maxEngagementsPerUser === 1) {
      throw new functions.https.HttpsError(
        "already-exists",
        "Already completed this campaign"
      );
    }
  } else {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: either earnOpportunityId or campaignId is required"
    );
  }

  // Create engagement record with Flutter-compatible fields
  const engagementRef = db.collection("engagements").doc();
  const now = admin.firestore.FieldValue.serverTimestamp();

  await engagementRef.set({
    id: engagementRef.id,
    userId: userId,
    // Support both field names for Flutter compatibility
    earnOpportunityId: resolvedOpportunityId,
    oddienceCampaignId: resolvedCampaignId,
    campaignId: resolvedCampaignId,
    threadId: resolvedThreadId,
    type: engagementType,
    status: EngagementStatus.STARTED,
    progress: 0,
    rewardAmount: rewardAmount,
    watchDurationSeconds: 0,
    requiredDurationSeconds: 0, // Will be updated by client
    answers: [],
    attemptNumber: 1,
    startedAt: now,
    createdAt: now,
    evidence: [],
  });

  // Update earn thread if provided
  if (resolvedThreadId) {
    try {
      await db.collection("earnThreads").doc(resolvedThreadId).update({
        lastActivityAt: now,
        updatedAt: now,
      });
    } catch (e) {
      // Thread might not exist, ignore
      console.log(`Could not update earnThread ${resolvedThreadId}:`, e);
    }
  }

  return {
    success: true,
    engagementId: engagementRef.id,
    rewardAmount: rewardAmount,
  };
});

/**
 * Process engagement completion and reward user
 */
export const processEngagement = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(context, "processEngagement");
    await requirePlayIntegrity(data, context, "processEngagement", "HIGHEST");

    const userId = context.auth.uid;
    const { engagementId, evidence } = data;

    // Get engagement
    const engagementDoc = await db
      .collection("engagements")
      .doc(engagementId)
      .get();

    if (!engagementDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    // Validate ownership
    if (engagement.userId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Not authorized"
      );
    }

    // Check status - support both old and new status values
    const completedStatuses = [
      EngagementStatus.COMPLETED,
      EngagementStatus.REWARDED,
    ];
    if (completedStatuses.includes(engagement.status)) {
      throw new functions.https.HttpsError(
        "already-exists",
        "Engagement already completed"
      );
    }

    const failedStatuses = [
      EngagementStatus.FAILED,
      EngagementStatus.REJECTED,
      EngagementStatus.ABANDONED,
    ];
    if (failedStatuses.includes(engagement.status)) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Engagement has failed or was abandoned"
      );
    }

    // Validate evidence based on engagement type
    const isValid = validateEngagementEvidence(engagement.type, evidence);

    if (!isValid) {
      await engagementDoc.ref.update({
        status: EngagementStatus.FAILED,
        failedAt: admin.firestore.FieldValue.serverTimestamp(),
        failureReason: "Invalid evidence",
      });
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Invalid engagement evidence"
      );
    }

    const rewardAmount = engagement.rewardAmount;

    // Get campaignId - support both field names
    const campaignId = engagement.campaignId || engagement.oddienceCampaignId;

    // Calculate user's share for display (90% of total reward)
    const userShare = Math.floor(rewardAmount * LedgerConfig.EARNING_USER_SHARE);

    // Get or create user's default sub-account
    const { subAccountId } = await getOrCreateDefaultSubAccount(userId);

    // Process reward through the Trust Ledger system
    // This handles the 90/5/5 split: 90% to user, 5% daily pot, 5% weekly pot
    const ledgerResult = await processEarningWithSplit(
      userId,
      rewardAmount,
      engagementId,
      `Earned from ${engagement.type}`,
      subAccountId, // Credit to user's default sub-account
      null, // No account type restriction
      {
        engagementType: engagement.type,
        earnOpportunityId: engagement.earnOpportunityId,
        campaignId: campaignId,
        threadId: engagement.threadId,
      }
    );

    if (!ledgerResult.success) {
      throw new functions.https.HttpsError(
        "internal",
        `Failed to process earning: ${ledgerResult.error}`
      );
    }

    // Update engagement and related records in transaction
    await db.runTransaction(async (transaction) => {
      // Update engagement with Flutter-compatible fields
      transaction.update(engagementDoc.ref, {
        status: EngagementStatus.COMPLETED,
        progress: 100,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        tokensEarned: userShare, // User's 90% share
        totalTokensGenerated: rewardAmount, // Total including pot contributions
        ledgerJournalId: ledgerResult.journalId, // Link to ledger entry
        evidence: admin.firestore.FieldValue.arrayUnion(evidence),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Update campaign stats if campaign exists
      if (campaignId) {
        const campaignRef = db.collection("campaigns").doc(campaignId);
        const campaignDoc = await transaction.get(campaignRef);
        if (campaignDoc.exists) {
          transaction.update(campaignRef, {
            totalEngagements: admin.firestore.FieldValue.increment(1),
            remainingBudgetTokens:
              admin.firestore.FieldValue.increment(-rewardAmount),
          });
        }
      }

      // Update pot entries (tracks user's draw eligibility, not actual pot balance)
      // Pot balances are now managed by the ledger
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const potEntryRef = db
        .collection("potEntries")
        .doc(`${userId}_${today.toISOString().split("T")[0]}`);
      transaction.set(
        potEntryRef,
        {
          userId: userId,
          date: today.toISOString().split("T")[0],
          entries: admin.firestore.FieldValue.increment(rewardAmount),
          ledgerJournalId: ledgerResult.journalId,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true }
      );

      // Update earn thread completed count if present
      if (engagement.threadId) {
        const threadRef = db.collection("earnThreads").doc(engagement.threadId);
        transaction.update(threadRef, {
          completedOpportunities: admin.firestore.FieldValue.increment(1),
          lastActivityAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    });

    // Update engagement stats (streak tracking) - NEW SYSTEM
    let streakInfo = {
      currentStreak: 1,
      longestStreak: 1,
      multiplier: 1.0,
      isNewDay: true,
      streakBroken: false,
    };
    try {
      streakInfo = await updateEngagementStats(userId, userShare);
    } catch (statsError) {
      // Log but don't fail - streak update is secondary
      console.error("Failed to update engagement stats:", statsError);
    }

    // Update daily score for pot leaderboard - NEW SYSTEM
    try {
      // Get user profile for leaderboard display
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();
      const userProfile = {
        displayName:
          userData?.profile?.displayName || userData?.displayName || "User",
        username: userData?.profile?.username || userData?.username || null,
        avatarUrl: userData?.profile?.avatarUrl || userData?.avatarUrl || null,
      };

      // Update user's daily score
      await updateDailyScore(
        userId,
        userShare,
        streakInfo.currentStreak,
        streakInfo.multiplier,
        userProfile
      );

      // If user has a referrer, update referrer's assist score
      if (userData?.referredBy) {
        await updateReferrerAssistScore(userData.referredBy, userShare);
      }
    } catch (scoreError) {
      // Log but don't fail the engagement - score update is secondary
      console.error("Failed to update daily score:", scoreError);
    }

    // Store streak audit fields on the engagement document
    try {
      await engagementDoc.ref.update({
        streakDayAtCompletion: streakInfo.currentStreak,
        multiplierApplied: streakInfo.multiplier,
        subAccountId: subAccountId, // Track which sub-account was credited
      });
    } catch (auditError) {
      console.error("Failed to store streak audit fields:", auditError);
    }

    return {
      success: true,
      tokensEarned: userShare, // User's 90% share
      totalGenerated: rewardAmount, // Total including pot contributions
      dailyPotContribution: Math.floor(rewardAmount * LedgerConfig.EARNING_DAILY_POT_SHARE),
      weeklyPotContribution: rewardAmount - userShare - Math.floor(rewardAmount * LedgerConfig.EARNING_DAILY_POT_SHARE),
      ledgerJournalId: ledgerResult.journalId,
      streakDay: streakInfo.currentStreak,
      multiplierApplied: streakInfo.multiplier,
      streakBroken: streakInfo.streakBroken,
      subAccountId: subAccountId,
    };
  }
);

/**
 * Update engagement progress (for multi-step engagements like surveys)
 */
export const updateEngagementProgress = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(context, "updateEngagementProgress");

    const userId = context.auth.uid;
    const { engagementId, progress, stepData, watchDurationSeconds, status } =
      data;

    const engagementDoc = await db
      .collection("engagements")
      .doc(engagementId)
      .get();

    if (!engagementDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    if (engagement.userId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Not authorized"
      );
    }

    // Allow progress updates for active engagements
    const activeStatuses = [
      EngagementStatus.STARTED,
      EngagementStatus.WATCHING,
      EngagementStatus.SURVEYING,
      EngagementStatus.IN_PROGRESS,
    ];
    if (!activeStatuses.includes(engagement.status)) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Engagement not in progress"
      );
    }

    // Build update object
    const updateData: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    if (progress !== undefined) {
      updateData.progress = progress;
    }

    if (watchDurationSeconds !== undefined) {
      updateData.watchDurationSeconds = watchDurationSeconds;
    }

    if (status && activeStatuses.includes(status)) {
      updateData.status = status;
    }

    if (stepData) {
      updateData.evidence = admin.firestore.FieldValue.arrayUnion(stepData);
    }

    await engagementDoc.ref.update(updateData);

    return { success: true, progress };
  }
);

/**
 * Abandon an engagement
 */
export const abandonEngagement = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(context, "abandonEngagement");

    const userId = context.auth.uid;
    const { engagementId } = data;

    const engagementDoc = await db
      .collection("engagements")
      .doc(engagementId)
      .get();

    if (!engagementDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    if (engagement.userId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Not authorized"
      );
    }

    // Can only abandon active engagements
    const activeStatuses = [
      EngagementStatus.STARTED,
      EngagementStatus.WATCHING,
      EngagementStatus.SURVEYING,
      EngagementStatus.IN_PROGRESS,
    ];
    if (!activeStatuses.includes(engagement.status)) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Engagement cannot be abandoned"
      );
    }

    await engagementDoc.ref.update({
      status: EngagementStatus.ABANDONED,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);

/**
 * Validate engagement evidence based on type
 */
function validateEngagementEvidence(
  type: string,
  evidence: Record<string, unknown>
): boolean {
  switch (type) {
    case "video":
      // Validate video watch evidence
      // Accept either old format (watchDuration, videoId) or new format (watchDurationMs)
      if (evidence.watchDurationMs !== undefined) {
        return (evidence.watchDurationMs as number) > 0;
      }
      if (!evidence.watchDuration && !evidence.videoId) {
        return false;
      }
      // Check minimum watch time (e.g., 80% of video)
      if (evidence.watchPercentage !== undefined) {
        return (evidence.watchPercentage as number) >= 80;
      }
      return true;

    case "survey":
      // Validate survey responses
      if (!evidence.responses || !Array.isArray(evidence.responses)) {
        return false;
      }
      // Check that all required questions are answered
      return (evidence.responses as unknown[]).length > 0;

    case "poll":
      // Validate poll response
      return evidence.selectedOption !== undefined;

    case "image":
      // Image view validation
      return evidence.viewDurationMs !== undefined || evidence.viewed === true;

    default:
      return true;
  }
}
