/**
 * Referral-related Cloud Functions
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processReferralRewards,
  LedgerConfig,
  getOrCreateDefaultSubAccount,
} from "./ledger";
import { createEngagementStats } from "./engagementStats";

const db = admin.firestore();

// Referral reward amounts (now from ledger config for consistency)
const REFERRER_REWARD = LedgerConfig.REFERRER_REWARD; // Tokens for the referrer
const REFEREE_REWARD = LedgerConfig.REFEREE_REWARD; // Tokens for the new user

/**
 * Process referral code application
 */
export const applyReferralCode = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "applyReferralCode");
  await requirePlayIntegrity(data, context, "applyReferralCode", "HIGH");

  const refereeUserId = context.auth.uid;
  const { code } = data;

  if (!code) {
    throw new functions.https.HttpsError("invalid-argument", "Referral code is required");
  }

  // Check if user has already applied a referral code (use Flutter-compatible field name)
  const existingReferral = await db.collection("referrals")
    .where("refereeUserId", "==", refereeUserId)
    .limit(1)
    .get();

  if (!existingReferral.empty) {
    throw new functions.https.HttpsError("already-exists", "You have already used a referral code");
  }

  // Find the referrer by code
  const referrerQuery = await db.collection("referralCodes")
    .where("code", "==", code.toUpperCase())
    .limit(1)
    .get();

  if (referrerQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Invalid referral code");
  }

  const referrerDoc = referrerQuery.docs[0];
  const referrerUserId = referrerDoc.data().userId;

  // Can't refer yourself
  if (referrerUserId === refereeUserId) {
    throw new functions.https.HttpsError("invalid-argument", "You cannot use your own referral code");
  }

  // Get referee profile info for display in referral list
  const refereeUserDoc = await db.collection("users").doc(refereeUserId).get();
  const refereeData = refereeUserDoc.data() || {};
  const refereeDisplayName = refereeData.displayName || null;
  const refereeUsername = refereeData.username || null;
  const refereeAvatarUrl = refereeData.avatarUrl || null;

  const now = admin.firestore.FieldValue.serverTimestamp();

  // Get or create default sub-accounts for both users
  const { subAccountId: referrerSubAccountId } = await getOrCreateDefaultSubAccount(referrerUserId);
  const { subAccountId: refereeSubAccountId } = await getOrCreateDefaultSubAccount(refereeUserId);

  // Create referral record first
  const referralRef = db.collection("referrals").doc();
  await referralRef.set({
    id: referralRef.id,
    referrerUserId: referrerUserId,
    refereeUserId: refereeUserId,
    refereeDisplayName: refereeDisplayName,
    refereeUsername: refereeUsername,
    refereeAvatarUrl: refereeAvatarUrl,
    referralCode: code.toUpperCase(),
    status: "processing",
    referrerReward: REFERRER_REWARD,
    refereeReward: REFEREE_REWARD,
    referrerSubAccountId: referrerSubAccountId,
    refereeSubAccountId: refereeSubAccountId,
    createdAt: now,
    registeredAt: now,
    qualifiedAt: now,
    expiresAt: null,
  });

  // Process referral rewards through the Trust Ledger system
  // This transfers tokens from system:referrals account to both users' sub-accounts
  const ledgerResult = await processReferralRewards(
    referrerUserId,
    refereeUserId,
    referralRef.id,
    referrerSubAccountId,
    refereeSubAccountId,
    {
      referralCode: code.toUpperCase(),
      refereeDisplayName,
    }
  );

  if (!ledgerResult.success) {
    // Update referral as failed
    await referralRef.update({
      status: "failed",
      failureReason: ledgerResult.error,
    });
    throw new functions.https.HttpsError(
      "internal",
      `Failed to process referral rewards: ${ledgerResult.error}`
    );
  }

  // Update referral and related records in transaction
  await db.runTransaction(async (transaction) => {
    // Update referral record as rewarded with ledger reference
    transaction.update(referralRef, {
      status: "rewarded",
      rewardedAt: now,
      ledgerJournalId: ledgerResult.journalId,
    });

    // Update referee's user record with referredBy
    transaction.update(db.collection("users").doc(refereeUserId), {
      referredBy: referrerUserId,
      updatedAt: now,
    });

    // Update referrer's stats
    const statsRef = db.collection("referralStats").doc(referrerUserId);
    transaction.set(statsRef, {
      userId: referrerUserId,
      totalReferrals: admin.firestore.FieldValue.increment(1),
      completedReferrals: admin.firestore.FieldValue.increment(1),
      totalEarned: admin.firestore.FieldValue.increment(REFERRER_REWARD),
      updatedAt: now,
    }, { merge: true });
  });

  return {
    success: true,
    referrerReward: REFERRER_REWARD,
    refereeReward: REFEREE_REWARD,
    ledgerJournalId: ledgerResult.journalId,
  };
});

/**
 * Generate referral code for new user
 * Triggered when a new user is created
 *
 * Also creates:
 * - Ledger account with default sub-account
 * - Engagement stats document
 */
export const generateReferralCode = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snap, context) => {
    const userId = context.params.userId;

    // Generate unique code
    let code = generateCode();
    let isUnique = false;
    let attempts = 0;

    while (!isUnique && attempts < 10) {
      const existing = await db.collection("referralCodes")
        .where("code", "==", code)
        .limit(1)
        .get();

      if (existing.empty) {
        isUnique = true;
      } else {
        code = generateCode();
        attempts++;
      }
    }

    // Create referral code document
    await db.collection("referralCodes").doc(userId).set({
      userId: userId,
      code: code,
      uses: 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Initialize referral stats
    await db.collection("referralStats").doc(userId).set({
      userId: userId,
      code: code,
      totalReferrals: 0,
      completedReferrals: 0,
      pendingReferrals: 0,
      totalEarned: 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create ledger account with default sub-account
    try {
      const { subAccountId } = await getOrCreateDefaultSubAccount(userId);
      console.log(`Created ledger account with sub-account ${subAccountId} for user ${userId}`);
    } catch (error) {
      console.error(`Failed to create ledger account for user ${userId}:`, error);
    }

    // Create engagement stats document
    try {
      await createEngagementStats(userId);
      console.log(`Created engagement stats for user ${userId}`);
    } catch (error) {
      console.error(`Failed to create engagement stats for user ${userId}:`, error);
    }

    // Sync referral code to users collection for Flutter to read
    await db.collection("users").doc(userId).update({
      referralCode: code,
    });

    console.log(`Generated referral code ${code} for user ${userId}`);
    return null;
  });

/**
 * Generate a random referral code
 */
function generateCode(): string {
  const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"; // Excluding similar chars
  let code = "";
  for (let i = 0; i < 6; i++) {
    code += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return code;
}
