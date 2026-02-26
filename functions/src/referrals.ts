/**
 * Referral-related Cloud Functions
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processReferralRewards,
  LedgerConfig,
  getOrCreateUserAccount,
} from "./ledger";
import { createEngagementStats } from "./engagementStats";
import { autoCreateContacts } from "./contacts";

const db = admin.firestore();

// Referral reward amounts (now from ledger config for consistency)
const REFERRER_REWARD = LedgerConfig.REFERRER_REWARD; // Tokens for the referrer
const REFEREE_REWARD = LedgerConfig.REFEREE_REWARD; // Tokens for the new user

/**
 * Process referral code application
 */
export const applyReferralCode = onCall({ labels: { area: "lifecycle" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(request, "applyReferralCode");
  await requirePlayIntegrity(request.data, request, "applyReferralCode", "HIGH");

  const refereeUserId = request.auth.uid;
  const { code } = request.data;

  if (!code) {
    throw new HttpsError("invalid-argument", "Referral code is required");
  }

  // Check if user has already applied a referral code (use Flutter-compatible field name)
  const existingReferral = await db.collection("referrals")
    .where("refereeUserId", "==", refereeUserId)
    .limit(1)
    .get();

  if (!existingReferral.empty) {
    throw new HttpsError("already-exists", "You have already used a referral code");
  }

  // Find the referrer by code
  const referrerQuery = await db.collection("referralCodes")
    .where("code", "==", code.toUpperCase())
    .limit(1)
    .get();

  if (referrerQuery.empty) {
    throw new HttpsError("not-found", "Invalid referral code");
  }

  const referrerDoc = referrerQuery.docs[0];
  const referrerUserId = referrerDoc.data().userId;

  // Can't refer yourself
  if (referrerUserId === refereeUserId) {
    throw new HttpsError("invalid-argument", "You cannot use your own referral code");
  }

  // Get referee profile info for display in referral list
  const refereeUserDoc = await db.collection("users").doc(refereeUserId).get();
  const refereeData = refereeUserDoc.data() || {};
  const refereeDisplayName = refereeData.displayName || null;
  const refereeUsername = refereeData.username || null;
  const refereeAvatarUrl = refereeData.avatarUrl || null;

  const now = admin.firestore.FieldValue.serverTimestamp();

  // Referral rewards go to main wallet (no sub-account needed)

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
    referrerSubAccountId: null,
    refereeSubAccountId: null,
    createdAt: now,
    registeredAt: now,
    qualifiedAt: now,
    expiresAt: null,
  });

  // Process referral rewards through the Trust Ledger system
  // Tokens go to both users' main wallets (ledger account balances)
  const ledgerResult = await processReferralRewards(
    referrerUserId,
    refereeUserId,
    referralRef.id,
    undefined, // Referrer main wallet
    undefined, // Referee main wallet
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
    throw new HttpsError(
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
export const generateReferralCode = onDocumentCreated({ document: "users/{userId}", labels: { area: "lifecycle" } }, async (event) => {
  const userId = event.params.userId;

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

    // Eagerly create the user's main ledger account (= their main wallet).
    // No default sub-account — the ledger account IS the main wallet.
    try {
      await getOrCreateUserAccount(userId);
      logger.info(`Created ledger account for user ${userId}`);
    } catch (error) {
      logger.error(`Failed to create ledger account for user ${userId}:`, error);
    }

    // Create engagement stats document
    try {
      await createEngagementStats(userId);
      logger.info(`Created engagement stats for user ${userId}`);
    } catch (error) {
      logger.error(`Failed to create engagement stats for user ${userId}:`, error);
    }

    // Sync referral code to users collection for Flutter to read
    await db.collection("users").doc(userId).update({
      referralCode: code,
    });

    logger.info(`Generated referral code ${code} for user ${userId}`);

    // ---------------------------------------------------------------
    // Phase 4: Check pendingInvites for this user's phone number
    // If someone invited this phone number, auto-create mutual contacts
    // and notify the inviter.
    // ---------------------------------------------------------------
    try {
      const userData = event.data?.data();
      const newUserPhone = userData?.phoneNumber;

      if (newUserPhone && typeof newUserPhone === "string") {
        // Query pending invites for this phone number (first inviter wins)
        const pendingSnap = await db
          .collection("pendingInvites")
          .where("invitedPhoneNumber", "==", newUserPhone)
          .where("status", "==", "pending")
          .orderBy("createdAt", "asc")
          .limit(1)
          .get();

        if (!pendingSnap.empty) {
          const inviteDoc = pendingSnap.docs[0];
          const inviteData = inviteDoc.data();
          const inviterUserId = inviteData.inviterUserId as string;

          // Mark invite as claimed
          await inviteDoc.ref.update({
            status: "claimed",
            claimedAt: admin.firestore.FieldValue.serverTimestamp(),
            claimedByUserId: userId,
          });

          // Auto-create mutual contacts
          const created = await autoCreateContacts(inviterUserId, userId, "phone_invite");
          if (created) {
            logger.info(`Auto-created contacts: inviter ${inviterUserId} ↔ new user ${userId}`);
          }

          // Store referredBy on the new user's doc
          await db.collection("users").doc(userId).update({
            referredBy: inviterUserId,
          });

          // Notify the inviter
          try {
            const inviterDoc = await db.collection("users").doc(inviterUserId).get();
            const inviterFcm = inviterDoc.data()?.fcmToken;
            const newUserName = userData?.displayName || "Someone";

            if (inviterFcm) {
              await admin.messaging().send({
                token: inviterFcm,
                notification: {
                  title: "Your invite worked!",
                  body: `${newUserName} just joined iMaliChat.`,
                },
                data: {
                  type: "invite_joined",
                  contactUserId: userId,
                },
              });
            }
          } catch (fcmErr) {
            logger.warn("FCM notification failed for invite_joined:", fcmErr);
          }

          logger.info(`Claimed pending invite ${inviteDoc.id} for phone ${newUserPhone}`);
        }
      }
    } catch (inviteErr) {
      // Non-critical — don't let invite processing break user creation
      logger.error("Error processing pending invites:", inviteErr);
    }

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
