/**
 * Wallet Cloud Functions — Test Suite
 *
 * Tests wallet functions modified in the audit fix:
 * - cancelCashout (new function)
 * - transferBetweenWallets ('main' sentinel handling)
 * - getSubAccounts (App Check)
 */

import { resetMocks } from "./mocks/admin.mock";
import {
  createMockCallContext,
  setupMockDocument,
} from "./mocks/firestore.mock";

// ── Mocks ──────────────────────────────────────────────────────────────────

jest.mock("firebase-admin", () => require("./mocks/admin.mock").mockFirebaseAdmin);

jest.mock("firebase-functions", () => ({
  https: {
    onCall: jest.fn((handler) => handler),
    HttpsError: class HttpsError extends Error {
      constructor(
        public code: string,
        public message: string,
        public details?: unknown
      ) {
        super(message);
        this.name = "HttpsError";
      }
    },
  },
  logger: { log: jest.fn(), info: jest.fn(), warn: jest.fn(), error: jest.fn() },
}));

// Mock ledger functions
const mockFailCashout = jest.fn().mockResolvedValue({ success: true, journalId: "j_refund_001" });
const mockValidateMainWalletBalance = jest.fn().mockResolvedValue({ available: 5000, sufficient: true });
const mockCreditSubAccount = jest.fn().mockResolvedValue(undefined);
const mockDebitSubAccount = jest.fn().mockResolvedValue(undefined);
const mockTransferBetweenSubAccounts = jest.fn().mockResolvedValue(undefined);
const mockGetSubAccount = jest.fn().mockResolvedValue({ accountTypeId: null, balance: 1000 });
const mockValidateSubAccountAllows = jest.fn().mockResolvedValue({ allowed: true });
const mockGetUserSubAccounts = jest.fn().mockResolvedValue([]);
const mockValidateSubAccountBalance = jest.fn().mockResolvedValue({ allowed: true });
const mockProcessP2PTransfer = jest.fn().mockResolvedValue({ success: true, journalId: "j_p2p" });
const mockRequireAppCheck = jest.fn();

jest.mock("../ledger", () => ({
  failCashout: (...args: unknown[]) => mockFailCashout(...args),
  validateMainWalletBalance: (...args: unknown[]) => mockValidateMainWalletBalance(...args),
  creditSubAccount: (...args: unknown[]) => mockCreditSubAccount(...args),
  debitSubAccount: (...args: unknown[]) => mockDebitSubAccount(...args),
  transferBetweenSubAccounts: (...args: unknown[]) => mockTransferBetweenSubAccounts(...args),
  getSubAccount: (...args: unknown[]) => mockGetSubAccount(...args),
  validateSubAccountAllows: (...args: unknown[]) => mockValidateSubAccountAllows(...args),
  getUserSubAccounts: (...args: unknown[]) => mockGetUserSubAccounts(...args),
  validateSubAccountBalance: (...args: unknown[]) => mockValidateSubAccountBalance(...args),
  processP2PTransfer: (...args: unknown[]) => mockProcessP2PTransfer(...args),
  AccountId: {
    user: (id: string) => `user:${id}`,
    client: (id: string) => `client:${id}`,
  },
  SubAccountConfig: {
    COLLECTION_LEDGER_ACCOUNTS: "ledgerAccounts",
    SUBCOLLECTION_SUB_ACCOUNTS: "subAccounts",
  },
}));

jest.mock("../security", () => ({
  requireAppCheck: (...args: unknown[]) => mockRequireAppCheck(...args),
  requirePlayIntegrity: jest.fn(),
}));

// ── Import module under test ────────────────────────────────────────────────

import { cancelCashout as _cancelCashout, transferBetweenWallets as _transferBetweenWallets } from "../wallet";

// onCall mock returns the raw handler — cast to callable
const cancelCashout = _cancelCashout as unknown as (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;
const transferBetweenWallets = _transferBetweenWallets as unknown as (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;

// ── Helpers ─────────────────────────────────────────────────────────────────

const authContext = createMockCallContext({
  uid: "user_001",
  appCheckToken: true,
});

const unauthContext = createMockCallContext(null);

// ── cancelCashout Tests ─────────────────────────────────────────────────────

describe("cancelCashout", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("throws unauthenticated when not logged in", async () => {
    await expect(
      cancelCashout({ cashoutId: "co_001" }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("throws if cashoutId is missing", async () => {
    await expect(
      cancelCashout({}, authContext)
    ).rejects.toThrow("cashoutId is required");
  });

  it("throws not-found if cashout does not exist", async () => {
    await expect(
      cancelCashout({ cashoutId: "missing" }, authContext)
    ).rejects.toThrow("Cashout not found");
  });

  it("throws permission-denied if user does not own the cashout", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "other_user",
      status: "pending",
      tokenAmount: 5000,
    });

    await expect(
      cancelCashout({ cashoutId: "co_001" }, authContext)
    ).rejects.toThrow("Not authorized to cancel this cashout");
  });

  it("throws failed-precondition if cashout is not pending", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "user_001",
      status: "processing",
      tokenAmount: 5000,
    });

    await expect(
      cancelCashout({ cashoutId: "co_001" }, authContext)
    ).rejects.toThrow("Can only cancel pending cashouts");
  });

  it("calls failCashout from ledger and returns success", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "user_001",
      status: "pending",
      tokenAmount: 5000,
    });

    const result = await cancelCashout({ cashoutId: "co_001" }, authContext);

    expect(result.success).toBe(true);
    expect(result.cashoutId).toBe("co_001");
    expect(result.refundLedgerJournalId).toBe("j_refund_001");
    expect(mockFailCashout).toHaveBeenCalledWith(
      "user_001",
      "co_001",
      5000,
      "User cancelled cashout",
      undefined // no sub-account
    );
  });

  it("passes sub-account ID when cashout has one (not 'main')", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "user_001",
      status: "pending",
      tokenAmount: 3000,
      subAccountId: "sub_savings_001",
    });

    await cancelCashout({ cashoutId: "co_001" }, authContext);

    expect(mockFailCashout).toHaveBeenCalledWith(
      "user_001",
      "co_001",
      3000,
      "User cancelled cashout",
      "sub_savings_001"
    );
  });

  it("treats subAccountId='main' as undefined (main wallet)", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "user_001",
      status: "pending",
      tokenAmount: 5000,
      subAccountId: "main",
    });

    await cancelCashout({ cashoutId: "co_001" }, authContext);

    expect(mockFailCashout).toHaveBeenCalledWith(
      "user_001",
      "co_001",
      5000,
      "User cancelled cashout",
      undefined // 'main' converted to undefined
    );
  });

  it("uses amount field as fallback when tokenAmount is missing", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "user_001",
      status: "pending",
      amount: 7000,
    });

    await cancelCashout({ cashoutId: "co_001" }, authContext);

    expect(mockFailCashout).toHaveBeenCalledWith(
      "user_001",
      "co_001",
      7000,
      "User cancelled cashout",
      undefined
    );
  });

  it("throws internal error when ledger failCashout fails", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "user_001",
      status: "pending",
      tokenAmount: 5000,
    });
    mockFailCashout.mockResolvedValueOnce({ success: false, error: "Ledger locked" });

    await expect(
      cancelCashout({ cashoutId: "co_001" }, authContext)
    ).rejects.toThrow("Failed to reverse cashout: Ledger locked");
  });

  it("calls requireAppCheck", async () => {
    setupMockDocument("cashouts", "co_001", {
      userId: "user_001",
      status: "pending",
      tokenAmount: 5000,
    });

    await cancelCashout({ cashoutId: "co_001" }, authContext);

    expect(mockRequireAppCheck).toHaveBeenCalledWith(authContext, "cancelCashout");
  });
});

// ── transferBetweenWallets Tests ────────────────────────────────────────────

describe("transferBetweenWallets", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("throws unauthenticated when not logged in", async () => {
    await expect(
      transferBetweenWallets({ fromSubAccountId: "a", toSubAccountId: "b", amount: 100 }, unauthContext)
    ).rejects.toThrow("User must be authenticated");
  });

  it("throws if fromSubAccountId is missing", async () => {
    await expect(
      transferBetweenWallets({ toSubAccountId: "b", amount: 100 }, authContext)
    ).rejects.toThrow("fromSubAccountId, toSubAccountId, and amount are required");
  });

  it("throws if amount is zero (caught by required check)", async () => {
    // amount: 0 is falsy, caught by the !amount required check
    await expect(
      transferBetweenWallets({ fromSubAccountId: "a", toSubAccountId: "b", amount: 0 }, authContext)
    ).rejects.toThrow("fromSubAccountId, toSubAccountId, and amount are required");
  });

  it("throws if source and destination are the same", async () => {
    await expect(
      transferBetweenWallets({ fromSubAccountId: "a", toSubAccountId: "a", amount: 100 }, authContext)
    ).rejects.toThrow("Source and destination must be different");
  });

  it("throws if both are 'main' (same source/dest)", async () => {
    // Both being 'main' is caught by the generic same-source-dest check
    await expect(
      transferBetweenWallets({ fromSubAccountId: "main", toSubAccountId: "main", amount: 100 }, authContext)
    ).rejects.toThrow("Source and destination must be different");
  });

  // ── main → sub-account ──

  describe("main → sub-account", () => {
    it("validates main wallet balance and credits destination", async () => {
      const result = await transferBetweenWallets(
        { fromSubAccountId: "main", toSubAccountId: "sub_001", amount: 500 },
        authContext
      );

      expect(result.success).toBe(true);
      expect(mockValidateMainWalletBalance).toHaveBeenCalledWith("user_001", 500);
      expect(mockCreditSubAccount).toHaveBeenCalledWith("user_001", "sub_001", 500);
      expect(mockDebitSubAccount).not.toHaveBeenCalled();
      expect(mockTransferBetweenSubAccounts).not.toHaveBeenCalled();
    });

    it("throws when main wallet has insufficient balance", async () => {
      mockValidateMainWalletBalance.mockResolvedValueOnce({ available: 200, sufficient: false });

      await expect(
        transferBetweenWallets(
          { fromSubAccountId: "main", toSubAccountId: "sub_001", amount: 500 },
          authContext
        )
      ).rejects.toThrow("Insufficient main wallet balance: has 200, needs 500");
    });
  });

  // ── sub-account → main ──

  describe("sub-account → main", () => {
    it("debits source sub-account only", async () => {
      mockGetSubAccount.mockResolvedValueOnce({ accountTypeId: null, balance: 1000 });

      const result = await transferBetweenWallets(
        { fromSubAccountId: "sub_001", toSubAccountId: "main", amount: 300 },
        authContext
      );

      expect(result.success).toBe(true);
      expect(mockDebitSubAccount).toHaveBeenCalledWith("user_001", "sub_001", 300);
      expect(mockCreditSubAccount).not.toHaveBeenCalled();
      expect(mockTransferBetweenSubAccounts).not.toHaveBeenCalled();
    });

    it("checks sub-account allows p2p_send for restricted wallets", async () => {
      mockGetSubAccount.mockResolvedValueOnce({ accountTypeId: "brand_loyalty", balance: 1000 });
      mockValidateSubAccountAllows.mockResolvedValueOnce({ allowed: false, reason: "Brand wallet cannot transfer out" });

      await expect(
        transferBetweenWallets(
          { fromSubAccountId: "sub_brand", toSubAccountId: "main", amount: 200 },
          authContext
        )
      ).rejects.toThrow("Brand wallet cannot transfer out");
    });
  });

  // ── sub-account → sub-account ──

  describe("sub-account → sub-account", () => {
    it("calls transferBetweenSubAccounts", async () => {
      mockGetSubAccount.mockResolvedValueOnce({ accountTypeId: null, balance: 1000 });

      const result = await transferBetweenWallets(
        { fromSubAccountId: "sub_001", toSubAccountId: "sub_002", amount: 100 },
        authContext
      );

      expect(result.success).toBe(true);
      expect(mockTransferBetweenSubAccounts).toHaveBeenCalledWith(
        "user_001", "sub_001", "user_001", "sub_002", 100
      );
    });
  });

  it("calls requireAppCheck", async () => {
    await transferBetweenWallets(
      { fromSubAccountId: "main", toSubAccountId: "sub_001", amount: 100 },
      authContext
    );

    expect(mockRequireAppCheck).toHaveBeenCalledWith(authContext, "transferBetweenWallets");
  });
});
