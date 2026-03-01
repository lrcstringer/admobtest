/**
 * Token Pool Test Fixtures
 *
 * Reusable pool documents and user profiles for testing
 * Collection Room Cloud Functions (tokenPools.ts).
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

export const organizer = {
  id: "user_organizer_001",
  displayName: "Pool Organizer",
  email: "organizer@test.com",
  avatarUrl: "https://example.com/avatar/organizer.jpg",
  profilePicThumbUrl: null,
  fcmToken: "fcm_organizer_001",
};

export const recipient = {
  id: "user_recipient_001",
  displayName: "Gift Recipient",
  email: "recipient@test.com",
  avatarUrl: "https://example.com/avatar/recipient.jpg",
  profilePicThumbUrl: null,
  fcmToken: "fcm_recipient_001",
};

export const invitee1 = {
  id: "user_invitee_001",
  displayName: "Invitee One",
  email: "invitee1@test.com",
  avatarUrl: null,
  profilePicThumbUrl: "https://example.com/thumb/invitee1.jpg",
  fcmToken: "fcm_invitee_001",
};

export const invitee2 = {
  id: "user_invitee_002",
  displayName: "Invitee Two",
  email: "invitee2@test.com",
  avatarUrl: null,
  profilePicThumbUrl: null,
  fcmToken: "fcm_invitee_002",
};

export const invitee3 = {
  id: "user_invitee_003",
  displayName: "Invitee Three",
  email: "invitee3@test.com",
  avatarUrl: null,
  profilePicThumbUrl: null,
  fcmToken: null, // No FCM token
};

// ── Pool Document Fixtures ────────────────────────────────────────────────

/** Sasaza pool in "collecting" status with contributions */
export const collectingSasazaPool = {
  id: "pool_sasaza_collecting_001",
  mode: "sasaza",
  status: "collecting",
  organizerId: organizer.id,
  organizerName: organizer.displayName,
  recipientId: recipient.id,
  recipientName: recipient.displayName,
  conversationId: "collection_pool_sasaza_collecting_001",
  title: "Birthday Gift for Recipient",
  message: "Happy Birthday!",
  style: "celebration",
  totalAmount: 500,
  contributionCount: 3,
  contributorCount: 2,
  contributions: {
    [organizer.id]: {
      userId: organizer.id,
      displayName: organizer.displayName,
      totalAmount: 300,
      contributionCount: 2,
      anonymous: false,
      lastContributedAt: createTimestamp(hoursAgo(2)),
    },
    [invitee1.id]: {
      userId: invitee1.id,
      displayName: invitee1.displayName,
      totalAmount: 200,
      contributionCount: 1,
      anonymous: false,
      lastContributedAt: createTimestamp(hoursAgo(1)),
    },
  },
  payouts: [],
  giftMessageId: null,
  giftConversationId: null,
  inviteeIds: [invitee1.id, invitee2.id],
  expiresAt: createTimestamp(daysFromNow(25)),
  createdAt: createTimestamp(daysAgo(5)),
  updatedAt: createTimestamp(hoursAgo(1)),
  sentAt: null,
  openedAt: null,
  completedAt: null,
  cancelledAt: null,
  groupAccountId: "group:pool_sasaza_collecting_001",
  reminderSent: false,
};

/** Sasaza pool in "collecting" with ZERO contributions */
export const emptyCollectingSasazaPool = {
  ...collectingSasazaPool,
  id: "pool_sasaza_empty_001",
  conversationId: "collection_pool_sasaza_empty_001",
  totalAmount: 0,
  contributionCount: 0,
  contributorCount: 0,
  contributions: {},
  groupAccountId: "group:pool_sasaza_empty_001",
};

/** Save pool in "collecting" with contributions (one anonymous) */
export const collectingSavePool = {
  id: "pool_save_collecting_001",
  mode: "save",
  status: "collecting",
  organizerId: organizer.id,
  organizerName: organizer.displayName,
  recipientId: null,
  recipientName: null,
  conversationId: "collection_pool_save_collecting_001",
  title: "Holiday Savings",
  message: "",
  style: "professional",
  totalAmount: 1000,
  contributionCount: 3,
  contributorCount: 3,
  contributions: {
    [organizer.id]: {
      userId: organizer.id,
      displayName: organizer.displayName,
      totalAmount: 400,
      contributionCount: 1,
      anonymous: false,
      lastContributedAt: createTimestamp(hoursAgo(4)),
    },
    [invitee1.id]: {
      userId: invitee1.id,
      displayName: invitee1.displayName,
      totalAmount: 300,
      contributionCount: 1,
      anonymous: false,
      lastContributedAt: createTimestamp(hoursAgo(3)),
    },
    [invitee2.id]: {
      userId: invitee2.id,
      displayName: invitee2.displayName,
      totalAmount: 300,
      contributionCount: 1,
      anonymous: true,
      lastContributedAt: createTimestamp(hoursAgo(2)),
    },
  },
  payouts: [],
  giftMessageId: null,
  giftConversationId: null,
  inviteeIds: [invitee1.id, invitee2.id],
  expiresAt: null,
  createdAt: createTimestamp(daysAgo(10)),
  updatedAt: createTimestamp(hoursAgo(2)),
  sentAt: null,
  openedAt: null,
  completedAt: null,
  cancelledAt: null,
  groupAccountId: "group:pool_save_collecting_001",
  reminderSent: false,
};

/** Sasaza pool in "sent" status (gift sent, awaiting open/claim) */
export const sentSasazaPool = {
  id: "pool_sasaza_sent_001",
  mode: "sasaza",
  status: "sent",
  organizerId: organizer.id,
  organizerName: organizer.displayName,
  recipientId: recipient.id,
  recipientName: recipient.displayName,
  conversationId: "collection_pool_sasaza_sent_001",
  title: "Birthday Gift",
  message: "Enjoy!",
  style: "celebration",
  totalAmount: 500,
  contributionCount: 2,
  contributorCount: 2,
  contributions: {
    [organizer.id]: {
      userId: organizer.id,
      displayName: organizer.displayName,
      totalAmount: 300,
      contributionCount: 1,
      anonymous: false,
    },
    [invitee1.id]: {
      userId: invitee1.id,
      displayName: invitee1.displayName,
      totalAmount: 200,
      contributionCount: 1,
      anonymous: false,
    },
  },
  payouts: [],
  giftMessageId: "msg_gift_001",
  giftConversationId: "p2p_user_organizer_001_user_recipient_001",
  inviteeIds: [invitee1.id, invitee2.id],
  expiresAt: createTimestamp(daysFromNow(5)),
  createdAt: createTimestamp(daysAgo(10)),
  updatedAt: createTimestamp(daysAgo(2)),
  sentAt: createTimestamp(daysAgo(2)),
  openedAt: null,
  completedAt: null,
  cancelledAt: null,
  groupAccountId: "group:pool_sasaza_sent_001",
  reminderSent: false,
};

/** Sasaza pool — sent + opened (awaiting claim) */
export const openedSasazaPool = {
  ...sentSasazaPool,
  id: "pool_sasaza_opened_001",
  conversationId: "collection_pool_sasaza_opened_001",
  openedAt: createTimestamp(daysAgo(1)),
  groupAccountId: "group:pool_sasaza_opened_001",
};

/** Completed sasaza pool */
export const completedSasazaPool = {
  ...sentSasazaPool,
  id: "pool_sasaza_completed_001",
  status: "completed",
  conversationId: "collection_pool_sasaza_completed_001",
  openedAt: createTimestamp(daysAgo(1)),
  completedAt: createTimestamp(hoursAgo(6)),
  groupAccountId: "group:pool_sasaza_completed_001",
};

/** Cancelled pool */
export const cancelledPool = {
  ...collectingSasazaPool,
  id: "pool_cancelled_001",
  status: "cancelled",
  conversationId: "collection_pool_cancelled_001",
  cancelledAt: createTimestamp(hoursAgo(12)),
  groupAccountId: "group:pool_cancelled_001",
};

/** Expired pool */
export const expiredPool = {
  ...collectingSasazaPool,
  id: "pool_expired_001",
  status: "expired",
  conversationId: "collection_pool_expired_001",
  expiresAt: createTimestamp(daysAgo(1)),
  groupAccountId: "group:pool_expired_001",
};

/** Near-expiry pool (2 days left, reminderSent=false) */
export const nearExpirySasazaPool = {
  ...collectingSasazaPool,
  id: "pool_near_expiry_001",
  conversationId: "collection_pool_near_expiry_001",
  expiresAt: createTimestamp(daysFromNow(2)),
  reminderSent: false,
  groupAccountId: "group:pool_near_expiry_001",
};

/** Pool already reminded */
export const alreadyRemindedPool = {
  ...nearExpirySasazaPool,
  id: "pool_already_reminded_001",
  conversationId: "collection_pool_already_reminded_001",
  reminderSent: true,
  groupAccountId: "group:pool_already_reminded_001",
};

// ── Factory Function ──────────────────────────────────────────────────────

export function createPoolFixture(
  overrides: Partial<typeof collectingSasazaPool>
): typeof collectingSasazaPool {
  return {
    ...collectingSasazaPool,
    id: `pool_custom_${Date.now()}`,
    ...overrides,
  };
}

/** Seed user docs for pool tests */
export function seedPoolUsers(
  setMockDoc: (collection: string, docId: string, data: unknown) => void
): void {
  setMockDoc("users", organizer.id, organizer);
  setMockDoc("users", recipient.id, recipient);
  setMockDoc("users", invitee1.id, invitee1);
  setMockDoc("users", invitee2.id, invitee2);
  setMockDoc("users", invitee3.id, invitee3);
}
