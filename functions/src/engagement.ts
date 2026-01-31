/**
 * Engagement Cloud Functions
 * Track and process user engagements with ads/surveys
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";

const db = admin.firestore();

/**
 * Start a new engagement (ad view or survey)
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
  const {campaignId, type, threadId} = data;

  // Validate
  if (!campaignId || !type) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields"
    );
  }

  // Get campaign
  const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

  if (!campaignDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Campaign not found");
  }

  const campaign = campaignDoc.data()!;

  // Check if campaign is active
  if (campaign.status !== "active") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Campaign is not active"
    );
  }

  // Check if user has already completed this campaign (if applicable)
  const existingEngagement = await db
    .collection("engagements")
    .where("oddienceUserId", "==", userId)
    .where("campaignId", "==", campaignId)
    .where("status", "==", "completed")
    .limit(1)
    .get();

  if (!existingEngagement.empty && campaign.maxEngagementsPerUser === 1) {
    throw new functions.https.HttpsError(
      "already-exists",
      "Already completed this campaign"
    );
  }

  // Create engagement record
  const engagementRef = db.collection("engagements").doc();
  await engagementRef.set({
    id: engagementRef.id,
    oddienceUserId: userId,
    campaignId: campaignId,
    threadId: threadId || null,
    type: type,
    status: "in_progress",
    progress: 0,
    rewardAmount: campaign.rewardPerEngagement,
    startedAt: admin.firestore.FieldValue.serverTimestamp(),
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    evidence: [],
  });

  // Update earn thread if provided
  if (threadId) {
    await db.collection("earnThreads").doc(threadId).update({
      status: "in_progress",
      engagementId: engagementRef.id,
      startedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  return {
    success: true,
    engagementId: engagementRef.id,
    rewardAmount: campaign.rewardPerEngagement,
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
    const {engagementId, evidence} = data;

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
    if (engagement.oddienceUserId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Not authorized"
      );
    }

    // Check status
    if (engagement.status === "completed") {
      throw new functions.https.HttpsError(
        "already-exists",
        "Engagement already completed"
      );
    }

    if (engagement.status === "failed") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Engagement has failed"
      );
    }

    // Validate evidence based on engagement type
    const isValid = validateEngagementEvidence(engagement.type, evidence);

    if (!isValid) {
      await engagementDoc.ref.update({
        status: "failed",
        failedAt: admin.firestore.FieldValue.serverTimestamp(),
        failureReason: "Invalid evidence",
      });
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Invalid engagement evidence"
      );
    }

    // Get user's wallet
    const walletQuery = await db
      .collection("wallets")
      .where("oddienceUserId", "==", userId)
      .limit(1)
      .get();

    if (walletQuery.empty) {
      throw new functions.https.HttpsError("not-found", "Wallet not found");
    }

    const walletDoc = walletQuery.docs[0];
    const rewardAmount = engagement.rewardAmount;

    // Process reward in transaction
    await db.runTransaction(async (transaction) => {
      // Update engagement
      transaction.update(engagementDoc.ref, {
        status: "completed",
        progress: 100,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        evidence: admin.firestore.FieldValue.arrayUnion(evidence),
      });

      // Credit wallet
      transaction.update(walletDoc.ref, {
        tokenBalance: admin.firestore.FieldValue.increment(rewardAmount),
        lifetimeEarned: admin.firestore.FieldValue.increment(rewardAmount),
        todayEarned: admin.firestore.FieldValue.increment(rewardAmount),
        lastEarnedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Create transaction record
      const txRef = db.collection("transactions").doc();
      transaction.set(txRef, {
        id: txRef.id,
        walletId: walletDoc.id,
        oddienceUserId: userId,
        type: "earn",
        subType: engagement.type,
        tokenAmount: rewardAmount,
        zarAmount: rewardAmount * 0.01,
        description: `Earned from ${engagement.type}`,
        status: "completed",
        referenceId: engagementId,
        referenceType: "engagement",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Update campaign stats
      const campaignRef = db.collection("campaigns").doc(engagement.campaignId);
      transaction.update(campaignRef, {
        totalEngagements: admin.firestore.FieldValue.increment(1),
        remainingBudgetTokens:
          admin.firestore.FieldValue.increment(-rewardAmount),
      });

      // Update pot entries
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const potEntryRef = db
        .collection("potEntries")
        .doc(`${userId}_${today.toISOString().split("T")[0]}`);
      transaction.set(
        potEntryRef,
        {
          oddienceUserId: userId,
          date: today.toISOString().split("T")[0],
          entries: admin.firestore.FieldValue.increment(rewardAmount),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        {merge: true}
      );

      // Update earn thread if present
      if (engagement.threadId) {
        const threadRef = db.collection("earnThreads").doc(engagement.threadId);
        transaction.update(threadRef, {
          status: "completed",
          progress: 100,
          completedAt: admin.firestore.FieldValue.serverTimestamp(),
          tokensEarned: rewardAmount,
        });
      }
    });

    return {success: true, tokensEarned: rewardAmount};
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
    const {engagementId, progress, stepData} = data;

    const engagementDoc = await db
      .collection("engagements")
      .doc(engagementId)
      .get();

    if (!engagementDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Engagement not found");
    }

    const engagement = engagementDoc.data()!;

    if (engagement.oddienceUserId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Not authorized"
      );
    }

    if (engagement.status !== "in_progress") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Engagement not in progress"
      );
    }

    await engagementDoc.ref.update({
      progress: progress,
      evidence: admin.firestore.FieldValue.arrayUnion(stepData),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update earn thread progress if present
    if (engagement.threadId) {
      await db.collection("earnThreads").doc(engagement.threadId).update({
        progress: progress,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    return {success: true, progress};
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
    if (!evidence.watchDuration || !evidence.videoId) {
      return false;
    }
    // Check minimum watch time (e.g., 80% of video)
    return (evidence.watchPercentage as number) >= 80;

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

  default:
    return true;
  }
}
