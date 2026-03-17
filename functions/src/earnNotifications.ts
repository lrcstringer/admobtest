/**
 * Earn Notifications
 *
 * In-app notifications for the earn inbox:
 * - new_client: first active thread for a client
 * - new_thread: new earn thread goes live
 * - new_opportunity: new opportunity added to a thread
 * - expiry_warning: thread/opportunity expiring within 24h
 *
 * Notifications are stored in Firestore `earnNotifications` collection,
 * support read/unread, and auto-expire after 30 days.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import { TargetingCriteria } from "./constants/targeting";
import {
  UserTargetingProfile,
  isUserEligibleForTargeting,
  checkBrandInteraction,
} from "./targetingUtils";
import { calculateAge } from "./constants/targeting";

const db = admin.firestore();

// ============================================================================
// TYPES
// ============================================================================

type EarnNotificationType =
  | "new_client"
  | "new_thread"
  | "new_opportunity"
  | "expiry_warning";

interface NotificationPayload {
  type: EarnNotificationType;
  title: string;
  body: string;
  data: {
    clientId: string;
    clientName: string;
    threadId?: string;
    opportunityId?: string;
  };
}

// ============================================================================
// HELPERS
// ============================================================================

/**
 * Create earn notification docs for a list of user IDs and optionally send FCM.
 */
async function createEarnNotifications(
  payload: NotificationPayload,
  targetUserIds: string[]
): Promise<number> {
  if (targetUserIds.length === 0) return 0;

  const now = admin.firestore.Timestamp.now();
  const expiresAt = admin.firestore.Timestamp.fromDate(
    new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) // 30 days
  );

  // Batch-write notification docs (max 500 per batch)
  let written = 0;
  for (let i = 0; i < targetUserIds.length; i += 500) {
    const batch = db.batch();
    const userBatch = targetUserIds.slice(i, i + 500);

    for (const userId of userBatch) {
      const ref = db.collection("earnNotifications").doc();
      batch.set(ref, {
        id: ref.id,
        userId,
        type: payload.type,
        title: payload.title,
        body: payload.body,
        data: payload.data,
        read: false,
        createdAt: now,
        expiresAt,
      });
    }

    await batch.commit();
    written += userBatch.length;
  }

  // Send FCM push notifications (best-effort, don't fail on errors)
  try {
    await sendFcmToUsers(targetUserIds, payload);
  } catch (err) {
    logger.warn("FCM send failed (non-fatal)", { error: err });
  }

  return written;
}

/**
 * Send FCM push to users who have fcmToken.
 * Reads tokens from user docs and sends in batches of 500.
 */
async function sendFcmToUsers(
  userIds: string[],
  payload: NotificationPayload
): Promise<void> {
  // Batch-read user docs to get FCM tokens (max 30 per getAll)
  const tokens: string[] = [];

  for (let i = 0; i < userIds.length; i += 30) {
    const batch = userIds.slice(i, i + 30);
    const refs = batch.map((uid) => db.collection("users").doc(uid));
    const docs = await db.getAll(...refs);

    for (const doc of docs) {
      const token = doc.data()?.fcmToken;
      if (token && typeof token === "string") {
        tokens.push(token);
      }
    }
  }

  if (tokens.length === 0) return;

  // Send in batches of 500 (FCM multicast limit)
  for (let i = 0; i < tokens.length; i += 500) {
    const batch = tokens.slice(i, i + 500);
    try {
      await admin.messaging().sendEachForMulticast({
        tokens: batch,
        notification: {
          title: payload.title,
          body: payload.body,
        },
        data: {
          type: `earn_${payload.type}`,
          clientId: payload.data.clientId,
          ...(payload.data.threadId ? { threadId: payload.data.threadId } : {}),
          ...(payload.data.opportunityId
            ? { opportunityId: payload.data.opportunityId }
            : {}),
        },
      });
    } catch (err) {
      logger.warn("FCM batch send error", {
        batchStart: i,
        error: err,
      });
    }
  }
}

/**
 * Get all user IDs eligible for a targeting criteria.
 * If no targeting, returns all active user IDs.
 */
async function getEligibleUserIds(
  targeting: TargetingCriteria | null | undefined,
  clientId?: string,
  completedUniqueUsers?: number
): Promise<string[]> {
  const usersSnapshot = await db
    .collection("users")
    .where("isActive", "!=", false)
    .select(
      "profile",
      "gender",
      "dateOfBirth",
      "province",
      "city",
      "languages",
      "interests",
      "createdAt",
      "interactedClientIds",
      "fcmToken"
    )
    .get();

  if (!targeting) {
    return usersSnapshot.docs.map((doc) => doc.id);
  }

  const eligibleIds: string[] = [];

  for (const doc of usersSnapshot.docs) {
    const userData = doc.data();
    const userProfile = userData.profile || {};

    const gender = userProfile.gender || userData.gender || null;
    const dob =
      userProfile.dateOfBirth?.toDate?.() ||
      userData.dateOfBirth?.toDate?.() ||
      null;
    const age = dob ? calculateAge(dob) : null;
    const province = userProfile.province || userData.province || null;
    const city = userProfile.city || userData.city || null;
    const languages: string[] =
      userProfile.languages || userData.languages || [];
    const interests: string[] =
      userProfile.interests || userData.interests || [];
    const interactedClientIds: string[] =
      userData.interactedClientIds || [];
    const createdAt = userData.createdAt?.toDate?.() || new Date();
    const accountAgeDays = Math.floor(
      (Date.now() - createdAt.getTime()) / (1000 * 60 * 60 * 24)
    );

    const profile: UserTargetingProfile = {
      gender,
      age,
      province,
      city,
      languages,
      interests,
      devicePlatform: null, // Not available in batch context
      accountAgeDays,
      engagementLevel: "active", // Simplified for notifications
      interactedClientIds,
    };

    if (
      isUserEligibleForTargeting(profile, targeting, completedUniqueUsers) &&
      (!clientId ||
        checkBrandInteraction(targeting, interactedClientIds, clientId))
    ) {
      eligibleIds.push(doc.id);
    }
  }

  return eligibleIds;
}

// ============================================================================
// NOTIFICATION TRIGGER HELPERS (called from earnAdmin.ts)
// ============================================================================

/**
 * Notify users about a new earn thread.
 * Also checks if this is the first active thread for the client (new_client).
 */
export async function notifyNewThread(
  threadId: string,
  threadTitle: string,
  clientId: string,
  clientName: string,
  targeting: TargetingCriteria | null | undefined
): Promise<void> {
  // Check if this is the client's first active thread
  const existingThreads = await db
    .collection("earnThreads")
    .where("clientId", "==", clientId)
    .where("isActive", "==", true)
    .where("isDeleted", "!=", true)
    .limit(2)
    .get();

  // If only 1 active thread (the one just created), send new_client notification too
  const isFirstThread = existingThreads.size <= 1;

  const eligibleUserIds = await getEligibleUserIds(targeting, clientId);

  if (isFirstThread) {
    await createEarnNotifications(
      {
        type: "new_client",
        title: `New brand: ${clientName}`,
        body: `${clientName} has earn opportunities for you!`,
        data: { clientId, clientName },
      },
      eligibleUserIds
    );
  }

  await createEarnNotifications(
    {
      type: "new_thread",
      title: `New campaign from ${clientName}`,
      body: `${threadTitle} \u2014 tap to see earning opportunities`,
      data: { clientId, clientName, threadId },
    },
    eligibleUserIds
  );
}

/**
 * Notify users about a new earn opportunity.
 */
export async function notifyNewOpportunity(
  opportunityId: string,
  threadId: string,
  threadTitle: string,
  clientId: string,
  clientName: string,
  tokenReward: number,
  earningType: string,
  targeting: TargetingCriteria | null | undefined
): Promise<void> {
  const earningLabel =
    earningType === "adVideo"
      ? "Watch & Earn"
      : earningType.charAt(0).toUpperCase() + earningType.slice(1);

  const eligibleUserIds = await getEligibleUserIds(targeting, clientId);

  await createEarnNotifications(
    {
      type: "new_opportunity",
      title: `New opportunity in ${threadTitle}`,
      body: `Earn ${tokenReward} tokens \u2014 ${earningLabel}`,
      data: { clientId, clientName, threadId, opportunityId },
    },
    eligibleUserIds
  );
}

// ============================================================================
// CALLABLE: Get user's earn notifications
// ============================================================================

export const getEarnNotifications = onCall({ labels: { area: "earn" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Must be authenticated"
    );
  }
  await requireAppCheck(request as any, "getEarnNotifications");

  const userId = request.auth.uid;
  const now = admin.firestore.Timestamp.now();

  const snapshot = await db
    .collection("earnNotifications")
    .where("userId", "==", userId)
    .where("expiresAt", ">", now)
    .orderBy("expiresAt")
    .orderBy("createdAt", "desc")
    .limit(20)
    .get();

  const notifications = snapshot.docs.map((doc) => {
    const d = doc.data();
    return {
      id: d.id || doc.id,
      type: d.type,
      title: d.title,
      body: d.body,
      data: d.data || {},
      read: d.read === true,
      createdAt: d.createdAt,
    };
  });

  // Count unread
  const unreadSnapshot = await db
    .collection("earnNotifications")
    .where("userId", "==", userId)
    .where("read", "==", false)
    .where("expiresAt", ">", now)
    .count()
    .get();

  return {
    success: true,
    notifications,
    unreadCount: unreadSnapshot.data().count,
  };
});

// ============================================================================
// CALLABLE: Mark notification(s) as read
// ============================================================================

export const markEarnNotificationRead = onCall({ labels: { area: "earn" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Must be authenticated"
    );
  }
  await requireAppCheck(request as any, "markEarnNotificationRead");

  const userId = request.auth.uid;
  const data = request.data as { notificationId?: string; markAllRead?: boolean };

  if (data.markAllRead) {
    // Mark all unread notifications as read
    const unreadSnapshot = await db
      .collection("earnNotifications")
      .where("userId", "==", userId)
      .where("read", "==", false)
      .get();

    if (unreadSnapshot.empty) {
      return { success: true, updated: 0 };
    }

    const batch = db.batch();
    for (const doc of unreadSnapshot.docs) {
      batch.update(doc.ref, { read: true });
    }
    await batch.commit();

    return { success: true, updated: unreadSnapshot.size };
  }

  if (data.notificationId) {
    const ref = db
      .collection("earnNotifications")
      .doc(data.notificationId);
    const doc = await ref.get();

    if (!doc.exists || doc.data()?.userId !== userId) {
      throw new HttpsError(
        "not-found",
        "Notification not found"
      );
    }

    await ref.update({ read: true });
    return { success: true, updated: 1 };
  }

  throw new HttpsError(
    "invalid-argument",
    "Provide notificationId or markAllRead"
  );
});

// ============================================================================
// SCHEDULED: Check for expiring threads/opportunities (hourly)
// ============================================================================

export const checkExpiryNotifications = onSchedule({ schedule: "every 1 hours", region: "europe-west1", labels: { area: "earn" } }, async () => {
  const now = new Date();
  const in25Hours = new Date(now.getTime() + 25 * 60 * 60 * 1000);
  const oneDayAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000);

  const nowTs = admin.firestore.Timestamp.fromDate(now);
  const in25HoursTs = admin.firestore.Timestamp.fromDate(in25Hours);
  const oneDayAgoTs = admin.firestore.Timestamp.fromDate(oneDayAgo);

  // ---- Threads expiring within ~24h ----
  const expiringThreads = await db
    .collection("earnThreads")
    .where("isActive", "==", true)
    .where("activeTo", ">=", nowTs)
    .where("activeTo", "<=", in25HoursTs)
    .get();

  for (const threadDoc of expiringThreads.docs) {
    const thread = threadDoc.data();
    if (thread.isDeleted === true) continue;

    // Check if we already sent an expiry notification for this thread recently
    const existing = await db
      .collection("earnNotifications")
      .where("type", "==", "expiry_warning")
      .where("data.threadId", "==", threadDoc.id)
      .where("createdAt", ">=", oneDayAgoTs)
      .limit(1)
      .get();

    if (!existing.empty) continue; // Already notified

    const targeting: TargetingCriteria | null = thread.targeting || null;
    const eligibleUserIds = await getEligibleUserIds(
      targeting,
      thread.clientId,
      thread.completedUniqueUsers || 0
    );

    await createEarnNotifications(
      {
        type: "expiry_warning",
        title: `Expiring soon: ${thread.title}`,
        body: "This campaign expires in 24 hours \u2014 don\u2019t miss out!",
        data: {
          clientId: thread.clientId,
          clientName: thread.clientName || "Unknown",
          threadId: threadDoc.id,
        },
      },
      eligibleUserIds
    );
  }

  // ---- Opportunities expiring within ~24h ----
  const expiringOpps = await db
    .collection("earnOpportunities")
    .where("isActive", "==", true)
    .where("expiresAt", ">=", nowTs)
    .where("expiresAt", "<=", in25HoursTs)
    .get();

  // Batch-fetch unique thread docs for expiring opportunities
  const uniqueThreadIds = new Set<string>();
  for (const oppDoc of expiringOpps.docs) {
    const opp = oppDoc.data();
    if (opp.isDeleted !== true && opp.threadId) {
      uniqueThreadIds.add(opp.threadId);
    }
  }

  const threadDataMap = new Map<string, admin.firestore.DocumentData | undefined>();
  if (uniqueThreadIds.size > 0) {
    const threadRefs = Array.from(uniqueThreadIds).map((id) =>
      db.collection("earnThreads").doc(id)
    );
    const threadDocs = await db.getAll(...threadRefs);
    for (const tDoc of threadDocs) {
      threadDataMap.set(tDoc.id, tDoc.exists ? tDoc.data() : undefined);
    }
  }

  for (const oppDoc of expiringOpps.docs) {
    const opp = oppDoc.data();
    if (opp.isDeleted === true) continue;

    const existing = await db
      .collection("earnNotifications")
      .where("type", "==", "expiry_warning")
      .where("data.opportunityId", "==", oppDoc.id)
      .where("createdAt", ">=", oneDayAgoTs)
      .limit(1)
      .get();

    if (!existing.empty) continue;

    // Get thread info from batch-fetched map
    const thread = threadDataMap.get(opp.threadId);

    const targeting: TargetingCriteria | null = opp.targeting || null;
    const eligibleUserIds = await getEligibleUserIds(
      targeting,
      opp.clientId || thread?.clientId
    );

    await createEarnNotifications(
      {
        type: "expiry_warning",
        title: `Expiring soon: ${opp.title || thread?.title || "Opportunity"}`,
        body: "This opportunity expires in 24 hours \u2014 don\u2019t miss out!",
        data: {
          clientId: opp.clientId || thread?.clientId || "",
          clientName: opp.clientName || thread?.clientName || "Unknown",
          threadId: opp.threadId,
          opportunityId: oppDoc.id,
        },
      },
      eligibleUserIds
    );
  }

  logger.info("Expiry notification check complete", {
    threads: expiringThreads.size,
    opportunities: expiringOpps.size,
  });
});

// ============================================================================
// SCHEDULED: Cleanup expired notifications (daily)
// ============================================================================

export const cleanupExpiredEarnNotifications = onSchedule({ schedule: "every 24 hours", region: "europe-west1", labels: { area: "earn" } }, async () => {
  const now = admin.firestore.Timestamp.now();

  const expired = await db
    .collection("earnNotifications")
    .where("expiresAt", "<", now)
    .limit(500) // Process in chunks to avoid timeout
    .get();

  if (expired.empty) {
    logger.info("No expired earn notifications to clean up");
    return;
  }

  const batch = db.batch();
  for (const doc of expired.docs) {
    batch.delete(doc.ref);
  }
  await batch.commit();

  logger.info(`Cleaned up ${expired.size} expired earn notifications`);
});
