/**
 * Upload Review Cloud Functions — Test Suite
 *
 * Tests the admin upload review functions:
 * - adminReviewUpload (approve/reject with escrow, sub-account, stats)
 * - getUploadReviewQueue
 */

import { resetMocks } from "./mocks/admin.mock";
import {
  createMockCallContext,
  setupMockDocument,
} from "./mocks/firestore.mock";

// ── Mocks ──────────────────────────────────────────────────────────────────

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
    // Support onCall(handler) and onCall(opts, handler)
    const handler = typeof args[0] === "function" ? args[0] : args[1];
    // Return adapter: tests call fn(data, context), handler expects request object
    return (data: unknown, context: unknown) =>
      (handler as Function)({ data, ...(context as object) });
  }),
  HttpsError: MockHttpsError,
}));


// Mock adminAuth
const mockRequireAdminPermission = jest.fn().mockResolvedValue({ uid: "admin_001" });
const mockLogAdminAction = jest.fn().mockResolvedValue(undefined);
jest.mock("../adminAuth", () => ({
  requireAdminPermission: (...args: unknown[]) => mockRequireAdminPermission(...args),
  logAdminAction: (...args: unknown[]) => mockLogAdminAction(...args),
}));

// Mock ledger
const mockProcessEarningWithSplit = jest.fn().mockResolvedValue({ success: true, journalId: "j_earn_001" });
const mockProcessEscrowCompletion = jest.fn().mockResolvedValue({ success: true, journalId: "j_escrow_001" });
const mockReverseJournal = jest.fn().mockResolvedValue({ success: true, reversalJournalId: "j_rev_001" });
const mockGetOrCreateBrandSubAccount = jest.fn().mockResolvedValue({ subAccountId: "brand_sub_001", isNew: false });

jest.mock("../ledger", () => ({
  processEarningWithSplit: (...args: unknown[]) => mockProcessEarningWithSplit(...args),
  processEscrowCompletion: (...args: unknown[]) => mockProcessEscrowCompletion(...args),
  reverseJournal: (...args: unknown[]) => mockReverseJournal(...args),
  getOrCreateBrandSubAccount: (...args: unknown[]) => mockGetOrCreateBrandSubAccount(...args),
  AccountId: {
    user: (id: string) => `user:${id}`,
    client: (id: string) => `client:${id}`,
  },
  LedgerConfig: {
    EARNING_DAILY_POT_SHARE: 0.05,
    EARNING_WEEKLY_POT_SHARE: 0.05,
  },
}));

// Mock rewardAllocation
const mockReleaseRewardReservation = jest.fn().mockResolvedValue(undefined);
jest.mock("../rewardAllocation", () => ({
  releaseRewardReservation: (...args: unknown[]) => mockReleaseRewardReservation(...args),
}));

// Mock engagementStats
const mockUpdateEngagementStats = jest.fn().mockResolvedValue({ currentStreak: 3, multiplier: 1.2 });
jest.mock("../engagementStats", () => ({
  updateEngagementStats: (...args: unknown[]) => mockUpdateEngagementStats(...args),
}));

// Mock dailyScores
const mockUpdateDailyScore = jest.fn().mockResolvedValue(120);
const mockUpdateReferrerAssistScore = jest.fn().mockResolvedValue(undefined);
const mockUpdateLeaderboardScores = jest.fn().mockResolvedValue(undefined);
jest.mock("../dailyScores", () => ({
  updateDailyScore: (...args: unknown[]) => mockUpdateDailyScore(...args),
  updateReferrerAssistScore: (...args: unknown[]) => mockUpdateReferrerAssistScore(...args),
  updateLeaderboardScores: (...args: unknown[]) => mockUpdateLeaderboardScores(...args),
}));

// ── Import module under test (after mocks) ─────────────────────────────────

import { adminReviewUpload as _adminReviewUpload, getUploadReviewQueue as _getUploadReviewQueue } from "../uploadReview";

// onCall mock returns the raw handler — cast to callable
const adminReviewUpload = _adminReviewUpload as unknown as (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;
const getUploadReviewQueue = _getUploadReviewQueue as unknown as (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;

// ── Helpers ─────────────────────────────────────────────────────────────────

const adminContext = createMockCallContext({
  uid: "admin_001",
  admin: true,
  token: { admin: true },
  appCheckToken: true,
});

function setupEngagement(id: string, overrides: Record<string, unknown> = {}) {
  setupMockDocument("engagements", id, {
    userId: "user_001",
    threadId: "thread_001",
    earnOpportunityId: "opp_001",
    type: "upload",
    rewardAmount: 100,
    status: "pending_review",
    clientName: "TestBrand",
    ...overrides,
  });
}

function setupThread(id: string, overrides: Record<string, unknown> = {}) {
  setupMockDocument("earnThreads", id, {
    clientId: "client_001",
    tokenSourceAccountId: "sub_client_001",
    tokenDestAccountTypeId: null,
    ...overrides,
  });
}

function setupUser(id: string, overrides: Record<string, unknown> = {}) {
  setupMockDocument("users", id, {
    displayName: "Test User",
    username: "testuser",
    avatarUrl: null,
    referredBy: null,
    ...overrides,
  });
}

// ── Tests ───────────────────────────────────────────────────────────────────

describe("adminReviewUpload", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  // ── Input validation ──

  describe("input validation", () => {
    it("throws if engagementId is missing", async () => {
      await expect(
        adminReviewUpload({ action: "approve" }, adminContext)
      ).rejects.toThrow("engagementId and action are required");
    });

    it("throws if action is missing", async () => {
      await expect(
        adminReviewUpload({ engagementId: "eng_001" }, adminContext)
      ).rejects.toThrow("engagementId and action are required");
    });

    it("throws if action is invalid", async () => {
      await expect(
        adminReviewUpload({ engagementId: "eng_001", action: "maybe" }, adminContext)
      ).rejects.toThrow("action must be 'approve' or 'reject'");
    });
  });

  // ── Engagement state checks ──

  describe("engagement state checks", () => {
    it("throws not-found if engagement does not exist", async () => {
      await expect(
        adminReviewUpload({ engagementId: "missing", action: "approve" }, adminContext)
      ).rejects.toThrow("Engagement not found");
    });

    it("throws failed-precondition if engagement is not pending_review", async () => {
      setupEngagement("eng_001", { status: "completed" });
      await expect(
        adminReviewUpload({ engagementId: "eng_001", action: "approve" }, adminContext)
      ).rejects.toThrow("Engagement is not pending review");
    });
  });

  // ── Rejection ──

  describe("reject", () => {
    it("rejects engagement with reason", async () => {
      setupEngagement("eng_001");

      const result = await adminReviewUpload(
        { engagementId: "eng_001", action: "reject", reason: "Blurry photo" },
        adminContext
      );

      expect(result.success).toBe(true);
      expect(result.action).toBe("rejected");
    });

    it("reverses escrow when engagement has escrowJournalId", async () => {
      setupEngagement("eng_001", { escrowJournalId: "escrow_j_001" });

      await adminReviewUpload(
        { engagementId: "eng_001", action: "reject", reason: "Invalid" },
        adminContext
      );

      expect(mockReverseJournal).toHaveBeenCalledWith(
        "escrow_j_001",
        expect.stringContaining("Upload rejected by admin"),
        "admin_001"
      );
    });

    it("does NOT call reverseJournal when no escrowJournalId", async () => {
      setupEngagement("eng_001"); // no escrowJournalId

      await adminReviewUpload(
        { engagementId: "eng_001", action: "reject" },
        adminContext
      );

      expect(mockReverseJournal).not.toHaveBeenCalled();
    });

    it("releases reward reservation when reservedRewardItemId exists", async () => {
      setupEngagement("eng_001", { reservedRewardItemId: "reward_item_001" });

      await adminReviewUpload(
        { engagementId: "eng_001", action: "reject" },
        adminContext
      );

      expect(mockReleaseRewardReservation).toHaveBeenCalledWith(
        "reward_item_001",
        "eng_001"
      );
    });

    it("does NOT release reservation when no reservedRewardItemId", async () => {
      setupEngagement("eng_001");

      await adminReviewUpload(
        { engagementId: "eng_001", action: "reject" },
        adminContext
      );

      expect(mockReleaseRewardReservation).not.toHaveBeenCalled();
    });
  });

  // ── Approval — non-escrow path ──

  describe("approve (non-escrow)", () => {
    beforeEach(() => {
      setupEngagement("eng_001");
      setupThread("thread_001");
      setupUser("user_001");
    });

    it("calls processEarningWithSplit (not escrow)", async () => {
      const result = await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(result.success).toBe(true);
      expect(result.action).toBe("approved");
      expect(mockProcessEarningWithSplit).toHaveBeenCalled();
      expect(mockProcessEscrowCompletion).not.toHaveBeenCalled();
    });

    it("records userShare (90%), not full rewardAmount", async () => {
      const result = await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      // rewardAmount=100 → dailyPot=5, weeklyPot=5, userShare=90
      expect(result.tokensAwarded).toBe(90);
    });

    it("passes userShare to engagement stats", async () => {
      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      // Should pass 90 (userShare), not 100 (rewardAmount)
      expect(mockUpdateEngagementStats).toHaveBeenCalledWith("user_001", 90, 1);
    });

    it("passes userShare to daily score", async () => {
      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockUpdateDailyScore).toHaveBeenCalledWith(
        "user_001",
        90,  // userShare, not 100
        3,   // streak from mock
        1.2, // multiplier from mock
        expect.objectContaining({ displayName: "Test User" })
      );
    });

    it("updates referrer assist score when user has referredBy", async () => {
      setupUser("user_001", { referredBy: "referrer_001" });

      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockUpdateReferrerAssistScore).toHaveBeenCalledWith("referrer_001", 90);
    });

    it("does NOT update referrer score when no referredBy", async () => {
      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockUpdateReferrerAssistScore).not.toHaveBeenCalled();
    });

    it("uses client sub-account as token source when thread has tokenSourceAccountId", async () => {
      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockProcessEarningWithSplit).toHaveBeenCalledWith(
        "user_001",
        100,
        "eng_001",
        expect.any(String),
        "sub_client_001", // tokenSourceAccountId from thread
        undefined,        // no subAccountId (tokenDestAccountTypeId is null)
        null,             // tokenDestAccountTypeId
        expect.objectContaining({ threadId: "thread_001" })
      );
    });

    it("falls back to client:clientId when no tokenSourceAccountId", async () => {
      setupThread("thread_001", { tokenSourceAccountId: null, clientId: "client_001" });

      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockProcessEarningWithSplit).toHaveBeenCalledWith(
        "user_001",
        100,
        "eng_001",
        expect.any(String),
        "client:client_001", // AccountId.client(clientId)
        undefined,
        null,
        expect.any(Object)
      );
    });

    it("falls back to client:imalichat when no clientId and no tokenSourceAccountId", async () => {
      setupThread("thread_001", { tokenSourceAccountId: null, clientId: null });

      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockProcessEarningWithSplit).toHaveBeenCalledWith(
        "user_001",
        100,
        "eng_001",
        expect.any(String),
        "client:imalichat",
        undefined,
        null,
        expect.any(Object)
      );
    });
  });

  // ── Approval — brand sub-account path ──

  describe("approve (brand sub-account)", () => {
    it("calls getOrCreateBrandSubAccount when thread has tokenDestAccountTypeId", async () => {
      setupEngagement("eng_001", { clientName: "BrandCo" });
      setupThread("thread_001", { tokenDestAccountTypeId: "brand_loyalty" });
      setupUser("user_001");

      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockGetOrCreateBrandSubAccount).toHaveBeenCalledWith(
        "user_001",
        "brand_loyalty",
        "BrandCo Wallet"
      );

      expect(mockProcessEarningWithSplit).toHaveBeenCalledWith(
        "user_001",
        100,
        "eng_001",
        expect.any(String),
        "sub_client_001",
        "brand_sub_001",  // from getOrCreateBrandSubAccount mock
        "brand_loyalty",
        expect.any(Object)
      );
    });
  });

  // ── Approval — escrow path ──

  describe("approve (escrow)", () => {
    it("calls processEscrowCompletion when engagement has escrowJournalId", async () => {
      setupEngagement("eng_001", { escrowJournalId: "escrow_j_001", escrowAmount: 120 });
      setupThread("thread_001");
      setupUser("user_001");

      const result = await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(result.success).toBe(true);
      expect(mockProcessEscrowCompletion).toHaveBeenCalledWith(
        "user_001",
        100,  // rewardAmount
        120,  // escrowAmount
        "eng_001",
        "sub_client_001",
        undefined,
        null,
        expect.objectContaining({ reviewedBy: "admin_001" })
      );
      expect(mockProcessEarningWithSplit).not.toHaveBeenCalled();
    });

    it("defaults escrowAmount to rewardAmount when not set", async () => {
      setupEngagement("eng_001", { escrowJournalId: "escrow_j_001" }); // no escrowAmount
      setupThread("thread_001");
      setupUser("user_001");

      await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      expect(mockProcessEscrowCompletion).toHaveBeenCalledWith(
        "user_001",
        100, // rewardAmount
        100, // escrowAmount defaults to rewardAmount
        expect.any(String),
        expect.any(String),
        undefined,
        null,
        expect.any(Object)
      );
    });
  });

  // ── Ledger failure ──

  describe("ledger failure", () => {
    it("throws internal error when ledger result is not successful", async () => {
      setupEngagement("eng_001");
      setupThread("thread_001");
      setupUser("user_001");
      mockProcessEarningWithSplit.mockResolvedValueOnce({ success: false, error: "Insufficient funds" });

      await expect(
        adminReviewUpload({ engagementId: "eng_001", action: "approve" }, adminContext)
      ).rejects.toThrow("Failed to process earning: Insufficient funds");
    });
  });

  // ── Math.floor split verification ──

  describe("90/5/5 split uses Math.floor", () => {
    it("floors pot shares for odd amounts (e.g. 107 tokens)", async () => {
      setupEngagement("eng_001", { rewardAmount: 107 });
      setupThread("thread_001");
      setupUser("user_001");

      const result = await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      // 107 * 0.05 = 5.35 → Math.floor = 5 for each pot
      // userShare = 107 - 5 - 5 = 97
      expect(result.tokensAwarded).toBe(97);
      expect(mockUpdateEngagementStats).toHaveBeenCalledWith("user_001", 97, 1);
    });

    it("handles single-token reward correctly", async () => {
      setupEngagement("eng_001", { rewardAmount: 1 });
      setupThread("thread_001");
      setupUser("user_001");

      const result = await adminReviewUpload(
        { engagementId: "eng_001", action: "approve" },
        adminContext
      );

      // 1 * 0.05 = 0.05 → Math.floor = 0 for each pot
      // userShare = 1 - 0 - 0 = 1
      expect(result.tokensAwarded).toBe(1);
    });
  });
});

describe("getUploadReviewQueue", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("returns empty items when no pending_review engagements", async () => {
    const result = await getUploadReviewQueue({}, adminContext);

    expect(result.success).toBe(true);
    expect(result.items).toEqual([]);
    expect(result.count).toBe(0);
  });

  it("requires admin permission", async () => {
    await getUploadReviewQueue({}, adminContext);

    expect(mockRequireAdminPermission).toHaveBeenCalledWith(
      expect.objectContaining(adminContext),
      "review:getQueue",
      "getUploadReviewQueue"
    );
  });
});
