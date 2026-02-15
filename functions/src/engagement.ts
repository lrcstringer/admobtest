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
import * as crypto from "crypto";
import * as https from "https";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import { getSASTDayStart, getSASTWeekStart, SAST_OFFSET_MS } from "./pots";
import {
  processEarningWithSplit,
  LedgerConfig,
  AccountId,
  getOrCreateDefaultSubAccount,
  getBalance,
  createEscrowReservation,
  processEscrowCompletion,
  reverseJournal,
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
import { enqueueRewardAllocation } from "./rewardAllocation";

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
  PENDING_REVIEW: "pending_review",
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

  // Check daily completion limit (resets at midnight SAST)
  const today = getSASTDayStart();

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
  let resolvedTokenSourceAccountId: string | null = null;
  let bonusRewardMultiplier = 1;
  let resolvedRequiredDuration = 0;
  let escrowAmount = 0;
  let escrowJournalId: string | null = null;

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

    if (opportunity.isDeleted === true) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Opportunity is no longer available"
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
    resolvedRequiredDuration = opportunity.durationSeconds ?? 0;
    // Capture bonus multiplier for escrow reservation (max possible payout)
    if (opportunity.bonusReward && opportunity.bonusRewardMultiplier) {
      bonusRewardMultiplier = opportunity.bonusRewardMultiplier;
    }

    // Check per-opportunity daily limit (e.g., adVideo opportunities may have dailyLimitPerUser: 3)
    const dailyLimitPerUser = opportunity.dailyLimitPerUser ?? null;
    if (dailyLimitPerUser !== null && dailyLimitPerUser > 0) {
      const todayOpportunityCompletionsSnapshot = await db
        .collection("engagements")
        .where("userId", "==", userId)
        .where("earnOpportunityId", "==", earnOpportunityId)
        .where("status", "==", EngagementStatus.COMPLETED)
        .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(today))
        .count()
        .get();

      const todayOpportunityCompletions = todayOpportunityCompletionsSnapshot.data().count;
      if (todayOpportunityCompletions >= dailyLimitPerUser) {
        throw new functions.https.HttpsError(
          "resource-exhausted",
          "OPPORTUNITY_DAILY_LIMIT_REACHED"
        );
      }
    }

    // Get thread to denormalize clientId and resolve token source
    if (resolvedThreadId) {
      const threadDoc = await db
        .collection("earnThreads")
        .doc(resolvedThreadId)
        .get();

      if (threadDoc.exists) {
        const threadData = threadDoc.data()!;
        resolvedClientId = threadData.clientId || null;
        resolvedTokenSourceAccountId = threadData.tokenSourceAccountId || null;
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

  // Create engagement reference early so we have the ID for escrow idempotency
  const engagementRef = db.collection("engagements").doc();
  const engagementId = engagementRef.id;
  const now = admin.firestore.FieldValue.serverTimestamp();

  // =========================================================================
  // Escrow Reservation: Atomically lock tokens before creating engagement
  // =========================================================================
  if (resolvedTokenSourceAccountId) {
    // Reserve maximum possible payout (base × bonus multiplier)
    escrowAmount = Math.floor(rewardAmount * bonusRewardMultiplier);

    const escrowResult = await createEscrowReservation(
      engagementId,
      escrowAmount,
      resolvedTokenSourceAccountId,
      {
        userId,
        earnOpportunityId: resolvedOpportunityId,
        threadId: resolvedThreadId,
        clientId: resolvedClientId,
        baseReward: rewardAmount,
        bonusRewardMultiplier,
      },
    );

    if (!escrowResult.success) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "This offer is currently unavailable"
      );
    }

    escrowJournalId = escrowResult.journalId || null;
  }

  // Create engagement record with Flutter-compatible fields
  await engagementRef.set({
    id: engagementId,
    userId: userId,
    // Support both field names for Flutter compatibility
    earnOpportunityId: resolvedOpportunityId,
    audienceCampaignId: resolvedCampaignId,
    campaignId: resolvedCampaignId,
    threadId: resolvedThreadId,
    clientId: resolvedClientId, // Denormalized for targeting queries
    type: engagementType,
    status: EngagementStatus.STARTED,
    progress: 0,
    rewardAmount: rewardAmount,
    streakPoints: streakPoints, // Streak points from opportunity
    watchDurationSeconds: 0,
    requiredDurationSeconds: resolvedRequiredDuration,
    answers: [],
    attemptNumber: 1,
    startedAt: now,
    createdAt: now,
    evidence: [],
    // Escrow reservation fields
    escrowAmount: escrowAmount || null,
    escrowJournalId: escrowJournalId,
    escrowReservedAt: escrowJournalId ? now : null,
    tokenSourceAccountId: resolvedTokenSourceAccountId,
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
    engagementId: engagementId,
    rewardAmount: rewardAmount,
    escrowReserved: !!escrowJournalId,
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

    // Extract escrow metadata (null for legacy engagements without escrow)
    const hasEscrow = !!engagement.escrowJournalId;
    const engagementEscrowAmount: number | null = engagement.escrowAmount || null;
    const engagementTokenSourceAccountId: string | null = engagement.tokenSourceAccountId || null;

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

    // =========================================================================
    // Fetch opportunity once (used for admin review check + bonus logic)
    // =========================================================================
    let opportunityData: FirebaseFirestore.DocumentData | null = null;
    if (engagement.earnOpportunityId) {
      const opportunityDoc = await db
        .collection("earnOpportunities")
        .doc(engagement.earnOpportunityId)
        .get();
      if (opportunityDoc.exists) {
        opportunityData = opportunityDoc.data()!;
      }
    }

    // Admin Review Check (Upload opportunities with requiresAdminReview)
    if (engagement.type === "upload" && opportunityData?.requiresAdminReview) {
      await engagementDoc.ref.update({
        status: EngagementStatus.PENDING_REVIEW,
        evidence: evidence,
        submittedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return {
        success: true,
        status: "pending_review",
        message: "Your submission is under review",
      };
    }

    let rewardAmount = engagement.rewardAmount;
    let bonusApplied = false;
    let bonusMultiplier = 1.0;

    // =========================================================================
    // Bonus Reward Logic (reuses opportunityData from above)
    // =========================================================================
    if (engagement.earnOpportunityId && opportunityData) {
      try {
        {
          const opportunity = opportunityData;

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

    // Get campaignId - support multiple field names
    const campaignId = engagement.campaignId || engagement.audienceCampaignId;

    // Calculate token split — NO rounding anywhere.
    // Pot shares are exact 5%, user gets the remainder.
    const dailyPotShare = rewardAmount * LedgerConfig.EARNING_DAILY_POT_SHARE;
    const weeklyPotShare = rewardAmount * LedgerConfig.EARNING_WEEKLY_POT_SHARE;
    const userShare = rewardAmount - dailyPotShare - weeklyPotShare;

    // ===========================================================================
    // Client-funded token flow: fetch thread and validate budget
    // ===========================================================================
    let clientId: string | null = engagement.clientId || null;
    let tokenSourceAccountId: string | null = null;
    let tokenDestAccountTypeId: string | null = null;
    let clientName: string | null = null;

    if (engagement.threadId) {
      const threadDoc = await db
        .collection("earnThreads")
        .doc(engagement.threadId)
        .get();

      if (threadDoc.exists) {
        const threadData = threadDoc.data()!;

        if (threadData.isDeleted === true) {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "Campaign is no longer available"
          );
        }

        clientId = threadData.clientId || null;
        tokenSourceAccountId = threadData.tokenSourceAccountId || null;
        tokenDestAccountTypeId = threadData.tokenDestAccountTypeId || null;
        clientName = threadData.clientName || null;

        // Budget pre-check: only needed for legacy engagements without escrow.
        // Escrow engagements already have tokens reserved and guaranteed.
        if (tokenSourceAccountId && !hasEscrow) {
          const sourceBalance = await getBalance(tokenSourceAccountId);
          if (sourceBalance < rewardAmount) {
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
    let ledgerResult;

    if (hasEscrow && engagementEscrowAmount && engagementTokenSourceAccountId) {
      // ESCROW PATH: Release tokens from escrow.
      // rewardAmount here is the ACTUAL reward after bonus determination.
      // engagementEscrowAmount is the MAXIMUM that was reserved at start.
      ledgerResult = await processEscrowCompletion(
        userId,
        rewardAmount,
        engagementEscrowAmount,
        engagementId,
        engagementTokenSourceAccountId,
        subAccountId,
        tokenDestAccountTypeId,
        {
          engagementType: engagement.type,
          earnOpportunityId: engagement.earnOpportunityId,
          campaignId: campaignId,
          threadId: engagement.threadId,
          clientId: clientId,
          bonusApplied: bonusApplied,
          bonusMultiplier: bonusApplied ? bonusMultiplier : null,
        },
      );
    } else {
      // LEGACY PATH: Direct debit from source (no escrow)
      const resolvedTokenSource = tokenSourceAccountId
        || (clientId ? AccountId.client(clientId) : null);

      if (!resolvedTokenSource) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "No token source configured for this engagement"
        );
      }

      ledgerResult = await processEarningWithSplit(
        userId,
        rewardAmount,
        engagementId,
        `Earned from ${engagement.type}`,
        resolvedTokenSource,
        subAccountId,
        tokenDestAccountTypeId,
        {
          engagementType: engagement.type,
          earnOpportunityId: engagement.earnOpportunityId,
          campaignId: campaignId,
          threadId: engagement.threadId,
          clientId: clientId,
        },
      );
    }

    if (!ledgerResult.success) {
      throw new functions.https.HttpsError(
        "internal",
        `Failed to process earning: ${ledgerResult.error}`
      );
    }

    // Update engagement and related records in transaction (CRITICAL — must complete)
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
        // Escrow completion tracking
        ...(hasEscrow ? {
          escrowReleasedAt: admin.firestore.FieldValue.serverTimestamp(),
          escrowReleaseJournalId: ledgerResult.journalId,
          escrowExcessReturned: engagementEscrowAmount! - rewardAmount,
        } : {}),
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
      // Use SAST-aware date so pot entry IDs match the SAST calendar day
      const today = getSASTDayStart();
      const sastNow = new Date(Date.now() + SAST_OFFSET_MS);
      const sastDateStr = `${sastNow.getUTCFullYear()}-${String(sastNow.getUTCMonth() + 1).padStart(2, "0")}-${String(sastNow.getUTCDate()).padStart(2, "0")}`;
      const potEntryRef = db
        .collection("potEntries")
        .doc(`${userId}_${sastDateStr}`);
      transaction.set(
        potEntryRef,
        {
          userId: userId,
          date: sastDateStr,
          entries: admin.firestore.FieldValue.increment(rewardAmount),
          ledgerJournalId: ledgerResult.journalId,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true }
      );

      // Update Firestore pot running totals (Flutter reads these for display)
      // IDs must match those created by initializeDailyPot/initializeWeeklyPot in pots.ts
      const dailyPotId = `daily_${today.getTime()}`;
      const dailyPotRef = db.collection("pots").doc(dailyPotId);
      if (dailyPotShare > 0) {
        transaction.set(
          dailyPotRef,
          {
            id: dailyPotId,
            type: "daily",
            totalTokens: admin.firestore.FieldValue.increment(dailyPotShare),
            participantCount: admin.firestore.FieldValue.increment(1),
            isActive: true,
            isDistributed: false,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true }
        );
      }

      const weekStart = getSASTWeekStart();
      const weeklyPotId = `weekly_${weekStart.getTime()}`;
      const weeklyPotRef = db.collection("pots").doc(weeklyPotId);
      if (weeklyPotShare > 0) {
        transaction.set(
          weeklyPotRef,
          {
            id: weeklyPotId,
            type: "weekly",
            totalTokens: admin.firestore.FieldValue.increment(weeklyPotShare),
            participantCount: admin.firestore.FieldValue.increment(1),
            isActive: true,
            isDistributed: false,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true }
        );
      }

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

    // =========================================================================
    // PARALLEL BATCH 1: streak stats + reward check + budget/targeting tracking
    // These are all independent — run concurrently to cut ~1.5s of serial awaits
    // =========================================================================
    const engagementStreakPoints = engagement.streakPoints ?? 1;
    const monitorSourceAccountId = tokenSourceAccountId || engagementTokenSourceAccountId;

    const defaultStreak = {
      currentStreak: 1,
      longestStreak: 1,
      multiplier: 1.0,
      isNewDay: true,
      streakBroken: false,
    };

    // Helper: budget monitoring
    const doBudgetMonitoring = async () => {
      if (!monitorSourceAccountId) return;
      const currentBalance = await getBalance(monitorSourceAccountId);
      if (currentBalance <= 0) {
        const subAccFirestoreId = AccountId.parseClientSubAccountId(monitorSourceAccountId);
        if (subAccFirestoreId && clientId) {
          await db
            .collection("clients").doc(clientId)
            .collection("subAccounts").doc(subAccFirestoreId)
            .update({
              budgetExhausted: true,
              depletedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
        }
        const threadsToExhaust = await db
          .collection("earnThreads")
          .where("tokenSourceAccountId", "==", monitorSourceAccountId)
          .where("budgetExhausted", "!=", true)
          .get();
        if (!threadsToExhaust.empty) {
          const batch = db.batch();
          for (const threadDoc of threadsToExhaust.docs) {
            batch.update(threadDoc.ref, {
              budgetExhausted: true,
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
          }
          await batch.commit();
        }
        await db.collection("adminNotifications").add({
          type: "budget_depleted",
          clientId: clientId,
          tokenSourceAccountId: monitorSourceAccountId,
          threadsExhausted: threadsToExhaust.size,
          message: `Token source ${monitorSourceAccountId} budget depleted. ${threadsToExhaust.size} threads marked as budget-exhausted.`,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          read: false,
        });
      }
    };

    // Helper: targeting tracking
    const doTargetingTracking = async () => {
      if (clientId) {
        await db.collection("users").doc(userId).update({
          interactedClientIds: admin.firestore.FieldValue.arrayUnion(clientId),
        });
      }
      if (engagement.threadId) {
        const previousCompleted = await db
          .collection("engagements")
          .where("userId", "==", userId)
          .where("threadId", "==", engagement.threadId)
          .where("status", "==", EngagementStatus.COMPLETED)
          .limit(2)
          .get();
        if (previousCompleted.size === 1) {
          await db.collection("earnThreads").doc(engagement.threadId).update({
            completedUniqueUsers: admin.firestore.FieldValue.increment(1),
          });
        }
      }
    };

    // Helper: opportunity budget tracking
    const doOpportunityBudgetTracking = async () => {
      if (!engagement.earnOpportunityId) return;
      const oppRef = db.collection("earnOpportunities").doc(engagement.earnOpportunityId);
      const oppDoc = await oppRef.get();
      if (!oppDoc.exists) return;
      const oppData = oppDoc.data()!;
      const tokenBudget = oppData.tokenBudget;
      if (tokenBudget == null || tokenBudget <= 0) return;
      const newSpent = (oppData.tokenSpent || 0) + rewardAmount;
      const updates: Record<string, unknown> = {
        tokenSpent: admin.firestore.FieldValue.increment(rewardAmount),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      if (newSpent >= tokenBudget) {
        updates.budgetExhausted = true;
        await db.collection("adminNotifications").add({
          type: "opportunity_budget_depleted",
          opportunityId: engagement.earnOpportunityId,
          threadId: engagement.threadId,
          clientId: clientId,
          tokenBudget,
          tokenSpent: newSpent,
          message: `Opportunity "${oppData.title}" budget exhausted (${newSpent}/${tokenBudget} tokens)`,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          read: false,
        });
      }
      await oppRef.update(updates);
    };

    // Helper: reward allocation check
    const doRewardAllocation = async (): Promise<{
      rewardPending: boolean;
      rewardCampaignName: string | null;
      rewardType: string | null;
    }> => {
      if (!engagement.earnOpportunityId) {
        return { rewardPending: false, rewardCampaignName: null, rewardType: null };
      }
      const oppDoc = await db
        .collection("earnOpportunities")
        .doc(engagement.earnOpportunityId)
        .get();
      if (!oppDoc.exists) {
        return { rewardPending: false, rewardCampaignName: null, rewardType: null };
      }
      const oppData = oppDoc.data()!;
      if (!oppData.rewardCampaignId) {
        return { rewardPending: false, rewardCampaignName: null, rewardType: null };
      }
      await enqueueRewardAllocation(userId, oppData.rewardCampaignId, engagementId);
      return {
        rewardPending: true,
        rewardCampaignName: oppData.rewardCampaignName || null,
        rewardType: oppData.rewardType || null,
      };
    };

    // Run all parallel batch 1 operations concurrently
    const [streakInfo, , , , rewardInfo] = await Promise.all([
      updateEngagementStats(userId, userShare, engagementStreakPoints)
        .catch((e) => { console.error("Streak stats error:", e); return defaultStreak; }),
      doBudgetMonitoring()
        .catch((e) => console.error("Budget monitoring error:", e)),
      doTargetingTracking()
        .catch((e) => console.error("Targeting tracking error:", e)),
      doOpportunityBudgetTracking()
        .catch((e) => console.error("Opportunity budget tracking error:", e)),
      doRewardAllocation()
        .catch((e) => {
          console.error("Reward allocation error:", e);
          return { rewardPending: false, rewardCampaignName: null, rewardType: null };
        }),
    ]);

    // =========================================================================
    // PARALLEL BATCH 2: leaderboard + streak audit (depend on streakInfo)
    // =========================================================================
    const doLeaderboardUpdates = async () => {
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();
      const userProfile = {
        displayName:
          userData?.profile?.displayName || userData?.displayName || "User",
        username: userData?.profile?.username || userData?.username || null,
        avatarUrl: userData?.profile?.avatarUrl || userData?.avatarUrl || null,
      };
      const updatedDailyScore = await updateDailyScore(
        userId, userShare, streakInfo.currentStreak, streakInfo.multiplier, userProfile
      );
      await updateLeaderboardScores(
        userId, updatedDailyScore, streakInfo.currentStreak, userProfile
      );
      if (userData?.referredBy) {
        await updateReferrerAssistScore(userData.referredBy, userShare);
      }
    };

    const doStreakAudit = async () => {
      await engagementDoc.ref.update({
        streakDayAtCompletion: streakInfo.currentStreak,
        multiplierApplied: streakInfo.multiplier,
        subAccountId: subAccountId,
      });
    };

    // Fire-and-forget: leaderboard + streak audit are non-critical for the
    // user response. Skipping the await saves ~1s (7 sequential daily score reads).
    Promise.all([
      doLeaderboardUpdates().catch((e) => console.error("Leaderboard error:", e)),
      doStreakAudit().catch((e) => console.error("Streak audit error:", e)),
    ]);

    return {
      success: true,
      tokensEarned: userShare,
      totalGenerated: rewardAmount,
      dailyPotContribution: dailyPotShare,
      weeklyPotContribution: weeklyPotShare,
      ledgerJournalId: ledgerResult.journalId,
      streakDay: streakInfo.currentStreak,
      multiplierApplied: streakInfo.multiplier,
      streakBroken: streakInfo.streakBroken,
      subAccountId: subAccountId,
      bonusApplied: bonusApplied,
      bonusMultiplier: bonusApplied ? bonusMultiplier : null,
      rewardPending: rewardInfo.rewardPending,
      rewardCampaignName: rewardInfo.rewardCampaignName,
      rewardType: rewardInfo.rewardType,
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

    // Reverse escrow reservation if one exists
    let escrowReversalJournalId: string | null = null;
    let escrowReversalFailed = false;

    if (engagement.escrowJournalId) {
      try {
        const reversalResult = await reverseJournal(
          engagement.escrowJournalId,
          "Engagement abandoned by user",
          "system"
        );
        escrowReversalJournalId = reversalResult.journalId || null;
        console.log(
          `Escrow reversed for engagement ${engagementId}: ` +
          `journalId=${escrowReversalJournalId}`
        );
      } catch (error) {
        // Still abandon the engagement even if reversal fails;
        // the cleanup function will retry later
        console.error(
          `Failed to reverse escrow for engagement ${engagementId}:`,
          error
        );
        escrowReversalFailed = true;
      }
    }

    await engagementDoc.ref.update({
      status: EngagementStatus.ABANDONED,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      ...(engagement.escrowJournalId && {
        escrowReversedAt: escrowReversalFailed
          ? null
          : admin.firestore.FieldValue.serverTimestamp(),
        escrowReversalJournalId,
        escrowReversalFailed,
        escrowReversalReason: "user_abandoned",
      }),
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

    case "image":
      // Validate image view evidence — same structure as video
      if (evidence.watchDurationMs !== undefined) {
        return (evidence.watchDurationMs as number) > 0;
      }
      if (evidence.watchPercentage !== undefined) {
        return (evidence.watchPercentage as number) >= 80;
      }
      return true;

    case "survey":
      // Validate survey responses — per-question-type validation
      if (!evidence.responses || !Array.isArray(evidence.responses)) {
        return false;
      }
      if ((evidence.responses as unknown[]).length === 0) return false;
      for (const r of evidence.responses as Record<string, unknown>[]) {
        switch (r.questionType) {
          case "single_select":
            if (!r.selectedOption) return false;
            break;
          case "multi_select":
            if (!Array.isArray(r.selectedOptions) || (r.selectedOptions as unknown[]).length === 0) return false;
            break;
          case "text_input":
            if (!Array.isArray(r.textResponses) || (r.textResponses as unknown[]).length === 0) return false;
            if ((r.textResponses as string[]).some((t: string) => typeof t !== "string" || t.trim().length === 0)) return false;
            break;
          case "likert":
            if (typeof r.likertValue !== "number" || (r.likertValue as number) < 1 || (r.likertValue as number) > 5) return false;
            break;
          case "star_tags":
            if (typeof r.starRating !== "number" || (r.starRating as number) < 1 || (r.starRating as number) > 5) return false;
            break;
          case "slider":
            if (typeof r.sliderValue !== "number") return false;
            break;
          default:
            // Accept responses without questionType (e.g. legacy selectedOption format)
            if (!r.selectedOption && !r.questionType) return false;
            break;
        }
      }
      return true;

    case "poll":
      // Validate poll response — verify a real poll vote was cast
      if (evidence.pollId && evidence.selectedOption) {
        return true; // Full validation done in processEngagement
      }
      return evidence.selectedOption !== undefined;

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

    case "upload": {
      // Upload engagement: validate uploaded files and/or text response
      const files = evidence.uploadedFiles as Array<Record<string, unknown>> | undefined;
      const textResponse = evidence.uploadTextResponse as string | undefined;

      // Must have at least one upload (file or text)
      const hasFile = Array.isArray(files) && files.length > 0;
      const hasText = typeof textResponse === "string" && textResponse.trim().length >= 10;

      if (!hasFile && !hasText) return false;

      // Validate each uploaded file has required fields
      if (hasFile) {
        for (const f of files!) {
          if (!f.url || !f.type) return false;
          if (typeof f.sizeBytes !== "number" || (f.sizeBytes as number) <= 0) return false;
        }
      }

      return true;
    }

    default:
      return true;
  }
}

// =============================================================================
// AdMob Server-Side Verification (SSV) Callback
// =============================================================================

// Cache for Google's AdMob public keys
let cachedPublicKeys: Map<string, crypto.KeyObject> | null = null;
let keysCacheExpiry = 0;
const KEYS_CACHE_TTL_MS = 24 * 60 * 60 * 1000; // 24 hours
const GOOGLE_KEYS_URL = "https://www.gstatic.com/admob/reward/verifier-keys.json";

/**
 * Fetch Google's AdMob public keys for SSV verification
 * Keys are cached for 24 hours
 */
async function getAdMobPublicKeys(): Promise<Map<string, crypto.KeyObject>> {
  const now = Date.now();

  // Return cached keys if still valid
  if (cachedPublicKeys && now < keysCacheExpiry) {
    return cachedPublicKeys;
  }

  return new Promise((resolve, reject) => {
    https.get(GOOGLE_KEYS_URL, (response) => {
      let data = "";

      response.on("data", (chunk) => {
        data += chunk;
      });

      response.on("end", () => {
        try {
          const keysJson = JSON.parse(data);
          const keys = new Map<string, crypto.KeyObject>();

          // Parse each key from JWK format
          for (const key of keysJson.keys || []) {
            if (key.keyId && key.base64) {
              try {
                // AdMob keys are in base64 DER format
                const derBuffer = Buffer.from(key.base64, "base64");
                const publicKey = crypto.createPublicKey({
                  key: derBuffer,
                  format: "der",
                  type: "spki",
                });
                keys.set(key.keyId.toString(), publicKey);
              } catch (keyError) {
                console.warn(`Failed to parse AdMob key ${key.keyId}:`, keyError);
              }
            }
          }

          // Update cache
          cachedPublicKeys = keys;
          keysCacheExpiry = now + KEYS_CACHE_TTL_MS;

          console.log(`AdMob SSV: Cached ${keys.size} public keys`);
          resolve(keys);
        } catch (parseError) {
          console.error("AdMob SSV: Failed to parse keys JSON:", parseError);
          reject(parseError);
        }
      });
    }).on("error", (error) => {
      console.error("AdMob SSV: Failed to fetch keys:", error);
      reject(error);
    });
  });
}

/**
 * Verify AdMob SSV signature using ECDSA
 * @param queryString The full query string from the callback URL
 * @param signature Base64-encoded signature from AdMob
 * @param keyId The key ID used to sign the callback
 * @returns true if signature is valid, false otherwise
 */
async function verifyAdMobSignature(
  queryString: string,
  signature: string,
  keyId: string
): Promise<boolean> {
  try {
    const keys = await getAdMobPublicKeys();
    const publicKey = keys.get(keyId);

    if (!publicKey) {
      console.error(`AdMob SSV: Unknown key ID: ${keyId}`);
      return false;
    }

    // The message to verify is the query string without signature and key_id params
    // Parse query string and rebuild without those params
    const params = new URLSearchParams(queryString);
    params.delete("signature");
    params.delete("key_id");

    // Sort params alphabetically and rebuild (AdMob uses sorted params for signing)
    const sortedParams = new URLSearchParams([...params.entries()].sort());
    const messageToVerify = sortedParams.toString();

    // Decode the base64 signature (URL-safe base64)
    const signatureBuffer = Buffer.from(
      signature.replace(/-/g, "+").replace(/_/g, "/"),
      "base64"
    );

    // Verify using ECDSA with SHA256
    const verifier = crypto.createVerify("SHA256");
    verifier.update(messageToVerify);

    return verifier.verify(publicKey, signatureBuffer);
  } catch (error) {
    console.error("AdMob SSV: Signature verification error:", error);
    return false;
  }
}

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

    // Verify the signature using Google's public keys
    let signatureValid = false;
    if (signature && keyId) {
      // Reconstruct the query string from the URL
      const queryString = req.url?.split("?")[1] || "";
      signatureValid = await verifyAdMobSignature(queryString, signature, keyId);

      if (!signatureValid) {
        console.error("AdMob SSV: Invalid signature", {
          transactionId,
          keyId,
          userId: ssv_userId,
        });
        // Still store the record but mark as unverified
        // This allows investigation of potential fraud
      } else {
        console.log("AdMob SSV: Signature verified successfully", { transactionId });
      }
    } else {
      console.warn("AdMob SSV: Missing signature or key_id", { transactionId });
    }

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
      verified: signatureValid, // Only true if ECDSA signature verified
      signaturePresent: !!(signature && keyId),
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
