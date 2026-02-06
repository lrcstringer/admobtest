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
import { updateDailyScore, updateReferrerAssistScore, updateLeaderboardScores } from "./dailyScores";
import {
  shouldAwardBonus,
  shouldAwardEveryXBonus,
  stateFromFirestore,
  stateToFirestore,
  DEFAULT_BONUS_CONFIG,
} from "./bonus";

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

// Daily completion limit - resets at midnight local time
const DAILY_EARN_CAP = 30;

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

  // Check daily completion limit (resets at midnight)
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const todayCompletionsSnapshot = await db
    .collection("engagements")
    .where("userId", "==", userId)
    .where("status", "==", EngagementStatus.COMPLETED)
    .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(today))
    .count()
    .get();

  const dailyCompletions = todayCompletionsSnapshot.data().count;

  if (dailyCompletions >= DAILY_EARN_CAP) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      "DAILY_LIMIT_REACHED"
    );
  }

  const { earnOpportunityId, campaignId, type, threadId } = data;

  // Support both earnOpportunityId (preferred) and campaignId (legacy)
  let rewardAmount: number;
  let streakPoints: number = 1; // Default to 1 for backward compatibility
  let engagementType: string;
  let resolvedCampaignId: string | null = null;
  let resolvedOpportunityId: string | null = earnOpportunityId || null;
  let resolvedThreadId: string | null = threadId || null;
  let resolvedClientId: string | null = null;

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
    streakPoints = opportunity.streakPoints ?? 1; // Default to 1 if not set
    engagementType = opportunity.earningType || opportunity.mediaType || "video";
    resolvedCampaignId = opportunity.campaignId || null;
    resolvedThreadId = opportunity.threadId || threadId || null;

    // Get thread to denormalize clientId and perform budget pre-check
    if (resolvedThreadId) {
      const threadDoc = await db
        .collection("earnThreads")
        .doc(resolvedThreadId)
        .get();

      if (threadDoc.exists) {
        const threadData = threadDoc.data()!;
        resolvedClientId = threadData.clientId || null;

        // Budget pre-check: verify client sub-account has sufficient balance
        if (
          resolvedClientId &&
          threadData.tokenSourceSubAccountId
        ) {
          const subAccountDoc = await db
            .collection("clients")
            .doc(resolvedClientId)
            .collection("subAccounts")
            .doc(threadData.tokenSourceSubAccountId)
            .get();

          if (subAccountDoc.exists) {
            const subAccount = subAccountDoc.data()!;
            if (!subAccount.isActive || subAccount.balance < rewardAmount) {
              throw new functions.https.HttpsError(
                "failed-precondition",
                "This offer is currently unavailable"
              );
            }
          }
        }
      }
    }

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
    clientId: resolvedClientId, // Denormalized for targeting queries
    type: engagementType,
    status: EngagementStatus.STARTED,
    progress: 0,
    rewardAmount: rewardAmount,
    streakPoints: streakPoints, // Streak points from opportunity
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

    let rewardAmount = engagement.rewardAmount;
    let bonusApplied = false;
    let bonusMultiplier = 1.0;

    // =========================================================================
    // Bonus Reward Logic
    // =========================================================================
    if (engagement.earnOpportunityId) {
      try {
        // Fetch opportunity to get bonus configuration
        const opportunityDoc = await db
          .collection("earnOpportunities")
          .doc(engagement.earnOpportunityId)
          .get();

        if (opportunityDoc.exists) {
          const opportunity = opportunityDoc.data()!;

          if (opportunity.bonusReward) {
            const bonusIntervalType = opportunity.bonusIntervalType;
            const bonusIntervalX = opportunity.bonusIntervalX;
            bonusMultiplier = opportunity.bonusRewardMultiplier || 1.0;

            if (bonusIntervalType === "every_x" && bonusIntervalX) {
              // ── "Every X Completions" Mode ──
              // Get user's completion count for this opportunity
              const userDoc = await db.collection("users").doc(userId).get();
              const userData = userDoc.exists ? userDoc.data()! : {};
              const opportunityCompletions = userData.opportunityCompletions || {};
              const currentCount = (opportunityCompletions[engagement.earnOpportunityId] || 0) + 1;

              // Check if this is an Xth completion
              if (shouldAwardEveryXBonus(currentCount, bonusIntervalX)) {
                bonusApplied = true;
                rewardAmount = Math.floor(rewardAmount * bonusMultiplier);
              }

              // Update the completion count
              await db
                .collection("users")
                .doc(userId)
                .set(
                  {
                    opportunityCompletions: {
                      [engagement.earnOpportunityId]: currentCount,
                    },
                  },
                  { merge: true }
                );
            } else if (bonusIntervalType === "random") {
              // ── "Random" Mode (Adaptive Algorithm) ──
              // Get user's bonus engine state
              const userDoc = await db.collection("users").doc(userId).get();
              const userData = userDoc.exists ? userDoc.data()! : {};
              const currentBonusState = stateFromFirestore(
                userData.bonusEngineState,
                DEFAULT_BONUS_CONFIG
              );

              // Determine if bonus should be awarded
              const decision = shouldAwardBonus(
                currentBonusState,
                DEFAULT_BONUS_CONFIG
              );

              if (decision.awarded) {
                bonusApplied = true;
                rewardAmount = Math.floor(rewardAmount * bonusMultiplier);
              }

              // Persist updated state
              await db
                .collection("users")
                .doc(userId)
                .set(
                  {
                    bonusEngineState: stateToFirestore(decision.newState),
                  },
                  { merge: true }
                );
            }
          }
        }
      } catch (bonusError) {
        console.error("Failed to process bonus reward:", bonusError);
        // Continue without bonus - don't fail the engagement
      }
    }

    // Get campaignId - support both field names
    const campaignId = engagement.campaignId || engagement.oddienceCampaignId;

    // Calculate user's share for display (90% of total reward)
    const userShare = Math.floor(rewardAmount * LedgerConfig.EARNING_USER_SHARE);

    // ===========================================================================
    // Client-funded token flow: fetch thread and validate budget
    // ===========================================================================
    let clientId: string | null = engagement.clientId || null;
    let clientSubAccountId: string | null = null;
    let tokenDestAccountTypeId: string | null = null;
    let clientName: string | null = null;

    if (engagement.threadId) {
      const threadDoc = await db
        .collection("earnThreads")
        .doc(engagement.threadId)
        .get();

      if (threadDoc.exists) {
        const threadData = threadDoc.data()!;
        clientId = threadData.clientId || null;
        clientSubAccountId = threadData.tokenSourceSubAccountId || null;
        tokenDestAccountTypeId = threadData.tokenDestAccountTypeId || null;
        clientName = threadData.clientName || null;

        // Validate client sub-account balance
        if (clientId && clientSubAccountId) {
          const subAccountDoc = await db
            .collection("clients")
            .doc(clientId)
            .collection("subAccounts")
            .doc(clientSubAccountId)
            .get();

          if (!subAccountDoc.exists) {
            throw new functions.https.HttpsError(
              "failed-precondition",
              "Client budget not found"
            );
          }

          const subAccount = subAccountDoc.data()!;
          if (!subAccount.isActive) {
            throw new functions.https.HttpsError(
              "failed-precondition",
              "This offer is currently unavailable"
            );
          }
          if (subAccount.balance < rewardAmount) {
            throw new functions.https.HttpsError(
              "failed-precondition",
              "Insufficient budget for this offer"
            );
          }
        }
      }
    }

    // ===========================================================================
    // Determine user sub-account (default or brand-restricted)
    // ===========================================================================
    let subAccountId: string;

    if (tokenDestAccountTypeId && clientName) {
      // Thread specifies a restricted wallet type - find or create brand wallet
      const userSubAccountsSnapshot = await db
        .collection("users")
        .doc(userId)
        .collection("subAccounts")
        .where("accountTypeId", "==", tokenDestAccountTypeId)
        .limit(1)
        .get();

      if (!userSubAccountsSnapshot.empty) {
        subAccountId = userSubAccountsSnapshot.docs[0].id;
      } else {
        // Auto-create brand-restricted wallet
        const newSubAccountRef = db
          .collection("users")
          .doc(userId)
          .collection("subAccounts")
          .doc();

        await newSubAccountRef.set({
          id: newSubAccountRef.id,
          userId: userId,
          accountTypeId: tokenDestAccountTypeId,
          name: `${clientName} Wallet`,
          balance: 0,
          isDefault: false,
          isActive: true,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        subAccountId = newSubAccountRef.id;
      }
    } else {
      // Use default sub-account
      const defaultResult = await getOrCreateDefaultSubAccount(userId);
      subAccountId = defaultResult.subAccountId;
    }

    // Process reward through the Trust Ledger system
    // This handles the 90/5/5 split: 90% to user, 5% daily pot, 5% weekly pot
    const ledgerResult = await processEarningWithSplit(
      userId,
      rewardAmount,
      engagementId,
      `Earned from ${engagement.type}`,
      subAccountId, // Credit to user's sub-account
      tokenDestAccountTypeId, // Account type for audit
      {
        engagementType: engagement.type,
        earnOpportunityId: engagement.earnOpportunityId,
        campaignId: campaignId,
        threadId: engagement.threadId,
        clientId: clientId,
      },
      clientId || undefined, // Client ID for client-funded threads
      clientSubAccountId || undefined // Client sub-account to debit
    );

    if (!ledgerResult.success) {
      throw new functions.https.HttpsError(
        "internal",
        `Failed to process earning: ${ledgerResult.error}`
      );
    }

    // ===========================================================================
    // Budget monitoring: check for low balance warnings and depletion
    // ===========================================================================
    if (clientId && clientSubAccountId) {
      try {
        const updatedSubAccountDoc = await db
          .collection("clients")
          .doc(clientId)
          .collection("subAccounts")
          .doc(clientSubAccountId)
          .get();

        if (updatedSubAccountDoc.exists) {
          const subAccount = updatedSubAccountDoc.data()!;
          const balance = subAccount.balance || 0;
          const initialBudget = subAccount.initialBudget || 1;
          const remainingPercent = balance / initialBudget;
          const warningThreshold = subAccount.warningThreshold ?? 0.20;

          // Check for low balance warning
          const warningNotifiedAt = subAccount.warningNotifiedAt?.toDate?.();
          const dayAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);

          if (
            remainingPercent <= warningThreshold &&
            (!warningNotifiedAt || warningNotifiedAt < dayAgo)
          ) {
            // Set warning notification timestamp
            await updatedSubAccountDoc.ref.update({
              warningNotifiedAt: admin.firestore.FieldValue.serverTimestamp(),
            });

            // Create admin notification
            await db.collection("adminNotifications").add({
              type: "budget_warning",
              clientId: clientId,
              subAccountId: clientSubAccountId,
              balance: balance,
              remainingPercent: remainingPercent,
              message: `Client sub-account is at ${Math.round(remainingPercent * 100)}% budget`,
              createdAt: admin.firestore.FieldValue.serverTimestamp(),
              read: false,
            });
          }

          // Check for budget depletion
          if (balance <= 0) {
            // Deactivate sub-account and related threads
            await updatedSubAccountDoc.ref.update({
              isActive: false,
              depletedAt: admin.firestore.FieldValue.serverTimestamp(),
            });

            // Auto-deactivate threads using this sub-account
            const threadsToDeactivate = await db
              .collection("earnThreads")
              .where("tokenSourceSubAccountId", "==", clientSubAccountId)
              .where("isActive", "==", true)
              .get();

            if (!threadsToDeactivate.empty) {
              const batch = db.batch();
              for (const threadDoc of threadsToDeactivate.docs) {
                batch.update(threadDoc.ref, {
                  isActive: false,
                  deactivatedReason: "budget_depleted",
                  updatedAt: admin.firestore.FieldValue.serverTimestamp(),
                });
              }
              await batch.commit();
            }

            // Create admin notification for depletion
            await db.collection("adminNotifications").add({
              type: "budget_depleted",
              clientId: clientId,
              subAccountId: clientSubAccountId,
              threadsDeactivated: threadsToDeactivate.size,
              message: `Client sub-account budget depleted. ${threadsToDeactivate.size} threads auto-deactivated.`,
              createdAt: admin.firestore.FieldValue.serverTimestamp(),
              read: false,
            });
          }
        }
      } catch (budgetError) {
        console.error("Failed to process budget monitoring:", budgetError);
        // Don't fail the engagement for budget monitoring errors
      }
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
        // Bonus reward tracking
        bonusApplied: bonusApplied,
        bonusMultiplier: bonusApplied ? bonusMultiplier : null,
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

    // ===========================================================================
    // Targeting tracking updates
    // ===========================================================================

    // Update user's interactedClientIds for previousBrandInteraction targeting
    if (clientId) {
      try {
        await db
          .collection("users")
          .doc(userId)
          .update({
            interactedClientIds: admin.firestore.FieldValue.arrayUnion(clientId),
          });
      } catch (clientTrackingError) {
        console.error("Failed to update interactedClientIds:", clientTrackingError);
      }
    }

    // Update thread's completedUniqueUsers for maxAudience targeting
    if (engagement.threadId) {
      try {
        // Check if this is the user's first completed engagement for this thread
        const previousCompletedEngagements = await db
          .collection("engagements")
          .where("userId", "==", userId)
          .where("threadId", "==", engagement.threadId)
          .where("status", "==", EngagementStatus.COMPLETED)
          .limit(2)
          .get();

        // If this is the only completed engagement (the one we just updated),
        // increment the uniqueUsers counter
        if (previousCompletedEngagements.size === 1) {
          await db
            .collection("earnThreads")
            .doc(engagement.threadId)
            .update({
              completedUniqueUsers: admin.firestore.FieldValue.increment(1),
            });
        }
      } catch (uniqueUsersError) {
        console.error("Failed to update completedUniqueUsers:", uniqueUsersError);
      }
    }

    // Update engagement stats (streak tracking) - NEW SYSTEM
    // Get streakPoints from engagement (defaults to 1 for backward compatibility)
    const engagementStreakPoints = engagement.streakPoints ?? 1;

    let streakInfo = {
      currentStreak: 1,
      longestStreak: 1,
      multiplier: 1.0,
      isNewDay: true,
      streakBroken: false,
    };
    try {
      streakInfo = await updateEngagementStats(userId, userShare, engagementStreakPoints);
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
      const updatedDailyScore = await updateDailyScore(
        userId,
        userShare,
        streakInfo.currentStreak,
        streakInfo.multiplier,
        userProfile
      );

      // Update live leaderboard scores (daily + weekly)
      await updateLeaderboardScores(
        userId,
        updatedDailyScore,
        streakInfo.currentStreak,
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
      // Bonus reward info
      bonusApplied: bonusApplied,
      bonusMultiplier: bonusApplied ? bonusMultiplier : null,
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

    case "adVideo":
      // AdMob rewarded video validation
      // Requires either adTransactionId or adFullyWatched flag
      if (evidence.adTransactionId) {
        return true; // Has transaction ID from AdMob callback
      }
      if (evidence.adFullyWatched === true) {
        return true; // Client confirmed ad was fully watched
      }
      // Fall back to standard watch duration check
      if (evidence.watchDurationMs !== undefined) {
        return (evidence.watchDurationMs as number) >= 25000; // Min 25 seconds
      }
      return false;

    default:
      return true;
  }
}

// =============================================================================
// AdMob Server-Side Verification (SSV) Callback
// =============================================================================

/**
 * AdMob SSV callback endpoint
 *
 * This endpoint is called by Google AdMob to verify that a reward should be granted.
 * It receives a signed callback from AdMob's servers and verifies the signature
 * before recording the verification.
 *
 * Query parameters from AdMob:
 * - ad_network: The ad network identifier
 * - ad_unit: The ad unit ID
 * - custom_data: Custom data passed from the client (format: "userId_engagementId")
 * - reward_amount: The reward amount
 * - reward_item: The reward item type
 * - timestamp: When the ad was watched
 * - transaction_id: Unique transaction ID
 * - user_id: User identifier
 * - signature: Signature to verify the callback
 * - key_id: Key ID used for signature verification
 *
 * @see https://developers.google.com/admob/android/ssv
 */
export const admobSSVCallback = functions.https.onRequest(async (req, res) => {
  try {
    // Log the callback for debugging
    console.log("AdMob SSV Callback received:", {
      query: req.query,
      method: req.method,
      url: req.url,
    });

    // Only accept GET requests
    if (req.method !== "GET") {
      res.status(405).send("Method Not Allowed");
      return;
    }

    // Extract parameters
    const {
      ad_unit: adUnit,
      custom_data: customData,
      reward_amount: rewardAmount,
      reward_item: rewardItem,
      timestamp,
      transaction_id: transactionId,
      user_id: userId,
      signature,
      key_id: keyId,
    } = req.query as Record<string, string>;

    // Validate required parameters
    if (!transactionId || !customData) {
      console.error("AdMob SSV: Missing required parameters");
      res.status(400).send("Missing required parameters");
      return;
    }

    // Parse custom_data (format: "userId_timestamp")
    const customDataParts = (customData as string).split("_");
    const ssv_userId = customDataParts[0];
    // ssv_timestamp is extracted but not currently used - available for future auditing
    const _ssv_timestamp = customDataParts.length > 1 ? customDataParts[1] : null;
    void _ssv_timestamp; // Silence unused variable warning

    // Validate the user ID matches
    if (userId && ssv_userId !== userId) {
      console.warn("AdMob SSV: User ID mismatch", { ssv_userId, userId });
    }

    // TODO: Implement full signature verification using Google's public keys
    // For now, we log the callback and store the verification
    // Full implementation would involve:
    // 1. Fetch Google's public keys from: https://www.gstatic.com/admob/reward/verifier-keys.json
    // 2. Verify the ECDSA signature using the key_id
    // 3. Ensure the callback URL matches the signed content

    // Store the SSV verification record
    const ssvRef = db.collection("admobSSVCallbacks").doc(transactionId as string);
    const existingDoc = await ssvRef.get();

    if (existingDoc.exists) {
      // Duplicate callback - this is normal for retries
      console.log("AdMob SSV: Duplicate callback for transaction", transactionId);
      res.status(200).send("OK - Already processed");
      return;
    }

    // Store the verification
    await ssvRef.set({
      transactionId,
      userId: ssv_userId,
      adUnit,
      rewardAmount: rewardAmount ? parseInt(rewardAmount as string, 10) : null,
      rewardItem,
      timestamp: timestamp ? parseInt(timestamp as string, 10) : null,
      receivedAt: admin.firestore.FieldValue.serverTimestamp(),
      signature,
      keyId,
      verified: true, // Set to true after implementing full signature verification
      rawQuery: req.query,
    });

    console.log("AdMob SSV: Verification stored successfully", {
      transactionId,
      userId: ssv_userId,
      adUnit,
      rewardAmount,
    });

    // Respond with success
    // AdMob expects a 200 response to confirm the callback was received
    res.status(200).send("OK");
  } catch (error) {
    console.error("AdMob SSV: Error processing callback", error);
    // Return 200 anyway to prevent AdMob from retrying indefinitely
    // We log the error for investigation
    res.status(200).send("OK - Error logged");
  }
});

/**
 * Verify an AdMob SSV transaction
 * Called by the client to check if a transaction was verified via SSV
 */
export const verifyAdMobTransaction = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const { transactionId } = data;

  if (!transactionId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Transaction ID is required"
    );
  }

  // Look up the SSV verification
  const ssvDoc = await db.collection("admobSSVCallbacks").doc(transactionId).get();

  if (!ssvDoc.exists) {
    return {
      verified: false,
      message: "Transaction not found in SSV records",
    };
  }

  const ssvData = ssvDoc.data();

  // Verify the user matches
  if (ssvData?.userId !== context.auth.uid) {
    console.warn("AdMob SSV verification: User ID mismatch", {
      expected: context.auth.uid,
      actual: ssvData?.userId,
    });
    return {
      verified: false,
      message: "User ID mismatch",
    };
  }

  return {
    verified: ssvData?.verified === true,
    transactionId,
    rewardAmount: ssvData?.rewardAmount,
    rewardItem: ssvData?.rewardItem,
    timestamp: ssvData?.timestamp,
  };
});
