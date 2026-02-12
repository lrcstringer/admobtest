/**
 * iMali Firebase Cloud Functions
 *
 * This file exports all Cloud Functions for the iMali app.
 * Functions handle: wallet operations, pot draws, referrals, purchases, etc.
 */

import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Allow undefined values in Firestore documents — they are stripped automatically.
// Without this, any optional field (e.g. ipAddress, userAgent) that is undefined
// causes "Cannot use undefined as a Firestore value" errors.
admin.firestore().settings({ ignoreUndefinedProperties: true });

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
export * from "./poll";
export * from "./pollAdmin";
export * from "./uploadReview";
export * from "./adminAccounts";
export * from "./rewardCampaigns";
export * from "./rewardItems";
export * from "./rewardAllocation";
export * from "./rewardScheduled";
export * from "./rewardWebhook";
export * from "./rewardSponsorReport";
export * from "./earnNotifications";
export * from "./adminAuth";
export * from "./groups";
export * from "./groupTriggers";
export * from "./migrations/earnOverhaulMigration";
export { runAdMobSystemMigration, runUpdateAdMobQuestion, adminRunPlatformSetup } from "./migrations/admobSystemThreadMigration";

// Ledger initialization and reconciliation
import * as functions from "firebase-functions";
import { cleanupRateLimits, requireAppCheck } from "./security";
import { requireAdminPermission, cleanupExpiredPendingActions } from "./adminAuth";
import { initializeLedger, reconcileAllAccounts, verifySystemBalance } from "./ledger";

/**
 * Initialize the Trust Ledger system
 * Call this once during initial deployment to create all system accounts
 * (cbook:bus, cbook:trust, pot:daily, pot:weekly, system:cashout_pending, client:imalichat).
 */
export const initializeTrustLedger = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "initializeTrustLedger");
  await requireAdminPermission(context, "accounts:initializeLedger", "initializeTrustLedger");

  await initializeLedger();
  return { success: true, message: "Trust Ledger initialized — system accounts created" };
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

    // Verify system balance (asset/liability invariant: cbook = all others)
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
    await cleanupExpiredPendingActions();
    return null;
  });
