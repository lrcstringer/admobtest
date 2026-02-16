/**
 * Upload Review Cloud Functions
 *
 * Admin functions for reviewing user-submitted upload engagements.
 * When an upload opportunity has requiresAdminReview=true, engagements
 * enter "pending_review" status. These functions allow admins to
 * approve (awarding tokens) or reject submissions.
 */

import * as functions from "firebase-functions";
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
export const adminReviewUpload = functions.https.onCall(
  async (data, context) => {
    const adminCtx = await requireAdminPermission(context, "review:reviewUpload", "adminReviewUpload");

    const { engagementId, action, reason } = data;

    if (!engagementId || !action) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "engagementId and action are required"
      );
    }

    if (!["approve", "reject"].includes(action)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "action must be 'approve' or 'reject'"
      );
    }

    // Get engagement
    const engagementRef = db.collection("engagements").doc(engagementId);
    const engagementDoc = await engagementRef.get();

    if (!engagementDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    if (engagement.status !== "pending_review") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Engagement is not pending review (current status: ${engagement.status})`
      );
    }

    const adminUid = context.auth!.uid;
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
          console.error("Failed to release reward reservation on rejection:", e)
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
      throw new functions.https.HttpsError(
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
      console.warn("Non-critical: stats update failed after upload approval", statsError);
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
export const getUploadReviewQueue = functions.https.onCall(
  async (data, context) => {
    await requireAdminPermission(context, "review:getQueue", "getUploadReviewQueue");

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

    const items = await Promise.all(
      snapshot.docs.map(async (doc) => {
        const engagement = doc.data();

        // Fetch user display info
        let userDisplayName: string | null = null;
        let userPhotoUrl: string | null = null;
        try {
          const userDoc = await db.collection("users").doc(engagement.userId).get();
          if (userDoc.exists) {
            const userData = userDoc.data()!;
            userDisplayName = userData.displayName || userData.username || null;
            userPhotoUrl = userData.photoUrl || null;
          }
        } catch {
          // Non-critical
        }

        // Fetch opportunity info
        let opportunityTitle: string | null = null;
        let uploadPrompt: string | null = null;
        try {
          if (engagement.earnOpportunityId) {
            const oppDoc = await db
              .collection("earnOpportunities")
              .doc(engagement.earnOpportunityId)
              .get();
            if (oppDoc.exists) {
              const oppData = oppDoc.data()!;
              opportunityTitle = oppData.title || null;
              uploadPrompt = oppData.uploadPrompt || null;
            }
          }
        } catch {
          // Non-critical
        }

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
      })
    );

    return {
      success: true,
      items,
      count: items.length,
    };
  }
);
