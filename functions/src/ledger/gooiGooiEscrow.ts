/**
 * Gooi-Gooi Escrow Functions
 *
 * Dedicated ledger operations for Gooi-Gooi rotating savings.
 * Uses group account type with Pot and Reserve sub-accounts.
 *
 * Flow:
 *   Member wallet → Group Pot (contribution)
 *   Member wallet → Group Reserve (3% split from contribution)
 *   Group Pot → Recipient wallet (payout)
 *   Group Reserve → Group Pot (shortfall coverage)
 *   Member wallet → Group Pot (late fee)
 *   Group Pot/Reserve → Member wallet (refund on dissolution/removal)
 *   Member wallet → Group Pot (debt recovery)
 *   Group Reserve → Member wallets (round completion return)
 *   Bidding discount pool → Member wallets (round completion bonus)
 *   Ledger adjustment → Zero negative reserve (bad debt writeoff)
 */

import * as admin from "firebase-admin";
import { logger } from "firebase-functions/v2";
import {
  AccountId,
  IdempotencyKey,
  LedgerConfig,
  PostJournalResult,
  JournalEntryInput,
  LedgerAccount,
} from "./types";
import { postJournal } from "./journals";
import { ensureSystemAccounts, getOrCreateUserAccount } from "./accounts";
import { validateMainWalletBalance } from "./subAccounts";

const db = admin.firestore();

// ============================================================================
// GROUP ACCOUNT MANAGEMENT (Pot + Reserve sub-accounts)
// ============================================================================

/**
 * Get or create a Gooi-Gooi group ledger account with Pot and Reserve sub-accounts.
 */
export async function getOrCreateGooiGroupAccount(
  groupId: string
): Promise<{ accountId: string; potSubAccountId: string; reserveSubAccountId: string }> {
  const accountId = AccountId.group(groupId);
  const accountRef = db.collection(LedgerConfig.COLLECTION_ACCOUNTS).doc(accountId);
  const accountDoc = await accountRef.get();
  const now = admin.firestore.Timestamp.now();

  if (accountDoc.exists) {
    // Get existing sub-accounts
    const subAccountsSnap = await accountRef.collection("subAccounts").get();
    let potId: string | null = null;
    let reserveId: string | null = null;

    for (const doc of subAccountsSnap.docs) {
      const name = doc.data().name;
      if (name === "Pot") potId = doc.id;
      if (name === "Reserve") reserveId = doc.id;
    }

    // Create missing sub-accounts if needed
    if (!potId) {
      const potRef = accountRef.collection("subAccounts").doc();
      await potRef.set({
        id: potRef.id, userId: groupId, accountTypeId: null,
        name: "Pot", balance: 0, lifetimeCredits: 0, lifetimeDebits: 0,
        isActive: true, isDefault: true, lastCreditAt: null, createdAt: now, updatedAt: now,
      });
      potId = potRef.id;
    }
    if (!reserveId) {
      const resRef = accountRef.collection("subAccounts").doc();
      await resRef.set({
        id: resRef.id, userId: groupId, accountTypeId: null,
        name: "Reserve", balance: 0, lifetimeCredits: 0, lifetimeDebits: 0,
        isActive: true, isDefault: false, lastCreditAt: null, createdAt: now, updatedAt: now,
      });
      reserveId = resRef.id;
    }

    return { accountId, potSubAccountId: potId, reserveSubAccountId: reserveId };
  }

  // Create account from scratch
  const account: LedgerAccount = {
    id: accountId,
    type: "group",
    name: `Gooi-Gooi Group: ${groupId}`,
    ownerId: groupId,
    balance: 0,
    allocatedBalance: 0,
    currency: "TOKEN",
    status: "active",
    metadata: { groupId, type: "gooi_gooi", createdAt: now },
    createdAt: now,
    updatedAt: now,
    version: 1,
  };
  await accountRef.set(account);

  // Create Pot sub-account
  const potRef = accountRef.collection("subAccounts").doc();
  await potRef.set({
    id: potRef.id, userId: groupId, accountTypeId: null,
    name: "Pot", balance: 0, lifetimeCredits: 0, lifetimeDebits: 0,
    isActive: true, isDefault: true, lastCreditAt: null, createdAt: now, updatedAt: now,
  });

  // Create Reserve sub-account
  const resRef = accountRef.collection("subAccounts").doc();
  await resRef.set({
    id: resRef.id, userId: groupId, accountTypeId: null,
    name: "Reserve", balance: 0, lifetimeCredits: 0, lifetimeDebits: 0,
    isActive: true, isDefault: false, lastCreditAt: null, createdAt: now, updatedAt: now,
  });

  logger.info(`Created Gooi-Gooi ledger account ${accountId} with Pot=${potRef.id}, Reserve=${resRef.id}`);

  return { accountId, potSubAccountId: potRef.id, reserveSubAccountId: resRef.id };
}

/**
 * Get the balance of a specific sub-account (Pot or Reserve).
 */
async function getSubAccountBalance(accountId: string, subAccountId: string): Promise<number> {
  const doc = await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .collection("subAccounts")
    .doc(subAccountId)
    .get();
  return doc.exists ? (doc.data()?.balance || 0) : 0;
}

/**
 * Credit a sub-account balance.
 */
async function creditSubAccount(accountId: string, subAccountId: string, amount: number): Promise<void> {
  const now = admin.firestore.Timestamp.now();
  await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .collection("subAccounts")
    .doc(subAccountId)
    .update({
      balance: admin.firestore.FieldValue.increment(amount),
      lifetimeCredits: admin.firestore.FieldValue.increment(amount),
      lastCreditAt: now,
      updatedAt: now,
    });
}

/**
 * Debit a sub-account balance.
 */
async function debitSubAccount(accountId: string, subAccountId: string, amount: number): Promise<void> {
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
}

// ============================================================================
// LEDGER OPERATIONS
// ============================================================================

/**
 * 1. Process a Gooi-Gooi contribution (base amount → Pot).
 * Called when a member pays their cycle contribution.
 * The reserve split is handled separately by processGooiReserve.
 */
export async function processGooiContribution(
  userId: string,
  groupId: string,
  cycleId: string,
  baseAmount: number
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(userId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  // Validate member has sufficient balance
  const mainCheck = await validateMainWalletBalance(userId, baseAmount);
  if (!mainCheck.sufficient) {
    return {
      success: false,
      error: `Insufficient balance: has ${mainCheck.available}, needs ${baseAmount}`,
      errorCode: "INSUFFICIENT_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: AccountId.user(userId), entryType: "debit", amount: baseAmount, description: `Gooi-Gooi contribution cycle ${cycleId}` },
    { accountId: groupAccount.accountId, entryType: "credit", amount: baseAmount, description: `Contribution from ${userId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiContribution(groupId, cycleId, userId),
    type: "gooi_contribution",
    description: `Gooi-Gooi contribution: ${baseAmount} tokens from ${userId} to group ${groupId}`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: userId,
    metadata: { groupId, cycleId, userId, baseAmount },
  });

  if (result.success && !result.isDuplicate) {
    await creditSubAccount(groupAccount.accountId, groupAccount.potSubAccountId, baseAmount);
  }

  return result;
}

/**
 * 2. Process reserve split from a contribution (amount → Reserve).
 */
export async function processGooiReserve(
  userId: string,
  groupId: string,
  cycleId: string,
  reserveAmount: number
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(userId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  const mainCheck = await validateMainWalletBalance(userId, reserveAmount);
  if (!mainCheck.sufficient) {
    return {
      success: false,
      error: `Insufficient balance for reserve: has ${mainCheck.available}, needs ${reserveAmount}`,
      errorCode: "INSUFFICIENT_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: AccountId.user(userId), entryType: "debit", amount: reserveAmount, description: `Gooi-Gooi reserve contribution cycle ${cycleId}` },
    { accountId: groupAccount.accountId, entryType: "credit", amount: reserveAmount, description: `Reserve from ${userId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiReserve(groupId, cycleId, userId),
    type: "gooi_reserve",
    description: `Gooi-Gooi reserve: ${reserveAmount} tokens from ${userId} to group ${groupId} reserve`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: userId,
    metadata: { groupId, cycleId, userId, reserveAmount },
  });

  if (result.success && !result.isDuplicate) {
    await creditSubAccount(groupAccount.accountId, groupAccount.reserveSubAccountId, reserveAmount);
  }

  return result;
}

/**
 * 3. Process payout from Pot to recipient.
 */
export async function processGooiPayout(
  groupId: string,
  cycleId: string,
  recipientUserId: string,
  amount: number
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(recipientUserId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  // Validate pot has funds
  const potBalance = await getSubAccountBalance(groupAccount.accountId, groupAccount.potSubAccountId);
  if (potBalance < amount) {
    return {
      success: false,
      error: `Insufficient pot balance: has ${potBalance}, needs ${amount}`,
      errorCode: "AMOUNT_EXCEEDS_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: groupAccount.accountId, entryType: "debit", amount, description: `Payout to ${recipientUserId}` },
    { accountId: AccountId.user(recipientUserId), entryType: "credit", amount, description: `Gooi-Gooi payout from group ${groupId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiPayout(groupId, cycleId, recipientUserId),
    type: "gooi_payout",
    description: `Gooi-Gooi payout: ${amount} tokens from group ${groupId} to ${recipientUserId}`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: "system",
    metadata: { groupId, cycleId, recipientUserId, amount },
  });

  if (result.success && !result.isDuplicate) {
    await debitSubAccount(groupAccount.accountId, groupAccount.potSubAccountId, amount);
  }

  return result;
}

/**
 * 4. Top up pot from reserve (shortfall coverage).
 */
export async function processGooiReserveTopup(
  groupId: string,
  cycleId: string,
  amount: number
): Promise<PostJournalResult> {
  await ensureSystemAccounts();
  const groupAccount = await getOrCreateGooiGroupAccount(groupId);

  const reserveBalance = await getSubAccountBalance(groupAccount.accountId, groupAccount.reserveSubAccountId);
  if (reserveBalance < amount) {
    return {
      success: false,
      error: `Insufficient reserve: has ${reserveBalance}, needs ${amount}`,
      errorCode: "AMOUNT_EXCEEDS_BALANCE",
    };
  }

  // Internal transfer within group — debit reserve sub, credit pot sub
  // On the ledger level this is a self-transfer (same account), so we
  // record it as a zero-net journal with metadata for audit purposes.
  // Since both sub-accounts are under the same group account, we only
  // need to move sub-account balances; the main account balance stays the same.
  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiReserveTopup(groupId, cycleId),
    type: "gooi_reserve_topup",
    description: `Gooi-Gooi reserve topup: ${amount} tokens from reserve to pot for group ${groupId}`,
    entries: [
      { accountId: groupAccount.accountId, entryType: "debit", amount, description: "Reserve → Pot topup (debit group)" },
      { accountId: groupAccount.accountId, entryType: "credit", amount, description: "Reserve → Pot topup (credit group)" },
    ],
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: "system",
    metadata: { groupId, cycleId, amount, type: "reserve_topup" },
  });

  if (result.success && !result.isDuplicate) {
    await debitSubAccount(groupAccount.accountId, groupAccount.reserveSubAccountId, amount);
    await creditSubAccount(groupAccount.accountId, groupAccount.potSubAccountId, amount);
  }

  return result;
}

/**
 * 5. Process late fee from member to pot.
 */
export async function processGooiLateFee(
  userId: string,
  groupId: string,
  cycleId: string,
  amount: number
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(userId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  const mainCheck = await validateMainWalletBalance(userId, amount);
  if (!mainCheck.sufficient) {
    return {
      success: false,
      error: `Insufficient balance for late fee: has ${mainCheck.available}, needs ${amount}`,
      errorCode: "INSUFFICIENT_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: AccountId.user(userId), entryType: "debit", amount, description: `Gooi-Gooi late fee cycle ${cycleId}` },
    { accountId: groupAccount.accountId, entryType: "credit", amount, description: `Late fee from ${userId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiLateFee(groupId, cycleId, userId),
    type: "gooi_late_fee",
    description: `Gooi-Gooi late fee: ${amount} tokens from ${userId}`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: "system",
    metadata: { groupId, cycleId, userId, amount },
  });

  if (result.success && !result.isDuplicate) {
    await creditSubAccount(groupAccount.accountId, groupAccount.potSubAccountId, amount);
  }

  return result;
}

/**
 * 6. Refund from pot/reserve to member (dissolution or removal).
 */
export async function processGooiRefund(
  groupId: string,
  userId: string,
  amount: number,
  sourceSubAccount: "pot" | "reserve"
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(userId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  const subAccountId = sourceSubAccount === "pot"
    ? groupAccount.potSubAccountId
    : groupAccount.reserveSubAccountId;

  const balance = await getSubAccountBalance(groupAccount.accountId, subAccountId);
  if (balance < amount) {
    return {
      success: false,
      error: `Insufficient ${sourceSubAccount} balance: has ${balance}, needs ${amount}`,
      errorCode: "AMOUNT_EXCEEDS_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: groupAccount.accountId, entryType: "debit", amount, description: `Refund from ${sourceSubAccount} to ${userId}` },
    { accountId: AccountId.user(userId), entryType: "credit", amount, description: `Gooi-Gooi refund from group ${groupId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiRefund(groupId, userId),
    type: "gooi_refund",
    description: `Gooi-Gooi refund: ${amount} tokens from group ${groupId} ${sourceSubAccount} to ${userId}`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: "system",
    metadata: { groupId, userId, amount, sourceSubAccount },
  });

  if (result.success && !result.isDuplicate) {
    await debitSubAccount(groupAccount.accountId, subAccountId, amount);
  }

  return result;
}

/**
 * 7. Recover debt from member wallet to pot.
 */
export async function processGooiDebtRecovery(
  userId: string,
  groupId: string,
  debtId: string,
  amount: number
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(userId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  const mainCheck = await validateMainWalletBalance(userId, amount);
  if (!mainCheck.sufficient) {
    return {
      success: false,
      error: `Insufficient balance for debt recovery: has ${mainCheck.available}, needs ${amount}`,
      errorCode: "INSUFFICIENT_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: AccountId.user(userId), entryType: "debit", amount, description: `Gooi-Gooi debt recovery ${debtId}` },
    { accountId: groupAccount.accountId, entryType: "credit", amount, description: `Debt recovery from ${userId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiDebtRecovery(debtId),
    type: "gooi_debt_recovery",
    description: `Gooi-Gooi debt recovery: ${amount} tokens from ${userId} for debt ${debtId}`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: userId,
    metadata: { groupId, userId, debtId, amount },
  });

  if (result.success && !result.isDuplicate) {
    await creditSubAccount(groupAccount.accountId, groupAccount.potSubAccountId, amount);
  }

  return result;
}

/**
 * 8. Return reserve balance to a member at round completion.
 */
export async function processGooiReserveReturn(
  groupId: string,
  userId: string,
  amount: number
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(userId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  const reserveBalance = await getSubAccountBalance(groupAccount.accountId, groupAccount.reserveSubAccountId);
  if (reserveBalance < amount) {
    return {
      success: false,
      error: `Insufficient reserve for return: has ${reserveBalance}, needs ${amount}`,
      errorCode: "AMOUNT_EXCEEDS_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: groupAccount.accountId, entryType: "debit", amount, description: `Reserve return to ${userId}` },
    { accountId: AccountId.user(userId), entryType: "credit", amount, description: `Gooi-Gooi reserve return from group ${groupId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiReserveReturn(groupId, userId),
    type: "gooi_reserve_return",
    description: `Gooi-Gooi reserve return: ${amount} tokens to ${userId}`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: "system",
    metadata: { groupId, userId, amount },
  });

  if (result.success && !result.isDuplicate) {
    await debitSubAccount(groupAccount.accountId, groupAccount.reserveSubAccountId, amount);
  }

  return result;
}

/**
 * 9. Distribute bidding bonus from discount pool to a member at round completion.
 */
export async function processGooiBidBonus(
  groupId: string,
  userId: string,
  amount: number
): Promise<PostJournalResult> {
  const [, , groupAccount] = await Promise.all([
    ensureSystemAccounts(),
    getOrCreateUserAccount(userId),
    getOrCreateGooiGroupAccount(groupId),
  ]);

  // Bid bonus comes from pot (where the discount was accumulated)
  const potBalance = await getSubAccountBalance(groupAccount.accountId, groupAccount.potSubAccountId);
  if (potBalance < amount) {
    return {
      success: false,
      error: `Insufficient pot for bid bonus: has ${potBalance}, needs ${amount}`,
      errorCode: "AMOUNT_EXCEEDS_BALANCE",
    };
  }

  const entries: JournalEntryInput[] = [
    { accountId: groupAccount.accountId, entryType: "debit", amount, description: `Bid bonus to ${userId}` },
    { accountId: AccountId.user(userId), entryType: "credit", amount, description: `Gooi-Gooi bidding bonus from group ${groupId}` },
  ];

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiBidBonus(groupId, userId),
    type: "gooi_bid_bonus",
    description: `Gooi-Gooi bid bonus: ${amount} tokens to ${userId}`,
    entries,
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: "system",
    metadata: { groupId, userId, amount },
  });

  if (result.success && !result.isDuplicate) {
    await debitSubAccount(groupAccount.accountId, groupAccount.potSubAccountId, amount);
  }

  return result;
}

/**
 * 10. Write off bad debt — zeroes negative reserve balance.
 * This is an explicit Initiator action at round close, recorded as a ledger adjustment.
 */
export async function processGooiBadDebtWriteoff(
  groupId: string,
  amount: number,
  initiatorUserId: string
): Promise<PostJournalResult> {
  await ensureSystemAccounts();
  const groupAccount = await getOrCreateGooiGroupAccount(groupId);

  // The writeoff credits the reserve to zero it out, offset by a debit to the same group account.
  // Net effect on the group account is zero — it's an accounting adjustment.
  const result = await postJournal({
    idempotencyKey: IdempotencyKey.gooiBadDebtWriteoff(groupId),
    type: "gooi_bad_debt_writeoff",
    description: `Gooi-Gooi bad debt writeoff: ${amount} tokens for group ${groupId}`,
    entries: [
      { accountId: groupAccount.accountId, entryType: "debit", amount, description: "Bad debt writeoff (debit)" },
      { accountId: groupAccount.accountId, entryType: "credit", amount, description: "Bad debt writeoff (credit)" },
    ],
    referenceType: "gooi_gooi",
    referenceId: groupId,
    initiatedBy: initiatorUserId,
    metadata: { groupId, amount, type: "bad_debt_writeoff" },
  });

  if (result.success && !result.isDuplicate) {
    // Credit the reserve sub-account to bring it back to zero
    await creditSubAccount(groupAccount.accountId, groupAccount.reserveSubAccountId, amount);
    // Debit the pot sub-account by the same amount (the loss is absorbed)
    await debitSubAccount(groupAccount.accountId, groupAccount.potSubAccountId, amount);
  }

  return result;
}
