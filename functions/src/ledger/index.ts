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
 * - cbook: Cash Book accounts (asset/debit-normal — business, trust)
 * - client: Brand partners (advertisers, campaign sponsors)
 * - client_subacc: Client sub-accounts (on-ledger budgets)
 * - system: iMali system accounts (cashout_pending)
 * - pot: Daily and weekly pot accounts
 * - user: Individual user wallet accounts
 * - supplier: Service provider accounts (Vodacom, MTN, Eskom, etc.)
 * - group: Group accounts (stokvels, family, organizations, clubs)
 *
 * Token Flows:
 * - Funding: cbook → client (also seeds cbook as asset debit)
 * - Sub-account: client → client_subacc
 * - Earning: client/client_subacc → user (90%) + daily pot (5%) + weekly pot (5%)
 * - Pot Win: pot → user (winner)
 * - Purchase: user → supplier
 * - Referral: client:imalichat → referrer + referee
 * - P2P: user → user
 * - Cashout: user → pending → supplier
 */

// Re-export all types
export * from "./types";

// Re-export sub-account functions
export {
  getSubAccount,
  getUserSubAccounts,
  getDefaultSubAccount,
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
  validateMainWalletBalance,
  deactivateSubAccount,
  deleteAllSubAccounts,
  createAccountType,
  listAccountTypes,
  updateAccountType,
  deactivateAccountType,
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
  ensureSystemAccounts,
  createSupplierAccount,
  createClientAccount,
  getClientAccount,
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
  logJournalPostedAudit,
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
import { logger } from "firebase-functions/v2";
import {
  SystemAccounts,
  LedgerConfig,
  AccountId,
  IdempotencyKey,
  PostJournalInput,
  PostJournalResult,
  JournalEntryInput,
  SubAccount,
  SubAccountConfig,
} from "./types";
import { getOrCreateUserAccount, createSupplierAccount, ensureSystemAccounts } from "./accounts";
import { postJournal, createEarningEntries, createReferralEntries, createTransferEntries, logJournalPostedAudit } from "./journals";
import {
  getSubAccount,
  getUserSubAccounts,
  getAccountTypeRules,
  validateSubAccountAllows,
  creditSubAccount,
  debitSubAccount,
  validateMainWalletBalance,
} from "./subAccounts";

const db = admin.firestore();

/**
 * Process user earning with automatic pot split
 *
 * Distributes tokens: 90% to user's sub-account, 5% to daily pot, 5% to weekly pot
 *
 * The tokenSourceAccountId is the ledger account to debit (either client:{clientId}
 * or client_subacc:{subAccountId}). The journal handles the balance change on-ledger —
 * no off-ledger sub-account decrement is needed.
 *
 * @param userId - The user's ID
 * @param totalAmount - Total tokens earned
 * @param engagementId - Reference to the engagement
 * @param description - Description for the journal entry
 * @param tokenSourceAccountId - Ledger account to debit (e.g. "client:abc" or "client_subacc:xyz")
 * @param userSubAccountId - The user's sub-account to credit (optional, uses default if not provided)
 * @param accountTypeId - The account type for audit (optional)
 * @param metadata - Additional metadata
 */
export async function processEarningWithSplit(
  userId: string,
  totalAmount: number,
  engagementId: string,
  description: string,
  tokenSourceAccountId: string,
  userSubAccountId?: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>,
): Promise<PostJournalResult> {
  // Ensure system accounts exist (pots, etc.) — runs once per cold start
  await ensureSystemAccounts();

  // Ensure user account exists (legacy ledgerAccounts)
  await getOrCreateUserAccount(userId);

  // Sub-account is optional: if provided (brand sub-account), credit it.
  // If not provided, tokens go to main wallet (journal only, no sub-account op).
  const finalSubAccountId = userSubAccountId || undefined;

  // Calculate token split — floor pot shares to avoid fractional tokens.
  const dailyPotShare = Math.floor(totalAmount * LedgerConfig.EARNING_DAILY_POT_SHARE);
  const weeklyPotShare = Math.floor(totalAmount * LedgerConfig.EARNING_WEEKLY_POT_SHARE);
  const userShare = totalAmount - dailyPotShare - weeklyPotShare;

  // Create earning entries with split — source is the token source account
  const entries = createEarningEntries(userId, totalAmount, tokenSourceAccountId);

  const journalInput: PostJournalInput = {
    idempotencyKey: IdempotencyKey.earning(engagementId),
    type: "earn",
    description,
    entries,
    referenceType: "engagement",
    referenceId: engagementId,
    initiatedBy: "system",
    subAccountId: finalSubAccountId || null,
    accountTypeId: accountTypeId || null,
    metadata: {
      ...metadata,
      totalAmount,
      userId,
      userShare,
      dailyPotShare,
      weeklyPotShare,
      tokenSourceAccountId,
    },
  };

  // Atomic: journal + sub-account credit in a single Firestore transaction
  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate && userShare > 0 && finalSubAccountId) {
        await creditSubAccount(userId, finalSubAccountId, userShare, tx);
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, totalAmount);
    }

    return journalResult;
  } catch (error) {
    logger.error("processEarningWithSplit failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
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

  // Sub-account is optional: if provided, credit it. Otherwise main wallet (journal only).
  const finalSubAccountId = subAccountId || undefined;

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

  const journalInput: PostJournalInput = {
    idempotencyKey: IdempotencyKey.potWin(potDrawId, winnerId),
    type: "pot_win",
    description: `${potType.charAt(0).toUpperCase() + potType.slice(1)} pot win: ${amount} tokens`,
    entries,
    referenceType: "pot_draw",
    referenceId: potDrawId,
    initiatedBy: "system",
    subAccountId: finalSubAccountId || null,
    metadata: {
      ...metadata,
      potType,
      winnerId,
      amount,
    },
  };

  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate && finalSubAccountId) {
        await creditSubAccount(winnerId, finalSubAccountId, amount, tx);
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, amount);
    }

    return journalResult;
  } catch (error) {
    logger.error("processPotWin failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
}

/**
 * Sweep rounding residual from a pot account to the residual account.
 *
 * Called at distribution time: pot balance is fractional, winners get
 * Math.floor(share), and the leftover (pot balance - sum of floored payouts)
 * is transferred here to keep the ledger balanced.
 *
 * @param potType - "daily" | "weekly"
 * @param residualAmount - The fractional residual to sweep
 * @param potDrawId - Reference to the pot draw
 */
export async function processPotResidual(
  potType: "daily" | "weekly",
  residualAmount: number,
  potDrawId: string,
  metadata?: Record<string, unknown>,
): Promise<PostJournalResult> {
  if (residualAmount <= 0) {
    return { success: true, journalId: "", isDuplicate: false };
  }

  await ensureSystemAccounts();

  const potAccountId = potType === "daily" ? SystemAccounts.DAILY_POT : SystemAccounts.WEEKLY_POT;

  const entries: JournalEntryInput[] = [
    {
      accountId: potAccountId,
      entryType: "debit",
      amount: residualAmount,
      description: `${potType} pot distribution residual`,
    },
    {
      accountId: SystemAccounts.POT_RESIDUAL,
      entryType: "credit",
      amount: residualAmount,
      description: `Rounding residual from ${potType} pot draw`,
    },
  ];

  return postJournal({
    idempotencyKey: `pot_residual:${potDrawId}`,
    type: "pot_residual",
    description: `${potType} pot distribution residual: ${residualAmount} tokens`,
    entries,
    referenceType: "pot_draw",
    referenceId: potDrawId,
    initiatedBy: "system",
    metadata: {
      ...metadata,
      potType,
      residualAmount,
    },
  });
}

/**
 * Process purchase - transfer tokens from user's sub-account to supplier
 *
 * @param userId - The user's ID
 * @param providerId - The service provider ID
 * @param providerName - The service provider name
 * @param amount - Token amount for purchase
 * @param purchaseId - Reference to the purchase
 * @param subAccountId - The sub-account to debit (optional, undefined = main wallet)
 * @param accountTypeId - The account type for audit (optional)
 * @param metadata - Additional metadata
 */
export async function processPurchaseTransaction(
  userId: string,
  providerId: string,
  providerName: string,
  amount: number,
  purchaseId: string,
  subAccountId?: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  // Ensure accounts exist
  await getOrCreateUserAccount(userId);
  await createSupplierAccount(providerId, providerName);

  // Validate balance
  let resolvedAccountTypeId = accountTypeId || null;
  if (subAccountId) {
    // Purchase from specific sub-account
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
    resolvedAccountTypeId = accountTypeId || subAccount.accountTypeId;
  } else {
    // Purchase from main wallet
    const { sufficient, available } = await validateMainWalletBalance(userId, amount);
    if (!sufficient) {
      return {
        success: false,
        error: `Insufficient main wallet balance: has ${available}, needs ${amount}`,
        errorCode: "INSUFFICIENT_BALANCE",
      };
    }
  }

  const entries = createTransferEntries(
    AccountId.user(userId),
    AccountId.supplier(providerId),
    amount,
    `Purchase from ${providerName}`
  );

  const journalInput: PostJournalInput = {
    idempotencyKey: IdempotencyKey.purchase(purchaseId),
    type: "purchase",
    description: `Purchase: ${amount} tokens to ${providerName}`,
    entries,
    referenceType: "purchase",
    referenceId: purchaseId,
    initiatedBy: userId,
    subAccountId: subAccountId || null,
    accountTypeId: resolvedAccountTypeId,
    metadata: {
      ...metadata,
      userId,
      providerId,
      providerName,
      amount,
    },
  };

  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate && subAccountId) {
        await debitSubAccount(userId, subAccountId, amount, tx);
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, amount);
    }

    return journalResult;
  } catch (error) {
    logger.error("processPurchaseTransaction failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
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

  // Sub-accounts are optional: if provided (e.g. brand), credit them.
  // Otherwise tokens go to main wallet (journal only).
  const finalReferrerSubAccountId = referrerSubAccountId || undefined;
  const finalRefereeSubAccountId = refereeSubAccountId || undefined;

  const entries = createReferralEntries(referrerId, refereeId, SystemAccounts.IMALICHAT_CLIENT);
  const totalAmount = LedgerConfig.REFERRER_REWARD + LedgerConfig.REFEREE_REWARD;

  const journalInput: PostJournalInput = {
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
  };

  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate) {
        if (finalReferrerSubAccountId) {
          await creditSubAccount(referrerId, finalReferrerSubAccountId, LedgerConfig.REFERRER_REWARD, tx);
        }
        if (finalRefereeSubAccountId) {
          await creditSubAccount(refereeId, finalRefereeSubAccountId, LedgerConfig.REFEREE_REWARD, tx);
        }
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, totalAmount);
    }

    return journalResult;
  } catch (error) {
    logger.error("processReferralRewards failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
}

/**
 * Process P2P transfer between users' sub-accounts
 *
 * @param senderId - The sender's user ID
 * @param recipientId - The recipient's user ID
 * @param amount - Token amount to transfer
 * @param transferId - Reference to the transfer
 * @param senderSubAccountId - Sender's sub-account (optional, undefined = main wallet)
 * @param recipientSubAccountId - Recipient's sub-account (optional, undefined = main wallet)
 * @param message - Optional message
 * @param metadata - Additional metadata
 */
export async function processP2PTransfer(
  senderId: string,
  recipientId: string,
  amount: number,
  transferId: string,
  senderSubAccountId?: string,
  recipientSubAccountId?: string,
  message?: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  // Ensure accounts exist
  await getOrCreateUserAccount(senderId);
  await getOrCreateUserAccount(recipientId);

  // Validate sender balance
  let senderAccountTypeId: string | null = null;
  if (senderSubAccountId) {
    // Sending from a specific sub-account
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
    senderAccountTypeId = senderSubAccount.accountTypeId;

    // Validate P2P send is allowed for this account type
    if (senderAccountTypeId) {
      const sendAllowed = await validateSubAccountAllows(senderAccountTypeId, "p2p_send");
      if (!sendAllowed.allowed) {
        return {
          success: false,
          error: sendAllowed.reason || "This account cannot send P2P transfers",
          errorCode: "P2P_SEND_NOT_ALLOWED",
        };
      }
    }
  } else {
    // Sending from main wallet — validate main wallet available balance
    const { sufficient, available } = await validateMainWalletBalance(senderId, amount);
    if (!sufficient) {
      return {
        success: false,
        error: `Insufficient main wallet balance: has ${available}, needs ${amount}`,
        errorCode: "INSUFFICIENT_BALANCE",
      };
    }
  }

  // Determine recipient sub-account
  let finalRecipientSubAccountId = recipientSubAccountId || undefined;

  // Enforce p2pRestrictToSameAccountType: if sender is sending from a brand
  // sub-account with this restriction, the recipient must have a matching
  // sub-account of the same account type — and tokens go there automatically.
  if (senderAccountTypeId) {
    const senderRules = await getAccountTypeRules(senderAccountTypeId);
    if (senderRules.p2pRestrictToSameAccountType) {
      const recipientSubAccounts = await getUserSubAccounts(recipientId);
      const matchingSub = recipientSubAccounts.find(
        (sa) => sa.accountTypeId === senderAccountTypeId && sa.isActive
      );
      if (!matchingSub) {
        return {
          success: false,
          error: "Recipient does not have a matching brand wallet for this transfer",
          errorCode: "RECIPIENT_MISSING_MATCHING_ACCOUNT",
        };
      }
      finalRecipientSubAccountId = matchingSub.id;
    }
  }

  // Validate P2P receive is allowed on the recipient's sub-account
  if (finalRecipientSubAccountId) {
    const recipientSubAccount = await getSubAccount(recipientId, finalRecipientSubAccountId);
    if (recipientSubAccount?.accountTypeId) {
      const receiveAllowed = await validateSubAccountAllows(recipientSubAccount.accountTypeId, "p2p_receive");
      if (!receiveAllowed.allowed) {
        return {
          success: false,
          error: receiveAllowed.reason || "Recipient's wallet cannot receive P2P transfers",
          errorCode: "P2P_RECEIVE_NOT_ALLOWED",
        };
      }
    }
  }

  const entries = createTransferEntries(
    AccountId.user(senderId),
    AccountId.user(recipientId),
    amount,
    message || `P2P transfer`
  );

  const journalInput: PostJournalInput = {
    idempotencyKey: IdempotencyKey.p2pTransfer(transferId),
    type: "p2p_transfer",
    description: `P2P: ${amount} tokens from ${senderId} to ${recipientId}`,
    entries,
    referenceType: "transfer",
    referenceId: transferId,
    initiatedBy: senderId,
    subAccountId: senderSubAccountId || null,
    accountTypeId: senderAccountTypeId,
    metadata: {
      ...metadata,
      senderId,
      recipientId,
      amount,
      message,
      senderSubAccountId,
      recipientSubAccountId: finalRecipientSubAccountId,
    },
  };

  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate) {
        if (senderSubAccountId) {
          await debitSubAccount(senderId, senderSubAccountId, amount, tx);
        }
        if (finalRecipientSubAccountId) {
          await creditSubAccount(recipientId, finalRecipientSubAccountId, amount, tx);
        }
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, amount);
    }

    return journalResult;
  } catch (error) {
    logger.error("processP2PTransfer failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
}

/**
 * Initiate cashout - move tokens from sub-account to pending
 *
 * @param userId - The user's ID
 * @param amount - Token amount to cash out
 * @param cashoutId - Reference to the cashout
 * @param subAccountId - The sub-account to debit (optional, undefined = main wallet)
 * @param metadata - Additional metadata
 */
export async function initiateCashout(
  userId: string,
  amount: number,
  cashoutId: string,
  subAccountId?: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  // Validate balance
  let accountTypeId: string | null = null;
  if (subAccountId) {
    // Cashout from specific sub-account
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
    accountTypeId = subAccount.accountTypeId;
  } else {
    // Cashout from main wallet
    const { sufficient, available } = await validateMainWalletBalance(userId, amount);
    if (!sufficient) {
      return {
        success: false,
        error: `Insufficient main wallet balance: has ${available}, needs ${amount}`,
        errorCode: "INSUFFICIENT_BALANCE",
      };
    }
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

  const journalInput: PostJournalInput = {
    idempotencyKey: IdempotencyKey.cashoutInitiate(cashoutId),
    type: "cashout_initiate",
    description: `Cashout initiated: ${amount} tokens`,
    entries,
    referenceType: "cashout",
    referenceId: cashoutId,
    initiatedBy: userId,
    subAccountId: subAccountId || null,
    accountTypeId,
    metadata: {
      ...metadata,
      userId,
      amount,
      subAccountId: subAccountId || "main",
    },
  };

  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate && subAccountId) {
        await debitSubAccount(userId, subAccountId, amount, tx);
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, amount);
    }

    return journalResult;
  } catch (error) {
    logger.error("initiateCashout failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
}

/**
 * Complete cashout - move tokens from pending to supplier
 *
 * @param cashoutId - Reference to the cashout
 * @param amount - Token amount
 * @param supplierId - Supplier account identifier (e.g. "cashout_eft", "cashout_ewallet")
 * @param metadata - Additional metadata
 */
export async function completeCashout(
  cashoutId: string,
  amount: number,
  supplierId: string,
  metadata?: Record<string, unknown>
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  // Ensure supplier account exists
  await createSupplierAccount(supplierId, `Cashout: ${supplierId}`);

  const entries: JournalEntryInput[] = [
    {
      accountId: SystemAccounts.CASHOUT_PENDING,
      entryType: "debit",
      amount,
      description: "Cashout completed",
    },
    {
      accountId: AccountId.supplier(supplierId),
      entryType: "credit",
      amount,
      description: `Cashout to supplier: ${supplierId}`,
    },
  ];

  return postJournal({
    idempotencyKey: IdempotencyKey.cashoutComplete(cashoutId),
    type: "cashout_complete",
    description: `Cashout completed: ${amount} tokens to ${supplierId}`,
    entries,
    referenceType: "cashout",
    referenceId: cashoutId,
    initiatedBy: "system",
    metadata: {
      ...metadata,
      amount,
      supplierId,
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
 * @param subAccountId - The sub-account to credit (optional, undefined = main wallet)
 * @param metadata - Additional metadata
 */
export async function failCashout(
  userId: string,
  cashoutId: string,
  amount: number,
  reason: string,
  subAccountId?: string,
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

  const journalInput: PostJournalInput = {
    idempotencyKey: IdempotencyKey.cashoutFailed(cashoutId),
    type: "cashout_failed",
    description: `Cashout failed: ${amount} tokens refunded - ${reason}`,
    entries,
    referenceType: "cashout",
    referenceId: cashoutId,
    initiatedBy: "system",
    subAccountId: subAccountId || null,
    metadata: {
      ...metadata,
      userId,
      amount,
      reason,
      subAccountId: subAccountId || "main",
    },
  };

  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate && subAccountId) {
        await creditSubAccount(userId, subAccountId, amount, tx);
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, amount);
    }

    return journalResult;
  } catch (error) {
    logger.error("failCashout failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
}

/**
 * Process client sub-account funding — transfer tokens from client master to sub-account
 *
 * Posts a journal: DR client:{clientId} CR client_subacc:{subAccountId}
 * Validates client account has sufficient ledger balance.
 *
 * @param clientId - The client's ID
 * @param subAccountId - The sub-account Firestore ID
 * @param amount - Token amount to transfer
 * @param reference - Unique reference for idempotency
 * @param adminUserId - The admin performing the transfer
 */
export async function processClientSubAccountFunding(
  clientId: string,
  subAccountId: string,
  amount: number,
  reference: string,
  adminUserId: string,
): Promise<PostJournalResult> {
  if (amount <= 0) {
    return {
      success: false,
      error: "Funding amount must be positive",
      errorCode: "INVALID_AMOUNT",
    };
  }

  const entries: JournalEntryInput[] = [
    {
      accountId: AccountId.client(clientId),
      entryType: "debit",
      amount,
      description: `Fund sub-account ${subAccountId}`,
    },
    {
      accountId: AccountId.clientSubAccount(subAccountId),
      entryType: "credit",
      amount,
      description: `Funded from client ${clientId}`,
    },
  ];

  return postJournal({
    idempotencyKey: IdempotencyKey.subAccountFund(subAccountId, reference),
    type: "subacc_fund",
    description: `Sub-account funding: ${amount} tokens from ${clientId} to ${subAccountId}`,
    entries,
    referenceType: "client_fund",
    referenceId: reference,
    initiatedBy: adminUserId,
    metadata: {
      clientId,
      subAccountId,
      amount,
      adminUserId,
    },
  });
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
  logger.info("Initializing Trust Ledger System...");

  // Import here to avoid circular dependency
  const { initializeSystemAccounts } = await import("./accounts");

  await initializeSystemAccounts();

  logger.info("Trust Ledger System initialized successfully");
}

// ============================================================================
// ESCROW RESERVATION HELPERS
// ============================================================================

/**
 * Reserve tokens in escrow for an engagement.
 *
 * Moves tokens from the campaign's token source account into the system
 * escrow account via an atomic journal entry. This guarantees the tokens
 * are available when the user completes the engagement.
 *
 * The escrowAmount should be the MAXIMUM possible payout:
 *   base reward × bonus multiplier (if bonus is configured on the opportunity)
 *
 * @param engagementId - The engagement ID (used for idempotency)
 * @param escrowAmount - Maximum possible payout to reserve
 * @param tokenSourceAccountId - The campaign's token source (client or client_subacc)
 * @param metadata - Additional metadata for audit trail
 */
export async function createEscrowReservation(
  engagementId: string,
  escrowAmount: number,
  tokenSourceAccountId: string,
  metadata?: Record<string, unknown>,
): Promise<PostJournalResult> {
  await ensureSystemAccounts();

  if (!Number.isFinite(escrowAmount) || escrowAmount <= 0) {
    return {
      success: false,
      error: `Escrow amount must be a positive number, got: ${escrowAmount}`,
      errorCode: "INVALID_AMOUNT",
    };
  }

  const entries: JournalEntryInput[] = [
    {
      accountId: tokenSourceAccountId,
      entryType: "debit",
      amount: escrowAmount,
      description: "Escrow reservation for engagement",
    },
    {
      accountId: SystemAccounts.ENGAGEMENT_ESCROW,
      entryType: "credit",
      amount: escrowAmount,
      description: "Tokens held in escrow",
    },
  ];

  return postJournal({
    idempotencyKey: IdempotencyKey.escrowReserve(engagementId),
    type: "escrow_reserve",
    description: `Escrow reservation: ${escrowAmount} tokens for engagement ${engagementId}`,
    entries,
    referenceType: "engagement",
    referenceId: engagementId,
    initiatedBy: "system",
    metadata: {
      ...metadata,
      escrowAmount,
      tokenSourceAccountId,
      engagementId,
    },
  });
}

/**
 * Create journal entries for escrow release at engagement completion.
 *
 * Produces a SINGLE balanced journal:
 *   DR system:escrow           escrowAmount    (full reserved amount leaves escrow)
 *   CR user:{userId}           userShare       (90% of actualReward)
 *   CR pot:daily               dailyPotShare   (5% of actualReward)
 *   CR pot:weekly              weeklyPotShare  (5% of actualReward)
 *   CR tokenSourceAccountId    excess          (escrowAmount - actualReward, returned to source)
 *
 * When bonus triggers: actualReward == escrowAmount, excess == 0, no source credit.
 * When no bonus: actualReward == baseReward < escrowAmount, excess returned to source.
 */
export function createEscrowCompletionEntries(
  userId: string,
  actualReward: number,
  escrowAmount: number,
  tokenSourceAccountId: string,
): JournalEntryInput[] {
  const dailyPotAmount = Math.floor(actualReward * LedgerConfig.EARNING_DAILY_POT_SHARE);
  const weeklyPotAmount = Math.floor(actualReward * LedgerConfig.EARNING_WEEKLY_POT_SHARE);
  const userAmount = actualReward - dailyPotAmount - weeklyPotAmount;
  const excess = escrowAmount - actualReward;

  const entries: JournalEntryInput[] = [
    {
      accountId: SystemAccounts.ENGAGEMENT_ESCROW,
      entryType: "debit",
      amount: escrowAmount,
      description: "Escrow release — full reserved amount",
    },
  ];

  if (userAmount > 0) {
    entries.push({
      accountId: AccountId.user(userId),
      entryType: "credit",
      amount: userAmount,
      description: "User earning (90%)",
    });
  }

  if (dailyPotAmount > 0) {
    entries.push({
      accountId: SystemAccounts.DAILY_POT,
      entryType: "credit",
      amount: dailyPotAmount,
      description: "Daily pot contribution (5%)",
    });
  }

  if (weeklyPotAmount > 0) {
    entries.push({
      accountId: SystemAccounts.WEEKLY_POT,
      entryType: "credit",
      amount: weeklyPotAmount,
      description: "Weekly pot contribution (5%)",
    });
  }

  if (excess > 0) {
    entries.push({
      accountId: tokenSourceAccountId,
      entryType: "credit",
      amount: excess,
      description: "Excess escrow returned to source (bonus not triggered)",
    });
  }

  return entries;
}

/**
 * Process engagement completion from escrow.
 *
 * Creates a single balanced journal that debits escrow for the full reserved
 * amount, credits user/pots for the actual reward, and returns any excess
 * to the original token source account.
 *
 * Also credits the user's sub-account with their 90% share.
 *
 * @param userId - The user's ID
 * @param actualReward - The actual reward after bonus determination
 * @param escrowAmount - The original reserved amount (max possible payout)
 * @param engagementId - The engagement ID
 * @param tokenSourceAccountId - Where to return excess tokens
 * @param userSubAccountId - The user's sub-account to credit
 * @param accountTypeId - Account type for audit trail
 * @param metadata - Additional metadata
 */
export async function processEscrowCompletion(
  userId: string,
  actualReward: number,
  escrowAmount: number,
  engagementId: string,
  tokenSourceAccountId: string,
  userSubAccountId?: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>,
): Promise<PostJournalResult> {
  await ensureSystemAccounts();
  await getOrCreateUserAccount(userId);

  // Sub-account is optional: if provided (brand), credit it. Otherwise main wallet.
  const finalSubAccountId = userSubAccountId || undefined;

  const dailyPotShare = Math.floor(actualReward * LedgerConfig.EARNING_DAILY_POT_SHARE);
  const weeklyPotShare = Math.floor(actualReward * LedgerConfig.EARNING_WEEKLY_POT_SHARE);
  const userShare = actualReward - dailyPotShare - weeklyPotShare;
  const excess = escrowAmount - actualReward;

  const entries = createEscrowCompletionEntries(
    userId,
    actualReward,
    escrowAmount,
    tokenSourceAccountId,
  );

  const journalInput: PostJournalInput = {
    idempotencyKey: IdempotencyKey.escrowRelease(engagementId),
    type: "escrow_release",
    description: `Escrow release: ${actualReward} tokens earned, ${excess} returned`,
    entries,
    referenceType: "engagement",
    referenceId: engagementId,
    initiatedBy: "system",
    subAccountId: finalSubAccountId || null,
    accountTypeId: accountTypeId || null,
    metadata: {
      ...metadata,
      userId,
      actualReward,
      escrowAmount,
      excess,
      userShare,
      tokenSourceAccountId,
    },
  };

  try {
    const journalResult = await db.runTransaction(async (tx) => {
      const result = await postJournal(journalInput, tx);
      if (result.success && !result.isDuplicate && userShare > 0 && finalSubAccountId) {
        await creditSubAccount(userId, finalSubAccountId, userShare, tx);
      }
      return result;
    });

    if (journalResult.success && !journalResult.isDuplicate && journalResult.journalId) {
      logJournalPostedAudit(journalInput, journalResult.journalId, escrowAmount);
    }

    return journalResult;
  } catch (error) {
    logger.error("processEscrowCompletion failed:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      errorCode: "TRANSACTION_FAILED",
    };
  }
}

// ============================================================================
// TOKEN EXPIRY
// ============================================================================

/**
 * Process expired sub-account tokens.
 *
 * Scans all active account types with `expiryDays` set and finds sub-accounts
 * whose `lastCreditAt` is older than the expiry window. Expired balances are
 * refunded to the brand client account via double-entry journal.
 *
 * Designed to be called from a scheduled Cloud Function (daily).
 */
export async function processSubAccountExpiry(): Promise<{
  expired: number;
  failed: number;
}> {
  const now = admin.firestore.Timestamp.now();
  let expired = 0;
  let failed = 0;

  // 1. Find all active account types with expiryDays configured
  const accountTypesSnap = await db
    .collection(SubAccountConfig.COLLECTION_ACCOUNT_TYPES)
    .where("isActive", "==", true)
    .get();

  const typesWithExpiry = accountTypesSnap.docs.filter((doc) => {
    const rules = doc.data().rules;
    return rules?.expiryDays != null && rules.expiryDays > 0;
  });

  if (typesWithExpiry.length === 0) {
    logger.info("No account types with expiryDays — nothing to expire");
    return { expired: 0, failed: 0 };
  }

  // 2. For each account type, find sub-accounts past expiry
  for (const typeDoc of typesWithExpiry) {
    const accountType = typeDoc.data();
    const expiryDays: number = accountType.rules.expiryDays;
    const cutoffDate = new Date(now.toDate().getTime() - expiryDays * 86_400_000);
    const cutoff = admin.firestore.Timestamp.fromDate(cutoffDate);

    const expiredSubs = await db
      .collectionGroup(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
      .where("accountTypeId", "==", typeDoc.id)
      .where("isActive", "==", true)
      .where("lastCreditAt", "<", cutoff)
      .limit(100)
      .get();

    for (const subDoc of expiredSubs.docs) {
      const sub = subDoc.data() as SubAccount;

      // Skip zero-balance or null lastCreditAt
      if (sub.balance <= 0 || !sub.lastCreditAt) continue;

      try {
        // Determine refund target: brand client account
        const advertiserId = accountType.advertiserId;
        const refundAccountId = advertiserId
          ? `client:${advertiserId}`
          : SystemAccounts.CBOOK_BUS;

        // Create expiry journal: DR user, CR client
        const entries = createTransferEntries(
          AccountId.user(sub.userId),
          refundAccountId,
          sub.balance,
          `Token expiry: ${sub.balance} tokens from ${sub.name} (${expiryDays}-day expiry)`
        );

        const dateKey = cutoffDate.toISOString().slice(0, 10);
        const journalInput: PostJournalInput = {
          idempotencyKey: `token_expiry:${sub.id}:${dateKey}`,
          type: "token_expiry",
          description: `Token expiry: ${sub.balance} tokens from user ${sub.userId} (${sub.name})`,
          entries,
          referenceType: "sub_account_expiry",
          referenceId: sub.id,
          initiatedBy: "system",
          subAccountId: sub.id,
          accountTypeId: sub.accountTypeId,
          metadata: {
            userId: sub.userId,
            expiryDays,
            advertiserId: advertiserId || null,
            amount: sub.balance,
            lastCreditAt: sub.lastCreditAt.toDate().toISOString(),
          },
        };

        const expiredBalance = sub.balance;

        await db.runTransaction(async (tx) => {
          // Re-read inside transaction to get current balance
          const freshDoc = await tx.get(subDoc.ref);
          if (!freshDoc.exists) return;
          const freshSub = freshDoc.data() as SubAccount;
          if (freshSub.balance <= 0) return;

          const result = await postJournal(journalInput, tx);
          if (result.success && !result.isDuplicate) {
            await debitSubAccount(sub.userId, sub.id, freshSub.balance, tx);
          }
        });

        logger.info(
          `Expired ${expiredBalance} tokens from sub-account ${sub.id} (user ${sub.userId}, type ${typeDoc.id})`
        );
        expired++;
      } catch (e) {
        logger.error(`Failed to expire sub-account ${sub.id}:`, e);
        failed++;
      }
    }
  }

  return { expired, failed };
}
