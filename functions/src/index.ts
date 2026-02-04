/**
 * iMali Firebase Cloud Functions
 *
 * This file exports all Cloud Functions for the iMali app.
 * Functions handle: wallet operations, pot draws, referrals, purchases, etc.
 */

import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Export all functions
export * from "./wallet";
export * from "./pots";
export * from "./referrals";
export * from "./purchases";
export * from "./scheduled";
export * from "./triggers";
export * from "./chat";
export * from "./engagement";
export * from "./fraud";
export * from "./auth";
export * from "./biometricAuth";
export * from "./accountDeletion";
export * from "./dataExport";
export * from "./kyc";
export * from "./earnAdmin";
export * from "./adminAccounts";
export * from "./groups";
export * from "./groupTriggers";

// Ledger initialization and reconciliation
import * as functions from "firebase-functions";
import { cleanupRateLimits } from "./security";
import { initializeLedger, reconcileAllAccounts, verifySystemBalance } from "./ledger";

/**
 * Initialize the Trust Ledger system
 * Call this once during initial deployment
 */
export const initializeTrustLedger = functions.https.onCall(async (data, context) => {
  // Only allow admin users
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Must be authenticated");
  }

  // TODO: Add admin role check

  await initializeLedger();
  return { success: true, message: "Trust Ledger initialized" };
});

/**
 * Run ledger reconciliation - daily scheduled job
 * Verifies all account balances match their journal entries
 */
export const runLedgerReconciliation = functions.pubsub
  .schedule("0 4 * * *") // 4 AM daily SAST
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    console.log("Starting daily ledger reconciliation...");

    // Reconcile all accounts
    const reconciliationResults = await reconcileAllAccounts();
    const failedAccounts = reconciliationResults.results.filter((r) => !r.isReconciled);

    if (failedAccounts.length > 0) {
      console.error(`Reconciliation failed for ${failedAccounts.length} accounts:`, failedAccounts);
    }

    // Verify system balance (total user tokens = treasury outflow + pot balances)
    const systemBalance = await verifySystemBalance();
    if (!systemBalance.isValid) {
      console.error("CRITICAL: System balance verification failed!", systemBalance);
    }

    console.log(`Ledger reconciliation complete. ${reconciliationResults.total} accounts checked, ${reconciliationResults.failed} failures.`);
    return null;
  });

// Security cleanup function
export const cleanupSecurityData = functions.pubsub
  .schedule("0 3 * * *") // 3 AM daily
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    await cleanupRateLimits();
    return null;
  });
