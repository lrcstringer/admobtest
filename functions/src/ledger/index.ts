/**
 * Trust Ledger System - Main Entry Point
 *
 * This module provides a complete double-entry bookkeeping ledger system
 * for the iMali token economy. All token movements are tracked through
 * balanced journal entries ensuring full auditability and integrity.
 *
 * Key Features:
 * - Double-entry bookkeeping (every transaction has debits = credits)
 * - Immutable journal entries (corrections via reversal, never mutation)
 * - Idempotent operations (safe for retries)
 * - Full audit trail
 * - Reconciliation and integrity verification
 *
 * Account Types:
 * - system: iMali system accounts (treasury, referrals, operations, fees)
 * - pot: Daily and weekly pot accounts
 * - user: Individual user wallet accounts
 * - supplier: Service provider accounts (Vodacom, MTN, Eskom, etc.)
 * - cashout: Pending cashout holding account
 *
 * Token Flows:
 * - Earning: treasury → user (90%) + daily pot (5%) + weekly pot (5%)
 * - Pot Win: pot → user (winner)
 * - Purchase: user → supplier
 * - Referral: referrals → referrer + referee
 * - P2P: user → user
 * - Cashout: user → pending → treasury (burn)
 */

// Re-export all types
export * from "./types";

// Re-export sub-account functions
export {
  getSubAccount,
  getUserSubAccounts,
  getDefaultSubAccount,
  getOrCreateDefaultSubAccount,
  getOrCreateBrandSubAccount,
  getAccountType,
  getAccountTypeRules,
  validateSubAccountAllows,
  validatePurchaseAllowed,
  validateSubAccountBalance,
  creditSubAccount,
  debitSubAccount,
  transferBetweenSubAccounts,
  getSubAccountBalance,
  getUserTotalBalance,
  getUserDefaultBalance,
  deactivateSubAccount,
  deleteAllSubAccounts,
  createAccountType,
  listAccountTypes,
} from "./subAccounts";

// Re-export account functions
export {
  getAccount,
  getAccountOrThrow,
  getAccounts,
  getUserAccount,
  getOrCreateUserAccount,
  getAccountsByType,
  createAccount,
  initializeSystemAccounts,
  createSupplierAccount,
  freezeAccount,
  unfreezeAccount,
  closeAccount,
  validateAccountActive,
  validateSufficientBalance,
  logAuditEvent,
  getBalance,
  getBalances,
  getTotalUserBalance,
  getPotBalances,
} from "./accounts";

// Re-export journal functions
export {
  postJournal,
  reverseJournal,
  getJournal,
  getJournalByIdempotencyKey,
  getAccountJournals,
  getJournalsByReference,
  getRecentJournals,
  calculateNetChange,
  createTransferEntries,
  createEarningEntries,
  createReferralEntries,
} from "./journals";

// Re-export reconciliation functions
export {
  reconcileAccount,
  reconcileAllAccounts,
  calculateBalanceFromEntries,
  verifyJournalBalanced,
  verifyAllJournalsBalanced,
  verifySystemBalance,
  getReconciliationHistory,
  getAccountsWithDrift,
  getLedgerStatistics,
  repairAccountBalance,
} from "./reconciliation";

// Re-export group account functions
export {
  getOrCreateGroupAccount,
  getGroupBalance,
  processGroupContribution,
  processGroupWithdrawal,
  processGroupPayout,
  processGroupPenalty,
  deleteGroupAccount,
} from "./groupAccounts";

// ============================================================================
// HIGH-LEVEL TRANSACTION HELPERS
// ============================================================================

import * as admin from "firebase-admin";
import {
  SystemAccounts,
  LedgerConfig,
  AccountId,
  IdempotencyKey,
  PostJournalResult,
  JournalEntryInput,
} from "./types";
import { getOrCreateUserAccount, createSupplierAccount, initializeSystemAccounts, getBalance } from "./accounts";
import { postJournal, createEarningEntries, createReferralEntries, createTransferEntries } from "./journals";
import {
  getOrCreateDefaultSubAccount,
  getSubAccount,
  creditSubAccount,
  debitSubAccount,
} from "./subAccounts";

// Module-level promise to ensure system accounts are initialized once per cold start.
// This is a SAFETY NET — admins should call initializeTrustLedger explicitly before
// launching the consumer app. This fallback prevents crashes if they forget.
let _systemAccountsInitPromise: Promise<void> | null = null;

async function ensureSystemAccounts(): Promise<void> {
  if (!_systemAccountsInitPromise) {
    console.warn(
      "ensureSystemAccounts: auto-initializing system accounts (safety net). " +
      "Admins should call initializeTrustLedger explicitly before launch."
    );
    _systemAccountsInitPromise = initializeSystemAccounts().catch((err) => {
      // Reset so next call retries
      _systemAccountsInitPromise = null;
      throw err;
    });
  }
  return _systemAccountsInitPromise;
}

/**
 * Process user earning with automatic pot split
 *
 * Distributes tokens: 90% to user's sub-account, 5% to daily pot, 5% to weekly pot
 *
 * For client-funded threads:
 * - If clientId and clientSubAccountId are provided, debits the client's sub-account
 *   instead of the treasury
 * - Uses `client:{clientId}` as the source account in the journal entry
 *
 * @param userId - The user's ID
 * @param totalAmount - Total tokens earned
 * @param engagementId - Reference to the engagement
 * @param description - Description for the journal entry
 * @param subAccountId - The sub-account to credit (optional, uses default if not provided)
 * @param accountTypeId - The account type for audit (optional)
 * @param metadata - Additional metadata
 * @param clientId - Client ID for client-funded threads (optional)
 * @param clientSubAccountId - Client sub-account to debit (optional, required if clientId provided)
 */
export async function processEarningWithSplit(
  userId: string,
  totalAmount: number,
  engagementId: string,
  description: string,
  subAccountId?: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>,
  clientId?: string,
  clientSubAccountId?: string
): Promise<PostJournalResult> {
  // Ensure system accounts exist (treasury, pots, etc.) — runs once per cold start
  await ensureSystemAccounts();

  // Ensure user account exists (legacy ledgerAccounts)
  await getOrCreateUserAccount(userId);

  // Get or create sub-account if not provided
  let finalSubAccountId = subAccountId;
  if (!finalSubAccountId) {
    const result = await getOrCreateDefaultSubAccount(userId);
    finalSubAccountId = result.subAccountId;
  }

  // Calculate user share
  const userShare = Math.floor(totalAmount * LedgerConfig.EARNING_USER_SHARE);
  const dailyPotShare = Math.floor(totalAmount * LedgerConfig.EARNING_DAILY_POT_SHARE);
  const weeklyPotShare = totalAmount - userShare - dailyPotShare;

  // Determine source account: client or treasury
  const sourceAccountId = clientId
    ? AccountId.client(clientId)
    : SystemAccounts.TREASURY;

  // Create earning entries with split
  const entries = createEarningEntries(userId, totalAmount, sourceAccountId);

  // Post journal entry
  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.earning(engagementId),
    type: "earn",
    description,
    entries,
    referenceType: "engagement",
    referenceId: engagementId,
    initiatedBy: "system",
    subAccountId: finalSubAccountId,
    accountTypeId: accountTypeId || null,
    metadata: {
      ...metadata,
      totalAmount,
      userId,
      userShare,
      dailyPotShare,
      weeklyPotShare,
      clientId: clientId || null,
      clientSubAccountId: clientSubAccountId || null,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Non-blocking treasury balance check after successful earning
  if (!clientId) {
    checkTreasuryBalance().catch((err) =>
      console.error("Treasury balance check failed:", err)
    );
  }

  // Credit the user's sub-account with their share (90%)
  if (userShare > 0 && !journalResult.isDuplicate) {
    await creditSubAccount(userId, finalSubAccountId, userShare);
  }

  // If client-funded, debit the client's sub-account
  if (clientId && clientSubAccountId && !journalResult.isDuplicate) {
    const db = admin.firestore();
    await db
      .collection("clients")
      .doc(clientId)
      .collection("subAccounts")
      .doc(clientSubAccountId)
      .update({
        balance: admin.firestore.FieldValue.increment(-totalAmount),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
  }

  return journalResult;
}

/**
 * Process pot win - transfer pot balance to winner's sub-account
 *
 * @param potType - "daily" or "weekly"
 * @param winnerId - The winner's user ID
 * @param amount - Token amount won
 * @param potDrawId - Reference to the pot draw
 * @param subAccountId - The sub-account to credit (optional, uses default if not provided)
 * @param metadata - Additional metadata
 */
export async function processPotWin(
  potType: "daily" | "weekly",
  winnerId: string,
  amount: number,
  potDrawId: string,
  subAccountId?: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  // Ensure winner account exists
  await getOrCreateUserAccount(winnerId);

  // Get or create sub-account if not provided
  let finalSubAccountId = subAccountId;
  if (!finalSubAccountId) {
    const result = await getOrCreateDefaultSubAccount(winnerId);
    finalSubAccountId = result.subAccountId;
  }

  const potAccountId = potType === "daily" ? SystemAccounts.DAILY_POT : SystemAccounts.WEEKLY_POT;

  const entries: JournalEntryInput[] = [
    {
      accountId: potAccountId,
      entryType: "debit",
      amount,
      description: `${potType} pot payout`,
    },
    {
      accountId: AccountId.user(winnerId),
      entryType: "credit",
      amount,
      description: `${potType} pot winnings`,
    },
  ];

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.potWin(potDrawId, winnerId),
    type: "pot_win",
    description: `${potType.charAt(0).toUpperCase() + potType.slice(1)} pot win: ${amount} tokens`,
    entries,
    referenceType: "pot_draw",
    referenceId: potDrawId,
    initiatedBy: "system",
    subAccountId: finalSubAccountId,
    metadata: {
      ...metadata,
      potType,
      winnerId,
      amount,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Credit the winner's sub-account
  if (!journalResult.isDuplicate) {
    await creditSubAccount(winnerId, finalSubAccountId, amount);
  }

  return journalResult;
}

/**
 * Process purchase - transfer tokens from user's sub-account to supplier
 *
 * @param userId - The user's ID
 * @param providerId - The service provider ID
 * @param providerName - The service provider name
 * @param amount - Token amount for purchase
 * @param purchaseId - Reference to the purchase
 * @param subAccountId - The sub-account to debit (required)
 * @param accountTypeId - The account type for audit (optional)
 * @param metadata - Additional metadata
 */
export async function processPurchaseTransaction(
  userId: string,
  providerId: string,
  providerName: string,
  amount: number,
  purchaseId: string,
  subAccountId: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  // Ensure accounts exist
  await getOrCreateUserAccount(userId);
  await createSupplierAccount(providerId, providerName);

  // Validate sub-account has sufficient balance
  const subAccount = await getSubAccount(userId, subAccountId);
  if (!subAccount) {
    return {
      success: false,
      error: `Sub-account not found: ${subAccountId}`,
      errorCode: "SUB_ACCOUNT_NOT_FOUND",
    };
  }
  if (subAccount.balance < amount) {
    return {
      success: false,
      error: `Insufficient balance: has ${subAccount.balance}, needs ${amount}`,
      errorCode: "INSUFFICIENT_SUB_ACCOUNT_BALANCE",
    };
  }

  const entries = createTransferEntries(
    AccountId.user(userId),
    AccountId.supplier(providerId),
    amount,
    `Purchase from ${providerName}`
  );

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.purchase(purchaseId),
    type: "purchase",
    description: `Purchase: ${amount} tokens to ${providerName}`,
    entries,
    referenceType: "purchase",
    referenceId: purchaseId,
    initiatedBy: userId,
    subAccountId,
    accountTypeId: accountTypeId || subAccount.accountTypeId,
    metadata: {
      ...metadata,
      userId,
      providerId,
      providerName,
      amount,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Debit the user's sub-account
  if (!journalResult.isDuplicate) {
    await debitSubAccount(userId, subAccountId, amount);
  }

  return journalResult;
}

/**
 * Process referral rewards - credit both referrer and referee's default sub-accounts
 *
 * @param referrerId - The referrer's user ID
 * @param refereeId - The referee's user ID
 * @param referralId - Reference to the referral
 * @param referrerSubAccountId - Referrer's sub-account (optional, uses default)
 * @param refereeSubAccountId - Referee's sub-account (optional, uses default)
 * @param metadata - Additional metadata
 */
export async function processReferralRewards(
  referrerId: string,
  refereeId: string,
  referralId: string,
  referrerSubAccountId?: string,
  refereeSubAccountId?: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  // Ensure accounts exist
  await getOrCreateUserAccount(referrerId);
  await getOrCreateUserAccount(refereeId);

  // Get or create sub-accounts
  let finalReferrerSubAccountId = referrerSubAccountId;
  let finalRefereeSubAccountId = refereeSubAccountId;

  if (!finalReferrerSubAccountId) {
    const result = await getOrCreateDefaultSubAccount(referrerId);
    finalReferrerSubAccountId = result.subAccountId;
  }
  if (!finalRefereeSubAccountId) {
    const result = await getOrCreateDefaultSubAccount(refereeId);
    finalRefereeSubAccountId = result.subAccountId;
  }

  const entries = createReferralEntries(referrerId, refereeId, SystemAccounts.REFERRALS);

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.referral(referralId),
    type: "referral_reward",
    description: `Referral rewards: ${LedgerConfig.REFERRER_REWARD} to referrer, ${LedgerConfig.REFEREE_REWARD} to referee`,
    entries,
    referenceType: "referral",
    referenceId: referralId,
    initiatedBy: "system",
    metadata: {
      ...metadata,
      referrerId,
      refereeId,
      referrerReward: LedgerConfig.REFERRER_REWARD,
      refereeReward: LedgerConfig.REFEREE_REWARD,
      referrerSubAccountId: finalReferrerSubAccountId,
      refereeSubAccountId: finalRefereeSubAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Credit both sub-accounts
  if (!journalResult.isDuplicate) {
    await creditSubAccount(referrerId, finalReferrerSubAccountId, LedgerConfig.REFERRER_REWARD);
    await creditSubAccount(refereeId, finalRefereeSubAccountId, LedgerConfig.REFEREE_REWARD);
  }

  return journalResult;
}

/**
 * Process P2P transfer between users' sub-accounts
 *
 * @param senderId - The sender's user ID
 * @param recipientId - The recipient's user ID
 * @param amount - Token amount to transfer
 * @param transferId - Reference to the transfer
 * @param senderSubAccountId - Sender's sub-account (required)
 * @param recipientSubAccountId - Recipient's sub-account (optional, uses default)
 * @param message - Optional message
 * @param metadata - Additional metadata
 */
export async function processP2PTransfer(
  senderId: string,
  recipientId: string,
  amount: number,
  transferId: string,
  senderSubAccountId: string,
  recipientSubAccountId?: string,
  message?: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  // Ensure accounts exist
  await getOrCreateUserAccount(senderId);
  await getOrCreateUserAccount(recipientId);

  // Get sender's sub-account to validate balance
  const senderSubAccount = await getSubAccount(senderId, senderSubAccountId);
  if (!senderSubAccount) {
    return {
      success: false,
      error: `Sender sub-account not found: ${senderSubAccountId}`,
      errorCode: "SUB_ACCOUNT_NOT_FOUND",
    };
  }
  if (senderSubAccount.balance < amount) {
    return {
      success: false,
      error: `Insufficient balance: has ${senderSubAccount.balance}, needs ${amount}`,
      errorCode: "INSUFFICIENT_SUB_ACCOUNT_BALANCE",
    };
  }

  // Get or create recipient's sub-account
  let finalRecipientSubAccountId = recipientSubAccountId;
  if (!finalRecipientSubAccountId) {
    const result = await getOrCreateDefaultSubAccount(recipientId);
    finalRecipientSubAccountId = result.subAccountId;
  }

  const entries = createTransferEntries(
    AccountId.user(senderId),
    AccountId.user(recipientId),
    amount,
    message || `P2P transfer`
  );

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.p2pTransfer(transferId),
    type: "p2p_transfer",
    description: `P2P: ${amount} tokens from ${senderId} to ${recipientId}`,
    entries,
    referenceType: "transfer",
    referenceId: transferId,
    initiatedBy: senderId,
    subAccountId: senderSubAccountId,
    accountTypeId: senderSubAccount.accountTypeId,
    metadata: {
      ...metadata,
      senderId,
      recipientId,
      amount,
      message,
      senderSubAccountId,
      recipientSubAccountId: finalRecipientSubAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Transfer between sub-accounts
  if (!journalResult.isDuplicate) {
    await debitSubAccount(senderId, senderSubAccountId, amount);
    await creditSubAccount(recipientId, finalRecipientSubAccountId, amount);
  }

  return journalResult;
}

/**
 * Initiate cashout - move tokens from sub-account to pending
 *
 * @param userId - The user's ID
 * @param amount - Token amount to cash out
 * @param cashoutId - Reference to the cashout
 * @param subAccountId - The sub-account to debit (required)
 * @param metadata - Additional metadata
 */
export async function initiateCashout(
  userId: string,
  amount: number,
  cashoutId: string,
  subAccountId: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  // Validate sub-account has sufficient balance
  const subAccount = await getSubAccount(userId, subAccountId);
  if (!subAccount) {
    return {
      success: false,
      error: `Sub-account not found: ${subAccountId}`,
      errorCode: "SUB_ACCOUNT_NOT_FOUND",
    };
  }
  if (subAccount.balance < amount) {
    return {
      success: false,
      error: `Insufficient balance: has ${subAccount.balance}, needs ${amount}`,
      errorCode: "INSUFFICIENT_SUB_ACCOUNT_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    {
      accountId: AccountId.user(userId),
      entryType: "debit",
      amount,
      description: "Cashout initiated",
    },
    {
      accountId: SystemAccounts.CASHOUT_PENDING,
      entryType: "credit",
      amount,
      description: "Cashout pending",
    },
  ];

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.cashoutInitiate(cashoutId),
    type: "cashout_initiate",
    description: `Cashout initiated: ${amount} tokens`,
    entries,
    referenceType: "cashout",
    referenceId: cashoutId,
    initiatedBy: userId,
    subAccountId,
    accountTypeId: subAccount.accountTypeId,
    metadata: {
      ...metadata,
      userId,
      amount,
      subAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Debit the user's sub-account
  if (!journalResult.isDuplicate) {
    await debitSubAccount(userId, subAccountId, amount);
  }

  return journalResult;
}

/**
 * Complete cashout - burn tokens (return to treasury)
 */
export async function completeCashout(
  cashoutId: string,
  amount: number,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  const entries: JournalEntryInput[] = [
    {
      accountId: SystemAccounts.CASHOUT_PENDING,
      entryType: "debit",
      amount,
      description: "Cashout completed",
    },
    {
      accountId: SystemAccounts.TREASURY,
      entryType: "credit",
      amount,
      description: "Tokens returned to treasury",
    },
  ];

  return postJournal({
    idempotencyKey: IdempotencyKey.cashoutComplete(cashoutId),
    type: "cashout_complete",
    description: `Cashout completed: ${amount} tokens burned`,
    entries,
    referenceType: "cashout",
    referenceId: cashoutId,
    initiatedBy: "system",
    metadata: {
      ...metadata,
      amount,
    },
  });
}

/**
 * Fail/refund cashout - return tokens to user's sub-account
 *
 * @param userId - The user's ID
 * @param cashoutId - Reference to the cashout
 * @param amount - Token amount to refund
 * @param reason - Reason for failure
 * @param subAccountId - The sub-account to credit (required)
 * @param metadata - Additional metadata
 */
export async function failCashout(
  userId: string,
  cashoutId: string,
  amount: number,
  reason: string,
  subAccountId: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  const entries: JournalEntryInput[] = [
    {
      accountId: SystemAccounts.CASHOUT_PENDING,
      entryType: "debit",
      amount,
      description: "Cashout failed - refunding",
    },
    {
      accountId: AccountId.user(userId),
      entryType: "credit",
      amount,
      description: `Cashout refund: ${reason}`,
    },
  ];

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.cashoutFailed(cashoutId),
    type: "cashout_failed",
    description: `Cashout failed: ${amount} tokens refunded - ${reason}`,
    entries,
    referenceType: "cashout",
    referenceId: cashoutId,
    initiatedBy: "system",
    subAccountId,
    metadata: {
      ...metadata,
      userId,
      amount,
      reason,
      subAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Credit the user's sub-account with the refund
  if (!journalResult.isDuplicate) {
    await creditSubAccount(userId, subAccountId, amount);
  }

  return journalResult;
}

/**
 * Seed treasury with tokens (admin function)
 *
 * Mints new tokens by debiting system:mint and crediting system:treasury.
 * system:mint is the ONLY account allowed to go negative — it tracks total
 * tokens ever created. Treasury must have a positive balance to fund earnings.
 *
 * @param amount - Number of tokens to mint (must be > 0)
 * @param reason - Why the seed is happening (audit trail)
 * @param adminUserId - The admin performing the seed
 */
export async function seedTreasury(
  amount: number,
  reason: string,
  adminUserId: string
): Promise<PostJournalResult> {
  if (amount <= 0) {
    return {
      success: false,
      error: "Seed amount must be positive",
      errorCode: "INVALID_AMOUNT",
    };
  }

  // Ensure system accounts (including mint) exist
  await ensureSystemAccounts();

  const entries: JournalEntryInput[] = [
    {
      accountId: SystemAccounts.MINT,
      entryType: "debit",
      amount,
      description: `Mint ${amount} tokens`,
    },
    {
      accountId: SystemAccounts.TREASURY,
      entryType: "credit",
      amount,
      description: `Treasury seed: ${reason}`,
    },
  ];

  // Use timestamp + adminId so the same admin can seed multiple times
  const idempotencyKey = `${IdempotencyKey.systemSeed(SystemAccounts.TREASURY)}:${Date.now()}:${adminUserId}`;

  return postJournal({
    idempotencyKey,
    type: "system_seed",
    description: `Treasury seed: ${amount} tokens — ${reason}`,
    entries,
    referenceType: "system",
    referenceId: "treasury_seed",
    initiatedBy: adminUserId,
    metadata: {
      amount,
      reason,
      adminUserId,
    },
  });
}

// ============================================================================
// TREASURY MONITORING
// ============================================================================

/** Default threshold: warn when treasury has fewer than 100,000 tokens */
const TREASURY_LOW_BALANCE_THRESHOLD = 100_000;

/**
 * Check treasury balance and create admin notifications if running low.
 *
 * - Below threshold → "treasury_low_balance" notification (max 1 per 24h)
 * - At or below zero → "treasury_depleted" notification (max 1 per 1h)
 */
export async function checkTreasuryBalance(): Promise<void> {
  const db = admin.firestore();
  const balance = await getBalance(SystemAccounts.TREASURY);

  if (balance > TREASURY_LOW_BALANCE_THRESHOLD) {
    return; // Healthy
  }

  const now = Date.now();

  if (balance <= 0) {
    // CRITICAL — treasury depleted
    const oneHourAgo = new Date(now - 60 * 60 * 1000);
    const existing = await db
      .collection("adminNotifications")
      .where("type", "==", "treasury_depleted")
      .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(oneHourAgo))
      .limit(1)
      .get();

    if (existing.empty) {
      await db.collection("adminNotifications").add({
        type: "treasury_depleted",
        severity: "critical",
        title: "Treasury Depleted",
        message: `Treasury balance is ${balance} tokens. All earnings will fail until treasury is seeded.`,
        balance,
        createdAt: admin.firestore.Timestamp.now(),
        read: false,
      });
      console.error(`CRITICAL: Treasury depleted — balance=${balance}`);
    }
    return;
  }

  // WARNING — low balance
  const twentyFourHoursAgo = new Date(now - 24 * 60 * 60 * 1000);
  const existing = await db
    .collection("adminNotifications")
    .where("type", "==", "treasury_low_balance")
    .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(twentyFourHoursAgo))
    .limit(1)
    .get();

  if (existing.empty) {
    await db.collection("adminNotifications").add({
      type: "treasury_low_balance",
      severity: "warning",
      title: "Treasury Balance Low",
      message: `Treasury balance is ${balance} tokens (threshold: ${TREASURY_LOW_BALANCE_THRESHOLD}). Consider seeding more tokens.`,
      balance,
      threshold: TREASURY_LOW_BALANCE_THRESHOLD,
      createdAt: admin.firestore.Timestamp.now(),
      read: false,
    });
    console.warn(`WARNING: Treasury low — balance=${balance}, threshold=${TREASURY_LOW_BALANCE_THRESHOLD}`);
  }
}

// ============================================================================
// INITIALIZATION
// ============================================================================

/**
 * Initialize the ledger system
 *
 * Call this once during deployment or system setup.
 * Creates all system accounts if they don't exist.
 */
export async function initializeLedger(): Promise<void> {
  console.log("Initializing Trust Ledger System...");

  // Import here to avoid circular dependency
  const { initializeSystemAccounts } = await import("./accounts");

  await initializeSystemAccounts();

  console.log("Trust Ledger System initialized successfully");
}
