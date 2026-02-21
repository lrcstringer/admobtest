/**
 * Communities Cloud Functions
 *
 * Unified community system supporting regular communities and stokvels.
 * Adapted from groups.ts with added messaging capability.
 *
 * Collections:
 *   communities/{communityId}
 *   communities/{communityId}/messages/{messageId}
 *   communities/{communityId}/members/{userId}
 *   communities/{communityId}/transactions/{transactionId}
 *   communities/{communityId}/pendingApprovals/{approvalId}
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  GroupRole,
  GroupMemberStatus,
  GroupTransactionStatus,
  StokvelSettings,
  GroupTransaction,
  PendingApproval,
} from "./ledger/types";
import {
  getOrCreateGroupAccount,
  getGroupBalance,
  processGroupContribution,
  processGroupWithdrawal,
  processGroupPayout,
} from "./ledger/groupAccounts";
import {
  CommunityConfig,
  CommunityErrorCodes,
  CommunityType,
  Community,
  CommunityMember,
  requireAuth,
  getCommunityOrThrow,
  getCommunityMember,
  requireCommunityMember,
  getMemberPermissions,
  requirePermission,
  requireActiveCommunity,
  getUserProfile,
  getDefaultCommunitySettings,
  getDefaultStokvelSettings,
  truncate,
} from "./helpers/communityHelpers";

const db = admin.firestore();

// ============================================================================
// COMMUNITY MANAGEMENT
// ============================================================================

/**
 * Create a new community (regular or stokvel).
 */
export const createCommunity = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "createCommunity");
  await requirePlayIntegrity(request.data, request, "createCommunity", "HIGH");

  const { name, description, avatarUrl, type, settings, stokvelSettings } = request.data;

  // Validate input
  if (!name || name.trim().length === 0) {
    throw new HttpsError("invalid-argument", "Community name is required");
  }
  if (name.length > CommunityConfig.MAX_NAME_LENGTH) {
    throw new HttpsError("invalid-argument", CommunityErrorCodes.NAME_TOO_LONG);
  }
  if (description && description.length > CommunityConfig.MAX_DESCRIPTION_LENGTH) {
    throw new HttpsError("invalid-argument", CommunityErrorCodes.DESCRIPTION_TOO_LONG);
  }

  const validTypes: CommunityType[] = ["regular", "stokvel"];
  if (!validTypes.includes(type)) {
    throw new HttpsError("invalid-argument", "Invalid community type");
  }

  // Get user info for owner member record
  const userData = await getUserProfile(userId);
  const now = admin.firestore.Timestamp.now();
  const communityRef = db.collection(CommunityConfig.COLLECTION).doc();

  // Prepare settings
  const communitySettings = {
    ...getDefaultCommunitySettings(type),
    ...settings,
  };

  // Prepare stokvel settings if applicable
  let stokvel: StokvelSettings | null = null;
  if (type === "stokvel") {
    stokvel = {
      ...getDefaultStokvelSettings(),
      ...stokvelSettings,
    };
  }

  // Create community document
  const community: Community = {
    id: communityRef.id,
    type,
    name: name.trim(),
    description: description?.trim() || null,
    avatarUrl: avatarUrl || null,
    ownerId: userId,
    memberIds: [userId],
    adminIds: [userId],
    memberCount: 1,
    totalBalance: 0,
    status: "active",
    settings: communitySettings,
    stokvel,
    lastMessage: null,
    lastMessageAt: null,
    unreadCounts: {},
    muted: {},
    createdAt: now,
    updatedAt: null,
  };

  // Create owner member record
  const ownerMember: CommunityMember = {
    id: userId,
    communityId: communityRef.id,
    userId,
    role: "owner",
    displayName: userData.displayName || "Unknown",
    avatarUrl: userData.profilePicThumbUrl || userData.avatarUrl || null,
    status: "active",
    contributionBalance: 0,
    joinedAt: now,
    invitedBy: userId,
    invitedAt: now,
    lastReadAt: now,
  };

  // Create community and owner in transaction
  await db.runTransaction(async (transaction) => {
    transaction.set(communityRef, community);
    transaction.set(
      communityRef.collection(CommunityConfig.SUBCOLLECTION_MEMBERS).doc(userId),
      ownerMember
    );
  });

  // Create ledger account (uses same group:id format — ledger doesn't care about collection name)
  try {
    await getOrCreateGroupAccount(communityRef.id);
    logger.info(`Created ledger account for community ${communityRef.id}`);
  } catch (error) {
    logger.error(`Failed to create ledger account for community ${communityRef.id}:`, error);
  }

  return {
    success: true,
    communityId: communityRef.id,
    community,
  };
});

/**
 * Update community settings.
 */
export const updateCommunity = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "updateCommunity");

  const { communityId, name, description, avatarUrl, settings, stokvelSettings } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);
  const member = await requireCommunityMember(communityId, userId);
  requirePermission(member, "canEditSettings");

  // Validate updates
  if (name !== undefined) {
    if (name.trim().length === 0) {
      throw new HttpsError("invalid-argument", "Community name cannot be empty");
    }
    if (name.length > CommunityConfig.MAX_NAME_LENGTH) {
      throw new HttpsError("invalid-argument", CommunityErrorCodes.NAME_TOO_LONG);
    }
  }
  if (description !== undefined && description.length > CommunityConfig.MAX_DESCRIPTION_LENGTH) {
    throw new HttpsError("invalid-argument", CommunityErrorCodes.DESCRIPTION_TOO_LONG);
  }

  const updateData: Record<string, unknown> = {
    updatedAt: admin.firestore.Timestamp.now(),
  };

  if (name !== undefined) updateData.name = name.trim();
  if (description !== undefined) updateData.description = description.trim();
  if (avatarUrl !== undefined) updateData.avatarUrl = avatarUrl;
  if (settings) {
    updateData.settings = { ...community.settings, ...settings };
  }
  if (stokvelSettings && community.type === "stokvel") {
    updateData.stokvel = {
      ...(community.stokvel || getDefaultStokvelSettings()),
      ...stokvelSettings,
    };
  }

  await db.collection(CommunityConfig.COLLECTION).doc(communityId).update(updateData);

  return { success: true };
});

/**
 * Delete/close a community (only owner can do this).
 */
export const deleteCommunity = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "deleteCommunity");
  await requirePlayIntegrity(request.data, request, "deleteCommunity", "HIGH");

  const { communityId } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  const community = await getCommunityOrThrow(communityId);

  if (community.ownerId !== userId) {
    throw new HttpsError("permission-denied", CommunityErrorCodes.PERMISSION_DENIED);
  }

  // Check if community has balance
  const balance = await getGroupBalance(communityId);
  if (balance > 0) {
    throw new HttpsError(
      "failed-precondition",
      "Cannot delete community with remaining balance. Distribute funds first."
    );
  }

  // Mark as closed (soft-delete for audit trail)
  await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
    status: "closed",
    updatedAt: admin.firestore.Timestamp.now(),
  });

  return { success: true };
});

// ============================================================================
// MEMBERSHIP FUNCTIONS
// ============================================================================

/**
 * Invite a member to the community.
 */
export const inviteCommunityMember = onCall({ labels: { area: "social" } }, async (request) => {
  const inviterId = requireAuth(request);
  requireAppCheck(request, "inviteCommunityMember");

  const { communityId, userId, role } = request.data;

  if (!communityId || !userId) {
    throw new HttpsError("invalid-argument", "Community ID and user ID are required");
  }

  if (userId === inviterId) {
    throw new HttpsError("invalid-argument", CommunityErrorCodes.CANNOT_INVITE_SELF);
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  // Check inviter permissions
  const inviterMember = await requireCommunityMember(communityId, inviterId);

  // Check if settings allow member invites, or if inviter is admin
  if (!community.settings.allowMemberInvites && !community.adminIds.includes(inviterId)) {
    throw new HttpsError("permission-denied", "Only admins can invite members");
  }

  if (community.adminIds.includes(inviterId)) {
    // Admins can always invite
  } else {
    // Regular members can invite if settings allow
    requirePermission(inviterMember, "canManageMembers");
  }

  // Check if already a member
  const existingMember = await getCommunityMember(communityId, userId);
  if (existingMember) {
    if (existingMember.status === "blocked") {
      throw new HttpsError("failed-precondition", CommunityErrorCodes.MEMBER_BLOCKED);
    }
    throw new HttpsError("already-exists", CommunityErrorCodes.MEMBER_ALREADY_EXISTS);
  }

  // Check max members
  if (community.memberCount >= community.settings.maxMembers) {
    throw new HttpsError("resource-exhausted", CommunityErrorCodes.MAX_MEMBERS_REACHED);
  }

  // Get invitee user info
  const inviteeData = await getUserProfile(userId);
  const now = admin.firestore.Timestamp.now();

  // Validate role - can't invite as owner
  const memberRole: GroupRole = role === "owner" ? "admin" : (role || "member");

  // Create invited member record
  const memberData: CommunityMember = {
    id: userId,
    communityId,
    userId,
    role: memberRole,
    displayName: inviteeData.displayName || "Unknown",
    avatarUrl: inviteeData.profilePicThumbUrl || inviteeData.avatarUrl || null,
    status: "invited",
    contributionBalance: 0,
    joinedAt: null,
    invitedBy: inviterId,
    invitedAt: now,
    lastReadAt: null,
  };

  await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
    .doc(userId)
    .set(memberData);

  return { success: true, memberId: userId };
});

/**
 * Accept a community invitation.
 */
export const acceptCommunityInvitation = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "acceptCommunityInvitation");

  const { communityId } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  const member = await getCommunityMember(communityId, userId);
  if (!member) {
    throw new HttpsError("not-found", CommunityErrorCodes.INVITATION_NOT_FOUND);
  }
  if (member.status === "active") {
    throw new HttpsError("already-exists", CommunityErrorCodes.INVITATION_ALREADY_ACCEPTED);
  }
  if (member.status === "blocked") {
    throw new HttpsError("permission-denied", CommunityErrorCodes.MEMBER_BLOCKED);
  }

  // Check invitation hasn't expired
  const invitedAt = member.invitedAt.toDate();
  const expiresAt = new Date(invitedAt.getTime() + CommunityConfig.INVITATION_EXPIRY_DAYS * 24 * 60 * 60 * 1000);
  if (new Date() > expiresAt) {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.INVITATION_EXPIRED);
  }

  const now = admin.firestore.Timestamp.now();

  // Update member and community in transaction
  await db.runTransaction(async (transaction) => {
    const communityRef = db.collection(CommunityConfig.COLLECTION).doc(communityId);
    const memberRef = communityRef
      .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
      .doc(userId);

    transaction.update(memberRef, {
      status: "active" as GroupMemberStatus,
      joinedAt: now,
      lastReadAt: now,
    });

    // Build update data — add to adminIds if role is admin
    const updatePayload: Record<string, unknown> = {
      memberIds: admin.firestore.FieldValue.arrayUnion(userId),
      memberCount: admin.firestore.FieldValue.increment(1),
      updatedAt: now,
    };

    if (member.role === "admin" || member.role === "treasurer") {
      updatePayload.adminIds = admin.firestore.FieldValue.arrayUnion(userId);
    }

    transaction.update(communityRef, updatePayload);
  });

  // Post system message
  await postSystemMessage(communityId, `${member.displayName} joined the community`, "member_joined", { userId });

  return { success: true };
});

/**
 * Remove a member from the community.
 */
export const removeCommunityMember = onCall({ labels: { area: "social" } }, async (request) => {
  const actorId = requireAuth(request);
  requireAppCheck(request, "removeCommunityMember");

  const { communityId, memberId } = request.data;

  if (!communityId || !memberId) {
    throw new HttpsError("invalid-argument", "Community ID and member ID are required");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  // Can't remove the owner
  if (memberId === community.ownerId) {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.CANNOT_REMOVE_OWNER);
  }

  // Check permissions (must be admin or removing self)
  const actor = await getCommunityMember(communityId, actorId);
  if (!actor || actor.status !== "active") {
    throw new HttpsError("permission-denied", CommunityErrorCodes.NOT_A_MEMBER);
  }

  const isSelfRemoval = actorId === memberId;
  if (!isSelfRemoval) {
    requirePermission(actor, "canManageMembers");
  }

  // Get member being removed
  const targetMember = await getCommunityMember(communityId, memberId);
  if (!targetMember) {
    throw new HttpsError("not-found", CommunityErrorCodes.MEMBER_NOT_FOUND);
  }

  const now = admin.firestore.Timestamp.now();

  // Remove member and update community in transaction
  await db.runTransaction(async (transaction) => {
    const communityRef = db.collection(CommunityConfig.COLLECTION).doc(communityId);
    const memberRef = communityRef
      .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
      .doc(memberId);

    transaction.delete(memberRef);

    if (targetMember.status === "active") {
      const updatePayload: Record<string, unknown> = {
        memberIds: admin.firestore.FieldValue.arrayRemove(memberId),
        adminIds: admin.firestore.FieldValue.arrayRemove(memberId),
        memberCount: admin.firestore.FieldValue.increment(-1),
        updatedAt: now,
      };

      // Clean up per-user maps
      updatePayload[`unreadCounts.${memberId}`] = admin.firestore.FieldValue.delete();
      updatePayload[`muted.${memberId}`] = admin.firestore.FieldValue.delete();

      transaction.update(communityRef, updatePayload);
    }
  });

  // Post system message
  const action = isSelfRemoval ? "left" : "was removed from";
  await postSystemMessage(
    communityId,
    `${targetMember.displayName} ${action} the community`,
    isSelfRemoval ? "member_left" : "member_removed",
    { userId: memberId }
  );

  return { success: true };
});

/**
 * Update a member's role.
 */
export const updateCommunityMemberRole = onCall({ labels: { area: "social" } }, async (request) => {
  const actorId = requireAuth(request);
  requireAppCheck(request, "updateCommunityMemberRole");

  const { communityId, memberId, role } = request.data;

  if (!communityId || !memberId || !role) {
    throw new HttpsError("invalid-argument", "Community ID, member ID, and role are required");
  }

  const validRoles: GroupRole[] = ["admin", "treasurer", "member", "viewer"];
  if (!validRoles.includes(role)) {
    throw new HttpsError("invalid-argument", "Invalid role");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  if (actorId === memberId) {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.CANNOT_CHANGE_OWN_ROLE);
  }

  if (memberId === community.ownerId) {
    throw new HttpsError("failed-precondition", "Cannot change owner's role");
  }

  const actor = await requireCommunityMember(communityId, actorId);
  requirePermission(actor, "canManageMembers");

  // Only owner can make admins
  if (role === "admin" && actor.role !== "owner") {
    throw new HttpsError("permission-denied", "Only owner can assign admin role");
  }

  const targetMember = await getCommunityMember(communityId, memberId);
  if (!targetMember || targetMember.status !== "active") {
    throw new HttpsError("not-found", CommunityErrorCodes.MEMBER_NOT_FOUND);
  }

  const wasAdmin = targetMember.role === "admin" || targetMember.role === "treasurer";
  const isNowAdmin = role === "admin" || role === "treasurer";

  // Update role in member subcollection
  await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
    .doc(memberId)
    .update({ role });

  // Update adminIds on community doc if role change affects admin status
  if (!wasAdmin && isNowAdmin) {
    await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
      adminIds: admin.firestore.FieldValue.arrayUnion(memberId),
      updatedAt: admin.firestore.Timestamp.now(),
    });
  } else if (wasAdmin && !isNowAdmin) {
    await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
      adminIds: admin.firestore.FieldValue.arrayRemove(memberId),
      updatedAt: admin.firestore.Timestamp.now(),
    });
  }

  return { success: true };
});

/**
 * Leave a community.
 */
export const leaveCommunity = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "leaveCommunity");

  const { communityId } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  const community = await getCommunityOrThrow(communityId);

  if (userId === community.ownerId) {
    throw new HttpsError(
      "failed-precondition",
      "Owner cannot leave. Transfer ownership or delete the community."
    );
  }

  // Reuse removeMember logic — call the wrapped handler directly
  return removeCommunityMember.run({ data: { communityId, memberId: userId }, auth: request.auth } as any);
});

// ============================================================================
// COMMUNITY MESSAGING
// ============================================================================

/**
 * Helper: post a system message to a community.
 */
async function postSystemMessage(
  communityId: string,
  text: string,
  eventType: string,
  eventData: Record<string, unknown> = {}
): Promise<void> {
  const msgRef = db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MESSAGES)
    .doc();

  await msgRef.set({
    id: msgRef.id,
    communityId,
    senderId: "system",
    senderName: "System",
    senderAvatarUrl: null,
    type: "system",
    status: "sent",
    textContent: text,
    media: null,
    reactions: {},
    replyTo: null,
    systemEventType: eventType,
    systemEventData: eventData,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    deletedFor: [],
    deletedForEveryone: false,
  });

  // Update lastMessage on community
  await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
    lastMessage: {
      text: truncate(text, 100),
      senderId: "system",
      senderName: "System",
      type: "system",
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    },
    lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
  });
}

/**
 * Send a message in a community chat.
 */
export const sendCommunityMessage = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "sendCommunityMessage");

  const { communityId, text, mediaUrl, mediaType, replyToMessageId, ciphertext, e2ee, encryptedPreviews } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }
  if (!text && !mediaUrl && !ciphertext) {
    throw new HttpsError("invalid-argument", "Message text, media, or ciphertext is required");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);
  const member = await requireCommunityMember(communityId, userId);

  // Check onlyAdminsPost setting
  if (community.settings.onlyAdminsPost && !community.adminIds.includes(userId)) {
    throw new HttpsError("permission-denied", CommunityErrorCodes.ONLY_ADMINS_CAN_POST);
  }

  // Check media sharing permission
  if (mediaUrl && !community.settings.membersCanShareMedia && !community.adminIds.includes(userId)) {
    throw new HttpsError("permission-denied", "Media sharing is disabled for members");
  }

  // Build reply context if replying
  let replyTo = null;
  if (replyToMessageId) {
    const replyDoc = await db
      .collection(CommunityConfig.COLLECTION)
      .doc(communityId)
      .collection(CommunityConfig.SUBCOLLECTION_MESSAGES)
      .doc(replyToMessageId)
      .get();

    if (replyDoc.exists) {
      const replyData = replyDoc.data()!;
      replyTo = {
        messageId: replyToMessageId,
        senderName: replyData.senderName || "Unknown",
        text: truncate(replyData.textContent || "[Media]", 50),
        type: replyData.type || "text",
      };
    }
  }

  const messageType = mediaUrl ? (mediaType === "audio/m4a" || mediaType === "audio/aac" ? "voice" : "image") : "text";

  // Write message to subcollection
  const msgRef = db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MESSAGES)
    .doc();

  const message = {
    id: msgRef.id,
    communityId,
    senderId: userId,
    senderName: member.displayName,
    senderAvatarUrl: member.avatarUrl || null,
    type: messageType,
    status: "sent",
    textContent: ciphertext ? null : (text || null),
    ciphertext: ciphertext || null,
    e2ee: e2ee || null,
    media: mediaUrl ? {
      url: mediaUrl,
      thumbnailUrl: null,
      fileName: `${messageType}_${Date.now()}`,
      fileSize: 0,
      mimeType: mediaType || "application/octet-stream",
      duration: null,
      width: null,
      height: null,
    } : null,
    reactions: {},
    replyTo,
    systemEventType: null,
    systemEventData: null,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    deletedFor: [],
    deletedForEveryone: false,
  };

  // Build unread count increments for all OTHER members
  const unreadUpdates: Record<string, unknown> = {};
  for (const memberId of community.memberIds) {
    if (memberId !== userId) {
      unreadUpdates[`unreadCounts.${memberId}`] = admin.firestore.FieldValue.increment(1);
    }
  }

  const previewText = ciphertext ? null : truncate(text || "[Media]", 100);

  // Batch write message + update community
  const batch = db.batch();
  batch.set(msgRef, message);
  batch.update(db.collection(CommunityConfig.COLLECTION).doc(communityId), {
    lastMessage: {
      text: previewText,
      senderId: userId,
      senderName: member.displayName,
      type: messageType,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    },
    lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
    ...unreadUpdates,
    ...(encryptedPreviews ? { lastMessageEncryptedPreviews: encryptedPreviews } : {}),
  });
  await batch.commit();

  return { success: true, messageId: msgRef.id };
});

/**
 * Mark community as read for the current user.
 */
export const markCommunityRead = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "markCommunityRead");

  const { communityId } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  await requireCommunityMember(communityId, userId);

  // Reset unread count and update lastReadAt on member doc
  const batch = db.batch();

  batch.update(db.collection(CommunityConfig.COLLECTION).doc(communityId), {
    [`unreadCounts.${userId}`]: 0,
  });

  batch.update(
    db.collection(CommunityConfig.COLLECTION)
      .doc(communityId)
      .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
      .doc(userId),
    { lastReadAt: admin.firestore.FieldValue.serverTimestamp() }
  );

  await batch.commit();

  return { success: true };
});

/**
 * Toggle a reaction on a community message.
 */
export const toggleCommunityMessageReaction = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "toggleCommunityMessageReaction");

  const { communityId, messageId, emoji } = request.data;

  if (!communityId || !messageId || !emoji) {
    throw new HttpsError("invalid-argument", "Community ID, message ID, and emoji are required");
  }

  await requireCommunityMember(communityId, userId);

  const msgRef = db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MESSAGES)
    .doc(messageId);

  const msgDoc = await msgRef.get();
  if (!msgDoc.exists) {
    throw new HttpsError("not-found", "Message not found");
  }

  const reactions = msgDoc.data()?.reactions || {};
  const emojiReactions: string[] = reactions[emoji] || [];

  if (emojiReactions.includes(userId)) {
    // Remove reaction
    await msgRef.update({
      [`reactions.${emoji}`]: admin.firestore.FieldValue.arrayRemove(userId),
    });
  } else {
    // Add reaction
    await msgRef.update({
      [`reactions.${emoji}`]: admin.firestore.FieldValue.arrayUnion(userId),
    });
  }

  return { success: true };
});

/**
 * Mute/unmute a community.
 */
export const toggleCommunityMute = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "toggleCommunityMute");

  const { communityId, muted } = request.data;

  if (!communityId || muted === undefined) {
    throw new HttpsError("invalid-argument", "Community ID and muted flag are required");
  }

  await requireCommunityMember(communityId, userId);

  await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
    [`muted.${userId}`]: muted === true,
  });

  return { success: true };
});

// ============================================================================
// FINANCIAL OPERATIONS
// ============================================================================

/**
 * Contribute tokens to a community.
 */
export const contributeToCommunity = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "contributeToCommunity");
  await requirePlayIntegrity(request.data, request, "contributeToCommunity", "HIGH");

  const { communityId, amount, description } = request.data;

  if (!communityId || !amount) {
    throw new HttpsError("invalid-argument", "Community ID and amount are required");
  }

  if (amount <= 0) {
    throw new HttpsError("invalid-argument", "Amount must be positive");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  if (!community.settings.enableFinancials) {
    throw new HttpsError("failed-precondition", "Financials are not enabled for this community");
  }

  const member = await requireCommunityMember(communityId, userId);
  requirePermission(member, "canTransferFunds");

  const now = admin.firestore.Timestamp.now();

  // Create transaction record
  const transactionRef = db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc();

  const transactionData: GroupTransaction = {
    id: transactionRef.id,
    groupId: communityId,
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

  // Process through the ledger
  try {
    const result = await processGroupContribution(
      communityId,
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
      .collection(CommunityConfig.COLLECTION)
      .doc(communityId)
      .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
      .doc(userId)
      .update({
        contributionBalance: admin.firestore.FieldValue.increment(amount),
      });

    // Update community total balance
    await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
      totalBalance: admin.firestore.FieldValue.increment(amount),
      updatedAt: admin.firestore.Timestamp.now(),
    });

    // Post system message
    await postSystemMessage(
      communityId,
      `${member.displayName} contributed R${(amount / 100).toFixed(2)}`,
      "contribution",
      { userId, amount, transactionId: transactionRef.id }
    );

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
 * Withdraw tokens from a community.
 */
export const withdrawFromCommunity = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "withdrawFromCommunity");
  await requirePlayIntegrity(request.data, request, "withdrawFromCommunity", "HIGH");

  const { communityId, amount, description } = request.data;

  if (!communityId || !amount) {
    throw new HttpsError("invalid-argument", "Community ID and amount are required");
  }

  if (amount <= 0) {
    throw new HttpsError("invalid-argument", "Amount must be positive");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  if (!community.settings.enableFinancials) {
    throw new HttpsError("failed-precondition", "Financials are not enabled for this community");
  }

  if (!community.settings.allowMemberWithdrawals) {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.WITHDRAWALS_NOT_ALLOWED);
  }

  const member = await requireCommunityMember(communityId, userId);
  requirePermission(member, "canTransferFunds");

  // Check community has sufficient balance
  const communityBalance = await getGroupBalance(communityId);
  if (communityBalance < amount) {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.AMOUNT_EXCEEDS_BALANCE);
  }

  const now = admin.firestore.Timestamp.now();
  const perms = getMemberPermissions(member);

  // Check if approval is needed
  const needsApproval = amount > perms.maxTransferWithoutApproval &&
    amount > community.settings.requireApprovalAbove;

  // Create transaction record
  const transactionRef = db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc();

  const transactionData: GroupTransaction = {
    id: transactionRef.id,
    groupId: communityId,
    journalId: null,
    type: "withdrawal",
    amount,
    fromMemberId: null,
    toMemberId: userId,
    description: description || "Withdrawal",
    status: "pending",
    approvedBy: null,
    createdBy: userId,
    createdAt: now,
    completedAt: null,
  };

  await transactionRef.set(transactionData);

  if (needsApproval) {
    // Create pending approval
    const approvalRef = db
      .collection(CommunityConfig.COLLECTION)
      .doc(communityId)
      .collection(CommunityConfig.SUBCOLLECTION_APPROVALS)
      .doc();

    // Get list of approvers (admins, treasurers, owner)
    const approversSnap = await db
      .collection(CommunityConfig.COLLECTION)
      .doc(communityId)
      .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
      .where("status", "==", "active")
      .where("role", "in", ["owner", "admin", "treasurer"])
      .get();

    const requiredApprovers = approversSnap.docs
      .map((d) => d.id)
      .filter((id) => id !== userId);

    const expiresAt = new Date(now.toDate().getTime() + CommunityConfig.APPROVAL_EXPIRY_HOURS * 60 * 60 * 1000);

    const approvalData: PendingApproval = {
      id: approvalRef.id,
      groupId: communityId,
      transactionId: transactionRef.id,
      requiredApprovers,
      approvers: [],
      rejectedBy: null,
      status: "pending",
      createdAt: now,
      expiresAt: admin.firestore.Timestamp.fromDate(expiresAt),
    };

    await approvalRef.set(approvalData);

    // Post system message about pending withdrawal
    await postSystemMessage(
      communityId,
      `${member.displayName} requested a withdrawal of R${(amount / 100).toFixed(2)} (awaiting approval)`,
      "withdrawal_requested",
      { userId, amount, transactionId: transactionRef.id, approvalId: approvalRef.id }
    );

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
      communityId,
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

    // Update community total balance
    await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
      totalBalance: admin.firestore.FieldValue.increment(-amount),
      updatedAt: admin.firestore.Timestamp.now(),
    });

    // Post system message
    await postSystemMessage(
      communityId,
      `${member.displayName} withdrew R${(amount / 100).toFixed(2)}`,
      "withdrawal_completed",
      { userId, amount, transactionId: transactionRef.id }
    );

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
 * Approve a pending community transaction.
 */
export const approveCommunityTransaction = onCall({ labels: { area: "social" } }, async (request) => {
  const approverId = requireAuth(request);
  requireAppCheck(request, "approveCommunityTransaction");

  const { communityId, transactionId } = request.data;

  if (!communityId || !transactionId) {
    throw new HttpsError("invalid-argument", "Community ID and transaction ID are required");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  const member = await requireCommunityMember(communityId, approverId);
  requirePermission(member, "canApproveFunds", CommunityErrorCodes.NOT_AUTHORIZED_TO_APPROVE);

  // Get transaction
  const transactionDoc = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc(transactionId)
    .get();

  if (!transactionDoc.exists) {
    throw new HttpsError("not-found", CommunityErrorCodes.TRANSACTION_NOT_FOUND);
  }

  const transaction = transactionDoc.data() as GroupTransaction;

  if (transaction.status === "completed") {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.TRANSACTION_ALREADY_APPROVED);
  }
  if (transaction.status === "rejected") {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.TRANSACTION_ALREADY_REJECTED);
  }

  // Get pending approval
  const approvalsSnap = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_APPROVALS)
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
    throw new HttpsError("failed-precondition", CommunityErrorCodes.TRANSACTION_EXPIRED);
  }

  // Check approver is authorized
  if (!approval.requiredApprovers.includes(approverId)) {
    throw new HttpsError("permission-denied", CommunityErrorCodes.NOT_AUTHORIZED_TO_APPROVE);
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
      communityId,
      transaction.toMemberId!,
      transaction.amount,
      transactionId
    );
  } else if (transaction.type === "payout") {
    result = await processGroupPayout(communityId, [
      { memberId: transaction.toMemberId!, amount: transaction.amount },
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

  // Update community balance
  if (transaction.type === "withdrawal" || transaction.type === "payout") {
    await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
      totalBalance: admin.firestore.FieldValue.increment(-transaction.amount),
      updatedAt: admin.firestore.Timestamp.now(),
    });
  }

  // Post system message
  await postSystemMessage(
    communityId,
    `Withdrawal of R${(transaction.amount / 100).toFixed(2)} was approved`,
    "transaction_approved",
    { transactionId, approverId, amount: transaction.amount }
  );

  return {
    success: true,
    journalId: result.journalId,
  };
});

/**
 * Reject a pending community transaction.
 */
export const rejectCommunityTransaction = onCall({ labels: { area: "social" } }, async (request) => {
  const rejecterId = requireAuth(request);
  requireAppCheck(request, "rejectCommunityTransaction");

  const { communityId, transactionId, reason } = request.data;

  if (!communityId || !transactionId) {
    throw new HttpsError("invalid-argument", "Community ID and transaction ID are required");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  const member = await requireCommunityMember(communityId, rejecterId);
  requirePermission(member, "canApproveFunds", CommunityErrorCodes.NOT_AUTHORIZED_TO_APPROVE);

  // Get transaction
  const transactionDoc = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc(transactionId)
    .get();

  if (!transactionDoc.exists) {
    throw new HttpsError("not-found", CommunityErrorCodes.TRANSACTION_NOT_FOUND);
  }

  const transaction = transactionDoc.data() as GroupTransaction;

  if (transaction.status === "completed") {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.TRANSACTION_ALREADY_APPROVED);
  }
  if (transaction.status === "rejected") {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.TRANSACTION_ALREADY_REJECTED);
  }

  // Update approval and transaction
  const approvalsSnap = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_APPROVALS)
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

  // Post system message
  await postSystemMessage(
    communityId,
    `Withdrawal request of R${(transaction.amount / 100).toFixed(2)} was rejected${reason ? `: ${reason}` : ""}`,
    "transaction_rejected",
    { transactionId, rejecterId, amount: transaction.amount, reason: reason || null }
  );

  return { success: true };
});

// ============================================================================
// QUERY FUNCTIONS
// ============================================================================

/**
 * Get all communities for the current user.
 */
export const getUserCommunities = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "getUserCommunities");

  const communitiesSnap = await db
    .collection(CommunityConfig.COLLECTION)
    .where("memberIds", "array-contains", userId)
    .where("status", "!=", "closed")
    .orderBy("status")
    .orderBy("lastMessageAt", "desc")
    .limit(100)
    .get();

  const communities = communitiesSnap.docs.map((doc) => ({ id: doc.id, ...doc.data() }));

  return { success: true, communities };
});

/**
 * Get community details with members.
 */
export const getCommunityDetails = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "getCommunityDetails");

  const { communityId } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  const community = await getCommunityOrThrow(communityId);
  await requireCommunityMember(communityId, userId);

  // Get members
  const membersSnap = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
    .orderBy("role")
    .limit(200)
    .get();

  const members = membersSnap.docs.map((doc) => doc.data());

  // Get current balance from ledger
  const balance = await getGroupBalance(communityId);

  return {
    success: true,
    community: { ...community, totalBalance: balance },
    members,
  };
});

/**
 * Get community transactions.
 */
export const getCommunityTransactions = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "getCommunityTransactions");

  const { communityId, limit = 50 } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  await getCommunityOrThrow(communityId);
  const member = await requireCommunityMember(communityId, userId);
  requirePermission(member, "canViewLedger");

  const transactionsSnap = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
    .orderBy("createdAt", "desc")
    .limit(Math.min(limit, 100))
    .get();

  const transactions = transactionsSnap.docs.map((doc) => doc.data());

  return { success: true, transactions };
});

/**
 * Get pending approvals for a community.
 */
export const getCommunityPendingApprovals = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "getCommunityPendingApprovals");

  const { communityId } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  await getCommunityOrThrow(communityId);
  const member = await requireCommunityMember(communityId, userId);
  requirePermission(member, "canApproveFunds");

  const approvalsSnap = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_APPROVALS)
    .where("status", "==", "pending")
    .orderBy("createdAt", "desc")
    .limit(100)
    .get();

  const approvals = approvalsSnap.docs.map((doc) => doc.data());

  // Get related transactions in parallel (was serial N+1)
  const transactionIds = approvals.map((a) => (a as PendingApproval).transactionId);
  const transactions: Record<string, unknown> = {};
  const txResults = await Promise.all(
    transactionIds.map((txId) =>
      db
        .collection(CommunityConfig.COLLECTION)
        .doc(communityId)
        .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
        .doc(txId)
        .get()
    )
  );
  for (const txDoc of txResults) {
    if (txDoc.exists) {
      transactions[txDoc.id] = txDoc.data();
    }
  }

  return { success: true, approvals, transactions };
});

// ============================================================================
// STOKVEL-SPECIFIC SCHEDULED FUNCTIONS
// ============================================================================

/**
 * Send contribution reminders for community stokvels.
 * Runs every Monday at 9 AM South Africa time.
 */
export const sendCommunityContributionReminders = onSchedule(
  { schedule: "0 9 * * 1", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "social" } },
  async () => {
    logger.info("Running community contribution reminders...");

    const stokvelsSnap = await db
      .collection(CommunityConfig.COLLECTION)
      .where("type", "==", "stokvel")
      .where("status", "==", "active")
      .get();

    logger.info(`Found ${stokvelsSnap.docs.length} stokvel communities to process`);

    const now = new Date();
    const dayOfMonth = now.getDate();
    const isFirstWeekOfMonth = dayOfMonth <= 7;

    for (const stokvelDoc of stokvelsSnap.docs) {
      const stokvel = stokvelDoc.data() as Community;
      const settings = stokvel.settings;

      // For monthly contributions, only remind in first week
      if (settings.contributionCycle === "monthly" && !isFirstWeekOfMonth) {
        continue;
      }

      // Skip non-cycle communities
      if (settings.contributionCycle === "none") {
        continue;
      }

      // Get active members
      const membersSnap = await stokvelDoc.ref
        .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
        .where("status", "==", "active")
        .limit(50)
        .get();

      // Create notifications
      const batch = db.batch();
      const notificationTime = admin.firestore.Timestamp.now();

      for (const memberDoc of membersSnap.docs) {
        const memberData = memberDoc.data() as CommunityMember;
        const notificationRef = db.collection("notifications").doc();
        batch.set(notificationRef, {
          id: notificationRef.id,
          userId: memberData.userId,
          type: "stokvel_contribution_reminder",
          title: `${stokvel.name} - Contribution Reminder`,
          body: `Your ${settings.contributionCycle} contribution of R${(settings.contributionAmount / 100).toFixed(2)} is due.`,
          data: {
            communityId: stokvel.id,
            communityName: stokvel.name,
            amount: settings.contributionAmount,
          },
          read: false,
          createdAt: notificationTime,
        });
      }

      await batch.commit();
      logger.info(`Sent reminders to ${membersSnap.docs.length} members of ${stokvel.name}`);
    }

    logger.info("Community contribution reminders completed");
  }
);

/**
 * Calculate and apply stokvel penalties for missed contributions.
 * Runs on the 1st of every month at midnight South Africa time.
 */
export const calculateCommunityPenalties = onSchedule(
  { schedule: "0 0 1 * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "social" } },
  async () => {
    logger.info("Running community penalty calculations...");

    const stokvelsSnap = await db
      .collection(CommunityConfig.COLLECTION)
      .where("type", "==", "stokvel")
      .where("status", "==", "active")
      .get();

    logger.info(`Found ${stokvelsSnap.docs.length} stokvel communities to process`);

    const now = admin.firestore.Timestamp.now();
    const lastMonth = new Date();
    lastMonth.setMonth(lastMonth.getMonth() - 1);
    const lastMonthStart = new Date(lastMonth.getFullYear(), lastMonth.getMonth(), 1);
    const lastMonthEnd = new Date(lastMonth.getFullYear(), lastMonth.getMonth() + 1, 0, 23, 59, 59);

    for (const stokvelDoc of stokvelsSnap.docs) {
      const stokvel = stokvelDoc.data() as Community;
      const settings = stokvel.settings;

      if (!settings.penaltyPercentage || settings.penaltyPercentage <= 0) continue;
      if (!settings.contributionAmount || settings.contributionAmount <= 0) continue;

      // Get active members
      const membersSnap = await stokvelDoc.ref
        .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
        .where("status", "==", "active")
        .limit(50)
        .get();

      // Get contributions from last month
      const contributionsSnap = await stokvelDoc.ref
        .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
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
        const memberData = memberDoc.data() as CommunityMember;
        const contributed = memberContributions[memberData.userId] || 0;

        if (contributed >= settings.contributionAmount) continue;

        const shortfall = settings.contributionAmount - contributed;
        const penaltyAmount = Math.round(shortfall * (settings.penaltyPercentage / 100));

        if (penaltyAmount <= 0) continue;

        logger.info(`Applying penalty of ${penaltyAmount} to ${memberData.userId} in ${stokvel.name}`);

        const dateStr = `${lastMonth.getFullYear()}-${String(lastMonth.getMonth() + 1).padStart(2, "0")}`;

        try {
          // Ledger call must remain sequential
          const result = await processGroupPenalty(
            stokvel.id,
            memberData.userId,
            penaltyAmount,
            `Missed contribution for ${dateStr} (shortfall: R${(shortfall / 100).toFixed(2)})`,
            dateStr
          );

          if (result.success) {
            // Batch the Firestore writes instead of individual awaits
            const txRef = stokvelDoc.ref.collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS).doc();
            penaltyBatch.set(txRef, {
              id: txRef.id,
              groupId: stokvel.id,
              journalId: result.journalId,
              type: "penalty",
              amount: penaltyAmount,
              fromMemberId: memberData.userId,
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
              userId: memberData.userId,
              type: "stokvel_penalty",
              title: `${stokvel.name} - Penalty Applied`,
              body: `A penalty of R${(penaltyAmount / 100).toFixed(2)} was applied for missing your ${dateStr} contribution.`,
              data: {
                communityId: stokvel.id,
                communityName: stokvel.name,
                amount: penaltyAmount,
              },
              read: false,
              createdAt: now,
            });

            totalPenaltyAmount += penaltyAmount;
            penaltyBatchCount += 2;

            // Post system message (writes its own docs, keep sequential)
            await postSystemMessage(
              stokvel.id,
              `Penalty of R${(penaltyAmount / 100).toFixed(2)} applied to ${memberData.displayName} for missed ${dateStr} contribution`,
              "penalty_applied",
              { userId: memberData.userId, amount: penaltyAmount, dateStr }
            );
          } else {
            logger.error(`Failed to apply penalty: ${result.error}`);
          }
        } catch (error) {
          logger.error(`Error applying penalty to ${memberData.userId}:`, error);
        }
      }

      // Commit all penalty Firestore writes for this stokvel in one batch
      if (penaltyBatchCount > 0) {
        // Update community balance once for all penalties
        penaltyBatch.update(stokvelDoc.ref, {
          totalBalance: admin.firestore.FieldValue.increment(totalPenaltyAmount),
          updatedAt: now,
        });
        await penaltyBatch.commit();
      }
    }

    logger.info("Community penalty calculations completed");
  }
);

/**
 * Process community stokvel payouts according to schedule.
 * Runs on the 1st of every month at 10 AM South Africa time.
 */
export const processCommunityPayouts = onSchedule(
  { schedule: "0 10 1 * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "social" } },
  async () => {
    logger.info("Running community payout processing...");

    const now = admin.firestore.Timestamp.now();
    const today = new Date();

    const stokvelsSnap = await db
      .collection(CommunityConfig.COLLECTION)
      .where("type", "==", "stokvel")
      .where("status", "==", "active")
      .get();

    logger.info(`Found ${stokvelsSnap.docs.length} stokvel communities to check for payouts`);

    for (const stokvelDoc of stokvelsSnap.docs) {
      const stokvel = stokvelDoc.data() as Community;
      const stokvelSettings = stokvel.stokvel;

      if (!stokvelSettings) continue;

      // Check if payout is due
      const nextPayoutDate = stokvelSettings.nextPayoutDate?.toDate();
      if (nextPayoutDate && nextPayoutDate > today) continue;

      // Get community balance
      const balance = await getGroupBalance(stokvel.id);
      if (balance <= 0) {
        logger.info(`${stokvel.name}: No balance to pay out`);
        continue;
      }

      // Get active members
      const membersSnap = await stokvelDoc.ref
        .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
        .where("status", "==", "active")
        .limit(50)
        .get();

      if (membersSnap.empty) continue;

      const members = membersSnap.docs.map((d) => d.data() as CommunityMember);
      let recipientId: string | null = null;
      let payoutAmount = 0;

      switch (stokvelSettings.payoutType) {
        case "rotating": {
          const payoutOrder = stokvelSettings.payoutOrder || members.map((m) => m.userId);
          const currentRecipient = stokvelSettings.currentPayoutRecipient;
          const currentIndex = currentRecipient ? payoutOrder.indexOf(currentRecipient) : -1;
          const nextIndex = (currentIndex + 1) % payoutOrder.length;
          recipientId = payoutOrder[nextIndex];
          payoutAmount = balance;
          break;
        }
        case "lottery": {
          const memberIds = members.map((m) => m.userId);
          recipientId = memberIds[Math.floor(Math.random() * memberIds.length)];
          payoutAmount = balance;
          break;
        }
        case "fixed_date": {
          payoutAmount = Math.floor(balance / members.length);
          break;
        }
        case "goal_reached": {
          continue;
        }
      }

      if (stokvelSettings.payoutType === "fixed_date" && payoutAmount > 0) {
        // Pay all members equally
        const payouts = members.map((m) => ({
          memberId: m.userId,
          amount: payoutAmount,
        }));

        const transactionRef = stokvelDoc.ref.collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS).doc();

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
            for (const m of members) {
              const notificationRef = db.collection("notifications").doc();
              payoutBatch.set(notificationRef, {
                id: notificationRef.id,
                userId: m.userId,
                type: "stokvel_payout",
                title: `${stokvel.name} - Payout Received`,
                body: `You received R${(payoutAmount / 100).toFixed(2)} from the monthly payout.`,
                data: { communityId: stokvel.id, communityName: stokvel.name, amount: payoutAmount },
                read: false,
                createdAt: now,
              });
            }
            await payoutBatch.commit();

            // Post system message (writes its own docs, keep sequential)
            await postSystemMessage(
              stokvel.id,
              `Monthly payout of R${(payoutAmount / 100).toFixed(2)} sent to ${members.length} members`,
              "payout_completed",
              { amount: payoutAmount, recipientCount: members.length }
            );
          }
        } catch (error) {
          logger.error(`Error processing fixed_date payout for ${stokvel.name}:`, error);
        }
      } else if (recipientId && payoutAmount > 0) {
        // Single recipient payout
        const transactionRef = stokvelDoc.ref.collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS).doc();

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
              "stokvel.currentPayoutRecipient": recipientId,
              "stokvel.nextPayoutDate": admin.firestore.Timestamp.fromDate(nextMonth),
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
              data: { communityId: stokvel.id, communityName: stokvel.name, amount: payoutAmount },
              read: false,
              createdAt: now,
            });

            // Notify other members
            const otherMembers = members.filter((m) => m.userId !== recipientId);
            for (const m of otherMembers) {
              const otherNotifRef = db.collection("notifications").doc();
              payoutBatch.set(otherNotifRef, {
                id: otherNotifRef.id,
                userId: m.userId,
                type: "stokvel_payout_notification",
                title: `${stokvel.name} - Payout Completed`,
                body: `This month's payout of R${(payoutAmount / 100).toFixed(2)} went to a fellow member.`,
                data: { communityId: stokvel.id, communityName: stokvel.name, amount: payoutAmount },
                read: false,
                createdAt: now,
              });
            }
            await payoutBatch.commit();

            // Post system message (writes its own docs, keep sequential)
            const recipientMember = members.find((m) => m.userId === recipientId);
            await postSystemMessage(
              stokvel.id,
              `${stokvelSettings.payoutType === "rotating" ? "Rotating" : "Lottery"} payout of R${(payoutAmount / 100).toFixed(2)} sent to ${recipientMember?.displayName || "member"}`,
              "payout_completed",
              { amount: payoutAmount, recipientId }
            );

            logger.info(`Processed payout of ${payoutAmount} to ${recipientId} for ${stokvel.name}`);
          }
        } catch (error) {
          logger.error(`Error processing payout for ${stokvel.name}:`, error);
        }
      }
    }

    logger.info("Community payout processing completed");
  }
);

/**
 * Manually trigger a community stokvel payout.
 */
export const triggerCommunityPayout = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "triggerCommunityPayout");
  await requirePlayIntegrity(request.data, request, "triggerCommunityPayout", "HIGH");

  const { communityId, recipientId } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  const community = await getCommunityOrThrow(communityId);
  requireActiveCommunity(community);

  if (community.type !== "stokvel") {
    throw new HttpsError("failed-precondition", "This function is only for stokvel communities");
  }

  const member = await requireCommunityMember(communityId, userId);
  if (member.role !== "owner" && member.role !== "admin") {
    throw new HttpsError("permission-denied", "Only owner or admin can trigger payouts");
  }

  const balance = await getGroupBalance(communityId);
  if (balance <= 0) {
    throw new HttpsError("failed-precondition", "No balance available for payout");
  }

  // Determine recipient
  let finalRecipientId = recipientId;
  const stokvelSettings = community.stokvel;

  if (!finalRecipientId && stokvelSettings) {
    const membersSnap = await db
      .collection(CommunityConfig.COLLECTION)
      .doc(communityId)
      .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
      .where("status", "==", "active")
      .get();

    const members = membersSnap.docs.map((d) => d.data() as CommunityMember);

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
  const recipientMember = await getCommunityMember(communityId, finalRecipientId);
  if (!recipientMember || recipientMember.status !== "active") {
    throw new HttpsError("not-found", "Recipient is not an active member");
  }

  const now = admin.firestore.Timestamp.now();
  const transactionRef = db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
    .doc();

  try {
    const result = await processGroupPayout(
      communityId,
      [{ memberId: finalRecipientId, amount: balance }],
      transactionRef.id
    );

    if (!result.success) {
      throw new HttpsError("internal", result.error || "Failed to process payout");
    }

    await transactionRef.set({
      id: transactionRef.id,
      groupId: communityId,
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

    await db.collection(CommunityConfig.COLLECTION).doc(communityId).update({
      totalBalance: admin.firestore.FieldValue.increment(-balance),
      "stokvel.currentPayoutRecipient": finalRecipientId,
      "stokvel.nextPayoutDate": admin.firestore.Timestamp.fromDate(nextMonth),
      updatedAt: now,
    });

    // Post system message
    await postSystemMessage(
      communityId,
      `Payout of R${(balance / 100).toFixed(2)} sent to ${recipientMember.displayName}`,
      "payout_completed",
      { amount: balance, recipientId: finalRecipientId, triggeredBy: userId }
    );

    // Notify recipient
    const notificationRef = db.collection("notifications").doc();
    await notificationRef.set({
      id: notificationRef.id,
      userId: finalRecipientId,
      type: "stokvel_payout",
      title: `${community.name} - Payout Received`,
      body: `You received a payout of R${(balance / 100).toFixed(2)}!`,
      data: { communityId, communityName: community.name, amount: balance },
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
 * Get stokvel analytics for a community.
 */
export const getCommunityAnalytics = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "getCommunityAnalytics");

  const { communityId, months = 6 } = request.data;

  if (!communityId) {
    throw new HttpsError("invalid-argument", "Community ID is required");
  }

  const community = await getCommunityOrThrow(communityId);
  if (community.type !== "stokvel") {
    throw new HttpsError("failed-precondition", "Analytics are only for stokvel communities");
  }

  const member = await requireCommunityMember(communityId, userId);
  requirePermission(member, "canViewLedger");

  // Calculate date range
  const endDate = new Date();
  const startDate = new Date();
  startDate.setMonth(startDate.getMonth() - months);

  // Get all completed transactions in range
  const transactionsSnap = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_TRANSACTIONS)
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
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
    .where("status", "==", "active")
    .select("userId", "displayName", "avatarUrl")
    .limit(500)
    .get();

  const memberInfo: Record<string, { displayName: string; avatarUrl: string | null }> = {};
  for (const memberDoc of membersSnap.docs) {
    const m = memberDoc.data() as CommunityMember;
    memberInfo[m.userId] = { displayName: m.displayName, avatarUrl: m.avatarUrl };
  }

  return {
    success: true,
    analytics,
    memberInfo,
    stokvelSettings: community.stokvel,
    currentBalance: await getGroupBalance(communityId),
  };
});
