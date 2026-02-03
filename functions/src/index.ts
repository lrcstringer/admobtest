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

// Security cleanup function
import * as functions from "firebase-functions";
import { cleanupRateLimits } from "./security";

export const cleanupSecurityData = functions.pubsub
  .schedule("0 3 * * *") // 3 AM daily
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    await cleanupRateLimits();
    return null;
  });
