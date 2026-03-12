/**
 * Gooi-Gooi Notification Triggers
 *
 * Firestore triggers that send FCM push notifications for Gooi-Gooi events:
 * - Invitation received
 * - Group activated
 * - Cycle opened (contribution due)
 * - Payout received
 * - Payout triggered
 * - Member joined/left
 * - Late contribution flagged
 * - Delegation granted/revoked
 *
 * All notifications use deduplication guards to prevent duplicate sends.
 */

import { onDocumentUpdated, onDocumentCreated } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";

const db = admin.firestore();
const GOOI_NOTIF_LABELS = { area: "gooi-gooi-notifications" };

/** Get a user's FCM token. */
async function getFcmToken(userId: string): Promise<string | null> {
  const doc = await db.collection("users").doc(userId).get();
  return doc.data()?.fcmToken || null;
}

/** Send an FCM notification to a user (with error handling). */
async function sendGooiNotification(
  userId: string,
  title: string,
  body: string,
  data: Record<string, string>
): Promise<boolean> {
  const token = await getFcmToken(userId);
  if (!token) return false;

  try {
    await admin.messaging().send({
      token,
      notification: { title, body },
      data: { ...data, type: "gooi_gooi" },
      android: { notification: { channelId: "gooi_gooi" } },
    });
    return true;
  } catch (err) {
    logger.warn(`Failed to send Gooi-Gooi notification to ${userId}:`, err);
    return false;
  }
}

/** Deduplication: claim a notification key on a document. */
async function claimNotificationKey(
  docRef: FirebaseFirestore.DocumentReference,
  key: string
): Promise<boolean> {
  try {
    return await db.runTransaction(async (txn) => {
      const snap = await txn.get(docRef);
      if (!snap.exists) return false;
      const sentMap = (snap.data()?.notificationsSent as Record<string, boolean>) || {};
      if (sentMap[key]) return false;
      txn.update(docRef, { [`notificationsSent.${key}`]: true });
      return true;
    });
  } catch (error) {
    logger.warn(`Failed to claim notification key '${key}':`, error);
    return false;
  }
}

// ============================================================================
// MEMBER INVITED → notify invitee
// ============================================================================

export const onGooiMemberInvited = onDocumentCreated(
  {
    document: "gooiGroups/{groupId}/members/{memberId}",
    retry: true,
    labels: GOOI_NOTIF_LABELS,
  },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const member = snap.data();
    if (member.status !== "INVITED") return;

    const groupDoc = await db.collection("gooiGroups").doc(event.params.groupId).get();
    if (!groupDoc.exists) return;
    const group = groupDoc.data()!;

    const claimed = await claimNotificationKey(snap.ref, "invited");
    if (!claimed) return;

    await sendGooiNotification(
      member.userId,
      "Gooi-Gooi Invitation",
      `You've been invited to join "${group.name}". Contribution: R${(group.contributionAmount / 100).toFixed(2)} per ${group.cycleFrequency.toLowerCase()}.`,
      { groupId: event.params.groupId, action: "invitation" }
    );
  }
);

// ============================================================================
// GROUP STATUS CHANGE → notify all members
// ============================================================================

export const onGooiGroupStatusChange = onDocumentUpdated(
  {
    document: "gooiGroups/{groupId}",
    retry: true,
    labels: GOOI_NOTIF_LABELS,
  },
  async (event) => {
    const before = event.data?.before?.data();
    const after = event.data?.after?.data();
    if (!before || !after) return;

    if (before.status === after.status) return;

    const groupId = event.params.groupId;
    const groupRef = db.collection("gooiGroups").doc(groupId);

    // GROUP ACTIVATED
    if (before.status === "FORMING" && after.status === "ACTIVE") {
      const claimed = await claimNotificationKey(groupRef, "activated");
      if (!claimed) return;

      const membersSnap = await groupRef.collection("members")
        .where("isActive", "==", true)
        .get();

      for (const memberDoc of membersSnap.docs) {
        const member = memberDoc.data();
        await sendGooiNotification(
          member.userId,
          "Gooi-Gooi Activated!",
          `"${after.name}" is now active! Your first contribution is due soon.`,
          { groupId, action: "activated" }
        );
      }
    }

    // GROUP COMPLETED
    if (after.status === "COMPLETED") {
      const claimed = await claimNotificationKey(groupRef, "completed");
      if (!claimed) return;

      for (const uid of after.memberUserIds || []) {
        await sendGooiNotification(
          uid,
          "Gooi-Gooi Complete!",
          `"${after.name}" has completed all cycles. Thank you for participating!`,
          { groupId, action: "completed" }
        );
      }
    }

    // GROUP DISSOLVED
    if (after.status === "DISSOLVED") {
      const claimed = await claimNotificationKey(groupRef, "dissolved");
      if (!claimed) return;

      for (const uid of after.memberUserIds || []) {
        await sendGooiNotification(
          uid,
          "Gooi-Gooi Dissolved",
          `"${after.name}" has been dissolved.`,
          { groupId, action: "dissolved" }
        );
      }
    }
  }
);

// ============================================================================
// PAYOUT CREATED → notify recipient
// ============================================================================

export const onGooiPayoutCreated = onDocumentCreated(
  {
    document: "gooiGroups/{groupId}/payouts/{payoutId}",
    retry: true,
    labels: GOOI_NOTIF_LABELS,
  },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const payout = snap.data();
    if (payout.status !== "COMPLETED") return;

    const claimed = await claimNotificationKey(snap.ref, "payout_received");
    if (!claimed) return;

    const groupDoc = await db.collection("gooiGroups").doc(event.params.groupId).get();
    const groupName = groupDoc.data()?.name || "your group";

    await sendGooiNotification(
      payout.recipientUserId,
      "Gooi-Gooi Payout Received!",
      `You received R${(payout.totalPayoutAmount / 100).toFixed(2)} from "${groupName}".`,
      { groupId: event.params.groupId, payoutId: event.params.payoutId, action: "payout_received" }
    );
  }
);

// ============================================================================
// CONTRIBUTION STATUS CHANGE → notify member if LATE
// ============================================================================

export const onGooiContributionStatusChange = onDocumentUpdated(
  {
    document: "gooiGroups/{groupId}/contributions/{contributionId}",
    retry: true,
    labels: GOOI_NOTIF_LABELS,
  },
  async (event) => {
    const before = event.data?.before?.data();
    const after = event.data?.after?.data();
    if (!before || !after) return;

    if (before.status === after.status) return;

    const contribRef = event.data!.after!.ref;

    // LATE notification
    if (after.status === "LATE") {
      const claimed = await claimNotificationKey(contribRef, "late_flagged");
      if (!claimed) return;

      const groupDoc = await db.collection("gooiGroups").doc(event.params.groupId).get();
      const groupName = groupDoc.data()?.name || "your group";

      await sendGooiNotification(
        after.userId,
        "Contribution Overdue",
        `Your Gooi-Gooi contribution for "${groupName}" is now late. Please pay to avoid penalties.`,
        { groupId: event.params.groupId, action: "contribution_late" }
      );
    }

    // MISSED notification
    if (after.status === "MISSED") {
      const claimed = await claimNotificationKey(contribRef, "missed_flagged");
      if (!claimed) return;

      const groupDoc = await db.collection("gooiGroups").doc(event.params.groupId).get();
      const groupName = groupDoc.data()?.name || "your group";

      await sendGooiNotification(
        after.userId,
        "Contribution Missed",
        `Your Gooi-Gooi contribution for "${groupName}" was missed. This may affect your standing.`,
        { groupId: event.params.groupId, action: "contribution_missed" }
      );
    }
  }
);

// ============================================================================
// MEMBER STATUS CHANGE → notify delegation, suspension
// ============================================================================

export const onGooiMemberStatusChange = onDocumentUpdated(
  {
    document: "gooiGroups/{groupId}/members/{memberId}",
    retry: true,
    labels: GOOI_NOTIF_LABELS,
  },
  async (event) => {
    const before = event.data?.before?.data();
    const after = event.data?.after?.data();
    if (!before || !after) return;

    const memberRef = event.data!.after!.ref;

    // Delegation granted
    if (before.role !== "TRIGGER_DELEGATE" && after.role === "TRIGGER_DELEGATE") {
      const claimed = await claimNotificationKey(memberRef, "delegation_granted");
      if (!claimed) return;

      const groupDoc = await db.collection("gooiGroups").doc(event.params.groupId).get();
      const groupName = groupDoc.data()?.name || "the group";

      await sendGooiNotification(
        after.userId,
        "Trigger Delegation",
        `You've been delegated payout trigger rights for "${groupName}".`,
        { groupId: event.params.groupId, action: "delegation_granted" }
      );
    }

    // Suspended
    if (before.status !== "SUSPENDED" && after.status === "SUSPENDED") {
      const claimed = await claimNotificationKey(memberRef, "suspended");
      if (!claimed) return;

      const groupDoc = await db.collection("gooiGroups").doc(event.params.groupId).get();
      const groupName = groupDoc.data()?.name || "the group";

      await sendGooiNotification(
        after.userId,
        "Gooi-Gooi Suspension",
        `You've been suspended from "${groupName}". Contact the group initiator for more information.`,
        { groupId: event.params.groupId, action: "member_suspended" }
      );
    }
  }
);
