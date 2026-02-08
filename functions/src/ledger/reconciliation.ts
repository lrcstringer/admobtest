/**
 * Trust Ledger System - Reconciliation Service
 *
 * Verifies ledger integrity by comparing stored balances
 * against calculated balances from journal entries.
 */

import * as admin from "firebase-admin";
import {
  LedgerAccount,
  LedgerJournal,
  LedgerConfig,
  ReconciliationResult,
  BalanceSnapshot,
  LedgerErrorCodes,
} from "./types";
import { getAccount, logAuditEvent } from "./accounts";

const db = admin.firestore();

// ============================================================================
// RECONCILIATION
// ============================================================================

/**
 * Reconcile a single account
 *
 * Calculates balance from all journal entries and compares to stored balance.
 * Creates a snapshot record of the reconciliation.
 */
export async function reconcileAccount(
  accountId: string
): Promise<ReconciliationResult> {
  const now = admin.firestore.Timestamp.now();

  // Get current stored balance
  const account = await getAccount(accountId);
  if (!account) {
    return {
      accountId,
      storedBalance: 0,
      calculatedBalance: 0,
      isReconciled: false,
      discrepancy: 0,
      checkedAt: now,
    };
  }

  // Calculate balance from all journal entries
  const calculatedBalance = await calculateBalanceFromEntries(accountId);

  const discrepancy = account.balance - calculatedBalance;
  const isReconciled = discrepancy === 0;

  const result: ReconciliationResult = {
    accountId,
    storedBalance: account.balance,
    calculatedBalance,
    isReconciled,
    discrepancy,
    checkedAt: now,
  };

  // Create snapshot
  await createBalanceSnapshot(accountId, account.balance, calculatedBalance);

  // Log audit event if discrepancy found
  if (!isReconciled) {
    console.error(
      `BALANCE DRIFT DETECTED for ${accountId}: stored=${account.balance}, calculated=${calculatedBalance}, drift=${discrepancy}`
    );

    await logAuditEvent({
      eventType: "balance_drift_detected",
      accountId,
      actorId: "system",
      actorType: "system",
      description: `Balance drift detected: stored=${account.balance}, calculated=${calculatedBalance}`,
      previousValue: account.balance,
      newValue: calculatedBalance,
      metadata: {
        discrepancy,
        accountType: account.type,
      },
    });
  } else {
    await logAuditEvent({
      eventType: "reconciliation_passed",
      accountId,
      actorId: "system",
      actorType: "system",
      description: `Account reconciled successfully: balance=${account.balance}`,
      metadata: {
        balance: account.balance,
      },
    });
  }

  return result;
}

/**
 * Reconcile all accounts
 */
export async function reconcileAllAccounts(): Promise<{
  total: number;
  passed: number;
  failed: number;
  results: ReconciliationResult[];
}> {
  const snapshot = await db.collection(LedgerConfig.COLLECTION_ACCOUNTS).get();

  const results: ReconciliationResult[] = [];
  let passed = 0;
  let failed = 0;

  for (const doc of snapshot.docs) {
    const account = doc.data() as LedgerAccount;
    const result = await reconcileAccount(account.id);
    results.push(result);

    if (result.isReconciled) {
      passed++;
    } else {
      failed++;
    }
  }

  // Log summary
  console.log(
    `Reconciliation complete: ${passed} passed, ${failed} failed out of ${snapshot.docs.length} accounts`
  );

  if (failed > 0) {
    await logAuditEvent({
      eventType: "reconciliation_failed",
      actorId: "system",
      actorType: "system",
      description: `Reconciliation completed with ${failed} failures`,
      metadata: {
        total: snapshot.docs.length,
        passed,
        failed,
        failedAccounts: results
          .filter((r) => !r.isReconciled)
          .map((r) => r.accountId),
      },
    });
  }

  return {
    total: snapshot.docs.length,
    passed,
    failed,
    results,
  };
}

/**
 * Calculate account balance from all journal entries
 */
export async function calculateBalanceFromEntries(
  accountId: string
): Promise<number> {
  // Get all posted journals
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .where("status", "==", "posted")
    .get();

  let balance = 0;

  for (const doc of snapshot.docs) {
    const journal = doc.data() as LedgerJournal;

    for (const entry of journal.entries) {
      if (entry.accountId === accountId) {
        if (entry.entryType === "credit") {
          balance += entry.amount;
        } else {
          balance -= entry.amount;
        }
      }
    }
  }

  return balance;
}

/**
 * Create a balance snapshot
 */
async function createBalanceSnapshot(
  accountId: string,
  storedBalance: number,
  calculatedBalance: number
): Promise<void> {
  const snapshotRef = db.collection(LedgerConfig.COLLECTION_SNAPSHOTS).doc();
  const now = admin.firestore.Timestamp.now();

  // Get the last posted journal
  const lastJournalSnapshot = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .where("status", "==", "posted")
    .orderBy("postedAt", "desc")
    .limit(1)
    .get();

  const lastJournal = lastJournalSnapshot.docs[0]?.data() as LedgerJournal | undefined;

  const snapshot: BalanceSnapshot = {
    id: snapshotRef.id,
    accountId,
    balance: storedBalance,
    lastJournalId: lastJournal?.id || "",
    lastJournalPostedAt: lastJournal?.postedAt || now,
    snapshotAt: now,
    calculatedBalance,
    isReconciled: storedBalance === calculatedBalance,
    discrepancy: storedBalance - calculatedBalance,
  };

  await snapshotRef.set(snapshot);
}

// ============================================================================
// INTEGRITY CHECKS
// ============================================================================

/**
 * Verify a specific journal is balanced
 */
export async function verifyJournalBalanced(
  journalId: string
): Promise<{ balanced: boolean; debits: number; credits: number }> {
  const doc = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .doc(journalId)
    .get();

  if (!doc.exists) {
    throw new Error(`${LedgerErrorCodes.JOURNAL_NOT_FOUND}: ${journalId}`);
  }

  const journal = doc.data() as LedgerJournal;

  const debits = journal.entries
    .filter((e) => e.entryType === "debit")
    .reduce((sum, e) => sum + e.amount, 0);

  const credits = journal.entries
    .filter((e) => e.entryType === "credit")
    .reduce((sum, e) => sum + e.amount, 0);

  return {
    balanced: debits === credits,
    debits,
    credits,
  };
}

/**
 * Verify all journals are balanced
 */
export async function verifyAllJournalsBalanced(): Promise<{
  total: number;
  balanced: number;
  unbalanced: string[];
}> {
  const snapshot = await db.collection(LedgerConfig.COLLECTION_JOURNALS).get();

  let balanced = 0;
  const unbalanced: string[] = [];

  for (const doc of snapshot.docs) {
    const journal = doc.data() as LedgerJournal;

    const debits = journal.entries
      .filter((e) => e.entryType === "debit")
      .reduce((sum, e) => sum + e.amount, 0);

    const credits = journal.entries
      .filter((e) => e.entryType === "credit")
      .reduce((sum, e) => sum + e.amount, 0);

    if (debits === credits) {
      balanced++;
    } else {
      unbalanced.push(journal.id);
      console.error(
        `Unbalanced journal ${journal.id}: debits=${debits}, credits=${credits}`
      );
    }
  }

  return {
    total: snapshot.docs.length,
    balanced,
    unbalanced,
  };
}

/**
 * Verify total system balance equals zero (true double-entry invariant)
 *
 * In a proper double-entry system, the sum of ALL account balances
 * must always equal zero. With the seeded treasury model:
 *
 *   mint (negative) + treasury + users + pots + suppliers + cashout + other system = 0
 *
 * The mint account is the only account allowed to go negative. Its absolute
 * value represents the total tokens ever created.
 */
export async function verifySystemBalance(): Promise<{
  isValid: boolean;
  sumAllBalances: number;
  mintBalance: number;
  totalMinted: number;
  treasuryBalance: number;
  userBalances: number;
  potBalances: number;
  supplierBalances: number;
  clientBalances: number;
  pendingCashout: number;
  otherSystemBalances: number;
}> {
  const snapshot = await db.collection(LedgerConfig.COLLECTION_ACCOUNTS).get();

  let mintBalance = 0;
  let treasuryBalance = 0;
  let otherSystemBalances = 0;
  let userBalances = 0;
  let potBalances = 0;
  let supplierBalances = 0;
  let clientBalances = 0;
  let pendingCashout = 0;

  for (const doc of snapshot.docs) {
    const account = doc.data() as LedgerAccount;

    if (account.id === "system:mint") {
      mintBalance = account.balance;
    } else if (account.id === "system:treasury") {
      treasuryBalance = account.balance;
    } else if (account.type === "system") {
      otherSystemBalances += account.balance;
    } else if (account.type === "user") {
      userBalances += account.balance;
    } else if (account.type === "pot") {
      potBalances += account.balance;
    } else if (account.type === "supplier") {
      supplierBalances += account.balance;
    } else if (account.type === "client") {
      clientBalances += account.balance;
    } else if (account.type === "cashout") {
      pendingCashout += account.balance;
    }
  }

  // True double-entry invariant: sum of ALL balances must be 0
  const sumAllBalances =
    mintBalance +
    treasuryBalance +
    otherSystemBalances +
    userBalances +
    potBalances +
    supplierBalances +
    clientBalances +
    pendingCashout;

  const isValid = sumAllBalances === 0;

  if (!isValid) {
    console.error(
      `System balance mismatch! Sum of all balances: ${sumAllBalances} (expected 0)`
    );

    await logAuditEvent({
      eventType: "reconciliation_failed",
      actorId: "system",
      actorType: "system",
      description: "System balance verification failed — double-entry invariant broken",
      metadata: {
        sumAllBalances,
        mintBalance,
        treasuryBalance,
        otherSystemBalances,
        userBalances,
        potBalances,
        supplierBalances,
        clientBalances,
        pendingCashout,
      },
    });
  }

  return {
    isValid,
    sumAllBalances,
    mintBalance,
    totalMinted: Math.abs(mintBalance),
    treasuryBalance,
    userBalances,
    potBalances,
    supplierBalances,
    clientBalances,
    pendingCashout,
    otherSystemBalances,
  };
}

// ============================================================================
// REPORTING
// ============================================================================

/**
 * Get reconciliation history for an account
 */
export async function getReconciliationHistory(
  accountId: string,
  limit: number = 30
): Promise<BalanceSnapshot[]> {
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_SNAPSHOTS)
    .where("accountId", "==", accountId)
    .orderBy("snapshotAt", "desc")
    .limit(limit)
    .get();

  return snapshot.docs.map((doc) => doc.data() as BalanceSnapshot);
}

/**
 * Get accounts with balance drift
 */
export async function getAccountsWithDrift(): Promise<BalanceSnapshot[]> {
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_SNAPSHOTS)
    .where("isReconciled", "==", false)
    .orderBy("snapshotAt", "desc")
    .limit(100)
    .get();

  return snapshot.docs.map((doc) => doc.data() as BalanceSnapshot);
}

/**
 * Get system statistics
 */
export async function getLedgerStatistics(): Promise<{
  totalAccounts: number;
  accountsByType: Record<string, number>;
  totalJournals: number;
  journalsByType: Record<string, number>;
  journalsByStatus: Record<string, number>;
  totalTokensInCirculation: number;
  potBalances: { daily: number; weekly: number };
}> {
  // Get account stats
  const accountsSnapshot = await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .get();

  const accountsByType: Record<string, number> = {};
  let totalTokensInCirculation = 0;
  let dailyPotBalance = 0;
  let weeklyPotBalance = 0;

  for (const doc of accountsSnapshot.docs) {
    const account = doc.data() as LedgerAccount;
    accountsByType[account.type] = (accountsByType[account.type] || 0) + 1;

    if (account.type === "user") {
      totalTokensInCirculation += account.balance;
    }
    if (account.id === "pot:daily") {
      dailyPotBalance = account.balance;
      totalTokensInCirculation += account.balance;
    }
    if (account.id === "pot:weekly") {
      weeklyPotBalance = account.balance;
      totalTokensInCirculation += account.balance;
    }
  }

  // Get journal stats
  const journalsSnapshot = await db
    .collection(LedgerConfig.COLLECTION_JOURNALS)
    .get();

  const journalsByType: Record<string, number> = {};
  const journalsByStatus: Record<string, number> = {};

  for (const doc of journalsSnapshot.docs) {
    const journal = doc.data() as LedgerJournal;
    journalsByType[journal.type] = (journalsByType[journal.type] || 0) + 1;
    journalsByStatus[journal.status] =
      (journalsByStatus[journal.status] || 0) + 1;
  }

  return {
    totalAccounts: accountsSnapshot.docs.length,
    accountsByType,
    totalJournals: journalsSnapshot.docs.length,
    journalsByType,
    journalsByStatus,
    totalTokensInCirculation,
    potBalances: {
      daily: dailyPotBalance,
      weekly: weeklyPotBalance,
    },
  };
}

// ============================================================================
// REPAIR FUNCTIONS (Admin only - use with caution)
// ============================================================================

/**
 * Recalculate and fix an account balance from entries
 * DANGER: Only use this if reconciliation has detected a drift
 */
export async function repairAccountBalance(
  accountId: string,
  adminUserId: string,
  reason: string
): Promise<{ previousBalance: number; newBalance: number; fixed: boolean }> {
  const account = await getAccount(accountId);
  if (!account) {
    throw new Error(`${LedgerErrorCodes.ACCOUNT_NOT_FOUND}: ${accountId}`);
  }

  const calculatedBalance = await calculateBalanceFromEntries(accountId);

  if (account.balance === calculatedBalance) {
    return {
      previousBalance: account.balance,
      newBalance: calculatedBalance,
      fixed: false,
    };
  }

  // Update the account balance
  await db.collection(LedgerConfig.COLLECTION_ACCOUNTS).doc(accountId).update({
    balance: calculatedBalance,
    updatedAt: admin.firestore.Timestamp.now(),
    version: admin.firestore.FieldValue.increment(1),
    "metadata.balanceRepaired": true,
    "metadata.lastRepairAt": admin.firestore.Timestamp.now(),
    "metadata.lastRepairBy": adminUserId,
    "metadata.lastRepairReason": reason,
  });

  await logAuditEvent({
    eventType: "manual_adjustment",
    accountId,
    actorId: adminUserId,
    actorType: "admin",
    description: `Balance repaired: ${account.balance} -> ${calculatedBalance}`,
    previousValue: account.balance,
    newValue: calculatedBalance,
    metadata: {
      reason,
      discrepancy: account.balance - calculatedBalance,
    },
  });

  return {
    previousBalance: account.balance,
    newBalance: calculatedBalance,
    fixed: true,
  };
}
