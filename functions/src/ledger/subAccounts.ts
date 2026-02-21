/**
 * Trust Ledger System - Sub-Account Management
 *
 * Sub-accounts are subdivisions within a user's ledger account.
 * They are displayed as "wallets" in the UI but never called wallet in backend.
 *
 * Each user has:
 * - One default (unrestricted) sub-account for general use
 * - Zero or more brand-specific (restricted) sub-accounts
 */

import * as admin from "firebase-admin";
import { logger } from "firebase-functions/v2";
import {
  AccountId,
  SubAccount,
  SubAccountTypeDefinition,
  AccountTypeRules,
  SubAccountOperation,
  SubAccountValidationResult,
  SubAccountConfig,
  SubAccountErrorCodes,
} from "./types";

const db = admin.firestore();

// ============================================================================
// SUB-ACCOUNT RETRIEVAL
// ============================================================================

/**
 * Get a specific sub-account by ID
 */
export async function getSubAccount(
  userId: string,
  subAccountId: string
): Promise<SubAccount | null> {
  const doc = await db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .doc(subAccountId)
    .get();

  if (!doc.exists) {
    return null;
  }

  return doc.data() as SubAccount;
}

/**
 * Get all sub-accounts for a user
 */
export async function getUserSubAccounts(
  userId: string
): Promise<SubAccount[]> {
  const snapshot = await db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .where("isActive", "==", true)
    .orderBy("createdAt", "asc")
    .get();

  return snapshot.docs.map((doc) => doc.data() as SubAccount);
}

/**
 * Get the default (unrestricted) sub-account for a user
 */
export async function getDefaultSubAccount(
  userId: string
): Promise<SubAccount | null> {
  const snapshot = await db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .where("isDefault", "==", true)
    .where("isActive", "==", true)
    .limit(1)
    .get();

  if (snapshot.empty) {
    return null;
  }

  return snapshot.docs[0].data() as SubAccount;
}

/**
 * Get or create a brand-specific sub-account for a user
 */
export async function getOrCreateBrandSubAccount(
  userId: string,
  accountTypeId: string,
  name: string
): Promise<{ subAccountId: string; isNew: boolean }> {
  // Check if user already has a sub-account with this account type
  const snapshot = await db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .where("accountTypeId", "==", accountTypeId)
    .where("isActive", "==", true)
    .limit(1)
    .get();

  if (!snapshot.empty) {
    return { subAccountId: snapshot.docs[0].id, isNew: false };
  }

  // Validate account type exists
  const accountType = await getAccountType(accountTypeId);
  if (!accountType) {
    throw new Error(`${SubAccountErrorCodes.ACCOUNT_TYPE_NOT_FOUND}: ${accountTypeId}`);
  }

  // Create ledger account document if it doesn't exist
  // Parent doc is the ledger account (user:{uid}) — already created by getOrCreateUserAccount
  const ledgerAccountRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId));

  const now = admin.firestore.Timestamp.now();

  // Create the brand sub-account
  const subAccountRef = ledgerAccountRef
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .doc();

  const subAccount: SubAccount = {
    id: subAccountRef.id,
    userId,
    accountTypeId,
    name: name || accountType.name,
    balance: 0,
    lifetimeCredits: 0,
    lifetimeDebits: 0,
    isActive: true,
    isDefault: false,
    createdAt: now,
    updatedAt: now,
  };

  await subAccountRef.set(subAccount);

  logger.info(`Created brand sub-account for user ${userId}: ${subAccountRef.id} (${accountTypeId})`);

  return { subAccountId: subAccountRef.id, isNew: true };
}

// ============================================================================
// ACCOUNT TYPE MANAGEMENT
// ============================================================================

/**
 * Get an account type by ID
 */
export async function getAccountType(
  accountTypeId: string
): Promise<SubAccountTypeDefinition | null> {
  const doc = await db
    .collection(SubAccountConfig.COLLECTION_ACCOUNT_TYPES)
    .doc(accountTypeId)
    .get();

  if (!doc.exists) {
    return null;
  }

  return doc.data() as SubAccountTypeDefinition;
}

/**
 * Get the default unrestricted account type rules
 */
function getDefaultAccountTypeRules(): AccountTypeRules {
  return {
    allowedOfframps: ["*"], // Any offramp allowed
    allowP2pSend: true,
    allowP2pReceive: true,
    allowCashout: true,
    expiryDays: null, // Never expires
  };
}

/**
 * Get account type rules (returns default rules if accountTypeId is null)
 */
export async function getAccountTypeRules(
  accountTypeId: string | null
): Promise<AccountTypeRules> {
  if (!accountTypeId) {
    return getDefaultAccountTypeRules();
  }

  const accountType = await getAccountType(accountTypeId);
  if (!accountType) {
    // If account type not found, return default rules (shouldn't happen)
    logger.warn(`Account type not found: ${accountTypeId}, using default rules`);
    return getDefaultAccountTypeRules();
  }

  return accountType.rules;
}

// ============================================================================
// SUB-ACCOUNT VALIDATION
// ============================================================================

/**
 * Validate if a sub-account allows a specific operation
 */
export async function validateSubAccountAllows(
  accountTypeId: string | null,
  operation: SubAccountOperation
): Promise<SubAccountValidationResult> {
  const rules = await getAccountTypeRules(accountTypeId);

  switch (operation) {
    case "p2p_send":
      if (!rules.allowP2pSend) {
        return {
          allowed: false,
          reason: "This account cannot send P2P transfers",
        };
      }
      break;

    case "p2p_receive":
      if (!rules.allowP2pReceive) {
        return {
          allowed: false,
          reason: "This account cannot receive P2P transfers",
        };
      }
      break;

    case "cashout":
      if (!rules.allowCashout) {
        return {
          allowed: false,
          reason: "This account cannot perform cashouts",
        };
      }
      break;

    case "purchase":
      // Purchase validation requires checking allowedOfframps
      // This is handled separately by validatePurchaseAllowed
      break;
  }

  return { allowed: true };
}

/**
 * Validate if a sub-account allows a specific purchase category
 */
export async function validatePurchaseAllowed(
  accountTypeId: string | null,
  purchaseCategory: string
): Promise<SubAccountValidationResult> {
  const rules = await getAccountTypeRules(accountTypeId);

  // Check if all offramps are allowed
  if (rules.allowedOfframps.includes("*")) {
    return { allowed: true };
  }

  // Check if this specific category is allowed
  if (rules.allowedOfframps.includes(purchaseCategory)) {
    return { allowed: true };
  }

  return {
    allowed: false,
    reason: `This account can only purchase: ${rules.allowedOfframps.join(", ")}`,
  };
}

/**
 * Validate sub-account has sufficient balance
 */
export async function validateSubAccountBalance(
  userId: string,
  subAccountId: string,
  requiredAmount: number
): Promise<SubAccountValidationResult> {
  const subAccount = await getSubAccount(userId, subAccountId);

  if (!subAccount) {
    return {
      allowed: false,
      reason: "Sub-account not found",
    };
  }

  if (!subAccount.isActive) {
    return {
      allowed: false,
      reason: "Sub-account is inactive",
    };
  }

  if (subAccount.balance < requiredAmount) {
    return {
      allowed: false,
      reason: `Insufficient balance: has ${subAccount.balance}, needs ${requiredAmount}`,
    };
  }

  return { allowed: true };
}

// ============================================================================
// SUB-ACCOUNT BALANCE OPERATIONS
// ============================================================================

/**
 * Credit a sub-account (increase balance)
 * Can be used within a transaction by passing tx parameter
 */
export async function creditSubAccount(
  userId: string,
  subAccountId: string,
  amount: number,
  tx?: admin.firestore.Transaction
): Promise<void> {
  if (amount <= 0) {
    throw new Error("Credit amount must be positive");
  }

  const subAccountRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .doc(subAccountId);

  const ledgerAccountRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId));

  const now = admin.firestore.Timestamp.now();

  if (tx) {
    // Use provided transaction
    tx.update(subAccountRef, {
      balance: admin.firestore.FieldValue.increment(amount),
      lifetimeCredits: admin.firestore.FieldValue.increment(amount),
      updatedAt: now,
    });
    tx.update(ledgerAccountRef, {
      allocatedBalance: admin.firestore.FieldValue.increment(amount),
      updatedAt: now,
    });
  } else {
    // Run our own transaction
    await db.runTransaction(async (transaction) => {
      transaction.update(subAccountRef, {
        balance: admin.firestore.FieldValue.increment(amount),
        lifetimeCredits: admin.firestore.FieldValue.increment(amount),
        updatedAt: now,
      });
      transaction.update(ledgerAccountRef, {
        allocatedBalance: admin.firestore.FieldValue.increment(amount),
        totalBalance: admin.firestore.FieldValue.increment(amount), // backward compat
        updatedAt: now,
      });
    });
  }
}

/**
 * Debit a sub-account (decrease balance)
 * Can be used within a transaction by passing tx parameter
 */
export async function debitSubAccount(
  userId: string,
  subAccountId: string,
  amount: number,
  tx?: admin.firestore.Transaction
): Promise<void> {
  if (amount <= 0) {
    throw new Error("Debit amount must be positive");
  }

  const subAccountRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .doc(subAccountId);

  const ledgerAccountRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId));

  const now = admin.firestore.Timestamp.now();

  if (tx) {
    // Validate balance inside transaction
    const subAccountDoc = await tx.get(subAccountRef);
    if (!subAccountDoc.exists) {
      throw new Error(`${SubAccountErrorCodes.SUB_ACCOUNT_NOT_FOUND}: ${subAccountId}`);
    }
    const subAccount = subAccountDoc.data() as SubAccount;
    if (subAccount.balance < amount) {
      throw new Error(
        `${SubAccountErrorCodes.INSUFFICIENT_SUB_ACCOUNT_BALANCE}: has ${subAccount.balance}, needs ${amount}`
      );
    }

    tx.update(subAccountRef, {
      balance: admin.firestore.FieldValue.increment(-amount),
      lifetimeDebits: admin.firestore.FieldValue.increment(amount),
      updatedAt: now,
    });
    tx.update(ledgerAccountRef, {
      allocatedBalance: admin.firestore.FieldValue.increment(-amount),
      updatedAt: now,
    });
  } else {
    // Run our own transaction
    await db.runTransaction(async (transaction) => {
      const subAccountDoc = await transaction.get(subAccountRef);
      if (!subAccountDoc.exists) {
        throw new Error(`${SubAccountErrorCodes.SUB_ACCOUNT_NOT_FOUND}: ${subAccountId}`);
      }
      const subAccount = subAccountDoc.data() as SubAccount;
      if (subAccount.balance < amount) {
        throw new Error(
          `${SubAccountErrorCodes.INSUFFICIENT_SUB_ACCOUNT_BALANCE}: has ${subAccount.balance}, needs ${amount}`
        );
      }

      transaction.update(subAccountRef, {
        balance: admin.firestore.FieldValue.increment(-amount),
        lifetimeDebits: admin.firestore.FieldValue.increment(amount),
        updatedAt: now,
      });
      transaction.update(ledgerAccountRef, {
        allocatedBalance: admin.firestore.FieldValue.increment(-amount),
        totalBalance: admin.firestore.FieldValue.increment(-amount), // backward compat
        updatedAt: now,
      });
    });
  }
}

/**
 * Transfer between sub-accounts (same user or different users)
 */
export async function transferBetweenSubAccounts(
  fromUserId: string,
  fromSubAccountId: string,
  toUserId: string,
  toSubAccountId: string,
  amount: number
): Promise<void> {
  if (amount <= 0) {
    throw new Error("Transfer amount must be positive");
  }

  await db.runTransaction(async (tx) => {
    // Debit source
    await debitSubAccount(fromUserId, fromSubAccountId, amount, tx);
    // Credit destination
    await creditSubAccount(toUserId, toSubAccountId, amount, tx);
  });
}

// ============================================================================
// SUB-ACCOUNT BALANCE QUERIES
// ============================================================================

/**
 * Get sub-account balance
 */
export async function getSubAccountBalance(
  userId: string,
  subAccountId: string
): Promise<number> {
  const subAccount = await getSubAccount(userId, subAccountId);
  return subAccount?.balance || 0;
}

/**
 * Get user's total balance across all sub-accounts (allocated portion)
 */
export async function getUserTotalBalance(userId: string): Promise<number> {
  const ledgerAccountDoc = await db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .get();

  if (!ledgerAccountDoc.exists) {
    return 0;
  }

  const data = ledgerAccountDoc.data();
  return data?.allocatedBalance ?? 0;
}

/**
 * Validate that the user's main wallet has sufficient available balance.
 *
 * Main wallet available = ledgerAccount.balance - ledgerAccount.allocatedBalance
 *
 * Can be called within a transaction by passing the tx parameter.
 */
export async function validateMainWalletBalance(
  userId: string,
  requiredAmount: number,
  tx?: admin.firestore.Transaction
): Promise<{ available: number; sufficient: boolean }> {
  const ledgerAccountRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId));

  const doc = tx
    ? await tx.get(ledgerAccountRef)
    : await ledgerAccountRef.get();

  if (!doc.exists) {
    return { available: 0, sufficient: false };
  }

  const data = doc.data()!;
  const balance = data.balance || 0;
  const allocated = data.allocatedBalance ?? 0;
  const available = balance - allocated;

  return { available, sufficient: available >= requiredAmount };
}

// ============================================================================
// SUB-ACCOUNT LIFECYCLE
// ============================================================================

/**
 * Deactivate a sub-account (soft delete)
 * Requires zero balance
 */
export async function deactivateSubAccount(
  userId: string,
  subAccountId: string
): Promise<void> {
  const subAccount = await getSubAccount(userId, subAccountId);

  if (!subAccount) {
    throw new Error(`${SubAccountErrorCodes.SUB_ACCOUNT_NOT_FOUND}: ${subAccountId}`);
  }

  if (subAccount.isDefault) {
    throw new Error("Cannot deactivate the default sub-account");
  }

  if (subAccount.balance !== 0) {
    throw new Error("Cannot deactivate sub-account with non-zero balance");
  }

  await db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .doc(subAccountId)
    .update({
      isActive: false,
      updatedAt: admin.firestore.Timestamp.now(),
    });
}

/**
 * Delete all sub-accounts for a user (used during account deletion)
 */
export async function deleteAllSubAccounts(userId: string): Promise<void> {
  const subAccountsRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS);

  const snapshot = await subAccountsRef.get();

  const batch = db.batch();
  for (const doc of snapshot.docs) {
    batch.delete(doc.ref);
  }
  await batch.commit();

  // Delete the ledger account document
  await db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId))
    .delete();

  logger.info(`Deleted all sub-accounts for user ${userId}`);
}

// ============================================================================
// ACCOUNT TYPE CRUD (Admin only)
// ============================================================================

/**
 * Create a new account type (admin function)
 */
export async function createAccountType(
  id: string,
  name: string,
  description: string,
  rules: AccountTypeRules,
  options?: {
    advertiserId?: string;
    iconUrl?: string;
  }
): Promise<SubAccountTypeDefinition> {
  const now = admin.firestore.Timestamp.now();

  const accountType: SubAccountTypeDefinition = {
    id,
    advertiserId: options?.advertiserId || null,
    name,
    description,
    iconUrl: options?.iconUrl || null,
    isRestricted: !rules.allowedOfframps.includes("*"),
    rules,
    isActive: true,
    createdAt: now,
  };

  await db
    .collection(SubAccountConfig.COLLECTION_ACCOUNT_TYPES)
    .doc(id)
    .set(accountType);

  return accountType;
}

/**
 * List all active account types
 */
export async function listAccountTypes(): Promise<SubAccountTypeDefinition[]> {
  const snapshot = await db
    .collection(SubAccountConfig.COLLECTION_ACCOUNT_TYPES)
    .where("isActive", "==", true)
    .get();

  return snapshot.docs.map((doc) => doc.data() as SubAccountTypeDefinition);
}
