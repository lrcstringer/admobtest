/**
 * Gift Test Fixtures
 *
 * Reusable gift documents and user profiles for testing
 * Gift Cloud Functions (gifts.ts).
 */

import { createTimestamp } from "../mocks/firestore.mock";

// ── Helper Functions ──────────────────────────────────────────────────────

const daysAgo = (days: number): Date => {
  const d = new Date();
  d.setDate(d.getDate() - days);
  return d;
};

const daysFromNow = (days: number): Date => {
  const d = new Date();
  d.setDate(d.getDate() + days);
  return d;
};

const hoursAgo = (hours: number): Date => {
  const d = new Date();
  d.setHours(d.getHours() - hours);
  return d;
};

// ── User Fixtures ─────────────────────────────────────────────────────────

export const sender = {
  id: "user_sender_001",
  displayName: "Gift Sender",
  email: "sender@test.com",
  avatarUrl: "https://example.com/avatar/sender.jpg",
  profilePicThumbUrl: null,
  fcmToken: "fcm_sender_001",
};

export const giftRecipient = {
  id: "user_gift_recipient_001",
  displayName: "Gift Recipient",
  email: "giftrecipient@test.com",
  avatarUrl: null,
  profilePicThumbUrl: "https://example.com/thumb/recipient.jpg",
  fcmToken: "fcm_gift_recipient_001",
};

export const noFcmRecipient = {
  id: "user_no_fcm_001",
  displayName: "No FCM User",
  email: "nofcm@test.com",
  avatarUrl: null,
  profilePicThumbUrl: null,
  fcmToken: null,
};

// ── Conversation Fixtures ─────────────────────────────────────────────────

/** Deterministic P2P conversation ID for sender ↔ giftRecipient */
const p2pConversationId = (() => {
  const sorted = [sender.id, giftRecipient.id].sort();
  return `p2p_${sorted[0]}_${sorted[1]}`;
})();

export const existingConversation = {
  participantIds: [sender.id, giftRecipient.id],
  participants: {
    [sender.id]: { displayName: sender.displayName, avatarUrl: sender.avatarUrl },
    [giftRecipient.id]: { displayName: giftRecipient.displayName, avatarUrl: giftRecipient.profilePicThumbUrl },
  },
  createdAt: createTimestamp(daysAgo(30)),
  updatedAt: createTimestamp(daysAgo(1)),
};

// ── Gift Document Fixtures ────────────────────────────────────────────────

/** Pending gift — freshly sent in P2P conversation */
export const pendingGift = {
  id: "gift_pending_001",
  senderId: sender.id,
  senderName: sender.displayName,
  recipientId: giftRecipient.id,
  recipientName: giftRecipient.displayName,
  amount: 500,
  conversationId: p2pConversationId,
  communityId: null,
  messageId: "msg_gift_pending_001",
  message: "Happy Birthday!",
  style: "birthday",
  status: "pending",
  createdAt: createTimestamp(daysAgo(1)),
  openedAt: null,
  claimedAt: null,
  expiresAt: createTimestamp(daysFromNow(6)),
  debitTransactionId: "j_debit_001",
  creditTransactionId: null,
  notificationSent: true,
  reminderSent: false,
};

/** Pending gift — sent within a community */
export const pendingCommunityGift = {
  ...pendingGift,
  id: "gift_community_001",
  conversationId: null,
  communityId: "community_001",
  messageId: "msg_gift_community_001",
  message: "Congrats on the promotion!",
  style: "professional",
};

/** Opened gift — recipient has opened it */
export const openedGift = {
  ...pendingGift,
  id: "gift_opened_001",
  status: "opened",
  messageId: "msg_gift_opened_001",
  openedAt: createTimestamp(hoursAgo(4)),
};

/** Claimed gift — fully claimed, credit transaction recorded */
export const claimedGift = {
  ...pendingGift,
  id: "gift_claimed_001",
  status: "claimed",
  messageId: "msg_gift_claimed_001",
  openedAt: createTimestamp(hoursAgo(6)),
  claimedAt: createTimestamp(hoursAgo(4)),
  creditTransactionId: "j_credit_001",
};

/** Expired gift — past expiresAt */
export const expiredGift = {
  ...pendingGift,
  id: "gift_expired_001",
  status: "expired",
  messageId: "msg_gift_expired_001",
  expiresAt: createTimestamp(daysAgo(1)),
};

/** Near-expiry gift — 1 day left, no reminder sent yet */
export const nearExpiryGift = {
  ...pendingGift,
  id: "gift_near_expiry_001",
  messageId: "msg_gift_near_expiry_001",
  expiresAt: createTimestamp(daysFromNow(1)),
  reminderSent: false,
};

/** Already reminded gift */
export const alreadyRemindedGift = {
  ...nearExpiryGift,
  id: "gift_already_reminded_001",
  messageId: "msg_gift_already_reminded_001",
  reminderSent: true,
};

// ── Factory Function ──────────────────────────────────────────────────────

export function createGiftFixture(
  overrides: Partial<typeof pendingGift>
): typeof pendingGift {
  return {
    ...pendingGift,
    id: `gift_custom_${Date.now()}`,
    ...overrides,
  };
}

/** Seed user docs for gift tests */
export function seedGiftUsers(
  setMockDoc: (collection: string, docId: string, data: unknown) => void
): void {
  setMockDoc("users", sender.id, sender);
  setMockDoc("users", giftRecipient.id, giftRecipient);
  setMockDoc("users", noFcmRecipient.id, noFcmRecipient);
}

export { p2pConversationId };
