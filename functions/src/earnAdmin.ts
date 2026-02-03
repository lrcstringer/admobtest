/**
 * Admin functions for managing earn threads and opportunities
 *
 * These functions are used to populate and manage the earn-related collections:
 * - earnThreads: Brand groupings for earn opportunities
 * - earnOpportunities: Individual video/survey tasks
 *
 * These should be called from admin panel or via Firebase console
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Create or update an earn thread (brand)
 * Admin-only function
 */
export const createEarnThread = functions.https.onCall(async (data, context) => {
  // Verify admin
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Must be authenticated"
    );
  }

  // Check for admin claim
  const token = context.auth.token;
  if (!token.admin) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Must be an admin"
    );
  }

  const {
    brandId,
    brandName,
    avatarColor,
    avatarImage,
    isPinned = false,
    isActive = true,
  } = data;

  if (!brandId || !brandName) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "brandId and brandName are required"
    );
  }

  const threadRef = db.collection("earnThreads").doc(brandId);
  const now = admin.firestore.FieldValue.serverTimestamp();

  const existingThread = await threadRef.get();

  if (existingThread.exists) {
    // Update existing thread
    await threadRef.update({
      brandName,
      avatarColor: avatarColor || null,
      avatarImage: avatarImage || null,
      isPinned,
      isActive,
      updatedAt: now,
    });
  } else {
    // Create new thread
    await threadRef.set({
      id: brandId,
      brandId,
      brandName,
      avatarColor: avatarColor || null,
      avatarImage: avatarImage || null,
      isPinned,
      isActive,
      availableOpportunities: 0,
      completedOpportunities: 0,
      createdAt: now,
      lastActivityAt: now,
    });
  }

  return { success: true, threadId: brandId };
});

/**
 * Create or update an earn opportunity
 * Admin-only function
 */
export const createEarnOpportunity = functions.https.onCall(
  async (data, context) => {
    // Verify admin
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const token = context.auth.token;
    if (!token.admin) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Must be an admin"
      );
    }

    const {
      id,
      threadId,
      title,
      description,
      tokenReward,
      mediaType = "video",
      mediaUrl,
      questions = [],
      durationSeconds,
      expiresAt,
      isActive = true,
      brandName,
      brandAvatarColor,
      campaignId,
    } = data;

    if (!threadId || !title || !tokenReward || !mediaUrl || !durationSeconds) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "threadId, title, tokenReward, mediaUrl, and durationSeconds are required"
      );
    }

    // Verify thread exists
    const threadDoc = await db.collection("earnThreads").doc(threadId).get();
    if (!threadDoc.exists) {
      throw new functions.https.HttpsError(
        "not-found",
        "Thread not found. Create the thread first."
      );
    }

    const opportunityRef = id
      ? db.collection("earnOpportunities").doc(id)
      : db.collection("earnOpportunities").doc();

    const now = admin.firestore.FieldValue.serverTimestamp();
    const opportunityId = opportunityRef.id;

    const existingOpportunity = await opportunityRef.get();
    const wasActive = existingOpportunity.exists
      ? existingOpportunity.data()?.isActive
      : false;

    const opportunityData = {
      id: opportunityId,
      threadId,
      title,
      description: description || null,
      tokenReward,
      mediaType,
      mediaUrl,
      questions,
      durationSeconds,
      expiresAt: expiresAt
        ? admin.firestore.Timestamp.fromDate(new Date(expiresAt))
        : null,
      isActive,
      brandName: brandName || threadDoc.data()?.brandName,
      brandAvatarColor: brandAvatarColor || threadDoc.data()?.avatarColor,
      campaignId: campaignId || null,
      updatedAt: now,
    };

    if (existingOpportunity.exists) {
      await opportunityRef.update(opportunityData);
    } else {
      await opportunityRef.set({
        ...opportunityData,
        createdAt: now,
      });
    }

    // Update thread's available opportunities count
    if (isActive !== wasActive) {
      const increment = isActive ? 1 : -1;
      await db
        .collection("earnThreads")
        .doc(threadId)
        .update({
          availableOpportunities: admin.firestore.FieldValue.increment(
            increment
          ),
          lastActivityAt: now,
        });
    }

    return { success: true, opportunityId };
  }
);

/**
 * Sync campaigns to earnOpportunities
 * Converts campaigns collection entries to earnOpportunities format
 * Admin-only function
 */
export const syncCampaignsToOpportunities = functions.https.onCall(
  async (data, context) => {
    // Verify admin
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const token = context.auth.token;
    if (!token.admin) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Must be an admin"
      );
    }

    const { defaultThreadId } = data;

    if (!defaultThreadId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "defaultThreadId is required"
      );
    }

    // Get all active campaigns
    const campaignsSnapshot = await db
      .collection("campaigns")
      .where("status", "==", "active")
      .get();

    if (campaignsSnapshot.empty) {
      return { success: true, synced: 0 };
    }

    const batch = db.batch();
    const now = admin.firestore.FieldValue.serverTimestamp();
    let syncedCount = 0;

    for (const campaignDoc of campaignsSnapshot.docs) {
      const campaign = campaignDoc.data();

      // Check if opportunity already exists for this campaign
      const existingOpportunity = await db
        .collection("earnOpportunities")
        .where("campaignId", "==", campaignDoc.id)
        .limit(1)
        .get();

      if (existingOpportunity.empty) {
        const opportunityRef = db.collection("earnOpportunities").doc();

        batch.set(opportunityRef, {
          id: opportunityRef.id,
          threadId: defaultThreadId,
          title: campaign.title || campaign.name || "Earn Opportunity",
          description: campaign.description || null,
          tokenReward: campaign.rewardPerEngagement || 10,
          mediaType: campaign.type || "video",
          mediaUrl: campaign.mediaUrl || campaign.videoUrl || "",
          questions: campaign.questions || [],
          durationSeconds: campaign.videoDuration || 30,
          expiresAt: campaign.endDate || null,
          isActive: true,
          brandName: campaign.brandName || null,
          brandAvatarColor: null,
          campaignId: campaignDoc.id,
          createdAt: now,
          updatedAt: now,
        });

        syncedCount++;
      }
    }

    if (syncedCount > 0) {
      await batch.commit();

      // Update thread's available opportunities count
      await db
        .collection("earnThreads")
        .doc(defaultThreadId)
        .update({
          availableOpportunities:
            admin.firestore.FieldValue.increment(syncedCount),
          lastActivityAt: now,
        });
    }

    return { success: true, synced: syncedCount };
  }
);

/**
 * Deactivate expired opportunities
 * Run daily to clean up expired opportunities
 */
export const deactivateExpiredOpportunities = functions.pubsub
  .schedule("0 1 * * *") // 1 AM daily
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();

    const expiredOpportunities = await db
      .collection("earnOpportunities")
      .where("isActive", "==", true)
      .where("expiresAt", "<=", now)
      .get();

    if (expiredOpportunities.empty) {
      console.log("No expired opportunities to deactivate");
      return null;
    }

    const batch = db.batch();
    const threadUpdates: Map<string, number> = new Map();

    for (const doc of expiredOpportunities.docs) {
      const data = doc.data();
      batch.update(doc.ref, {
        isActive: false,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Track thread updates
      const threadId = data.threadId;
      threadUpdates.set(threadId, (threadUpdates.get(threadId) || 0) + 1);
    }

    await batch.commit();

    // Update thread counts
    for (const [threadId, count] of threadUpdates) {
      await db
        .collection("earnThreads")
        .doc(threadId)
        .update({
          availableOpportunities: admin.firestore.FieldValue.increment(-count),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
    }

    console.log(
      `Deactivated ${expiredOpportunities.size} expired opportunities`
    );
    return null;
  });

/**
 * Get earn statistics
 * Returns counts and stats for admin dashboard
 */
export const getEarnStatistics = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }
    requireAppCheck(context, "getEarnStatistics");

    // Get total threads
    const threadsCount = await db
      .collection("earnThreads")
      .where("isActive", "==", true)
      .count()
      .get();

    // Get total active opportunities
    const opportunitiesCount = await db
      .collection("earnOpportunities")
      .where("isActive", "==", true)
      .count()
      .get();

    // Get today's engagements
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const todayStart = admin.firestore.Timestamp.fromDate(today);

    const todayEngagements = await db
      .collection("engagements")
      .where("createdAt", ">=", todayStart)
      .count()
      .get();

    const completedToday = await db
      .collection("engagements")
      .where("completedAt", ">=", todayStart)
      .where("status", "==", "completed")
      .count()
      .get();

    return {
      activeThreads: threadsCount.data().count,
      activeOpportunities: opportunitiesCount.data().count,
      engagementsToday: todayEngagements.data().count,
      completedToday: completedToday.data().count,
    };
  }
);
