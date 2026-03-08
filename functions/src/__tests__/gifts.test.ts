/**
 * Gifts Cloud Functions — Test Suite
 *
 * Comprehensive tests for all 5 Cloud Functions in gifts.ts:
 * - sendGift, openGift, claimGift, expireGifts, sendGiftExpiryReminders
 */

import { resetMocks, setMockDoc, mockBatch } from "./mocks/admin.mock";
import { createMockCallContext } from "./mocks/firestore.mock";
import {
  sender,
  giftRecipient,
  pendingGift,
  openedGift,
  claimedGift,
  expiredGift,
  nearExpiryGift,
  seedGiftUsers,
  p2pConversationId,
} from "./fixtures/giftFixtures";

// ── Mocks ────────────────────────────────────────────────────────────────

jest.mock("firebase-admin", () => require("./mocks/admin.mock").mockFirebaseAdmin);

const MockHttpsError = class HttpsError extends Error {
  constructor(
    public code: string,
    public message: string,
    public details?: unknown
  ) {
    super(message);
    this.name = "HttpsError";
  }
};

jest.mock("firebase-functions/v2/https", () => ({
  onCall: jest.fn((...args: unknown[]) => {
    const handler = typeof args[0] === "function" ? args[0] : args[1];
    return (data: unknown, context: unknown) =>
      (handler as Function)({ data, ...(context as object) });
  }),
  HttpsError: MockHttpsError,
}));

jest.mock("firebase-functions/v2/scheduler", () => ({
  onSchedule: jest.fn((...args: unknown[]) => {
    const handler = args.length === 2 ? args[1] : args[0];
    return handler;
  }),
}));

jest.mock("firebase-functions/v2", () => ({
  logger: {
    log: jest.fn(),
    info: jest.fn(),
    warn: jest.fn(),
    error: jest.fn(),
    debug: jest.fn(),
  },
}));

// Ledger mocks
const mockValidateMainWalletBalance = jest.fn().mockResolvedValue({
  available: 10000,
  sufficient: true,
});

jest.mock("../ledger", () => ({
  validateMainWalletBalance: (...args: unknown[]) => mockValidateMainWalletBalance(...args),
}));

const mockProcessGiftDebit = jest.fn().mockResolvedValue("j_debit_test");
const mockProcessGiftCredit = jest.fn().mockResolvedValue("j_credit_test");
const mockProcessGiftRefund = jest.fn().mockResolvedValue("j_refund_test");

jest.mock("../ledger/giftSprayEscrow", () => ({
  processGiftDebit: (...args: unknown[]) => mockProcessGiftDebit(...args),
  processGiftCredit: (...args: unknown[]) => mockProcessGiftCredit(...args),
  processGiftRefund: (...args: unknown[]) => mockProcessGiftRefund(...args),
}));

const mockRequireAppCheck = jest.fn();
const mockRequirePlayIntegrity = jest.fn().mockResolvedValue(undefined);

jest.mock("../security", () => ({
  requireAppCheck: (...args: unknown[]) => mockRequireAppCheck(...args),
  requirePlayIntegrity: (...args: unknown[]) => mockRequirePlayIntegrity(...args),
}));

// ── Import module under test ──────────────────────────────────────────────

import {
  sendGift as _sendGift,
  openGift as _openGift,
  claimGift as _claimGift,
  expireGifts as _expireGifts,
  sendGiftExpiryReminders as _sendGiftExpiryReminders,
} from "../gifts";

// Cast onCall functions to callable types
type CallableFn = (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;
const sendGift = _sendGift as unknown as CallableFn;
const openGift = _openGift as unknown as CallableFn;
const claimGift = _claimGift as unknown as CallableFn;

// Cast onSchedule functions
const expireGifts = _expireGifts as unknown as (event?: unknown) => Promise<void>;
const sendGiftExpiryReminders = _sendGiftExpiryReminders as unknown as (event?: unknown) => Promise<void>;

// ── Helpers ───────────────────────────────────────────────────────────────

const authContext = (uid: string) => createMockCallContext({ uid, appCheckToken: true });
const unauthContext = createMockCallContext(null);
const senderCtx = authContext(sender.id);
const recipientCtx = authContext(giftRecipient.id);

function seedUsers(): void {
  seedGiftUsers(setMockDoc);
}

function seedGift(giftId: string, giftData: Record<string, unknown>): void {
  setMockDoc("gifts", giftId, giftData);
}

// ── Tests ─────────────────────────────────────────────────────────────────

describe("sendGift", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  // --- Auth ---
  it("throws unauthenticated when not logged in", async () => {
    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 100,
        message: "Test",
        style: "celebration",
      }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("calls requireAppCheck", async () => {
    await sendGift({
      recipientId: giftRecipient.id,
      amount: 100,
      message: "Test gift",
      style: "celebration",
    }, senderCtx).catch(() => {});

    expect(mockRequireAppCheck).toHaveBeenCalled();
  });

  // --- Input validation ---
  it("throws if recipientId is missing", async () => {
    await expect(
      sendGift({ amount: 100, message: "Test", style: "celebration" }, senderCtx)
    ).rejects.toThrow("recipientId is required");
  });

  it("throws if amount is not an integer", async () => {
    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 10.5,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("amount must be an integer");
  });

  it("throws if amount is below minimum (10)", async () => {
    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 5,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("Minimum gift is 10 tokens");
  });

  it("throws if amount exceeds maximum (100000)", async () => {
    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 200000,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("Maximum gift is 100000 tokens");
  });

  it("throws if message is missing or empty", async () => {
    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 100,
        message: "  ",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("Gift message is required");
  });

  it("throws if style is invalid", async () => {
    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 100,
        message: "Test",
        style: "invalid_style",
      }, senderCtx)
    ).rejects.toThrow("Invalid style");
  });

  it("throws if sending to yourself", async () => {
    await expect(
      sendGift({
        recipientId: sender.id,
        amount: 100,
        message: "Self",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("Cannot send a gift to yourself");
  });

  it("throws if recipient does not exist", async () => {
    await expect(
      sendGift({
        recipientId: "nonexistent_user",
        amount: 100,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("not found");
  });

  // --- Balance ---
  it("throws if sender has insufficient balance", async () => {
    mockValidateMainWalletBalance.mockResolvedValueOnce({
      available: 50,
      sufficient: false,
    });

    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 100,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("Insufficient balance");
  });

  // --- Success cases ---
  it("creates P2P conversation and gift on success", async () => {
    // Seed a conversation to be found (parent doc)
    setMockDoc("conversations", p2pConversationId, { participantIds: [sender.id, giftRecipient.id] });

    const result = await sendGift({
      recipientId: giftRecipient.id,
      amount: 100,
      message: "Happy Birthday!",
      style: "birthday",
    }, senderCtx);

    expect(result).toBeDefined();
    expect(result.senderId).toBe(sender.id);
    expect(result.recipientId).toBe(giftRecipient.id);
    expect(result.amount).toBe(100);
    expect(result.style).toBe("birthday");
    expect(result.status).toBe("pending");
    expect(result.message).toBe("Happy Birthday!");
    expect(result.debitTransactionId).toBe("j_debit_test");
    expect(result.creditTransactionId).toBeNull();
  });

  it("creates gift in existing conversation", async () => {
    const convId = "conv_existing_123";
    setMockDoc("conversations", convId, { participantIds: [sender.id, giftRecipient.id] });

    const result = await sendGift({
      recipientId: giftRecipient.id,
      amount: 200,
      message: "Congrats!",
      style: "celebration",
      conversationId: convId,
    }, senderCtx);

    expect(result.conversationId).toBe(convId);
    expect(result.amount).toBe(200);
  });

  it("creates gift in community", async () => {
    const communityId = "community_123";
    setMockDoc("communities", communityId, { memberIds: [sender.id, giftRecipient.id] });

    const result = await sendGift({
      recipientId: giftRecipient.id,
      amount: 50,
      message: "Welcome!",
      style: "love",
      communityId,
    }, senderCtx);

    expect(result.communityId).toBe(communityId);
    expect(result.conversationId).toBeNull();
  });

  it("calls processGiftDebit with correct args", async () => {
    setMockDoc("conversations", p2pConversationId, { participantIds: [sender.id, giftRecipient.id] });

    await sendGift({
      recipientId: giftRecipient.id,
      amount: 500,
      message: "Test debit",
      style: "professional",
    }, senderCtx);

    expect(mockProcessGiftDebit).toHaveBeenCalledWith(
      sender.id,
      500,
      expect.any(String), // generated giftId
      expect.stringContaining(giftRecipient.displayName),
    );
  });

  it("truncates message to 100 characters", async () => {
    setMockDoc("conversations", p2pConversationId, { participantIds: [sender.id, giftRecipient.id] });

    const longMessage = "a".repeat(200);
    const result = await sendGift({
      recipientId: giftRecipient.id,
      amount: 100,
      message: longMessage,
      style: "celebration",
    }, senderCtx);

    expect(result.message).toHaveLength(100);
  });

  it("refunds on batch write failure", async () => {
    setMockDoc("conversations", p2pConversationId, { participantIds: [sender.id, giftRecipient.id] });
    mockBatch.commit.mockRejectedValueOnce(new Error("Batch write failed"));

    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 100,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("Your tokens have been refunded");

    expect(mockProcessGiftRefund).toHaveBeenCalled();
  });

  it("throws CRITICAL if batch fails AND refund fails", async () => {
    setMockDoc("conversations", p2pConversationId, { participantIds: [sender.id, giftRecipient.id] });
    mockBatch.commit.mockRejectedValueOnce(new Error("Batch write failed"));
    mockProcessGiftRefund.mockRejectedValueOnce(new Error("Refund failed"));

    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 100,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("manual recovery");
  });

  it("throws if debit fails with insufficient balance", async () => {
    setMockDoc("conversations", p2pConversationId, { participantIds: [sender.id, giftRecipient.id] });
    mockProcessGiftDebit.mockRejectedValueOnce(new Error("INSUFFICIENT_BALANCE"));

    await expect(
      sendGift({
        recipientId: giftRecipient.id,
        amount: 100,
        message: "Test",
        style: "celebration",
      }, senderCtx)
    ).rejects.toThrow("Insufficient balance");
  });

  it("accepts all 5 valid styles", async () => {
    const styles = ["ndlovukazi", "celebration", "love", "birthday", "professional"];
    for (const s of styles) {
      jest.clearAllMocks();
      resetMocks();
      seedUsers();
      setMockDoc("conversations", p2pConversationId, { participantIds: [sender.id, giftRecipient.id] });

      const result = await sendGift({
        recipientId: giftRecipient.id,
        amount: 10,
        message: "Test",
        style: s,
      }, senderCtx);

      expect(result.style).toBe(s);
    }
  });
});

// ── openGift ──────────────────────────────────────────────────────────────

describe("openGift", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  it("throws unauthenticated when not logged in", async () => {
    await expect(
      openGift({ giftId: pendingGift.id }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("calls requireAppCheck", async () => {
    seedGift(pendingGift.id, pendingGift);
    await openGift({ giftId: pendingGift.id }, recipientCtx).catch(() => {});
    expect(mockRequireAppCheck).toHaveBeenCalled();
  });

  it("throws if giftId is missing", async () => {
    await expect(
      openGift({}, recipientCtx)
    ).rejects.toThrow("giftId is required");
  });

  it("throws if gift does not exist", async () => {
    await expect(
      openGift({ giftId: "nonexistent_gift" }, recipientCtx)
    ).rejects.toThrow("Gift not found");
  });

  it("throws permission-denied for non-recipient", async () => {
    seedGift(pendingGift.id, pendingGift);

    await expect(
      openGift({ giftId: pendingGift.id }, senderCtx)
    ).rejects.toThrow("Only the recipient can open");
  });

  it("returns idempotently if already opened", async () => {
    seedGift(openedGift.id, openedGift);

    const result = await openGift({ giftId: openedGift.id }, recipientCtx);
    expect(result.status).toBe("opened");
  });

  it("returns idempotently if already claimed", async () => {
    seedGift(claimedGift.id, claimedGift);

    const result = await openGift({ giftId: claimedGift.id }, recipientCtx);
    expect(result).toBeDefined();
  });

  it("throws if gift is expired", async () => {
    seedGift(expiredGift.id, { ...expiredGift, status: "pending" });

    await expect(
      openGift({ giftId: expiredGift.id }, recipientCtx)
    ).rejects.toThrow("expired");
  });

  it("marks gift as opened on success", async () => {
    seedGift(pendingGift.id, pendingGift);
    // Seed message parent for message embed update
    setMockDoc("conversations", pendingGift.conversationId!, {});

    const result = await openGift({ giftId: pendingGift.id }, recipientCtx);
    expect(result.status).toBe("opened");
  });
});

// ── claimGift ─────────────────────────────────────────────────────────────

describe("claimGift", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  it("throws unauthenticated when not logged in", async () => {
    await expect(
      claimGift({ giftId: openedGift.id }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("calls requireAppCheck", async () => {
    seedGift(openedGift.id, openedGift);
    await claimGift({ giftId: openedGift.id }, recipientCtx).catch(() => {});
    expect(mockRequireAppCheck).toHaveBeenCalled();
  });

  it("calls requirePlayIntegrity (advisory mode)", async () => {
    seedGift(openedGift.id, openedGift);
    setMockDoc("conversations", openedGift.conversationId!, {});
    await claimGift({ giftId: openedGift.id }, recipientCtx).catch(() => {});
    expect(mockRequirePlayIntegrity).toHaveBeenCalled();
  });

  it("throws if giftId is missing", async () => {
    await expect(
      claimGift({}, recipientCtx)
    ).rejects.toThrow("giftId is required");
  });

  it("throws if gift does not exist", async () => {
    await expect(
      claimGift({ giftId: "nonexistent_gift" }, recipientCtx)
    ).rejects.toThrow("Gift not found");
  });

  it("throws permission-denied for non-recipient", async () => {
    seedGift(openedGift.id, openedGift);

    await expect(
      claimGift({ giftId: openedGift.id }, senderCtx)
    ).rejects.toThrow("Only the recipient can claim");
  });

  it("throws if gift is pending (must open first)", async () => {
    seedGift(pendingGift.id, pendingGift);

    await expect(
      claimGift({ giftId: pendingGift.id }, recipientCtx)
    ).rejects.toThrow("cannot be claimed");
  });

  it("returns idempotently if already claimed", async () => {
    seedGift(claimedGift.id, claimedGift);

    const result = await claimGift({ giftId: claimedGift.id }, recipientCtx);
    expect(result.status).toBe("claimed");
  });

  it("throws if gift is expired", async () => {
    seedGift(expiredGift.id, { ...expiredGift, status: "opened" });

    await expect(
      claimGift({ giftId: expiredGift.id }, recipientCtx)
    ).rejects.toThrow("expired");
  });

  it("marks as claimed and calls processGiftCredit on success", async () => {
    seedGift(openedGift.id, openedGift);
    setMockDoc("conversations", openedGift.conversationId!, {});

    const result = await claimGift({ giftId: openedGift.id }, recipientCtx);

    expect(result.status).toBe("claimed");
    expect(mockProcessGiftCredit).toHaveBeenCalledWith(
      giftRecipient.id,
      openedGift.amount,
      openedGift.id,
      expect.stringContaining(openedGift.senderName),
    );
  });

  it("rolls back to opened if credit fails", async () => {
    seedGift(openedGift.id, openedGift);
    setMockDoc("conversations", openedGift.conversationId!, {});
    mockProcessGiftCredit.mockRejectedValueOnce(new Error("Credit failed"));

    await expect(
      claimGift({ giftId: openedGift.id }, recipientCtx)
    ).rejects.toThrow("Failed to transfer tokens");
  });

  it("logs error and throws when credit fails (rollback succeeds)", async () => {
    const { logger } = require("firebase-functions/v2");
    seedGift(openedGift.id, openedGift);
    setMockDoc("conversations", openedGift.conversationId!, {});
    mockProcessGiftCredit.mockRejectedValueOnce(new Error("Credit failed"));

    await expect(
      claimGift({ giftId: openedGift.id }, recipientCtx)
    ).rejects.toThrow("Failed to transfer tokens");

    // Verifies the initial error is logged before rollback
    expect(logger.error).toHaveBeenCalledWith(
      expect.stringContaining("credit failed"),
      expect.anything(),
    );
  });
});

// ── expireGifts ───────────────────────────────────────────────────────────

describe("expireGifts", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  it("returns early when no expired gifts exist", async () => {
    const { logger } = require("firebase-functions/v2");
    await expireGifts();
    expect(logger.info).toHaveBeenCalledWith(expect.stringContaining("No gifts to expire"));
  });

  it("expires a pending gift and refunds sender", async () => {
    // Seed an expired pending gift
    seedGift(expiredGift.id, { ...expiredGift, status: "pending" });
    setMockDoc("conversations", expiredGift.conversationId!, {});

    await expireGifts();

    expect(mockProcessGiftRefund).toHaveBeenCalledWith(
      expiredGift.senderId,
      expiredGift.amount,
      expiredGift.id,
      expect.any(String),
    );
  });

  it("expires an opened gift and refunds sender", async () => {
    seedGift(expiredGift.id, { ...expiredGift, status: "opened" });
    setMockDoc("conversations", expiredGift.conversationId!, {});

    await expireGifts();

    expect(mockProcessGiftRefund).toHaveBeenCalled();
  });

  it("reverts status if refund fails", async () => {
    seedGift(expiredGift.id, { ...expiredGift, status: "pending" });
    setMockDoc("conversations", expiredGift.conversationId!, {});
    mockProcessGiftRefund.mockRejectedValueOnce(new Error("Refund failed"));

    await expireGifts();

    const { logger } = require("firebase-functions/v2");
    expect(logger.error).toHaveBeenCalledWith(
      expect.stringContaining("Refund failed"),
      expect.anything(),
    );
  });
});

// ── sendGiftExpiryReminders ──────────────────────────────────────────────

describe("sendGiftExpiryReminders", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  it("returns early when no reminders needed", async () => {
    const { logger } = require("firebase-functions/v2");
    await sendGiftExpiryReminders();
    expect(logger.info).toHaveBeenCalledWith(expect.stringContaining("No gift expiry reminders"));
  });

  it("sends reminder and marks reminderSent=true", async () => {
    seedGift(nearExpiryGift.id, nearExpiryGift);

    await sendGiftExpiryReminders();

    // Batch commit should have been called
    expect(mockBatch.commit).toHaveBeenCalled();
  });
});
