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
      oddienceUserId: userId,
      tokenBalance: 0,
      pendingBalance: 0,
      lifetimeEarned: 0,
      lifetimeCashout: 0,
      todayEarned: 0,
      pendingCashout: 0,
      lastEarnedAt: null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`Created wallet ${walletRef.id} for user ${userId}`);

    // Initialize leaderboard entry
    await db.collection("leaderboard").doc(userId).set({
      oddienceUserId: userId,
      displayName: userData.displayName || "User",
      avatarUrl: userData.profile?.avatarUrl || null,
      totalScore: 0,
      rank: 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

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

    const userId = after.oddienceUserId;

    // Update leaderboard score
    await db.collection("leaderboard").doc(userId).update({
      totalScore: after.lifetimeEarned,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

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

    // Check if display name or avatar changed
    const nameChanged = before.displayName !== after.displayName;
    const avatarChanged = before.profile?.avatarUrl !== after.profile?.avatarUrl;

    if (!nameChanged && !avatarChanged) {
      return null;
    }

    // Update leaderboard entry
    await db.collection("leaderboard").doc(userId).update({
      displayName: after.displayName,
      avatarUrl: after.profile?.avatarUrl || null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return null;
  });

/**
 * Send notification when user wins a pot
 */
export const onPotWinnerCreated = functions.firestore
  .document("potWinners/{winnerId}")
  .onCreate(async (snap, context) => {
    const winnerData = snap.data();
    const userId = winnerData.oddienceUserId;

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
    const referrerId = referralData.referrerId;

    // Get referrer's FCM token
    const userDoc = await db.collection("users").doc(referrerId).get();
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

      console.log(`Sent referral notification to user ${referrerId}`);
    } catch (error) {
      console.error(`Failed to send notification to user ${referrerId}:`, error);
    }

    return null;
  });

/**
 * Clean up user data on account deletion
 */
export const onUserDeleted = functions.firestore
  .document("users/{userId}")
  .onDelete(async (snap, context) => {
    const userId = context.params.userId;

    // Collections to clean up
    const collectionsToClean = [
      "wallets",
      "referralCodes",
      "referralStats",
      "leaderboard",
    ];

    const batch = db.batch();

    for (const collection of collectionsToClean) {
      const docs = await db.collection(collection)
        .where("oddienceUserId", "==", userId)
        .get();

      docs.forEach((doc) => {
        batch.delete(doc.ref);
      });
    }

    // Also delete by document ID if applicable
    batch.delete(db.collection("leaderboard").doc(userId));
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

    // Update thread with last message info
    await db.collection("chatThreads").doc(threadId).update({
      lastMessage: messageData.content,
      lastMessageAt: messageData.createdAt,
      lastMessageSenderId: messageData.senderId,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Send notification to recipient
    const recipientId = messageData.recipientId;

    // Get recipient's FCM token
    const userDoc = await db.collection("users").doc(recipientId).get();
    const fcmToken = userDoc.data()?.fcmToken;

    if (!fcmToken) {
      return null;
    }

    // Get sender's name
    const senderDoc = await db.collection("users").doc(messageData.senderId).get();
    const senderName = senderDoc.data()?.displayName || "Someone";

    try {
      await admin.messaging().send({
        token: fcmToken,
        notification: {
          title: senderName,
          body: messageData.type === "transfer"
            ? `Sent you ${messageData.metadata?.amount} tokens`
            : messageData.content,
        },
        data: {
          type: "chat_message",
          threadId: threadId,
          senderId: messageData.senderId,
        },
      });
    } catch (error) {
      console.error(`Failed to send chat notification:`, error);
    }

    return null;
  });
