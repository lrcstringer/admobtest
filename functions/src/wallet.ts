/**
 * Wallet-related Cloud Functions
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";

const db = admin.firestore();

/**
 * Process token earnings from ads/surveys
 * Called when user completes an earning activity
 */
export const processEarning = functions.https.onCall(async (data, context) => {
  // Verify authentication
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "processEarning");
  await requirePlayIntegrity(data, context, "processEarning", "HIGH");

  const userId = context.auth.uid;
  const { type, amount, source, metadata } = data;

  // Validate input
  if (!type || !amount || amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Invalid earning data");
  }

  // Check daily cap (500 tokens per day)
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const earningsToday = await db.collection("transactions")
    .where("userId", "==", userId)
    .where("type", "==", "earn")
    .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(today))
    .get();

  const totalEarnedToday = earningsToday.docs.reduce((sum, doc) => {
    return sum + (doc.data().tokenAmount || 0);
  }, 0);

  if (totalEarnedToday + amount > 500) {
    throw new functions.https.HttpsError("resource-exhausted", "Daily earning cap reached");
  }

  // Get user's wallet
  const walletQuery = await db.collection("wallets")
    .where("userId", "==", userId)
    .limit(1)
    .get();

  if (walletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Wallet not found");
  }

  const walletDoc = walletQuery.docs[0];
  const walletId = walletDoc.id;

  // Use transaction for atomicity
  await db.runTransaction(async (transaction) => {
    // Read current wallet data inside transaction for accurate balance
    const currentWallet = await transaction.get(walletDoc.ref);
    const currentBalance = currentWallet.data()?.tokenBalance || 0;
    const balanceAfter = currentBalance + amount;

    // Update wallet balance
    transaction.update(walletDoc.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(amount),
      lifetimeEarned: admin.firestore.FieldValue.increment(amount),
      todayEarned: admin.firestore.FieldValue.increment(amount),
      lastEarnedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      version: admin.firestore.FieldValue.increment(1),
    });

    // Create transaction record
    const transactionRef = db.collection("transactions").doc();
    transaction.set(transactionRef, {
      id: transactionRef.id,
      walletId: walletId,
      userId: userId,
      type: "earn",
      subType: type,
      tokenAmount: amount,
      balanceAfter: balanceAfter,
      zarAmount: amount * 0.01,
      description: `Earned from ${source || type}`,
      status: "completed",
      metadata: metadata || {},
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update user's pot entries for today
    const potEntryRef = db.collection("potEntries").doc(`${userId}_${today.toISOString().split("T")[0]}`);
    transaction.set(potEntryRef, {
      userId: userId,
      date: today.toISOString().split("T")[0],
      entries: admin.firestore.FieldValue.increment(amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  });

  return { success: true, amount };
});

/**
 * Process cashout request
 */
export const processCashout = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(context, "processCashout");
  await requirePlayIntegrity(data, context, "processCashout", "HIGHEST");

  const userId = context.auth.uid;
  const { amount, bankDetails } = data;

  // Validate minimum cashout (5000 tokens = R50)
  if (amount < 5000) {
    throw new functions.https.HttpsError("invalid-argument", "Minimum cashout is 5000 tokens (R50)");
  }

  // Get user's wallet
  const walletQuery = await db.collection("wallets")
    .where("userId", "==", userId)
    .limit(1)
    .get();

  if (walletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Wallet not found");
  }

  const walletDoc = walletQuery.docs[0];
  const walletData = walletDoc.data();

  // Check balance
  if (walletData.tokenBalance < amount) {
    throw new functions.https.HttpsError("failed-precondition", "Insufficient balance");
  }

  const zarAmount = amount * 0.01;

  // Create cashout request
  await db.runTransaction(async (transaction) => {
    // Read current wallet data inside transaction for accurate balance
    const currentWallet = await transaction.get(walletDoc.ref);
    const currentBalance = currentWallet.data()?.tokenBalance || 0;
    const balanceAfter = currentBalance - amount;

    // Deduct from wallet
    transaction.update(walletDoc.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(-amount),
      pendingWithdrawal: admin.firestore.FieldValue.increment(amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      version: admin.firestore.FieldValue.increment(1),
    });

    // Create cashout record
    const cashoutRef = db.collection("cashouts").doc();
    transaction.set(cashoutRef, {
      id: cashoutRef.id,
      walletId: walletDoc.id,
      userId: userId,
      tokenAmount: amount,
      zarAmount: zarAmount,
      status: "pending",
      bankDetails: bankDetails,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create transaction record
    const transactionRef = db.collection("transactions").doc();
    transaction.set(transactionRef, {
      id: transactionRef.id,
      walletId: walletDoc.id,
      userId: userId,
      type: "cashout",
      tokenAmount: -amount,
      balanceAfter: balanceAfter,
      zarAmount: -zarAmount,
      description: "Cashout request",
      status: "pending",
      referenceId: cashoutRef.id,
      referenceType: "cashout",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  return { success: true, zarAmount };
});

/**
 * Reset daily earnings at midnight
 */
export const resetDailyEarnings = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const batch = db.batch();
    const walletsSnapshot = await db.collection("wallets").get();

    walletsSnapshot.docs.forEach((doc) => {
      batch.update(doc.ref, {
        todayEarned: 0,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    await batch.commit();
    console.log(`Reset daily earnings for ${walletsSnapshot.size} wallets`);
    return null;
  });
