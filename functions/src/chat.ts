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
import {
  processP2PTransfer,
  getOrCreateDefaultSubAccount,
  getDefaultSubAccount,
  validateSubAccountAllows,
  validateSubAccountBalance,
} from "./ledger";

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

  // Get sender's default sub-account
  const senderSubAccount = await getDefaultSubAccount(senderId);
  if (!senderSubAccount) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Sender account not found. Please complete setup first."
    );
  }

  // Validate sender's account type allows P2P sends
  const p2pAllowed = await validateSubAccountAllows(
    senderSubAccount.accountTypeId,
    "p2p_send"
  );
  if (!p2pAllowed.allowed) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      p2pAllowed.reason || "This account cannot send P2P transfers"
    );
  }

  // Validate sender's sub-account has sufficient balance
  const balanceCheck = await validateSubAccountBalance(
    senderId,
    senderSubAccount.id,
    amount
  );
  if (!balanceCheck.allowed) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      balanceCheck.reason || "Insufficient balance"
    );
  }

  // Get or create recipient's default sub-account
  const { subAccountId: recipientSubAccountId } = await getOrCreateDefaultSubAccount(recipientId);

  // Generate a unique transfer ID for idempotency
  const transferId = db.collection("p2pTransfers").doc().id;

  // Process transfer through the Trust Ledger system using sub-accounts
  const ledgerResult = await processP2PTransfer(
    senderId,
    recipientId,
    amount,
    transferId,
    senderSubAccount.id, // Sender's sub-account to debit
    recipientSubAccountId, // Recipient's sub-account to credit
    message,
    {
      threadId,
      source: "chat",
    }
  );

  if (!ledgerResult.success) {
    throw new functions.https.HttpsError(
      "internal",
      `Failed to process transfer: ${ledgerResult.error}`
    );
  }

  // Create chat message for transfer if threadId provided
  if (threadId) {
    const messageRef = db.collection("chatMessages").doc();
    const now = admin.firestore.FieldValue.serverTimestamp();

    await db.runTransaction(async (transaction) => {
      transaction.set(messageRef, {
        id: messageRef.id,
        threadId: threadId,
        senderId: senderId,
        recipientId: recipientId,
        textContent: message || null,
        type: "tokenSend",
        status: "paid",
        tokenAmount: amount,
        ledgerJournalId: ledgerResult.journalId,
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
    });
  }

  return {
    success: true,
    amount,
    ledgerJournalId: ledgerResult.journalId,
  };
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

    // Get payer's default sub-account
    const payerSubAccount = await getDefaultSubAccount(payerId);
    if (!payerSubAccount) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Payer account not found. Please complete setup first."
      );
    }

    // Validate payer's account type allows P2P sends
    const p2pAllowed = await validateSubAccountAllows(
      payerSubAccount.accountTypeId,
      "p2p_send"
    );
    if (!p2pAllowed.allowed) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        p2pAllowed.reason || "This account cannot send P2P transfers"
      );
    }

    // Validate payer's sub-account has sufficient balance
    const balanceCheck = await validateSubAccountBalance(
      payerId,
      payerSubAccount.id,
      amount
    );
    if (!balanceCheck.allowed) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        balanceCheck.reason || "Insufficient balance"
      );
    }

    // Get or create requester's default sub-account
    const { subAccountId: requesterSubAccountId } = await getOrCreateDefaultSubAccount(requesterId);

    // Generate a unique transfer ID using the messageId for idempotency
    const transferId = `request_${messageId}`;

    // Process transfer through the Trust Ledger system using sub-accounts
    const ledgerResult = await processP2PTransfer(
      payerId,
      requesterId,
      amount,
      transferId,
      payerSubAccount.id, // Payer's sub-account to debit
      requesterSubAccountId, // Requester's sub-account to credit
      "Paid token request",
      {
        messageId,
        threadId,
        source: "chatRequest",
      }
    );

    if (!ledgerResult.success) {
      throw new functions.https.HttpsError(
        "internal",
        `Failed to process payment: ${ledgerResult.error}`
      );
    }

    // Update message and thread
    const now = admin.firestore.FieldValue.serverTimestamp();

    await db.runTransaction(async (transaction) => {
      // Update message status to paid with ledger reference
      transaction.update(messageDoc.ref, {
        status: "paid",
        actionedAt: now,
        ledgerJournalId: ledgerResult.journalId,
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

    return {
      success: true,
      amount,
      ledgerJournalId: ledgerResult.journalId,
    };
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

  // Get payer's default sub-account
  const payerSubAccount = await getDefaultSubAccount(payerId);
  if (!payerSubAccount) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Payer account not found"
    );
  }

  // Validate payer's account type allows P2P sends
  const p2pAllowed = await validateSubAccountAllows(
    payerSubAccount.accountTypeId,
    "p2p_send"
  );
  if (!p2pAllowed.allowed) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      p2pAllowed.reason || "This account cannot send P2P transfers"
    );
  }

  // Validate payer's sub-account has sufficient balance
  const balanceCheck = await validateSubAccountBalance(
    payerId,
    payerSubAccount.id,
    request.amount
  );
  if (!balanceCheck.allowed) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      balanceCheck.reason || "Insufficient balance"
    );
  }

  // Get or create requester's default sub-account
  const { subAccountId: requesterSubAccountId } = await getOrCreateDefaultSubAccount(request.requesterId);

  // Generate a unique transfer ID using the requestId for idempotency
  const transferId = `legacy_request_${requestId}`;

  // Process transfer through the Trust Ledger system using sub-accounts
  const ledgerResult = await processP2PTransfer(
    payerId,
    request.requesterId,
    request.amount,
    transferId,
    payerSubAccount.id, // Payer's sub-account to debit
    requesterSubAccountId, // Requester's sub-account to credit
    "Paid payment request",
    {
      requestId,
      threadId: request.threadId,
      source: "legacyPaymentRequest",
    }
  );

  if (!ledgerResult.success) {
    throw new functions.https.HttpsError(
      "internal",
      `Failed to process payment: ${ledgerResult.error}`
    );
  }

  // Update request and related records
  const now = admin.firestore.FieldValue.serverTimestamp();

  await db.runTransaction(async (transaction) => {
    // Update request status with ledger reference
    transaction.update(requestDoc.ref, {
      status: "paid",
      paidAt: now,
      ledgerJournalId: ledgerResult.journalId,
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
          ledgerJournalId: ledgerResult.journalId,
        });
      }

      transaction.update(db.collection("chatThreads").doc(request.threadId), {
        lastMessagePreview: `Request for ${request.amount} tokens paid`,
        lastMessageAt: now,
        updatedAt: now,
      });
    }
  });

  return {
    success: true,
    amount: request.amount,
    ledgerJournalId: ledgerResult.journalId,
  };
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
