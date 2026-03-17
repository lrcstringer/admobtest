/**
 * Conversation Token Operations
 *
 * Cloud Functions for sending, requesting, accepting, and declining
 * token transfers within P2P conversations. These functions interact
 * with the Trust Ledger (double-entry bookkeeping) to process payments
 * and validate balances.
 *
 * Extracted from conversations.ts to keep token-specific logic isolated.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processP2PTransfer,
  validateMainWalletBalance,
  getSubAccount,
  getAccountTypeRules,
  getUserSubAccounts,
  validateSubAccountBalance,
} from "./ledger";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

function requireAuth(request: { auth?: { uid: string } }): string {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  return request.auth.uid;
}

async function getUserProfile(userId: string) {
  const doc = await db.collection("users").doc(userId).get();
  if (!doc.exists) {
    throw new HttpsError("not-found", "User not found");
  }
  return doc.data()!;
}

// ============================================================================
// TOKEN OPERATIONS
// ============================================================================

/**
 * Send tokens to another user via conversation.
 * Creates a tokenSend message and processes through the ledger.
 */
export const sendConversationTokens = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "sendConversationTokens");
  await requirePlayIntegrity(request.data, request, "sendConversationTokens", "HIGHEST");

  const { conversationId, recipientId, amount, encryptedMessage, messageE2ee, messageX3dh, senderSubAccountId } = request.data;

  if (!conversationId || !recipientId || !amount || amount <= 0) {
    throw new HttpsError("invalid-argument", "Invalid transfer data");
  }

  if (userId === recipientId) {
    throw new HttpsError("invalid-argument", "Cannot send tokens to yourself");
  }

  // Verify conversation and membership
  const convDoc = await db.collection("conversations").doc(conversationId).get();
  if (!convDoc.exists) {
    throw new HttpsError("not-found", "Conversation not found");
  }
  const conv = convDoc.data()!;
  if (!conv.participantIds?.includes(userId) || !conv.participantIds?.includes(recipientId)) {
    throw new HttpsError("permission-denied", "Not a participant in this conversation");
  }

  // Validate sender balance — sub-account or main wallet
  if (senderSubAccountId) {
    const subAccount = await getSubAccount(userId, senderSubAccountId);
    if (!subAccount) {
      throw new HttpsError("failed-precondition", "Sub-account not found");
    }
    const balanceCheck = await validateSubAccountBalance(userId, senderSubAccountId, amount);
    if (!balanceCheck.allowed) {
      throw new HttpsError("failed-precondition", balanceCheck.reason || "Insufficient balance");
    }
  } else {
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new HttpsError("failed-precondition", `Insufficient balance: has ${mainCheck.available}, needs ${amount}`);
    }
  }

  // Process transfer through Trust Ledger
  // processP2PTransfer handles p2pRestrictToSameAccountType enforcement internally
  const transferId = db.collection("p2pTransfers").doc().id;
  const ledgerResult = await processP2PTransfer(
    userId,
    recipientId,
    amount,
    transferId,
    senderSubAccountId || undefined,
    undefined, // recipient sub-account determined by processP2PTransfer if restricted
    `P2P transfer: ${amount} tokens`,
    { conversationId, source: "conversation" }
  );

  if (!ledgerResult.success) {
    throw new HttpsError("internal", `Failed to process transfer: ${ledgerResult.error}`);
  }

  // Create tokenSend message
  const userProfile = await getUserProfile(userId);
  const now = admin.firestore.FieldValue.serverTimestamp();
  const messageRef = db.collection("conversations").doc(conversationId).collection("messages").doc();

  // Compute expiresAt from conversation disappearing messages setting
  const tokenDisappearDuration = conv.disappearingMessagesDurationMs || null;
  const tokenExpiresAt = tokenDisappearDuration
    ? admin.firestore.Timestamp.fromDate(new Date(Date.now() + tokenDisappearDuration))
    : null;

  const preview = `Sent ${amount} tokens`;

  const batch = db.batch();

  batch.set(messageRef, {
    id: messageRef.id,
    senderId: userId,
    senderName: userProfile.displayName || "Unknown",
    senderAvatarUrl: userProfile.avatarUrl || userProfile.profilePicThumbUrl || null,
    type: "tokenSend",
    status: "sent",
    textContent: null,
    ciphertext: encryptedMessage || null,
    e2ee: messageE2ee || null,
    x3dhHeader: messageX3dh || null,
    tokenAmount: amount,
    recipientId,
    senderSubAccountId: senderSubAccountId || null,
    ledgerJournalId: ledgerResult.journalId || null,
    media: null,
    reactions: {},
    replyTo: null,
    readBy: {},
    forwardedFrom: null,
    communityId: null,
    systemEventType: null,
    systemEventData: null,
    createdAt: now,
    expiresAt: tokenExpiresAt,
    actionedAt: now,
    deletedAt: null,
    deletedFor: [],
    deletedForEveryone: false,
  });

  // Update conversation
  const otherParticipants = conv.participantIds.filter((id: string) => id !== userId);
  const unreadUpdates: Record<string, unknown> = {};
  for (const pid of otherParticipants) {
    unreadUpdates[`unreadCounts.${pid}`] = admin.firestore.FieldValue.increment(1);
  }

  batch.update(convDoc.ref, {
    lastMessageId: messageRef.id,
    lastMessageText: preview,
    lastMessageSenderId: userId,
    lastMessageSenderName: userProfile.displayName || "Unknown",
    lastMessageType: "tokenSend",
    lastMessageAt: now,
    updatedAt: now,
    ...unreadUpdates,
  });

  await batch.commit();

  return { success: true, messageId: messageRef.id, amount, ledgerJournalId: ledgerResult.journalId };
});

/**
 * Request tokens from another user in a conversation.
 * Creates a tokenRequest message with 7-day expiry.
 */
export const requestConversationTokens = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "requestConversationTokens");

  const { conversationId, recipientId, amount, encryptedMessage, messageE2ee, messageX3dh, senderSubAccountId } = request.data;

  if (!conversationId || !recipientId || !amount || amount <= 0) {
    throw new HttpsError("invalid-argument", "Invalid request data");
  }

  if (userId === recipientId) {
    throw new HttpsError("invalid-argument", "Cannot request from yourself");
  }

  // Verify conversation membership
  const convDoc = await db.collection("conversations").doc(conversationId).get();
  if (!convDoc.exists) {
    throw new HttpsError("not-found", "Conversation not found");
  }
  const conv = convDoc.data()!;
  if (!conv.participantIds?.includes(userId) || !conv.participantIds?.includes(recipientId)) {
    throw new HttpsError("permission-denied", "Not a participant in this conversation");
  }

  const userProfile = await getUserProfile(userId);
  const now = admin.firestore.FieldValue.serverTimestamp();
  // Token requests expire in 7 days, or sooner if disappearing messages is enabled
  const requestTtlMs = 7 * 24 * 60 * 60 * 1000;
  const disappearTtlMs = conv.disappearingMessagesDurationMs || null;
  const effectiveTtlMs = disappearTtlMs ? Math.min(requestTtlMs, disappearTtlMs) : requestTtlMs;
  const expiresAt = admin.firestore.Timestamp.fromDate(new Date(Date.now() + effectiveTtlMs));
  const messageRef = db.collection("conversations").doc(conversationId).collection("messages").doc();

  const preview = `Requested ${amount} tokens`;

  const batch = db.batch();

  batch.set(messageRef, {
    id: messageRef.id,
    senderId: userId,
    senderName: userProfile.displayName || "Unknown",
    senderAvatarUrl: userProfile.avatarUrl || userProfile.profilePicThumbUrl || null,
    type: "tokenRequest",
    status: "pending",
    textContent: null,
    ciphertext: encryptedMessage || null,
    e2ee: messageE2ee || null,
    x3dhHeader: messageX3dh || null,
    tokenAmount: amount,
    recipientId,
    senderSubAccountId: senderSubAccountId || null,
    ledgerJournalId: null,
    media: null,
    reactions: {},
    replyTo: null,
    readBy: {},
    forwardedFrom: null,
    communityId: null,
    systemEventType: null,
    systemEventData: null,
    createdAt: now,
    expiresAt,
    actionedAt: null,
    deletedAt: null,
    deletedFor: [],
    deletedForEveryone: false,
  });

  // Update conversation
  const otherParticipants = conv.participantIds.filter((id: string) => id !== userId);
  const unreadUpdates: Record<string, unknown> = {};
  for (const pid of otherParticipants) {
    unreadUpdates[`unreadCounts.${pid}`] = admin.firestore.FieldValue.increment(1);
  }

  batch.update(convDoc.ref, {
    lastMessageId: messageRef.id,
    lastMessageText: preview,
    lastMessageSenderId: userId,
    lastMessageSenderName: userProfile.displayName || "Unknown",
    lastMessageType: "tokenRequest",
    lastMessageAt: now,
    updatedAt: now,
    ...unreadUpdates,
  });

  await batch.commit();

  return { success: true, messageId: messageRef.id };
});

/**
 * Accept a token request in a conversation.
 * Validates the request is pending + not expired, processes payment via ledger.
 */
export const acceptConversationTokenRequest = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "acceptConversationTokenRequest");
  await requirePlayIntegrity(request.data, request, "acceptConversationTokenRequest", "HIGHEST");

  const { conversationId, messageId } = request.data;

  if (!conversationId || !messageId) {
    throw new HttpsError("invalid-argument", "conversationId and messageId are required");
  }

  const messageDoc = await db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc(messageId)
    .get();

  if (!messageDoc.exists) {
    throw new HttpsError("not-found", "Message not found");
  }

  const msgData = messageDoc.data()!;

  if (msgData.type !== "tokenRequest") {
    throw new HttpsError("invalid-argument", "Message is not a token request");
  }

  if (msgData.recipientId !== userId) {
    throw new HttpsError("permission-denied", "Not authorized to accept this request");
  }

  if (msgData.status !== "pending") {
    throw new HttpsError("failed-precondition", `Request is no longer pending (status: ${msgData.status})`);
  }

  if (msgData.expiresAt && msgData.expiresAt.toDate() < new Date()) {
    await messageDoc.ref.update({
      status: "expired",
      actionedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    throw new HttpsError("failed-precondition", "Request has expired");
  }

  const requesterId = msgData.senderId;
  const amount = msgData.tokenAmount;
  const requesterSubAccountId: string | undefined = msgData.senderSubAccountId || undefined;

  // Determine payer's source sub-account:
  // If the requester specified a brand sub-account with p2pRestrictToSameAccountType,
  // the payer must also have a matching brand sub-account — and pay from it.
  let payerSubAccountId: string | undefined;
  if (requesterSubAccountId) {
    const requesterSubAccount = await getSubAccount(requesterId, requesterSubAccountId);
    if (requesterSubAccount?.accountTypeId) {
      const rules = await getAccountTypeRules(requesterSubAccount.accountTypeId);
      if (rules.p2pRestrictToSameAccountType) {
        const payerSubAccounts = await getUserSubAccounts(userId);
        const matchingSub = payerSubAccounts.find(
          (sa) => sa.accountTypeId === requesterSubAccount.accountTypeId && sa.isActive
        );
        if (!matchingSub) {
          throw new HttpsError(
            "failed-precondition",
            "You do not have a matching brand wallet to pay this request"
          );
        }
        payerSubAccountId = matchingSub.id;
      }
    }
  }

  // Validate payer balance — sub-account or main wallet
  if (payerSubAccountId) {
    const balanceCheck = await validateSubAccountBalance(userId, payerSubAccountId, amount);
    if (!balanceCheck.allowed) {
      throw new HttpsError("failed-precondition", balanceCheck.reason || "Insufficient balance");
    }
  } else {
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new HttpsError("failed-precondition", `Insufficient balance: has ${mainCheck.available}, needs ${amount}`);
    }
  }

  // Process transfer through Trust Ledger
  // processP2PTransfer handles p2pRestrictToSameAccountType enforcement internally
  const transferId = `conv_request_${messageId}`;
  const ledgerResult = await processP2PTransfer(
    userId,
    requesterId,
    amount,
    transferId,
    payerSubAccountId,
    requesterSubAccountId,
    "Paid token request",
    { conversationId, messageId, source: "conversationRequest" }
  );

  if (!ledgerResult.success) {
    throw new HttpsError("internal", `Failed to process payment: ${ledgerResult.error}`);
  }

  // Update message and conversation
  const now = admin.firestore.FieldValue.serverTimestamp();

  await db.runTransaction(async (transaction) => {
    transaction.update(messageDoc.ref, {
      status: "paid",
      actionedAt: now,
      ledgerJournalId: ledgerResult.journalId || null,
    });

    transaction.update(db.collection("conversations").doc(conversationId), {
      lastMessageText: `Request for ${amount} tokens paid`,
      lastMessageAt: now,
      updatedAt: now,
    });
  });

  return { success: true, amount, ledgerJournalId: ledgerResult.journalId };
});

/**
 * Decline a token request in a conversation.
 */
export const declineConversationTokenRequest = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  await requireAppCheck(request, "declineConversationTokenRequest");

  const { conversationId, messageId } = request.data;

  if (!conversationId || !messageId) {
    throw new HttpsError("invalid-argument", "conversationId and messageId are required");
  }

  const messageDoc = await db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc(messageId)
    .get();

  if (!messageDoc.exists) {
    throw new HttpsError("not-found", "Message not found");
  }

  const msgData = messageDoc.data()!;

  if (msgData.type !== "tokenRequest") {
    throw new HttpsError("invalid-argument", "Message is not a token request");
  }

  if (msgData.recipientId !== userId) {
    throw new HttpsError("permission-denied", "Not authorized to decline this request");
  }

  if (msgData.status !== "pending") {
    throw new HttpsError("failed-precondition", "Request is no longer pending");
  }

  const now = admin.firestore.FieldValue.serverTimestamp();

  await db.runTransaction(async (transaction) => {
    transaction.update(messageDoc.ref, {
      status: "declined",
      actionedAt: now,
    });

    transaction.update(db.collection("conversations").doc(conversationId), {
      lastMessageText: `Request for ${msgData.tokenAmount} tokens declined`,
      lastMessageAt: now,
      updatedAt: now,
    });
  });

  return { success: true };
});
