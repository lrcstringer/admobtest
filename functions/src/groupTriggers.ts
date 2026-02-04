/**
 * Group Account Firestore Triggers
 *
 * Handles automatic operations triggered by Firestore document changes
 * for group accounts (stokvels, family, organizations, clubs).
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {
  Group,
  GroupMember,
  GroupTransaction,
  GroupConfig,
} from "./ledger/types";
import {
  getOrCreateGroupAccount,
  deleteGroupAccount,
} from "./ledger/groupAccounts";

const db = admin.firestore();

// ============================================================================
// GROUP LIFECYCLE TRIGGERS
// ============================================================================

/**
 * When a group is created, create its ledger account
 */
export const onGroupCreated = functions.firestore
  .document(`${GroupConfig.COLLECTION_GROUPS}/{groupId}`)
  .onCreate(async (snap, context) => {
    const groupId = context.params.groupId;
    const group = snap.data() as Group;

    console.log(`Group created: ${groupId} (${group.type})`);

    try {
      // Create ledger account with treasury sub-account
      const { accountId, subAccountId } = await getOrCreateGroupAccount(groupId);
      console.log(`Created ledger account ${accountId} with treasury ${subAccountId} for group ${groupId}`);

      // Update group with ledger reference (for debugging)
      await snap.ref.update({
        "metadata.ledgerAccountId": accountId,
        "metadata.treasurySubAccountId": subAccountId,
      });
    } catch (error) {
      console.error(`Failed to create ledger account for group ${groupId}:`, error);
    }

    return null;
  });

/**
 * When a group is deleted (closed), cleanup its ledger account
 */
export const onGroupDeleted = functions.firestore
  .document(`${GroupConfig.COLLECTION_GROUPS}/{groupId}`)
  .onDelete(async (snap, context) => {
    const groupId = context.params.groupId;
    const group = snap.data() as Group;

    console.log(`Group deleted: ${groupId}`);

    // Only delete ledger account if balance is zero
    // (should have been checked before allowing deletion)
    if (group.totalBalance === 0) {
      try {
        await deleteGroupAccount(groupId);
        console.log(`Deleted ledger account for group ${groupId}`);
      } catch (error) {
        console.error(`Failed to delete ledger account for group ${groupId}:`, error);
      }
    } else {
      console.warn(`Group ${groupId} deleted with non-zero balance: ${group.totalBalance}`);
    }

    return null;
  });

/**
 * When group status changes to closed, notify members
 */
export const onGroupStatusChanged = functions.firestore
  .document(`${GroupConfig.COLLECTION_GROUPS}/{groupId}`)
  .onUpdate(async (change, context) => {
    const before = change.before.data() as Group;
    const after = change.after.data() as Group;
    const groupId = context.params.groupId;

    // Check if status changed
    if (before.status === after.status) {
      return null;
    }

    console.log(`Group ${groupId} status changed: ${before.status} -> ${after.status}`);

    // Notify members when group is suspended or closed
    if (after.status === "suspended" || after.status === "closed") {
      try {
        // Get all active members
        const membersSnap = await db
          .collection(GroupConfig.COLLECTION_GROUPS)
          .doc(groupId)
          .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
          .where("status", "==", "active")
          .get();

        // Send notification to each member
        const notifications = membersSnap.docs.map(async (doc) => {
          const member = doc.data() as GroupMember;
          const notificationData = {
            userId: member.userId,
            type: after.status === "closed" ? "group_closed" : "group_suspended",
            title: after.status === "closed" ? "Group Closed" : "Group Suspended",
            body: after.status === "closed"
              ? `The group "${after.name}" has been closed.`
              : `The group "${after.name}" has been temporarily suspended.`,
            data: {
              groupId,
              groupName: after.name,
              status: after.status,
            },
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            read: false,
          };

          return db.collection("notifications").add(notificationData);
        });

        await Promise.all(notifications);
        console.log(`Notified ${membersSnap.size} members about group ${groupId} status change`);
      } catch (error) {
        console.error(`Failed to notify members about group ${groupId} status change:`, error);
      }
    }

    return null;
  });

// ============================================================================
// MEMBER TRIGGERS
// ============================================================================

/**
 * When a member is added/invited, send notification
 */
export const onMemberAdded = functions.firestore
  .document(`${GroupConfig.COLLECTION_GROUPS}/{groupId}/${GroupConfig.SUBCOLLECTION_MEMBERS}/{memberId}`)
  .onCreate(async (snap, context) => {
    const groupId = context.params.groupId;
    const memberId = context.params.memberId;
    const member = snap.data() as GroupMember;

    console.log(`Member added to group ${groupId}: ${memberId} (status: ${member.status})`);

    // Only notify if this is an invitation (not the owner joining on creation)
    if (member.status === "invited") {
      try {
        // Get group details
        const groupDoc = await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).get();
        const group = groupDoc.data() as Group;

        // Get inviter details
        const inviterDoc = await db.collection("users").doc(member.invitedBy).get();
        const inviterData = inviterDoc.data() || {};
        const inviterName = inviterData.displayName || "Someone";

        // Send notification
        await db.collection("notifications").add({
          userId: member.userId,
          type: "group_invitation",
          title: "Group Invitation",
          body: `${inviterName} invited you to join "${group.name}"`,
          data: {
            groupId,
            groupName: group.name,
            groupType: group.type,
            invitedBy: member.invitedBy,
            inviterName,
            role: member.role,
          },
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          read: false,
        });

        console.log(`Sent invitation notification to ${memberId} for group ${groupId}`);
      } catch (error) {
        console.error(`Failed to send invitation notification:`, error);
      }
    }

    return null;
  });

/**
 * When a member accepts invitation, notify the group
 */
export const onMemberJoined = functions.firestore
  .document(`${GroupConfig.COLLECTION_GROUPS}/{groupId}/${GroupConfig.SUBCOLLECTION_MEMBERS}/{memberId}`)
  .onUpdate(async (change, context) => {
    const before = change.before.data() as GroupMember;
    const after = change.after.data() as GroupMember;
    const groupId = context.params.groupId;
    const memberId = context.params.memberId;

    // Check if member just accepted invitation
    if (before.status === "invited" && after.status === "active") {
      console.log(`Member ${memberId} joined group ${groupId}`);

      try {
        // Get group details
        const groupDoc = await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).get();
        const group = groupDoc.data() as Group;

        // Notify owner and admins
        const adminsSnap = await db
          .collection(GroupConfig.COLLECTION_GROUPS)
          .doc(groupId)
          .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
          .where("status", "==", "active")
          .where("role", "in", ["owner", "admin"])
          .get();

        const notifications = adminsSnap.docs
          .filter((doc) => doc.id !== memberId) // Don't notify the joining member
          .map((doc) => {
            return db.collection("notifications").add({
              userId: doc.id,
              type: "member_joined",
              title: "New Member",
              body: `${after.displayName} joined "${group.name}"`,
              data: {
                groupId,
                groupName: group.name,
                memberId,
                memberName: after.displayName,
              },
              createdAt: admin.firestore.FieldValue.serverTimestamp(),
              read: false,
            });
          });

        await Promise.all(notifications);
        console.log(`Notified admins about new member ${memberId} in group ${groupId}`);
      } catch (error) {
        console.error(`Failed to notify admins about new member:`, error);
      }
    }

    return null;
  });

// ============================================================================
// TRANSACTION TRIGGERS
// ============================================================================

/**
 * When a transaction is completed, notify relevant members
 */
export const onGroupTransactionCompleted = functions.firestore
  .document(`${GroupConfig.COLLECTION_GROUPS}/{groupId}/${GroupConfig.SUBCOLLECTION_TRANSACTIONS}/{transactionId}`)
  .onUpdate(async (change, context) => {
    const before = change.before.data() as GroupTransaction;
    const after = change.after.data() as GroupTransaction;
    const groupId = context.params.groupId;
    const transactionId = context.params.transactionId;

    // Check if transaction just completed
    if (before.status !== "completed" && after.status === "completed") {
      console.log(`Transaction ${transactionId} completed in group ${groupId}`);

      try {
        // Get group details
        const groupDoc = await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).get();
        const group = groupDoc.data() as Group;

        // Get user details for the transaction
        let actorName = "A member";
        if (after.createdBy) {
          const actorDoc = await db.collection("users").doc(after.createdBy).get();
          const actorData = actorDoc.data();
          if (actorData) {
            actorName = actorData.displayName || "A member";
          }
        }

        // Determine notification recipients and message based on transaction type
        let recipientIds: string[] = [];
        let notificationBody = "";

        switch (after.type) {
          case "contribution":
            // Notify owner and admins
            const adminsSnap = await db
              .collection(GroupConfig.COLLECTION_GROUPS)
              .doc(groupId)
              .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
              .where("status", "==", "active")
              .where("role", "in", ["owner", "admin", "treasurer"])
              .get();
            recipientIds = adminsSnap.docs.map((d) => d.id).filter((id) => id !== after.createdBy);
            notificationBody = `${actorName} contributed ${after.amount} tokens to "${group.name}"`;
            break;

          case "withdrawal":
            // Notify owner
            recipientIds = [group.ownerId].filter((id) => id !== after.toMemberId);
            notificationBody = `${actorName} withdrew ${after.amount} tokens from "${group.name}"`;
            break;

          case "payout":
            // Notify recipient
            if (after.toMemberId) {
              recipientIds = [after.toMemberId];
              notificationBody = `You received a payout of ${after.amount} tokens from "${group.name}"`;
            }
            break;

          default:
            return null;
        }

        // Send notifications
        const notifications = recipientIds.map((userId) => {
          return db.collection("notifications").add({
            userId,
            type: "group_transaction",
            title: group.name,
            body: notificationBody,
            data: {
              groupId,
              groupName: group.name,
              transactionId,
              transactionType: after.type,
              amount: after.amount,
            },
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            read: false,
          });
        });

        await Promise.all(notifications);
        console.log(`Sent ${notifications.length} notifications for transaction ${transactionId}`);
      } catch (error) {
        console.error(`Failed to send transaction notifications:`, error);
      }
    }

    return null;
  });

/**
 * When a transaction needs approval, notify approvers
 */
export const onApprovalNeeded = functions.firestore
  .document(`${GroupConfig.COLLECTION_GROUPS}/{groupId}/${GroupConfig.SUBCOLLECTION_APPROVALS}/{approvalId}`)
  .onCreate(async (snap, context) => {
    const groupId = context.params.groupId;
    const approvalId = context.params.approvalId;
    const approval = snap.data();

    console.log(`Approval needed for transaction in group ${groupId}: ${approvalId}`);

    try {
      // Get group details
      const groupDoc = await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).get();
      const group = groupDoc.data() as Group;

      // Get transaction details
      const transactionDoc = await db
        .collection(GroupConfig.COLLECTION_GROUPS)
        .doc(groupId)
        .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
        .doc(approval.transactionId)
        .get();
      const transaction = transactionDoc.data() as GroupTransaction;

      // Get requester name
      let requesterName = "A member";
      if (transaction.createdBy) {
        const requesterDoc = await db.collection("users").doc(transaction.createdBy).get();
        const requesterData = requesterDoc.data();
        if (requesterData) {
          requesterName = requesterData.displayName || "A member";
        }
      }

      // Notify all required approvers
      const notifications = approval.requiredApprovers.map((approverId: string) => {
        return db.collection("notifications").add({
          userId: approverId,
          type: "approval_needed",
          title: "Approval Needed",
          body: `${requesterName} requested ${transaction.type} of ${transaction.amount} tokens in "${group.name}"`,
          data: {
            groupId,
            groupName: group.name,
            approvalId,
            transactionId: approval.transactionId,
            transactionType: transaction.type,
            amount: transaction.amount,
            requestedBy: transaction.createdBy,
          },
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          read: false,
        });
      });

      await Promise.all(notifications);
      console.log(`Notified ${notifications.length} approvers for approval ${approvalId}`);
    } catch (error) {
      console.error(`Failed to send approval notifications:`, error);
    }

    return null;
  });
