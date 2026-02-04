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
import {
  initiateCashout,
  completeCashout,
  failCashout,
  LedgerConfig,
  getDefaultSubAccount,
  validateSubAccountAllows,
  validateSubAccountBalance,
} from "./ledger";

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
  // This moves tokens from user's sub-account to cashout:pending
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
 * Complete a pending cashout (called after bank transfer is confirmed)
 */
export const completeCashoutRequest = functions.https.onCall(async (data, context) => {
  // This should be called by an admin or automated system
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "completeCashoutRequest");

  const { cashoutId, adminNotes } = data;

  if (!cashoutId) {
    throw new functions.https.HttpsError("invalid-argument", "Cashout ID is required");
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

  // Complete cashout through ledger (moves from pending to treasury - burns tokens)
  const ledgerResult = await completeCashout(
    cashoutId,
    cashoutData.tokenAmount,
    {
      completedBy: context.auth.uid,
      adminNotes,
    }
  );

  if (!ledgerResult.success) {
    throw new functions.https.HttpsError(
      "internal",
      `Failed to complete cashout: ${ledgerResult.error}`
    );
  }

  // Update cashout record
  await cashoutDoc.ref.update({
    status: "completed",
    completedAt: admin.firestore.FieldValue.serverTimestamp(),
    completedBy: context.auth.uid,
    completionLedgerJournalId: ledgerResult.journalId,
    adminNotes: adminNotes || null,
  });

  return {
    success: true,
    ledgerJournalId: ledgerResult.journalId,
  };
});

/**
 * Fail/refund a cashout (if bank transfer fails)
 */
export const failCashoutRequest = functions.https.onCall(async (data, context) => {
  // This should be called by an admin or automated system
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "failCashoutRequest");

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
      failedBy: context.auth.uid,
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
    failedBy: context.auth.uid,
    refundLedgerJournalId: ledgerResult.journalId,
  });

  return {
    success: true,
    ledgerJournalId: ledgerResult.journalId,
  };
});

// NOTE: resetDailyEarnings removed
// The wallets collection is deprecated. Daily earning caps are now tracked via:
// - userEngagementStats/{userId} document (tokensEarnedToday field)
// - Daily scores in users/{userId}/dailyScores/{date}
