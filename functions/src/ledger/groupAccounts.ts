/**
 * Group Account Ledger Functions
 *
 * Handles ledger operations for group accounts (stokvels, family, organizations, clubs).
 * Each group gets a ledger account with ID format: "group:{groupId}"
 * Groups have a single treasury sub-account for pooled funds.
 */

import * as admin from "firebase-admin";
import { logger } from "firebase-functions/v2";
import {
  LedgerAccount,
  PostJournalResult,
  JournalEntryInput,
  AccountId,
  IdempotencyKey,
  LedgerConfig,
} from "./types";
import { postJournal } from "./journals";
import { validateMainWalletBalance } from "./subAccounts";

const db = admin.firestore();

// ============================================================================
// GROUP ACCOUNT MANAGEMENT
// ============================================================================

/**
 * Get or create a ledger account for a group
 *
 * @param groupId - The group's ID
 * @returns The account ID and treasury sub-account ID
 */
export async function getOrCreateGroupAccount(
  groupId: string
): Promise<{ accountId: string; subAccountId: string }> {
  const accountId = AccountId.group(groupId);

  const accountRef = db.collection(LedgerConfig.COLLECTION_ACCOUNTS).doc(accountId);
  const accountDoc = await accountRef.get();

  if (accountDoc.exists) {
    // Get existing treasury sub-account
    const subAccountsSnap = await accountRef
      .collection("subAccounts")
      .where("name", "==", "Treasury")
      .limit(1)
      .get();

    if (!subAccountsSnap.empty) {
      return {
        accountId,
        subAccountId: subAccountsSnap.docs[0].id,
      };
    }
  }

  const now = admin.firestore.Timestamp.now();

  // Create account if doesn't exist
  if (!accountDoc.exists) {
    const account: LedgerAccount = {
      id: accountId,
      type: "group",
      name: `Group Account: ${groupId}`,
      ownerId: groupId,
      balance: 0,
      allocatedBalance: 0,
      currency: "TOKEN",
      status: "active",
      metadata: {
        groupId,
        createdAt: now,
      },
      createdAt: now,
      updatedAt: now,
      version: 1,
    };

    await accountRef.set(account);
  }

  // Create treasury sub-account
  const subAccountRef = accountRef.collection("subAccounts").doc();
  const subAccountData = {
    id: subAccountRef.id,
    userId: groupId, // For groups, userId is the groupId
    accountTypeId: null,
    name: "Treasury",
    balance: 0,
    lifetimeCredits: 0,
    lifetimeDebits: 0,
    isActive: true,
    isDefault: true,
    createdAt: now,
    updatedAt: now,
  };

  await subAccountRef.set(subAccountData);

  logger.info(`Created ledger account ${accountId} with treasury ${subAccountRef.id} for group ${groupId}`);

  return {
    accountId,
    subAccountId: subAccountRef.id,
  };
}

/**
 * Get the balance of a group's ledger account
 *
 * @param groupId - The group's ID
 * @returns The total balance
 */
export async function getGroupBalance(groupId: string): Promise<number> {
  const accountId = AccountId.group(groupId);
  const accountDoc = await db.collection(LedgerConfig.COLLECTION_ACCOUNTS).doc(accountId).get();

  if (!accountDoc.exists) {
    return 0;
  }

  // Sum all sub-account balances
  const subAccountsSnap = await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .collection("subAccounts")
    .where("isActive", "==", true)
    .get();

  let total = 0;
  for (const doc of subAccountsSnap.docs) {
    total += doc.data().balance || 0;
  }

  return total;
}

/**
 * Get the group's treasury sub-account
 */
async function getGroupTreasurySubAccount(groupId: string): Promise<{
  accountId: string;
  subAccountId: string;
  balance: number;
} | null> {
  const accountId = AccountId.group(groupId);
  const subAccountsSnap = await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .collection("subAccounts")
    .where("name", "==", "Treasury")
    .where("isActive", "==", true)
    .limit(1)
    .get();

  if (subAccountsSnap.empty) {
    return null;
  }

  const subAccount = subAccountsSnap.docs[0];
  return {
    accountId,
    subAccountId: subAccount.id,
    balance: subAccount.data().balance || 0,
  };
}

// ============================================================================
// GROUP TRANSACTIONS
// ============================================================================

/**
 * Process a contribution from a member to a group
 *
 * @param groupId - The group's ID
 * @param memberId - The contributing member's user ID
 * @param amount - Token amount to contribute
 * @param transactionId - Reference transaction ID
 * @returns PostJournalResult
 */
export async function processGroupContribution(
  groupId: string,
  memberId: string,
  amount: number,
  transactionId: string
): Promise<PostJournalResult> {
  // Ensure group account exists
  const { accountId: groupAccountId, subAccountId: groupSubAccountId } =
    await getOrCreateGroupAccount(groupId);

  // Validate member has sufficient balance (main wallet)
  const mainCheck = await validateMainWalletBalance(memberId, amount);
  if (!mainCheck.sufficient) {
    return {
      success: false,
      error: `Insufficient balance: has ${mainCheck.available}, needs ${amount}`,
      errorCode: "INSUFFICIENT_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    {
      accountId: AccountId.user(memberId),
      entryType: "debit",
      amount,
      description: `Contribution to group ${groupId}`,
    },
    {
      accountId: groupAccountId,
      entryType: "credit",
      amount,
      description: `Contribution from member ${memberId}`,
    },
  ];

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.groupContribution(groupId, transactionId),
    type: "group_contribution",
    description: `Group contribution: ${amount} tokens from ${memberId} to ${groupId}`,
    entries,
    referenceType: "group",
    referenceId: transactionId,
    initiatedBy: memberId,
    metadata: {
      groupId,
      memberId,
      amount,
      transactionId,
      groupSubAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Journal entry debits the user's ledger account balance
  // No sub-account debit needed — tokens come from main wallet
  if (!journalResult.isDuplicate) {

    // Credit group's treasury sub-account
    await creditGroupSubAccount(groupId, groupSubAccountId, amount);
  }

  return journalResult;
}

/**
 * Process a withdrawal from a group to a member
 *
 * @param groupId - The group's ID
 * @param memberId - The withdrawing member's user ID
 * @param amount - Token amount to withdraw
 * @param transactionId - Reference transaction ID
 * @returns PostJournalResult
 */
export async function processGroupWithdrawal(
  groupId: string,
  memberId: string,
  amount: number,
  transactionId: string
): Promise<PostJournalResult> {
  // Get group account
  const groupTreasury = await getGroupTreasurySubAccount(groupId);
  if (!groupTreasury) {
    return {
      success: false,
      error: `Group account not found: ${groupId}`,
      errorCode: "GROUP_NOT_FOUND",
    };
  }

  // Validate group has sufficient balance
  if (groupTreasury.balance < amount) {
    return {
      success: false,
      error: `Insufficient group balance: has ${groupTreasury.balance}, needs ${amount}`,
      errorCode: "AMOUNT_EXCEEDS_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    {
      accountId: groupTreasury.accountId,
      entryType: "debit",
      amount,
      description: `Withdrawal by member ${memberId}`,
    },
    {
      accountId: AccountId.user(memberId),
      entryType: "credit",
      amount,
      description: `Withdrawal from group ${groupId}`,
    },
  ];

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.groupWithdrawal(groupId, transactionId),
    type: "group_withdrawal",
    description: `Group withdrawal: ${amount} tokens from ${groupId} to ${memberId}`,
    entries,
    referenceType: "group",
    referenceId: transactionId,
    initiatedBy: memberId,
    metadata: {
      groupId,
      memberId,
      amount,
      transactionId,
      groupSubAccountId: groupTreasury.subAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Journal entry credits the user's ledger account balance (main wallet)
  // Only debit the group's treasury sub-account
  if (!journalResult.isDuplicate) {
    await debitGroupSubAccount(groupId, groupTreasury.subAccountId, amount);
  }

  return journalResult;
}

/**
 * Process a payout from a group to one or more members
 *
 * @param groupId - The group's ID
 * @param payouts - Array of payout details { memberId, amount }
 * @param transactionId - Reference transaction ID
 * @returns PostJournalResult
 */
export async function processGroupPayout(
  groupId: string,
  payouts: Array<{ memberId: string; amount: number }>,
  transactionId: string
): Promise<PostJournalResult> {
  // Get group account
  const groupTreasury = await getGroupTreasurySubAccount(groupId);
  if (!groupTreasury) {
    return {
      success: false,
      error: `Group account not found: ${groupId}`,
      errorCode: "GROUP_NOT_FOUND",
    };
  }

  // Calculate total payout
  const totalAmount = payouts.reduce((sum, p) => sum + p.amount, 0);

  // Validate group has sufficient balance
  if (groupTreasury.balance < totalAmount) {
    return {
      success: false,
      error: `Insufficient group balance: has ${groupTreasury.balance}, needs ${totalAmount}`,
      errorCode: "AMOUNT_EXCEEDS_BALANCE",
    };
  }

  // Prepare entries - one debit from group, multiple credits to members
  const entries: JournalEntryInput[] = [
    {
      accountId: groupTreasury.accountId,
      entryType: "debit",
      amount: totalAmount,
      description: `Payout to ${payouts.length} member(s)`,
    },
  ];

  for (const payout of payouts) {
    entries.push({
      accountId: AccountId.user(payout.memberId),
      entryType: "credit",
      amount: payout.amount,
      description: `Payout from group ${groupId}`,
    });
  }

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.groupPayout(groupId, transactionId),
    type: "group_payout",
    description: `Group payout: ${totalAmount} tokens from ${groupId} to ${payouts.length} member(s)`,
    entries,
    referenceType: "group",
    referenceId: transactionId,
    initiatedBy: "system",
    metadata: {
      groupId,
      payouts,
      totalAmount,
      transactionId,
      groupSubAccountId: groupTreasury.subAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Update sub-account balances
  if (!journalResult.isDuplicate) {
    // Debit group's treasury sub-account
    await debitGroupSubAccount(groupId, groupTreasury.subAccountId, totalAmount);

    // Journal entries credit each member's ledger account (main wallet)
    // No sub-account credits needed
  }

  return journalResult;
}

/**
 * Process a penalty charged to a group member
 *
 * @param groupId - The group's ID
 * @param memberId - The member being penalized
 * @param amount - Penalty amount
 * @param reason - Reason for penalty
 * @param date - Date string for the penalty period
 * @returns PostJournalResult
 */
export async function processGroupPenalty(
  groupId: string,
  memberId: string,
  amount: number,
  reason: string,
  date: string
): Promise<PostJournalResult> {
  // Validate member has sufficient balance (main wallet)
  const mainCheck = await validateMainWalletBalance(memberId, amount);
  if (!mainCheck.sufficient) {
    return {
      success: false,
      error: `Insufficient balance for penalty: has ${mainCheck.available}, needs ${amount}`,
      errorCode: "INSUFFICIENT_BALANCE",
    };
  }

  // Get group account
  const { accountId: groupAccountId, subAccountId: groupSubAccountId } =
    await getOrCreateGroupAccount(groupId);

  const entries: JournalEntryInput[] = [
    {
      accountId: AccountId.user(memberId),
      entryType: "debit",
      amount,
      description: `Penalty: ${reason}`,
    },
    {
      accountId: groupAccountId,
      entryType: "credit",
      amount,
      description: `Penalty from member ${memberId}`,
    },
  ];

  const journalResult = await postJournal({
    idempotencyKey: IdempotencyKey.groupPenalty(groupId, memberId, date),
    type: "group_penalty",
    description: `Group penalty: ${amount} tokens from ${memberId} - ${reason}`,
    entries,
    referenceType: "group",
    referenceId: `penalty:${groupId}:${memberId}:${date}`,
    initiatedBy: "system",
    metadata: {
      groupId,
      memberId,
      amount,
      reason,
      date,
      groupSubAccountId,
    },
  });

  if (!journalResult.success) {
    return journalResult;
  }

  // Journal entry debits the user's ledger account balance (main wallet)
  // Only credit the group's treasury sub-account
  if (!journalResult.isDuplicate) {
    await creditGroupSubAccount(groupId, groupSubAccountId, amount);
  }

  return journalResult;
}

// ============================================================================
// HELPER FUNCTIONS FOR GROUP SUB-ACCOUNTS
// ============================================================================

/**
 * Credit a group's sub-account
 */
async function creditGroupSubAccount(
  groupId: string,
  subAccountId: string,
  amount: number
): Promise<void> {
  const accountId = AccountId.group(groupId);
  const now = admin.firestore.Timestamp.now();

  await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .collection("subAccounts")
    .doc(subAccountId)
    .update({
      balance: admin.firestore.FieldValue.increment(amount),
      lifetimeCredits: admin.firestore.FieldValue.increment(amount),
      updatedAt: now,
    });

  // Also update the main account balance
  await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .update({
      balance: admin.firestore.FieldValue.increment(amount),
      updatedAt: now,
    });
}

/**
 * Debit a group's sub-account
 */
async function debitGroupSubAccount(
  groupId: string,
  subAccountId: string,
  amount: number
): Promise<void> {
  const accountId = AccountId.group(groupId);
  const now = admin.firestore.Timestamp.now();

  await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .collection("subAccounts")
    .doc(subAccountId)
    .update({
      balance: admin.firestore.FieldValue.increment(-amount),
      lifetimeDebits: admin.firestore.FieldValue.increment(amount),
      updatedAt: now,
    });

  // Also update the main account balance
  await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .update({
      balance: admin.firestore.FieldValue.increment(-amount),
      updatedAt: now,
    });
}

/**
 * Delete a group's ledger account and sub-accounts
 *
 * @param groupId - The group's ID
 */
export async function deleteGroupAccount(groupId: string): Promise<void> {
  const accountId = AccountId.group(groupId);
  const accountRef = db.collection(LedgerConfig.COLLECTION_ACCOUNTS).doc(accountId);

  // Delete all sub-accounts
  const subAccountsSnap = await accountRef.collection("subAccounts").get();
  const batch = db.batch();

  for (const doc of subAccountsSnap.docs) {
    batch.delete(doc.ref);
  }

  // Delete the main account
  batch.delete(accountRef);

  await batch.commit();
  logger.info(`Deleted ledger account for group ${groupId}`);
}
