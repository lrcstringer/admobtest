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

  // Get caller's blocked list for filtering
  const callerDoc = await db.collection("users").doc(userId).get();
  const callerBlockedIds: string[] = callerDoc.data()?.chat?.blockedUserIds || [];

  // Exclude calling user, blocked users, and users who restrict discoverability
  const users: Array<Record<string, unknown>> = [];

  for (const doc of nameResults.docs) {
    if (doc.id === userId) continue;

    const d = doc.data();

    // Skip users the caller has blocked
    if (callerBlockedIds.includes(doc.id)) continue;

    // Skip users who have blocked the caller
    const targetBlockedIds: string[] = d.chat?.blockedUserIds || [];
    if (targetBlockedIds.includes(userId)) continue;

    // Respect discoverability privacy setting
    const discoverability = d.privacy?.discoverability || "everyone";
    if (discoverability === "nobody") continue;
    if (discoverability === "contactsOnly") {
      // Check if caller is in this user's contacts
      const contactSnap = await db
        .collection("contacts")
        .where("userId", "==", doc.id)
        .where("contactUserId", "==", userId)
        .where("status", "==", "accepted")
        .limit(1)
        .get();
      if (contactSnap.empty) continue;
    }

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

  // Deterministic doc ID prevents duplicate conversations from race conditions
  const sortedIds = [userId, participantId].sort();
  const deterministicId = `p2p_${sortedIds[0]}_${sortedIds[1]}`;
  const convRef = db.collection("conversations").doc(deterministicId);

  // Use a transaction to prevent race condition where both participants call
  // getOrCreateConversation concurrently and the second set() overwrites the
  // first's accepted map (inverting who accepted).
  const result = await db.runTransaction(async (txn) => {
    const existingDoc = await txn.get(convRef);
    if (existingDoc.exists) {
      const convData = existingDoc.data()!;
      return { created: false, conversation: { ...convData, id: existingDoc.id } };
    }

    // Get both user profiles for denormalized data
    const [currentUser, otherUser] = await Promise.all([
      getUserProfile(userId),
      getUserProfile(participantId),
    ]);

    const now = admin.firestore.FieldValue.serverTimestamp();

    const conversation: Record<string, unknown> = {
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
      accepted: {
        [userId]: true,          // Initiator has accepted
        [participantId]: false,  // Recipient hasn't accepted yet
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
      disappearingMessagesDurationMs: null,
      createdAt: now,
      updatedAt: null,
    };

    txn.set(convRef, conversation);
    return { created: true, conversation: { ...conversation, id: convRef.id } };
  });

  return { success: true, conversation: result.conversation };
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

  const { conversationId, text, mediaUrl, mediaType, messageType: messageTypeParam, replyToMessageId, ciphertext, e2ee, x3dhHeader } = request.data;

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

  // P2P conversations require E2EE — reject plaintext messages
  if (conv.type === "p2p" && !ciphertext) {
    throw new HttpsError(
      "invalid-argument",
      "P2P conversations require end-to-end encryption. Plaintext messages are not accepted."
    );
  }

  // Fix 4: Validate E2EE envelope schema when ciphertext is present
  if (ciphertext) {
    if (!e2ee || typeof e2ee !== "object") {
      throw new HttpsError("invalid-argument", "e2ee metadata is required with ciphertext");
    }
    if (typeof e2ee.dhPublicKey !== "string" || !e2ee.dhPublicKey) {
      throw new HttpsError("invalid-argument", "e2ee.dhPublicKey is required");
    }
    if (typeof e2ee.messageNumber !== "number") {
      throw new HttpsError("invalid-argument", "e2ee.messageNumber is required");
    }
    // Fix 3: Verify the sender's claimed identity key matches their registered bundle
    if (x3dhHeader && x3dhHeader.identityKey) {
      const senderBundleDoc = await db
        .collection("users")
        .doc(userId)
        .collection("keys")
        .doc("bundle")
        .get();
      if (senderBundleDoc.exists) {
        const registeredIdentityKey = senderBundleDoc.data()!.identityKey as string | undefined;
        if (registeredIdentityKey && registeredIdentityKey !== x3dhHeader.identityKey) {
          throw new HttpsError(
            "permission-denied",
            "Sender identity key does not match registered key bundle"
          );
        }
      }
    }
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

  // Compute expiresAt from conversation disappearing messages setting
  const disappearDuration = conv.disappearingMessagesDurationMs || null;
  const messageExpiresAt = disappearDuration
    ? admin.firestore.Timestamp.fromDate(new Date(Date.now() + disappearDuration))
    : null;

  const messageType = messageTypeParam || (mediaUrl ? (mediaType?.startsWith("audio") ? "voice" : "image") : "text");

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
    readBy: {},
    forwardedFrom: null,
    communityId: null,
    systemEventType: null,
    systemEventData: null,
    createdAt: now,
    expiresAt: messageExpiresAt,
    actionedAt: null,
    deletedAt: null,
    deletedFor: [],
    deletedForEveryone: false,
  };

  // Auto-accept: if sender hasn't accepted yet, replying = implicit acceptance
  const senderAccepted = conv.accepted?.[userId] ?? true; // legacy convos = accepted
  const acceptUpdate: Record<string, unknown> = {};
  if (!senderAccepted) {
    acceptUpdate[`accepted.${userId}`] = true;
  }

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
    lastMessageId: messageRef.id,
    lastMessageText: ciphertext ? null : truncate(text || "[Media]", 100),
    lastMessageSenderId: userId,
    lastMessageSenderName: senderName,
    lastMessageType: messageType,
    lastMessageAt: now,
    updatedAt: now,
    ...unreadUpdates,
    ...acceptUpdate,
  });

  await batch.commit();

  // Send FCM push notification to other participants
  for (const pid of otherParticipants) {
    try {
      const tokenDoc = await db.collection("users").doc(pid).get();
      const fcmToken = tokenDoc.data()?.fcmToken;
      if (fcmToken) {
        // Check if the recipient has accepted this conversation
        const recipientAccepted = conv.accepted?.[pid] ?? true; // legacy = accepted
        if (!recipientAccepted) {
          // Send silent data-only push (no notification banner, no sound)
          await admin.messaging().send({
            token: fcmToken,
            data: {
              type: "message_request",
              conversationId,
              messageId: messageRef.id,
              senderId: userId,
              senderName,
            },
            android: { priority: "normal" as const },
          });
          continue; // skip normal notification
        }

        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: senderName,
            body: ciphertext ? "New encrypted message" : truncate(text || "[Media]", 100),
          },
          data: {
            type: "chat_message",
            conversationId,
            messageId: messageRef.id,
            senderId: userId,
            senderName,
          },
          android: {
            priority: "high" as const,
            notification: {
              channelId: "chat_messages",
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          },
          apns: {
            payload: {
              aps: {
                sound: "default",
                badge: 1,
              },
            },
          },
        });
      }
    } catch (fcmErr) {
      // FCM failure is non-fatal — message was already sent
      console.warn(`FCM push failed for ${pid}:`, fcmErr);
    }
  }

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

  const { conversationId, recipientId, amount, encryptedMessage, messageE2ee, messageX3dh } = request.data;

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
  requireAppCheck(request, "requestConversationTokens");

  const { conversationId, recipientId, amount, encryptedMessage, messageE2ee, messageX3dh } = request.data;

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

  // Reset unread count
  await db.collection("conversations").doc(conversationId).update({
    [`unreadCounts.${userId}`]: 0,
  });

  // Stamp readBy on recent messages not sent by this user
  const messagesRef = db
    .collection("conversations")
    .doc(conversationId)
    .collection("messages");

  const recentMessages = await messagesRef
    .where("senderId", "!=", userId)
    .orderBy("senderId")
    .orderBy("createdAt", "desc")
    .limit(100)
    .get();

  if (!recentMessages.empty) {
    const now = admin.firestore.FieldValue.serverTimestamp();
    const batch = db.batch();
    let batchCount = 0;

    for (const msgDoc of recentMessages.docs) {
      const data = msgDoc.data();
      // Skip if already read by this user
      if (data.readBy && data.readBy[userId]) continue;
      // Skip deleted messages
      if (data.deletedForEveryone) continue;

      batch.update(msgDoc.ref, {
        [`readBy.${userId}`]: now,
      });
      batchCount++;

      // Firestore batch limit is 500
      if (batchCount >= 499) break;
    }

    if (batchCount > 0) {
      await batch.commit();
    }
  }

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
// DISAPPEARING MESSAGES
// ============================================================================

/**
 * Set disappearing messages duration for a conversation.
 * Either participant can change the setting.
 * Inserts a system message announcing the change.
 *
 * Allowed durationMs values: null (off), 86400000 (24h), 604800000 (7d), 7776000000 (90d)
 */
export const setDisappearingMessages = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "setDisappearingMessages");

  const { conversationId, durationMs } = request.data;

  if (!conversationId) {
    throw new HttpsError("invalid-argument", "conversationId is required");
  }

  // Validate durationMs: null = off, or one of the allowed values
  const ALLOWED_DURATIONS: (number | null)[] = [null, 86400000, 604800000, 7776000000];
  if (!ALLOWED_DURATIONS.includes(durationMs ?? null)) {
    throw new HttpsError("invalid-argument", "Invalid duration. Allowed: null, 86400000, 604800000, 7776000000");
  }

  // Verify conversation and membership
  const convDoc = await db.collection("conversations").doc(conversationId).get();
  if (!convDoc.exists) {
    throw new HttpsError("not-found", "Conversation not found");
  }
  const conv = convDoc.data()!;
  if (!conv.participantIds || !conv.participantIds.includes(userId)) {
    throw new HttpsError("permission-denied", "Not a participant in this conversation");
  }

  // Get sender display name for system message
  const userProfile = await getUserProfile(userId);
  const senderName = userProfile.displayName || "Someone";
  const senderAvatarUrl = userProfile.avatarUrl || userProfile.profilePicThumbUrl || null;

  // Build system message text
  let systemText: string;
  const effectiveDuration = durationMs ?? null;
  if (effectiveDuration === null) {
    systemText = `${senderName} turned off disappearing messages`;
  } else if (effectiveDuration === 86400000) {
    systemText = `${senderName} turned on disappearing messages (24 hours)`;
  } else if (effectiveDuration === 604800000) {
    systemText = `${senderName} turned on disappearing messages (7 days)`;
  } else {
    systemText = `${senderName} turned on disappearing messages (90 days)`;
  }

  const now = admin.firestore.FieldValue.serverTimestamp();
  const messageRef = db.collection("conversations").doc(conversationId).collection("messages").doc();

  const batch = db.batch();

  // 1. Update conversation TTL field
  batch.update(convDoc.ref, {
    disappearingMessagesDurationMs: effectiveDuration,
    updatedAt: now,
  });

  // 2. Insert system message (system messages never expire)
  batch.set(messageRef, {
    id: messageRef.id,
    senderId: userId,
    senderName,
    senderAvatarUrl,
    type: "system",
    status: "sent",
    textContent: systemText,
    ciphertext: null,
    e2ee: null,
    x3dhHeader: null,
    media: null,
    tokenAmount: null,
    recipientId: null,
    ledgerJournalId: null,
    reactions: {},
    replyTo: null,
    readBy: {},
    forwardedFrom: null,
    communityId: null,
    systemEventType: "disappearing_messages_changed",
    systemEventData: { durationMs: effectiveDuration, changedBy: userId },
    createdAt: now,
    expiresAt: null,
    actionedAt: null,
    deletedAt: null,
    deletedFor: [],
    deletedForEveryone: false,
  });

  // 3. Update conversation last message preview
  batch.update(convDoc.ref, {
    lastMessageId: messageRef.id,
    lastMessageText: systemText,
    lastMessageSenderId: userId,
    lastMessageSenderName: senderName,
    lastMessageType: "system",
    lastMessageAt: now,
  });

  await batch.commit();

  return { success: true, messageId: messageRef.id };
});

// ============================================================================
// MESSAGE REQUESTS
// ============================================================================

/**
 * Explicitly accept a message request (conversation).
 * Sets accepted.{userId} to true on the conversation document.
 */
export const acceptConversationRequest = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "acceptConversationRequest");

    const { conversationId } = request.data;

    if (!conversationId) {
      throw new HttpsError("invalid-argument", "conversationId is required");
    }

    const convDoc = await db.collection("conversations").doc(conversationId).get();
    if (!convDoc.exists) {
      throw new HttpsError("not-found", "Conversation not found");
    }

    const conv = convDoc.data()!;
    if (!conv.participantIds?.includes(userId)) {
      throw new HttpsError("permission-denied", "Not a participant");
    }

    await convDoc.ref.update({
      [`accepted.${userId}`]: true,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);

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
// MESSAGE FORWARDING
// ============================================================================

/**
 * Forward a message from one conversation to another.
 * Re-uses media Storage URLs. Client re-encrypts the payload for the target recipient.
 */
export const forwardConversationMessage = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);
  requireAppCheck(request, "forwardConversationMessage");

  const {
    sourceConversationId,
    sourceMessageId,
    targetConversationId,
    ciphertext,
    e2ee,
    x3dhHeader,
  } = request.data;

  if (!sourceConversationId || !sourceMessageId || !targetConversationId) {
    throw new HttpsError("invalid-argument", "sourceConversationId, sourceMessageId, and targetConversationId are required");
  }

  // Verify user is participant in source conversation
  const sourceConvDoc = await db.collection("conversations").doc(sourceConversationId).get();
  if (!sourceConvDoc.exists) {
    throw new HttpsError("not-found", "Source conversation not found");
  }
  const sourceConv = sourceConvDoc.data()!;
  if (!sourceConv.participantIds?.includes(userId)) {
    throw new HttpsError("permission-denied", "Not a participant in source conversation");
  }

  // Verify user is participant in target conversation
  const targetConvDoc = await db.collection("conversations").doc(targetConversationId).get();
  if (!targetConvDoc.exists) {
    throw new HttpsError("not-found", "Target conversation not found");
  }
  const targetConv = targetConvDoc.data()!;
  if (!targetConv.participantIds?.includes(userId)) {
    throw new HttpsError("permission-denied", "Not a participant in target conversation");
  }

  // Read source message for metadata
  const sourceMessageDoc = await db
    .collection("conversations")
    .doc(sourceConversationId)
    .collection("messages")
    .doc(sourceMessageId)
    .get();

  if (!sourceMessageDoc.exists) {
    throw new HttpsError("not-found", "Source message not found");
  }

  const sourceMsg = sourceMessageDoc.data()!;

  // Validate E2EE envelope when re-encrypted ciphertext is provided
  if (ciphertext) {
    if (!e2ee || typeof e2ee !== "object") {
      throw new HttpsError("invalid-argument", "e2ee metadata is required with ciphertext");
    }
    if (typeof e2ee.dhPublicKey !== "string" || !e2ee.dhPublicKey) {
      throw new HttpsError("invalid-argument", "e2ee.dhPublicKey is required");
    }
    if (typeof e2ee.messageNumber !== "number") {
      throw new HttpsError("invalid-argument", "e2ee.messageNumber is required");
    }
  }

  // Don't allow forwarding deleted or system messages
  if (sourceMsg.deletedForEveryone) {
    throw new HttpsError("failed-precondition", "Cannot forward a deleted message");
  }
  if (sourceMsg.type === "system" || sourceMsg.type === "tokenSend" || sourceMsg.type === "tokenRequest") {
    throw new HttpsError("invalid-argument", "Cannot forward system or token messages");
  }

  // Get sender info
  const userProfile = await getUserProfile(userId);
  const senderName = userProfile.displayName || "Unknown";
  const senderAvatarUrl = userProfile.avatarUrl || userProfile.profilePicThumbUrl || null;

  const now = admin.firestore.FieldValue.serverTimestamp();
  const messageRef = db
    .collection("conversations")
    .doc(targetConversationId)
    .collection("messages")
    .doc();

  // Forwarded messages follow the TARGET conversation's disappearing messages setting
  const fwdDisappearDuration = targetConv.disappearingMessagesDurationMs || null;
  const fwdExpiresAt = fwdDisappearDuration
    ? admin.firestore.Timestamp.fromDate(new Date(Date.now() + fwdDisappearDuration))
    : null;

  const forwardedFrom = {
    messageId: sourceMessageId,
    conversationId: sourceConversationId,
    senderName: sourceMsg.senderName || "Unknown",
  };

  const batch = db.batch();

  batch.set(messageRef, {
    id: messageRef.id,
    senderId: userId,
    senderName,
    senderAvatarUrl,
    type: sourceMsg.type || "text",
    status: "sent",
    textContent: ciphertext ? null : (sourceMsg.textContent || null),
    ciphertext: ciphertext || null,
    e2ee: e2ee || null,
    x3dhHeader: x3dhHeader || null,
    media: sourceMsg.media || null,
    tokenAmount: null,
    recipientId: null,
    ledgerJournalId: null,
    reactions: {},
    replyTo: null,
    readBy: {},
    forwardedFrom,
    communityId: null,
    systemEventType: null,
    systemEventData: null,
    createdAt: now,
    expiresAt: fwdExpiresAt,
    actionedAt: null,
    deletedAt: null,
    deletedFor: [],
    deletedForEveryone: false,
  });

  // Update target conversation
  const preview = "Forwarded message";
  const otherParticipants = targetConv.participantIds.filter((id: string) => id !== userId);
  const unreadUpdates: Record<string, unknown> = {};
  for (const pid of otherParticipants) {
    unreadUpdates[`unreadCounts.${pid}`] = admin.firestore.FieldValue.increment(1);
  }

  batch.update(targetConvDoc.ref, {
    lastMessageId: messageRef.id,
    lastMessageText: preview,
    lastMessageSenderId: userId,
    lastMessageSenderName: senderName,
    lastMessageType: sourceMsg.type || "text",
    lastMessageAt: now,
    updatedAt: now,
    ...unreadUpdates,
  });

  await batch.commit();

  return { success: true, messageId: messageRef.id };
});

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

// ============================================================================
// PRIVACY SETTINGS
// ============================================================================

const ALLOWED_DISCOVERABILITY = ["everyone", "contactsOnly", "nobody"];
const ALLOWED_PHONE_VISIBILITY = ["contactsOnly", "nobody"];
const ALLOWED_PHOTO_VISIBILITY = ["everyone", "contactsOnly"];
const ALLOWED_LAST_SEEN = ["everyone", "contactsOnly", "nobody"];
const ALLOWED_GROUP_ADD = ["everyone", "contactsOnly"];
const ALLOWED_BRAND_MESSAGING = ["allowAll", "optedInOnly", "none"];

/**
 * Update the current user's privacy settings.
 * Validates each setting against allowed enum values, then writes
 * to users/{userId}.privacy map.
 */
export const updatePrivacySettings = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "updatePrivacySettings");

    const { settings } = request.data;
    if (!settings || typeof settings !== "object") {
      throw new HttpsError("invalid-argument", "settings is required");
    }

    // Validate and build the privacy map (only include provided fields)
    const privacy: Record<string, unknown> = {};

    if (settings.discoverability !== undefined) {
      if (!ALLOWED_DISCOVERABILITY.includes(settings.discoverability)) {
        throw new HttpsError(
          "invalid-argument",
          `discoverability must be one of: ${ALLOWED_DISCOVERABILITY.join(", ")}`
        );
      }
      privacy.discoverability = settings.discoverability;
    }

    if (settings.phoneNumberVisibility !== undefined) {
      if (!ALLOWED_PHONE_VISIBILITY.includes(settings.phoneNumberVisibility)) {
        throw new HttpsError(
          "invalid-argument",
          `phoneNumberVisibility must be one of: ${ALLOWED_PHONE_VISIBILITY.join(", ")}`
        );
      }
      privacy.phoneNumberVisibility = settings.phoneNumberVisibility;
    }

    if (settings.profilePhotoVisibility !== undefined) {
      if (!ALLOWED_PHOTO_VISIBILITY.includes(settings.profilePhotoVisibility)) {
        throw new HttpsError(
          "invalid-argument",
          `profilePhotoVisibility must be one of: ${ALLOWED_PHOTO_VISIBILITY.join(", ")}`
        );
      }
      privacy.profilePhotoVisibility = settings.profilePhotoVisibility;
    }

    if (settings.lastSeenVisibility !== undefined) {
      if (!ALLOWED_LAST_SEEN.includes(settings.lastSeenVisibility)) {
        throw new HttpsError(
          "invalid-argument",
          `lastSeenVisibility must be one of: ${ALLOWED_LAST_SEEN.join(", ")}`
        );
      }
      privacy.lastSeenVisibility = settings.lastSeenVisibility;
    }

    if (settings.readReceipts !== undefined) {
      if (typeof settings.readReceipts !== "boolean") {
        throw new HttpsError(
          "invalid-argument",
          "readReceipts must be a boolean"
        );
      }
      privacy.readReceipts = settings.readReceipts;
    }

    if (settings.groupAddPermission !== undefined) {
      if (!ALLOWED_GROUP_ADD.includes(settings.groupAddPermission)) {
        throw new HttpsError(
          "invalid-argument",
          `groupAddPermission must be one of: ${ALLOWED_GROUP_ADD.join(", ")}`
        );
      }
      privacy.groupAddPermission = settings.groupAddPermission;
    }

    if (settings.brandMessaging !== undefined) {
      if (!ALLOWED_BRAND_MESSAGING.includes(settings.brandMessaging)) {
        throw new HttpsError(
          "invalid-argument",
          `brandMessaging must be one of: ${ALLOWED_BRAND_MESSAGING.join(", ")}`
        );
      }
      privacy.brandMessaging = settings.brandMessaging;
    }

    if (Object.keys(privacy).length === 0) {
      throw new HttpsError(
        "invalid-argument",
        "At least one privacy setting must be provided"
      );
    }

    // Merge into existing privacy map (preserves unmodified fields)
    await db.collection("users").doc(userId).set(
      { privacy, updatedAt: admin.firestore.FieldValue.serverTimestamp() },
      { merge: true }
    );

    logger.info(`updatePrivacySettings: updated ${Object.keys(privacy).length} settings for user ${userId}`);

    return { success: true };
  }
);

// ============================================================================
// CONTACT REQUESTS
// ============================================================================

/**
 * Send a contact request to another user.
 * Creates paired contact documents: sender gets "accepted", recipient gets "pending".
 * If recipient already sent a request to sender, auto-accept both (mutual).
 */
export const sendContactRequest = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "sendContactRequest");

    const { contactUserId, source } = request.data;
    const isPhoneImport = source === "phone_import";

    if (!contactUserId || typeof contactUserId !== "string") {
      throw new HttpsError("invalid-argument", "contactUserId is required");
    }

    if (userId === contactUserId) {
      throw new HttpsError("invalid-argument", "Cannot add yourself as a contact");
    }

    // Check if target user exists
    const targetDoc = await db.collection("users").doc(contactUserId).get();
    if (!targetDoc.exists) {
      throw new HttpsError("not-found", "User not found");
    }
    const targetData = targetDoc.data()!;

    // Check blocked lists
    const callerDoc = await db.collection("users").doc(userId).get();
    const callerData = callerDoc.data()!;
    const callerBlockedIds: string[] = callerData.chat?.blockedUserIds || [];
    const targetBlockedIds: string[] = targetData.chat?.blockedUserIds || [];

    if (callerBlockedIds.includes(contactUserId)) {
      throw new HttpsError("failed-precondition", "You have blocked this user");
    }
    if (targetBlockedIds.includes(userId)) {
      throw new HttpsError("failed-precondition", "This user is not available");
    }

    // Respect discoverability privacy
    const discoverability = targetData.privacy?.discoverability || "everyone";
    if (discoverability === "nobody") {
      throw new HttpsError("failed-precondition", "This user is not accepting contact requests");
    }
    if (discoverability === "contactsOnly") {
      // Check if caller is already in target's contacts
      const existingContact = await db
        .collection("contacts")
        .where("userId", "==", contactUserId)
        .where("contactUserId", "==", userId)
        .where("status", "==", "accepted")
        .limit(1)
        .get();
      if (existingContact.empty) {
        throw new HttpsError("failed-precondition", "This user only accepts requests from existing contacts");
      }
    }

    // Check for existing relationship (either direction)
    const existingSenderDoc = await db
      .collection("contacts")
      .where("userId", "==", userId)
      .where("contactUserId", "==", contactUserId)
      .limit(1)
      .get();

    if (!existingSenderDoc.empty) {
      const existingStatus = existingSenderDoc.docs[0].data().status;
      if (existingStatus === "accepted" || existingStatus === "pending") {
        throw new HttpsError("already-exists", "Contact request already exists");
      }
    }

    // Check if recipient already sent a request to the caller (auto-mutual)
    const reverseDoc = await db
      .collection("contacts")
      .where("userId", "==", contactUserId)
      .where("contactUserId", "==", userId)
      .limit(1)
      .get();

    const now = admin.firestore.FieldValue.serverTimestamp();
    const batch = db.batch();

    if (!reverseDoc.empty && reverseDoc.docs[0].data().status === "pending") {
      // Auto-accept both sides (mutual)
      const reverseRef = reverseDoc.docs[0].ref;
      batch.update(reverseRef, { status: "accepted" });

      // Create sender's doc as accepted
      const senderRef = db.collection("contacts").doc();
      batch.set(senderRef, {
        userId,
        contactUserId,
        displayName: targetData.displayName || "User",
        username: targetData.username || null,
        avatarUrl: targetData.avatarUrl || null,
        avatarColor: targetData.avatarColor || null,
        phoneNumber: targetData.phoneNumber || null,
        status: "accepted",
        isFavorite: false,
        nickname: null,
        notes: null,
        initiatedBy: userId,
        createdAt: now,
        lastInteractionAt: null,
      });

      await batch.commit();

      // Notify both users
      try {
        const callerFcm = callerData.fcmToken;
        const targetFcm = targetData.fcmToken;
        if (targetFcm) {
          await admin.messaging().send({
            token: targetFcm,
            notification: {
              title: "Contact Accepted",
              body: `${callerData.displayName || "Someone"} is now your contact`,
            },
            data: { type: "contact_accepted", contactUserId: userId },
          });
        }
        if (callerFcm) {
          await admin.messaging().send({
            token: callerFcm,
            notification: {
              title: "Contact Accepted",
              body: `${targetData.displayName || "Someone"} is now your contact`,
            },
            data: { type: "contact_accepted", contactUserId },
          });
        }
      } catch (fcmErr) {
        logger.warn("FCM notification failed for auto-mutual contact:", fcmErr);
      }

      return { success: true, status: "accepted", autoMutual: true };
    }

    // Normal flow: create paired documents
    // Sender's doc: always accepted (they chose to add)
    // Recipient's doc: accepted if phone_import, pending otherwise
    const recipientStatus = isPhoneImport ? "accepted" : "pending";

    const senderRef = db.collection("contacts").doc();
    batch.set(senderRef, {
      userId,
      contactUserId,
      displayName: targetData.displayName || "User",
      username: targetData.username || null,
      avatarUrl: targetData.avatarUrl || null,
      avatarColor: targetData.avatarColor || null,
      phoneNumber: targetData.phoneNumber || null,
      status: "accepted",
      isFavorite: false,
      nickname: null,
      notes: null,
      initiatedBy: userId,
      createdAt: now,
      lastInteractionAt: null,
    });

    const recipientRef = db.collection("contacts").doc();
    batch.set(recipientRef, {
      userId: contactUserId,
      contactUserId: userId,
      displayName: callerData.displayName || "User",
      username: callerData.username || null,
      avatarUrl: callerData.avatarUrl || null,
      avatarColor: callerData.avatarColor || null,
      phoneNumber: callerData.phoneNumber || null,
      status: recipientStatus,
      isFavorite: false,
      nickname: null,
      notes: null,
      initiatedBy: userId,
      createdAt: now,
      lastInteractionAt: null,
    });

    await batch.commit();

    // Send FCM notification to recipient
    try {
      const targetFcm = targetData.fcmToken;
      if (targetFcm) {
        const notifTitle = isPhoneImport ? "New Contact" : "New Contact Request";
        const notifBody = isPhoneImport
          ? `${callerData.displayName || "Someone"} added you as a contact`
          : `${callerData.displayName || "Someone"} wants to add you as a contact`;
        const notifType = isPhoneImport ? "contact_accepted" : "contact_request";

        await admin.messaging().send({
          token: targetFcm,
          notification: {
            title: notifTitle,
            body: notifBody,
          },
          data: { type: notifType, contactUserId: userId },
        });
      }
    } catch (fcmErr) {
      logger.warn("FCM notification failed for contact request:", fcmErr);
    }

    return { success: true, status: recipientStatus };
  }
);

/**
 * Accept an incoming contact request.
 * Updates the recipient's contact doc to "accepted" and
 * ensures the sender's mirror doc is also "accepted".
 */
export const acceptContactRequest = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "acceptContactRequest");

    const { contactId } = request.data;

    if (!contactId || typeof contactId !== "string") {
      throw new HttpsError("invalid-argument", "contactId is required");
    }

    const contactDoc = await db.collection("contacts").doc(contactId).get();
    if (!contactDoc.exists) {
      throw new HttpsError("not-found", "Contact request not found");
    }

    const contactData = contactDoc.data()!;

    // Verify this is the recipient's pending doc
    if (contactData.userId !== userId) {
      throw new HttpsError("permission-denied", "Not authorized");
    }
    if (contactData.status !== "pending") {
      throw new HttpsError("failed-precondition", "Contact request is not pending");
    }

    const senderId = contactData.contactUserId;

    // Update recipient's doc to accepted
    const batch = db.batch();
    batch.update(contactDoc.ref, { status: "accepted" });

    // Also update the sender's mirror doc if it exists
    const senderContactSnap = await db
      .collection("contacts")
      .where("userId", "==", senderId)
      .where("contactUserId", "==", userId)
      .limit(1)
      .get();

    if (!senderContactSnap.empty) {
      batch.update(senderContactSnap.docs[0].ref, { status: "accepted" });
    }

    await batch.commit();

    // Notify the original sender
    try {
      const senderDoc = await db.collection("users").doc(senderId).get();
      const senderFcm = senderDoc.data()?.fcmToken;
      const recipientName = (await db.collection("users").doc(userId).get()).data()?.displayName || "Someone";
      if (senderFcm) {
        await admin.messaging().send({
          token: senderFcm,
          notification: {
            title: "Contact Accepted",
            body: `${recipientName} accepted your contact request`,
          },
          data: { type: "contact_accepted", contactUserId: userId },
        });
      }
    } catch (fcmErr) {
      logger.warn("FCM notification failed for contact acceptance:", fcmErr);
    }

    return { success: true };
  }
);

/**
 * Decline an incoming contact request.
 * Deletes both paired contact documents.
 */
export const declineContactRequest = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "declineContactRequest");

    const { contactId } = request.data;

    if (!contactId || typeof contactId !== "string") {
      throw new HttpsError("invalid-argument", "contactId is required");
    }

    const contactDoc = await db.collection("contacts").doc(contactId).get();
    if (!contactDoc.exists) {
      throw new HttpsError("not-found", "Contact request not found");
    }

    const contactData = contactDoc.data()!;

    // Verify this is the recipient's pending doc
    if (contactData.userId !== userId) {
      throw new HttpsError("permission-denied", "Not authorized");
    }
    if (contactData.status !== "pending") {
      throw new HttpsError("failed-precondition", "Contact request is not pending");
    }

    const senderId = contactData.contactUserId;

    // Delete both documents
    const batch = db.batch();
    batch.delete(contactDoc.ref);

    // Also delete the sender's mirror doc
    const senderContactSnap = await db
      .collection("contacts")
      .where("userId", "==", senderId)
      .where("contactUserId", "==", userId)
      .limit(1)
      .get();

    if (!senderContactSnap.empty) {
      batch.delete(senderContactSnap.docs[0].ref);
    }

    await batch.commit();

    return { success: true };
  }
);

/**
 * Remove a contact (unilateral).
 * Deletes only the caller's contact document.
 * Does NOT delete the other user's document.
 */
export const removeContact = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "removeContact");

    const { contactId } = request.data;

    if (!contactId || typeof contactId !== "string") {
      throw new HttpsError("invalid-argument", "contactId is required");
    }

    const contactDoc = await db.collection("contacts").doc(contactId).get();
    if (!contactDoc.exists) {
      throw new HttpsError("not-found", "Contact not found");
    }

    const contactData = contactDoc.data()!;

    // Verify ownership
    if (contactData.userId !== userId) {
      throw new HttpsError("permission-denied", "Not authorized");
    }

    await contactDoc.ref.delete();

    return { success: true };
  }
);

// ============================================================================
// PHONE CONTACT MATCHING
// ============================================================================

/**
 * Match a list of phone numbers against registered iMaliChat users.
 * Returns matching user profiles (public fields only), respecting
 * privacy settings and block lists.
 */
export const matchPhoneContacts = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "matchPhoneContacts");

    const { phoneNumbers } = request.data;

    if (!Array.isArray(phoneNumbers) || phoneNumbers.length === 0) {
      throw new HttpsError("invalid-argument", "phoneNumbers must be a non-empty array");
    }

    if (phoneNumbers.length > 500) {
      throw new HttpsError("invalid-argument", "Maximum 500 phone numbers per request");
    }

    // Get caller's blocked list
    const callerDoc = await db.collection("users").doc(userId).get();
    const callerBlockedIds: string[] = callerDoc.data()?.chat?.blockedUserIds || [];

    // Get caller's existing contacts with their status
    const existingContactsSnap = await db
      .collection("contacts")
      .where("userId", "==", userId)
      .get();
    const contactStatusMap = new Map<string, string>();
    for (const d of existingContactsSnap.docs) {
      const data = d.data();
      contactStatusMap.set(data.contactUserId as string, data.status as string);
    }

    const matchedUsers: Array<{
      userId: string;
      displayName: string;
      username: string | null;
      avatarUrl: string | null;
      avatarColor: string | null;
      phoneNumber: string;
      isExistingContact: boolean;
      contactStatus: string | null;
    }> = [];

    // Query users by phone number in batches of 30 (Firestore whereIn limit)
    const batchSize = 30;
    for (let i = 0; i < phoneNumbers.length; i += batchSize) {
      const batch = phoneNumbers.slice(i, i + batchSize);

      const snap = await db
        .collection("users")
        .where("phoneNumber", "in", batch)
        .get();

      for (const doc of snap.docs) {
        const uid = doc.id;

        // Skip self
        if (uid === userId) continue;

        // Skip users blocked by caller or who blocked caller
        if (callerBlockedIds.includes(uid)) continue;
        const userBlockedIds: string[] = doc.data().chat?.blockedUserIds || [];
        if (userBlockedIds.includes(userId)) continue;

        // Skip users with discoverability "nobody"
        const discoverability = doc.data().privacy?.discoverability || "everyone";
        if (discoverability === "nobody") continue;

        const userData = doc.data();
        const status = contactStatusMap.get(uid) || null;
        matchedUsers.push({
          userId: uid,
          displayName: userData.displayName || "User",
          username: userData.username || null,
          avatarUrl: userData.avatarUrl || null,
          avatarColor: userData.avatarColor || null,
          phoneNumber: userData.phoneNumber || "",
          isExistingContact: status === "accepted",
          contactStatus: status,
        });
      }
    }

    logger.info(`matchPhoneContacts: matched ${matchedUsers.length} users from ${phoneNumbers.length} numbers for user ${userId}`);

    return { success: true, matches: matchedUsers };
  }
);

// ============================================================================
// BRAND ACCOUNTS
// ============================================================================

/**
 * Follow a brand. Adds clientId to user's followedBrands array
 * and creates a brandFollowers/{clientId}/followers/{userId} doc.
 */
export const followBrand = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "followBrand");

    const { clientId } = request.data;

    if (!clientId || typeof clientId !== "string") {
      throw new HttpsError("invalid-argument", "clientId is required");
    }

    // Verify client exists and is active
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (!clientDoc.exists || clientDoc.data()?.isActive !== true) {
      throw new HttpsError("not-found", "Brand not found");
    }

    const batch = db.batch();

    // Add to user's followedBrands array
    batch.update(db.collection("users").doc(userId), {
      followedBrands: admin.firestore.FieldValue.arrayUnion(clientId),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create follower document
    batch.set(
      db.collection("brandFollowers").doc(clientId).collection("followers").doc(userId),
      {
        userId,
        followedAt: admin.firestore.FieldValue.serverTimestamp(),
      }
    );

    // Increment follower count on client doc
    batch.update(db.collection("clients").doc(clientId), {
      followerCount: admin.firestore.FieldValue.increment(1),
    });

    await batch.commit();

    logger.info(`followBrand: user ${userId} followed brand ${clientId}`);
    return { success: true };
  }
);

/**
 * Unfollow a brand. Removes clientId from user's followedBrands array
 * and deletes the brandFollowers doc.
 */
export const unfollowBrand = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "unfollowBrand");

    const { clientId } = request.data;

    if (!clientId || typeof clientId !== "string") {
      throw new HttpsError("invalid-argument", "clientId is required");
    }

    const batch = db.batch();

    // Remove from user's followedBrands array
    batch.update(db.collection("users").doc(userId), {
      followedBrands: admin.firestore.FieldValue.arrayRemove(clientId),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Delete follower document
    batch.delete(
      db.collection("brandFollowers").doc(clientId).collection("followers").doc(userId)
    );

    // Decrement follower count on client doc
    batch.update(db.collection("clients").doc(clientId), {
      followerCount: admin.firestore.FieldValue.increment(-1),
    });

    await batch.commit();

    logger.info(`unfollowBrand: user ${userId} unfollowed brand ${clientId}`);
    return { success: true };
  }
);

/**
 * Get user's followed brands with full client profile data.
 */
export const getFollowedBrands = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getFollowedBrands");

    const userDoc = await db.collection("users").doc(userId).get();
    const followedBrandIds: string[] = userDoc.data()?.followedBrands || [];

    if (followedBrandIds.length === 0) {
      return { success: true, brands: [] };
    }

    // Fetch brand details in batches of 30
    const brands: Array<Record<string, unknown>> = [];
    const batchSize = 30;

    for (let i = 0; i < followedBrandIds.length; i += batchSize) {
      const batchIds = followedBrandIds.slice(i, i + batchSize);

      // Firestore __name__ whereIn for doc IDs
      const snap = await db
        .collection("clients")
        .where(admin.firestore.FieldPath.documentId(), "in", batchIds)
        .get();

      for (const doc of snap.docs) {
        const data = doc.data();
        if (data.isActive !== true || data.isDeleted === true) continue;

        brands.push({
          id: doc.id,
          name: data.displayName || data.companyName || "Brand",
          logoUrl: data.avatarImage || null,
          avatarColor: data.avatarColor || null,
          description: data.industry || null,
          isFollowed: true,
          followerCount: data.followerCount || 0,
        });
      }
    }

    return { success: true, brands };
  }
);

/**
 * Get available brands that support brand messaging.
 * Returns active clients with isBrandMessagingEnabled = true.
 */
export const getAvailableBrands = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getAvailableBrands");

    const userDoc = await db.collection("users").doc(userId).get();
    const followedBrandIds: string[] = userDoc.data()?.followedBrands || [];
    const followedSet = new Set(followedBrandIds);

    // Query active clients with brand messaging enabled
    const snap = await db
      .collection("clients")
      .where("isActive", "==", true)
      .where("isBrandMessagingEnabled", "==", true)
      .limit(50)
      .get();

    const brands: Array<Record<string, unknown>> = [];

    for (const doc of snap.docs) {
      const data = doc.data();
      if (data.isDeleted === true) continue;

      brands.push({
        id: doc.id,
        name: data.displayName || data.companyName || "Brand",
        logoUrl: data.avatarImage || null,
        avatarColor: data.avatarColor || null,
        description: data.industry || null,
        isFollowed: followedSet.has(doc.id),
        followerCount: data.followerCount || 0,
      });
    }

    return { success: true, brands };
  }
);

// ============================================================================
// PEOPLE YOU MAY KNOW
// ============================================================================

/**
 * Get suggested contacts the user may know.
 * Sources:
 *   1. Friends of friends (contacts of your contacts)
 *   2. Members of shared communities
 * Returns ranked list with reasons, respects privacy and blocks.
 */
export const getPeopleYouMayKnow = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getPeopleYouMayKnow");

    const userDoc = await db.collection("users").doc(userId).get();
    const userData = userDoc.data()!;
    const callerBlockedIds: string[] = userData.chat?.blockedUserIds || [];

    // Get caller's existing contact user IDs
    const contactsSnap = await db
      .collection("contacts")
      .where("userId", "==", userId)
      .get();
    const existingContactIds = new Set(
      contactsSnap.docs.map((d) => d.data().contactUserId as string)
    );
    existingContactIds.add(userId); // exclude self

    const suggestions: Map<string, {
      userId: string;
      displayName: string;
      username: string | null;
      avatarUrl: string | null;
      avatarColor: string | null;
      reason: string;
      source: string;
      score: number;
    }> = new Map();

    // Helper to check if a user should be excluded
    const shouldExclude = (uid: string): boolean => {
      return existingContactIds.has(uid) || callerBlockedIds.includes(uid);
    };

    // 1. Friends of friends — contacts of your contacts
    const myContactUserIds = contactsSnap.docs
      .filter((d) => d.data().status === "accepted")
      .map((d) => d.data().contactUserId as string)
      .slice(0, 20);

    for (const friendId of myContactUserIds) {
      const friendContactsSnap = await db
        .collection("contacts")
        .where("userId", "==", friendId)
        .where("status", "==", "accepted")
        .limit(20)
        .get();

      for (const fDoc of friendContactsSnap.docs) {
        const fData = fDoc.data();
        const suggestedId = fData.contactUserId as string;

        if (shouldExclude(suggestedId)) continue;
        if (suggestions.has(suggestedId)) {
          const existing = suggestions.get(suggestedId)!;
          existing.score += 1;
          const count = existing.score;
          existing.reason = `${count} mutual friends`;
          continue;
        }

        const suggestedDoc = await db.collection("users").doc(suggestedId).get();
        if (!suggestedDoc.exists) continue;
        const sData = suggestedDoc.data()!;

        const disc = sData.privacy?.discoverability || "everyone";
        if (disc === "nobody") continue;

        const sBlockedIds: string[] = sData.chat?.blockedUserIds || [];
        if (sBlockedIds.includes(userId)) continue;

        suggestions.set(suggestedId, {
          userId: suggestedId,
          displayName: sData.displayName || "User",
          username: sData.username || null,
          avatarUrl: sData.avatarUrl || null,
          avatarColor: sData.avatarColor || null,
          reason: "1 mutual friend",
          source: "mutualFriend",
          score: 1,
        });
      }

      if (suggestions.size >= 20) break;
    }

    // 2. Community members
    if (suggestions.size < 20) {
      const commSnap = await db
        .collection("communityMembers")
        .where("userId", "==", userId)
        .where("status", "==", "active")
        .limit(5)
        .get();

      for (const mem of commSnap.docs) {
        const communityId = mem.data().communityId as string;

        const commDoc = await db.collection("communities").doc(communityId).get();
        const commName = commDoc.data()?.name || "a community";

        const membersSnap = await db
          .collection("communityMembers")
          .where("communityId", "==", communityId)
          .where("status", "==", "active")
          .limit(20)
          .get();

        for (const mDoc of membersSnap.docs) {
          const memberId = mDoc.data().userId as string;
          if (shouldExclude(memberId)) continue;
          if (suggestions.has(memberId)) continue;

          const memberDoc = await db.collection("users").doc(memberId).get();
          if (!memberDoc.exists) continue;
          const mData = memberDoc.data()!;

          const disc = mData.privacy?.discoverability || "everyone";
          if (disc === "nobody") continue;

          const mBlockedIds: string[] = mData.chat?.blockedUserIds || [];
          if (mBlockedIds.includes(userId)) continue;

          suggestions.set(memberId, {
            userId: memberId,
            displayName: mData.displayName || "User",
            username: mData.username || null,
            avatarUrl: mData.avatarUrl || null,
            avatarColor: mData.avatarColor || null,
            reason: `Member of ${commName}`,
            source: "communityMember",
            score: 0,
          });

          if (suggestions.size >= 20) break;
        }
        if (suggestions.size >= 20) break;
      }
    }

    // Sort by score descending, remove score from output
    const sorted = Array.from(suggestions.values())
      .sort((a, b) => b.score - a.score)
      .slice(0, 20)
      .map((s) => ({
        userId: s.userId,
        displayName: s.displayName,
        username: s.username,
        avatarUrl: s.avatarUrl,
        avatarColor: s.avatarColor,
        reason: s.reason,
        source: s.source,
      }));

    logger.info(`getPeopleYouMayKnow: ${sorted.length} suggestions for user ${userId}`);

    return { success: true, suggestions: sorted };
  }
);

// ============================================================================
// PENDING INVITES (phone-based invite tracking)
// ============================================================================

/**
 * Record a pending invite when a user shares an invite link for a specific
 * phone contact. This enables auto-contact creation when the invitee registers.
 *
 * Collection: pendingInvites/{docId}
 *   inviterUserId, invitedPhoneNumber, referralCode?, status, createdAt, claimedAt?, claimedByUserId?
 */
export const recordPendingInvite = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "recordPendingInvite");

    const { phoneNumber, referralCode } = request.data;

    if (!phoneNumber || typeof phoneNumber !== "string") {
      throw new HttpsError("invalid-argument", "phoneNumber is required");
    }

    // Normalize phone number (strip spaces/dashes, ensure + prefix)
    let normalized = phoneNumber.replace(/[\s\-()]/g, "");
    if (normalized.startsWith("0") && normalized.length === 10) {
      normalized = "+27" + normalized.substring(1);
    }
    if (!normalized.startsWith("+")) {
      normalized = "+" + normalized;
    }

    // Prevent duplicate pending invites from same inviter for same phone
    const existing = await db
      .collection("pendingInvites")
      .where("inviterUserId", "==", userId)
      .where("invitedPhoneNumber", "==", normalized)
      .where("status", "==", "pending")
      .limit(1)
      .get();

    if (!existing.empty) {
      logger.info(`Duplicate pending invite skipped: ${userId} → ${normalized}`);
      return { success: true, alreadyExists: true };
    }

    await db.collection("pendingInvites").add({
      inviterUserId: userId,
      invitedPhoneNumber: normalized,
      referralCode: referralCode || null,
      status: "pending",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      claimedAt: null,
      claimedByUserId: null,
    });

    logger.info(`Recorded pending invite: ${userId} → ${normalized}`);
    return { success: true };
  }
);

/**
 * Auto-create paired contact documents for two users.
 * Used by referral signup flow and phone-based invite tracking.
 * Checks for existing relationship to avoid duplicates.
 */
export async function autoCreateContacts(
  userIdA: string,
  userIdB: string,
  initiatedBy: string = "system_referral"
): Promise<boolean> {
  // Check for existing relationship
  const existingSnap = await db
    .collection("contacts")
    .where("userId", "==", userIdA)
    .where("contactUserId", "==", userIdB)
    .limit(1)
    .get();

  if (!existingSnap.empty) {
    logger.info(`autoCreateContacts: relationship already exists between ${userIdA} and ${userIdB}`);
    return false;
  }

  // Fetch both user profiles
  const [userADoc, userBDoc] = await Promise.all([
    db.collection("users").doc(userIdA).get(),
    db.collection("users").doc(userIdB).get(),
  ]);

  const userAData = userADoc.exists ? userADoc.data()! : {};
  const userBData = userBDoc.exists ? userBDoc.data()! : {};

  const now = admin.firestore.FieldValue.serverTimestamp();
  const batch = db.batch();

  // A → B contact doc
  const refAB = db.collection("contacts").doc();
  batch.set(refAB, {
    userId: userIdA,
    contactUserId: userIdB,
    displayName: userBData.displayName || "User",
    username: userBData.username || null,
    avatarUrl: userBData.avatarUrl || null,
    avatarColor: userBData.avatarColor || null,
    phoneNumber: userBData.phoneNumber || null,
    status: "accepted",
    isFavorite: false,
    nickname: null,
    notes: null,
    initiatedBy,
    createdAt: now,
    lastInteractionAt: null,
  });

  // B → A contact doc
  const refBA = db.collection("contacts").doc();
  batch.set(refBA, {
    userId: userIdB,
    contactUserId: userIdA,
    displayName: userAData.displayName || "User",
    username: userAData.username || null,
    avatarUrl: userAData.avatarUrl || null,
    avatarColor: userAData.avatarColor || null,
    phoneNumber: userAData.phoneNumber || null,
    status: "accepted",
    isFavorite: false,
    nickname: null,
    notes: null,
    initiatedBy,
    createdAt: now,
    lastInteractionAt: null,
  });

  await batch.commit();
  logger.info(`autoCreateContacts: created mutual contact between ${userIdA} and ${userIdB}`);
  return true;
}
