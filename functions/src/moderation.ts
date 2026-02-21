/**
 * Moderation Cloud Functions
 *
 * Block/unblock users, submit reports, delete messages.
 *
 * Collections:
 *   users/{userId}               — blockedUserIds array
 *   reports/{reportId}           — abuse reports
 *   conversations/...            — message deletion
 *   communities/...              — message deletion
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

function requireAuth(context: { auth?: { uid: string; token: Record<string, unknown> } }): string {
  if (!context.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Authentication required."
    );
  }
  return context.auth.uid;
}

// ============================================================================
// BLOCK / UNBLOCK
// ============================================================================

/**
 * Block a user — adds them to the caller's blockedUserIds array.
 */
export const blockUser = onCall(
  { labels: { area: "moderation" } },
  async (request) => {
    const data = request.data as { targetUserId: string };
    const userId = requireAuth(request);
    requireAppCheck(request, "blockUser");

    const { targetUserId } = data;
    if (!targetUserId || typeof targetUserId !== "string") {
      throw new HttpsError(
        "invalid-argument",
        "targetUserId is required."
      );
    }
    if (targetUserId === userId) {
      throw new HttpsError(
        "invalid-argument",
        "You cannot block yourself."
      );
    }

    // Add to blocked list
    await db.collection("users").doc(userId).update({
      "chat.blockedUserIds": admin.firestore.FieldValue.arrayUnion(targetUserId),
    });

    return { success: true };
  }
);

/**
 * Unblock a user — removes them from the caller's blockedUserIds array.
 */
export const unblockUser = onCall(
  { labels: { area: "moderation" } },
  async (request) => {
    const data = request.data as { targetUserId: string };
    const userId = requireAuth(request);
    requireAppCheck(request, "unblockUser");

    const { targetUserId } = data;
    if (!targetUserId || typeof targetUserId !== "string") {
      throw new HttpsError(
        "invalid-argument",
        "targetUserId is required."
      );
    }

    await db.collection("users").doc(userId).update({
      "chat.blockedUserIds": admin.firestore.FieldValue.arrayRemove(targetUserId),
    });

    return { success: true };
  }
);

/**
 * Get the current user's list of blocked user IDs.
 */
export const getBlockedUsers = onCall({ labels: { area: "moderation" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "getBlockedUsers");

  const userDoc = await db.collection("users").doc(userId).get();
  const userData = userDoc.data();
  const blockedUserIds: string[] =
    userData?.chat?.blockedUserIds ?? [];

  return { blockedUserIds };
});

// ============================================================================
// REPORTS
// ============================================================================

/**
 * Submit an abuse report against a user, message, or community.
 */
export const submitReport = onCall(
  { labels: { area: "moderation" } },
  async (request) => {
    const data = request.data as {
      type: string;
      targetId: string;
      reason: string;
      additionalInfo?: string;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "submitReport");

    const { type, targetId, reason, additionalInfo } = data;

    // Validate type
    const validTypes = ["message", "user", "community"];
    if (!validTypes.includes(type)) {
      throw new HttpsError(
        "invalid-argument",
        `Invalid report type. Must be one of: ${validTypes.join(", ")}`
      );
    }

    // Validate reason
    const validReasons = [
      "spam",
      "harassment",
      "inappropriate_content",
      "scam",
      "other",
    ];
    if (!validReasons.includes(reason)) {
      throw new HttpsError(
        "invalid-argument",
        `Invalid reason. Must be one of: ${validReasons.join(", ")}`
      );
    }

    if (!targetId || typeof targetId !== "string") {
      throw new HttpsError(
        "invalid-argument",
        "targetId is required."
      );
    }

    const reportRef = db.collection("reports").doc();
    await reportRef.set({
      id: reportRef.id,
      type,
      targetId,
      reporterId: userId,
      reason,
      additionalInfo: additionalInfo || null,
      status: "pending",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true, reportId: reportRef.id };
  }
);

// ============================================================================
// MESSAGE DELETION
// ============================================================================

/**
 * Delete a message for the current user only (adds userId to deletedFor[]).
 */
export const deleteMessageForMe = onCall(
  { labels: { area: "moderation" } },
  async (request) => {
    const data = request.data as {
      parentCollection: string;
      parentId: string;
      messageId: string;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "deleteMessageForMe");

    const { parentCollection, parentId, messageId } = data;

    if (!["conversations", "communities"].includes(parentCollection)) {
      throw new HttpsError(
        "invalid-argument",
        "parentCollection must be 'conversations' or 'communities'."
      );
    }

    const msgRef = db
      .collection(parentCollection)
      .doc(parentId)
      .collection("messages")
      .doc(messageId);

    const msgDoc = await msgRef.get();
    if (!msgDoc.exists) {
      throw new HttpsError("not-found", "Message not found.");
    }

    await msgRef.update({
      deletedFor: admin.firestore.FieldValue.arrayUnion(userId),
    });

    return { success: true };
  }
);

/**
 * Delete a message for everyone — only the sender can do this, within 1 hour.
 * Community admins can also delete any message in their community.
 */
export const deleteMessageForEveryone = onCall(
  { labels: { area: "moderation" } },
  async (request) => {
    const data = request.data as {
      parentCollection: string;
      parentId: string;
      messageId: string;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "deleteMessageForEveryone");

    const { parentCollection, parentId, messageId } = data;

    if (!["conversations", "communities"].includes(parentCollection)) {
      throw new HttpsError(
        "invalid-argument",
        "parentCollection must be 'conversations' or 'communities'."
      );
    }

    const msgRef = db
      .collection(parentCollection)
      .doc(parentId)
      .collection("messages")
      .doc(messageId);

    const msgDoc = await msgRef.get();
    if (!msgDoc.exists) {
      throw new HttpsError("not-found", "Message not found.");
    }

    const msgData = msgDoc.data()!;
    const isSender = msgData.senderId === userId;

    // Check if community admin
    let isAdmin = false;
    if (parentCollection === "communities") {
      const communityDoc = await db
        .collection("communities")
        .doc(parentId)
        .get();
      const communityData = communityDoc.data();
      if (communityData) {
        isAdmin =
          communityData.adminIds?.includes(userId) ||
          communityData.ownerId === userId;
      }
    }

    if (!isSender && !isAdmin) {
      throw new HttpsError(
        "permission-denied",
        "Only the sender or a community admin can delete messages for everyone."
      );
    }

    // Sender: enforce 1-hour time limit (admins bypass this)
    if (isSender && !isAdmin) {
      const createdAt = msgData.createdAt?.toDate?.() || new Date(0);
      const oneHourAgo = new Date(Date.now() - 60 * 60 * 1000);
      if (createdAt < oneHourAgo) {
        throw new HttpsError(
          "failed-precondition",
          "Messages can only be deleted for everyone within 1 hour of sending."
        );
      }
    }

    await msgRef.update({
      deletedForEveryone: true,
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      textContent: null,
      media: null,
    });

    return { success: true };
  }
);
