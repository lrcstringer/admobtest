/**
 * Firestore Triggers
 * React to document changes in the database
 */

import {
  onDocumentCreated,
  onDocumentUpdated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Initialize user data when new user is created
 *
 * NOTE: Ledger account, sub-account, and engagement stats are now created
 * by the generateReferralCode trigger in referrals.ts to ensure atomicity.
 *
 * This trigger only handles non-financial initialization that doesn't need
 * the full ledger setup.
 */
export const onUserCreated = onDocumentCreated({ document: "users/{userId}", labels: { area: "lifecycle" } }, async (event) => {
  const userId = event.params.userId;
  // const userData = event.data?.data();

  // Ledger account (main wallet, no default sub-account) is created by generateReferralCode
  // Engagement stats are created by generateReferralCode
  // Referral code is created by generateReferralCode

  logger.info(`User ${userId} created. Ledger setup handled by generateReferralCode trigger.`);

  return null;
});

// NOTE: onWalletUpdated trigger removed
// The wallets collection is deprecated. Balances are now tracked via:
// - ledgerAccounts/{userId}/subAccounts/{subAccountId}
// - Leaderboard scores are now calculated from dailyScores at pot draw time

/**
 * Update user display name in leaderboard when profile changes
 */
export const onUserUpdated = onDocumentUpdated({ document: "users/{userId}", labels: { area: "lifecycle" } }, async (event) => {
  const userId = event.params.userId;
  const before = event.data?.before.data();
  const after = event.data?.after.data();

  if (!before || !after) {
    return null;
  }

  // Check if display name, username, or avatar changed
  const nameChanged = before.displayName !== after.displayName ||
    before.profile?.displayName !== after.profile?.displayName;
  const usernameChanged = before.profile?.username !== after.profile?.username;
  const avatarChanged = before.profile?.avatarUrl !== after.profile?.avatarUrl;
  const avatarColorChanged = before.profile?.avatarColor !== after.profile?.avatarColor;

  if (!nameChanged && !usernameChanged && !avatarChanged && !avatarColorChanged) {
    return null;
  }

  const displayName = after.displayName ||
    after.profile?.displayName || "User";
  const username = after.profile?.username || null;
  const avatarUrl = after.profile?.avatarUrl || null;
  const avatarColor = after.profile?.avatarColor || null;
  const now = admin.firestore.FieldValue.serverTimestamp();

  // Update all leaderboard entries
  const leaderboardTypes = ["daily", "weekly", "allTime"];

  for (const type of leaderboardTypes) {
    try {
      await db
        .collection("leaderboards")
        .doc(type)
        .collection("scores")
        .doc(userId)
        .update({
          displayName: displayName,
          username: username,
          avatarUrl: avatarUrl,
          avatarColor: avatarColor,
          updatedAt: now,
        });
    } catch (e) {
      // Document might not exist, ignore
      logger.info(`Could not update ${type} leaderboard for user ${userId}`);
    }
  }

  return null;
});

/**
 * Send notification when user wins a pot
 */
export const onPotWinnerCreated = onDocumentCreated({ document: "potWinners/{winnerId}", retry: true, labels: { area: "lifecycle" } }, async (event) => {
  const winnerData = event.data?.data();
  if (!winnerData) {
    return null;
  }
  const userId = winnerData.userId;

  // Get user's FCM token
  const userDoc = await db.collection("users").doc(userId).get();
  const fcmToken = userDoc.data()?.fcmToken;

  if (!fcmToken) {
    logger.info(`No FCM token for user ${userId}`);
    return null;
  }

  // Send push notification
  const potType = winnerData.potType === "weekly" ? "weekly" : "daily";
  const prizeAmount = winnerData.prizeAmount;

  try {
    await admin.messaging().send({
      token: fcmToken,
      notification: {
        title: "Congratulations! You Won!",
        body: `You won the ${potType} pot! ${prizeAmount} tokens have been added to your wallet.`,
      },
      data: {
        type: "pot_win",
        potId: winnerData.potId,
        amount: String(prizeAmount),
      },
    });

    logger.info(`Sent pot win notification to user ${userId}`);
  } catch (error) {
    logger.error(`Failed to send notification to user ${userId}:`, error);
  }

  return null;
});

/**
 * Send notification for referral bonus
 */
export const onReferralCompleted = onDocumentCreated({ document: "referrals/{referralId}", retry: true, labels: { area: "lifecycle" } }, async (event) => {
  const referralData = event.data?.data();
  if (!referralData) {
    return null;
  }
  // Use Flutter-compatible field name
  const referrerUserId = referralData.referrerUserId;

  if (!referrerUserId) {
    logger.info("No referrerUserId in referral document");
    return null;
  }

  // Get referrer's FCM token
  const userDoc = await db.collection("users").doc(referrerUserId).get();
  const fcmToken = userDoc.data()?.fcmToken;

  if (!fcmToken) {
    return null;
  }

  try {
    await admin.messaging().send({
      token: fcmToken,
      notification: {
        title: "Referral Bonus!",
        body: `A friend just signed up using your code! You earned ${referralData.referrerReward} tokens.`,
      },
      data: {
        type: "referral_bonus",
        referralId: event.params.referralId,
        amount: String(referralData.referrerReward),
      },
    });

    logger.info(`Sent referral notification to user ${referrerUserId}`);
  } catch (error) {
    logger.error(`Failed to send notification to user ${referrerUserId}:`, error);
  }

  return null;
});

/**
 * Safety-net cleanup on user document deletion.
 *
 * The primary cleanup is handled by the deleteUserAccount callable
 * function (accountDeletion.ts), which deletes all user data across
 * all collections before deleting this document and the Auth account.
 *
 * This trigger catches manual deletions via Firebase Console and
 * provides a fallback for the core financial/referral collections.
 */
export const onUserDeleted = onDocumentDeleted({ document: "users/{userId}", retry: true, labels: { area: "lifecycle" } }, async (event) => {
  const userId = event.params.userId;

    // Collections to clean up (by userId field)
    const collectionsToClean = [
      "referralCodes",
      "referralStats",
      "engagements",
    ];

    const batch = db.batch();

    for (const collection of collectionsToClean) {
      const docs = await db.collection(collection)
        .where("userId", "==", userId)
        .get();

      docs.forEach((doc) => {
        batch.delete(doc.ref);
      });
    }

    // Delete from new leaderboards structure
    const leaderboardTypes = ["daily", "weekly", "allTime"];
    for (const type of leaderboardTypes) {
      batch.delete(
        db.collection("leaderboards").doc(type).collection("scores").doc(userId)
      );
    }

    // Delete legacy leaderboard entry if exists
    batch.delete(db.collection("leaderboard").doc(userId));

    // Delete referral-related docs by ID
    batch.delete(db.collection("referralStats").doc(userId));
    batch.delete(db.collection("referralCodes").doc(userId));

    // Delete userEngagementStats document
    batch.delete(db.collection("userEngagementStats").doc(userId));

    await batch.commit();

    // Delete ledgerAccounts subcollections (must be done separately)
    // Delete subAccounts subcollection first
    const subAccountsSnap = await db
      .collection("ledgerAccounts")
      .doc(userId)
      .collection("subAccounts")
      .get();

    if (!subAccountsSnap.empty) {
      const subAccountBatch = db.batch();
      subAccountsSnap.docs.forEach((doc) => {
        subAccountBatch.delete(doc.ref);
      });
      await subAccountBatch.commit();
    }

    // Delete the ledgerAccount document
    await db.collection("ledgerAccounts").doc(userId).delete();

    // Delete dailyScores subcollection
    const dailyScoresSnap = await db
      .collection("users")
      .doc(userId)
      .collection("dailyScores")
      .get();

    if (!dailyScoresSnap.empty) {
      const dailyScoresBatch = db.batch();
      dailyScoresSnap.docs.forEach((doc) => {
        dailyScoresBatch.delete(doc.ref);
      });
      await dailyScoresBatch.commit();
    }

    logger.info(`Cleaned up data for deleted user ${userId}`);

    return null;
  });

/**
 * Update chat thread when new message is sent
 */
export const onMessageCreated = onDocumentCreated({ document: "chatMessages/{messageId}", labels: { area: "lifecycle" } }, async (event) => {
  const messageData = event.data?.data();
  if (!messageData) {
    return null;
  }
  const threadId = messageData.threadId;

  // Build last message preview based on message type
  let lastMessagePreview: string;
  const messageType = messageData.type;
  const tokenAmount = messageData.tokenAmount;

  if (messageType === "tokenSend") {
    lastMessagePreview = `Sent ${tokenAmount} tokens`;
  } else if (messageType === "tokenRequest") {
    lastMessagePreview = `Requested ${tokenAmount} tokens`;
  } else if (messageType === "tokenReceived") {
    lastMessagePreview = `Received ${tokenAmount} tokens`;
  } else if (messageData.textContent) {
    lastMessagePreview = messageData.textContent;
  } else {
    lastMessagePreview = "New message";
  }

  // Update thread with last message info (using Flutter-compatible field names)
  await db.collection("chatThreads").doc(threadId).update({
    lastMessagePreview: lastMessagePreview,
    lastMessageAt: messageData.createdAt,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Send notification to recipient
  const recipientId = messageData.recipientId;

  if (!recipientId) {
    // No recipient to notify (e.g., system messages)
    return null;
  }

  // Get recipient's FCM token
  const userDoc = await db.collection("users").doc(recipientId).get();
  const fcmToken = userDoc.data()?.fcmToken;

  if (!fcmToken) {
    return null;
  }

  // Get sender's name
  const senderDoc = await db.collection("users").doc(messageData.senderId).get();
  const senderName = senderDoc.data()?.displayName || "Someone";

  // Build notification body based on message type
  let notificationBody: string;
  if (messageType === "tokenSend") {
    notificationBody = `Sent you ${tokenAmount} tokens`;
  } else if (messageType === "tokenRequest") {
    notificationBody = `Requested ${tokenAmount} tokens from you`;
  } else if (messageData.textContent) {
    notificationBody = messageData.textContent;
  } else {
    notificationBody = "Sent you a message";
  }

  try {
    await admin.messaging().send({
      token: fcmToken,
      notification: {
        title: senderName,
        body: notificationBody,
      },
      data: {
        type: "chat_message",
        threadId: threadId,
        senderId: messageData.senderId,
        messageType: messageType || "text",
      },
    });
  } catch (error) {
    logger.error(`Failed to send chat notification:`, error);
  }

  return null;
});
