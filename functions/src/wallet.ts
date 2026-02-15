/**
 * Wallet-related Cloud Functions
 *
 * NOTE: "Wallet" is UI terminology only. Backend uses the Trust Ledger system
 * with sub-accounts for actual balance tracking.
 *
 * Legacy processEarning function removed - earnings are now processed via
 * engagement.ts → processEngagement which uses the ledger system.
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import { requireAdminPermission, createPendingAction } from "./adminAuth";
import {
  initiateCashout,
  failCashout,
  LedgerConfig,
  getSubAccount,
  getDefaultSubAccount,
  getOrCreateDefaultSubAccount,
  getUserSubAccounts,
  transferBetweenSubAccounts,
  processP2PTransfer,
  validateSubAccountAllows,
  validateSubAccountBalance,
  AccountId,
} from "./ledger";
import { SubAccountConfig } from "./ledger/types";

const db = admin.firestore();

/**
 * Process cashout request
 */
export const processCashout = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "processCashout");
  await requirePlayIntegrity(data, context, "processCashout", "HIGHEST");

  const userId = context.auth.uid;
  const { amount, bankDetails } = data;

  // Validate minimum cashout (from ledger config)
  if (amount < LedgerConfig.MIN_CASHOUT_AMOUNT) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      `Minimum cashout is ${LedgerConfig.MIN_CASHOUT_AMOUNT} tokens (R${LedgerConfig.MIN_CASHOUT_AMOUNT / LedgerConfig.TOKENS_PER_ZAR})`
    );
  }

  // Get user's default sub-account
  const subAccount = await getDefaultSubAccount(userId);
  if (!subAccount) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Account not found. Please complete setup first."
    );
  }

  // Validate user's account type allows cashout
  const cashoutAllowed = await validateSubAccountAllows(
    subAccount.accountTypeId,
    "cashout"
  );
  if (!cashoutAllowed.allowed) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      cashoutAllowed.reason || "This account cannot perform cashouts"
    );
  }

  // Validate user's sub-account has sufficient balance
  const balanceCheck = await validateSubAccountBalance(
    userId,
    subAccount.id,
    amount
  );
  if (!balanceCheck.allowed) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      balanceCheck.reason || "Insufficient balance"
    );
  }

  const zarAmount = amount / LedgerConfig.TOKENS_PER_ZAR;

  // Create cashout record first
  const cashoutRef = db.collection("cashouts").doc();
  await cashoutRef.set({
    id: cashoutRef.id,
    userId: userId,
    tokenAmount: amount,
    zarAmount: zarAmount,
    subAccountId: subAccount.id,
    status: "processing",
    bankDetails: bankDetails,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Process cashout through the Trust Ledger system
  // This moves tokens from user's sub-account to system:cashout_pending
  const ledgerResult = await initiateCashout(
    userId,
    amount,
    cashoutRef.id,
    subAccount.id, // User's sub-account to debit
    {
      bankDetails,
      zarAmount,
    }
  );

  if (!ledgerResult.success) {
    // Update cashout as failed
    await cashoutRef.update({
      status: "failed",
      failureReason: ledgerResult.error,
    });
    throw new functions.https.HttpsError(
      "internal",
      `Failed to initiate cashout: ${ledgerResult.error}`
    );
  }

  // Update cashout with ledger reference
  await cashoutRef.update({
    status: "pending",
    ledgerJournalId: ledgerResult.journalId,
  });

  return {
    success: true,
    cashoutId: cashoutRef.id,
    zarAmount,
    ledgerJournalId: ledgerResult.journalId,
  };
});

/**
 * Complete a pending cashout (called after bank transfer is confirmed).
 * Maker-checker: creates a pending action that must be approved by a second admin.
 */
export const completeCashoutRequest = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "completeCashoutRequest");
  const adminCtx = await requireAdminPermission(context, "cashout:complete", "completeCashoutRequest");

  const { cashoutId, adminNotes } = data;

  if (!cashoutId) {
    throw new functions.https.HttpsError("invalid-argument", "Cashout ID is required");
  }

  // Validate cashout exists and is pending before creating pending action
  const cashoutDoc = await db.collection("cashouts").doc(cashoutId).get();
  if (!cashoutDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Cashout not found");
  }

  const cashoutData = cashoutDoc.data()!;
  if (cashoutData.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Cashout is not pending (status: ${cashoutData.status})`
    );
  }

  // Create pending action for maker-checker approval
  const { pendingActionId } = await createPendingAction(
    adminCtx,
    "cashout:complete",
    "completeCashoutRequest",
    {
      cashoutId,
      adminNotes,
      makerUid: adminCtx.uid,
      tokenAmount: cashoutData.tokenAmount,
      userId: cashoutData.userId,
    },
    `Complete cashout ${cashoutId} for ${cashoutData.tokenAmount} tokens`,
  );

  return {
    success: true,
    pendingActionId,
    requiresApproval: true,
    message: "Cashout completion requires approval from a second admin",
  };
});

/**
 * Fail/refund a cashout (if bank transfer fails)
 */
export const failCashoutRequest = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "failCashoutRequest");
  const adminCtx = await requireAdminPermission(context, "cashout:fail", "failCashoutRequest");

  const { cashoutId, reason } = data;

  if (!cashoutId || !reason) {
    throw new functions.https.HttpsError("invalid-argument", "Cashout ID and reason are required");
  }

  // Get cashout record
  const cashoutDoc = await db.collection("cashouts").doc(cashoutId).get();
  if (!cashoutDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Cashout not found");
  }

  const cashoutData = cashoutDoc.data()!;

  if (cashoutData.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Cashout is not pending (status: ${cashoutData.status})`
    );
  }

  // Fail/refund cashout through ledger (moves from pending back to user's sub-account)
  // Get the subAccountId from the cashout record (if not stored, use default)
  let subAccountId = cashoutData.subAccountId;
  if (!subAccountId) {
    // Fallback: get user's default sub-account
    const subAccount = await getDefaultSubAccount(cashoutData.userId);
    if (!subAccount) {
      throw new functions.https.HttpsError(
        "internal",
        "Could not find sub-account for refund"
      );
    }
    subAccountId = subAccount.id;
  }

  const ledgerResult = await failCashout(
    cashoutData.userId,
    cashoutId,
    cashoutData.tokenAmount,
    reason,
    subAccountId, // User's sub-account to credit with refund
    {
      failedBy: adminCtx.uid,
    }
  );

  if (!ledgerResult.success) {
    throw new functions.https.HttpsError(
      "internal",
      `Failed to refund cashout: ${ledgerResult.error}`
    );
  }

  // Update cashout record
  await cashoutDoc.ref.update({
    status: "failed",
    failureReason: reason,
    failedAt: admin.firestore.FieldValue.serverTimestamp(),
    failedBy: adminCtx.uid,
    refundLedgerJournalId: ledgerResult.journalId,
  });

  return {
    success: true,
    ledgerJournalId: ledgerResult.journalId,
  };
});

/**
 * Get all sub-accounts (wallets) for the current user.
 * Auto-creates the default sub-account if none exists.
 */
export const getSubAccounts = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;

  // Ensure default sub-account exists
  await getOrCreateDefaultSubAccount(userId);

  // Return all active sub-accounts
  const subAccounts = await getUserSubAccounts(userId);
  return subAccounts;
});

/**
 * Transfer tokens between the current user's own sub-accounts (wallets).
 */
export const transferBetweenWallets = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { fromSubAccountId, toSubAccountId, amount } = data;

  if (!fromSubAccountId || !toSubAccountId || !amount) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "fromSubAccountId, toSubAccountId, and amount are required"
    );
  }

  if (amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Amount must be positive");
  }

  if (fromSubAccountId === toSubAccountId) {
    throw new functions.https.HttpsError("invalid-argument", "Source and destination must be different");
  }

  // Enforce account type rules: restricted wallets may not allow outbound transfers
  const fromSubAccount = await getSubAccount(userId, fromSubAccountId);
  if (fromSubAccount?.accountTypeId) {
    const allowed = await validateSubAccountAllows(fromSubAccount.accountTypeId, "p2p_send");
    if (!allowed.allowed) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        allowed.reason || "This wallet does not allow outbound transfers"
      );
    }
  }

  try {
    await transferBetweenSubAccounts(userId, fromSubAccountId, userId, toSubAccountId, amount);
    return { success: true };
  } catch (e: unknown) {
    const message = e instanceof Error ? e.message : "Transfer failed";
    throw new functions.https.HttpsError("internal", message);
  }
});

/**
 * Send tokens to another user (P2P transfer).
 */
export const sendP2PTransfer = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "sendP2PTransfer");

  const userId = context.auth.uid;
  const { recipientUserId, amount, subAccountId, note } = data;

  if (!recipientUserId || !amount || !subAccountId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "recipientUserId, amount, and subAccountId are required"
    );
  }

  if (amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Amount must be positive");
  }

  if (recipientUserId === userId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot send to yourself");
  }

  // Validate sender's sub-account allows P2P sends
  const subAccount = await getDefaultSubAccount(userId);
  if (subAccount) {
    const allowed = await validateSubAccountAllows(subAccount.accountTypeId, "p2p_send");
    if (!allowed.allowed) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        allowed.reason || "This wallet cannot send tokens"
      );
    }
  }

  // Validate sufficient balance
  const balanceCheck = await validateSubAccountBalance(userId, subAccountId, amount);
  if (!balanceCheck.allowed) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      balanceCheck.reason || "Insufficient balance"
    );
  }

  // Generate a transfer ID
  const transferRef = db.collection("p2pTransfers").doc();

  const result = await processP2PTransfer(
    userId,
    recipientUserId,
    amount,
    transferRef.id,
    subAccountId,
    undefined, // recipient gets default sub-account
    note || "P2P Transfer",
    { initiatedFrom: "wallet" }
  );

  if (!result.success) {
    throw new functions.https.HttpsError("internal", result.error || "Transfer failed");
  }

  return {
    success: true,
    journalId: result.journalId,
    amount,
  };
});

/**
 * Create a user-defined wallet (budget envelope).
 * Creates an unrestricted sub-account the user can transfer tokens into.
 * Max 10 user-created wallets per user.
 */
export const createUserWallet = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { name } = data;

  if (!name || typeof name !== "string" || name.trim().length === 0) {
    throw new functions.https.HttpsError("invalid-argument", "Wallet name is required");
  }

  const trimmedName = name.trim();
  if (trimmedName.length > 30) {
    throw new functions.https.HttpsError("invalid-argument", "Wallet name must be 30 characters or less");
  }

  // Fetch existing sub-accounts to check limits and duplicates
  const existingSubAccounts = await getUserSubAccounts(userId);

  // Check max wallet limit (10 user-created + 1 default + brand wallets)
  const userCreatedCount = existingSubAccounts.filter(
    (sa) => !sa.isDefault && !sa.accountTypeId
  ).length;
  if (userCreatedCount >= 10) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      "Maximum of 10 custom wallets reached"
    );
  }

  // Check for duplicate name
  const nameExists = existingSubAccounts.some(
    (sa) => sa.name.toLowerCase() === trimmedName.toLowerCase()
  );
  if (nameExists) {
    throw new functions.https.HttpsError(
      "already-exists",
      "A wallet with this name already exists"
    );
  }

  // Create the sub-account under ledgerAccounts/user:{uid}/subAccounts/
  const ledgerAccountRef = db
    .collection(SubAccountConfig.COLLECTION_LEDGER_ACCOUNTS)
    .doc(AccountId.user(userId));

  const subAccountRef = ledgerAccountRef
    .collection(SubAccountConfig.SUBCOLLECTION_SUB_ACCOUNTS)
    .doc();

  const now = admin.firestore.Timestamp.now();

  const subAccount = {
    id: subAccountRef.id,
    userId,
    accountTypeId: null, // unrestricted
    name: trimmedName,
    balance: 0,
    lifetimeCredits: 0,
    lifetimeDebits: 0,
    isDefault: false,
    isActive: true,
    createdAt: now,
    updatedAt: now,
  };

  await subAccountRef.set(subAccount);

  return {
    success: true,
    subAccountId: subAccountRef.id,
    name: trimmedName,
  };
});
