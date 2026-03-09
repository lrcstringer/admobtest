/**
 * iMali Firebase Cloud Functions
 *
 * This file exports all Cloud Functions for the iMali app.
 * Functions handle: wallet operations, pot draws, referrals, purchases, etc.
 */

import * as admin from "firebase-admin";
import { setGlobalOptions, logger } from "firebase-functions/v2";

// Initialize Firebase Admin
admin.initializeApp();

// Gen2 global defaults — applied to every function unless overridden
setGlobalOptions({
  region: "africa-south1",
  maxInstances: 10,
  labels: { app: "imalichat" },
});

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
export * from "./rewardTriggers";
export * from "./earnNotifications";
export * from "./adminAuth";
export * from "./groups";
export * from "./groupTriggers";
export * from "./conversations";
export * from "./conversationTokens";
export * from "./contacts";
export * from "./brands";
export * from "./communities";
export * from "./messagingNotifications";
export * from "./gifts";
export * from "./tokenSprays";
export * from "./giftNotifications";
export * from "./tokenPools";
export * from "./tokenPoolNotifications";
export * from "./moderation";
export * from "./keyManagement";
export * from "./calls";
export * from "./buyAdmin";
export * from "./marketplace";
export * from "./buyNotifications";
export * from "./groupBuys";
export * from "./migrations/earnOverhaulMigration";
export { runAdMobSystemMigration, runUpdateAdMobQuestion, adminRunPlatformSetup } from "./migrations/admobSystemThreadMigration";

// Ledger initialization and reconciliation
import { onCall } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { cleanupRateLimits, requireAppCheck } from "./security";
import { requireAdminPermission, cleanupExpiredPendingActions } from "./adminAuth";
import { initializeLedger, reconcileAllAccounts, verifySystemBalance } from "./ledger";

/**
 * Initialize the Trust Ledger system
 * Call this once during initial deployment to create all system accounts
 * (cbook:bus, cbook:trust, pot:daily, pot:weekly, system:cashout_pending, client:imalichat).
 */
export const initializeTrustLedger = onCall({ concurrency: 1, labels: { area: "ledger" } }, async (request) => {
  requireAppCheck(request, "initializeTrustLedger");
  await requireAdminPermission(request, "accounts:initializeLedger", "initializeTrustLedger");

  await initializeLedger();
  return { success: true, message: "Trust Ledger initialized — system accounts created" };
});

/**
 * Run ledger reconciliation - daily scheduled job
 * Verifies all account balances match their journal entries
 */
export const runLedgerReconciliation = onSchedule(
  { schedule: "0 4 * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", timeoutSeconds: 300, memory: "512MiB", cpu: 1, labels: { area: "ledger" } },
  async () => {
    logger.info("Starting daily ledger reconciliation...");

    // Reconcile all accounts
    const reconciliationResults = await reconcileAllAccounts();
    const failedAccounts = reconciliationResults.results.filter((r) => !r.isReconciled);

    if (failedAccounts.length > 0) {
      logger.error(`Reconciliation failed for ${failedAccounts.length} accounts:`, failedAccounts);
    }

    // Verify system balance (asset/liability invariant: cbook = all others)
    const systemBalance = await verifySystemBalance();
    if (!systemBalance.isValid) {
      logger.error("CRITICAL: System balance verification failed!", systemBalance);
    }

    logger.info(`Ledger reconciliation complete. ${reconciliationResults.total} accounts checked, ${reconciliationResults.failed} failures.`);
  }
);

// Sub-account token expiry — runs daily at 2 AM SAST
export const expireSubAccountTokens = onSchedule(
  {
    schedule: "0 2 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 300,
    memory: "512MiB",
    labels: { area: "subaccounts" },
  },
  async () => {
    const { processSubAccountExpiry } = await import("./ledger");
    const result = await processSubAccountExpiry();
    logger.info(`Sub-account token expiry: ${result.expired} expired, ${result.failed} failures`);
  }
);

// Security cleanup function
export const cleanupSecurityData = onSchedule(
  { schedule: "0 3 * * *", timeZone: "Africa/Johannesburg", region: "europe-west1", labels: { area: "auth" } },
  async () => {
    await cleanupRateLimits();
    await cleanupExpiredPendingActions();
  }
);
