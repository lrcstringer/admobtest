/**
 * Trust Ledger System - Account Management
 *
 * Handles creation, retrieval, and management of ledger accounts.
 * All accounts are stored in the ledgerAccounts collection.
 */

import * as admin from "firebase-admin";
import {
  LedgerAccount,
  CreateAccountInput,
  AccountType,
  AccountStatus,
  LedgerConfig,
  LedgerErrorCodes,
  SystemAccounts,
  AccountId,
  LedgerOperationResult,
  AuditLogEntry,
  AuditEventType,
} from "./types";

const db = admin.firestore();

// ============================================================================
// ACCOUNT RETRIEVAL
// ============================================================================

/**
 * Get an account by ID
 */
export async function getAccount(
  accountId: string
): Promise<LedgerAccount | null> {
  const doc = await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .get();

  if (!doc.exists) {
    return null;
  }

  return doc.data() as LedgerAccount;
}

/**
 * Get an account by ID, throwing if not found
 */
export async function getAccountOrThrow(accountId: string): Promise<LedgerAccount> {
  const account = await getAccount(accountId);
  if (!account) {
    throw new Error(`${LedgerErrorCodes.ACCOUNT_NOT_FOUND}: ${accountId}`);
  }
  return account;
}

/**
 * Get multiple accounts by IDs
 */
export async function getAccounts(
  accountIds: string[]
): Promise<Map<string, LedgerAccount>> {
  if (accountIds.length === 0) {
    return new Map();
  }

  const results = new Map<string, LedgerAccount>();

  // Firestore IN queries limited to 30 items, so batch if needed
  const batches: string[][] = [];
  for (let i = 0; i < accountIds.length; i += 30) {
    batches.push(accountIds.slice(i, i + 30));
  }

  for (const batch of batches) {
    const snapshot = await db
      .collection(LedgerConfig.COLLECTION_ACCOUNTS)
      .where(admin.firestore.FieldPath.documentId(), "in", batch)
      .get();

    for (const doc of snapshot.docs) {
      results.set(doc.id, doc.data() as LedgerAccount);
    }
  }

  return results;
}

/**
 * Get user's account by userId
 */
export async function getUserAccount(
  userId: string
): Promise<LedgerAccount | null> {
  return getAccount(AccountId.user(userId));
}

/**
 * Get user's account, creating if it doesn't exist
 */
export async function getOrCreateUserAccount(
  userId: string,
  userName?: string
): Promise<LedgerAccount> {
  const accountId = AccountId.user(userId);
  let account = await getAccount(accountId);

  if (!account) {
    const result = await createAccount({
      type: "user",
      name: userName || `User ${userId.substring(0, 8)}`,
      ownerId: userId,
      initialBalance: 0,
    });

    if (!result.success || !result.data) {
      throw new Error(result.error || "Failed to create user account");
    }

    account = result.data;
  }

  return account;
}

/**
 * Get all accounts of a specific type
 */
export async function getAccountsByType(
  type: AccountType
): Promise<LedgerAccount[]> {
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .where("type", "==", type)
    .where("status", "==", "active")
    .get();

  return snapshot.docs.map((doc) => doc.data() as LedgerAccount);
}

// ============================================================================
// ACCOUNT CREATION
// ============================================================================

/**
 * Create a new ledger account
 */
export async function createAccount(
  input: CreateAccountInput
): Promise<LedgerOperationResult<LedgerAccount>> {
  const accountId = buildAccountId(input.type, input.ownerId);

  // Check if account already exists
  const existing = await getAccount(accountId);
  if (existing) {
    // Return existing account (idempotent)
    return {
      success: true,
      data: existing,
    };
  }

  const now = admin.firestore.Timestamp.now();
  const account: LedgerAccount = {
    id: accountId,
    type: input.type,
    name: input.name,
    ownerId: input.ownerId,
    balance: input.initialBalance || 0,
    currency: "TOKEN",
    status: "active",
    metadata: input.metadata || {},
    createdAt: now,
    updatedAt: now,
    version: 1,
  };

  try {
    await db
      .collection(LedgerConfig.COLLECTION_ACCOUNTS)
      .doc(accountId)
      .set(account);

    // Log audit event
    await logAuditEvent({
      eventType: "account_created",
      accountId,
      actorId: "system",
      actorType: "system",
      description: `Account created: ${input.name}`,
      newValue: account,
      metadata: {},
    });

    return {
      success: true,
      data: account,
    };
  } catch (error) {
    console.error("Failed to create account:", error);
    return {
      success: false,
      error: `Failed to create account: ${error}`,
      errorCode: LedgerErrorCodes.TRANSACTION_FAILED,
    };
  }
}

/**
 * Build account ID based on type and owner
 */
function buildAccountId(type: AccountType, ownerId?: string): string {
  switch (type) {
    case "user":
      if (!ownerId) throw new Error("User accounts require ownerId");
      return AccountId.user(ownerId);
    case "supplier":
      if (!ownerId) throw new Error("Supplier accounts require ownerId");
      return AccountId.supplier(ownerId);
    case "client":
      if (!ownerId) throw new Error("Client accounts require ownerId");
      return AccountId.client(ownerId);
    case "client_subacc":
      if (!ownerId) throw new Error("Client sub-accounts require ownerId (subAccountId)");
      return AccountId.clientSubAccount(ownerId);
    case "group":
      if (!ownerId) throw new Error("Group accounts require ownerId (groupId)");
      return AccountId.group(ownerId);
    case "system":
    case "pot":
    case "cbook":
      // These use predefined IDs from SystemAccounts
      throw new Error(`${type} accounts should use predefined SystemAccount IDs`);
    default:
      throw new Error(`Unknown account type: ${type}`);
  }
}

// ============================================================================
// SYSTEM ACCOUNT INITIALIZATION
// ============================================================================

/**
 * Initialize all system accounts (call once during deployment)
 */
export async function initializeSystemAccounts(): Promise<void> {
  const systemAccountsToCreate: Array<{
    id: string;
    type: AccountType;
    name: string;
  }> = [
    {
      id: SystemAccounts.CBOOK_BUS,
      type: "cbook",
      name: "iMaliChat Business Cash Book",
    },
    {
      id: SystemAccounts.CBOOK_TRUST,
      type: "cbook",
      name: "Client Trust Cash Book",
    },
    {
      id: SystemAccounts.DAILY_POT,
      type: "pot",
      name: "Daily Pot",
    },
    {
      id: SystemAccounts.WEEKLY_POT,
      type: "pot",
      name: "Weekly Pot",
    },
    {
      id: SystemAccounts.CASHOUT_PENDING,
      type: "system",
      name: "Pending Cashouts",
    },
    {
      id: SystemAccounts.ENGAGEMENT_ESCROW,
      type: "system",
      name: "Engagement Escrow Holding",
    },
    {
      id: SystemAccounts.IMALICHAT_CLIENT,
      type: "client",
      name: "iMaliChat",
    },
  ];

  const batch = db.batch();
  const now = admin.firestore.Timestamp.now();

  for (const accountDef of systemAccountsToCreate) {
    const accountRef = db
      .collection(LedgerConfig.COLLECTION_ACCOUNTS)
      .doc(accountDef.id);

    // Check if exists
    const existing = await accountRef.get();
    if (existing.exists) {
      console.log(`System account ${accountDef.id} already exists, skipping`);
      continue;
    }

    const account: LedgerAccount = {
      id: accountDef.id,
      type: accountDef.type,
      name: accountDef.name,
      balance: 0,
      currency: "TOKEN",
      status: "active",
      metadata: {
        isSystemAccount: true,
        createdDuring: "initialization",
      },
      createdAt: now,
      updatedAt: now,
      version: 1,
    };

    batch.set(accountRef, account);
    console.log(`Creating system account: ${accountDef.id}`);
  }

  await batch.commit();
  console.log("System accounts initialization complete");
}

/**
 * Create a supplier account for a service provider
 */
export async function createSupplierAccount(
  providerId: string,
  providerName: string
): Promise<LedgerAccount> {
  const accountId = AccountId.supplier(providerId);
  const existing = await getAccount(accountId);

  if (existing) {
    return existing;
  }

  const now = admin.firestore.Timestamp.now();
  const account: LedgerAccount = {
    id: accountId,
    type: "supplier",
    name: providerName,
    ownerId: providerId,
    balance: 0,
    currency: "TOKEN",
    status: "active",
    metadata: {
      isSupplierAccount: true,
    },
    createdAt: now,
    updatedAt: now,
    version: 1,
  };

  await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .set(account);

  await logAuditEvent({
    eventType: "account_created",
    accountId,
    actorId: "system",
    actorType: "system",
    description: `Supplier account created: ${providerName}`,
    newValue: account,
    metadata: { providerId },
  });

  return account;
}

/**
 * Create a client account for a brand partner
 */
export async function createClientAccount(
  clientId: string,
  clientName: string,
  metadata?: {
    contactEmail?: string;
    contactName?: string;
    companyRegistration?: string;
    industry?: string;
  }
): Promise<LedgerAccount> {
  const accountId = AccountId.client(clientId);
  const existing = await getAccount(accountId);

  if (existing) {
    return existing;
  }

  const now = admin.firestore.Timestamp.now();
  const account: LedgerAccount = {
    id: accountId,
    type: "client",
    name: clientName,
    ownerId: clientId,
    balance: 0,
    currency: "TOKEN",
    status: "active",
    metadata: {
      isClientAccount: true,
      ...metadata,
    },
    createdAt: now,
    updatedAt: now,
    version: 1,
  };

  await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .doc(accountId)
    .set(account);

  await logAuditEvent({
    eventType: "account_created",
    accountId,
    actorId: "system",
    actorType: "system",
    description: `Client account created: ${clientName}`,
    newValue: account,
    metadata: { clientId, ...metadata },
  });

  return account;
}

/**
 * Get client's account by clientId
 */
export async function getClientAccount(
  clientId: string
): Promise<LedgerAccount | null> {
  return getAccount(AccountId.client(clientId));
}

// ============================================================================
// ACCOUNT STATUS MANAGEMENT
// ============================================================================

/**
 * Freeze an account (prevent all transactions)
 */
export async function freezeAccount(
  accountId: string,
  reason: string,
  frozenBy: string
): Promise<LedgerOperationResult<LedgerAccount>> {
  return updateAccountStatus(accountId, "frozen", reason, frozenBy);
}

/**
 * Unfreeze an account
 */
export async function unfreezeAccount(
  accountId: string,
  reason: string,
  unfrozenBy: string
): Promise<LedgerOperationResult<LedgerAccount>> {
  return updateAccountStatus(accountId, "active", reason, unfrozenBy);
}

/**
 * Close an account (permanent, requires zero balance)
 */
export async function closeAccount(
  accountId: string,
  reason: string,
  closedBy: string
): Promise<LedgerOperationResult<LedgerAccount>> {
  const account = await getAccount(accountId);
  if (!account) {
    return {
      success: false,
      error: "Account not found",
      errorCode: LedgerErrorCodes.ACCOUNT_NOT_FOUND,
    };
  }

  if (account.balance !== 0) {
    return {
      success: false,
      error: "Cannot close account with non-zero balance",
      errorCode: LedgerErrorCodes.BALANCE_WOULD_GO_NEGATIVE,
    };
  }

  return updateAccountStatus(accountId, "closed", reason, closedBy);
}

/**
 * Internal: Update account status
 */
async function updateAccountStatus(
  accountId: string,
  newStatus: AccountStatus,
  reason: string,
  actorId: string
): Promise<LedgerOperationResult<LedgerAccount>> {
  try {
    const accountRef = db
      .collection(LedgerConfig.COLLECTION_ACCOUNTS)
      .doc(accountId);

    const result = await db.runTransaction(async (tx) => {
      const doc = await tx.get(accountRef);
      if (!doc.exists) {
        throw new Error(LedgerErrorCodes.ACCOUNT_NOT_FOUND);
      }

      const account = doc.data() as LedgerAccount;
      const previousStatus = account.status;

      tx.update(accountRef, {
        status: newStatus,
        updatedAt: admin.firestore.Timestamp.now(),
        version: admin.firestore.FieldValue.increment(1),
        [`metadata.statusHistory`]: admin.firestore.FieldValue.arrayUnion({
          from: previousStatus,
          to: newStatus,
          reason,
          by: actorId,
          at: admin.firestore.Timestamp.now(),
        }),
      });

      return { ...account, status: newStatus };
    });

    // Log audit event
    const eventType: AuditEventType =
      newStatus === "frozen"
        ? "account_frozen"
        : newStatus === "active"
          ? "account_unfrozen"
          : "account_closed";

    await logAuditEvent({
      eventType,
      accountId,
      actorId,
      actorType: "admin",
      description: `Account status changed to ${newStatus}: ${reason}`,
      previousValue: result.status,
      newValue: newStatus,
      metadata: { reason },
    });

    return {
      success: true,
      data: result,
    };
  } catch (error) {
    console.error("Failed to update account status:", error);
    return {
      success: false,
      error: `Failed to update account status: ${error}`,
      errorCode: LedgerErrorCodes.TRANSACTION_FAILED,
    };
  }
}

// ============================================================================
// ACCOUNT VALIDATION
// ============================================================================

/**
 * Validate that an account exists and is active
 */
export async function validateAccountActive(
  accountId: string
): Promise<LedgerOperationResult<LedgerAccount>> {
  const account = await getAccount(accountId);

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

  return {
    success: true,
    data: account,
  };
}

/**
 * Validate that an account has sufficient balance for a debit
 */
export async function validateSufficientBalance(
  accountId: string,
  requiredAmount: number
): Promise<LedgerOperationResult<LedgerAccount>> {
  const validationResult = await validateAccountActive(accountId);
  if (!validationResult.success) {
    return validationResult;
  }

  const account = validationResult.data!;

  if (account.balance < requiredAmount) {
    return {
      success: false,
      error: `Insufficient balance: has ${account.balance}, needs ${requiredAmount}`,
      errorCode: LedgerErrorCodes.INSUFFICIENT_BALANCE,
    };
  }

  return {
    success: true,
    data: account,
  };
}

// ============================================================================
// AUDIT LOGGING
// ============================================================================

/**
 * Log an audit event
 */
export async function logAuditEvent(
  input: Omit<AuditLogEntry, "id" | "timestamp">
): Promise<void> {
  const auditRef = db.collection(LedgerConfig.COLLECTION_AUDIT).doc();

  const entry: Record<string, unknown> = {
    id: auditRef.id,
    ...input,
    timestamp: admin.firestore.Timestamp.now(),
  };

  // Strip undefined values — Firestore rejects them
  for (const key of Object.keys(entry)) {
    if (entry[key] === undefined) {
      delete entry[key];
    }
  }

  await auditRef.set(entry);
}

// ============================================================================
// BALANCE QUERIES
// ============================================================================

/**
 * Get account balance
 */
export async function getBalance(accountId: string): Promise<number> {
  const account = await getAccount(accountId);
  return account?.balance || 0;
}

/**
 * Get multiple account balances
 */
export async function getBalances(
  accountIds: string[]
): Promise<Map<string, number>> {
  const accounts = await getAccounts(accountIds);
  const balances = new Map<string, number>();

  for (const [id, account] of accounts) {
    balances.set(id, account.balance);
  }

  // Fill in zeros for accounts that don't exist
  for (const id of accountIds) {
    if (!balances.has(id)) {
      balances.set(id, 0);
    }
  }

  return balances;
}

/**
 * Get total balance across all user accounts
 */
export async function getTotalUserBalance(): Promise<number> {
  const snapshot = await db
    .collection(LedgerConfig.COLLECTION_ACCOUNTS)
    .where("type", "==", "user")
    .where("status", "==", "active")
    .get();

  let total = 0;
  for (const doc of snapshot.docs) {
    const account = doc.data() as LedgerAccount;
    total += account.balance;
  }

  return total;
}

/**
 * Get pot balances
 */
export async function getPotBalances(): Promise<{
  dailyPot: number;
  weeklyPot: number;
}> {
  const [dailyPot, weeklyPot] = await Promise.all([
    getBalance(SystemAccounts.DAILY_POT),
    getBalance(SystemAccounts.WEEKLY_POT),
  ]);

  return { dailyPot, weeklyPot };
}
