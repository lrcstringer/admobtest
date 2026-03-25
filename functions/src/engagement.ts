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

import { onCall, onRequest, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import * as crypto from "crypto";
import * as https from "https";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import { getSASTDayStart, getSASTWeekStart, SAST_OFFSET_MS } from "./pots";
import {
  processEarningWithSplit,
  LedgerConfig,
  AccountId,
  getOrCreateBrandSubAccount,
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
import {
  reserveRewardItem,
  confirmRewardReservation,
  releaseRewardReservation,
} from "./rewardAllocation";

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
  // In-flight processing sentinel — set atomically before the ledger call to
  // prevent concurrent processEngagement calls from both reaching the ledger
  // and causing a double-payment. Never visible to the Flutter client.
  REWARDING: "rewarding",
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
export const startEngagement = onCall({ timeoutSeconds: 60, memory: "256MiB", concurrency: 10, labels: { area: "earn" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  await requireAppCheck(request, "startEngagement");

  const userId = request.auth.uid;

  // Check daily completion limit (resets at midnight SAST)
  const today = getSASTDayStart();

  const { earnOpportunityId, campaignId, type, threadId } = request.data;

  // =========================================================================
  // Idempotency guard: return existing active engagement for this user +
  // opportunity so a network-retry never creates a second escrow reservation.
  // =========================================================================
  if (earnOpportunityId) {
    const existingSnapshot = await db
      .collection("engagements")
      .where("userId", "==", userId)
      .where("earnOpportunityId", "==", earnOpportunityId)
      .where("status", "in", [
        EngagementStatus.STARTED,
        EngagementStatus.WATCHING,
        EngagementStatus.SURVEYING,
        EngagementStatus.IN_PROGRESS,
        // M1 fix: include REWARDING so a client retry during processEngagement's
        // in-flight window doesn't bypass the guard and create a duplicate
        // engagement + escrow reservation.
        EngagementStatus.REWARDING,
      ])
      .limit(1)
      .get();

    if (!existingSnapshot.empty) {
      const existing = existingSnapshot.docs[0];
      const existingData = existing.data();
      // Convert Firestore Timestamps to ISO strings for the embedded object
      // (same serialization used on the happy path at engagement creation time).
      const startedAtIso =
        existingData.startedAt?.toDate?.()?.toISOString?.() ?? new Date().toISOString();
      const createdAtIso =
        existingData.createdAt?.toDate?.()?.toISOString?.() ?? startedAtIso;
      return {
        success: true,
        idempotent: true,
        engagementId: existing.id,
        rewardAmount: existingData.rewardAmount,
        escrowReserved: !!existingData.escrowJournalId,
        rewardReserved: !!existingData.reservedRewardItemId,
        reservedRewardCampaignName: existingData.reservedRewardCampaignName || null,
        reservedRewardType: existingData.reservedRewardType || null,
        // Embed full engagement data so the Flutter client can build the model
        // without a second Firestore read (same pattern as the happy path).
        engagement: {
          id: existing.id,
          userId: existingData.userId,
          earnOpportunityId: existingData.earnOpportunityId,
          audienceCampaignId: existingData.audienceCampaignId,
          threadId: existingData.threadId,
          clientId: existingData.clientId,
          status: existingData.status,
          watchDurationSeconds: existingData.watchDurationSeconds || 0,
          requiredDurationSeconds: existingData.requiredDurationSeconds || 0,
          answers: existingData.answers || [],
          attemptNumber: existingData.attemptNumber || 1,
          startedAt: startedAtIso,
          createdAt: createdAtIso,
        },
      };
    }
  }

  // =========================================================================
  // Phase 1: Parallel reads — daily cap + opportunity/campaign doc
  //
  // NOTE (soft-limit TOCTOU): The daily cap and per-opportunity daily limit
  // are checked via count queries that are not wrapped in a Firestore
  // transaction. Under high concurrency (this CF runs at concurrency=10),
  // two simultaneous startEngagement calls for the same user can both observe
  // count < cap and both proceed to create engagement documents, allowing a
  // user to slightly exceed the cap (by at most concurrent-instance-count−1).
  //
  // This is an intentional soft limit: the cap is an anti-abuse floor, not a
  // hard financial control. Correcting it would require an atomic per-user
  // daily-counter document (with a transaction on every start), which adds
  // significant latency for the common case. The current approach is correct
  // for the vast majority of usage patterns.
  // =========================================================================
  const dailyCapPromise = db
    .collection("engagements")
    .where("userId", "==", userId)
    .where("status", "==", EngagementStatus.COMPLETED)
    .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(today))
    .count()
    .get();

  const opportunityPromise = earnOpportunityId
    ? db.collection("earnOpportunities").doc(earnOpportunityId).get()
    : Promise.resolve(null);

  const campaignPromise = !earnOpportunityId && campaignId
    ? db.collection("campaigns").doc(campaignId).get()
    : Promise.resolve(null);

  const [todayCompletionsSnapshot, opportunityDoc, campaignDoc] =
    await Promise.all([dailyCapPromise, opportunityPromise, campaignPromise]);

  const dailyCompletions = todayCompletionsSnapshot.data().count;
  if (dailyCompletions >= DAILY_EARN_CAP) {
    throw new HttpsError(
      "resource-exhausted",
      "DAILY_LIMIT_REACHED"
    );
  }

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

  // Cache the opportunity data for reuse (avoids duplicate read later)
  let opportunityData: FirebaseFirestore.DocumentData | null = null;

  if (earnOpportunityId) {
    // New flow: opportunity doc already fetched above
    if (!opportunityDoc || !opportunityDoc.exists) {
      throw new HttpsError("not-found", "Opportunity not found");
    }

    const opportunity = opportunityDoc.data()!;
    opportunityData = opportunity;

    if (!opportunity.isActive) {
      throw new HttpsError(
        "failed-precondition",
        "Opportunity is not active"
      );
    }

    if (opportunity.isDeleted === true) {
      throw new HttpsError(
        "failed-precondition",
        "Opportunity is no longer available"
      );
    }

    // Check expiry
    if (opportunity.expiresAt && opportunity.expiresAt.toDate() < new Date()) {
      throw new HttpsError(
        "failed-precondition",
        "Opportunity has expired"
      );
    }

    rewardAmount = opportunity.tokenReward;
    if (!Number.isFinite(rewardAmount) || rewardAmount <= 0) {
      throw new HttpsError(
        "failed-precondition",
        `Opportunity ${earnOpportunityId} has invalid tokenReward: ${rewardAmount}`
      );
    }
    streakPoints = opportunity.streakPoints ?? 1; // Default to 1 if not set
    engagementType = opportunity.earningType || opportunity.mediaType || "video";
    resolvedCampaignId = opportunity.campaignId || null;
    resolvedThreadId = opportunity.threadId || threadId || null;
    resolvedRequiredDuration = opportunity.durationSeconds ?? 0;
    // Capture bonus multiplier for escrow reservation (max possible payout)
    if (opportunity.bonusReward && opportunity.bonusRewardMultiplier) {
      bonusRewardMultiplier = opportunity.bonusRewardMultiplier;
    }

    // Opportunity-level token source takes priority (Q1: granular budget control)
    if (opportunity.tokenSourceAccountId) {
      resolvedTokenSourceAccountId = opportunity.tokenSourceAccountId;
    }

    // =========================================================================
    // Phase 2: Parallel reads — per-opportunity daily limit + thread doc
    // =========================================================================
    const dailyLimitPerUser = opportunity.dailyLimitPerUser ?? null;

    const perOppLimitPromise = (dailyLimitPerUser !== null && dailyLimitPerUser > 0)
      ? db
          .collection("engagements")
          .where("userId", "==", userId)
          .where("earnOpportunityId", "==", earnOpportunityId)
          .where("status", "==", EngagementStatus.COMPLETED)
          .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(today))
          .count()
          .get()
      : Promise.resolve(null);

    const threadPromise = resolvedThreadId
      ? db.collection("earnThreads").doc(resolvedThreadId).get()
      : Promise.resolve(null);

    const [perOppSnapshot, threadDoc] = await Promise.all([perOppLimitPromise, threadPromise]);

    if (perOppSnapshot && dailyLimitPerUser !== null) {
      const todayOpportunityCompletions = perOppSnapshot.data().count;
      if (todayOpportunityCompletions >= dailyLimitPerUser) {
        throw new HttpsError(
          "resource-exhausted",
          "OPPORTUNITY_DAILY_LIMIT_REACHED"
        );
      }
    }

    if (threadDoc && threadDoc.exists) {
      const threadData = threadDoc.data()!;
      resolvedClientId = threadData.clientId || null;
      // Only use thread-level token source if opportunity didn't specify one
      resolvedTokenSourceAccountId ??= threadData.tokenSourceAccountId || null;
    }
  } else if (campaignId) {
    // Legacy flow: campaign doc already fetched in parallel above
    if (!type) {
      throw new HttpsError(
        "invalid-argument",
        "Missing required fields: type is required when using campaignId"
      );
    }

    if (!campaignDoc || !campaignDoc.exists) {
      throw new HttpsError("not-found", "Campaign not found");
    }

    const campaign = campaignDoc.data()!;

    if (campaign.status !== "active") {
      throw new HttpsError(
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
      throw new HttpsError(
        "already-exists",
        "Already completed this campaign"
      );
    }
  } else {
    throw new HttpsError(
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
    if (!Number.isFinite(escrowAmount) || escrowAmount <= 0) {
      throw new HttpsError(
        "failed-precondition",
        `Invalid escrow amount (${escrowAmount}) from rewardAmount=${rewardAmount}, multiplier=${bonusRewardMultiplier}`
      );
    }

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
      logger.error(
        `Escrow reservation failed for engagement ${engagementId}. ` +
        `Source: ${resolvedTokenSourceAccountId}, amount: ${escrowAmount}, ` +
        `error: ${escrowResult.error}, code: ${escrowResult.errorCode}`
      );
      throw new HttpsError(
        "failed-precondition",
        `Escrow failed: ${escrowResult.errorCode} — ${escrowResult.error}`
      );
    }

    escrowJournalId = escrowResult.journalId || null;
  }

  // =========================================================================
  // Reward Reservation: Atomically reserve reward item before creating engagement
  // Mirrors escrow reservation above — if reservation fails, engagement doesn't start
  // =========================================================================
  let reservedRewardItemId: string | null = null;
  let reservedRewardCampaignId: string | null = null;
  let reservedRewardCampaignName: string | null = null;
  let reservedRewardType: string | null = null;

  if (earnOpportunityId && opportunityData) {
    // Reuse opportunity data from Phase 1 (no duplicate read)
    if (opportunityData.rewardCampaignId) {
      try {
        const rewardResult = await reserveRewardItem(
          userId,
          opportunityData.rewardCampaignId,
          engagementId,
          opportunityData.rewardQuantity ?? 1
        );
        reservedRewardItemId = rewardResult.itemId;
        reservedRewardCampaignId = opportunityData.rewardCampaignId;
        reservedRewardCampaignName = rewardResult.campaignName;
        reservedRewardType = rewardResult.rewardType;
      } catch (rewardError: unknown) {
        // Log the specific reward reservation failure
        const rewardErrorMsg = rewardError instanceof Error ? rewardError.message : String(rewardError);
        logger.error(
          `Reward reservation failed for engagement ${engagementId}. ` +
          `campaignId: ${opportunityData.rewardCampaignId}, ` +
          `error: ${rewardErrorMsg}`
        );
        // If reward reservation fails, reverse escrow (if any) and throw
        if (escrowJournalId) {
          try {
            await reverseJournal(
              escrowJournalId,
              "Reward reservation failed — reversing token escrow",
              "system"
            );
          } catch (reverseErr) {
            logger.error(
              `Failed to reverse escrow after reward reservation failure`,
              { cause: reverseErr, engagementId, escrowJournalId }
            );
          }
        }
        throw rewardError;
      }
    }
  }

  // Create engagement record + update thread in parallel
  const writePromises: Promise<unknown>[] = [
    engagementRef.set({
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
      // Reward reservation fields (mirrors token escrow)
      reservedRewardItemId: reservedRewardItemId,
      reservedRewardCampaignId: reservedRewardCampaignId,
      reservedRewardCampaignName: reservedRewardCampaignName,
      reservedRewardType: reservedRewardType,
      // Denormalized opportunity fields — processEngagement reads these directly
      // so it never needs to re-fetch the opportunity doc.
      requiresAdminReview: opportunityData?.requiresAdminReview || false,
      bonusReward: opportunityData?.bonusReward || false,
      bonusIntervalType: opportunityData?.bonusIntervalType || null,
      bonusIntervalX: opportunityData?.bonusIntervalX || null,
      bonusRewardMultiplier: opportunityData?.bonusRewardMultiplier || null,
    }),
  ];

  if (resolvedThreadId) {
    writePromises.push(
      db.collection("earnThreads").doc(resolvedThreadId).update({
        lastActivityAt: now,
        updatedAt: now,
      }).catch((e) => {
        logger.info(`Could not update earnThread ${resolvedThreadId}:`, e);
      })
    );
  }

  await Promise.all(writePromises);

  // Include the full engagement data in the response so the Flutter client can
  // construct the model directly without an extra Firestore read.
  const nowIso = new Date().toISOString();
  return {
    success: true,
    engagementId: engagementId,
    rewardAmount: rewardAmount,
    escrowReserved: !!escrowJournalId,
    rewardReserved: !!reservedRewardItemId,
    reservedRewardCampaignName: reservedRewardCampaignName,
    reservedRewardType: reservedRewardType,
    engagement: {
      id: engagementId,
      userId: userId,
      earnOpportunityId: resolvedOpportunityId,
      audienceCampaignId: resolvedCampaignId,
      threadId: resolvedThreadId,
      clientId: resolvedClientId,
      status: EngagementStatus.STARTED,
      watchDurationSeconds: 0,
      requiredDurationSeconds: resolvedRequiredDuration,
      answers: [],
      attemptNumber: 1,
      startedAt: nowIso,
      createdAt: nowIso,
    },
  };
});

/**
 * Process engagement completion and reward user
 */
export const processEngagement = onCall(
  { timeoutSeconds: 120, memory: "512MiB", cpu: 1, minInstances: 0, concurrency: 10, labels: { area: "earn" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    await requireAppCheck(request, "processEngagement");
    await requirePlayIntegrity(request.data, request, "processEngagement", "HIGHEST");

    const userId = request.auth.uid;
    const { engagementId, evidence } = request.data;

    // Get engagement
    const engagementDoc = await db
      .collection("engagements")
      .doc(engagementId)
      .get();

    if (!engagementDoc.exists) {
      throw new HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    // Extract escrow metadata (null for legacy engagements without escrow)
    const hasEscrow = !!engagement.escrowJournalId;
    const engagementEscrowAmount: number | null = engagement.escrowAmount || null;
    const engagementTokenSourceAccountId: string | null = engagement.tokenSourceAccountId || null;

    // Validate ownership
    if (engagement.userId !== userId) {
      throw new HttpsError(
        "permission-denied",
        "Not authorized"
      );
    }

    // Check status - support both old and new status values
    const completedStatuses = [
      EngagementStatus.COMPLETED,
      EngagementStatus.REWARDED,
      // PENDING_REVIEW is a terminal submission state: the evidence has been
      // recorded and the engagement is awaiting admin action. Re-processing it
      // would overwrite the original evidence, so treat it as idempotent.
      EngagementStatus.PENDING_REVIEW,
    ];
    if (completedStatuses.includes(engagement.status)) {
      // Idempotent: engagement already completed or submitted for review (e.g.
      // client retrying after a network timeout). Return stored data so the
      // caller can display the confirm screen without double-awarding tokens.
      return {
        success: true,
        idempotent: true,
        engagementId,
        status: engagement.status,
        // H1 fix: use tokensEarned (user's 90% share, written by main txn).
        // rewardAmount is the gross pre-split total; tokenReward was never written.
        tokensEarned: engagement.tokensEarned ?? engagement.rewardAmount ?? 0,
        streakDay: engagement.streakDayAtCompletion ?? 0,
        multiplierApplied: engagement.multiplierApplied ?? 1,
        bonusApplied: engagement.bonusApplied ?? false,
        bonusMultiplier: engagement.bonusApplied ? (engagement.multiplierApplied ?? null) : null,
        rewardItemId: engagement.rewardItemId ?? null,
        // H2 fix: use reserved* prefixed fields — the plain names are never written.
        rewardCampaignName: engagement.reservedRewardCampaignName ?? null,
        rewardType: engagement.reservedRewardType ?? null,
      };
    }

    const failedStatuses = [
      EngagementStatus.FAILED,
      EngagementStatus.REJECTED,
      EngagementStatus.ABANDONED,
    ];
    if (failedStatuses.includes(engagement.status)) {
      throw new HttpsError(
        "failed-precondition",
        "Engagement has failed or was abandoned"
      );
    }

    // Validate evidence based on engagement type
    const isValid = validateEngagementEvidence(engagement.type, evidence);

    if (!isValid) {
      // Parallelize reward-reservation release and escrow reversal — both are
      // independent and can fail independently without blocking each other.
      await Promise.all([
        engagement.reservedRewardItemId
          ? releaseRewardReservation(engagement.reservedRewardItemId, engagementId)
              .catch((e: unknown) =>
                logger.error("Failed to release reward reservation on evidence failure:", e)
              )
          : Promise.resolve(),
        engagement.escrowJournalId
          ? reverseJournal(
              engagement.escrowJournalId,
              "Evidence validation failed",
              "system"
            ).catch((e: unknown) =>
              logger.error("Failed to reverse escrow on evidence failure:", e)
            )
          : Promise.resolve(),
      ]);
      await engagementDoc.ref.update({
        status: EngagementStatus.FAILED,
        failedAt: admin.firestore.FieldValue.serverTimestamp(),
        failureReason: "Invalid evidence",
      });
      throw new HttpsError(
        "invalid-argument",
        "Invalid engagement evidence"
      );
    }

    // =========================================================================
    // Admin Review Check — uses field denormalized onto the engagement doc
    // at startEngagement time, so no opportunity re-fetch is needed.
    // =========================================================================
    // Admin Review Check (Upload opportunities with requiresAdminReview)
    if (engagement.type === "upload" && engagement.requiresAdminReview) {
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

    // =========================================================================
    // RC1 Fix: Atomic claim — prevents concurrent processEngagement calls from
    // both reaching the ledger and producing a double-payment.
    //
    // Pattern: optimistic CAS on status field.
    //   • Only the call that atomically transitions status to REWARDING proceeds.
    //   • Any concurrent call arriving while processing is in-flight (REWARDING)
    //     receives an "aborted" error (client's submitting-phase guard prevents
    //     this in practice; direct CF callers are also safe).
    //   • If the engagement was completed in the window between the fast-path
    //     check above and this transaction, the idempotent data is returned here.
    //
    // Variable captures for the transaction (reset on every retry):
    let claimConflict = false;
    let claimIdempotentResponse: Record<string, unknown> | null = null;

    await db.runTransaction(async (claimTx) => {
      claimConflict = false;
      claimIdempotentResponse = null;

      const freshDoc = await claimTx.get(engagementDoc.ref);
      if (!freshDoc.exists) throw new HttpsError("not-found", "Engagement not found");

      const freshStatus = freshDoc.data()!.status as string;
      const fd = freshDoc.data()!;

      if ((completedStatuses as ReadonlyArray<string>).includes(freshStatus)) {
        // Completed in the window between the initial read and this transaction.
        // Build the idempotent response from the fresh doc.
        claimConflict = true;
        claimIdempotentResponse = {
          success: true,
          idempotent: true,
          engagementId,
          status: freshStatus,
          tokensEarned: fd.tokensEarned ?? fd.rewardAmount ?? 0,
          streakDay: fd.streakDayAtCompletion ?? 0,
          multiplierApplied: fd.multiplierApplied ?? 1,
          bonusApplied: fd.bonusApplied ?? false,
          bonusMultiplier: fd.bonusApplied ? (fd.multiplierApplied ?? null) : null,
          rewardItemId: fd.rewardItemId ?? null,
          rewardCampaignName: fd.reservedRewardCampaignName ?? null,
          rewardType: fd.reservedRewardType ?? null,
        };
        return; // don't write — just capture the response
      }

      if ((failedStatuses as ReadonlyArray<string>).includes(freshStatus)) {
        throw new HttpsError("failed-precondition", "Engagement has failed or was abandoned");
      }

      if (freshStatus === EngagementStatus.REWARDING) {
        // Another CF instance claimed this engagement and is processing it.
        // Normally reject — the client's submitting-phase guard prevents this.
        //
        // H1 fix: If the sentinel is stale (> 5 min old), the original CF
        // almost certainly crashed (timeout, OOM, cold-start abort) after
        // setting REWARDING but before completing the main write.  Without
        // recovery, the engagement stays stuck and the user can never earn
        // from it again.  Allow a re-claim so the caller can retry safely.
        const rewardingAt = fd.rewardingAt as FirebaseFirestore.Timestamp | null;
        const staleMs = rewardingAt ? Date.now() - rewardingAt.toMillis() : Infinity;
        const STALE_REWARDING_MS = 5 * 60 * 1000; // 5 minutes
        if (staleMs < STALE_REWARDING_MS) {
          throw new HttpsError(
            "aborted",
            "Engagement processing is already in progress — retry shortly"
          );
        }
        logger.warn(
          `processEngagement: stale REWARDING sentinel on ${engagementId} ` +
          `(${Math.round(staleMs / 1000)}s old). Previous CF likely crashed. Re-claiming.`,
          { engagementId }
        );
        // Fall through — claimTx.update below re-stamps the sentinel.
      }

      // Claim it: set status to REWARDING so no concurrent call can also proceed.
      claimTx.update(engagementDoc.ref, {
        status: EngagementStatus.REWARDING,
        rewardingAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    if (claimConflict && claimIdempotentResponse !== null) {
      return claimIdempotentResponse;
    }
    // =========================================================================

    let rewardAmount = engagement.rewardAmount;
    let bonusApplied = false;
    let bonusMultiplier = 1.0;

    // =========================================================================
    // Bonus Reward Logic — uses fields denormalized onto the engagement doc
    // at startEngagement time (bonusReward, bonusIntervalType, etc.)
    // Kick off thread fetch in parallel with bonus user-doc reads below.
    // =========================================================================
    const threadFetch: Promise<FirebaseFirestore.DocumentSnapshot | null> =
      engagement.threadId
        ? db.collection("earnThreads").doc(engagement.threadId).get()
        : Promise.resolve(null);

    if (engagement.earnOpportunityId && engagement.bonusReward) {
      try {
        const bonusIntervalType = engagement.bonusIntervalType;
        const bonusIntervalX = engagement.bonusIntervalX;
        bonusMultiplier = engagement.bonusRewardMultiplier || 1.0;

        if (bonusIntervalType === "every_x" && bonusIntervalX) {
          // ── "Every X Completions" Mode ──
          // Wrap in a transaction so concurrent completions for the same user
          // both read fresh counts and cannot both satisfy the X-interval check
          // at the same time, which would cause a double bonus payout.
          const userRef = db.collection("users").doc(userId);
          await db.runTransaction(async (tx) => {
            bonusApplied = false; // reset on each transaction retry
            const userDocTx = await tx.get(userRef);
            const userData = userDocTx.exists ? userDocTx.data()! : {};
            const opportunityCompletions = userData.opportunityCompletions || {};
            const currentCount = (opportunityCompletions[engagement.earnOpportunityId] || 0) + 1;
            if (shouldAwardEveryXBonus(currentCount, bonusIntervalX)) {
              bonusApplied = true;
            }
            tx.set(
              userRef,
              { opportunityCompletions: { [engagement.earnOpportunityId]: currentCount } },
              { merge: true }
            );
          });
          if (bonusApplied) {
            rewardAmount = Math.floor(rewardAmount * bonusMultiplier);
          }
        } else if (bonusIntervalType === "random") {
          // ── "Random" Mode (Adaptive Algorithm) ──
          // Wrap in a transaction so concurrent completions read the same
          // bonusEngineState and advance it exactly once, preventing two
          // independent decisions based on the same stale state.
          const userRef = db.collection("users").doc(userId);
          await db.runTransaction(async (tx) => {
            bonusApplied = false; // reset on each transaction retry
            const userDocTx = await tx.get(userRef);
            const userData = userDocTx.exists ? userDocTx.data()! : {};
            const currentBonusState = stateFromFirestore(userData.bonusEngineState, DEFAULT_BONUS_CONFIG);
            const decision = shouldAwardBonus(currentBonusState, DEFAULT_BONUS_CONFIG);
            if (decision.awarded) {
              bonusApplied = true;
            }
            tx.set(
              userRef,
              { bonusEngineState: stateToFirestore(decision.newState) },
              { merge: true }
            );
          });
          if (bonusApplied) {
            rewardAmount = Math.floor(rewardAmount * bonusMultiplier);
          }
        }
      } catch (bonusError) {
        logger.error("Failed to process bonus reward", { cause: bonusError, engagementId });
        // Continue without bonus - don't fail the engagement
      }
    }

    // Get campaignId - support multiple field names
    const campaignId = engagement.campaignId || engagement.audienceCampaignId;

    // Calculate token split — floor pot shares to avoid fractional tokens.
    const dailyPotShare = Math.floor(rewardAmount * LedgerConfig.EARNING_DAILY_POT_SHARE);
    const weeklyPotShare = Math.floor(rewardAmount * LedgerConfig.EARNING_WEEKLY_POT_SHARE);
    const userShare = rewardAmount - dailyPotShare - weeklyPotShare;

    // ===========================================================================
    // Client-funded token flow: fetch thread and validate budget
    // tokenSourceAccountId is already resolved at startEngagement time and
    // denormalized onto the engagement doc — no opportunity re-fetch needed.
    // ===========================================================================
    let clientId: string | null = engagement.clientId || null;
    let tokenSourceAccountId: string | null = engagementTokenSourceAccountId;
    let tokenDestAccountTypeId: string | null = null;
    let clientName: string | null = null;

    if (engagement.threadId) {
      const threadDoc = await threadFetch;

      if (threadDoc?.exists) {
        const threadData = threadDoc.data()!;

        if (threadData.isDeleted === true) {
          throw new HttpsError(
            "failed-precondition",
            "Campaign is no longer available"
          );
        }

        clientId = threadData.clientId || null;
        // Only use thread-level token source if opportunity didn't specify one
        tokenSourceAccountId ??= threadData.tokenSourceAccountId || null;
        tokenDestAccountTypeId = threadData.tokenDestAccountTypeId || null;
        clientName = threadData.clientName || null;

        // Budget pre-check: only needed for legacy engagements without escrow.
        // Escrow engagements already have tokens reserved and guaranteed.
        if (tokenSourceAccountId && !hasEscrow) {
          const sourceBalance = await getBalance(tokenSourceAccountId);
          if (sourceBalance < rewardAmount) {
            throw new HttpsError(
              "failed-precondition",
              "Insufficient budget for this offer"
            );
          }
        }
      }
    }

    // ===========================================================================
    // Determine user sub-account (brand-restricted only; otherwise main wallet)
    // ===========================================================================
    let subAccountId: string | undefined;

    if (tokenDestAccountTypeId && clientName) {
      // Thread specifies a restricted wallet type — use canonical sub-account function
      // (writes to ledgerAccounts/user:{uid}/subAccounts/, not users/{uid}/subAccounts/)
      const brandResult = await getOrCreateBrandSubAccount(
        userId,
        tokenDestAccountTypeId,
        `${clientName} Wallet`
      );
      subAccountId = brandResult.subAccountId;
    }
    // else: no sub-account — tokens go to main wallet (ledger account balance)

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
        throw new HttpsError(
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
      throw new HttpsError(
        "internal",
        `Failed to process earning: ${ledgerResult.error}`
      );
    }

    // =========================================================================
    // Confirm reward reservation — best-effort, does NOT block engagement completion.
    // #3 fix: If confirmation fails, engagement still completes with tokens.
    // The reserved item will be released by releaseStaleRewardReservations (30-min job).
    // =========================================================================
    let confirmedRewardItemId: string | null = null;
    if (engagement.reservedRewardItemId) {
      try {
        confirmedRewardItemId = await confirmRewardReservation(
          engagement.reservedRewardItemId,
          userId,
          engagementId
        );
      } catch (rewardConfirmError) {
        logger.error(
          `Failed to confirm reward reservation for engagement ${engagementId}. ` +
            `Tokens credited but reward not allocated. ` +
            `Stale reservation cleanup will release item ${engagement.reservedRewardItemId}.`,
          { error: rewardConfirmError, engagementId, userId }
        );
        // Continue — engagement completes with tokens, reward reservation released by scheduled job
      }
    }

    // Update engagement and related records in transaction (CRITICAL — must complete)
    await db.runTransaction(async (transaction) => {
      // Defense-in-depth: re-read status inside the transaction to ensure our
      // REWARDING claim was not lost (e.g., CF cold-start mid-flight).
      // Firestore only applies optimistic-concurrency protection to documents
      // that are READ inside the transaction — this read makes the update safe.
      const claimedDoc = await transaction.get(engagementDoc.ref);
      const claimedStatus = claimedDoc.data()?.status;
      if (claimedStatus !== EngagementStatus.REWARDING) {
        logger.warn(
          `processEngagement: expected status 'rewarding', found '${claimedStatus}'. ` +
          `Aborting main transaction to prevent double-write.`,
          { engagementId }
        );
        throw new HttpsError(
          "aborted",
          "Engagement claim was lost — retry"
        );
      }

      // Update engagement with Flutter-compatible fields
      transaction.update(engagementDoc.ref, {
        status: EngagementStatus.COMPLETED,
        progress: 100,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        tokensEarned: userShare, // User's 90% share
        totalTokensGenerated: rewardAmount, // Total including pot contributions
        ledgerJournalId: ledgerResult.journalId, // Link to ledger entry
        evidence: admin.firestore.FieldValue.arrayUnion(evidence),
        // Reward allocation (confirmed from reservation)
        rewardItemId: confirmedRewardItemId || null,
        // Bonus reward tracking
        bonusApplied: bonusApplied,
        bonusMultiplier: bonusApplied ? bonusMultiplier : null,
        // Sub-account used for token destination — written here (inside the
        // transaction) so it is always persisted; doStreakAudit is fire-and-
        // forget and its failure would otherwise leave this field unset.
        subAccountId: subAccountId || null,
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
        // Atomic first-completion detection: a marker document acts as a
        // distributed lock. If it already exists, this user has completed this
        // thread before and we skip the increment. The transaction guarantees
        // exactly-once semantics even under concurrent completions.
        const markerRef = db
          .collection("earnThreadCompletions")
          .doc(`${userId}_${engagement.threadId}`);
        await db.runTransaction(async (tx) => {
          const markerDoc = await tx.get(markerRef);
          if (!markerDoc.exists) {
            tx.set(markerRef, {
              userId,
              threadId: engagement.threadId,
              firstCompletedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
            tx.update(
              db.collection("earnThreads").doc(engagement.threadId!),
              { completedUniqueUsers: admin.firestore.FieldValue.increment(1) }
            );
          }
        });
      }
    };

    // Helper: opportunity budget tracking
    // Uses a transaction so budgetExhausted is set exactly once even under
    // concurrent completions — reads tokenSpent, increments atomically, and
    // sets the flag only when the committed new total crosses the threshold.
    const doOpportunityBudgetTracking = async () => {
      if (!engagement.earnOpportunityId) return;
      const oppRef = db.collection("earnOpportunities").doc(engagement.earnOpportunityId);

      let notifyPayload: Record<string, unknown> | null = null;

      await db.runTransaction(async (tx) => {
        notifyPayload = null; // reset on each retry
        const oppDoc = await tx.get(oppRef);
        if (!oppDoc.exists) return;
        const oppData = oppDoc.data()!;
        const tokenBudget = oppData.tokenBudget;
        if (tokenBudget == null || tokenBudget <= 0) return;
        // Idempotent: already exhausted — nothing to do
        if (oppData.budgetExhausted === true) return;

        const newSpent = (oppData.tokenSpent || 0) + rewardAmount;
        const updates: Record<string, unknown> = {
          tokenSpent: admin.firestore.FieldValue.increment(rewardAmount),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        };
        if (newSpent >= tokenBudget) {
          updates.budgetExhausted = true;
          notifyPayload = {
            type: "opportunity_budget_depleted",
            opportunityId: engagement.earnOpportunityId,
            threadId: engagement.threadId,
            clientId: clientId,
            tokenBudget,
            tokenSpent: newSpent,
            message: `Opportunity "${oppData.title}" budget exhausted (${newSpent}/${tokenBudget} tokens)`,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            read: false,
          };
        }
        tx.update(oppRef, updates);
      });

      // Fire notification outside the transaction — non-critical side-effect
      if (notifyPayload !== null) {
        await db.collection("adminNotifications").add(notifyPayload);
      }
    };

    // Run all parallel batch 1 operations concurrently
    const [streakInfo] = await Promise.all([
      updateEngagementStats(userId, userShare, engagementStreakPoints)
        .catch((e) => { logger.error("Streak stats error:", e); return defaultStreak; }),
      doBudgetMonitoring()
        .catch((e) => logger.error("Budget monitoring error:", e)),
      doTargetingTracking()
        .catch((e) => logger.error("Targeting tracking error:", e)),
      doOpportunityBudgetTracking()
        .catch((e) => logger.error("Opportunity budget tracking error:", e)),
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
      // subAccountId is now written in the main transaction above.
      await engagementDoc.ref.update({
        streakDayAtCompletion: streakInfo.currentStreak,
        multiplierApplied: streakInfo.multiplier,
      });
    };

    // Fire-and-forget: leaderboard + streak audit are non-critical for the
    // user response. Skipping the await saves ~1s (7 sequential daily score reads).
    Promise.all([
      doLeaderboardUpdates().catch((e) => logger.error("Leaderboard error:", e)),
      doStreakAudit().catch((e) => logger.error("Streak audit error:", e)),
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
      rewardItemId: confirmedRewardItemId || null,
      rewardCampaignName: engagement.reservedRewardCampaignName || null,
      rewardType: engagement.reservedRewardType || null,
    };
  }
);

/**
 * Update engagement progress (for multi-step engagements like surveys)
 */
export const updateEngagementProgress = onCall(
  { concurrency: 80, labels: { area: "earn" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    await requireAppCheck(request, "updateEngagementProgress");

    const userId = request.auth.uid;
    const { engagementId, progress, stepData, watchDurationSeconds, status } =
      request.data;

    const engagementDoc = await db
      .collection("engagements")
      .doc(engagementId)
      .get();

    if (!engagementDoc.exists) {
      throw new HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    if (engagement.userId !== userId) {
      throw new HttpsError(
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
      throw new HttpsError(
        "failed-precondition",
        "Engagement not in progress"
      );
    }

    // Build update object
    const updateData: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    if (progress !== undefined) {
      updateData.progress = Math.max(0, Math.min(100, Number(progress) || 0));
    }

    if (watchDurationSeconds !== undefined) {
      // Server-side validation: clamp to monotonically increasing and cap at
      // max elapsed time since engagement start (+ 10 s buffer for clock skew).
      // The client already enforces both constraints, but the CF is reachable
      // directly so we apply them here as a defence-in-depth measure.
      const prevDuration = (engagement.watchDurationSeconds as number) || 0;
      const startedAt = engagement.startedAt as FirebaseFirestore.Timestamp | null;
      const startMs = startedAt?.toMillis?.() ?? Date.now();
      const maxElapsedSeconds = Math.ceil((Date.now() - startMs) / 1000) + 10;
      const clamped = Math.max(
        prevDuration,
        Math.min(watchDurationSeconds as number, maxElapsedSeconds)
      );
      updateData.watchDurationSeconds = clamped;
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
export const abandonEngagement = onCall(
  { concurrency: 10, labels: { area: "earn" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    await requireAppCheck(request, "abandonEngagement");

    const userId = request.auth.uid;
    const { engagementId } = request.data;

    const engagementDoc = await db
      .collection("engagements")
      .doc(engagementId)
      .get();

    if (!engagementDoc.exists) {
      throw new HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    if (engagement.userId !== userId) {
      throw new HttpsError(
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
      throw new HttpsError(
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
        logger.info(
          `Escrow reversed for engagement ${engagementId}: ` +
          `journalId=${escrowReversalJournalId}`
        );
      } catch (error) {
        // Still abandon the engagement even if reversal fails;
        // the cleanup function will retry later
        logger.error(
          `Failed to reverse escrow for engagement ${engagementId}:`,
          error
        );
        escrowReversalFailed = true;
      }
    }

    // Release reward reservation if one exists
    if (engagement.reservedRewardItemId) {
      try {
        await releaseRewardReservation(
          engagement.reservedRewardItemId,
          engagementId
        );
        logger.info(
          `Reward reservation released for engagement ${engagementId}: ` +
            `itemId=${engagement.reservedRewardItemId}`
        );
      } catch (rewardReleaseError) {
        // Still abandon — stale reservation cleanup will handle it
        logger.error(
          `Failed to release reward reservation for engagement ${engagementId}:`,
          rewardReleaseError
        );
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
      // Poll vote is already validated by submitPollVote CF.
      // Evidence just needs survey responses (the client records the vote as a response)
      // or explicit poll fields for backwards compatibility.
      if (evidence.pollId && evidence.selectedOption) {
        return true;
      }
      if (evidence.selectedOption !== undefined) {
        return true;
      }
      // Accept survey-style responses (poll vote recorded as survey response by client)
      if (evidence.responses && Array.isArray(evidence.responses) &&
          (evidence.responses as unknown[]).length > 0) {
        return true;
      }
      // Accept new question type evidence: ranking, text, scale
      if (evidence.rankedOptions && Array.isArray(evidence.rankedOptions)) {
        return true;
      }
      if (evidence.textResponse && typeof evidence.textResponse === "string") {
        return true;
      }
      if (evidence.scaleRatings && typeof evidence.scaleRatings === "object") {
        return true;
      }
      // Poll vote was submitted separately — accept if engagement exists
      return true;

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
                logger.warn(`Failed to parse AdMob key ${key.keyId}:`, keyError);
              }
            }
          }

          // Update cache
          cachedPublicKeys = keys;
          keysCacheExpiry = now + KEYS_CACHE_TTL_MS;

          logger.info(`AdMob SSV: Cached ${keys.size} public keys`);
          resolve(keys);
        } catch (parseError) {
          logger.error("AdMob SSV: Failed to parse keys JSON:", parseError);
          reject(parseError);
        }
      });
    }).on("error", (error) => {
      logger.error("AdMob SSV: Failed to fetch keys:", error);
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
      logger.error(`AdMob SSV: Unknown key ID: ${keyId}`);
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
      signature.replaceAll("-", "+").replaceAll("_", "/"),
      "base64"
    );

    // Verify using ECDSA with SHA256
    const verifier = crypto.createVerify("SHA256");
    verifier.update(messageToVerify);

    return verifier.verify(publicKey, signatureBuffer);
  } catch (error) {
    logger.error("AdMob SSV: Signature verification error:", error);
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
export const admobSSVCallback = onRequest({ timeoutSeconds: 10, cors: false, concurrency: 200, invoker: "public", labels: { area: "earn" } }, async (req, res) => {
  try {
    // Log the callback for debugging
    logger.info("AdMob SSV Callback received:", {
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
      logger.error("AdMob SSV: Missing required parameters");
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
      logger.warn("AdMob SSV: User ID mismatch", { ssv_userId, userId });
    }

    // Verify the signature using Google's public keys
    let signatureValid = false;
    if (signature && keyId) {
      // Reconstruct the query string from the URL
      const queryString = req.url?.split("?")[1] || "";
      signatureValid = await verifyAdMobSignature(queryString, signature, keyId);

      if (!signatureValid) {
        logger.error("AdMob SSV: Invalid signature", {
          transactionId,
          keyId,
          userId: ssv_userId,
        });
        // Still store the record but mark as unverified
        // This allows investigation of potential fraud
      } else {
        logger.info("AdMob SSV: Signature verified successfully", { transactionId });
      }
    } else {
      logger.warn("AdMob SSV: Missing signature or key_id", { transactionId });
    }

    // Store the SSV verification record
    const ssvRef = db.collection("admobSSVCallbacks").doc(transactionId as string);
    const existingDoc = await ssvRef.get();

    if (existingDoc.exists) {
      // Duplicate callback - this is normal for retries
      logger.info("AdMob SSV: Duplicate callback for transaction", transactionId);
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

    logger.info("AdMob SSV: Verification stored successfully", {
      transactionId,
      userId: ssv_userId,
      adUnit,
      rewardAmount,
    });

    // Respond with success
    // AdMob expects a 200 response to confirm the callback was received
    res.status(200).send("OK");
  } catch (error) {
    logger.error("AdMob SSV: Error processing callback", error);
    // Return 200 anyway to prevent AdMob from retrying indefinitely
    // We log the error for investigation
    res.status(200).send("OK - Error logged");
  }
});

/**
 * Verify an AdMob SSV transaction
 * Called by the client to check if a transaction was verified via SSV
 */
export const verifyAdMobTransaction = onCall({ concurrency: 80, labels: { area: "earn" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const { transactionId } = request.data;

  if (!transactionId) {
    throw new HttpsError(
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
  if (ssvData?.userId !== request.auth.uid) {
    logger.warn("AdMob SSV verification: User ID mismatch", {
      expected: request.auth.uid,
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
