/**
 * Trust Ledger System - Journal Posting Service
 *
 * Core service for posting balanced journal entries.
 * Ensures atomicity, idempotency, and immutability.
 */

import * as admin from "firebase-admin";
import {
  LedgerJournal,
  LedgerEntry,
  PostJournalInput,
  JournalEntryInput,
  PostJournalResult,
  LedgerAccount,
  LedgerConfig,
  LedgerErrorCodes,
  JournalStatus,
  AccountId,
} from "./types";
import {
  getAccounts,
  logAuditEvent,
} from "./accounts";

const db = admin.firestore();

// ============================================================================
// JOURNAL POSTING
// ============================================================================

/**
 * Post a journal entry to the ledger (atomic, idempotent)
 *
 * This is the core function for all token movements. It:
 * 1. Validates the journal is balanced (debits = credits)
 * 2. Checks for duplicate via idempotency key
 * 3. Validates all accounts exist and are active
 * 4. Validates sufficient balance for debits
 * 5. Atomically updates all account balances
 * 6. Creates the immutable journal record
 */
export async function postJournal(
  input: PostJournalInput,
  parentTx?: admin.firestore.Transaction
): Promise<PostJournalResult> {
  // Validate input
  const validationError = validateJournalInput(input);
  if (validationError) {
    return {
      success: false,
      error: validationError.error,
      errorCode: validationError.errorCode,
    };
  }

  // Check for existing journal with same idempotency key (prevent duplicates)
  const existingJournal = await getJournalByIdempotencyKey(input.idempotencyKey);
  if (existingJournal) {
    console.log(
      `Journal with idempotency key ${input.idempotencyKey} already exists: ${existingJournal.id}`
    );
    return {
      success: true,
      data: existingJournal,
      journalId: existingJournal.id,
      isDuplicate: true,
    };
  }

  // Calculate totals
  const totalDebits = input.entries
    .filter((e) => e.entryType === "debit")
    .reduce((sum, e) => sum + e.amount, 0);
  const totalCredits = input.entries
    .filter((e) => e.entryType === "credit")
    .reduce((sum, e) => sum + e.amount, 0);

  // Validate balanced
  if (totalDebits !== totalCredits) {
    return {
      success: false,
      error: `Journal not balanced: debits=${totalDebits}, credits=${totalCredits}`,
      errorCode: LedgerErrorCodes.JOURNAL_NOT_BALANCED,
    };
  }

  // Get all affected accounts
  const accountIds = [...new Set(input.entries.map((e) => e.accountId))];
  const accounts = await getAccounts(accountIds);

  // Validate all accounts exist and are active
  for (const accountId of accountIds) {
    const account = accounts.get(accountId);
    if (!account) {
      return {
        success: false,
        error: `Account not found: ${accountId}`,
        errorCode: LedgerErrorCodes.ACCOUNT_NOT_FOUND,
      };
    }
    if (account.status === "frozen") {
      return {
        success: false,
        error: `Account is frozen: ${accountId}`,
        errorCode: LedgerErrorCodes.ACCOUNT_FROZEN,
      };
    }
    if (account.status === "closed") {
      return {
        success: false,
        error: `Account is closed: ${accountId}`,
        errorCode: LedgerErrorCodes.ACCOUNT_CLOSED,
      };
    }
  }

  // Calculate balance changes per account.
  // Asset accounts (cbook) are debit-normal: debit increases, credit decreases.
  // All other accounts are credit-normal: credit increases, debit decreases.
  const balanceChanges = new Map<string, number>();
  for (const entry of input.entries) {
    const isAsset = AccountId.isDebitNormal(entry.accountId);
    const change = isAsset
      ? (entry.entryType === "debit" ? entry.amount : -entry.amount)
      : (entry.entryType === "credit" ? entry.amount : -entry.amount);
    balanceChanges.set(
      entry.accountId,
      (balanceChanges.get(entry.accountId) || 0) + change
    );
  }

  // Validate no account goes negative — all accounts validated equally.
  for (const [accountId, change] of balanceChanges) {
    const account = accounts.get(accountId)!;
    const newBalance = account.balance + change;
    if (newBalance < 0) {
      return {
        success: false,
        error: `Insufficient balance in ${accountId}: has ${account.balance}, needs ${-change}`,
        errorCode: LedgerErrorCodes.INSUFFICIENT_BALANCE,
      };
    }
  }

  // Transaction body — extracted so it can run inside a parent transaction
  // or inside its own db.runTransaction wrapper.
  const txBody = async (tx: admin.firestore.Transaction): Promise<LedgerJournal> => {
    return executeJournalTx(tx, input, accountIds, balanceChanges, totalDebits, totalCredits);
  };

  if (parentTx) {
    // Caller manages the transaction — execute body with provided tx.
    // Errors propagate to parent transaction for retry/abort.
    // Audit log is skipped — caller fires it after commit via logJournalPostedAudit.
    const journal = await txBody(parentTx);
    return {
      success: true,
      data: journal,
      journalId: journal.id,
      isDuplicate: false,
    };
  }

  // No parent tx — existing behaviour: own transaction + audit + error handling
  try {
    const result = await db.runTransaction(txBody);

    // Log audit event
    logJournalPostedAudit(input, result.id, totalDebits);

    return {
      success: true,
      data: result,
      journalId: result.id,
      isDuplicate: false,
    };
  } catch (error) {
    console.error("Failed to post journal:", error);

    // Log failed attempt
    await logAuditEvent({
      eventType: "journal_failed",
      actorId: input.initiatedBy,
      actorType: input.initiatedBy === "system" ? "system" : "user",
      description: `Journal posting failed: ${input.type} - ${error}`,
      metadata: {
        idempotencyKey: input.idempotencyKey,
        error: String(error),
      },
    });

    const errorMessage = error instanceof Error ? error.message : String(error);
    return {
      success: false,
      error: errorMessage,
      errorCode: LedgerErrorCodes.TRANSACTION_FAILED,
    };
  }
}

/**
 * Core transaction body for journal posting.
 *
 * Re-fetches accounts inside the transaction for read consistency,
 * re-validates balances, creates the immutable journal, and updates
 * all affected account balances atomically.
 */
async function executeJournalTx(
  tx: admin.firestore.Transaction,
  input: PostJournalInput,
  accountIds: string[],
  balanceChanges: Map<string, number>,
  totalDebits: number,
  totalCredits: number,
): Promise<LedgerJournal> {
  // Re-fetch accounts inside transaction for consistency
  const accountRefs = accountIds.map((id) =>
    db.collection(LedgerConfig.COLLECTION_ACCOUNTS).doc(id)
  );
  const accountDocs = await Promise.all(accountRefs.map((ref) => tx.get(ref)));

  // Build account map from fresh data
  const freshAccounts = new Map<string, LedgerAccount>();
  for (let i = 0; i < accountIds.length; i++) {
    if (!accountDocs[i].exists) {
      throw new Error(`${LedgerErrorCodes.ACCOUNT_NOT_FOUND}: ${accountIds[i]}`);
    }
    freshAccounts.set(accountIds[i], accountDocs[i].data() as LedgerAccount);
  }

  // Re-validate balances inside transaction — all accounts validated equally
  for (const [accountId, change] of balanceChanges) {
    const account = freshAccounts.get(accountId)!;
    const newBalance = account.balance + change;
    if (newBalance < 0) {
      throw new Error(
        `${LedgerErrorCodes.INSUFFICIENT_BALANCE}: ${accountId} has ${account.balance}, needs ${-change}`
      );
    }
  }

  // Create journal document
  const journalRef = db.collection(LedgerConfig.COLLECTION_JOURNALS).doc();
  const now = admin.firestore.Timestamp.now();

  // Build entries with balanceAfter
  const entries: LedgerEntry[] = [];
  const newBalances = new Map<string, number>();

  // Initialize with current balances
  for (const [accountId, account] of freshAccounts) {
    newBalances.set(accountId, account.balance);
  }

  // Process entries in order, updating running balances
  for (let i = 0; i < input.entries.length; i++) {
    const inputEntry = input.entries[i];
    const isAsset = AccountId.isDebitNormal(inputEntry.accountId);
    const change = isAsset
      ? (inputEntry.entryType === "debit" ? inputEntry.amount : -inputEntry.amount)
      : (inputEntry.entryType === "credit" ? inputEntry.amount : -inputEntry.amount);

    const currentBalance = newBalances.get(inputEntry.accountId)!;
    const balanceAfter = currentBalance + change;
    newBalances.set(inputEntry.accountId, balanceAfter);

    entries.push({
      id: `${journalRef.id}_${i}`,
      accountId: inputEntry.accountId,
      entryType: inputEntry.entryType,
      amount: inputEntry.amount,
      balanceAfter,
      description: inputEntry.description,
    });
  }

  const journal: LedgerJournal = {
    id: journalRef.id,
    idempotencyKey: input.idempotencyKey,
    type: input.type,
    status: "posted",
    description: input.description,
    entries,
    totalDebits,
    totalCredits,
    referenceType: input.referenceType,
    referenceId: input.referenceId,
    ...(input.subAccountId !== undefined && { subAccountId: input.subAccountId }),
    ...(input.accountTypeId !== undefined && { accountTypeId: input.accountTypeId }),
    initiatedBy: input.initiatedBy,
    ...(input.approvedBy !== undefined && { approvedBy: input.approvedBy }),
    ...(input.ipAddress !== undefined && { ipAddress: input.ipAddress }),
    ...(input.userAgent !== undefined && { userAgent: input.userAgent }),
    createdAt: now,
    postedAt: now,
    metadata: input.metadata || {},
    // Denormalized for Firestore security rules — allows efficient per-user read access
    participantAccountIds: accountIds,
  };

  // Write journal
  tx.set(journalRef, journal);

  // Update all account balances
  for (let i = 0; i < accountIds.length; i++) {
    const newBalance = newBalances.get(accountIds[i])!;

    tx.update(accountRefs[i], {
      balance: newBalance,
      updatedAt: now,
      version: admin.firestore.FieldValue.increment(1),
    });
  }

  return journal;
}

/**
 * Fire-and-forget audit log for a successfully posted journal.
 *
 * Call this AFTER a parent transaction commits to record the audit trail.
 * When postJournal is called without a parentTx, it handles audit internally.
 */
export function logJournalPostedAudit(
  input: PostJournalInput,
  journalId: string,
  totalDebits: number,
): void {
  logAuditEvent({
    eventType: "journal_posted",
    journalId,
    actorId: input.initiatedBy,
    actorType: input.initiatedBy === "system" ? "system" : "user",
    description: `Journal posted: ${input.type} - ${input.description}`,
    newValue: {
      journalId,
      type: input.type,
      totalAmount: totalDebits,
      entryCount: input.entries.length,
    },
    ...(input.ipAddress !== undefined && { ipAddress: input.ipAddress }),
    ...(input.userAgent !== undefined && { userAgent: input.userAgent }),
    metadata: {
      referenceType: input.referenceType,
      referenceId: input.referenceId,
    },
  }).catch((err) => console.error("Audit log failed:", err));
}

// ============================================================================
// JOURNAL REVERSAL
// ============================================================================

/**
 * Reverse a posted journal (create opposite entries)
 *
 * The original journal is marked as reversed but never deleted.
 * A new reversal journal is created with opposite entries.
 */
export async function reverseJournal(
  journalId: string,
  reason: string,
  reversedBy: string
): Promise<PostJournalResult> {
  const original = await getJournal(journalId);

  if (!original) {
    return {
      success: false,
      error: `Journal not found: ${journalId}`,
      errorCode: LedgerErrorCodes.JOURNAL_NOT_FOUND,
    };
  }

  if (original.status === "reversed") {
    return {
      success: false,
      error: `Journal already reversed: ${journalId}`,
      errorCode: LedgerErrorCodes.JOURNAL_ALREADY_REVERSED,
    };
  }

  if (original.status !== "posted") {
    return {
      success: false,
      error: `Only posted journals can be reversed: ${journalId} is ${original.status}`,
      errorCode: LedgerErrorCodes.JOURNAL_CANNOT_BE_REVERSED,
    };
  }

  // Create reversal entries (opposite of original)
  const reversalEntries: JournalEntryInput[] = original.entries.map((entry) => ({
    accountId: entry.accountId,
    entryType: entry.entryType === "debit" ? "credit" : "debit",
    amount: entry.amount,
    description: `Reversal of: ${entry.description || "original entry"}`,
  }));

  // Post reversal journal
  const reversalResult = await postJournal({
    idempotencyKey: `reversal:${journalId}`,
    type: "reversal",
    description: `Reversal: ${reason}`,
    entries: reversalEntries,
    referenceType: original.referenceType,
    referenceId: original.referenceId,
    initiatedBy: reversedBy,
    metadata: {
      originalJournalId: journalId,
      reversalReason: reason,
    },
  });

  if (!reversalResult.success) {
    return reversalResult;
  }

  // Mark original journal as reversed
  const now = admin.firestore.Timestamp.now();
  await db.collection(LedgerConfig.COLLECTION_JOURNALS).doc(journalId).update({
    status: "reversed",
    reversedAt: now,
    reversedBy,
    reversalJournalId: reversalResult.journalId,
  });

  // Update the reversal journal with reference to original
  await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .doc(reversalResult.journalId!)
    .update({
      originalJournalId: journalId,
    });

  // Log audit event
  await logAuditEvent({
    eventType: "journal_reversed",
    journalId,
    actorId: reversedBy,
    actorType: reversedBy === "system" ? "system" : "admin",
    description: `Journal reversed: ${reason}`,
    metadata: {
      originalJournalId: journalId,
      reversalJournalId: reversalResult.journalId,
      reason,
    },
  });

  return reversalResult;
}

// ============================================================================
// JOURNAL QUERIES
// ============================================================================

/**
 * Get a journal by ID
 */
export async function getJournal(
  journalId: string
): Promise<LedgerJournal | null> {
  const doc = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .doc(journalId)
    .get();

  if (!doc.exists) {
    return null;
  }

  return doc.data() as LedgerJournal;
}

/**
 * Get journal by idempotency key
 */
export async function getJournalByIdempotencyKey(
  idempotencyKey: string
): Promise<LedgerJournal | null> {
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .where("idempotencyKey", "==", idempotencyKey)
    .limit(1)
    .get();

  if (snapshot.empty) {
    return null;
  }

  return snapshot.docs[0].data() as LedgerJournal;
}

/**
 * Get journals for an account
 */
export async function getAccountJournals(
  accountId: string,
  options: {
    limit?: number;
    startAfter?: admin.firestore.Timestamp;
    status?: JournalStatus;
  } = {}
): Promise<LedgerJournal[]> {
  // We need to find journals where the account appears in entries
  // Since entries are embedded, we can't query directly
  // This requires a different approach - we'll use a secondary index or scan

  // For now, scan all journals and filter (not efficient for large datasets)
  // In production, consider adding a subcollection or separate index

  let query = db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .orderBy("postedAt", "desc");

  if (options.status) {
    query = query.where("status", "==", options.status);
  }

  if (options.startAfter) {
    query = query.startAfter(options.startAfter);
  }

  if (options.limit) {
    // Get more than needed since we'll filter
    query = query.limit(options.limit * 3);
  }

  const snapshot = await query.get();

  const journals: LedgerJournal[] = [];
  for (const doc of snapshot.docs) {
    const journal = doc.data() as LedgerJournal;
    // Check if this account is in the entries
    if (journal.entries.some((e) => e.accountId === accountId)) {
      journals.push(journal);
      if (options.limit && journals.length >= options.limit) {
        break;
      }
    }
  }

  return journals;
}

/**
 * Get journals by reference
 */
export async function getJournalsByReference(
  referenceType: LedgerJournal["referenceType"],
  referenceId: string
): Promise<LedgerJournal[]> {
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .where("referenceType", "==", referenceType)
    .where("referenceId", "==", referenceId)
    .get();

  return snapshot.docs.map((doc) => doc.data() as LedgerJournal);
}

/**
 * Get recent journals
 */
export async function getRecentJournals(
  limit: number = 50
): Promise<LedgerJournal[]> {
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .orderBy("postedAt", "desc")
    .limit(limit)
    .get();

  return snapshot.docs.map((doc) => doc.data() as LedgerJournal);
}

// ============================================================================
// VALIDATION
// ============================================================================

/**
 * Validate journal input
 */
function validateJournalInput(
  input: PostJournalInput
): { error: string; errorCode: string } | null {
  if (!input.idempotencyKey || input.idempotencyKey.trim() === "") {
    return {
      error: "Idempotency key is required",
      errorCode: LedgerErrorCodes.INVALID_IDEMPOTENCY_KEY,
    };
  }

  if (!input.entries || input.entries.length === 0) {
    return {
      error: "At least one entry is required",
      errorCode: LedgerErrorCodes.EMPTY_ENTRIES,
    };
  }

  if (input.entries.length < 2) {
    return {
      error: "Double-entry requires at least 2 entries",
      errorCode: LedgerErrorCodes.EMPTY_ENTRIES,
    };
  }

  for (const entry of input.entries) {
    if (!entry.accountId) {
      return {
        error: "Entry account ID is required",
        errorCode: LedgerErrorCodes.ACCOUNT_NOT_FOUND,
      };
    }

    if (entry.amount <= 0) {
      return {
        error: `Entry amount must be positive: ${entry.amount}`,
        errorCode: LedgerErrorCodes.INVALID_AMOUNT,
      };
    }

    if (entry.entryType !== "debit" && entry.entryType !== "credit") {
      return {
        error: `Invalid entry type: ${entry.entryType}`,
        errorCode: LedgerErrorCodes.INVALID_ENTRY_TYPE,
      };
    }
  }

  return null;
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/**
 * Calculate net change for an account from a set of entries.
 * Asset accounts (cbook) are debit-normal; all others are credit-normal.
 */
export function calculateNetChange(
  entries: JournalEntryInput[],
  accountId: string
): number {
  const isAsset = AccountId.isDebitNormal(accountId);
  return entries.reduce((sum, entry) => {
    if (entry.accountId !== accountId) return sum;
    return sum + (isAsset
      ? (entry.entryType === "debit" ? entry.amount : -entry.amount)
      : (entry.entryType === "credit" ? entry.amount : -entry.amount));
  }, 0);
}

/**
 * Create a simple two-sided transfer journal input
 */
export function createTransferEntries(
  fromAccountId: string,
  toAccountId: string,
  amount: number,
  description?: string
): JournalEntryInput[] {
  return [
    {
      accountId: fromAccountId,
      entryType: "debit",
      amount,
      description: description || `Transfer to ${toAccountId}`,
    },
    {
      accountId: toAccountId,
      entryType: "credit",
      amount,
      description: description || `Transfer from ${fromAccountId}`,
    },
  ];
}

/**
 * Create entries for earning split (90% user, 5% daily pot, 5% weekly pot)
 */
export function createEarningEntries(
  userId: string,
  totalAmount: number,
  sourceAccountId: string
): JournalEntryInput[] {
  const dailyPotAmount = totalAmount * LedgerConfig.EARNING_DAILY_POT_SHARE;
  const weeklyPotAmount = totalAmount * LedgerConfig.EARNING_WEEKLY_POT_SHARE;
  const userAmount = totalAmount - dailyPotAmount - weeklyPotAmount; // User gets remainder

  const entries: JournalEntryInput[] = [
    {
      accountId: sourceAccountId,
      entryType: "debit",
      amount: totalAmount,
      description: "Earning distribution",
    },
  ];

  if (userAmount > 0) {
    entries.push({
      accountId: `user:${userId}`,
      entryType: "credit",
      amount: userAmount,
      description: "User earning (90%)",
    });
  }

  if (dailyPotAmount > 0) {
    entries.push({
      accountId: "pot:daily",
      entryType: "credit",
      amount: dailyPotAmount,
      description: "Daily pot contribution (5%)",
    });
  }

  if (weeklyPotAmount > 0) {
    entries.push({
      accountId: "pot:weekly",
      entryType: "credit",
      amount: weeklyPotAmount,
      description: "Weekly pot contribution (5%)",
    });
  }

  return entries;
}

/**
 * Create entries for referral rewards
 */
export function createReferralEntries(
  referrerId: string,
  refereeId: string,
  sourceAccountId: string
): JournalEntryInput[] {
  const referrerReward = LedgerConfig.REFERRER_REWARD;
  const refereeReward = LedgerConfig.REFEREE_REWARD;
  const totalAmount = referrerReward + refereeReward;

  return [
    {
      accountId: sourceAccountId,
      entryType: "debit",
      amount: totalAmount,
      description: "Referral rewards distribution",
    },
    {
      accountId: `user:${referrerId}`,
      entryType: "credit",
      amount: referrerReward,
      description: "Referrer reward",
    },
    {
      accountId: `user:${refereeId}`,
      entryType: "credit",
      amount: refereeReward,
      description: "New user welcome bonus",
    },
  ];
}
