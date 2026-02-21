/**
 * Community Helper Functions
 *
 * Shared utility functions for community Cloud Functions.
 * Extracted from the groups.ts helper pattern, adapted for the
 * communities collection.
 *
 * Reuses Group types from ledger/types.ts since communities use
 * the same role/permission system as groups.
 */

import { HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import {
  GroupRole,
  GroupMemberStatus,
  GroupPermissions,
  GroupRolePermissions,
  GroupSettings,
  StokvelSettings,
} from "../ledger/types";

const db = admin.firestore();

// ============================================================================
// COMMUNITY CONSTANTS
// ============================================================================

export const CommunityConfig = {
  // Collection paths
  COLLECTION: "communities",
  SUBCOLLECTION_MEMBERS: "members",
  SUBCOLLECTION_MESSAGES: "messages",
  SUBCOLLECTION_TRANSACTIONS: "transactions",
  SUBCOLLECTION_APPROVALS: "pendingApprovals",

  // Default settings
  DEFAULT_APPROVAL_THRESHOLD: 5000,
  DEFAULT_PENALTY_PERCENTAGE: 5,
  DEFAULT_CONTRIBUTION_AMOUNT: 1000,

  // Limits
  MAX_NAME_LENGTH: 50,
  MAX_DESCRIPTION_LENGTH: 200,
  MAX_MEMBERS: 100,
  MIN_MEMBERS_FOR_STOKVEL: 3,

  // Expiration
  APPROVAL_EXPIRY_HOURS: 72,
  INVITATION_EXPIRY_DAYS: 7,
} as const;

export const CommunityErrorCodes = {
  // Community errors
  NOT_FOUND: "COMMUNITY_NOT_FOUND",
  SUSPENDED: "COMMUNITY_SUSPENDED",
  CLOSED: "COMMUNITY_CLOSED",
  NAME_TOO_LONG: "COMMUNITY_NAME_TOO_LONG",
  DESCRIPTION_TOO_LONG: "COMMUNITY_DESCRIPTION_TOO_LONG",

  // Member errors
  MEMBER_NOT_FOUND: "COMMUNITY_MEMBER_NOT_FOUND",
  MEMBER_ALREADY_EXISTS: "COMMUNITY_MEMBER_ALREADY_EXISTS",
  MEMBER_BLOCKED: "COMMUNITY_MEMBER_BLOCKED",
  NOT_A_MEMBER: "COMMUNITY_NOT_A_MEMBER",
  CANNOT_REMOVE_OWNER: "COMMUNITY_CANNOT_REMOVE_OWNER",
  MAX_MEMBERS_REACHED: "COMMUNITY_MAX_MEMBERS_REACHED",
  INSUFFICIENT_MEMBERS: "COMMUNITY_INSUFFICIENT_MEMBERS",

  // Permission errors
  PERMISSION_DENIED: "COMMUNITY_PERMISSION_DENIED",
  NOT_AUTHORIZED_TO_APPROVE: "COMMUNITY_NOT_AUTHORIZED_TO_APPROVE",
  CANNOT_INVITE_SELF: "COMMUNITY_CANNOT_INVITE_SELF",
  CANNOT_CHANGE_OWN_ROLE: "COMMUNITY_CANNOT_CHANGE_OWN_ROLE",
  ONLY_ADMINS_CAN_POST: "COMMUNITY_ONLY_ADMINS_CAN_POST",

  // Transaction errors
  TRANSACTION_NOT_FOUND: "COMMUNITY_TRANSACTION_NOT_FOUND",
  TRANSACTION_ALREADY_APPROVED: "COMMUNITY_TRANSACTION_ALREADY_APPROVED",
  TRANSACTION_ALREADY_REJECTED: "COMMUNITY_TRANSACTION_ALREADY_REJECTED",
  TRANSACTION_EXPIRED: "COMMUNITY_TRANSACTION_EXPIRED",
  WITHDRAWALS_NOT_ALLOWED: "COMMUNITY_WITHDRAWALS_NOT_ALLOWED",
  AMOUNT_EXCEEDS_BALANCE: "COMMUNITY_AMOUNT_EXCEEDS_BALANCE",

  // Invitation errors
  INVITATION_NOT_FOUND: "COMMUNITY_INVITATION_NOT_FOUND",
  INVITATION_EXPIRED: "COMMUNITY_INVITATION_EXPIRED",
  INVITATION_ALREADY_ACCEPTED: "COMMUNITY_INVITATION_ALREADY_ACCEPTED",

  // Stokvel errors
  STOKVEL_MIN_MEMBERS_REQUIRED: "COMMUNITY_STOKVEL_MIN_MEMBERS_REQUIRED",
  CONTRIBUTION_MISSED: "COMMUNITY_CONTRIBUTION_MISSED",
  PAYOUT_NOT_DUE: "COMMUNITY_PAYOUT_NOT_DUE",
} as const;

// ============================================================================
// COMMUNITY TYPES
// ============================================================================

export type CommunityType = "regular" | "stokvel";

export interface CommunityMember {
  id: string;
  communityId: string;
  userId: string;
  role: GroupRole;
  displayName: string;
  avatarUrl: string | null;
  status: GroupMemberStatus;
  contributionBalance: number;
  joinedAt: admin.firestore.Timestamp | null;
  invitedBy: string;
  invitedAt: admin.firestore.Timestamp;
  lastReadAt: admin.firestore.Timestamp | null;
}

export interface Community {
  id: string;
  type: CommunityType;
  name: string;
  description: string | null;
  avatarUrl: string | null;
  ownerId: string;
  memberIds: string[];
  adminIds: string[];
  memberCount: number;
  totalBalance: number;
  status: "active" | "suspended" | "closed";
  settings: CommunitySettings;
  stokvel: StokvelSettings | null;
  lastMessage: {
    text: string;
    senderId: string;
    senderName: string;
    type: string;
    timestamp: admin.firestore.Timestamp;
  } | null;
  lastMessageAt: admin.firestore.Timestamp | null;
  unreadCounts: Record<string, number>;
  muted: Record<string, boolean>;
  createdAt: admin.firestore.Timestamp;
  updatedAt: admin.firestore.Timestamp | null;
}

export interface CommunitySettings extends GroupSettings {
  maxMembers: number;
  allowMemberInvites: boolean;
  onlyAdminsPost: boolean;
  membersCanShareMedia: boolean;
  enableFinancials: boolean;
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/**
 * Require authenticated user; returns userId.
 * Accepts a structural type compatible with both Gen1 CallableContext and Gen2 CallableRequest.
 */
export function requireAuth(context: { auth?: { uid: string } }): string {
  if (!context.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  return context.auth.uid;
}

/**
 * Get a community by ID or throw not-found error.
 */
export async function getCommunityOrThrow(communityId: string): Promise<Community> {
  const doc = await db.collection(CommunityConfig.COLLECTION).doc(communityId).get();
  if (!doc.exists) {
    throw new HttpsError("not-found", CommunityErrorCodes.NOT_FOUND);
  }
  return { id: doc.id, ...doc.data() } as Community;
}

/**
 * Get a community member or null.
 */
export async function getCommunityMember(
  communityId: string,
  userId: string
): Promise<CommunityMember | null> {
  const doc = await db
    .collection(CommunityConfig.COLLECTION)
    .doc(communityId)
    .collection(CommunityConfig.SUBCOLLECTION_MEMBERS)
    .doc(userId)
    .get();
  return doc.exists ? (doc.data() as CommunityMember) : null;
}

/**
 * Require that user is an active member of the community.
 */
export async function requireCommunityMember(
  communityId: string,
  userId: string
): Promise<CommunityMember> {
  const member = await getCommunityMember(communityId, userId);
  if (!member || member.status !== "active") {
    throw new HttpsError("permission-denied", CommunityErrorCodes.NOT_A_MEMBER);
  }
  return member;
}

/**
 * Get permissions for a community member based on their role.
 */
export function getMemberPermissions(member: CommunityMember): GroupPermissions {
  return GroupRolePermissions[member.role];
}

/**
 * Require that member has a specific permission.
 */
export function requirePermission(
  member: CommunityMember,
  permission: keyof GroupPermissions,
  errorCode: string = CommunityErrorCodes.PERMISSION_DENIED
): void {
  const perms = getMemberPermissions(member);
  if (!perms[permission]) {
    throw new HttpsError("permission-denied", errorCode);
  }
}

/**
 * Require that community status is active.
 */
export function requireActiveCommunity(community: Community): void {
  if (community.status === "suspended") {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.SUSPENDED);
  }
  if (community.status === "closed") {
    throw new HttpsError("failed-precondition", CommunityErrorCodes.CLOSED);
  }
}

/**
 * Get user profile data or throw not-found error.
 */
export async function getUserProfile(userId: string) {
  const doc = await db.collection("users").doc(userId).get();
  if (!doc.exists) {
    throw new HttpsError("not-found", "User not found");
  }
  return doc.data()!;
}

/**
 * Create default community settings.
 */
export function getDefaultCommunitySettings(type: CommunityType): CommunitySettings {
  const base: CommunitySettings = {
    maxMembers: CommunityConfig.MAX_MEMBERS,
    allowMemberInvites: true,
    onlyAdminsPost: false,
    membersCanShareMedia: true,
    enableFinancials: type === "stokvel",
    requireApprovalAbove: CommunityConfig.DEFAULT_APPROVAL_THRESHOLD,
    allowMemberWithdrawals: type !== "stokvel",
    contributionCycle: "none",
    contributionAmount: 0,
    penaltyPercentage: 0,
  };

  if (type === "stokvel") {
    base.contributionCycle = "monthly";
    base.contributionAmount = CommunityConfig.DEFAULT_CONTRIBUTION_AMOUNT;
    base.penaltyPercentage = CommunityConfig.DEFAULT_PENALTY_PERCENTAGE;
  }

  return base;
}

/**
 * Create default stokvel-specific settings.
 */
export function getDefaultStokvelSettings(): StokvelSettings {
  return {
    requireApprovalAbove: CommunityConfig.DEFAULT_APPROVAL_THRESHOLD,
    allowMemberWithdrawals: false,
    contributionCycle: "monthly",
    contributionAmount: CommunityConfig.DEFAULT_CONTRIBUTION_AMOUNT,
    penaltyPercentage: CommunityConfig.DEFAULT_PENALTY_PERCENTAGE,
    payoutType: "rotating",
    payoutSchedule: "0 0 1 * *",
    currentPayoutRecipient: null,
    nextPayoutDate: null,
    payoutOrder: [],
  };
}

/**
 * Truncate a string to a maximum length.
 */
export function truncate(text: string, maxLen: number): string {
  return text.length > maxLen ? text.substring(0, maxLen) + "..." : text;
}
