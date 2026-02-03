/**
 * Firestore Triggers
 * React to document changes in the database
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Create wallet when new user is created
 */
export const onUserCreated = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snap, context) => {
    const userId = context.params.userId;
    const userData = snap.data();

    // Create wallet for new user
    const walletRef = db.collection("wallets").doc();
    await walletRef.set({
      id: walletRef.id,
      userId: userId,
      type: "main",
      name: "Main Wallet",
      tokenBalance: 0,
      pendingBalance: 0,
      lifetimeEarned: 0,
      lifetimeWithdrawn: 0,
      todayEarned: 0,
      pendingWithdrawal: 0,
      lastEarnedAt: null,
      canWithdraw: true,
      version: 1,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`Created wallet ${walletRef.id} for user ${userId}`);

    // Initialize leaderboard entry in new structure (leaderboards/{type}/scores)
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const weekStart = new Date(today);
    weekStart.setDate(weekStart.getDate() - weekStart.getDay() + 1); // Monday
    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekEnd.getDate() + 7);

    const displayName = userData.displayName ||
      userData.profile?.displayName || "User";
    const username = userData.profile?.username || null;
    const avatarUrl = userData.profile?.avatarUrl || null;

    const baseScoreData = {
      userId: userId,
      displayName: displayName,
      username: username,
      avatarUrl: avatarUrl,
      avatarColor: null,
      totalTokensEarned: 0,
      rank: 0,
      engagementsCompleted: 0,
      currentStreak: 0,
      longestStreak: 0,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    // Create entries in all three leaderboards
    const batch = db.batch();

    // Daily leaderboard
    batch.set(
      db.collection("leaderboards").doc("daily").collection("scores").doc(userId),
      {
        ...baseScoreData,
        periodStart: admin.firestore.Timestamp.fromDate(today),
        periodEnd: admin.firestore.Timestamp.fromDate(tomorrow),
      }
    );

    // Weekly leaderboard
    batch.set(
      db.collection("leaderboards").doc("weekly").collection("scores").doc(userId),
      {
        ...baseScoreData,
        periodStart: admin.firestore.Timestamp.fromDate(weekStart),
        periodEnd: admin.firestore.Timestamp.fromDate(weekEnd),
      }
    );

    // All-time leaderboard
    batch.set(
      db.collection("leaderboards").doc("allTime").collection("scores").doc(userId),
      {
        ...baseScoreData,
        periodStart: admin.firestore.Timestamp.fromDate(new Date(0)),
        periodEnd: admin.firestore.Timestamp.fromDate(now),
      }
    );

    await batch.commit();

    return null;
  });

/**
 * Update leaderboard when wallet balance changes
 */
export const onWalletUpdated = functions.firestore
  .document("wallets/{walletId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    // Only update if lifetime earned changed
    if (before.lifetimeEarned === after.lifetimeEarned) {
      return null;
    }

    const userId = after.userId;
    const now = admin.firestore.FieldValue.serverTimestamp();

    // Update all-time leaderboard score (daily/weekly updated by leaderboard.ts)
    try {
      await db
        .collection("leaderboards")
        .doc("allTime")
        .collection("scores")
        .doc(userId)
        .update({
          totalTokensEarned: after.lifetimeEarned,
          currentStreak: after.currentStreak || 0,
          longestStreak: after.longestStreak || 0,
          updatedAt: now,
        });
    } catch (e) {
      // Document might not exist yet, create it
      console.log(`Creating allTime leaderboard entry for user ${userId}`);
    }

    return null;
  });

/**
 * Update user display name in leaderboard when profile changes
 */
export const onUserUpdated = functions.firestore
  .document("users/{userId}")
  .onUpdate(async (change, context) => {
    const userId = context.params.userId;
    const before = change.before.data();
    const after = change.after.data();

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
        console.log(`Could not update ${type} leaderboard for user ${userId}`);
      }
    }

    return null;
  });

/**
 * Send notification when user wins a pot
 */
export const onPotWinnerCreated = functions.firestore
  .document("potWinners/{winnerId}")
  .onCreate(async (snap, context) => {
    const winnerData = snap.data();
    const userId = winnerData.userId;

    // Get user's FCM token
    const userDoc = await db.collection("users").doc(userId).get();
    const fcmToken = userDoc.data()?.fcmToken;

    if (!fcmToken) {
      console.log(`No FCM token for user ${userId}`);
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

      console.log(`Sent pot win notification to user ${userId}`);
    } catch (error) {
      console.error(`Failed to send notification to user ${userId}:`, error);
    }

    return null;
  });

/**
 * Send notification for referral bonus
 */
export const onReferralCompleted = functions.firestore
  .document("referrals/{referralId}")
  .onCreate(async (snap, context) => {
    const referralData = snap.data();
    // Use Flutter-compatible field name
    const referrerUserId = referralData.referrerUserId;

    if (!referrerUserId) {
      console.log("No referrerUserId in referral document");
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
          referralId: context.params.referralId,
          amount: String(referralData.referrerReward),
        },
      });

      console.log(`Sent referral notification to user ${referrerUserId}`);
    } catch (error) {
      console.error(`Failed to send notification to user ${referrerUserId}:`, error);
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
export const onUserDeleted = functions.firestore
  .document("users/{userId}")
  .onDelete(async (snap, context) => {
    const userId = context.params.userId;

    // Collections to clean up (by userId field)
    const collectionsToClean = [
      "wallets",
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

    await batch.commit();
    console.log(`Cleaned up data for deleted user ${userId}`);

    return null;
  });

/**
 * Update chat thread when new message is sent
 */
export const onMessageCreated = functions.firestore
  .document("chatMessages/{messageId}")
  .onCreate(async (snap, context) => {
    const messageData = snap.data();
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
      console.error(`Failed to send chat notification:`, error);
    }

    return null;
  });
