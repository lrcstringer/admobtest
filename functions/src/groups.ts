/**
 * Group Account Cloud Functions
 *
 * Handles group management for:
 * - Stokvels (South African savings groups)
 * - Family accounts (shared household wallets)
 * - Organization accounts (business wallets)
 * - Club/Community accounts (shared funds with member roles)
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  Group,
  GroupMember,
  GroupTransaction,
  PendingApproval,
  GroupType,
  GroupRole,
  GroupStatus,
  GroupMemberStatus,
  GroupTransactionStatus,
  GroupSettings,
  StokvelSettings,
  GroupPermissions,
  GroupRolePermissions,
  GroupConfig,
  GroupErrorCodes,
  CreateGroupInput,
  UpdateGroupInput,
  InviteMemberInput,
} from "./ledger/types";
import {
  getOrCreateGroupAccount,
  getGroupBalance,
  processGroupContribution,
  processGroupWithdrawal,
  processGroupPayout,
} from "./ledger/groupAccounts";

const db = admin.firestore();

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/**
 * Get a group by ID or throw error
 */
async function getGroupOrThrow(groupId: string): Promise<Group> {
  const doc = await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).get();
  if (!doc.exists) {
    throw new HttpsError("not-found", GroupErrorCodes.GROUP_NOT_FOUND);
  }
  return doc.data() as Group;
}

/**
 * Get a group member or null
 */
async function getGroupMember(groupId: string, userId: string): Promise<GroupMember | null> {
  const doc = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
    .doc(userId)
    .get();
  return doc.exists ? (doc.data() as GroupMember) : null;
}

/**
 * Verify user is a member of the group
 */
async function requireGroupMember(groupId: string, userId: string): Promise<GroupMember> {
  const member = await getGroupMember(groupId, userId);
  if (!member || member.status !== "active") {
    throw new HttpsError("permission-denied", GroupErrorCodes.NOT_A_MEMBER);
  }
  return member;
}

/**
 * Get permissions for a member
 */
function getMemberPermissions(member: GroupMember): GroupPermissions {
  return GroupRolePermissions[member.role];
}

/**
 * Check if user has a specific permission
 */
function requirePermission(
  member: GroupMember,
  permission: keyof GroupPermissions,
  errorCode: string = GroupErrorCodes.PERMISSION_DENIED
): void {
  const perms = getMemberPermissions(member);
  if (!perms[permission]) {
    throw new HttpsError("permission-denied", errorCode);
  }
}

/**
 * Validate group status is active
 */
function requireActiveGroup(group: Group): void {
  if (group.status === "suspended") {
    throw new HttpsError("failed-precondition", GroupErrorCodes.GROUP_SUSPENDED);
  }
  if (group.status === "closed") {
    throw new HttpsError("failed-precondition", GroupErrorCodes.GROUP_CLOSED);
  }
}

/**
 * Create default group settings
 */
function getDefaultGroupSettings(type: GroupType): GroupSettings {
  const base: GroupSettings = {
    requireApprovalAbove: GroupConfig.DEFAULT_APPROVAL_THRESHOLD,
    allowMemberWithdrawals: true,
    contributionCycle: "none",
    contributionAmount: 0,
    penaltyPercentage: 0,
  };

  if (type === "stokvel") {
    base.contributionCycle = "monthly";
    base.contributionAmount = GroupConfig.DEFAULT_CONTRIBUTION_AMOUNT;
    base.penaltyPercentage = GroupConfig.DEFAULT_PENALTY_PERCENTAGE;
    base.allowMemberWithdrawals = false; // Stokvels typically don't allow early withdrawals
  }

  return base;
}

/**
 * Create default stokvel settings
 */
function getDefaultStokvelSettings(): StokvelSettings {
  return {
    ...getDefaultGroupSettings("stokvel"),
    payoutType: "rotating",
    payoutSchedule: "0 0 1 * *", // First day of month
    currentPayoutRecipient: null,
    nextPayoutDate: null,
    payoutOrder: [],
  };
}

// ============================================================================
// GROUP MANAGEMENT FUNCTIONS
// ============================================================================

/**
 * Create a new group
 */
export const createGroup = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "createGroup");
  await requirePlayIntegrity(request.data, request, "createGroup", "HIGH");

  const userId = request.auth.uid;
  const input: CreateGroupInput = request.data;

  // Validate input
  if (!input.name || input.name.trim().length === 0) {
    throw new HttpsError("invalid-argument", "Group name is required");
  }
  if (input.name.length > GroupConfig.MAX_GROUP_NAME_LENGTH) {
    throw new HttpsError("invalid-argument", GroupErrorCodes.GROUP_NAME_TOO_LONG);
  }
  if (input.description && input.description.length > GroupConfig.MAX_GROUP_DESCRIPTION_LENGTH) {
    throw new HttpsError("invalid-argument", GroupErrorCodes.GROUP_DESCRIPTION_TOO_LONG);
  }

  const validTypes: GroupType[] = ["stokvel", "family", "organization", "club"];
  if (!validTypes.includes(input.type)) {
    throw new HttpsError("invalid-argument", "Invalid group type");
  }

  // Get user info for member record
  const userDoc = await db.collection("users").doc(userId).get();
  const userData = userDoc.data() || {};

  const now = admin.firestore.Timestamp.now();
  const groupRef = db.collection(GroupConfig.COLLECTION_GROUPS).doc();

  // Prepare group settings
  const settings = {
    ...getDefaultGroupSettings(input.type),
    ...input.settings,
  };

  // Prepare stokvel settings if applicable
  let stokvelSettings: StokvelSettings | null = null;
  if (input.type === "stokvel") {
    stokvelSettings = {
      ...getDefaultStokvelSettings(),
      ...input.stokvelSettings,
    };
  }

  // Create group document
  const group: Group = {
    id: groupRef.id,
    type: input.type,
    name: input.name.trim(),
    description: input.description?.trim() || "",
    avatarUrl: input.avatarUrl || null,
    ownerId: userId,
    memberIds: [userId],
    memberCount: 1,
    totalBalance: 0,
    status: "active",
    settings,
    stokvelSettings,
    createdAt: now,
    updatedAt: now,
  };

  // Create owner member record
  const ownerMember: GroupMember = {
    id: userId,
    groupId: groupRef.id,
    userId,
    role: "owner",
    displayName: userData.displayName || "Unknown",
    avatarUrl: userData.avatarUrl || null,
    status: "active",
    contributionBalance: 0,
    joinedAt: now,
    invitedBy: userId, // Self-invited as creator
    invitedAt: now,
  };

  // Create group and owner in transaction
  await db.runTransaction(async (transaction) => {
    transaction.set(groupRef, group);
    transaction.set(
      groupRef.collection(GroupConfig.SUBCOLLECTION_MEMBERS).doc(userId),
      ownerMember
    );
  });

  // Create ledger account for the group (done outside transaction as it has its own transaction)
  try {
    await getOrCreateGroupAccount(groupRef.id);
    logger.info(`Created ledger account for group ${groupRef.id}`);
  } catch (error) {
    logger.error(`Failed to create ledger account for group ${groupRef.id}:`, error);
    // Don't fail the whole operation - the trigger will retry
  }

  return {
    success: true,
    groupId: groupRef.id,
    group,
  };
});

/**
 * Update group settings
 */
export const updateGroup = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "updateGroup");

  const userId = request.auth.uid;
  const { groupId, ...updates }: { groupId: string } & UpdateGroupInput = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);
  const member = await requireGroupMember(groupId, userId);
  requirePermission(member, "canEditSettings");

  // Validate updates
  if (updates.name !== undefined) {
    if (updates.name.trim().length === 0) {
      throw new HttpsError("invalid-argument", "Group name cannot be empty");
    }
    if (updates.name.length > GroupConfig.MAX_GROUP_NAME_LENGTH) {
      throw new HttpsError("invalid-argument", GroupErrorCodes.GROUP_NAME_TOO_LONG);
    }
  }
  if (updates.description !== undefined && updates.description.length > GroupConfig.MAX_GROUP_DESCRIPTION_LENGTH) {
    throw new HttpsError("invalid-argument", GroupErrorCodes.GROUP_DESCRIPTION_TOO_LONG);
  }

  const updateData: Partial<Group> = {
    updatedAt: admin.firestore.Timestamp.now(),
  };

  if (updates.name !== undefined) updateData.name = updates.name.trim();
  if (updates.description !== undefined) updateData.description = updates.description.trim();
  if (updates.avatarUrl !== undefined) updateData.avatarUrl = updates.avatarUrl;
  if (updates.settings) {
    updateData.settings = { ...group.settings, ...updates.settings };
  }
  if (updates.stokvelSettings && group.type === "stokvel") {
    updateData.stokvelSettings = {
      ...(group.stokvelSettings || getDefaultStokvelSettings()),
      ...updates.stokvelSettings,
    };
  }

  await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).update(updateData);

  return { success: true };
});

/**
 * Delete/close a group (only owner can do this)
 */
export const deleteGroup = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "deleteGroup");
  await requirePlayIntegrity(request.data, request, "deleteGroup", "HIGH");

  const userId = request.auth.uid;
  const { groupId } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  const group = await getGroupOrThrow(groupId);

  if (group.ownerId !== userId) {
    throw new HttpsError("permission-denied", GroupErrorCodes.PERMISSION_DENIED);
  }

  // Check if group has balance - can't delete with funds
  const balance = await getGroupBalance(groupId);
  if (balance > 0) {
    throw new HttpsError(
      "failed-precondition",
      "Cannot delete group with remaining balance. Distribute funds first."
    );
  }

  // Mark as closed instead of deleting (for audit trail)
  await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).update({
    status: "closed" as GroupStatus,
    updatedAt: admin.firestore.Timestamp.now(),
  });

  return { success: true };
});

// ============================================================================
// MEMBERSHIP FUNCTIONS
// ============================================================================

/**
 * Invite a member to the group
 */
export const inviteMember = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "inviteMember");

  const inviterId = request.auth.uid;
  const input: InviteMemberInput = request.data;

  if (!input.groupId || !input.userId) {
    throw new HttpsError("invalid-argument", "Group ID and user ID are required");
  }

  if (input.userId === inviterId) {
    throw new HttpsError("invalid-argument", GroupErrorCodes.CANNOT_INVITE_SELF);
  }

  const group = await getGroupOrThrow(input.groupId);
  requireActiveGroup(group);

  // Check inviter permissions
  const inviterMember = await requireGroupMember(input.groupId, inviterId);
  requirePermission(inviterMember, "canManageMembers");

  // Check if already a member
  const existingMember = await getGroupMember(input.groupId, input.userId);
  if (existingMember) {
    if (existingMember.status === "blocked") {
      throw new HttpsError("failed-precondition", GroupErrorCodes.MEMBER_BLOCKED);
    }
    throw new HttpsError("already-exists", GroupErrorCodes.MEMBER_ALREADY_EXISTS);
  }

  // Check max members
  if (group.memberCount >= GroupConfig.MAX_MEMBERS_PER_GROUP) {
    throw new HttpsError("resource-exhausted", GroupErrorCodes.MAX_MEMBERS_REACHED);
  }

  // Get invitee user info
  const inviteeDoc = await db.collection("users").doc(input.userId).get();
  if (!inviteeDoc.exists) {
    throw new HttpsError("not-found", "User not found");
  }
  const inviteeData = inviteeDoc.data() || {};

  const now = admin.firestore.Timestamp.now();

  // Validate role - can't invite as owner
  const role: GroupRole = input.role === "owner" ? "admin" : input.role;

  // Create invited member record
  const memberData: GroupMember = {
    id: input.userId,
    groupId: input.groupId,
    userId: input.userId,
    role,
    displayName: input.displayName || inviteeData.displayName || "Unknown",
    avatarUrl: input.avatarUrl || inviteeData.avatarUrl || null,
    status: "invited",
    contributionBalance: 0,
    joinedAt: null,
    invitedBy: inviterId,
    invitedAt: now,
  };

  await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(input.groupId)
    .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
    .doc(input.userId)
    .set(memberData);

  // TODO: Send push notification to invitee

  return { success: true, memberId: input.userId };
});

/**
 * Accept a group invitation
 */
export const acceptInvitation = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "acceptInvitation");

  const userId = request.auth.uid;
  const { groupId } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  const member = await getGroupMember(groupId, userId);
  if (!member) {
    throw new HttpsError("not-found", GroupErrorCodes.INVITATION_NOT_FOUND);
  }
  if (member.status === "active") {
    throw new HttpsError("already-exists", GroupErrorCodes.INVITATION_ALREADY_ACCEPTED);
  }
  if (member.status === "blocked") {
    throw new HttpsError("permission-denied", GroupErrorCodes.MEMBER_BLOCKED);
  }

  // Check invitation hasn't expired
  const invitedAt = member.invitedAt.toDate();
  const expiresAt = new Date(invitedAt.getTime() + GroupConfig.INVITATION_EXPIRY_DAYS * 24 * 60 * 60 * 1000);
  if (new Date() > expiresAt) {
    throw new HttpsError("failed-precondition", GroupErrorCodes.INVITATION_EXPIRED);
  }

  const now = admin.firestore.Timestamp.now();

  // Update member and group in transaction
  await db.runTransaction(async (transaction) => {
    const groupRef = db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId);
    const memberRef = groupRef.collection(GroupConfig.SUBCOLLECTION_MEMBERS).doc(userId);

    transaction.update(memberRef, {
      status: "active" as GroupMemberStatus,
      joinedAt: now,
    });

    transaction.update(groupRef, {
      memberIds: admin.firestore.FieldValue.arrayUnion(userId),
      memberCount: admin.firestore.FieldValue.increment(1),
      updatedAt: now,
    });
  });

  return { success: true };
});

/**
 * Remove a member from the group
 */
export const removeMember = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "removeMember");

  const actorId = request.auth.uid;
  const { groupId, memberId } = request.data;

  if (!groupId || !memberId) {
    throw new HttpsError("invalid-argument", "Group ID and member ID are required");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  // Can't remove the owner
  if (memberId === group.ownerId) {
    throw new HttpsError("failed-precondition", GroupErrorCodes.CANNOT_REMOVE_OWNER);
  }

  // Check permissions (must be admin or removing self)
  const actor = await getGroupMember(groupId, actorId);
  if (!actor || actor.status !== "active") {
    throw new HttpsError("permission-denied", GroupErrorCodes.NOT_A_MEMBER);
  }

  const isSelfRemoval = actorId === memberId;
  if (!isSelfRemoval) {
    requirePermission(actor, "canManageMembers");
  }

  // Get member being removed
  const targetMember = await getGroupMember(groupId, memberId);
  if (!targetMember) {
    throw new HttpsError("not-found", GroupErrorCodes.MEMBER_NOT_FOUND);
  }

  const now = admin.firestore.Timestamp.now();

  // Remove member and update group in transaction
  await db.runTransaction(async (transaction) => {
    const groupRef = db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId);
    const memberRef = groupRef.collection(GroupConfig.SUBCOLLECTION_MEMBERS).doc(memberId);

    // Delete member document
    transaction.delete(memberRef);

    // Update group only if was active member
    if (targetMember.status === "active") {
      transaction.update(groupRef, {
        memberIds: admin.firestore.FieldValue.arrayRemove(memberId),
        memberCount: admin.firestore.FieldValue.increment(-1),
        updatedAt: now,
      });
    }
  });

  return { success: true };
});

/**
 * Update a member's role
 */
export const updateMemberRole = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "updateMemberRole");

  const actorId = request.auth.uid;
  const { groupId, memberId, role } = request.data;

  if (!groupId || !memberId || !role) {
    throw new HttpsError("invalid-argument", "Group ID, member ID, and role are required");
  }

  const validRoles: GroupRole[] = ["admin", "treasurer", "member", "viewer"];
  if (!validRoles.includes(role)) {
    throw new HttpsError("invalid-argument", "Invalid role");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  // Can't change own role
  if (actorId === memberId) {
    throw new HttpsError("failed-precondition", GroupErrorCodes.CANNOT_CHANGE_OWN_ROLE);
  }

  // Can't change owner's role
  if (memberId === group.ownerId) {
    throw new HttpsError("failed-precondition", "Cannot change owner's role");
  }

  // Check actor has permission
  const actor = await requireGroupMember(groupId, actorId);
  requirePermission(actor, "canManageMembers");

  // Only owner can make admins
  if (role === "admin" && actor.role !== "owner") {
    throw new HttpsError("permission-denied", "Only owner can assign admin role");
  }

  // Get target member
  const targetMember = await getGroupMember(groupId, memberId);
  if (!targetMember || targetMember.status !== "active") {
    throw new HttpsError("not-found", GroupErrorCodes.MEMBER_NOT_FOUND);
  }

  await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
    .doc(memberId)
    .update({ role });

  return { success: true };
});

/**
 * Leave a group (convenience function that calls removeMember for self)
 */
export const leaveGroup = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "leaveGroup");

  const userId = request.auth.uid;
  const { groupId } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  const group = await getGroupOrThrow(groupId);

  // Owner can't leave - must transfer ownership first or delete group
  if (userId === group.ownerId) {
    throw new HttpsError(
      "failed-precondition",
      "Owner cannot leave. Transfer ownership or delete the group."
    );
  }

  // Use removeMember logic — call the wrapped handler directly
  return removeMember.run({ data: { groupId, memberId: userId }, auth: request.auth } as any);
});

// ============================================================================
// FINANCIAL OPERATIONS
// ============================================================================

/**
 * Contribute tokens to a group
 */
export const contributeToGroup = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "contributeToGroup");
  await requirePlayIntegrity(request.data, request, "contributeToGroup", "HIGH");

  const userId = request.auth.uid;
  const { groupId, amount, description } = request.data;

  if (!groupId || !amount) {
    throw new HttpsError("invalid-argument", "Group ID and amount are required");
  }

  if (amount <= 0) {
    throw new HttpsError("invalid-argument", "Amount must be positive");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  const member = await requireGroupMember(groupId, userId);
  requirePermission(member, "canTransferFunds");

  const now = admin.firestore.Timestamp.now();

  // Create transaction record
  const transactionRef = db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc();

  const transactionData: GroupTransaction = {
    id: transactionRef.id,
    groupId,
    journalId: null,
    type: "contribution",
    amount,
    fromMemberId: userId,
    toMemberId: null,
    description: description || "Contribution",
    status: "pending",
    approvedBy: null,
    createdBy: userId,
    createdAt: now,
    completedAt: null,
  };

  await transactionRef.set(transactionData);

  // Process the contribution through the ledger
  try {
    const result = await processGroupContribution(
      groupId,
      userId,
      amount,
      transactionRef.id
    );

    if (!result.success) {
      await transactionRef.update({
        status: "rejected" as GroupTransactionStatus,
        description: result.error || "Failed to process contribution",
      });
      throw new HttpsError("internal", result.error || "Failed to process contribution");
    }

    // Update transaction as completed
    await transactionRef.update({
      status: "completed" as GroupTransactionStatus,
      journalId: result.journalId,
      completedAt: admin.firestore.Timestamp.now(),
    });

    // Update member contribution balance
    await db
      .collection(GroupConfig.COLLECTION_GROUPS)
      .doc(groupId)
      .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
      .doc(userId)
      .update({
        contributionBalance: admin.firestore.FieldValue.increment(amount),
      });

    // Update group total balance
    await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).update({
      totalBalance: admin.firestore.FieldValue.increment(amount),
      updatedAt: admin.firestore.Timestamp.now(),
    });

    return {
      success: true,
      transactionId: transactionRef.id,
      journalId: result.journalId,
    };
  } catch (error) {
    logger.error("Contribution error:", error);
    await transactionRef.update({
      status: "rejected" as GroupTransactionStatus,
    });
    throw error;
  }
});

/**
 * Withdraw tokens from a group
 */
export const withdrawFromGroup = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "withdrawFromGroup");
  await requirePlayIntegrity(request.data, request, "withdrawFromGroup", "HIGH");

  const userId = request.auth.uid;
  const { groupId, amount, description } = request.data;

  if (!groupId || !amount) {
    throw new HttpsError("invalid-argument", "Group ID and amount are required");
  }

  if (amount <= 0) {
    throw new HttpsError("invalid-argument", "Amount must be positive");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  // Check if withdrawals are allowed
  if (!group.settings.allowMemberWithdrawals) {
    throw new HttpsError("failed-precondition", GroupErrorCodes.WITHDRAWALS_NOT_ALLOWED);
  }

  const member = await requireGroupMember(groupId, userId);
  requirePermission(member, "canTransferFunds");

  // Check group has sufficient balance
  const groupBalance = await getGroupBalance(groupId);
  if (groupBalance < amount) {
    throw new HttpsError("failed-precondition", GroupErrorCodes.AMOUNT_EXCEEDS_BALANCE);
  }

  const now = admin.firestore.Timestamp.now();
  const perms = getMemberPermissions(member);

  // Check if approval is needed
  const needsApproval = amount > perms.maxTransferWithoutApproval &&
    amount > group.settings.requireApprovalAbove;

  // Create transaction record
  const transactionRef = db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc();

  const transactionData: GroupTransaction = {
    id: transactionRef.id,
    groupId,
    journalId: null,
    type: "withdrawal",
    amount,
    fromMemberId: null,
    toMemberId: userId,
    description: description || "Withdrawal",
    status: needsApproval ? "pending" : "pending",
    approvedBy: null,
    createdBy: userId,
    createdAt: now,
    completedAt: null,
  };

  await transactionRef.set(transactionData);

  if (needsApproval) {
    // Create pending approval
    const approvalRef = db
      .collection(GroupConfig.COLLECTION_GROUPS)
      .doc(groupId)
      .collection(GroupConfig.SUBCOLLECTION_APPROVALS)
      .doc();

    // Get list of approvers (admins, treasurers, owner)
    const approversSnap = await db
      .collection(GroupConfig.COLLECTION_GROUPS)
      .doc(groupId)
      .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
      .where("status", "==", "active")
      .where("role", "in", ["owner", "admin", "treasurer"])
      .get();

    const requiredApprovers = approversSnap.docs
      .map((d) => d.id)
      .filter((id) => id !== userId); // Exclude requester

    const expiresAt = new Date(now.toDate().getTime() + GroupConfig.APPROVAL_EXPIRY_HOURS * 60 * 60 * 1000);

    const approvalData: PendingApproval = {
      id: approvalRef.id,
      groupId,
      transactionId: transactionRef.id,
      requiredApprovers,
      approvers: [],
      rejectedBy: null,
      status: "pending",
      createdAt: now,
      expiresAt: admin.firestore.Timestamp.fromDate(expiresAt),
    };

    await approvalRef.set(approvalData);

    return {
      success: true,
      transactionId: transactionRef.id,
      approvalRequired: true,
      approvalId: approvalRef.id,
    };
  }

  // Process withdrawal immediately
  try {
    const result = await processGroupWithdrawal(
      groupId,
      userId,
      amount,
      transactionRef.id
    );

    if (!result.success) {
      await transactionRef.update({
        status: "rejected" as GroupTransactionStatus,
      });
      throw new HttpsError("internal", result.error || "Failed to process withdrawal");
    }

    await transactionRef.update({
      status: "completed" as GroupTransactionStatus,
      journalId: result.journalId,
      completedAt: admin.firestore.Timestamp.now(),
    });

    // Update group total balance
    await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).update({
      totalBalance: admin.firestore.FieldValue.increment(-amount),
      updatedAt: admin.firestore.Timestamp.now(),
    });

    return {
      success: true,
      transactionId: transactionRef.id,
      journalId: result.journalId,
      approvalRequired: false,
    };
  } catch (error) {
    logger.error("Withdrawal error:", error);
    await transactionRef.update({
      status: "rejected" as GroupTransactionStatus,
    });
    throw error;
  }
});

/**
 * Approve a pending transaction
 */
export const approveTransaction = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "approveTransaction");

  const approverId = request.auth.uid;
  const { groupId, transactionId } = request.data;

  if (!groupId || !transactionId) {
    throw new HttpsError("invalid-argument", "Group ID and transaction ID are required");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  const member = await requireGroupMember(groupId, approverId);
  requirePermission(member, "canApproveFunds", GroupErrorCodes.NOT_AUTHORIZED_TO_APPROVE);

  // Get transaction
  const transactionDoc = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc(transactionId)
    .get();

  if (!transactionDoc.exists) {
    throw new HttpsError("not-found", GroupErrorCodes.TRANSACTION_NOT_FOUND);
  }

  const transaction = transactionDoc.data() as GroupTransaction;

  if (transaction.status === "completed") {
    throw new HttpsError("failed-precondition", GroupErrorCodes.TRANSACTION_ALREADY_APPROVED);
  }
  if (transaction.status === "rejected") {
    throw new HttpsError("failed-precondition", GroupErrorCodes.TRANSACTION_ALREADY_REJECTED);
  }

  // Get pending approval
  const approvalsSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_APPROVALS)
    .where("transactionId", "==", transactionId)
    .where("status", "==", "pending")
    .limit(1)
    .get();

  if (approvalsSnap.empty) {
    throw new HttpsError("not-found", "No pending approval found");
  }

  const approvalDoc = approvalsSnap.docs[0];
  const approval = approvalDoc.data() as PendingApproval;

  // Check if expired
  if (approval.expiresAt.toDate() < new Date()) {
    await approvalDoc.ref.update({ status: "expired" });
    await transactionDoc.ref.update({ status: "rejected" as GroupTransactionStatus });
    throw new HttpsError("failed-precondition", GroupErrorCodes.TRANSACTION_EXPIRED);
  }

  // Check approver is authorized
  if (!approval.requiredApprovers.includes(approverId)) {
    throw new HttpsError("permission-denied", GroupErrorCodes.NOT_AUTHORIZED_TO_APPROVE);
  }

  // Add approval
  await approvalDoc.ref.update({
    approvers: admin.firestore.FieldValue.arrayUnion(approverId),
    status: "approved",
  });

  await transactionDoc.ref.update({
    status: "approved" as GroupTransactionStatus,
    approvedBy: approverId,
  });

  // Process the transaction
  let result;
  if (transaction.type === "withdrawal") {
    result = await processGroupWithdrawal(
      groupId,
      transaction.toMemberId!,
      transaction.amount,
      transactionId
    );
  } else if (transaction.type === "payout") {
    result = await processGroupPayout(groupId, [
      {
        memberId: transaction.toMemberId!,
        amount: transaction.amount,
      },
    ], transactionId);
  } else {
    throw new HttpsError("invalid-argument", "Invalid transaction type for approval");
  }

  if (!result.success) {
    await transactionDoc.ref.update({
      status: "rejected" as GroupTransactionStatus,
    });
    throw new HttpsError("internal", result.error || "Failed to process transaction");
  }

  await transactionDoc.ref.update({
    status: "completed" as GroupTransactionStatus,
    journalId: result.journalId,
    completedAt: admin.firestore.Timestamp.now(),
  });

  // Update group balance if withdrawal
  if (transaction.type === "withdrawal" || transaction.type === "payout") {
    await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).update({
      totalBalance: admin.firestore.FieldValue.increment(-transaction.amount),
      updatedAt: admin.firestore.Timestamp.now(),
    });
  }

  return {
    success: true,
    journalId: result.journalId,
  };
});

/**
 * Reject a pending transaction
 */
export const rejectTransaction = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "rejectTransaction");

  const rejecterId = request.auth.uid;
  const { groupId, transactionId, reason } = request.data;

  if (!groupId || !transactionId) {
    throw new HttpsError("invalid-argument", "Group ID and transaction ID are required");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  const member = await requireGroupMember(groupId, rejecterId);
  requirePermission(member, "canApproveFunds", GroupErrorCodes.NOT_AUTHORIZED_TO_APPROVE);

  // Get transaction
  const transactionDoc = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc(transactionId)
    .get();

  if (!transactionDoc.exists) {
    throw new HttpsError("not-found", GroupErrorCodes.TRANSACTION_NOT_FOUND);
  }

  const transaction = transactionDoc.data() as GroupTransaction;

  if (transaction.status === "completed") {
    throw new HttpsError("failed-precondition", GroupErrorCodes.TRANSACTION_ALREADY_APPROVED);
  }
  if (transaction.status === "rejected") {
    throw new HttpsError("failed-precondition", GroupErrorCodes.TRANSACTION_ALREADY_REJECTED);
  }

  // Update approval and transaction
  const approvalsSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_APPROVALS)
    .where("transactionId", "==", transactionId)
    .where("status", "==", "pending")
    .limit(1)
    .get();

  if (!approvalsSnap.empty) {
    await approvalsSnap.docs[0].ref.update({
      status: "rejected",
      rejectedBy: rejecterId,
    });
  }

  await transactionDoc.ref.update({
    status: "rejected" as GroupTransactionStatus,
    description: reason ? `${transaction.description} (Rejected: ${reason})` : transaction.description,
  });

  return { success: true };
});

// ============================================================================
// QUERY FUNCTIONS
// ============================================================================

/**
 * Get all groups for the current user
 */
export const getUserGroups = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "getUserGroups");

  const userId = request.auth.uid;

  const groupsSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .where("memberIds", "array-contains", userId)
    .where("status", "!=", "closed")
    .orderBy("status")
    .orderBy("updatedAt", "desc")
    .limit(100)
    .get();

  const groups = groupsSnap.docs.map((doc) => doc.data() as Group);

  return { success: true, groups };
});

/**
 * Get group details with members
 */
export const getGroupDetails = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "getGroupDetails");

  const userId = request.auth.uid;
  const { groupId } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  const group = await getGroupOrThrow(groupId);
  await requireGroupMember(groupId, userId);

  // Get members
  const membersSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
    .orderBy("role")
    .limit(200)
    .get();

  const members = membersSnap.docs.map((doc) => doc.data() as GroupMember);

  // Get current balance from ledger
  const balance = await getGroupBalance(groupId);

  return {
    success: true,
    group: { ...group, totalBalance: balance },
    members,
  };
});

/**
 * Get group transactions
 */
export const getGroupTransactions = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "getGroupTransactions");

  const userId = request.auth.uid;
  const { groupId, limit = 50 } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  await getGroupOrThrow(groupId);
  const member = await requireGroupMember(groupId, userId);
  requirePermission(member, "canViewLedger");

  const transactionsSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
    .orderBy("createdAt", "desc")
    .limit(Math.min(limit, 100))
    .get();

  const transactions = transactionsSnap.docs.map((doc) => doc.data() as GroupTransaction);

  return { success: true, transactions };
});

/**
 * Get pending approvals for a group
 */
export const getPendingApprovals = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "getPendingApprovals");

  const userId = request.auth.uid;
  const { groupId } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  await getGroupOrThrow(groupId);
  const member = await requireGroupMember(groupId, userId);
  requirePermission(member, "canApproveFunds");

  const approvalsSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_APPROVALS)
    .where("status", "==", "pending")
    .orderBy("createdAt", "desc")
    .limit(100)
    .get();

  const approvals = approvalsSnap.docs.map((doc) => doc.data() as PendingApproval);

  // Get related transactions
  const transactionIds = approvals.map((a) => a.transactionId);
  const transactions: Record<string, GroupTransaction> = {};

  // Fetch all related transactions in parallel (was serial)
  const txResults = await Promise.all(
    transactionIds.map((txId) =>
      db.collection(GroupConfig.COLLECTION_GROUPS)
        .doc(groupId)
        .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
        .doc(txId)
        .get()
    )
  );
  for (const txDoc of txResults) {
    if (txDoc.exists) {
      transactions[txDoc.id] = txDoc.data() as GroupTransaction;
    }
  }

  return { success: true, approvals, transactions };
});

// ============================================================================
// STOKVEL-SPECIFIC SCHEDULED FUNCTIONS
// ============================================================================

/**
 * Send contribution reminders for stokvels
 * Runs every Monday at 9 AM South Africa time
 */
export const sendStokvelContributionReminders = onSchedule(
  { schedule: "0 9 * * 1", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "social" } },
  async () => {
    logger.info("Running stokvel contribution reminders...");

    // Get all active stokvels with contribution cycles
    const stokvelsSnap = await db
      .collection(GroupConfig.COLLECTION_GROUPS)
      .where("type", "==", "stokvel")
      .where("status", "==", "active")
      .where("settings.contributionCycle", "in", ["weekly", "monthly"])
      .get();

    logger.info(`Found ${stokvelsSnap.docs.length} stokvels to process`);

    const now = new Date();
    const dayOfMonth = now.getDate();
    const isFirstWeekOfMonth = dayOfMonth <= 7;

    for (const stokvelDoc of stokvelsSnap.docs) {
      const stokvel = stokvelDoc.data() as Group;
      const settings = stokvel.settings;

      // For monthly contributions, only remind in first week
      if (settings.contributionCycle === "monthly" && !isFirstWeekOfMonth) {
        continue;
      }

      // Get active members
      const membersSnap = await stokvelDoc.ref
        .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
        .where("status", "==", "active")
        .limit(50)
        .get();

      // Create notifications for each member
      const batch = db.batch();
      const notificationTime = admin.firestore.Timestamp.now();

      for (const memberDoc of membersSnap.docs) {
        const member = memberDoc.data() as GroupMember;

        const notificationRef = db.collection("notifications").doc();
        batch.set(notificationRef, {
          id: notificationRef.id,
          userId: member.userId,
          type: "stokvel_contribution_reminder",
          title: `${stokvel.name} - Contribution Reminder`,
          body: `Your ${settings.contributionCycle} contribution of R${(settings.contributionAmount / 100).toFixed(2)} is due.`,
          data: {
            groupId: stokvel.id,
            groupName: stokvel.name,
            amount: settings.contributionAmount,
          },
          read: false,
          createdAt: notificationTime,
        });
      }

      await batch.commit();
      logger.info(`Sent reminders to ${membersSnap.docs.length} members of ${stokvel.name}`);
    }

    logger.info("Stokvel contribution reminders completed");
  }
);

/**
 * Calculate and apply stokvel penalties for missed contributions
 * Runs on the 1st of every month at midnight South Africa time
 */
export const calculateStokvelPenalties = onSchedule(
  { schedule: "0 0 1 * *", timeZone: "Africa/Johannesburg", region: "europe-west1", timeoutSeconds: 300, labels: { area: "social" } },
  async () => {
    logger.info("Running stokvel penalty calculations...");

    // Get all active stokvels
    const stokvelsSnap = await db
      .collection(GroupConfig.COLLECTION_GROUPS)
      .where("type", "==", "stokvel")
      .where("status", "==", "active")
      .get();

    logger.info(`Found ${stokvelsSnap.docs.length} stokvels to process`);

    const now = admin.firestore.Timestamp.now();
    const lastMonth = new Date();
    lastMonth.setMonth(lastMonth.getMonth() - 1);
    const lastMonthStart = new Date(lastMonth.getFullYear(), lastMonth.getMonth(), 1);
    const lastMonthEnd = new Date(lastMonth.getFullYear(), lastMonth.getMonth() + 1, 0, 23, 59, 59);

    for (const stokvelDoc of stokvelsSnap.docs) {
      const stokvel = stokvelDoc.data() as Group;
      const settings = stokvel.settings;

      // Skip if no penalty configured
      if (!settings.penaltyPercentage || settings.penaltyPercentage <= 0) {
        continue;
      }

      // Skip if no contribution requirement
      if (!settings.contributionAmount || settings.contributionAmount <= 0) {
        continue;
      }

      // Get active members
      const membersSnap = await stokvelDoc.ref
        .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
        .where("status", "==", "active")
        .limit(50)
        .get();

      // Get contributions from last month
      const contributionsSnap = await stokvelDoc.ref
        .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
        .where("type", "==", "contribution")
        .where("status", "==", "completed")
        .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(lastMonthStart))
        .where("createdAt", "<=", admin.firestore.Timestamp.fromDate(lastMonthEnd))
        .limit(50)
        .get();

      // Calculate total contributions per member
      const memberContributions: Record<string, number> = {};
      for (const txDoc of contributionsSnap.docs) {
        const tx = txDoc.data() as GroupTransaction;
        if (tx.fromMemberId) {
          memberContributions[tx.fromMemberId] = (memberContributions[tx.fromMemberId] || 0) + tx.amount;
        }
      }

      // Check for members who didn't meet minimum contribution
      const { processGroupPenalty } = await import("./ledger/groupAccounts");
      const penaltyBatch = db.batch();
      let penaltyBatchCount = 0;
      let totalPenaltyAmount = 0;

      for (const memberDoc of membersSnap.docs) {
        const member = memberDoc.data() as GroupMember;
        const contributed = memberContributions[member.userId] || 0;

        // Skip if member contributed enough
        if (contributed >= settings.contributionAmount) {
          continue;
        }

        // Calculate shortfall and penalty
        const shortfall = settings.contributionAmount - contributed;
        const penaltyAmount = Math.round(shortfall * (settings.penaltyPercentage / 100));

        if (penaltyAmount <= 0) {
          continue;
        }

        logger.info(`Applying penalty of ${penaltyAmount} to ${member.userId} in ${stokvel.name}`);

        const dateStr = `${lastMonth.getFullYear()}-${String(lastMonth.getMonth() + 1).padStart(2, "0")}`;

        try {
          // Ledger call must remain sequential
          const result = await processGroupPenalty(
            stokvel.id,
            member.userId,
            penaltyAmount,
            `Missed contribution for ${dateStr} (shortfall: R${(shortfall / 100).toFixed(2)})`,
            dateStr
          );

          if (result.success) {
            // Batch the Firestore writes instead of individual awaits
            const txRef = stokvelDoc.ref.collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS).doc();
            penaltyBatch.set(txRef, {
              id: txRef.id,
              groupId: stokvel.id,
              journalId: result.journalId,
              type: "penalty",
              amount: penaltyAmount,
              fromMemberId: member.userId,
              toMemberId: null,
              description: `Penalty for missed ${dateStr} contribution`,
              status: "completed",
              approvedBy: "system",
              createdBy: "system",
              createdAt: now,
              completedAt: now,
            } as GroupTransaction);

            const notificationRef = db.collection("notifications").doc();
            penaltyBatch.set(notificationRef, {
              id: notificationRef.id,
              userId: member.userId,
              type: "stokvel_penalty",
              title: `${stokvel.name} - Penalty Applied`,
              body: `A penalty of R${(penaltyAmount / 100).toFixed(2)} was applied for missing your ${dateStr} contribution.`,
              data: {
                groupId: stokvel.id,
                groupName: stokvel.name,
                amount: penaltyAmount,
              },
              read: false,
              createdAt: now,
            });

            totalPenaltyAmount += penaltyAmount;
            penaltyBatchCount += 2;
          } else {
            logger.error(`Failed to apply penalty: ${result.error}`);
          }
        } catch (error) {
          logger.error(`Error applying penalty to ${member.userId}:`, error);
        }
      }

      // Commit all penalty Firestore writes for this stokvel in one batch
      if (penaltyBatchCount > 0) {
        // Update group balance once for all penalties
        penaltyBatch.update(stokvelDoc.ref, {
          totalBalance: admin.firestore.FieldValue.increment(totalPenaltyAmount),
          updatedAt: now,
        });
        await penaltyBatch.commit();
      }
    }

    logger.info("Stokvel penalty calculations completed");
  }
);

/**
 * Process stokvel payouts according to schedule
 * Runs on the 1st of every month at 10 AM South Africa time
 */
export const processStokvelPayouts = onSchedule(
  { schedule: "0 10 1 * *", timeZone: "Africa/Johannesburg", region: "europe-west1", timeoutSeconds: 300, labels: { area: "social" } },
  async () => {
    logger.info("Running stokvel payout processing...");

    const now = admin.firestore.Timestamp.now();
    const today = new Date();

    // Get all active stokvels with payout schedules
    const stokvelsSnap = await db
      .collection(GroupConfig.COLLECTION_GROUPS)
      .where("type", "==", "stokvel")
      .where("status", "==", "active")
      .get();

    logger.info(`Found ${stokvelsSnap.docs.length} stokvels to check for payouts`);

    for (const stokvelDoc of stokvelsSnap.docs) {
      const stokvel = stokvelDoc.data() as Group;
      const stokvelSettings = stokvel.stokvelSettings;

      if (!stokvelSettings) {
        continue;
      }

      // Check if payout is due
      const nextPayoutDate = stokvelSettings.nextPayoutDate?.toDate();
      if (nextPayoutDate && nextPayoutDate > today) {
        continue; // Payout not due yet
      }

      // Get group balance
      const balance = await getGroupBalance(stokvel.id);
      if (balance <= 0) {
        logger.info(`${stokvel.name}: No balance to pay out`);
        continue;
      }

      // Get active members
      const membersSnap = await stokvelDoc.ref
        .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
        .where("status", "==", "active")
        .limit(50)
        .get();

      if (membersSnap.empty) {
        continue;
      }

      const members = membersSnap.docs.map((d) => d.data() as GroupMember);
      let recipientId: string | null = null;
      let payoutAmount = 0;

      switch (stokvelSettings.payoutType) {
        case "rotating": {
          // Rotating payout - next person in order
          const payoutOrder = stokvelSettings.payoutOrder || members.map((m) => m.userId);
          const currentRecipient = stokvelSettings.currentPayoutRecipient;
          const currentIndex = currentRecipient ? payoutOrder.indexOf(currentRecipient) : -1;
          const nextIndex = (currentIndex + 1) % payoutOrder.length;
          recipientId = payoutOrder[nextIndex];
          payoutAmount = balance; // Full balance to recipient
          break;
        }

        case "lottery": {
          // Random selection
          const memberIds = members.map((m) => m.userId);
          recipientId = memberIds[Math.floor(Math.random() * memberIds.length)];
          payoutAmount = balance;
          break;
        }

        case "fixed_date": {
          // Equal split to all members
          payoutAmount = Math.floor(balance / members.length);
          break;
        }

        case "goal_reached": {
          // Skip - handled manually when goal is reached
          continue;
        }
      }

      if (stokvelSettings.payoutType === "fixed_date" && payoutAmount > 0) {
        // Pay all members equally
        const payouts = members.map((m) => ({
          memberId: m.userId,
          amount: payoutAmount,
        }));

        const transactionRef = stokvelDoc.ref.collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS).doc();

        try {
          // Ledger call must remain sequential
          const result = await processGroupPayout(stokvel.id, payouts, transactionRef.id);

          if (result.success) {
            // Batch all Firestore writes together
            const payoutBatch = db.batch();
            payoutBatch.set(transactionRef, {
              id: transactionRef.id,
              groupId: stokvel.id,
              journalId: result.journalId,
              type: "payout",
              amount: payoutAmount * members.length,
              fromMemberId: null,
              toMemberId: null,
              description: `Monthly payout to ${members.length} members`,
              status: "completed",
              approvedBy: "system",
              createdBy: "system",
              createdAt: now,
              completedAt: now,
            } as GroupTransaction);

            payoutBatch.update(stokvelDoc.ref, {
              totalBalance: admin.firestore.FieldValue.increment(-(payoutAmount * members.length)),
              updatedAt: now,
            });

            // Include member notifications in the same batch
            for (const member of members) {
              const notificationRef = db.collection("notifications").doc();
              payoutBatch.set(notificationRef, {
                id: notificationRef.id,
                userId: member.userId,
                type: "stokvel_payout",
                title: `${stokvel.name} - Payout Received`,
                body: `You received R${(payoutAmount / 100).toFixed(2)} from the monthly payout.`,
                data: {
                  groupId: stokvel.id,
                  groupName: stokvel.name,
                  amount: payoutAmount,
                },
                read: false,
                createdAt: now,
              });
            }
            await payoutBatch.commit();
          }
        } catch (error) {
          logger.error(`Error processing fixed_date payout for ${stokvel.name}:`, error);
        }
      } else if (recipientId && payoutAmount > 0) {
        // Single recipient payout
        const transactionRef = stokvelDoc.ref.collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS).doc();

        try {
          // Ledger call must remain sequential
          const result = await processGroupPayout(
            stokvel.id,
            [{ memberId: recipientId, amount: payoutAmount }],
            transactionRef.id
          );

          if (result.success) {
            // Update stokvel settings for next payout
            const nextMonth = new Date(today);
            nextMonth.setMonth(nextMonth.getMonth() + 1);
            nextMonth.setDate(1);

            // Batch all Firestore writes together
            const payoutBatch = db.batch();
            payoutBatch.set(transactionRef, {
              id: transactionRef.id,
              groupId: stokvel.id,
              journalId: result.journalId,
              type: "payout",
              amount: payoutAmount,
              fromMemberId: null,
              toMemberId: recipientId,
              description: `${stokvelSettings.payoutType === "rotating" ? "Rotating" : "Lottery"} payout`,
              status: "completed",
              approvedBy: "system",
              createdBy: "system",
              createdAt: now,
              completedAt: now,
            } as GroupTransaction);

            payoutBatch.update(stokvelDoc.ref, {
              totalBalance: admin.firestore.FieldValue.increment(-payoutAmount),
              "stokvelSettings.currentPayoutRecipient": recipientId,
              "stokvelSettings.nextPayoutDate": admin.firestore.Timestamp.fromDate(nextMonth),
              updatedAt: now,
            });

            // Notify recipient
            const notificationRef = db.collection("notifications").doc();
            payoutBatch.set(notificationRef, {
              id: notificationRef.id,
              userId: recipientId,
              type: "stokvel_payout",
              title: `${stokvel.name} - Payout Received`,
              body: `You received the ${stokvelSettings.payoutType === "rotating" ? "rotating" : "lottery"} payout of R${(payoutAmount / 100).toFixed(2)}!`,
              data: {
                groupId: stokvel.id,
                groupName: stokvel.name,
                amount: payoutAmount,
              },
              read: false,
              createdAt: now,
            });

            // Notify other members
            const otherMembers = members.filter((m) => m.userId !== recipientId);
            for (const member of otherMembers) {
              const otherNotifRef = db.collection("notifications").doc();
              payoutBatch.set(otherNotifRef, {
                id: otherNotifRef.id,
                userId: member.userId,
                type: "stokvel_payout_notification",
                title: `${stokvel.name} - Payout Completed`,
                body: `This month's payout of R${(payoutAmount / 100).toFixed(2)} went to a fellow member.`,
                data: {
                  groupId: stokvel.id,
                  groupName: stokvel.name,
                  amount: payoutAmount,
                },
                read: false,
                createdAt: now,
              });
            }
            await payoutBatch.commit();

            logger.info(`Processed payout of ${payoutAmount} to ${recipientId} for ${stokvel.name}`);
          }
        } catch (error) {
          logger.error(`Error processing payout for ${stokvel.name}:`, error);
        }
      }
    }

    logger.info("Stokvel payout processing completed");
  }
);

/**
 * Manually trigger a stokvel payout (for admins)
 */
export const triggerStokvelPayout = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "triggerStokvelPayout");
  await requirePlayIntegrity(request.data, request, "triggerStokvelPayout", "HIGH");

  const userId = request.auth.uid;
  const { groupId, recipientId } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  const group = await getGroupOrThrow(groupId);
  requireActiveGroup(group);

  if (group.type !== "stokvel") {
    throw new HttpsError("failed-precondition", "This function is only for stokvels");
  }

  // Check user is owner or admin
  const member = await requireGroupMember(groupId, userId);
  if (member.role !== "owner" && member.role !== "admin") {
    throw new HttpsError("permission-denied", "Only owner or admin can trigger payouts");
  }

  // Get group balance
  const balance = await getGroupBalance(groupId);
  if (balance <= 0) {
    throw new HttpsError("failed-precondition", "No balance available for payout");
  }

  // Determine recipient
  let finalRecipientId = recipientId;
  const stokvelSettings = group.stokvelSettings;

  if (!finalRecipientId && stokvelSettings) {
    // Get active members
    const membersSnap = await db
      .collection(GroupConfig.COLLECTION_GROUPS)
      .doc(groupId)
      .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
      .where("status", "==", "active")
      .get();

    const members = membersSnap.docs.map((d) => d.data() as GroupMember);

    if (stokvelSettings.payoutType === "rotating") {
      const payoutOrder = stokvelSettings.payoutOrder || members.map((m) => m.userId);
      const currentRecipient = stokvelSettings.currentPayoutRecipient;
      const currentIndex = currentRecipient ? payoutOrder.indexOf(currentRecipient) : -1;
      const nextIndex = (currentIndex + 1) % payoutOrder.length;
      finalRecipientId = payoutOrder[nextIndex];
    } else if (stokvelSettings.payoutType === "lottery") {
      const memberIds = members.map((m) => m.userId);
      finalRecipientId = memberIds[Math.floor(Math.random() * memberIds.length)];
    }
  }

  if (!finalRecipientId) {
    throw new HttpsError("invalid-argument", "Recipient ID is required for this payout type");
  }

  // Verify recipient is a member
  const recipientMember = await getGroupMember(groupId, finalRecipientId);
  if (!recipientMember || recipientMember.status !== "active") {
    throw new HttpsError("not-found", "Recipient is not an active member");
  }

  const now = admin.firestore.Timestamp.now();
  const transactionRef = db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc();

  try {
    const result = await processGroupPayout(
      groupId,
      [{ memberId: finalRecipientId, amount: balance }],
      transactionRef.id
    );

    if (!result.success) {
      throw new HttpsError("internal", result.error || "Failed to process payout");
    }

    await transactionRef.set({
      id: transactionRef.id,
      groupId,
      journalId: result.journalId,
      type: "payout",
      amount: balance,
      fromMemberId: null,
      toMemberId: finalRecipientId,
      description: `Manual payout triggered by ${member.displayName}`,
      status: "completed",
      approvedBy: userId,
      createdBy: userId,
      createdAt: now,
      completedAt: now,
    } as GroupTransaction);

    // Update stokvel settings
    const nextMonth = new Date();
    nextMonth.setMonth(nextMonth.getMonth() + 1);
    nextMonth.setDate(1);

    await db.collection(GroupConfig.COLLECTION_GROUPS).doc(groupId).update({
      totalBalance: admin.firestore.FieldValue.increment(-balance),
      "stokvelSettings.currentPayoutRecipient": finalRecipientId,
      "stokvelSettings.nextPayoutDate": admin.firestore.Timestamp.fromDate(nextMonth),
      updatedAt: now,
    });

    // Notify recipient
    const notificationRef = db.collection("notifications").doc();
    await notificationRef.set({
      id: notificationRef.id,
      userId: finalRecipientId,
      type: "stokvel_payout",
      title: `${group.name} - Payout Received`,
      body: `You received a payout of R${(balance / 100).toFixed(2)}!`,
      data: {
        groupId,
        groupName: group.name,
        amount: balance,
      },
      read: false,
      createdAt: now,
    });

    return {
      success: true,
      transactionId: transactionRef.id,
      journalId: result.journalId,
      recipientId: finalRecipientId,
      amount: balance,
    };
  } catch (error) {
    logger.error("Payout error:", error);
    throw error;
  }
});

/**
 * Get stokvel contribution history for analytics
 */
export const getStokvelAnalytics = onCall({ labels: { area: "social" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  await requireAppCheck(request, "getStokvelAnalytics");

  const userId = request.auth.uid;
  const { groupId, months = 6 } = request.data;

  if (!groupId) {
    throw new HttpsError("invalid-argument", "Group ID is required");
  }

  const group = await getGroupOrThrow(groupId);
  if (group.type !== "stokvel") {
    throw new HttpsError("failed-precondition", "This function is only for stokvels");
  }

  const member = await requireGroupMember(groupId, userId);
  requirePermission(member, "canViewLedger");

  // Calculate date range
  const endDate = new Date();
  const startDate = new Date();
  startDate.setMonth(startDate.getMonth() - months);

  // Get all contributions in range
  const transactionsSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_TRANSACTIONS)
    .where("status", "==", "completed")
    .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(startDate))
    .where("createdAt", "<=", admin.firestore.Timestamp.fromDate(endDate))
    .orderBy("createdAt", "desc")
    .select("amount", "type", "createdAt", "fromMemberId")
    .limit(1000)
    .get();

  const transactions = transactionsSnap.docs.map((d) => d.data() as GroupTransaction);

  // Calculate analytics
  const analytics = {
    totalContributions: 0,
    totalWithdrawals: 0,
    totalPayouts: 0,
    totalPenalties: 0,
    monthlyBreakdown: {} as Record<string, { contributions: number; withdrawals: number; payouts: number; penalties: number }>,
    memberContributions: {} as Record<string, number>,
  };

  for (const tx of transactions) {
    const monthKey = `${tx.createdAt.toDate().getFullYear()}-${String(tx.createdAt.toDate().getMonth() + 1).padStart(2, "0")}`;

    if (!analytics.monthlyBreakdown[monthKey]) {
      analytics.monthlyBreakdown[monthKey] = { contributions: 0, withdrawals: 0, payouts: 0, penalties: 0 };
    }

    switch (tx.type) {
      case "contribution":
        analytics.totalContributions += tx.amount;
        analytics.monthlyBreakdown[monthKey].contributions += tx.amount;
        if (tx.fromMemberId) {
          analytics.memberContributions[tx.fromMemberId] = (analytics.memberContributions[tx.fromMemberId] || 0) + tx.amount;
        }
        break;
      case "withdrawal":
        analytics.totalWithdrawals += tx.amount;
        analytics.monthlyBreakdown[monthKey].withdrawals += tx.amount;
        break;
      case "payout":
        analytics.totalPayouts += tx.amount;
        analytics.monthlyBreakdown[monthKey].payouts += tx.amount;
        break;
      case "penalty":
        analytics.totalPenalties += tx.amount;
        analytics.monthlyBreakdown[monthKey].penalties += tx.amount;
        break;
    }
  }

  // Get member info for contribution rankings
  const membersSnap = await db
    .collection(GroupConfig.COLLECTION_GROUPS)
    .doc(groupId)
    .collection(GroupConfig.SUBCOLLECTION_MEMBERS)
    .where("status", "==", "active")
    .select("userId", "displayName", "avatarUrl")
    .limit(500)
    .get();

  const memberInfo: Record<string, { displayName: string; avatarUrl: string | null }> = {};
  for (const memberDoc of membersSnap.docs) {
    const m = memberDoc.data() as GroupMember;
    memberInfo[m.userId] = { displayName: m.displayName, avatarUrl: m.avatarUrl };
  }

  return {
    success: true,
    analytics,
    memberInfo,
    stokvelSettings: group.stokvelSettings,
    currentBalance: await getGroupBalance(groupId),
  };
});
