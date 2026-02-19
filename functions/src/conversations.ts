/**
 * Conversations Cloud Functions
 *
 * P2P direct messaging system using subcollection messages.
 * Replaces the old flat chatMessages/chatThreads collections.
 *
 * Collections:
 *   conversations/{conversationId}
 *   conversations/{conversationId}/messages/{messageId}
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processP2PTransfer,
  getDefaultSubAccount,
  validateSubAccountAllows,
  validateSubAccountBalance,
  validateMainWalletBalance,
} from "./ledger";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

function requireAuth(context: functions.https.CallableContext): string {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  return context.auth.uid;
}

async function getUserProfile(userId: string) {
  const doc = await db.collection("users").doc(userId).get();
  if (!doc.exists) {
    throw new functions.https.HttpsError("not-found", "User not found");
  }
  return doc.data()!;
}

function truncate(text: string, maxLen: number): string {
  return text.length > maxLen ? text.substring(0, maxLen) + "..." : text;
}

// ============================================================================
// USER SEARCH
// ============================================================================

/**
 * Search for users by display name (case-insensitive prefix match).
 * Requires `displayNameLower` field on user documents.
 * Returns only public profile fields (no phone, FCM token, etc.).
 * Used by the contact picker when starting a new conversation.
 */
export const searchUsers = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);

  const { query } = data;

  if (!query || typeof query !== "string" || query.length < 2 || query.length > 50) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "query must be a string between 2 and 50 characters"
    );
  }

  const queryLower = query.toLowerCase();
  const limit = 20;

  // Search by displayNameLower prefix (case-insensitive)
  const nameResults = await db
    .collection("users")
    .where("displayNameLower", ">=", queryLower)
    .where("displayNameLower", "<=", queryLower + "\uf8ff")
    .limit(limit)
    .get();

  // Exclude calling user
  const users: Array<Record<string, unknown>> = [];

  for (const doc of nameResults.docs) {
    if (doc.id === userId) continue;

    const d = doc.data();
    users.push({
      userId: doc.id,
      displayName: d.displayName || "Unknown",
      username: d.username || null,
      avatarUrl: d.avatarUrl || null,
      avatarColor: d.avatarColor || null,
    });

    if (users.length >= limit) break;
  }

  return { success: true, users };
});

// ============================================================================
// CONVERSATION MANAGEMENT
// ============================================================================

/**
 * Get or create a P2P conversation between the current user and a participant.
 * If a conversation already exists between the two users, returns it.
 * Otherwise, creates a new one with denormalized participant info.
 */
export const getOrCreateConversation = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "getOrCreateConversation");

  const { participantId } = data;

  if (!participantId) {
    throw new functions.https.HttpsError("invalid-argument", "participantId is required");
  }

  if (userId === participantId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot create conversation with yourself");
  }

  // Check if conversation already exists between these two users
  const existing = await db
    .collection("conversations")
    .where("participantIds", "array-contains", userId)
    .where("type", "==", "p2p")
    .get();

  for (const doc of existing.docs) {
    const convData = doc.data();
    if (convData.participantIds && convData.participantIds.includes(participantId)) {
      return { success: true, conversation: { ...convData, id: doc.id } };
    }
  }

  // Get both user profiles for denormalized data
  const [currentUser, otherUser] = await Promise.all([
    getUserProfile(userId),
    getUserProfile(participantId),
  ]);

  const now = admin.firestore.FieldValue.serverTimestamp();
  const convRef = db.collection("conversations").doc();

  const conversation = {
    id: convRef.id,
    type: "p2p",
    participantIds: [userId, participantId],
    participants: {
      [userId]: {
        displayName: currentUser.displayName || "Unknown",
        avatarUrl: currentUser.avatarUrl || currentUser.profilePicThumbUrl || null,
      },
      [participantId]: {
        displayName: otherUser.displayName || "Unknown",
        avatarUrl: otherUser.avatarUrl || otherUser.profilePicThumbUrl || null,
      },
    },
    lastMessageText: null,
    lastMessageSenderId: null,
    lastMessageSenderName: null,
    lastMessageType: null,
    lastMessageAt: null,
    unreadCounts: {
      [userId]: 0,
      [participantId]: 0,
    },
    archived: {
      [userId]: false,
      [participantId]: false,
    },
    pinned: {
      [userId]: false,
      [participantId]: false,
    },
    muted: {
      [userId]: false,
      [participantId]: false,
    },
    createdAt: now,
    updatedAt: null,
  };

  await convRef.set(conversation);

  return { success: true, conversation: { ...conversation, id: convRef.id } };
});

// ============================================================================
// MESSAGING
// ============================================================================

/**
 * Send a text or media message in a conversation.
 * Writes message to subcollection and updates parent lastMessage + unreadCounts.
 */
export const sendConversationMessage = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "sendConversationMessage");

  const { conversationId, text, mediaUrl, mediaType, replyToMessageId, ciphertext, e2ee, x3dhHeader, encryptedPreviews } = data;

  if (!conversationId) {
    throw new functions.https.HttpsError("invalid-argument", "conversationId is required");
  }

  if (!text && !mediaUrl && !ciphertext) {
    throw new functions.https.HttpsError("invalid-argument", "Either text, mediaUrl, or ciphertext is required");
  }

  // Verify conversation exists and user is a participant
  const convDoc = await db.collection("conversations").doc(conversationId).get();
  if (!convDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Conversation not found");
  }

  const conv = convDoc.data()!;
  if (!conv.participantIds || !conv.participantIds.includes(userId)) {
    throw new functions.https.HttpsError("permission-denied", "Not a participant in this conversation");
  }

  // Get sender info
  const userProfile = await getUserProfile(userId);
  const senderName = userProfile.displayName || "Unknown";
  const senderAvatarUrl = userProfile.avatarUrl || userProfile.profilePicThumbUrl || null;

  // Build reply context if replying
  let replyTo = null;
  if (replyToMessageId) {
    const replyDoc = await db
      .collection("conversations")
      .doc(conversationId)
      .collection("messages")
      .doc(replyToMessageId)
      .get();
    if (replyDoc.exists) {
      const replyData = replyDoc.data()!;
      replyTo = {
        messageId: replyToMessageId,
        senderName: replyData.senderName || "Unknown",
        text: truncate(replyData.textContent || "[Media]", 50),
        type: replyData.type || "text",
      };
    }
  }

  const now = admin.firestore.FieldValue.serverTimestamp();
  const messageRef = db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc();

  const messageType = mediaUrl ? (mediaType?.startsWith("audio") ? "voice" : "image") : "text";

  const message: Record<string, unknown> = {
    id: messageRef.id,
    senderId: userId,
    senderName,
    senderAvatarUrl,
    type: messageType,
    status: "sent",
    textContent: ciphertext ? null : (text || null),
    ciphertext: ciphertext || null,
    e2ee: e2ee || null,
    x3dhHeader: x3dhHeader || null,
    media: mediaUrl
      ? {
          url: mediaUrl,
          mimeType: mediaType || "application/octet-stream",
          fileName: `${messageType}_${Date.now()}`,
          fileSize: 0,
          thumbnailUrl: null,
          duration: null,
          width: null,
          height: null,
        }
      : null,
    tokenAmount: null,
    recipientId: null,
    ledgerJournalId: null,
    reactions: {},
    replyTo,
    communityId: null,
    systemEventType: null,
    systemEventData: null,
    createdAt: now,
    expiresAt: null,
    actionedAt: null,
    deletedAt: null,
    deletedFor: [],
    deletedForEveryone: false,
  };

  // Find other participants to increment their unread counts
  const otherParticipants = conv.participantIds.filter((id: string) => id !== userId);
  const unreadUpdates: Record<string, unknown> = {};
  for (const pid of otherParticipants) {
    unreadUpdates[`unreadCounts.${pid}`] = admin.firestore.FieldValue.increment(1);
  }

  // Write message and update conversation atomically
  const batch = db.batch();

  batch.set(messageRef, message);

  batch.update(convDoc.ref, {
    lastMessageText: ciphertext ? null : truncate(text || "[Media]", 100),
    lastMessageSenderId: userId,
    lastMessageSenderName: senderName,
    lastMessageType: messageType,
    lastMessageAt: now,
    updatedAt: now,
    ...unreadUpdates,
    ...(encryptedPreviews ? { lastMessageEncryptedPreviews: encryptedPreviews } : {}),
  });

  await batch.commit();

  return { success: true, messageId: messageRef.id };
});

// ============================================================================
// TOKEN OPERATIONS
// ============================================================================

/**
 * Send tokens to another user via conversation.
 * Creates a tokenSend message and processes through the ledger.
 */
export const sendConversationTokens = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "sendConversationTokens");
  await requirePlayIntegrity(data, context, "sendConversationTokens", "HIGHEST");

  const { conversationId, recipientId, amount, message } = data;

  if (!conversationId || !recipientId || !amount || amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Invalid transfer data");
  }

  if (userId === recipientId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot send tokens to yourself");
  }

  // Verify conversation and membership
  const convDoc = await db.collection("conversations").doc(conversationId).get();
  if (!convDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Conversation not found");
  }
  const conv = convDoc.data()!;
  if (!conv.participantIds?.includes(userId) || !conv.participantIds?.includes(recipientId)) {
    throw new functions.https.HttpsError("permission-denied", "Not a participant in this conversation");
  }

  // Validate sender balance (sub-account or main wallet)
  const senderSubAccount = await getDefaultSubAccount(userId);
  let senderSubAccountId: string | undefined;

  if (senderSubAccount) {
    const p2pAllowed = await validateSubAccountAllows(senderSubAccount.accountTypeId, "p2p_send");
    if (!p2pAllowed.allowed) {
      throw new functions.https.HttpsError("failed-precondition", p2pAllowed.reason || "Account cannot send P2P transfers");
    }
    const balanceCheck = await validateSubAccountBalance(userId, senderSubAccount.id, amount);
    if (!balanceCheck.allowed) {
      throw new functions.https.HttpsError("failed-precondition", balanceCheck.reason || "Insufficient balance");
    }
    senderSubAccountId = senderSubAccount.id;
  } else {
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new functions.https.HttpsError("failed-precondition", `Insufficient balance: has ${mainCheck.available}, needs ${amount}`);
    }
  }

  // Process transfer through Trust Ledger
  const transferId = db.collection("p2pTransfers").doc().id;
  const ledgerResult = await processP2PTransfer(
    userId,
    recipientId,
    amount,
    transferId,
    senderSubAccountId,
    undefined,
    message,
    { conversationId, source: "conversation" }
  );

  if (!ledgerResult.success) {
    throw new functions.https.HttpsError("internal", `Failed to process transfer: ${ledgerResult.error}`);
  }

  // Create tokenSend message
  const userProfile = await getUserProfile(userId);
  const now = admin.firestore.FieldValue.serverTimestamp();
  const messageRef = db.collection("conversations").doc(conversationId).collection("messages").doc();

  const preview = message ? truncate(message, 100) : `Sent ${amount} tokens`;

  const batch = db.batch();

  batch.set(messageRef, {
    id: messageRef.id,
    senderId: userId,
    senderName: userProfile.displayName || "Unknown",
    senderAvatarUrl: userProfile.avatarUrl || userProfile.profilePicThumbUrl || null,
    type: "tokenSend",
    status: "sent",
    textContent: message || null,
    tokenAmount: amount,
    recipientId,
    ledgerJournalId: ledgerResult.journalId || null,
    media: null,
    reactions: {},
    replyTo: null,
    communityId: null,
    systemEventType: null,
    systemEventData: null,
    createdAt: now,
    expiresAt: null,
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
export const requestConversationTokens = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "requestConversationTokens");

  const { conversationId, recipientId, amount, message } = data;

  if (!conversationId || !recipientId || !amount || amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Invalid request data");
  }

  if (userId === recipientId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot request from yourself");
  }

  // Verify conversation membership
  const convDoc = await db.collection("conversations").doc(conversationId).get();
  if (!convDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Conversation not found");
  }
  const conv = convDoc.data()!;
  if (!conv.participantIds?.includes(userId) || !conv.participantIds?.includes(recipientId)) {
    throw new functions.https.HttpsError("permission-denied", "Not a participant in this conversation");
  }

  const userProfile = await getUserProfile(userId);
  const now = admin.firestore.FieldValue.serverTimestamp();
  const expiresAt = admin.firestore.Timestamp.fromDate(new Date(Date.now() + 7 * 24 * 60 * 60 * 1000));
  const messageRef = db.collection("conversations").doc(conversationId).collection("messages").doc();

  const preview = message ? truncate(message, 100) : `Requested ${amount} tokens`;

  const batch = db.batch();

  batch.set(messageRef, {
    id: messageRef.id,
    senderId: userId,
    senderName: userProfile.displayName || "Unknown",
    senderAvatarUrl: userProfile.avatarUrl || userProfile.profilePicThumbUrl || null,
    type: "tokenRequest",
    status: "pending",
    textContent: message || null,
    tokenAmount: amount,
    recipientId,
    ledgerJournalId: null,
    media: null,
    reactions: {},
    replyTo: null,
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
export const acceptConversationTokenRequest = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "acceptConversationTokenRequest");
  await requirePlayIntegrity(data, context, "acceptConversationTokenRequest", "HIGHEST");

  const { conversationId, messageId } = data;

  if (!conversationId || !messageId) {
    throw new functions.https.HttpsError("invalid-argument", "conversationId and messageId are required");
  }

  const messageDoc = await db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc(messageId)
    .get();

  if (!messageDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Message not found");
  }

  const msgData = messageDoc.data()!;

  if (msgData.type !== "tokenRequest") {
    throw new functions.https.HttpsError("invalid-argument", "Message is not a token request");
  }

  if (msgData.recipientId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized to accept this request");
  }

  if (msgData.status !== "pending") {
    throw new functions.https.HttpsError("failed-precondition", `Request is no longer pending (status: ${msgData.status})`);
  }

  if (msgData.expiresAt && msgData.expiresAt.toDate() < new Date()) {
    await messageDoc.ref.update({
      status: "expired",
      actionedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    throw new functions.https.HttpsError("failed-precondition", "Request has expired");
  }

  const requesterId = msgData.senderId;
  const amount = msgData.tokenAmount;

  // Validate payer balance
  const payerSubAccount = await getDefaultSubAccount(userId);
  let payerSubAccountId: string | undefined;

  if (payerSubAccount) {
    const p2pAllowed = await validateSubAccountAllows(payerSubAccount.accountTypeId, "p2p_send");
    if (!p2pAllowed.allowed) {
      throw new functions.https.HttpsError("failed-precondition", p2pAllowed.reason || "Account cannot send P2P transfers");
    }
    const balanceCheck = await validateSubAccountBalance(userId, payerSubAccount.id, amount);
    if (!balanceCheck.allowed) {
      throw new functions.https.HttpsError("failed-precondition", balanceCheck.reason || "Insufficient balance");
    }
    payerSubAccountId = payerSubAccount.id;
  } else {
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new functions.https.HttpsError("failed-precondition", `Insufficient balance: has ${mainCheck.available}, needs ${amount}`);
    }
  }

  // Process transfer through Trust Ledger
  const transferId = `conv_request_${messageId}`;
  const ledgerResult = await processP2PTransfer(
    userId,
    requesterId,
    amount,
    transferId,
    payerSubAccountId,
    undefined,
    "Paid token request",
    { conversationId, messageId, source: "conversationRequest" }
  );

  if (!ledgerResult.success) {
    throw new functions.https.HttpsError("internal", `Failed to process payment: ${ledgerResult.error}`);
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
export const declineConversationTokenRequest = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "declineConversationTokenRequest");

  const { conversationId, messageId } = data;

  if (!conversationId || !messageId) {
    throw new functions.https.HttpsError("invalid-argument", "conversationId and messageId are required");
  }

  const messageDoc = await db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc(messageId)
    .get();

  if (!messageDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Message not found");
  }

  const msgData = messageDoc.data()!;

  if (msgData.type !== "tokenRequest") {
    throw new functions.https.HttpsError("invalid-argument", "Message is not a token request");
  }

  if (msgData.recipientId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized to decline this request");
  }

  if (msgData.status !== "pending") {
    throw new functions.https.HttpsError("failed-precondition", "Request is no longer pending");
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

// ============================================================================
// THREAD MANAGEMENT
// ============================================================================

/**
 * Mark a conversation as read for the current user.
 * Resets unreadCounts.{userId} to 0.
 */
export const markConversationRead = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "markConversationRead");

  const { conversationId } = data;

  if (!conversationId) {
    throw new functions.https.HttpsError("invalid-argument", "conversationId is required");
  }

  await db.collection("conversations").doc(conversationId).update({
    [`unreadCounts.${userId}`]: 0,
  });

  return { success: true };
});

/**
 * Toggle pin status for a conversation.
 */
export const toggleConversationPin = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "toggleConversationPin");

  const { conversationId, pinned } = data;

  if (!conversationId || typeof pinned !== "boolean") {
    throw new functions.https.HttpsError("invalid-argument", "conversationId and pinned (boolean) are required");
  }

  await db.collection("conversations").doc(conversationId).update({
    [`pinned.${userId}`]: pinned,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true };
});

/**
 * Toggle mute status for a conversation.
 */
export const toggleConversationMute = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "toggleConversationMute");

  const { conversationId, muted } = data;

  if (!conversationId || typeof muted !== "boolean") {
    throw new functions.https.HttpsError("invalid-argument", "conversationId and muted (boolean) are required");
  }

  await db.collection("conversations").doc(conversationId).update({
    [`muted.${userId}`]: muted,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true };
});

/**
 * Archive a conversation for the current user.
 */
export const archiveConversation = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "archiveConversation");

  const { conversationId } = data;

  if (!conversationId) {
    throw new functions.https.HttpsError("invalid-argument", "conversationId is required");
  }

  await db.collection("conversations").doc(conversationId).update({
    [`archived.${userId}`]: true,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true };
});

// ============================================================================
// REACTIONS
// ============================================================================

/**
 * Toggle a reaction on a message.
 * If the user has already reacted with this emoji, removes it.
 * Otherwise, adds it.
 */
export const toggleMessageReaction = functions.https.onCall(async (data, context) => {
  const userId = requireAuth(context);
  requireAppCheck(context, "toggleMessageReaction");

  const { conversationId, messageId, emoji } = data;

  if (!conversationId || !messageId || !emoji) {
    throw new functions.https.HttpsError("invalid-argument", "conversationId, messageId, and emoji are required");
  }

  const messageRef = db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc(messageId);

  const messageDoc = await messageRef.get();
  if (!messageDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Message not found");
  }

  const reactions = messageDoc.data()!.reactions || {};
  const emojiReactions: string[] = reactions[emoji] || [];

  if (emojiReactions.includes(userId)) {
    // Remove reaction
    await messageRef.update({
      [`reactions.${emoji}`]: admin.firestore.FieldValue.arrayRemove(userId),
    });
  } else {
    // Add reaction
    await messageRef.update({
      [`reactions.${emoji}`]: admin.firestore.FieldValue.arrayUnion(userId),
    });
  }

  return { success: true };
});
