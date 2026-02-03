/**
 * Referral-related Cloud Functions
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";

const db = admin.firestore();

// Referral reward amounts
const REFERRER_REWARD = 100; // Tokens for the referrer
const REFEREE_REWARD = 50; // Tokens for the new user

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

  // Process referral rewards
  await db.runTransaction(async (transaction) => {
    // Create referral record with Flutter-compatible field names
    const referralRef = db.collection("referrals").doc();
    transaction.set(referralRef, {
      id: referralRef.id,
      referrerUserId: referrerUserId,
      refereeUserId: refereeUserId,
      refereeDisplayName: refereeDisplayName,
      refereeUsername: refereeUsername,
      refereeAvatarUrl: refereeAvatarUrl,
      referralCode: code.toUpperCase(),
      status: "rewarded", // Flutter enum value
      referrerReward: REFERRER_REWARD,
      refereeReward: REFEREE_REWARD,
      createdAt: now,
      registeredAt: now,
      qualifiedAt: now,
      rewardedAt: now,
      expiresAt: null,
    });

    // Get referrer's wallet and add reward
    const referrerWalletQuery = await db.collection("wallets")
      .where("userId", "==", referrerUserId)
      .limit(1)
      .get();

    if (!referrerWalletQuery.empty) {
      const referrerWallet = referrerWalletQuery.docs[0];
      const referrerWalletData = referrerWallet.data();
      const referrerNewBalance = (referrerWalletData.tokenBalance || 0) + REFERRER_REWARD;

      transaction.update(referrerWallet.ref, {
        tokenBalance: admin.firestore.FieldValue.increment(REFERRER_REWARD),
        lifetimeEarned: admin.firestore.FieldValue.increment(REFERRER_REWARD),
        version: admin.firestore.FieldValue.increment(1),
        updatedAt: now,
      });

      // Create transaction for referrer with balanceAfter
      const referrerTxRef = db.collection("transactions").doc();
      transaction.set(referrerTxRef, {
        id: referrerTxRef.id,
        walletId: referrerWallet.id,
        userId: referrerUserId,
        type: "referral_bonus",
        tokenAmount: REFERRER_REWARD,
        zarAmount: REFERRER_REWARD * 0.01,
        balanceAfter: referrerNewBalance,
        description: "Referral bonus - friend signed up!",
        status: "completed",
        referenceId: referralRef.id,
        referenceType: "referral",
        createdAt: now,
      });
    }

    // Get referee's wallet and add reward
    const refereeWalletQuery = await db.collection("wallets")
      .where("userId", "==", refereeUserId)
      .limit(1)
      .get();

    if (!refereeWalletQuery.empty) {
      const refereeWallet = refereeWalletQuery.docs[0];
      const refereeWalletData = refereeWallet.data();
      const refereeNewBalance = (refereeWalletData.tokenBalance || 0) + REFEREE_REWARD;

      transaction.update(refereeWallet.ref, {
        tokenBalance: admin.firestore.FieldValue.increment(REFEREE_REWARD),
        lifetimeEarned: admin.firestore.FieldValue.increment(REFEREE_REWARD),
        version: admin.firestore.FieldValue.increment(1),
        updatedAt: now,
      });

      // Create transaction for referee with balanceAfter
      const refereeTxRef = db.collection("transactions").doc();
      transaction.set(refereeTxRef, {
        id: refereeTxRef.id,
        walletId: refereeWallet.id,
        userId: refereeUserId,
        type: "referral_bonus",
        tokenAmount: REFEREE_REWARD,
        zarAmount: REFEREE_REWARD * 0.01,
        balanceAfter: refereeNewBalance,
        description: "Welcome bonus - used referral code!",
        status: "completed",
        referenceId: referralRef.id,
        referenceType: "referral",
        createdAt: now,
      });
    }

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
  };
});

/**
 * Generate referral code for new user
 * Triggered when a new user is created
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
