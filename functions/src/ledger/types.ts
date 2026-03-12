/**
 * Trust Ledger System - Type Definitions
 *
 * Core types for the double-entry bookkeeping ledger system.
 * All token movements are tracked as balanced journal entries.
 */

import { Timestamp } from "firebase-admin/firestore";

// ============================================================================
// ACCOUNT TYPES
// ============================================================================

/**
 * Account type categories in the ledger system
 *
 * Asset accounts (debit-normal): cbook — debit increases balance, credit decreases.
 * All other accounts are credit-normal: credit increases balance, debit decreases.
 */
export type AccountType =
  | "system" // iMali system accounts (cashout_pending)
  | "pot" // Daily and weekly pot accounts
  | "user" // Individual user wallet accounts
  | "supplier" // Service providers (Vodacom, MTN, Eskom, etc.)
  | "client" // Brand partners (advertisers, campaign sponsors)
  | "client_subacc" // Client sub-accounts (on-ledger budgets)
  | "cbook" // Cash Book accounts (business, trust) — asset/debit-normal
  | "group"; // Group accounts (stokvels, family, organizations, clubs)

/**
 * Account status
 */
export type AccountStatus = "active" | "frozen" | "closed";

/**
 * System account identifiers (well-known account IDs)
 */
export const SystemAccounts = {
  CBOOK_BUS: "cbook:bus", // iMaliChat business cash book (asset account)
  CBOOK_TRUST: "cbook:trust", // External client trust cash book (asset account)
  DAILY_POT: "pot:daily", // Daily pot accumulator
  WEEKLY_POT: "pot:weekly", // Weekly pot accumulator
  CASHOUT_PENDING: "system:cashout_pending", // Pending cashout holding
  ENGAGEMENT_ESCROW: "system:escrow", // Engagement token reservation holding
  GIFT_ESCROW: "system:gift_escrow", // Gift token holding until claimed
  SPRAY_ESCROW: "system:spray_escrow", // Token spray accumulation until claimed
  IMALICHAT_CLIENT: "client:imalichat", // iMaliChat's own client account
  POT_RESIDUAL: "system:pot_residual", // Rounding residual from pot distributions
  MARKETPLACE_ESCROW: "system:marketplace_escrow", // Marketplace buy/sell escrow
  GROUP_BUY_ESCROW: "system:group_buy_escrow", // Group buy contribution escrow
} as const;

/**
 * Ledger account document structure
 */
export interface LedgerAccount {
  id: string; // Format: "{type}:{identifier}" e.g., "user:abc123"
  type: AccountType;
  name: string; // Human-readable name
  ownerId?: string; // userId for user accounts, providerId for suppliers
  balance: number; // Current balance (maintained by journal system)
  allocatedBalance: number; // Sum of all active sub-account balances
  currency: "TOKEN"; // Always TOKEN for iMali
  status: AccountStatus;
  metadata: Record<string, unknown>;
  createdAt: Timestamp;
  updatedAt: Timestamp;
  version: number; // Optimistic locking version
}

/**
 * Input for creating a new account
 */
export interface CreateAccountInput {
  type: AccountType;
  name: string;
  ownerId?: string;
  initialBalance?: number;
  metadata?: Record<string, unknown>;
}

// ============================================================================
// JOURNAL TYPES
// ============================================================================

/**
 * Journal transaction types
 */
export type JournalType =
  | "earn" // User earned tokens (from engagement)
  | "pot_contribution" // Automatic pot contribution from earnings
  | "pot_win" // User won a pot draw
  | "purchase" // User purchased goods/services
  | "referral_reward" // Referral bonus paid
  | "p2p_transfer" // User-to-user transfer
  | "cashout_initiate" // Cashout started (user -> pending)
  | "cashout_complete" // Cashout completed (pending -> supplier)
  | "cashout_failed" // Cashout failed (pending -> user refund)
  | "client_fund" // CBook -> Client funding (also seeds cbook as asset debit)
  | "client_refund" // Client -> CBook refund
  | "subacc_fund" // Client -> Sub-Account funding
  | "escrow_reserve" // Tokens source → escrow at engagement start
  | "escrow_release" // Tokens escrow → user/pots/source at engagement completion
  | "pot_residual" // Rounding residual swept from pot at distribution time
  | "reversal" // Reversal of a previous journal
  | "adjustment" // Manual admin adjustment
  // Gift & spray transactions
  | "gift_debit" // Sender → gift escrow
  | "gift_credit" // Gift escrow → recipient on claim
  | "gift_refund" // Gift escrow → sender on expiry
  | "spray_contribution" // Contributor → spray escrow
  | "spray_payout" // Spray escrow → recipient on close/claim
  // Group transactions
  | "group_contribution" // Member contributes to group
  | "group_withdrawal" // Member withdraws from group
  | "group_payout" // Scheduled payout from group to member
  | "group_penalty" // Penalty charged to member
  | "group_transfer" // Transfer in/out of group
  | "token_expiry" // Sub-account token expiry refund to brand client
  // Marketplace transactions
  | "marketplace_escrow" // Buyer → marketplace escrow on purchase
  | "marketplace_release" // Marketplace escrow → seller on receipt confirmation
  | "marketplace_refund" // Marketplace escrow → buyer on cancel/dispute refund
  // Group buy transactions
  | "group_buy_escrow" // Contributor → group buy escrow on join
  | "group_buy_release" // Group buy escrow → organizer on completion
  | "group_buy_refund" // Group buy escrow → contributor on expiry/cancel
  // Gooi-Gooi transactions
  | "gooi_contribution" // Member contribution to Gooi-Gooi group
  | "gooi_reserve" // Member reserve fund contribution
  | "gooi_payout" // Cycle payout to recipient
  | "gooi_reserve_topup" // Reserve fund tops up shortfall
  | "gooi_late_fee" // Late fee charged to member
  | "gooi_refund" // Refund to member on group dissolution
  | "gooi_debt_recovery" // Recovery of outstanding debt from member
  | "gooi_reserve_return" // Reserve fund returned to member
  | "gooi_bid_bonus" // Bonus from bid auction
  | "gooi_bad_debt_writeoff"; // Bad debt written off

/**
 * Journal status
 */
export type JournalStatus = "pending" | "posted" | "failed" | "reversed";

/**
 * Entry type
 * Asset accounts (cbook): debit increases balance, credit decreases.
 * All other accounts: credit increases balance, debit decreases.
 */
export type EntryType = "debit" | "credit";

/**
 * Individual ledger entry within a journal
 */
export interface LedgerEntry {
  id: string;
  accountId: string; // Reference to ledger account
  entryType: EntryType;
  amount: number; // Always positive
  balanceAfter: number; // Account balance after this entry
  description?: string; // Optional per-entry description
}

/**
 * Journal document structure (immutable once posted)
 */
export interface LedgerJournal {
  id: string;
  idempotencyKey: string; // Unique key to prevent duplicate processing
  type: JournalType;
  status: JournalStatus;
  description: string;
  entries: LedgerEntry[]; // Embedded entries (2+ per journal)
  totalDebits: number; // Sum of all debit amounts
  totalCredits: number; // Sum of all credit amounts (must equal debits)

  // Business reference
  referenceType?:
    | "engagement"
    | "purchase"
    | "referral"
    | "transfer"
    | "cashout"
    | "pot_draw"
    | "pot_entry"
    | "client_fund" // Client funding/refund operations
    | "group" // Group transactions
    | "sub_account_expiry" // Token expiry refund to brand client
    | "gooi_gooi"; // Gooi-Gooi rotating savings
  referenceId?: string;

  // Sub-account tracking
  subAccountId?: string | null; // Which user sub-account is affected
  accountTypeId?: string | null; // For audit trail

  // Audit trail
  initiatedBy: string; // userId or "system"
  approvedBy?: string; // For manual adjustments requiring approval
  ipAddress?: string; // Client IP for fraud detection
  userAgent?: string; // Client user agent

  // Timestamps
  createdAt: Timestamp;
  postedAt?: Timestamp;
  reversedAt?: Timestamp;
  reversedBy?: string;
  reversalJournalId?: string; // If reversed, points to reversal journal
  originalJournalId?: string; // If this is a reversal, points to original

  // Additional metadata
  metadata: Record<string, unknown>;

  // Denormalized for Firestore security rules
  participantAccountIds?: string[];
}

/**
 * Input for posting a new journal
 */
export interface PostJournalInput {
  idempotencyKey: string;
  type: JournalType;
  description: string;
  entries: JournalEntryInput[];
  referenceType?: LedgerJournal["referenceType"];
  referenceId?: string;
  initiatedBy: string;
  approvedBy?: string;
  ipAddress?: string;
  userAgent?: string;
  subAccountId?: string | null; // Which user sub-account is affected
  accountTypeId?: string | null; // For audit trail
  metadata?: Record<string, unknown>;
}

/**
 * Input for a single entry when posting a journal
 */
export interface JournalEntryInput {
  accountId: string;
  entryType: EntryType;
  amount: number;
  description?: string;
}

// ============================================================================
// BALANCE SNAPSHOT TYPES
// ============================================================================

/**
 * Periodic balance snapshot for reconciliation
 */
export interface BalanceSnapshot {
  id: string;
  accountId: string;
  balance: number;
  lastJournalId: string; // Last journal included in this snapshot
  lastJournalPostedAt: Timestamp;
  snapshotAt: Timestamp;
  calculatedBalance: number; // Balance calculated from entries
  isReconciled: boolean; // true if balance matches calculated
  discrepancy: number; // Difference (should be 0)
}

// ============================================================================
// AUDIT LOG TYPES
// ============================================================================

/**
 * Audit event types
 */
export type AuditEventType =
  | "account_created"
  | "account_frozen"
  | "account_unfrozen"
  | "account_closed"
  | "journal_posted"
  | "journal_reversed"
  | "journal_failed"
  | "reconciliation_passed"
  | "reconciliation_failed"
  | "balance_drift_detected"
  | "manual_adjustment";

/**
 * Audit log entry
 */
export interface AuditLogEntry {
  id: string;
  eventType: AuditEventType;
  accountId?: string;
  journalId?: string;
  actorId: string; // userId or "system"
  actorType: "user" | "system" | "admin";
  description: string;
  previousValue?: unknown;
  newValue?: unknown;
  ipAddress?: string;
  userAgent?: string;
  timestamp: Timestamp;
  metadata: Record<string, unknown>;
}

// ============================================================================
// OPERATION RESULT TYPES
// ============================================================================

/**
 * Result of a ledger operation
 */
export interface LedgerOperationResult<T = unknown> {
  success: boolean;
  data?: T;
  error?: string;
  errorCode?: string;
}

/**
 * Result of posting a journal
 */
export interface PostJournalResult extends LedgerOperationResult<LedgerJournal> {
  journalId?: string;
  isDuplicate?: boolean; // True if idempotency key matched existing journal
}

/**
 * Result of account balance check
 */
export interface BalanceCheckResult {
  accountId: string;
  balance: number;
  available: number; // Balance minus pending outflows
  hasSufficientBalance: boolean;
  requiredAmount?: number;
}

/**
 * Reconciliation result
 */
export interface ReconciliationResult {
  accountId: string;
  storedBalance: number;
  calculatedBalance: number;
  isReconciled: boolean;
  discrepancy: number;
  lastJournalId?: string;
  checkedAt: Timestamp;
}

// ============================================================================
// CONSTANTS
// ============================================================================

/**
 * Ledger configuration constants
 */
export const LedgerConfig = {
  // Token distribution for earnings
  EARNING_USER_SHARE: 0.9, // 90% to user
  EARNING_DAILY_POT_SHARE: 0.05, // 5% to daily pot
  EARNING_WEEKLY_POT_SHARE: 0.05, // 5% to weekly pot

  // Minimum amounts
  MIN_TRANSFER_AMOUNT: 1, // Minimum 1 token for any transfer
  MIN_CASHOUT_AMOUNT: 5000, // Minimum 5000 tokens (R50) for cashout

  // Daily limits
  DAILY_EARNING_CAP: 500, // Maximum 500 tokens per day from earnings
  DAILY_P2P_LIMIT: 10000, // Maximum 10000 tokens per day for P2P

  // Referral rewards
  REFERRER_REWARD: 100, // Tokens for person who referred
  REFEREE_REWARD: 50, // Tokens for person who was referred

  // Collection names
  COLLECTION_ACCOUNTS: "ledgerAccounts",
  COLLECTION_JOURNALS: "ledgerJournals",
  COLLECTION_SNAPSHOTS: "ledgerSnapshots",
  COLLECTION_AUDIT: "ledgerAudit",

  // Token to ZAR conversion
  TOKENS_PER_ZAR: 100, // 100 tokens = R1
} as const;

/**
 * Escrow configuration constants
 */
export const EscrowConfig = {
  /** Maximum time (ms) an escrow reservation can remain active before auto-cleanup */
  ESCROW_TTL_MS: 2 * 60 * 60 * 1000, // 2 hours
  /** Cron expression for cleanup function schedule */
  CLEANUP_INTERVAL_CRON: "*/15 * * * *", // Every 15 minutes
  /** Maximum engagements to process per cleanup run per status */
  CLEANUP_BATCH_SIZE: 200,
} as const;

// ============================================================================
// ERROR CODES
// ============================================================================

/**
 * Ledger-specific error codes
 */
export const LedgerErrorCodes = {
  // Account errors
  ACCOUNT_NOT_FOUND: "LEDGER_ACCOUNT_NOT_FOUND",
  ACCOUNT_FROZEN: "LEDGER_ACCOUNT_FROZEN",
  ACCOUNT_CLOSED: "LEDGER_ACCOUNT_CLOSED",
  ACCOUNT_ALREADY_EXISTS: "LEDGER_ACCOUNT_ALREADY_EXISTS",

  // Balance errors
  INSUFFICIENT_BALANCE: "LEDGER_INSUFFICIENT_BALANCE",
  BALANCE_WOULD_GO_NEGATIVE: "LEDGER_BALANCE_WOULD_GO_NEGATIVE",

  // Journal errors
  JOURNAL_NOT_BALANCED: "LEDGER_JOURNAL_NOT_BALANCED",
  JOURNAL_ALREADY_EXISTS: "LEDGER_JOURNAL_ALREADY_EXISTS",
  JOURNAL_NOT_FOUND: "LEDGER_JOURNAL_NOT_FOUND",
  JOURNAL_ALREADY_REVERSED: "LEDGER_JOURNAL_ALREADY_REVERSED",
  JOURNAL_CANNOT_BE_REVERSED: "LEDGER_JOURNAL_CANNOT_BE_REVERSED",

  // Validation errors
  INVALID_AMOUNT: "LEDGER_INVALID_AMOUNT",
  INVALID_ENTRY_TYPE: "LEDGER_INVALID_ENTRY_TYPE",
  EMPTY_ENTRIES: "LEDGER_EMPTY_ENTRIES",
  INVALID_IDEMPOTENCY_KEY: "LEDGER_INVALID_IDEMPOTENCY_KEY",

  // Concurrency errors
  VERSION_CONFLICT: "LEDGER_VERSION_CONFLICT",
  TRANSACTION_FAILED: "LEDGER_TRANSACTION_FAILED",

  // Reconciliation errors
  RECONCILIATION_FAILED: "LEDGER_RECONCILIATION_FAILED",
  BALANCE_DRIFT_DETECTED: "LEDGER_BALANCE_DRIFT_DETECTED",
} as const;

// ============================================================================
// HELPER TYPES
// ============================================================================

/**
 * Account ID builder helpers
 */
export const AccountId = {
  user: (userId: string) => `user:${userId}`,
  supplier: (providerId: string) => `supplier:${providerId}`,
  client: (clientId: string) => `client:${clientId}`,
  clientSubAccount: (subAccountId: string) => `client_subacc:${subAccountId}`,
  group: (groupId: string) => `group:${groupId}`,
  parseUserId: (accountId: string): string | null => {
    if (accountId.startsWith("user:")) {
      return accountId.substring(5);
    }
    return null;
  },
  parseSupplierId: (accountId: string): string | null => {
    if (accountId.startsWith("supplier:")) {
      return accountId.substring(9);
    }
    return null;
  },
  parseClientId: (accountId: string): string | null => {
    if (accountId.startsWith("client:")) {
      return accountId.substring(7);
    }
    return null;
  },
  parseClientSubAccountId: (accountId: string): string | null => {
    if (accountId.startsWith("client_subacc:")) {
      return accountId.substring(14);
    }
    return null;
  },
  parseGroupId: (accountId: string): string | null => {
    if (accountId.startsWith("group:")) {
      return accountId.substring(6);
    }
    return null;
  },
  isUserAccount: (accountId: string): boolean => accountId.startsWith("user:"),
  isSystemAccount: (accountId: string): boolean =>
    accountId.startsWith("system:"),
  isPotAccount: (accountId: string): boolean => accountId.startsWith("pot:"),
  isSupplierAccount: (accountId: string): boolean =>
    accountId.startsWith("supplier:"),
  isClientAccount: (accountId: string): boolean =>
    accountId.startsWith("client:") && !accountId.startsWith("client_subacc:"),
  isClientSubAccount: (accountId: string): boolean =>
    accountId.startsWith("client_subacc:"),
  isCbookAccount: (accountId: string): boolean =>
    accountId.startsWith("cbook:"),
  isGroupAccount: (accountId: string): boolean =>
    accountId.startsWith("group:"),
  /**
   * Asset accounts (cbook) are debit-normal: debit increases balance, credit decreases.
   * All other accounts are credit-normal: credit increases balance, debit decreases.
   */
  isDebitNormal: (accountId: string): boolean =>
    accountId.startsWith("cbook:"),
};

/**
 * Idempotency key builders
 */
export const IdempotencyKey = {
  earning: (engagementId: string) => `earn:${engagementId}`,
  potContribution: (engagementId: string) => `pot_contrib:${engagementId}`,
  potWin: (potDrawId: string, userId: string) => `pot_win:${potDrawId}:${userId}`,
  purchase: (purchaseId: string) => `purchase:${purchaseId}`,
  referral: (referralId: string) => `referral:${referralId}`,
  p2pTransfer: (transferId: string) => `p2p:${transferId}`,
  cashoutInitiate: (cashoutId: string) => `cashout_init:${cashoutId}`,
  cashoutComplete: (cashoutId: string) => `cashout_complete:${cashoutId}`,
  cashoutFailed: (cashoutId: string) => `cashout_failed:${cashoutId}`,
  clientFund: (clientId: string, reference: string) => `client_fund:${clientId}:${reference}`,
  clientRefund: (clientId: string, reference: string) => `client_refund:${clientId}:${reference}`,
  subAccountFund: (subAccountId: string, reference: string) => `subacc_fund:${subAccountId}:${reference}`,
  escrowReserve: (engagementId: string) => `escrow_reserve:${engagementId}`,
  escrowRelease: (engagementId: string) => `escrow_release:${engagementId}`,
  reversal: (originalJournalId: string) => `reversal:${originalJournalId}`,
  adjustment: (adjustmentId: string) => `adjustment:${adjustmentId}`,
  // Gift & spray keys
  giftDebit: (giftId: string) => `gift_debit:${giftId}`,
  giftCredit: (giftId: string) => `gift_credit:${giftId}`,
  giftRefund: (giftId: string) => `gift_refund:${giftId}`,
  sprayContribution: (sprayId: string, userId: string) => `spray_contrib:${sprayId}:${userId}`,
  sprayPayout: (sprayId: string) => `spray_payout:${sprayId}`,
  // Group transaction keys
  groupContribution: (groupId: string, transactionId: string) => `group_contrib:${groupId}:${transactionId}`,
  groupWithdrawal: (groupId: string, transactionId: string) => `group_withdraw:${groupId}:${transactionId}`,
  groupPayout: (groupId: string, transactionId: string) => `group_payout:${groupId}:${transactionId}`,
  groupPenalty: (groupId: string, memberId: string, date: string) => `group_penalty:${groupId}:${memberId}:${date}`,
  groupTransfer: (groupId: string, transactionId: string) => `group_transfer:${groupId}:${transactionId}`,
  // Token pool keys
  poolSend: (poolId: string) => `pool_send:${poolId}`,
  poolDistribute: (poolId: string) => `pool_distribute:${poolId}`,
  poolCancel: (poolId: string) => `pool_cancel:${poolId}`,
  poolExpire: (poolId: string) => `pool_expire:${poolId}`,
  // Marketplace escrow keys
  marketplaceEscrow: (orderId: string) => `mkt_escrow:${orderId}`,
  marketplaceRelease: (orderId: string) => `mkt_release:${orderId}`,
  marketplaceRefund: (orderId: string) => `mkt_refund:${orderId}`,
  // Group buy escrow keys
  groupBuyEscrow: (groupBuyId: string, userId: string) => `gb_escrow:${groupBuyId}:${userId}`,
  groupBuyRelease: (groupBuyId: string) => `gb_release:${groupBuyId}`,
  groupBuyRefund: (groupBuyId: string, userId: string) => `gb_refund:${groupBuyId}:${userId}`,
  // Gooi-Gooi keys
  gooiContribution: (groupId: string, cycleId: string, memberId: string) => `gooi_c:${groupId}:${cycleId}:${memberId}`,
  gooiReserve: (groupId: string, cycleId: string, memberId: string) => `gooi_r:${groupId}:${cycleId}:${memberId}`,
  gooiPayout: (groupId: string, cycleId: string) => `gooi_p:${groupId}:${cycleId}`,
  gooiReserveTopup: (groupId: string, cycleId: string) => `gooi_rt:${groupId}:${cycleId}`,
  gooiLateFee: (groupId: string, cycleId: string, memberId: string) => `gooi_lf:${groupId}:${cycleId}:${memberId}`,
  gooiRefund: (groupId: string, memberId: string) => `gooi_ref:${groupId}:${memberId}`,
  gooiDebtRecovery: (debtId: string) => `gooi_debt:${debtId}`,
  gooiReserveReturn: (groupId: string, memberId: string) => `gooi_rr:${groupId}:${memberId}`,
  gooiBidBonus: (groupId: string, memberId: string) => `gooi_bb:${groupId}:${memberId}`,
  gooiBadDebtWriteoff: (groupId: string) => `gooi_bdw:${groupId}`,
};

// ============================================================================
// SUB-ACCOUNT TYPES
// ============================================================================

/**
 * Sub-account within a ledger account
 * Displayed as "wallets" in the UI but never called wallet in backend
 */
export interface SubAccount {
  id: string;
  userId: string;
  accountTypeId: string | null; // null = default unrestricted
  name: string; // Display name for UI (e.g., "iMaliChat", "Shoprite Rewards")
  balance: number;
  lifetimeCredits: number; // Total ever credited
  lifetimeDebits: number; // Total ever debited
  isActive: boolean;
  isDefault: boolean; // true for the primary unrestricted sub-account
  lastCreditAt: Timestamp | null; // Timestamp of last credit to this sub-account (for expiryDays)
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

/**
 * Account type definition - defines restrictions for a sub-account
 * Renamed from AccountType to avoid conflict with ledger AccountType union
 */
export interface SubAccountTypeDefinition {
  id: string;
  advertiserId: string | null; // null = platform default
  name: string; // e.g., "Shoprite Rewards"
  description: string;
  iconUrl: string | null;
  isRestricted: boolean;
  rules: AccountTypeRules;
  isActive: boolean;
  createdAt: Timestamp;
}

/**
 * Rules defining what a sub-account can do
 */
export interface AccountTypeRules {
  allowedOfframps: string[]; // ["*"] for any, or ["shoprite_voucher"] for restricted
  allowP2pSend: boolean;
  allowP2pReceive: boolean;
  allowCashout: boolean;
  expiryDays: number | null; // Days until unused balance expires
  p2pRestrictToSameAccountType: boolean; // When true, P2P only allowed with recipients who have the same account type
}

/**
 * User engagement stats (streak tracking)
 */
export interface UserEngagementStats {
  userId: string;
  currentStreak: number;
  longestStreak: number;
  streakStartedAt: Timestamp | null;
  lastEarnedDate: string; // "YYYY-MM-DD" in SAST timezone
  totalEngagementsCompleted: number;
  totalTokensEarned: number;
  updatedAt: Timestamp;
}

/**
 * User daily score (scoring history)
 */
export interface DailyScore {
  date: string; // "YYYY-MM-DD"
  engagementsCompleted: number;
  tokensEarned: number;
  streakDay: number; // What day of streak
  streakMultiplier: number; // 1.0, 1.2, 1.35, or 1.5
  assistScore: number; // From referrals
  finalScore: number; // (completions × multiplier) + assistScore
  displayName: string; // Cached for leaderboard display
  username: string | null;
  avatarUrl: string | null;
  updatedAt: Timestamp;
}

/**
 * Pot leaderboard entry (draw-time rankings)
 */
export interface PotLeaderboardEntry {
  rank: number;
  userId: string;
  displayName: string;
  username: string | null;
  avatarUrl: string | null;
  finalScore: number;
  engagementsCompleted: number;
  createdAt: Timestamp;
}

/**
 * Streak info returned from engagement stats update
 */
export interface StreakInfo {
  currentStreak: number;
  longestStreak: number;
  multiplier: number;
  isNewDay: boolean;
  streakBroken: boolean;
}

/**
 * Operations that can be validated against account type rules
 */
export type SubAccountOperation =
  | "p2p_send"
  | "p2p_receive"
  | "cashout"
  | "purchase";

/**
 * Sub-account operation validation result
 */
export interface SubAccountValidationResult {
  allowed: boolean;
  reason?: string;
}

// ============================================================================
// SUB-ACCOUNT CONSTANTS
// ============================================================================

/**
 * Sub-account configuration constants
 */
export const SubAccountConfig = {
  // Collection paths
  COLLECTION_LEDGER_ACCOUNTS: "ledgerAccounts",
  SUBCOLLECTION_SUB_ACCOUNTS: "subAccounts",
  COLLECTION_ACCOUNT_TYPES: "accountTypes",
  COLLECTION_ENGAGEMENT_STATS: "userEngagementStats",

  // Default sub-account settings
  DEFAULT_SUB_ACCOUNT_NAME: "iMaliChat",

  // Streak multiplier tiers
  STREAK_MULTIPLIER_TIER_1: 1.0, // Days 1-2
  STREAK_MULTIPLIER_TIER_2: 1.2, // Days 3-6
  STREAK_MULTIPLIER_TIER_3: 1.35, // Days 7-9
  STREAK_MULTIPLIER_TIER_4: 1.5, // Days 10+

  // Assist score percentage (referrer gets 10% of referee's earnings as assist)
  ASSIST_SCORE_PERCENTAGE: 0.1,
} as const;

/**
 * Error codes for sub-account operations
 */
export const SubAccountErrorCodes = {
  SUB_ACCOUNT_NOT_FOUND: "SUB_ACCOUNT_NOT_FOUND",
  ACCOUNT_TYPE_NOT_FOUND: "ACCOUNT_TYPE_NOT_FOUND",
  OPERATION_NOT_ALLOWED: "OPERATION_NOT_ALLOWED",
  INSUFFICIENT_SUB_ACCOUNT_BALANCE: "INSUFFICIENT_SUB_ACCOUNT_BALANCE",
  SUB_ACCOUNT_INACTIVE: "SUB_ACCOUNT_INACTIVE",
  OFFRAMP_NOT_ALLOWED: "OFFRAMP_NOT_ALLOWED",
  P2P_RECEIVE_NOT_ALLOWED: "P2P_RECEIVE_NOT_ALLOWED",
} as const;

// ============================================================================
// GROUP ACCOUNT TYPES
// ============================================================================

/**
 * Group types supported by the platform
 */
export type GroupType = "stokvel" | "family" | "organization" | "club";

/**
 * Group member roles with different permission levels
 */
export type GroupRole = "owner" | "admin" | "treasurer" | "member" | "viewer";

/**
 * Group status
 */
export type GroupStatus = "active" | "suspended" | "closed";

/**
 * Group member status
 */
export type GroupMemberStatus = "active" | "invited" | "blocked";

/**
 * Group transaction types
 */
export type GroupTransactionType =
  | "contribution" // Member adds funds to group
  | "withdrawal" // Member withdraws from group
  | "transfer_in" // External transfer into group
  | "transfer_out" // External transfer out of group
  | "penalty" // Penalty for missed contribution (stokvels)
  | "payout"; // Scheduled payout to member

/**
 * Group transaction status
 */
export type GroupTransactionStatus = "pending" | "approved" | "completed" | "rejected";

/**
 * Stokvel payout types
 */
export type PayoutType = "rotating" | "lottery" | "fixed_date" | "goal_reached";

/**
 * Contribution cycle frequency
 */
export type ContributionCycle = "weekly" | "monthly" | "none";

/**
 * Permissions for each group role
 */
export interface GroupPermissions {
  canManageMembers: boolean;
  canApproveFunds: boolean;
  canTransferFunds: boolean;
  canViewLedger: boolean;
  canEditSettings: boolean;
  maxTransferWithoutApproval: number; // 0 = always needs approval, Infinity = never needs approval
}

/**
 * Role-based permissions mapping
 */
export const GroupRolePermissions: Record<GroupRole, GroupPermissions> = {
  owner: {
    canManageMembers: true,
    canApproveFunds: true,
    canTransferFunds: true,
    canViewLedger: true,
    canEditSettings: true,
    maxTransferWithoutApproval: Infinity,
  },
  admin: {
    canManageMembers: true,
    canApproveFunds: true,
    canTransferFunds: true,
    canViewLedger: true,
    canEditSettings: false,
    maxTransferWithoutApproval: 10000,
  },
  treasurer: {
    canManageMembers: false,
    canApproveFunds: true,
    canTransferFunds: true,
    canViewLedger: true,
    canEditSettings: false,
    maxTransferWithoutApproval: 5000,
  },
  member: {
    canManageMembers: false,
    canApproveFunds: false,
    canTransferFunds: true,
    canViewLedger: true,
    canEditSettings: false,
    maxTransferWithoutApproval: 1000,
  },
  viewer: {
    canManageMembers: false,
    canApproveFunds: false,
    canTransferFunds: false,
    canViewLedger: true,
    canEditSettings: false,
    maxTransferWithoutApproval: 0,
  },
};

/**
 * Group settings - configurable by owner/admin
 */
export interface GroupSettings {
  requireApprovalAbove: number; // Token threshold for approval workflow
  allowMemberWithdrawals: boolean; // Can members withdraw their contributions
  contributionCycle: ContributionCycle; // For stokvels
  contributionAmount: number; // Required contribution per cycle (for stokvels)
  penaltyPercentage: number; // Penalty for missed contributions (0-100)
}

/**
 * Extended settings for stokvel groups
 */
export interface StokvelSettings extends GroupSettings {
  payoutType: PayoutType;
  payoutSchedule: string; // Cron expression for scheduled payouts
  currentPayoutRecipient: string | null; // For rotating payouts
  nextPayoutDate: Timestamp | null;
  payoutOrder: string[]; // For rotating, ordered list of member IDs
  lastPenaltyDate?: string | null; // YYYY-MM key for idempotent penalty processing
  lastPayoutDate?: string | null; // YYYY-MM key for idempotent payout processing
}

/**
 * Group document structure
 */
export interface Group {
  id: string;
  type: GroupType;
  name: string;
  description: string;
  avatarUrl: string | null;
  ownerId: string;
  memberIds: string[]; // Array of member user IDs for quick access checks
  memberCount: number;
  totalBalance: number; // Cached from ledger account
  status: GroupStatus;
  settings: GroupSettings;
  stokvelSettings: StokvelSettings | null; // Only for stokvel type
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

/**
 * Group member document structure
 */
export interface GroupMember {
  id: string;
  groupId: string;
  userId: string;
  role: GroupRole;
  displayName: string;
  avatarUrl: string | null;
  status: GroupMemberStatus;
  contributionBalance: number; // How much this member has contributed lifetime
  joinedAt: Timestamp | null; // null if still invited
  invitedBy: string;
  invitedAt: Timestamp;
}

/**
 * Group transaction document structure
 */
export interface GroupTransaction {
  id: string;
  groupId: string;
  journalId: string | null; // Links to ledger journal when completed
  type: GroupTransactionType;
  amount: number;
  fromMemberId: string | null;
  toMemberId: string | null;
  description: string;
  status: GroupTransactionStatus;
  approvedBy: string | null;
  createdBy: string;
  createdAt: Timestamp;
  completedAt: Timestamp | null;
  idempotencyKey?: string | null; // Client-generated UUID for deduplication
}

/**
 * Pending approval document structure
 */
export interface PendingApproval {
  id: string;
  groupId: string;
  transactionId: string;
  requiredApprovers: string[]; // User IDs who can approve
  approvers: string[]; // User IDs who have approved
  rejectedBy: string | null;
  status: "pending" | "approved" | "rejected" | "expired";
  createdAt: Timestamp;
  expiresAt: Timestamp;
}

/**
 * Input for creating a new group
 */
export interface CreateGroupInput {
  type: GroupType;
  name: string;
  description: string;
  avatarUrl?: string | null;
  settings?: Partial<GroupSettings>;
  stokvelSettings?: Partial<StokvelSettings>;
}

/**
 * Input for updating group settings
 */
export interface UpdateGroupInput {
  name?: string;
  description?: string;
  avatarUrl?: string | null;
  settings?: Partial<GroupSettings>;
  stokvelSettings?: Partial<StokvelSettings>;
}

/**
 * Input for inviting a member
 */
export interface InviteMemberInput {
  groupId: string;
  userId: string;
  role: GroupRole;
  displayName: string;
  avatarUrl?: string | null;
}

// ============================================================================
// GROUP CONSTANTS
// ============================================================================

/**
 * Group configuration constants
 */
export const GroupConfig = {
  // Collection paths
  COLLECTION_GROUPS: "groups",
  SUBCOLLECTION_MEMBERS: "members",
  SUBCOLLECTION_TRANSACTIONS: "transactions",
  SUBCOLLECTION_APPROVALS: "pendingApprovals",

  // Default settings
  DEFAULT_APPROVAL_THRESHOLD: 5000, // Require approval above 5000 tokens
  DEFAULT_PENALTY_PERCENTAGE: 5, // 5% penalty for missed contributions
  DEFAULT_CONTRIBUTION_AMOUNT: 1000, // 1000 tokens default contribution

  // Limits
  MAX_GROUP_NAME_LENGTH: 100,
  MAX_GROUP_DESCRIPTION_LENGTH: 500,
  MAX_MEMBERS_PER_GROUP: 100,
  MIN_MEMBERS_FOR_STOKVEL: 3, // Minimum members for a stokvel

  // Approval expiration
  APPROVAL_EXPIRY_HOURS: 72, // Approvals expire after 72 hours

  // Invitation expiration
  INVITATION_EXPIRY_DAYS: 7, // Invitations expire after 7 days
} as const;

/**
 * Group-specific error codes
 */
export const GroupErrorCodes = {
  // Group errors
  GROUP_NOT_FOUND: "GROUP_NOT_FOUND",
  GROUP_SUSPENDED: "GROUP_SUSPENDED",
  GROUP_CLOSED: "GROUP_CLOSED",
  GROUP_NAME_TOO_LONG: "GROUP_NAME_TOO_LONG",
  GROUP_DESCRIPTION_TOO_LONG: "GROUP_DESCRIPTION_TOO_LONG",

  // Member errors
  MEMBER_NOT_FOUND: "MEMBER_NOT_FOUND",
  MEMBER_ALREADY_EXISTS: "MEMBER_ALREADY_EXISTS",
  MEMBER_BLOCKED: "MEMBER_BLOCKED",
  NOT_A_MEMBER: "NOT_A_MEMBER",
  CANNOT_REMOVE_OWNER: "CANNOT_REMOVE_OWNER",
  MAX_MEMBERS_REACHED: "MAX_MEMBERS_REACHED",
  INSUFFICIENT_MEMBERS: "INSUFFICIENT_MEMBERS",

  // Permission errors
  PERMISSION_DENIED: "GROUP_PERMISSION_DENIED",
  NOT_AUTHORIZED_TO_APPROVE: "NOT_AUTHORIZED_TO_APPROVE",
  CANNOT_INVITE_SELF: "CANNOT_INVITE_SELF",
  CANNOT_CHANGE_OWN_ROLE: "CANNOT_CHANGE_OWN_ROLE",

  // Transaction errors
  TRANSACTION_NOT_FOUND: "GROUP_TRANSACTION_NOT_FOUND",
  TRANSACTION_ALREADY_APPROVED: "TRANSACTION_ALREADY_APPROVED",
  TRANSACTION_ALREADY_REJECTED: "TRANSACTION_ALREADY_REJECTED",
  TRANSACTION_EXPIRED: "TRANSACTION_EXPIRED",
  WITHDRAWALS_NOT_ALLOWED: "WITHDRAWALS_NOT_ALLOWED",
  AMOUNT_EXCEEDS_BALANCE: "AMOUNT_EXCEEDS_BALANCE",

  // Invitation errors
  INVITATION_NOT_FOUND: "INVITATION_NOT_FOUND",
  INVITATION_EXPIRED: "INVITATION_EXPIRED",
  INVITATION_ALREADY_ACCEPTED: "INVITATION_ALREADY_ACCEPTED",

  // Stokvel errors
  STOKVEL_MIN_MEMBERS_REQUIRED: "STOKVEL_MIN_MEMBERS_REQUIRED",
  CONTRIBUTION_MISSED: "CONTRIBUTION_MISSED",
  PAYOUT_NOT_DUE: "PAYOUT_NOT_DUE",
} as const;
