/**
 * Gooi-Gooi Helper Functions
 *
 * Configuration, validation, and error codes for the Gooi-Gooi
 * rotating savings feature. All amounts in tokens (100 = R1 ZAR).
 */

import { HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";

const db = admin.firestore();

// ============================================================================
// GOOI-GOOI TYPES
// ============================================================================

export type GooiGroupStatus = "FORMING" | "ACTIVE" | "COMPLETED" | "DISSOLVED";
export type GooiMemberRole = "INITIATOR" | "MEMBER" | "TRIGGER_DELEGATE";
export type GooiMemberStatus = "INVITED" | "ACCEPTED" | "ACTIVE" | "SUSPENDED" | "REMOVED";
export type GooiCycleStatus =
  | "PENDING"
  | "COLLECTING"
  | "AWAITING_TRIGGER"
  | "PAYOUT_PROCESSING"
  | "COMPLETE"
  | "DEFAULTED"
  | "PAYOUT_FAILED";
export type GooiContributionStatus = "PENDING" | "PAID" | "LATE" | "MISSED";
export type GooiPayoutStatus = "PENDING" | "TRIGGERED" | "PROCESSING" | "COMPLETED" | "FAILED";
export type GooiRosterMethod = "AGREED" | "RANDOM" | "BIDDING";
export type GooiCycleFrequency = "WEEKLY" | "BIWEEKLY" | "MONTHLY";
export type GooiBidStatus = "ACTIVE" | "WON" | "OUTBID" | "EXPIRED";
export type GooiDebtStatus = "OUTSTANDING" | "RECOVERED" | "WRITTEN_OFF";
export type GooiAuditEventType =
  | "GROUP_CREATED"
  | "MEMBER_INVITED"
  | "MEMBER_ACCEPTED"
  | "MEMBER_DECLINED"
  | "MEMBER_REMOVED"
  | "MEMBER_SUSPENDED"
  | "ROSTER_LOCKED"
  | "GROUP_ACTIVATED"
  | "CYCLE_OPENED"
  | "CONTRIBUTION_PAID"
  | "CONTRIBUTION_LATE"
  | "CONTRIBUTION_MISSED"
  | "LATE_FEE_APPLIED"
  | "LATE_FEE_WAIVED"
  | "PAYOUT_TRIGGERED"
  | "PAYOUT_COMPLETED"
  | "PAYOUT_FAILED"
  | "PAYOUT_RETRIED"
  | "GRACE_EXTENDED_UNILATERAL"
  | "GRACE_EXTENSION_VOTE_STARTED"
  | "GRACE_EXTENSION_VOTE_PASSED"
  | "GRACE_EXTENSION_VOTE_FAILED"
  | "DELEGATION_GRANTED"
  | "DELEGATION_REVOKED"
  | "DELEGATION_EXPIRED"
  | "AUTO_CONTRIBUTE_TOGGLED"
  | "BID_SUBMITTED"
  | "BID_WON"
  | "BIDDING_FINALIZED"
  | "WITHDRAWAL_REQUESTED"
  | "WITHDRAWAL_VOTE_STARTED"
  | "WITHDRAWAL_APPROVED"
  | "WITHDRAWAL_DENIED"
  | "BAD_DEBT_WRITTEN_OFF"
  | "GROUP_DISSOLVED"
  | "GROUP_COMPLETED"
  | "RESERVE_RETURNED"
  | "BID_BONUS_DISTRIBUTED"
  | "DEBT_RECORDED"
  | "DEBT_RECOVERED";

// ============================================================================
// GOOI-GOOI CONFIGURATION
// ============================================================================

export interface GooiGooiConfig {
  maxGroupSize: number;
  maxTotalCycles: number;
  maxActiveGroups: number;
  minContribution: number;
  maxContribution: number;
  maxLateFeePercent: number;
  autoTriggerHours: number;
  maxDelegationDays: number;
  biddingWindowHours: number;
  minBidPercent: number;
  invitationExpiryDays: number;
  maxUnilateralExtensionHours: number;
  maxVotedExtensionHours: number;
  graceExtensionVoteWindowHours: number;
  maxPayoutRetries: number;
  withdrawalVotePercent: number;
}

export const GooiDefaults: GooiGooiConfig = {
  maxGroupSize: 12,
  maxTotalCycles: 12,
  maxActiveGroups: 3,
  minContribution: 1000,       // R10
  maxContribution: 1000000,    // R10,000
  maxLateFeePercent: 10,
  autoTriggerHours: 72,
  maxDelegationDays: 14,
  biddingWindowHours: 48,
  minBidPercent: 80,
  invitationExpiryDays: 7,
  maxUnilateralExtensionHours: 24,
  maxVotedExtensionHours: 48,
  graceExtensionVoteWindowHours: 12,
  maxPayoutRetries: 3,
  withdrawalVotePercent: 80,
};

let cachedConfig: GooiGooiConfig | null = null;
let cachedConfigAt = 0;
const CONFIG_TTL_MS = 5 * 60 * 1000; // 5 minutes

/**
 * Load Gooi-Gooi platform config with in-memory TTL cache.
 * Falls back to defaults if Firestore doc doesn't exist.
 */
export async function getGooiConfig(): Promise<GooiGooiConfig> {
  const now = Date.now();
  if (cachedConfig && now - cachedConfigAt < CONFIG_TTL_MS) {
    return cachedConfig;
  }

  const doc = await db.collection("gooiGooiConfig").doc("default").get();
  if (doc.exists) {
    const data = doc.data()!;
    cachedConfig = { ...GooiDefaults, ...data } as GooiGooiConfig;
  } else {
    cachedConfig = { ...GooiDefaults };
  }
  cachedConfigAt = now;
  return cachedConfig;
}

/** Force-refresh config cache (use after admin update). */
export function invalidateGooiConfigCache(): void {
  cachedConfig = null;
  cachedConfigAt = 0;
}

// ============================================================================
// COLLECTION PATHS
// ============================================================================

export const GooiCollections = {
  GROUPS: "gooiGroups",
  MEMBERS: "members",
  CYCLES: "cycles",
  CONTRIBUTIONS: "contributions",
  PAYOUTS: "payouts",
  BIDS: "bids",
  AUDIT_LOG: "auditLog",
  DEBTS: "gooiGooiDebts",
  CONFIG: "gooiGooiConfig",
} as const;

// ============================================================================
// ERROR CODES
// ============================================================================

export const GooiErrorCodes = {
  // Group errors
  GROUP_NOT_FOUND: "GOOI_GROUP_NOT_FOUND",
  GROUP_NOT_FORMING: "GOOI_GROUP_NOT_FORMING",
  GROUP_NOT_ACTIVE: "GOOI_GROUP_NOT_ACTIVE",
  GROUP_FULL: "GOOI_GROUP_FULL",
  GROUP_ALREADY_ACTIVATED: "GOOI_GROUP_ALREADY_ACTIVATED",

  // Member errors
  NOT_INITIATOR: "GOOI_NOT_INITIATOR",
  NOT_MEMBER: "GOOI_NOT_MEMBER",
  ALREADY_MEMBER: "GOOI_ALREADY_MEMBER",
  MEMBER_NOT_FOUND: "GOOI_MEMBER_NOT_FOUND",
  MEMBER_SUSPENDED: "GOOI_MEMBER_SUSPENDED",
  MEMBER_REMOVED: "GOOI_MEMBER_REMOVED",
  MAX_ACTIVE_GROUPS: "GOOI_MAX_ACTIVE_GROUPS",
  OUTSTANDING_DEBT: "GOOI_OUTSTANDING_DEBT",
  INVITATION_EXPIRED: "GOOI_INVITATION_EXPIRED",
  INVITATION_NOT_FOUND: "GOOI_INVITATION_NOT_FOUND",

  // Contribution errors
  ALREADY_CONTRIBUTED: "GOOI_ALREADY_CONTRIBUTED",
  CYCLE_NOT_COLLECTING: "GOOI_CYCLE_NOT_COLLECTING",
  INSUFFICIENT_BALANCE: "GOOI_INSUFFICIENT_BALANCE",
  CONTRIBUTION_NOT_FOUND: "GOOI_CONTRIBUTION_NOT_FOUND",
  CONTRIBUTION_NOT_LATE: "GOOI_CONTRIBUTION_NOT_LATE",

  // Payout errors
  CYCLE_NOT_AWAITING_TRIGGER: "GOOI_CYCLE_NOT_AWAITING_TRIGGER",
  NOT_AUTHORIZED_TO_TRIGGER: "GOOI_NOT_AUTHORIZED_TO_TRIGGER",
  PAYOUT_ALREADY_TRIGGERED: "GOOI_PAYOUT_ALREADY_TRIGGERED",

  // Delegation errors
  CANNOT_DELEGATE_TO_SELF: "GOOI_CANNOT_DELEGATE_TO_SELF",
  DELEGATION_TOO_LONG: "GOOI_DELEGATION_TOO_LONG",
  NO_ACTIVE_DELEGATION: "GOOI_NO_ACTIVE_DELEGATION",

  // Roster errors
  ROSTER_ALREADY_LOCKED: "GOOI_ROSTER_ALREADY_LOCKED",
  NOT_ENOUGH_MEMBERS: "GOOI_NOT_ENOUGH_MEMBERS",

  // Bidding errors
  NOT_BIDDING_GROUP: "GOOI_NOT_BIDDING_GROUP",
  BID_TOO_LOW: "GOOI_BID_TOO_LOW",
  BIDDING_CLOSED: "GOOI_BIDDING_CLOSED",

  // Grace extension errors
  GRACE_ALREADY_EXTENDED: "GOOI_GRACE_ALREADY_EXTENDED",
  MAX_EXTENSION_REACHED: "GOOI_MAX_EXTENSION_REACHED",
  VOTE_ALREADY_ACTIVE: "GOOI_VOTE_ALREADY_ACTIVE",
  VOTE_NOT_FOUND: "GOOI_VOTE_NOT_FOUND",
  ALREADY_VOTED: "GOOI_ALREADY_VOTED",

  // Late fee errors
  LATE_FEE_ALREADY_APPLIED: "GOOI_LATE_FEE_ALREADY_APPLIED",
  LATE_FEE_ALREADY_WAIVED: "GOOI_LATE_FEE_ALREADY_WAIVED",

  // Dissolution errors
  CANNOT_DISSOLVE: "GOOI_CANNOT_DISSOLVE",

  // Bad debt errors
  NO_BAD_DEBT: "GOOI_NO_BAD_DEBT",
  GROUP_NOT_COMPLETED: "GOOI_GROUP_NOT_COMPLETED",

  // Validation
  INVALID_AMOUNT: "GOOI_INVALID_AMOUNT",
  INVALID_FREQUENCY: "GOOI_INVALID_FREQUENCY",
  INVALID_ROSTER_METHOD: "GOOI_INVALID_ROSTER_METHOD",
  INVALID_TOTAL_CYCLES: "GOOI_INVALID_TOTAL_CYCLES",
  INVALID_LATE_FEE: "GOOI_INVALID_LATE_FEE",
  INVALID_GRACE_PERIOD: "GOOI_INVALID_GRACE_PERIOD",
} as const;

// ============================================================================
// VALIDATION HELPERS
// ============================================================================

/**
 * Validate contribution amount against platform config.
 */
export function validateContributionAmount(amount: number, config: GooiGooiConfig): void {
  if (!Number.isInteger(amount) || amount <= 0) {
    throw new HttpsError("invalid-argument", "Contribution amount must be a positive integer (tokens)");
  }
  if (amount < config.minContribution) {
    throw new HttpsError(
      "invalid-argument",
      `Contribution must be at least R${config.minContribution / 100} (${config.minContribution} tokens)`
    );
  }
  if (amount > config.maxContribution) {
    throw new HttpsError(
      "invalid-argument",
      `Contribution cannot exceed R${config.maxContribution / 100} (${config.maxContribution} tokens)`
    );
  }
}

/**
 * Validate cycle frequency.
 */
export function validateCycleFrequency(freq: string): asserts freq is GooiCycleFrequency {
  const valid: GooiCycleFrequency[] = ["WEEKLY", "BIWEEKLY", "MONTHLY"];
  if (!valid.includes(freq as GooiCycleFrequency)) {
    throw new HttpsError("invalid-argument", `Cycle frequency must be one of: ${valid.join(", ")}`);
  }
}

/**
 * Validate roster method.
 */
export function validateRosterMethod(method: string): asserts method is GooiRosterMethod {
  const valid: GooiRosterMethod[] = ["AGREED", "RANDOM", "BIDDING"];
  if (!valid.includes(method as GooiRosterMethod)) {
    throw new HttpsError("invalid-argument", `Roster method must be one of: ${valid.join(", ")}`);
  }
}

/**
 * Validate total cycles.
 */
export function validateTotalCycles(totalCycles: number, config: GooiGooiConfig): void {
  if (!Number.isInteger(totalCycles) || totalCycles < 1) {
    throw new HttpsError("invalid-argument", "Total cycles must be a positive integer");
  }
  if (totalCycles > config.maxTotalCycles) {
    throw new HttpsError(
      "invalid-argument",
      `Total cycles cannot exceed ${config.maxTotalCycles}`
    );
  }
}

/**
 * Validate late fee percentage.
 */
export function validateLateFeePercent(percent: number, config: GooiGooiConfig): void {
  if (typeof percent !== "number" || percent < 0 || percent > config.maxLateFeePercent) {
    throw new HttpsError(
      "invalid-argument",
      `Late fee must be between 0 and ${config.maxLateFeePercent}%`
    );
  }
}

/**
 * Validate grace period hours.
 */
export function validateGracePeriodHours(hours: number): void {
  if (typeof hours !== "number" || hours < 24 || hours > 168) {
    throw new HttpsError("invalid-argument", "Grace period must be between 24 and 168 hours");
  }
}

/**
 * Require that the caller is the Initiator of the group.
 */
export async function requireInitiator(
  groupId: string,
  userId: string
): Promise<FirebaseFirestore.DocumentSnapshot> {
  const groupRef = db.collection(GooiCollections.GROUPS).doc(groupId);
  const groupDoc = await groupRef.get();
  if (!groupDoc.exists) {
    throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
  }
  if (groupDoc.data()!.initiatorUserId !== userId) {
    throw new HttpsError("permission-denied", GooiErrorCodes.NOT_INITIATOR);
  }
  return groupDoc;
}

/**
 * Require that the group is in FORMING status.
 */
export function requireGroupStatus(
  groupData: FirebaseFirestore.DocumentData,
  expected: GooiGroupStatus
): void {
  if (groupData.status !== expected) {
    throw new HttpsError(
      "failed-precondition",
      `Group must be in ${expected} status, currently ${groupData.status}`
    );
  }
}

/**
 * Get the member document for a user in a gooi group.
 * Returns null if not found.
 */
export async function getGooiMember(
  groupId: string,
  userId: string
): Promise<FirebaseFirestore.QueryDocumentSnapshot | null> {
  const membersSnap = await db
    .collection(GooiCollections.GROUPS)
    .doc(groupId)
    .collection(GooiCollections.MEMBERS)
    .where("userId", "==", userId)
    .where("isActive", "==", true)
    .limit(1)
    .get();

  return membersSnap.empty ? null : membersSnap.docs[0];
}

/**
 * Count the user's active Gooi-Gooi groups.
 */
export async function countActiveGooiGroups(userId: string): Promise<number> {
  const snap = await db
    .collection(GooiCollections.GROUPS)
    .where("memberUserIds", "array-contains", userId)
    .where("status", "in", ["FORMING", "ACTIVE"])
    .where("isDeleted", "==", false)
    .get();
  return snap.size;
}

/**
 * Check if user has outstanding Gooi-Gooi debts.
 */
export async function hasOutstandingDebts(userId: string): Promise<boolean> {
  const snap = await db
    .collection(GooiCollections.DEBTS)
    .where("userId", "==", userId)
    .where("status", "==", "OUTSTANDING")
    .limit(1)
    .get();
  return !snap.empty;
}

/**
 * Write an audit log entry for a gooi group.
 */
export async function writeGooiAuditLog(
  groupId: string,
  eventType: GooiAuditEventType,
  actorId: string,
  params: {
    targetId?: string;
    entityType?: string;
    entityId?: string;
    beforeState?: Record<string, unknown>;
    afterState?: Record<string, unknown>;
    metadata?: Record<string, unknown>;
  } = {}
): Promise<void> {
  const logRef = db
    .collection(GooiCollections.GROUPS)
    .doc(groupId)
    .collection(GooiCollections.AUDIT_LOG)
    .doc();

  await logRef.set({
    id: logRef.id,
    eventType,
    actorId,
    targetId: params.targetId || null,
    entityType: params.entityType || "GROUP",
    entityId: params.entityId || groupId,
    beforeState: params.beforeState || null,
    afterState: params.afterState || null,
    metadata: params.metadata || {},
    timestamp: admin.firestore.Timestamp.now(),
  });
}

/**
 * Calculate the next due date based on frequency from a start date.
 */
export function calculateDueDate(
  startDate: Date,
  cycleNumber: number,
  frequency: GooiCycleFrequency
): Date {
  const date = new Date(startDate);
  const cyclesOffset = cycleNumber - 1; // cycle 1 starts at startDate

  switch (frequency) {
    case "WEEKLY":
      date.setDate(date.getDate() + cyclesOffset * 7);
      break;
    case "BIWEEKLY":
      date.setDate(date.getDate() + cyclesOffset * 14);
      break;
    case "MONTHLY":
      date.setMonth(date.getMonth() + cyclesOffset);
      break;
  }

  // Set to 06:00 SAST (UTC+2) = 04:00 UTC
  date.setUTCHours(4, 0, 0, 0);
  return date;
}

/**
 * Shuffle an array deterministically using Fisher-Yates with a seed.
 * Uses groupId as seed for reproducible random rosters.
 */
export function seededShuffle<T>(array: T[], seed: string): T[] {
  const result = [...array];
  let hash = 0;
  for (let i = 0; i < seed.length; i++) {
    hash = ((hash << 5) - hash + seed.charCodeAt(i)) | 0;
  }

  for (let i = result.length - 1; i > 0; i--) {
    hash = ((hash << 5) - hash + i) | 0;
    const j = Math.abs(hash) % (i + 1);
    [result[i], result[j]] = [result[j], result[i]];
  }
  return result;
}

/**
 * Check if the caller is the Initiator or an active trigger delegate.
 */
export async function isAuthorizedToTrigger(
  groupId: string,
  userId: string
): Promise<boolean> {
  const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
  if (!groupDoc.exists) return false;

  const group = groupDoc.data()!;
  if (group.initiatorUserId === userId) return true;

  // Check if there's an active delegation to this user
  const now = admin.firestore.Timestamp.now();
  const memberSnap = await db
    .collection(GooiCollections.GROUPS)
    .doc(groupId)
    .collection(GooiCollections.MEMBERS)
    .where("userId", "==", userId)
    .where("role", "==", "TRIGGER_DELEGATE")
    .where("isActive", "==", true)
    .limit(1)
    .get();

  if (memberSnap.empty) return false;

  const member = memberSnap.docs[0].data();
  if (member.delegationExpiresAt && member.delegationExpiresAt.toMillis() < now.toMillis()) {
    return false; // delegation expired
  }

  return true;
}
