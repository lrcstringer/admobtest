/**
 * Chat P2P Cloud Functions
 * Handle in-chat token transfers and payment requests
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";

const db = admin.firestore();

/**
 * Send tokens to another user via chat
 */
export const sendTokens = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  requireAppCheck(context, "sendTokens");
  await requirePlayIntegrity(data, context, "sendTokens", "HIGHEST");

  const senderId = context.auth.uid;
  const {recipientId, amount, message, threadId} = data;

  // Validate input
  if (!recipientId || !amount || amount <= 0) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid transfer data"
    );
  }

  // Prevent self-transfer
  if (senderId === recipientId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Cannot send tokens to yourself"
    );
  }

  // Get sender's wallet
  const senderWalletQuery = await db
    .collection("wallets")
    .where("oddienceUserId", "==", senderId)
    .limit(1)
    .get();

  if (senderWalletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Sender wallet not found");
  }

  const senderWallet = senderWalletQuery.docs[0];
  const senderBalance = senderWallet.data().tokenBalance || 0;

  // Check balance
  if (senderBalance < amount) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Insufficient balance"
    );
  }

  // Get recipient's wallet
  const recipientWalletQuery = await db
    .collection("wallets")
    .where("oddienceUserId", "==", recipientId)
    .limit(1)
    .get();

  if (recipientWalletQuery.empty) {
    throw new functions.https.HttpsError(
      "not-found",
      "Recipient wallet not found"
    );
  }

  const recipientWallet = recipientWalletQuery.docs[0];

  // Process transfer in transaction
  await db.runTransaction(async (transaction) => {
    // Deduct from sender
    transaction.update(senderWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(-amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Add to recipient
    transaction.update(recipientWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create sender transaction record
    const senderTxRef = db.collection("transactions").doc();
    transaction.set(senderTxRef, {
      id: senderTxRef.id,
      walletId: senderWallet.id,
      oddienceUserId: senderId,
      type: "transfer",
      subType: "sent",
      tokenAmount: -amount,
      zarAmount: -amount * 0.01,
      description: "Sent to user",
      status: "completed",
      referenceId: recipientId,
      referenceType: "user",
      metadata: {threadId, message},
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create recipient transaction record
    const recipientTxRef = db.collection("transactions").doc();
    transaction.set(recipientTxRef, {
      id: recipientTxRef.id,
      walletId: recipientWallet.id,
      oddienceUserId: recipientId,
      type: "transfer",
      subType: "received",
      tokenAmount: amount,
      zarAmount: amount * 0.01,
      description: "Received from user",
      status: "completed",
      referenceId: senderId,
      referenceType: "user",
      metadata: {threadId, message},
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create chat message for transfer
    if (threadId) {
      const messageRef = db.collection("chatMessages").doc();
      transaction.set(messageRef, {
        id: messageRef.id,
        threadId: threadId,
        senderId: senderId,
        recipientId: recipientId,
        content: message || `Sent ${amount} tokens`,
        type: "transfer",
        status: "sent",
        metadata: {
          amount: amount,
          transferType: "sent",
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
  });

  return {success: true, amount};
});

/**
 * Create a payment request in chat
 */
export const createPaymentRequest = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(context, "createPaymentRequest");

    const requesterId = context.auth.uid;
    const {recipientId, amount, message, threadId} = data;

    // Validate
    if (!recipientId || !amount || amount <= 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Invalid request data"
      );
    }

    if (requesterId === recipientId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Cannot request from yourself"
      );
    }

    // Create payment request
    const requestRef = db.collection("paymentRequests").doc();
    await requestRef.set({
      id: requestRef.id,
      requesterId: requesterId,
      payerId: recipientId,
      amount: amount,
      message: message || null,
      threadId: threadId || null,
      status: "pending",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      expiresAt: admin.firestore.Timestamp.fromDate(
        new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) // 7 days
      ),
    });

    // Create chat message for request
    if (threadId) {
      const messageRef = db.collection("chatMessages").doc();
      await messageRef.set({
        id: messageRef.id,
        threadId: threadId,
        senderId: requesterId,
        recipientId: recipientId,
        content: message || `Requested ${amount} tokens`,
        type: "request",
        status: "sent",
        metadata: {
          requestId: requestRef.id,
          amount: amount,
          requestStatus: "pending",
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    return {success: true, requestId: requestRef.id};
  }
);

/**
 * Pay a payment request
 */
export const payRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  requireAppCheck(context, "payRequest");

  const payerId = context.auth.uid;
  const {requestId} = data;

  // Get the request
  const requestDoc = await db.collection("paymentRequests").doc(requestId).get();

  if (!requestDoc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "Payment request not found"
    );
  }

  const request = requestDoc.data()!;

  // Validate
  if (request.payerId !== payerId) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Not authorized to pay this request"
    );
  }

  if (request.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Request is no longer pending"
    );
  }

  // Check if expired
  if (request.expiresAt.toDate() < new Date()) {
    await requestDoc.ref.update({status: "expired"});
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Request has expired"
    );
  }

  // Get payer's wallet
  const payerWalletQuery = await db
    .collection("wallets")
    .where("oddienceUserId", "==", payerId)
    .limit(1)
    .get();

  if (payerWalletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Wallet not found");
  }

  const payerWallet = payerWalletQuery.docs[0];
  const balance = payerWallet.data().tokenBalance || 0;

  if (balance < request.amount) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Insufficient balance"
    );
  }

  // Get requester's wallet
  const requesterWalletQuery = await db
    .collection("wallets")
    .where("oddienceUserId", "==", request.requesterId)
    .limit(1)
    .get();

  if (requesterWalletQuery.empty) {
    throw new functions.https.HttpsError(
      "not-found",
      "Requester wallet not found"
    );
  }

  const requesterWallet = requesterWalletQuery.docs[0];

  // Process payment
  await db.runTransaction(async (transaction) => {
    // Update request status
    transaction.update(requestDoc.ref, {
      status: "paid",
      paidAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Transfer tokens
    transaction.update(payerWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(-request.amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    transaction.update(requesterWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(request.amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create transaction records
    const payerTxRef = db.collection("transactions").doc();
    transaction.set(payerTxRef, {
      id: payerTxRef.id,
      walletId: payerWallet.id,
      oddienceUserId: payerId,
      type: "transfer",
      subType: "request_paid",
      tokenAmount: -request.amount,
      zarAmount: -request.amount * 0.01,
      description: "Paid payment request",
      status: "completed",
      referenceId: requestId,
      referenceType: "payment_request",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    const requesterTxRef = db.collection("transactions").doc();
    transaction.set(requesterTxRef, {
      id: requesterTxRef.id,
      walletId: requesterWallet.id,
      oddienceUserId: request.requesterId,
      type: "transfer",
      subType: "request_received",
      tokenAmount: request.amount,
      zarAmount: request.amount * 0.01,
      description: "Received from payment request",
      status: "completed",
      referenceId: requestId,
      referenceType: "payment_request",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  return {success: true, amount: request.amount};
});

/**
 * Decline a payment request
 */
export const declineRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  requireAppCheck(context, "declineRequest");

  const userId = context.auth.uid;
  const {requestId, reason} = data;

  const requestDoc = await db.collection("paymentRequests").doc(requestId).get();

  if (!requestDoc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "Payment request not found"
    );
  }

  const request = requestDoc.data()!;

  if (request.payerId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized");
  }

  if (request.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Request is no longer pending"
    );
  }

  await requestDoc.ref.update({
    status: "declined",
    declinedAt: admin.firestore.FieldValue.serverTimestamp(),
    declineReason: reason || null,
  });

  return {success: true};
});
