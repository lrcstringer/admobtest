/**
 * Upload Review Cloud Functions
 *
 * Admin functions for reviewing user-submitted upload engagements.
 * When an upload opportunity has requiresAdminReview=true, engagements
 * enter "pending_review" status. These functions allow admins to
 * approve (awarding tokens) or reject submissions.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import { requireAdminPermission, logAdminAction } from "./adminAuth";
import * as admin from "firebase-admin";
import {
  processEarningWithSplit,
  processEscrowCompletion,
  reverseJournal,
  getOrCreateBrandSubAccount,
  AccountId,
  LedgerConfig,
} from "./ledger";
import { releaseRewardReservation } from "./rewardAllocation";
import { updateEngagementStats } from "./engagementStats";
import { updateDailyScore, updateReferrerAssistScore, updateLeaderboardScores } from "./dailyScores";

const db = admin.firestore();


/**
 * Admin reviews an upload engagement — approve or reject.
 *
 * approve: Runs the normal reward flow (ledger split, stats, scores).
 * reject: Marks engagement as rejected with reason.
 */
export const adminReviewUpload = onCall(
  { labels: { area: "moderation" } },
  async (request) => {
    const data = request.data;
    const adminCtx = await requireAdminPermission(request, "review:reviewUpload", "adminReviewUpload");

    const { engagementId, action, reason } = data;

    if (!engagementId || !action) {
      throw new HttpsError(
        "invalid-argument",
        "engagementId and action are required"
      );
    }

    if (!["approve", "reject"].includes(action)) {
      throw new HttpsError(
        "invalid-argument",
        "action must be 'approve' or 'reject'"
      );
    }

    // Get engagement
    const engagementRef = db.collection("engagements").doc(engagementId);
    const engagementDoc = await engagementRef.get();

    if (!engagementDoc.exists) {
      throw new HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    if (engagement.status !== "pending_review") {
      throw new HttpsError(
        "failed-precondition",
        `Engagement is not pending review (current status: ${engagement.status})`
      );
    }

    const adminUid = request.auth!.uid;
    const now = admin.firestore.FieldValue.serverTimestamp();

    // ── REJECT ──
    if (action === "reject") {
      // Reverse escrow if tokens were reserved
      if (engagement.escrowJournalId) {
        await reverseJournal(
          engagement.escrowJournalId,
          `Upload rejected by admin: ${reason || "No reason provided"}`,
          adminUid
        );
      }

      // Release reward item reservation if one exists
      if (engagement.reservedRewardItemId) {
        await releaseRewardReservation(
          engagement.reservedRewardItemId,
          engagementId
        ).catch((e: unknown) =>
          logger.error("Failed to release reward reservation on rejection:", e)
        );
      }

      await engagementRef.update({
        status: "rejected",
        rejectedAt: now,
        rejectedBy: adminUid,
        rejectionReason: reason || "No reason provided",
        updatedAt: now,
      });

      logAdminAction(adminCtx.uid, "adminReviewUpload", "success", { engagementId, action: "rejected", reason: reason || "No reason provided" }).catch(() => {});

      return {
        success: true,
        action: "rejected",
        message: "Upload engagement rejected",
      };
    }

    // ── APPROVE ──
    const userId = engagement.userId;
    const rewardAmount = engagement.rewardAmount;

    // Look up thread for client/ledger info
    let clientId: string | null = null;
    let clientSubAccountId: string | null = null;
    let tokenDestAccountTypeId: string | null = null;

    if (engagement.threadId) {
      const threadDoc = await db
        .collection("earnThreads")
        .doc(engagement.threadId)
        .get();

      if (threadDoc.exists) {
        const threadData = threadDoc.data()!;
        clientId = threadData.clientId || null;
        clientSubAccountId = threadData.tokenSourceAccountId || null;
        tokenDestAccountTypeId = threadData.tokenDestAccountTypeId || null;
      }
    }

    // Determine user sub-account (brand-restricted only; otherwise main wallet)
    // Uses canonical ledgerAccounts/user:{uid}/subAccounts/ path (same as engagement.ts)
    let subAccountId: string | undefined;
    if (tokenDestAccountTypeId) {
      // Thread specifies a restricted wallet type — use canonical sub-account function
      const clientDisplayName = engagement.clientName || "Brand";
      const brandResult = await getOrCreateBrandSubAccount(
        userId,
        tokenDestAccountTypeId,
        `${clientDisplayName} Wallet`
      );
      subAccountId = brandResult.subAccountId;
    }
    // else: no restricted type — tokens go to main wallet (ledger account balance)

    // Process reward through Trust Ledger (90/5/5 split)
    // tokenSourceAccountId is the ledger account to debit (client main or sub-account)
    const tokenSourceAccountId = clientSubAccountId
      || (clientId ? AccountId.client(clientId) : AccountId.client("imalichat"));

    // Calculate split for stats (must use userShare, not full rewardAmount)
    const dailyPotShare = Math.floor(rewardAmount * LedgerConfig.EARNING_DAILY_POT_SHARE);
    const weeklyPotShare = Math.floor(rewardAmount * LedgerConfig.EARNING_WEEKLY_POT_SHARE);
    const userShare = rewardAmount - dailyPotShare - weeklyPotShare;

    let ledgerResult;

    if (engagement.escrowJournalId) {
      // ESCROW PATH: Release tokens from escrow
      const escrowAmount = engagement.escrowAmount || rewardAmount;
      ledgerResult = await processEscrowCompletion(
        userId,
        rewardAmount,
        escrowAmount,
        engagementId,
        tokenSourceAccountId,
        subAccountId,
        tokenDestAccountTypeId,
        {
          engagementType: engagement.type,
          earnOpportunityId: engagement.earnOpportunityId,
          threadId: engagement.threadId,
          clientId: clientId,
          reviewedBy: adminUid,
        },
      );
    } else {
      // NON-ESCROW PATH: Direct earning split
      ledgerResult = await processEarningWithSplit(
        userId,
        rewardAmount,
        engagementId,
        `Earned from upload (admin approved)`,
        tokenSourceAccountId,
        subAccountId,
        tokenDestAccountTypeId,
        {
          engagementType: engagement.type,
          earnOpportunityId: engagement.earnOpportunityId,
          threadId: engagement.threadId,
          clientId: clientId,
          reviewedBy: adminUid,
        },
      );
    }

    if (!ledgerResult.success) {
      throw new HttpsError(
        "internal",
        `Failed to process earning: ${ledgerResult.error}`
      );
    }

    // Update engagement to completed — record userShare (90%), not full rewardAmount
    await engagementRef.update({
      status: "completed",
      completedAt: now,
      tokensEarned: userShare,
      reviewedBy: adminUid,
      reviewedAt: now,
      updatedAt: now,
    });

    // Update stats (mirrors processEngagement flow) — use userShare, not rewardAmount
    try {
      // Update engagement stats (streak tracking)
      const streakInfo = await updateEngagementStats(userId, userShare, 1);

      // Get user profile for leaderboard display
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();
      const userProfile = {
        displayName:
          userData?.profile?.displayName || userData?.displayName || "User",
        username: userData?.profile?.username || userData?.username || null,
        avatarUrl: userData?.profile?.avatarUrl || userData?.avatarUrl || null,
      };

      // Update daily score
      const updatedDailyScore = await updateDailyScore(
        userId,
        userShare,
        streakInfo.currentStreak,
        streakInfo.multiplier,
        userProfile
      );

      // Update leaderboard scores
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
    } catch (statsError) {
      logger.warn("Non-critical: stats update failed after upload approval", statsError);
    }

    logAdminAction(adminCtx.uid, "adminReviewUpload", "success", { engagementId, action: "approved", userId, tokensAwarded: userShare }).catch(() => {});

    return {
      success: true,
      action: "approved",
      tokensAwarded: userShare,
      message: `Upload approved — ${userShare} tokens awarded (${rewardAmount} total with pot split)`,
    };
  }
);

/**
 * Get the queue of upload engagements pending admin review.
 */
export const getUploadReviewQueue = onCall(
  { labels: { area: "moderation" } },
  async (request) => {
    const data = request.data;
    await requireAdminPermission(request, "review:getQueue", "getUploadReviewQueue");

    const { threadId, limit: queryLimit = 50 } = data || {};

    let query = db
      .collection("engagements")
      .where("status", "==", "pending_review")
      .orderBy("createdAt", "desc")
      .limit(Math.min(queryLimit, 100));

    if (threadId) {
      query = db
        .collection("engagements")
        .where("status", "==", "pending_review")
        .where("threadId", "==", threadId)
        .orderBy("createdAt", "desc")
        .limit(Math.min(queryLimit, 100));
    }

    const snapshot = await query.get();

    // Batch-fetch unique users and opportunities to avoid N+1 queries
    const uniqueUserIds = new Set<string>();
    const uniqueOppIds = new Set<string>();

    for (const doc of snapshot.docs) {
      const engagement = doc.data();
      if (engagement.userId) uniqueUserIds.add(engagement.userId);
      if (engagement.earnOpportunityId) uniqueOppIds.add(engagement.earnOpportunityId);
    }

    // Batch-fetch all user docs
    const userMap = new Map<string, FirebaseFirestore.DocumentData>();
    if (uniqueUserIds.size > 0) {
      try {
        const userRefs = Array.from(uniqueUserIds).map((uid) =>
          db.collection("users").doc(uid)
        );
        const userDocs = await db.getAll(...userRefs);
        for (const userDoc of userDocs) {
          if (userDoc.exists) {
            userMap.set(userDoc.id, userDoc.data()!);
          }
        }
      } catch {
        // Non-critical
      }
    }

    // Batch-fetch all opportunity docs
    const oppMap = new Map<string, FirebaseFirestore.DocumentData>();
    if (uniqueOppIds.size > 0) {
      try {
        const oppRefs = Array.from(uniqueOppIds).map((oppId) =>
          db.collection("earnOpportunities").doc(oppId)
        );
        const oppDocs = await db.getAll(...oppRefs);
        for (const oppDoc of oppDocs) {
          if (oppDoc.exists) {
            oppMap.set(oppDoc.id, oppDoc.data()!);
          }
        }
      } catch {
        // Non-critical
      }
    }

    const items = snapshot.docs.map((doc) => {
      const engagement = doc.data();

      // Look up user from pre-fetched map
      const userData = userMap.get(engagement.userId);
      const userDisplayName = userData
        ? (userData.displayName || userData.username || null)
        : null;
      const userPhotoUrl = userData?.photoUrl || null;

      // Look up opportunity from pre-fetched map
      const oppData = engagement.earnOpportunityId
        ? oppMap.get(engagement.earnOpportunityId)
        : undefined;
      const opportunityTitle = oppData?.title || null;
      const uploadPrompt = oppData?.uploadPrompt || null;

      return {
        engagementId: doc.id,
        userId: engagement.userId,
        userDisplayName,
        userPhotoUrl,
        threadId: engagement.threadId,
        earnOpportunityId: engagement.earnOpportunityId,
        opportunityTitle,
        uploadPrompt,
        evidence: engagement.evidence || {},
        rewardAmount: engagement.rewardAmount,
        submittedAt: engagement.submittedAt,
        createdAt: engagement.createdAt,
      };
    });

    return {
      success: true,
      items,
      count: items.length,
    };
  }
);
