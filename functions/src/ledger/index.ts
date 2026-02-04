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

import {
  SystemAccounts,
  LedgerConfig,
  AccountId,
  IdempotencyKey,
  PostJournalResult,
  JournalEntryInput,
} from "./types";
import { getOrCreateUserAccount, createSupplierAccount } from "./accounts";
import { postJournal, createEarningEntries, createReferralEntries, createTransferEntries } from "./journals";
import {
  getOrCreateDefaultSubAccount,
  getSubAccount,
  creditSubAccount,
  debitSubAccount,
} from "./subAccounts";

/**
 * Process user earning with automatic pot split
 *
 * Distributes tokens: 90% to user's sub-account, 5% to daily pot, 5% to weekly pot
 *
 * @param userId - The user's ID
 * @param totalAmount - Total tokens earned
 * @param engagementId - Reference to the engagement
 * @param description - Description for the journal entry
 * @param subAccountId - The sub-account to credit (optional, uses default if not provided)
 * @param accountTypeId - The account type for audit (optional)
 * @param metadata - Additional metadata
 */
export async function processEarningWithSplit(
  userId: string,
  totalAmount: number,
  engagementId: string,
  description: string,
  subAccountId?: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
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

  // Create earning entries with split
  const entries = createEarningEntries(userId, totalAmount, SystemAccounts.TREASURY);

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
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Credit the user's sub-account with their share (90%)
  if (userShare > 0 && !journalResult.isDuplicate) {
    await creditSubAccount(userId, finalSubAccountId, userShare);
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
 * Seed treasury with initial tokens (admin function)
 *
 * This creates tokens "out of thin air" by crediting treasury.
 * Treasury will have a negative balance representing tokens in circulation.
 * Should only be called during initial system setup.
 */
export async function seedTreasury(
  amount: number,
  reason: string,
  adminUserId: string
): Promise<PostJournalResult> {
  // For seeding, we credit the target account without a corresponding debit
  // This is the ONLY operation that creates an imbalance
  // We handle this by having a special "system:mint" account that can go negative

  // Actually, let's keep it balanced by having treasury start negative
  // When tokens are earned, treasury is debited (goes more negative)
  // When tokens are cashed out, treasury is credited (becomes less negative)

  // For initial seeding, we don't need to create tokens - treasury starts at 0
  // and goes negative as tokens are distributed

  // This function should only be used if we need to "reset" or add more capacity
  console.log(
    `Treasury seed requested: ${amount} tokens by ${adminUserId} - ${reason}`
  );

  // For now, just log this - actual token creation happens through earning
  return {
    success: true,
    data: undefined as any,
    journalId: "seed_not_required",
    isDuplicate: false,
  };
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
