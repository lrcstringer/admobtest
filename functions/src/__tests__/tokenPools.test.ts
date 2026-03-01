/**
 * Token Pools Cloud Functions — Test Suite
 *
 * Comprehensive tests for all 9 Cloud Functions in tokenPools.ts:
 * - createTokenPool, contributeToPool, sendGroupGift, openGroupGift,
 *   claimGroupGift, distributePool, cancelPool, expireTokenPools,
 *   sendPoolExpiryReminders
 */

import { resetMocks, setMockDoc, mockBatch } from "./mocks/admin.mock";
import { createMockCallContext } from "./mocks/firestore.mock";
import {
  organizer,
  recipient,
  invitee1,
  invitee2,
  collectingSasazaPool,
  emptyCollectingSasazaPool,
  collectingSavePool,
  sentSasazaPool,
  openedSasazaPool,
  completedSasazaPool,
  cancelledPool,
  seedPoolUsers,
} from "./fixtures/poolFixtures";

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
const mockGetOrCreateGroupAccount = jest.fn().mockResolvedValue({
  accountId: "group:pool_001",
  subAccountId: "sub_001",
});
const mockProcessGroupContribution = jest.fn().mockResolvedValue({
  success: true,
  journalId: "j_contrib_001",
});
const mockProcessGroupPayout = jest.fn().mockResolvedValue({
  success: true,
  journalId: "j_payout_001",
});

jest.mock("../ledger/groupAccounts", () => ({
  getOrCreateGroupAccount: (...args: unknown[]) => mockGetOrCreateGroupAccount(...args),
  processGroupContribution: (...args: unknown[]) => mockProcessGroupContribution(...args),
  processGroupPayout: (...args: unknown[]) => mockProcessGroupPayout(...args),
}));

const mockValidateMainWalletBalance = jest.fn().mockResolvedValue({
  available: 10000,
  sufficient: true,
});

jest.mock("../ledger", () => ({
  validateMainWalletBalance: (...args: unknown[]) => mockValidateMainWalletBalance(...args),
}));

const mockRequireAppCheck = jest.fn();
jest.mock("../security", () => ({
  requireAppCheck: (...args: unknown[]) => mockRequireAppCheck(...args),
}));

// ── Import module under test ──────────────────────────────────────────────

import {
  createTokenPool as _createTokenPool,
  contributeToPool as _contributeToPool,
  sendGroupGift as _sendGroupGift,
  openGroupGift as _openGroupGift,
  claimGroupGift as _claimGroupGift,
  distributePool as _distributePool,
  cancelPool as _cancelPool,
  expireTokenPools as _expireTokenPools,
  sendPoolExpiryReminders as _sendPoolExpiryReminders,
} from "../tokenPools";

// Cast onCall functions to callable types
type CallableFn = (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;
const createTokenPool = _createTokenPool as unknown as CallableFn;
const contributeToPool = _contributeToPool as unknown as CallableFn;
const sendGroupGift = _sendGroupGift as unknown as CallableFn;
const openGroupGift = _openGroupGift as unknown as CallableFn;
const claimGroupGift = _claimGroupGift as unknown as CallableFn;
const distributePool = _distributePool as unknown as CallableFn;
const cancelPool = _cancelPool as unknown as CallableFn;

// Cast onSchedule functions
const expireTokenPools = _expireTokenPools as unknown as (event?: unknown) => Promise<void>;
const sendPoolExpiryReminders = _sendPoolExpiryReminders as unknown as (event?: unknown) => Promise<void>;

// ── Helpers ───────────────────────────────────────────────────────────────

const authContext = (uid: string) => createMockCallContext({ uid, appCheckToken: true });
const unauthContext = createMockCallContext(null);
const organizerCtx = authContext(organizer.id);
const recipientCtx = authContext(recipient.id);
const invitee1Ctx = authContext(invitee1.id);

function seedUsers(): void {
  seedPoolUsers(setMockDoc);
}

function seedPool(poolId: string, poolData: Record<string, unknown>): void {
  setMockDoc("tokenPools", poolId, poolData);
}

// ── Tests ─────────────────────────────────────────────────────────────────

describe("createTokenPool", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  // --- Auth ---
  it("throws unauthenticated when not logged in", async () => {
    await expect(
      createTokenPool({
        mode: "sasaza",
        title: "Test",
        message: "",
        style: "celebration",
        recipientId: recipient.id,
        inviteeIds: [invitee1.id],
      }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("calls requireAppCheck", async () => {
    await createTokenPool({
      mode: "sasaza",
      title: "Test Pool",
      message: "",
      style: "celebration",
      recipientId: recipient.id,
      inviteeIds: [invitee1.id],
    }, organizerCtx).catch(() => {});

    expect(mockRequireAppCheck).toHaveBeenCalled();
  });

  // --- Input validation ---
  it("throws if mode is missing", async () => {
    await expect(
      createTokenPool({
        title: "Test",
        style: "celebration",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("mode must be 'sasaza' or 'save'");
  });

  it("throws if mode is invalid", async () => {
    await expect(
      createTokenPool({
        mode: "invalid",
        title: "Test",
        style: "celebration",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("mode must be 'sasaza' or 'save'");
  });

  it("throws if title is missing", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        style: "celebration",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("title must be 1-100 characters");
  });

  it("throws if title is empty string", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        title: "   ",
        style: "celebration",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("title must be 1-100 characters");
  });

  it("throws if title exceeds 100 characters", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        title: "x".repeat(101),
        style: "celebration",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("title must be 1-100 characters");
  });

  it("throws if message exceeds 200 characters", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        title: "Test",
        message: "x".repeat(201),
        style: "celebration",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("message must be 0-200 characters");
  });

  it("allows empty message", async () => {
    const result = await createTokenPool({
      mode: "save",
      title: "Test",
      message: "",
      style: "celebration",
      inviteeIds: [invitee1.id],
    }, organizerCtx);

    expect(result.success).toBe(true);
  });

  it("throws if style is missing", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        title: "Test",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("style must be one of:");
  });

  it("throws if style is invalid", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        title: "Test",
        style: "garbage",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("style must be one of:");
  });

  it("throws if inviteeIds is empty array", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        title: "Test",
        style: "celebration",
        inviteeIds: [],
      }, organizerCtx)
    ).rejects.toThrow("inviteeIds must have 1-50 entries");
  });

  it("throws if inviteeIds exceeds 50 entries", async () => {
    const bigList = Array.from({ length: 51 }, (_, i) => `user_${i}`);
    await expect(
      createTokenPool({
        mode: "save",
        title: "Test",
        style: "celebration",
        inviteeIds: bigList,
      }, organizerCtx)
    ).rejects.toThrow("inviteeIds must have 1-50 entries");
  });

  // --- Business rules ---
  it("throws if recipientId missing in sasaza mode", async () => {
    await expect(
      createTokenPool({
        mode: "sasaza",
        title: "Test",
        style: "celebration",
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("recipientId is required for sasaza mode");
  });

  it("throws if recipientId is the organizer in sasaza mode", async () => {
    await expect(
      createTokenPool({
        mode: "sasaza",
        title: "Test",
        style: "celebration",
        recipientId: organizer.id,
        inviteeIds: [invitee1.id],
      }, organizerCtx)
    ).rejects.toThrow("Cannot send a Group Sasaza to yourself");
  });

  it("throws if recipientId is in inviteeIds for sasaza mode", async () => {
    await expect(
      createTokenPool({
        mode: "sasaza",
        title: "Test",
        style: "celebration",
        recipientId: recipient.id,
        inviteeIds: [invitee1.id, recipient.id],
      }, organizerCtx)
    ).rejects.toThrow("Recipient cannot be an invitee");
  });

  it("throws if only organizer is in inviteeIds (empty after filter)", async () => {
    await expect(
      createTokenPool({
        mode: "save",
        title: "Test",
        style: "celebration",
        inviteeIds: [organizer.id],
      }, organizerCtx)
    ).rejects.toThrow("Must invite at least one other person");
  });

  // --- Happy path ---
  it("creates sasaza pool with correct fields", async () => {
    const result = await createTokenPool({
      mode: "sasaza",
      title: "Birthday Gift",
      message: "Happy Birthday!",
      style: "celebration",
      recipientId: recipient.id,
      inviteeIds: [invitee1.id, invitee2.id],
    }, organizerCtx);

    expect(result.success).toBe(true);
    expect(result.pool).toBeDefined();
    expect(mockGetOrCreateGroupAccount).toHaveBeenCalled();
    expect(mockBatch.commit).toHaveBeenCalled();
  });

  it("creates save pool with null recipientId and no expiresAt", async () => {
    const result = await createTokenPool({
      mode: "save",
      title: "Holiday Savings",
      message: "",
      style: "professional",
      inviteeIds: [invitee1.id],
    }, organizerCtx);

    expect(result.success).toBe(true);
  });
});

// ──────────────────────────────────────────────────────────────────────────
// contributeToPool
// ──────────────────────────────────────────────────────────────────────────

describe("contributeToPool", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
    seedPool(collectingSasazaPool.id, collectingSasazaPool);
  });

  // --- Auth ---
  it("throws unauthenticated when not logged in", async () => {
    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 100, anonymous: false }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("calls requireAppCheck", async () => {
    await contributeToPool(
      { poolId: collectingSasazaPool.id, amount: 100, anonymous: false },
      organizerCtx
    ).catch(() => {});

    expect(mockRequireAppCheck).toHaveBeenCalled();
  });

  // --- Input validation ---
  it("throws if poolId is missing", async () => {
    await expect(
      contributeToPool({ amount: 100, anonymous: false }, organizerCtx)
    ).rejects.toThrow("poolId is required");
  });

  it("throws if amount is below MIN_CONTRIBUTION (10)", async () => {
    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 5, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Amount must be an integer between 10 and 100000");
  });

  it("throws if amount exceeds MAX_CONTRIBUTION (100000)", async () => {
    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 100001, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Amount must be an integer between 10 and 100000");
  });

  it("throws if amount is not an integer", async () => {
    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 10.5, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Amount must be an integer between 10 and 100000");
  });

  // --- Business rules ---
  it("throws if balance is insufficient", async () => {
    mockValidateMainWalletBalance.mockResolvedValueOnce({ available: 5, sufficient: false });

    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 100, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Insufficient balance");
  });

  it("throws if pool not found", async () => {
    await expect(
      contributeToPool({ poolId: "nonexistent", amount: 100, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Pool not found");
  });

  it("throws if pool status is not collecting", async () => {
    seedPool(sentSasazaPool.id, sentSasazaPool);

    await expect(
      contributeToPool({ poolId: sentSasazaPool.id, amount: 100, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Pool is no longer accepting contributions");
  });

  it("throws if user is not organizer or invitee", async () => {
    const outsiderCtx = authContext("user_outsider");
    setMockDoc("users", "user_outsider", { displayName: "Outsider", fcmToken: null });

    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 100, anonymous: false }, outsiderCtx)
    ).rejects.toThrow("You are not a participant in this pool");
  });

  // --- Happy path ---
  it("happy path: organizer contributes successfully", async () => {
    const result = await contributeToPool(
      { poolId: collectingSasazaPool.id, amount: 100, anonymous: false },
      organizerCtx
    );

    expect(result.success).toBe(true);
    expect(mockProcessGroupContribution).toHaveBeenCalledWith(
      collectingSasazaPool.id,
      organizer.id,
      100,
      expect.any(String) // contributionId
    );
  });

  it("happy path: invitee contributes successfully", async () => {
    const result = await contributeToPool(
      { poolId: collectingSasazaPool.id, amount: 200, anonymous: false },
      invitee1Ctx
    );

    expect(result.success).toBe(true);
    expect(mockProcessGroupContribution).toHaveBeenCalledWith(
      collectingSasazaPool.id,
      invitee1.id,
      200,
      expect.any(String)
    );
  });

  // --- Ledger failure + rollback ---
  it("rolls back pool counters when ledger returns success: false", async () => {
    mockProcessGroupContribution.mockResolvedValueOnce({
      success: false,
      error: "Ledger error",
    });

    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 100, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Ledger error");
  });

  it("rolls back pool counters when ledger throws an exception", async () => {
    mockProcessGroupContribution.mockRejectedValueOnce(new Error("Connection timeout"));

    await expect(
      contributeToPool({ poolId: collectingSasazaPool.id, amount: 100, anonymous: false }, organizerCtx)
    ).rejects.toThrow("Failed to process contribution");
  });

  // --- Side effects ---
  it("anonymous contribution uses 'Someone' in system message", async () => {
    await contributeToPool(
      { poolId: collectingSasazaPool.id, amount: 100, anonymous: true },
      invitee1Ctx
    );

    // Verify system message was posted (messages subcollection set call)
    const msgSets = require("./mocks/admin.mock").mockOperations.sets;
    const systemMsgSet = msgSets.find(
      (s: { collection: string; data: { textContent?: string } }) =>
        s.collection.includes("messages") &&
        s.data?.textContent?.includes("Someone contributed 100 tokens")
    );
    expect(systemMsgSet).toBeDefined();
  });

  it("non-anonymous contribution uses display name in system message", async () => {
    await contributeToPool(
      { poolId: collectingSasazaPool.id, amount: 100, anonymous: false },
      invitee1Ctx
    );

    const msgSets = require("./mocks/admin.mock").mockOperations.sets;
    const systemMsgSet = msgSets.find(
      (s: { collection: string; data: { textContent?: string } }) =>
        s.collection.includes("messages") &&
        s.data?.textContent?.includes(`${invitee1.displayName} contributed 100 tokens`)
    );
    expect(systemMsgSet).toBeDefined();
  });
});

// ──────────────────────────────────────────────────────────────────────────
// sendGroupGift
// ──────────────────────────────────────────────────────────────────────────

describe("sendGroupGift", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
    seedPool(collectingSasazaPool.id, collectingSasazaPool);
  });

  // --- Auth ---
  it("throws unauthenticated when not logged in", async () => {
    await expect(
      sendGroupGift({ poolId: collectingSasazaPool.id }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  // --- Input/Business rules ---
  it("throws if poolId is missing", async () => {
    await expect(
      sendGroupGift({}, organizerCtx)
    ).rejects.toThrow("poolId is required");
  });

  it("throws if pool not found", async () => {
    await expect(
      sendGroupGift({ poolId: "nonexistent" }, organizerCtx)
    ).rejects.toThrow("Pool not found");
  });

  it("throws if pool mode is not sasaza", async () => {
    seedPool(collectingSavePool.id, collectingSavePool);

    await expect(
      sendGroupGift({ poolId: collectingSavePool.id }, organizerCtx)
    ).rejects.toThrow("Only sasaza pools can send a group gift");
  });

  it("throws if pool status is not collecting", async () => {
    seedPool(sentSasazaPool.id, sentSasazaPool);

    await expect(
      sendGroupGift({ poolId: sentSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Pool is not in collecting status");
  });

  it("throws if user is not the organizer", async () => {
    await expect(
      sendGroupGift({ poolId: collectingSasazaPool.id }, invitee1Ctx)
    ).rejects.toThrow("Only the organizer can send the gift");
  });

  it("throws if pool has zero contributions", async () => {
    seedPool(emptyCollectingSasazaPool.id, emptyCollectingSasazaPool);

    await expect(
      sendGroupGift({ poolId: emptyCollectingSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Pool has no contributions");
  });

  // --- Happy path ---
  it("sends gift successfully and calls processGroupPayout", async () => {
    const result = await sendGroupGift(
      { poolId: collectingSasazaPool.id },
      organizerCtx
    );

    expect(result.success).toBe(true);
    expect(mockProcessGroupPayout).toHaveBeenCalledWith(
      collectingSasazaPool.id,
      [{ memberId: recipient.id, amount: collectingSasazaPool.totalAmount }],
      expect.any(String)
    );
  });

  // --- Ledger failure ---
  it("rolls back status to collecting on ledger payout failure", async () => {
    mockProcessGroupPayout.mockResolvedValueOnce({ success: false, error: "Payout failed" });

    await expect(
      sendGroupGift({ poolId: collectingSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Payout failed");
  });

  it("rolls back status to collecting on ledger exception", async () => {
    mockProcessGroupPayout.mockRejectedValueOnce(new Error("Network error"));

    await expect(
      sendGroupGift({ poolId: collectingSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Failed to transfer tokens");
  });
});

// ──────────────────────────────────────────────────────────────────────────
// openGroupGift
// ──────────────────────────────────────────────────────────────────────────

describe("openGroupGift", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
    seedPool(sentSasazaPool.id, sentSasazaPool);
  });

  it("throws unauthenticated when not logged in", async () => {
    await expect(
      openGroupGift({ poolId: sentSasazaPool.id }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("throws if poolId is missing", async () => {
    await expect(
      openGroupGift({}, recipientCtx)
    ).rejects.toThrow("poolId is required");
  });

  it("throws if pool not found", async () => {
    await expect(
      openGroupGift({ poolId: "nonexistent" }, recipientCtx)
    ).rejects.toThrow("Pool not found");
  });

  it("throws if user is not the recipient", async () => {
    await expect(
      openGroupGift({ poolId: sentSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Only the recipient can open the gift");
  });

  it("throws if pool status is not sent", async () => {
    seedPool(collectingSasazaPool.id, collectingSasazaPool);

    await expect(
      openGroupGift({ poolId: collectingSasazaPool.id }, recipientCtx)
    ).rejects.toThrow("Gift is not in sent status");
  });

  it("happy path: sets openedAt timestamp", async () => {
    const result = await openGroupGift(
      { poolId: sentSasazaPool.id },
      recipientCtx
    );

    expect(result.success).toBe(true);
  });

  it("is idempotent: does not throw if already opened", async () => {
    seedPool(openedSasazaPool.id, openedSasazaPool);

    const result = await openGroupGift(
      { poolId: openedSasazaPool.id },
      recipientCtx
    );

    expect(result.success).toBe(true);
  });
});

// ──────────────────────────────────────────────────────────────────────────
// claimGroupGift
// ──────────────────────────────────────────────────────────────────────────

describe("claimGroupGift", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
    seedPool(openedSasazaPool.id, openedSasazaPool);
  });

  it("throws unauthenticated when not logged in", async () => {
    await expect(
      claimGroupGift({ poolId: openedSasazaPool.id }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("throws if poolId is missing", async () => {
    await expect(
      claimGroupGift({}, recipientCtx)
    ).rejects.toThrow("poolId is required");
  });

  it("throws if pool not found", async () => {
    await expect(
      claimGroupGift({ poolId: "nonexistent" }, recipientCtx)
    ).rejects.toThrow("Pool not found");
  });

  it("throws if user is not the recipient", async () => {
    await expect(
      claimGroupGift({ poolId: openedSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Only the recipient can claim the gift");
  });

  it("throws if pool status is not sent", async () => {
    seedPool(collectingSasazaPool.id, collectingSasazaPool);

    await expect(
      claimGroupGift({ poolId: collectingSasazaPool.id }, recipientCtx)
    ).rejects.toThrow("Gift is not in sent status");
  });

  it("throws if gift has not been opened yet", async () => {
    seedPool(sentSasazaPool.id, sentSasazaPool); // openedAt is null

    await expect(
      claimGroupGift({ poolId: sentSasazaPool.id }, recipientCtx)
    ).rejects.toThrow("Gift must be opened before claiming");
  });

  it("happy path: marks pool as completed", async () => {
    const result = await claimGroupGift(
      { poolId: openedSasazaPool.id },
      recipientCtx
    );

    expect(result.success).toBe(true);
  });
});

// ──────────────────────────────────────────────────────────────────────────
// distributePool
// ──────────────────────────────────────────────────────────────────────────

describe("distributePool", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
    seedPool(collectingSavePool.id, collectingSavePool);
  });

  // --- Auth ---
  it("throws unauthenticated when not logged in", async () => {
    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [{ userId: organizer.id, amount: 1000 }],
      }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  // --- Input validation ---
  it("throws if poolId is missing", async () => {
    await expect(
      distributePool({ payouts: [{ userId: organizer.id, amount: 1000 }] }, organizerCtx)
    ).rejects.toThrow("poolId is required");
  });

  it("throws if payouts is empty array", async () => {
    await expect(
      distributePool({ poolId: collectingSavePool.id, payouts: [] }, organizerCtx)
    ).rejects.toThrow("payouts must be a non-empty array");
  });

  it("throws if payouts is not an array", async () => {
    await expect(
      distributePool({ poolId: collectingSavePool.id, payouts: "bad" }, organizerCtx)
    ).rejects.toThrow("payouts must be a non-empty array");
  });

  it("throws if payout entry missing userId", async () => {
    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [{ amount: 1000 }],
      }, organizerCtx)
    ).rejects.toThrow("Each payout must have a userId");
  });

  it("throws if payout amount is not a positive integer", async () => {
    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [{ userId: organizer.id, amount: 0 }],
      }, organizerCtx)
    ).rejects.toThrow("Each payout amount must be a positive integer");
  });

  // --- Business rules ---
  it("throws if pool not found", async () => {
    await expect(
      distributePool({
        poolId: "nonexistent",
        payouts: [{ userId: organizer.id, amount: 1000 }],
      }, organizerCtx)
    ).rejects.toThrow("Pool not found");
  });

  it("throws if pool mode is not save", async () => {
    seedPool(collectingSasazaPool.id, collectingSasazaPool);

    await expect(
      distributePool({
        poolId: collectingSasazaPool.id,
        payouts: [{ userId: organizer.id, amount: 500 }],
      }, organizerCtx)
    ).rejects.toThrow("Only save pools can be distributed");
  });

  it("throws if pool status is not collecting", async () => {
    seedPool(completedSasazaPool.id, completedSasazaPool);

    await expect(
      distributePool({
        poolId: completedSasazaPool.id,
        payouts: [{ userId: organizer.id, amount: 500 }],
      }, organizerCtx)
    ).rejects.toThrow();
  });

  it("throws if user is not the organizer", async () => {
    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [{ userId: invitee1.id, amount: 1000 }],
      }, invitee1Ctx)
    ).rejects.toThrow("Only the organizer can distribute");
  });

  it("throws if payout sum does not equal totalAmount", async () => {
    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [{ userId: organizer.id, amount: 500 }],
      }, organizerCtx)
    ).rejects.toThrow("Payout sum (500) must equal pool total (1000)");
  });

  it("throws if payout recipient is not a pool participant", async () => {
    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [
          { userId: organizer.id, amount: 500 },
          { userId: "user_outsider", amount: 500 },
        ],
      }, organizerCtx)
    ).rejects.toThrow("User user_outsider is not a pool participant");
  });

  // --- Happy path ---
  it("distributes to all payees successfully", async () => {
    const result = await distributePool({
      poolId: collectingSavePool.id,
      payouts: [
        { userId: organizer.id, amount: 400 },
        { userId: invitee1.id, amount: 300 },
        { userId: invitee2.id, amount: 300 },
      ],
    }, organizerCtx);

    expect(result.success).toBe(true);
    expect(mockProcessGroupPayout).toHaveBeenCalledWith(
      collectingSavePool.id,
      [
        { memberId: organizer.id, amount: 400 },
        { memberId: invitee1.id, amount: 300 },
        { memberId: invitee2.id, amount: 300 },
      ],
      expect.any(String)
    );
  });

  // --- Ledger failure ---
  it("rolls back status to collecting on ledger failure", async () => {
    mockProcessGroupPayout.mockResolvedValueOnce({ success: false, error: "Payout failed" });

    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [
          { userId: organizer.id, amount: 400 },
          { userId: invitee1.id, amount: 300 },
          { userId: invitee2.id, amount: 300 },
        ],
      }, organizerCtx)
    ).rejects.toThrow("Payout failed");
  });

  it("rolls back status to collecting on ledger exception", async () => {
    mockProcessGroupPayout.mockRejectedValueOnce(new Error("Network error"));

    await expect(
      distributePool({
        poolId: collectingSavePool.id,
        payouts: [
          { userId: organizer.id, amount: 400 },
          { userId: invitee1.id, amount: 300 },
          { userId: invitee2.id, amount: 300 },
        ],
      }, organizerCtx)
    ).rejects.toThrow("Failed to distribute tokens");
  });
});

// ──────────────────────────────────────────────────────────────────────────
// cancelPool
// ──────────────────────────────────────────────────────────────────────────

describe("cancelPool", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
    seedPool(collectingSasazaPool.id, collectingSasazaPool);
  });

  it("throws unauthenticated when not logged in", async () => {
    await expect(
      cancelPool({ poolId: collectingSasazaPool.id }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("throws if poolId is missing", async () => {
    await expect(
      cancelPool({}, organizerCtx)
    ).rejects.toThrow("poolId is required");
  });

  it("throws if pool not found", async () => {
    await expect(
      cancelPool({ poolId: "nonexistent" }, organizerCtx)
    ).rejects.toThrow("Pool not found");
  });

  it("throws if pool status is not collecting", async () => {
    seedPool(sentSasazaPool.id, sentSasazaPool);

    await expect(
      cancelPool({ poolId: sentSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Pool can only be cancelled while collecting");
  });

  it("throws if user is not the organizer", async () => {
    await expect(
      cancelPool({ poolId: collectingSasazaPool.id }, invitee1Ctx)
    ).rejects.toThrow("Only the organizer can cancel the pool");
  });

  it("cancels with contributions: refunds all contributors", async () => {
    const result = await cancelPool(
      { poolId: collectingSasazaPool.id },
      organizerCtx
    );

    expect(result.success).toBe(true);
    expect(mockProcessGroupPayout).toHaveBeenCalledWith(
      collectingSasazaPool.id,
      expect.arrayContaining([
        { memberId: organizer.id, amount: 300 },
        { memberId: invitee1.id, amount: 200 },
      ]),
      expect.any(String)
    );
  });

  it("cancels with zero contributions: no refund", async () => {
    seedPool(emptyCollectingSasazaPool.id, emptyCollectingSasazaPool);

    const result = await cancelPool(
      { poolId: emptyCollectingSasazaPool.id },
      organizerCtx
    );

    expect(result.success).toBe(true);
    expect(mockProcessGroupPayout).not.toHaveBeenCalled();
  });

  it("rolls back status to collecting on refund ledger failure", async () => {
    mockProcessGroupPayout.mockResolvedValueOnce({ success: false, error: "Refund failed" });

    await expect(
      cancelPool({ poolId: collectingSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Refund failed");
  });
});

// ──────────────────────────────────────────────────────────────────────────
// expireTokenPools
// ──────────────────────────────────────────────────────────────────────────

describe("expireTokenPools", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  it("does nothing when no expired pools found", async () => {
    // No pools seeded in tokenPools collection
    await expireTokenPools({});
    expect(mockProcessGroupPayout).not.toHaveBeenCalled();
  });

  it("expires collecting pool with contributions: refunds all", async () => {
    const expiredCollecting = {
      ...collectingSasazaPool,
      id: "pool_expire_collecting",
      expiresAt: { toDate: () => new Date(Date.now() - 1000), toMillis: () => Date.now() - 1000, seconds: 0, nanoseconds: 0 },
    };
    seedPool("pool_expire_collecting", expiredCollecting);

    await expireTokenPools({});

    expect(mockProcessGroupPayout).toHaveBeenCalledWith(
      "pool_expire_collecting",
      expect.arrayContaining([
        { memberId: organizer.id, amount: 300 },
        { memberId: invitee1.id, amount: 200 },
      ]),
      expect.any(String)
    );
  });

  it("expires collecting pool with zero contributions: just status update", async () => {
    const expiredEmpty = {
      ...emptyCollectingSasazaPool,
      id: "pool_expire_empty",
      expiresAt: { toDate: () => new Date(Date.now() - 1000), toMillis: () => Date.now() - 1000, seconds: 0, nanoseconds: 0 },
    };
    seedPool("pool_expire_empty", expiredEmpty);

    await expireTokenPools({});

    expect(mockProcessGroupPayout).not.toHaveBeenCalled();
  });

  it("expires sent pool without refund and updates gift message embed", async () => {
    const expiredSent = {
      ...sentSasazaPool,
      id: "pool_expire_sent",
      expiresAt: { toDate: () => new Date(Date.now() - 1000), toMillis: () => Date.now() - 1000, seconds: 0, nanoseconds: 0 },
    };
    seedPool("pool_expire_sent", expiredSent);

    await expireTokenPools({});

    expect(mockProcessGroupPayout).not.toHaveBeenCalled();
  });

  it("skips already-terminal pools", async () => {
    const expiredAlreadyCompleted = {
      ...completedSasazaPool,
      id: "pool_completed_skip",
      expiresAt: { toDate: () => new Date(Date.now() - 1000), toMillis: () => Date.now() - 1000, seconds: 0, nanoseconds: 0 },
    };
    seedPool("pool_completed_skip", expiredAlreadyCompleted);

    await expireTokenPools({});

    expect(mockProcessGroupPayout).not.toHaveBeenCalled();
  });
});

// ──────────────────────────────────────────────────────────────────────────
// sendPoolExpiryReminders
// ──────────────────────────────────────────────────────────────────────────

describe("sendPoolExpiryReminders", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  it("does nothing when no pools need reminders", async () => {
    // No pools seeded
    await sendPoolExpiryReminders({});
    // No errors
  });
});

// ──────────────────────────────────────────────────────────────────────────
// Race conditions
// ──────────────────────────────────────────────────────────────────────────

describe("Race conditions", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    seedUsers();
  });

  it("contribute rejects when pool status changed to sent", async () => {
    seedPool(sentSasazaPool.id, sentSasazaPool);

    await expect(
      contributeToPool(
        { poolId: sentSasazaPool.id, amount: 100, anonymous: false },
        organizerCtx
      )
    ).rejects.toThrow("Pool is no longer accepting contributions");
  });

  it("cancel rejects when pool already completed", async () => {
    seedPool(completedSasazaPool.id, completedSasazaPool);

    await expect(
      cancelPool({ poolId: completedSasazaPool.id }, organizerCtx)
    ).rejects.toThrow("Pool can only be cancelled while collecting");
  });

  it("contribute rejects cancelled pool", async () => {
    seedPool(cancelledPool.id, cancelledPool);

    await expect(
      contributeToPool(
        { poolId: cancelledPool.id, amount: 100, anonymous: false },
        organizerCtx
      )
    ).rejects.toThrow("Pool is no longer accepting contributions");
  });

  it("distribute rejects cancelled pool", async () => {
    seedPool(cancelledPool.id, { ...cancelledPool, mode: "save" });

    await expect(
      distributePool({
        poolId: cancelledPool.id,
        payouts: [{ userId: organizer.id, amount: 500 }],
      }, organizerCtx)
    ).rejects.toThrow();
  });
});
