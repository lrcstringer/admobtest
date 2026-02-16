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
  getUserSubAccounts,
  creditSubAccount,
  debitSubAccount,
  transferBetweenSubAccounts,
  processP2PTransfer,
  validateSubAccountAllows,
  validateSubAccountBalance,
  validateMainWalletBalance,
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
  const { amount, bankDetails, subAccountId: requestedSubAccountId } = data;

  // Validate minimum cashout (from ledger config)
  if (amount < LedgerConfig.MIN_CASHOUT_AMOUNT) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      `Minimum cashout is ${LedgerConfig.MIN_CASHOUT_AMOUNT} tokens (R${LedgerConfig.MIN_CASHOUT_AMOUNT / LedgerConfig.TOKENS_PER_ZAR})`
    );
  }

  // Determine source: specific sub-account or main wallet
  let subAccountId: string | undefined;

  if (requestedSubAccountId && requestedSubAccountId !== "main") {
    // Specific sub-account requested
    const subAccount = await getSubAccount(userId, requestedSubAccountId);
    if (!subAccount) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Sub-account not found."
      );
    }

    // Validate sub-account's account type allows cashout
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

    // Validate sub-account balance
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
    subAccountId = subAccount.id;
  } else {
    // Main wallet cashout — validate main wallet balance
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Insufficient balance: has ${mainCheck.available}, needs ${amount}`
      );
    }
    // subAccountId remains undefined → main wallet
  }

  const zarAmount = amount / LedgerConfig.TOKENS_PER_ZAR;

  // Create cashout record
  const cashoutRef = db.collection("cashouts").doc();
  await cashoutRef.set({
    id: cashoutRef.id,
    userId: userId,
    tokenAmount: amount,
    zarAmount: zarAmount,
    subAccountId: subAccountId || null,
    status: "processing",
    bankDetails: bankDetails,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Process cashout through the Trust Ledger system
  const ledgerResult = await initiateCashout(
    userId,
    amount,
    cashoutRef.id,
    subAccountId, // Sub-account to debit, or undefined for main wallet
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

  // Fail/refund cashout through ledger (moves from pending back to user's account)
  // subAccountId may be null for main wallet cashouts
  const subAccountId = cashoutData.subAccountId || undefined;

  const ledgerResult = await failCashout(
    cashoutData.userId,
    cashoutId,
    cashoutData.tokenAmount,
    reason,
    subAccountId, // Sub-account to credit, or undefined for main wallet refund
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
 * Returns only user-created and brand sub-accounts (no default auto-creation).
 */
export const getSubAccounts = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "getSubAccounts");

  const userId = context.auth.uid;

  // Return all active sub-accounts (user-created + brand)
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
  requireAppCheck(context, "transferBetweenWallets");

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

  try {
    const fromIsMain = fromSubAccountId === "main";
    const toIsMain = toSubAccountId === "main";

    if (fromIsMain && toIsMain) {
      throw new functions.https.HttpsError("invalid-argument", "Source and destination cannot both be main wallet");
    }

    if (fromIsMain) {
      // Main wallet → sub-account: validate main wallet balance, credit destination only.
      // creditSubAccount increases allocatedBalance, effectively reducing main wallet available.
      const { sufficient, available } = await validateMainWalletBalance(userId, amount);
      if (!sufficient) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          `Insufficient main wallet balance: has ${available}, needs ${amount}`
        );
      }
      await creditSubAccount(userId, toSubAccountId, amount);
    } else if (toIsMain) {
      // Sub-account → main wallet: validate source, debit source only.
      // debitSubAccount decreases allocatedBalance, effectively increasing main wallet available.
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
      await debitSubAccount(userId, fromSubAccountId, amount);
    } else {
      // Sub-account → sub-account: enforce account type rules on source
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
      await transferBetweenSubAccounts(userId, fromSubAccountId, userId, toSubAccountId, amount);
    }

    return { success: true };
  } catch (e: unknown) {
    if (e instanceof functions.https.HttpsError) throw e;
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
  const { recipientUserId, amount, subAccountId: requestedSubAccountId, note } = data;

  if (!recipientUserId || !amount) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "recipientUserId and amount are required"
    );
  }

  if (amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Amount must be positive");
  }

  if (recipientUserId === userId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot send to yourself");
  }

  // Determine source: specific sub-account or main wallet
  let senderSubAccountId: string | undefined;

  if (requestedSubAccountId && requestedSubAccountId !== "main") {
    // Specific sub-account
    const subAccount = await getSubAccount(userId, requestedSubAccountId);
    if (subAccount) {
      const allowed = await validateSubAccountAllows(subAccount.accountTypeId, "p2p_send");
      if (!allowed.allowed) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          allowed.reason || "This wallet cannot send tokens"
        );
      }
    }

    // Validate sub-account balance
    const balanceCheck = await validateSubAccountBalance(userId, requestedSubAccountId, amount);
    if (!balanceCheck.allowed) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        balanceCheck.reason || "Insufficient balance"
      );
    }
    senderSubAccountId = requestedSubAccountId;
  } else {
    // Main wallet — validate main wallet balance
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Insufficient balance: has ${mainCheck.available}, needs ${amount}`
      );
    }
  }

  // Generate a transfer ID
  const transferRef = db.collection("p2pTransfers").doc();

  const result = await processP2PTransfer(
    userId,
    recipientUserId,
    amount,
    transferRef.id,
    senderSubAccountId, // Sender sub-account or undefined for main wallet
    undefined, // Recipient main wallet
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

/**
 * Cancel a pending cashout — reverse the ledger transaction and return tokens.
 */
export const cancelCashout = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "cancelCashout");

  const userId = context.auth.uid;
  const { cashoutId } = data;

  if (!cashoutId) {
    throw new functions.https.HttpsError("invalid-argument", "cashoutId is required");
  }

  // Get cashout document
  const cashoutRef = db.collection("cashouts").doc(cashoutId);
  const cashoutDoc = await cashoutRef.get();

  if (!cashoutDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Cashout not found");
  }

  const cashout = cashoutDoc.data()!;

  // Validate ownership
  if (cashout.userId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized to cancel this cashout");
  }

  // Only pending cashouts can be cancelled
  if (cashout.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Can only cancel pending cashouts"
    );
  }

  const tokenAmount = cashout.tokenAmount || cashout.amount;
  const subAccountId = cashout.subAccountId === "main" ? undefined : cashout.subAccountId;

  // Use the ledger failCashout function to reverse the transaction
  const ledgerResult = await failCashout(
    userId,
    cashoutId,
    tokenAmount,
    "User cancelled cashout",
    subAccountId,
  );

  if (!ledgerResult.success) {
    throw new functions.https.HttpsError(
      "internal",
      `Failed to reverse cashout: ${ledgerResult.error}`
    );
  }

  // Update cashout document
  await cashoutRef.update({
    status: "cancelled",
    cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    refundLedgerJournalId: ledgerResult.journalId,
  });

  return {
    success: true,
    cashoutId,
    refundLedgerJournalId: ledgerResult.journalId,
  };
});
