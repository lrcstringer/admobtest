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

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onDocumentUpdated } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
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
export const searchUsers = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);

  const { query } = request.data;

  if (!query || typeof query !== "string" || query.length < 2 || query.length > 50) {
    throw new HttpsError(
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
export const getOrCreateConversation = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "getOrCreateConversation");

  const { participantId } = request.data;

  if (!participantId) {
    throw new HttpsError("invalid-argument", "participantId is required");
  }

  if (userId === participantId) {
    throw new HttpsError("invalid-argument", "Cannot create conversation with yourself");
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
export const sendConversationMessage = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "sendConversationMessage");

  const { conversationId, text, mediaUrl, mediaType, replyToMessageId, ciphertext, e2ee, x3dhHeader, encryptedPreviews } = request.data;

  if (!conversationId) {
    throw new HttpsError("invalid-argument", "conversationId is required");
  }

  if (!text && !mediaUrl && !ciphertext) {
    throw new HttpsError("invalid-argument", "Either text, mediaUrl, or ciphertext is required");
  }

  // Verify conversation exists and user is a participant
  const convDoc = await db.collection("conversations").doc(conversationId).get();
  if (!convDoc.exists) {
    throw new HttpsError("not-found", "Conversation not found");
  }

  const conv = convDoc.data()!;
  if (!conv.participantIds || !conv.participantIds.includes(userId)) {
    throw new HttpsError("permission-denied", "Not a participant in this conversation");
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
      const replyText = replyData.textContent
        ? truncate(replyData.textContent, 50)
        : replyData.ciphertext
          ? "Encrypted message"
          : "[Media]";
      replyTo = {
        messageId: replyToMessageId,
        senderName: replyData.senderName || "Unknown",
        text: replyText,
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
export const sendConversationTokens = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "sendConversationTokens");
  await requirePlayIntegrity(request.data, request, "sendConversationTokens", "HIGHEST");

  const { conversationId, recipientId, amount, message } = request.data;

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

  // Validate sender balance (sub-account or main wallet)
  const senderSubAccount = await getDefaultSubAccount(userId);
  let senderSubAccountId: string | undefined;

  if (senderSubAccount) {
    const p2pAllowed = await validateSubAccountAllows(senderSubAccount.accountTypeId, "p2p_send");
    if (!p2pAllowed.allowed) {
      throw new HttpsError("failed-precondition", p2pAllowed.reason || "Account cannot send P2P transfers");
    }
    const balanceCheck = await validateSubAccountBalance(userId, senderSubAccount.id, amount);
    if (!balanceCheck.allowed) {
      throw new HttpsError("failed-precondition", balanceCheck.reason || "Insufficient balance");
    }
    senderSubAccountId = senderSubAccount.id;
  } else {
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new HttpsError("failed-precondition", `Insufficient balance: has ${mainCheck.available}, needs ${amount}`);
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
    throw new HttpsError("internal", `Failed to process transfer: ${ledgerResult.error}`);
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
export const requestConversationTokens = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "requestConversationTokens");

  const { conversationId, recipientId, amount, message } = request.data;

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
export const acceptConversationTokenRequest = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "acceptConversationTokenRequest");
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

  // Validate payer balance
  const payerSubAccount = await getDefaultSubAccount(userId);
  let payerSubAccountId: string | undefined;

  if (payerSubAccount) {
    const p2pAllowed = await validateSubAccountAllows(payerSubAccount.accountTypeId, "p2p_send");
    if (!p2pAllowed.allowed) {
      throw new HttpsError("failed-precondition", p2pAllowed.reason || "Account cannot send P2P transfers");
    }
    const balanceCheck = await validateSubAccountBalance(userId, payerSubAccount.id, amount);
    if (!balanceCheck.allowed) {
      throw new HttpsError("failed-precondition", balanceCheck.reason || "Insufficient balance");
    }
    payerSubAccountId = payerSubAccount.id;
  } else {
    const mainCheck = await validateMainWalletBalance(userId, amount);
    if (!mainCheck.sufficient) {
      throw new HttpsError("failed-precondition", `Insufficient balance: has ${mainCheck.available}, needs ${amount}`);
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
  requireAppCheck(request, "declineConversationTokenRequest");

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

// ============================================================================
// THREAD MANAGEMENT
// ============================================================================

/**
 * Mark a conversation as read for the current user.
 * Resets unreadCounts.{userId} to 0.
 */
export const markConversationRead = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "markConversationRead");

  const { conversationId } = request.data;

  if (!conversationId) {
    throw new HttpsError("invalid-argument", "conversationId is required");
  }

  await db.collection("conversations").doc(conversationId).update({
    [`unreadCounts.${userId}`]: 0,
  });

  return { success: true };
});

/**
 * Toggle pin status for a conversation.
 */
export const toggleConversationPin = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "toggleConversationPin");

  const { conversationId, pinned } = request.data;

  if (!conversationId || typeof pinned !== "boolean") {
    throw new HttpsError("invalid-argument", "conversationId and pinned (boolean) are required");
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
export const toggleConversationMute = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "toggleConversationMute");

  const { conversationId, muted } = request.data;

  if (!conversationId || typeof muted !== "boolean") {
    throw new HttpsError("invalid-argument", "conversationId and muted (boolean) are required");
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
export const archiveConversation = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "archiveConversation");

  const { conversationId } = request.data;

  if (!conversationId) {
    throw new HttpsError("invalid-argument", "conversationId is required");
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
export const toggleMessageReaction = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "toggleMessageReaction");

  const { conversationId, messageId, emoji } = request.data;

  if (!conversationId || !messageId || !emoji) {
    throw new HttpsError("invalid-argument", "conversationId, messageId, and emoji are required");
  }

  const messageRef = db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages")
    .doc(messageId);

  const messageDoc = await messageRef.get();
  if (!messageDoc.exists) {
    throw new HttpsError("not-found", "Message not found");
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

// ============================================================================
// MESSAGE DELETION
// ============================================================================

/**
 * Delete media files associated with a single message from Firebase Storage.
 * Checks all possible file paths (image full/thumb, voice, encrypted variants).
 * Best-effort: logs warnings but does not throw on failure.
 */
async function deleteMessageMedia(
  conversationId: string,
  messageId: string,
  msgData: admin.firestore.DocumentData
): Promise<void> {
  if (!msgData.media) return;

  const bucket = admin.storage().bucket();
  const prefix = `conversations/${conversationId}`;

  const possiblePaths = [
    `${prefix}/images/${messageId}_full.jpg`,
    `${prefix}/images/${messageId}_thumb.jpg`,
    `${prefix}/images/${messageId}_full.enc`,
    `${prefix}/images/${messageId}_thumb.enc`,
    `${prefix}/voice/${messageId}.m4a`,
    `${prefix}/voice/${messageId}.enc`,
  ];

  await Promise.all(
    possiblePaths.map(async (path) => {
      try {
        const file = bucket.file(path);
        const [exists] = await file.exists();
        if (exists) {
          await file.delete();
        }
      } catch (err: any) {
        logger.warn(`Failed to delete storage file ${path}:`, err.message);
      }
    })
  );
}

/**
 * Delete a single message for everyone in a conversation.
 * Soft-deletes the message (sets deletedForEveryone, clears content/media)
 * and removes associated media files from Firebase Storage.
 *
 * Any conversation participant can delete — no time limit.
 */
export const deleteConversationMessage = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "deleteConversationMessage");

    const { conversationId, messageId } = request.data;

    if (!conversationId || !messageId) {
      throw new HttpsError(
        "invalid-argument",
        "conversationId and messageId are required"
      );
    }

    // Verify conversation exists and user is a participant
    const convDoc = await db
      .collection("conversations")
      .doc(conversationId)
      .get();
    if (!convDoc.exists) {
      throw new HttpsError(
        "not-found",
        "Conversation not found"
      );
    }
    const conv = convDoc.data()!;
    if (!conv.participantIds || !conv.participantIds.includes(userId)) {
      throw new HttpsError(
        "permission-denied",
        "Not a participant in this conversation"
      );
    }

    // Get the message
    const msgRef = db
      .collection("conversations")
      .doc(conversationId)
      .collection("messages")
      .doc(messageId);
    const msgDoc = await msgRef.get();
    if (!msgDoc.exists) {
      throw new HttpsError("not-found", "Message not found");
    }

    const msgData = msgDoc.data()!;

    // Delete media from Storage (best-effort)
    await deleteMessageMedia(conversationId, messageId, msgData);

    // Soft-delete the message: clear all content fields
    await msgRef.update({
      deletedForEveryone: true,
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      textContent: null,
      ciphertext: null,
      media: null,
      e2ee: null,
      x3dhHeader: null,
    });

    // If this was the latest message, update conversation preview
    if (conv.lastMessageAt) {
      const latestMsg = await db
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .orderBy("createdAt", "desc")
        .limit(1)
        .get();

      if (!latestMsg.empty && latestMsg.docs[0].id === messageId) {
        await convDoc.ref.update({
          lastMessageText: "This message was deleted",
          lastMessageType: "system",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    }

    return { success: true };
  }
);

/**
 * Clear all messages from a conversation for the calling user only.
 * Adds the user's ID to each message's `deletedFor` array.
 * Does NOT delete media or hard-delete documents (other user still needs them).
 */
export const clearConversationChat = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "clearConversationChat");

    const { conversationId } = request.data;

    if (!conversationId) {
      throw new HttpsError(
        "invalid-argument",
        "conversationId is required"
      );
    }

    // Verify conversation exists and user is a participant
    const convDoc = await db
      .collection("conversations")
      .doc(conversationId)
      .get();
    if (!convDoc.exists) {
      throw new HttpsError(
        "not-found",
        "Conversation not found"
      );
    }
    const conv = convDoc.data()!;
    if (!conv.participantIds || !conv.participantIds.includes(userId)) {
      throw new HttpsError(
        "permission-denied",
        "Not a participant in this conversation"
      );
    }

    const messagesRef = db
      .collection("conversations")
      .doc(conversationId)
      .collection("messages");

    // Batch-update all messages: add userId to deletedFor array
    const batchSize = 500;
    let totalCleared = 0;
    let lastDoc: admin.firestore.QueryDocumentSnapshot | undefined;

    while (true) {
      let query = messagesRef.orderBy("createdAt").limit(batchSize);
      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const snapshot = await query.get();
      if (snapshot.empty) break;

      const batch = db.batch();
      for (const doc of snapshot.docs) {
        batch.update(doc.ref, {
          deletedFor: admin.firestore.FieldValue.arrayUnion(userId),
        });
      }
      await batch.commit();
      totalCleared += snapshot.docs.length;
      lastDoc = snapshot.docs.at(-1)!;

      if (snapshot.docs.length < batchSize) break;
    }

    // Reset conversation preview for this user
    await convDoc.ref.update({
      [`unreadCounts.${userId}`]: 0,
      [`lastMessageEncryptedPreviews.${userId}`]: "",
      [`chatClearedAt.${userId}`]: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    logger.info(
      `clearConversationChat: cleared ${totalCleared} messages for user ${userId} in conversation ${conversationId}`
    );

    return { success: true, clearedCount: totalCleared };
  }
);

// ============================================================================
// PROFILE SYNC TRIGGER
// ============================================================================

// ============================================================================
// HEAL STALE PARTICIPANT AVATARS
// ============================================================================

/**
 * Callable function to patch stale participant avatarUrl fields
 * on conversation documents. Called by the client-side self-healing
 * mechanism since Firestore security rules block direct client writes
 * to the conversations collection.
 *
 * Accepts: { patches: [{ conversationId, userId }] }
 * For each patch, reads the user doc's current avatarUrl and writes it
 * to participants.{userId}.avatarUrl on the conversation doc.
 */
export const healConversationAvatars = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);

  const { patches } = request.data;
  if (!Array.isArray(patches) || patches.length === 0) {
    return { success: true, healed: 0 };
  }

  // Cap at 20 patches per call to avoid abuse
  const limited = patches.slice(0, 20) as Array<{ conversationId: string; participantId: string }>;

  let healed = 0;
  for (const patch of limited) {
    const { conversationId, participantId } = patch;
    if (!conversationId || !participantId) continue;

    // Verify caller is a participant of this conversation
    const convDoc = await db.collection("conversations").doc(conversationId).get();
    if (!convDoc.exists) continue;
    const convData = convDoc.data()!;
    if (!convData.participantIds || !convData.participantIds.includes(userId)) continue;

    // Read the participant's current avatarUrl from their user doc
    const userDoc = await db.collection("users").doc(participantId).get();
    if (!userDoc.exists) continue;
    const freshAvatarUrl = userDoc.data()!.avatarUrl || null;

    // Only patch if there's actually a URL to set
    if (!freshAvatarUrl) continue;

    // Check if conversation already has this avatar (skip unnecessary writes)
    const currentAvatar = convData.participants?.[participantId]?.avatarUrl;
    if (currentAvatar === freshAvatarUrl) continue;

    await convDoc.ref.update({
      [`participants.${participantId}.avatarUrl`]: freshAvatarUrl,
    });
    healed++;
  }

  return { success: true, healed };
});

/**
 * Firestore trigger: when a user's profile changes (avatarUrl or displayName),
 * propagate the update to all conversation documents where that user
 * is a participant. This keeps denormalized participant info fresh.
 */
export const syncUserProfileToConversations = onDocumentUpdated(
  { document: "users/{userId}", labels: { area: "social" } },
  async (event) => {
    const userId = event.params.userId;
    const before = event.data?.before.data();
    const after = event.data?.after.data();

    if (!before || !after) return;

    const avatarChanged = before.avatarUrl !== after.avatarUrl;
    const nameChanged = before.displayName !== after.displayName;

    if (!avatarChanged && !nameChanged) return;

    const batchSize = 500;
    let totalUpdated = 0;

    // 1. Update all P2P conversation participant info
    const conversations = await db
      .collection("conversations")
      .where("participantIds", "array-contains", userId)
      .get();

    if (!conversations.empty) {
      for (let i = 0; i < conversations.docs.length; i += batchSize) {
        const batch = db.batch();
        const chunk = conversations.docs.slice(i, i + batchSize);
        for (const doc of chunk) {
          const updates: Record<string, unknown> = {};
          if (avatarChanged) {
            updates[`participants.${userId}.avatarUrl`] = after.avatarUrl || null;
          }
          if (nameChanged) {
            updates[`participants.${userId}.displayName`] = after.displayName || "Unknown";
          }
          batch.update(doc.ref, updates);
        }
        await batch.commit();
      }
      totalUpdated += conversations.docs.length;
    }

    // 2. Update all community member records for this user
    const communities = await db.collectionGroup("members")
      .where("userId", "==", userId)
      .where("status", "==", "active")
      .get();

    if (!communities.empty) {
      for (let i = 0; i < communities.docs.length; i += batchSize) {
        const batch = db.batch();
        const chunk = communities.docs.slice(i, i + batchSize);
        for (const doc of chunk) {
          const updates: Record<string, unknown> = {};
          if (avatarChanged) {
            updates.avatarUrl = after.avatarUrl || null;
          }
          if (nameChanged) {
            updates.displayName = after.displayName || "Unknown";
          }
          batch.update(doc.ref, updates);
        }
        await batch.commit();
      }
      totalUpdated += communities.docs.length;
    }

    logger.info(
      `syncUserProfileToConversations: updated ${totalUpdated} docs (${conversations.docs.length} conversations, ${communities.docs.length} community memberships) for user ${userId}`
    );
  });
