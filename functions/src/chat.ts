/**
 * Chat P2P Cloud Functions
 * Handle in-chat token transfers and payment requests
 *
 * Field names aligned with Flutter client:
 * - textContent (not content)
 * - tokenAmount (not metadata.amount)
 * - type: tokenSend, tokenRequest (not transfer, request)
 * - status: pending, paid, declined, expired, cancelled
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
  const { recipientId, amount, message, threadId } = data;

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
    .where("userId", "==", senderId)
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
    .where("userId", "==", recipientId)
    .limit(1)
    .get();

  if (recipientWalletQuery.empty) {
    throw new functions.https.HttpsError(
      "not-found",
      "Recipient wallet not found"
    );
  }

  const recipientWallet = recipientWalletQuery.docs[0];
  const recipientBalance = recipientWallet.data().tokenBalance || 0;

  // Process transfer in transaction
  await db.runTransaction(async (transaction) => {
    // Calculate balances after transfer
    const senderBalanceAfter = senderBalance - amount;
    const recipientBalanceAfter = recipientBalance + amount;

    // Deduct from sender
    transaction.update(senderWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(-amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      version: admin.firestore.FieldValue.increment(1),
    });

    // Add to recipient
    transaction.update(recipientWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      version: admin.firestore.FieldValue.increment(1),
    });

    // Create sender transaction record (p2pSend)
    const senderTxRef = db.collection("transactions").doc();
    transaction.set(senderTxRef, {
      id: senderTxRef.id,
      walletId: senderWallet.id,
      userId: senderId,
      type: "p2pSend",
      tokenAmount: -amount,
      balanceAfter: senderBalanceAfter,
      zarAmount: -amount * 0.01,
      description: "Sent to user",
      status: "completed",
      counterpartyId: recipientId,
      metadata: { threadId, message },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create recipient transaction record (p2pReceive)
    const recipientTxRef = db.collection("transactions").doc();
    transaction.set(recipientTxRef, {
      id: recipientTxRef.id,
      walletId: recipientWallet.id,
      userId: recipientId,
      type: "p2pReceive",
      tokenAmount: amount,
      balanceAfter: recipientBalanceAfter,
      zarAmount: amount * 0.01,
      description: "Received from user",
      status: "completed",
      counterpartyId: senderId,
      metadata: { threadId, message },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create chat message for transfer (Flutter-compatible fields)
    if (threadId) {
      const messageRef = db.collection("chatMessages").doc();
      const now = admin.firestore.FieldValue.serverTimestamp();

      transaction.set(messageRef, {
        id: messageRef.id,
        threadId: threadId,
        senderId: senderId,
        recipientId: recipientId,
        // Flutter-compatible field names
        textContent: message || null,
        type: "tokenSend", // Flutter expects tokenSend
        status: "paid", // Transfer is already paid/completed
        tokenAmount: amount, // Flutter expects tokenAmount directly
        mediaUrl: null,
        mediaType: null,
        actionData: null,
        expiresAt: null,
        readAt: null,
        actionedAt: now,
        createdAt: now,
      });

      // Update thread with last message preview
      const preview = message
        ? (message.length > 50 ? `${message.substring(0, 50)}...` : message)
        : `Sent ${amount} tokens`;

      transaction.update(db.collection("chatThreads").doc(threadId), {
        lastMessagePreview: preview,
        lastMessageAt: now,
        updatedAt: now,
      });
    }
  });

  return { success: true, amount };
});

/**
 * Create a token request in chat
 * Creates message in chatMessages with type: tokenRequest
 */
export const requestTokens = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  requireAppCheck(context, "requestTokens");

  const requesterId = context.auth.uid;
  const { recipientId, amount, message, threadId } = data;

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

  if (!threadId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Thread ID is required"
    );
  }

  // Create chat message for request (Flutter-compatible)
  const messageRef = db.collection("chatMessages").doc();
  const now = admin.firestore.FieldValue.serverTimestamp();
  const expiresAt = admin.firestore.Timestamp.fromDate(
    new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) // 7 days
  );

  await messageRef.set({
    id: messageRef.id,
    threadId: threadId,
    senderId: requesterId,
    recipientId: recipientId,
    // Flutter-compatible field names
    textContent: message || null,
    type: "tokenRequest", // Flutter expects tokenRequest
    status: "pending", // Request is pending until paid/declined
    tokenAmount: amount, // Flutter expects tokenAmount directly
    mediaUrl: null,
    mediaType: null,
    actionData: null,
    expiresAt: expiresAt,
    readAt: null,
    actionedAt: null,
    createdAt: now,
  });

  // Update thread with last message preview
  const preview = message
    ? (message.length > 50 ? `${message.substring(0, 50)}...` : message)
    : `Requested ${amount} tokens`;

  await db.collection("chatThreads").doc(threadId).update({
    lastMessagePreview: preview,
    lastMessageAt: now,
    updatedAt: now,
  });

  return { success: true, messageId: messageRef.id };
});

/**
 * Accept a token request from chat
 * Reads from chatMessages, performs token transfer
 */
export const acceptChatTokenRequest = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(context, "acceptChatTokenRequest");
    await requirePlayIntegrity(data, context, "acceptChatTokenRequest", "HIGHEST");

    const payerId = context.auth.uid;
    const { messageId } = data;

    if (!messageId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Message ID is required"
      );
    }

    // Get the chat message (token request)
    const messageDoc = await db.collection("chatMessages").doc(messageId).get();

    if (!messageDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Message not found");
    }

    const messageData = messageDoc.data()!;

    // Validate this is a token request
    if (messageData.type !== "tokenRequest") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Message is not a token request"
      );
    }

    // Validate the current user is the recipient (the one who should pay)
    if (messageData.recipientId !== payerId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Not authorized to accept this request"
      );
    }

    // Check if already processed
    if (messageData.status !== "pending") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Request is no longer pending (status: ${messageData.status})`
      );
    }

    // Check if expired
    if (messageData.expiresAt && messageData.expiresAt.toDate() < new Date()) {
      await messageDoc.ref.update({
        status: "expired",
        actionedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Request has expired"
      );
    }

    const requesterId = messageData.senderId;
    const amount = messageData.tokenAmount;
    const threadId = messageData.threadId;

    // Get payer's wallet
    const payerWalletQuery = await db
      .collection("wallets")
      .where("userId", "==", payerId)
      .limit(1)
      .get();

    if (payerWalletQuery.empty) {
      throw new functions.https.HttpsError("not-found", "Wallet not found");
    }

    const payerWallet = payerWalletQuery.docs[0];
    const payerBalance = payerWallet.data().tokenBalance || 0;

    if (payerBalance < amount) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Insufficient balance"
      );
    }

    // Get requester's wallet
    const requesterWalletQuery = await db
      .collection("wallets")
      .where("userId", "==", requesterId)
      .limit(1)
      .get();

    if (requesterWalletQuery.empty) {
      throw new functions.https.HttpsError(
        "not-found",
        "Requester wallet not found"
      );
    }

    const requesterWallet = requesterWalletQuery.docs[0];
    const requesterBalance = requesterWallet.data().tokenBalance || 0;

    // Process payment in transaction
    await db.runTransaction(async (transaction) => {
      const now = admin.firestore.FieldValue.serverTimestamp();
      const payerBalanceAfter = payerBalance - amount;
      const requesterBalanceAfter = requesterBalance + amount;

      // Update message status to paid
      transaction.update(messageDoc.ref, {
        status: "paid",
        actionedAt: now,
      });

      // Transfer tokens
      transaction.update(payerWallet.ref, {
        tokenBalance: admin.firestore.FieldValue.increment(-amount),
        updatedAt: now,
        version: admin.firestore.FieldValue.increment(1),
      });

      transaction.update(requesterWallet.ref, {
        tokenBalance: admin.firestore.FieldValue.increment(amount),
        updatedAt: now,
        version: admin.firestore.FieldValue.increment(1),
      });

      // Create transaction records
      const payerTxRef = db.collection("transactions").doc();
      transaction.set(payerTxRef, {
        id: payerTxRef.id,
        walletId: payerWallet.id,
        userId: payerId,
        type: "p2pSend",
        tokenAmount: -amount,
        balanceAfter: payerBalanceAfter,
        zarAmount: -amount * 0.01,
        description: "Paid token request",
        status: "completed",
        counterpartyId: requesterId,
        metadata: { messageId, threadId },
        createdAt: now,
      });

      const requesterTxRef = db.collection("transactions").doc();
      transaction.set(requesterTxRef, {
        id: requesterTxRef.id,
        walletId: requesterWallet.id,
        userId: requesterId,
        type: "p2pReceive",
        tokenAmount: amount,
        balanceAfter: requesterBalanceAfter,
        zarAmount: amount * 0.01,
        description: "Received from token request",
        status: "completed",
        counterpartyId: payerId,
        metadata: { messageId, threadId },
        createdAt: now,
      });

      // Update thread
      if (threadId) {
        transaction.update(db.collection("chatThreads").doc(threadId), {
          lastMessagePreview: `Request for ${amount} tokens paid`,
          lastMessageAt: now,
          updatedAt: now,
        });
      }
    });

    return { success: true, amount };
  }
);

/**
 * Decline a token request from chat
 */
export const declineChatTokenRequest = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(context, "declineChatTokenRequest");

    const userId = context.auth.uid;
    const { messageId, reason } = data;

    if (!messageId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Message ID is required"
      );
    }

    const messageDoc = await db.collection("chatMessages").doc(messageId).get();

    if (!messageDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Message not found");
    }

    const messageData = messageDoc.data()!;

    // Validate this is a token request
    if (messageData.type !== "tokenRequest") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Message is not a token request"
      );
    }

    // Validate the current user is the recipient (the one who should decline)
    if (messageData.recipientId !== userId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Not authorized to decline this request"
      );
    }

    if (messageData.status !== "pending") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Request is no longer pending"
      );
    }

    const now = admin.firestore.FieldValue.serverTimestamp();

    await messageDoc.ref.update({
      status: "declined",
      actionedAt: now,
      actionData: reason || null,
    });

    // Update thread
    const threadId = messageData.threadId;
    if (threadId) {
      await db.collection("chatThreads").doc(threadId).update({
        lastMessagePreview: `Request for ${messageData.tokenAmount} tokens declined`,
        lastMessageAt: now,
        updatedAt: now,
      });
    }

    return { success: true };
  }
);

// ============== Legacy functions for backwards compatibility ==============

/**
 * Create a payment request in paymentRequests collection (legacy)
 * @deprecated Use requestTokens instead which creates in chatMessages
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
    const { recipientId, amount, message, threadId } = data;

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

    // Create payment request in legacy collection
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

    // Also create chat message with Flutter-compatible fields
    if (threadId) {
      const messageRef = db.collection("chatMessages").doc();
      const now = admin.firestore.FieldValue.serverTimestamp();
      const expiresAt = admin.firestore.Timestamp.fromDate(
        new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
      );

      await messageRef.set({
        id: messageRef.id,
        threadId: threadId,
        senderId: requesterId,
        recipientId: recipientId,
        textContent: message || null,
        type: "tokenRequest",
        status: "pending",
        tokenAmount: amount,
        mediaUrl: null,
        mediaType: null,
        actionData: requestRef.id, // Link to legacy paymentRequests doc
        expiresAt: expiresAt,
        readAt: null,
        actionedAt: null,
        createdAt: now,
      });

      await db.collection("chatThreads").doc(threadId).update({
        lastMessagePreview: `Requested ${amount} tokens`,
        lastMessageAt: now,
        updatedAt: now,
      });
    }

    return { success: true, requestId: requestRef.id };
  }
);

/**
 * Pay a payment request from legacy paymentRequests collection
 * @deprecated Use acceptChatTokenRequest for chatMessages-based requests
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
  const { requestId } = data;

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
    await requestDoc.ref.update({ status: "expired" });
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Request has expired"
    );
  }

  // Get payer's wallet
  const payerWalletQuery = await db
    .collection("wallets")
    .where("userId", "==", payerId)
    .limit(1)
    .get();

  if (payerWalletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Wallet not found");
  }

  const payerWallet = payerWalletQuery.docs[0];
  const payerBalance = payerWallet.data().tokenBalance || 0;

  if (payerBalance < request.amount) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Insufficient balance"
    );
  }

  // Get requester's wallet
  const requesterWalletQuery = await db
    .collection("wallets")
    .where("userId", "==", request.requesterId)
    .limit(1)
    .get();

  if (requesterWalletQuery.empty) {
    throw new functions.https.HttpsError(
      "not-found",
      "Requester wallet not found"
    );
  }

  const requesterWallet = requesterWalletQuery.docs[0];
  const requesterBalance = requesterWallet.data().tokenBalance || 0;

  // Process payment
  await db.runTransaction(async (transaction) => {
    const now = admin.firestore.FieldValue.serverTimestamp();
    const payerBalanceAfter = payerBalance - request.amount;
    const requesterBalanceAfter = requesterBalance + request.amount;

    // Update request status
    transaction.update(requestDoc.ref, {
      status: "paid",
      paidAt: now,
    });

    // Transfer tokens
    transaction.update(payerWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(-request.amount),
      updatedAt: now,
      version: admin.firestore.FieldValue.increment(1),
    });

    transaction.update(requesterWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(request.amount),
      updatedAt: now,
      version: admin.firestore.FieldValue.increment(1),
    });

    // Create transaction records
    const payerTxRef = db.collection("transactions").doc();
    transaction.set(payerTxRef, {
      id: payerTxRef.id,
      walletId: payerWallet.id,
      userId: payerId,
      type: "p2pSend",
      tokenAmount: -request.amount,
      balanceAfter: payerBalanceAfter,
      zarAmount: -request.amount * 0.01,
      description: "Paid payment request",
      status: "completed",
      counterpartyId: request.requesterId,
      metadata: { requestId },
      createdAt: now,
    });

    const requesterTxRef = db.collection("transactions").doc();
    transaction.set(requesterTxRef, {
      id: requesterTxRef.id,
      walletId: requesterWallet.id,
      userId: request.requesterId,
      type: "p2pReceive",
      tokenAmount: request.amount,
      balanceAfter: requesterBalanceAfter,
      zarAmount: request.amount * 0.01,
      description: "Received from payment request",
      status: "completed",
      counterpartyId: payerId,
      metadata: { requestId },
      createdAt: now,
    });

    // Update linked chatMessage if exists
    if (request.threadId) {
      const chatMsgQuery = await db
        .collection("chatMessages")
        .where("actionData", "==", requestId)
        .limit(1)
        .get();

      if (!chatMsgQuery.empty) {
        transaction.update(chatMsgQuery.docs[0].ref, {
          status: "paid",
          actionedAt: now,
        });
      }

      transaction.update(db.collection("chatThreads").doc(request.threadId), {
        lastMessagePreview: `Request for ${request.amount} tokens paid`,
        lastMessageAt: now,
        updatedAt: now,
      });
    }
  });

  return { success: true, amount: request.amount };
});

/**
 * Decline a payment request from legacy paymentRequests collection
 * @deprecated Use declineChatTokenRequest for chatMessages-based requests
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
  const { requestId, reason } = data;

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

  const now = admin.firestore.FieldValue.serverTimestamp();

  await requestDoc.ref.update({
    status: "declined",
    declinedAt: now,
    declineReason: reason || null,
  });

  // Update linked chatMessage if exists
  if (request.threadId) {
    const chatMsgQuery = await db
      .collection("chatMessages")
      .where("actionData", "==", requestId)
      .limit(1)
      .get();

    if (!chatMsgQuery.empty) {
      await chatMsgQuery.docs[0].ref.update({
        status: "declined",
        actionedAt: now,
        actionData: reason || null,
      });
    }

    await db.collection("chatThreads").doc(request.threadId).update({
      lastMessagePreview: `Request for ${request.amount} tokens declined`,
      lastMessageAt: now,
      updatedAt: now,
    });
  }

  return { success: true };
});
