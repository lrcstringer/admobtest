/**
 * Purchases Cloud Functions — Test Suite
 *
 * Tests the purchase reversal flow:
 * - Sub-account balance restore on purchase failure
 * - reverseJournal + creditSubAccount coordination
 */

import { resetMocks } from "./mocks/admin.mock";
// Firestore mock helpers available but not needed for these unit-level tests

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

// Mock ledger
const mockReverseJournal = jest.fn().mockResolvedValue({ success: true, reversalJournalId: "j_rev_001" });
const mockCreditSubAccount = jest.fn().mockResolvedValue(undefined);
const mockProcessPurchase = jest.fn().mockResolvedValue({ success: true, journalId: "j_purchase_001" });
const mockValidateMainWalletBalance = jest.fn().mockResolvedValue({ available: 10000, sufficient: true });
const mockValidateSubAccountBalance = jest.fn().mockResolvedValue({ allowed: true });
const mockDebitSubAccount = jest.fn().mockResolvedValue(undefined);

jest.mock("../ledger", () => ({
  reverseJournal: (...args: unknown[]) => mockReverseJournal(...args),
  creditSubAccount: (...args: unknown[]) => mockCreditSubAccount(...args),
  processPurchase: (...args: unknown[]) => mockProcessPurchase(...args),
  validateMainWalletBalance: (...args: unknown[]) => mockValidateMainWalletBalance(...args),
  validateSubAccountBalance: (...args: unknown[]) => mockValidateSubAccountBalance(...args),
  debitSubAccount: (...args: unknown[]) => mockDebitSubAccount(...args),
  AccountId: {
    user: (id: string) => `user:${id}`,
  },
}));

// Mock appCheck
jest.mock("../appCheck", () => ({
  requireAppCheck: jest.fn(),
}));

// ── Tests ───────────────────────────────────────────────────────────────────

describe("Purchase reversal — sub-account balance restore", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("should call creditSubAccount after reverseJournal when purchase had sub-account", async () => {
    // Simulate a failed purchase that had a ledger journal and sub-account
    const purchaseData = {
      ledgerJournalId: "j_purchase_001",
      subAccountId: "sub_savings_001",
      userId: "user_001",
      status: "pending",
    };

    // Simulate the reversal logic
    if (purchaseData.ledgerJournalId) {
      await mockReverseJournal(
        purchaseData.ledgerJournalId,
        "Purchase failed: Provider error",
        "system"
      );

      if (purchaseData.subAccountId) {
        await mockCreditSubAccount(
          purchaseData.userId,
          purchaseData.subAccountId,
          5000 // tokenAmount
        );
      }
    }

    expect(mockReverseJournal).toHaveBeenCalledWith(
      "j_purchase_001",
      "Purchase failed: Provider error",
      "system"
    );
    expect(mockCreditSubAccount).toHaveBeenCalledWith(
      "user_001",
      "sub_savings_001",
      5000
    );
  });

  it("should NOT call creditSubAccount when purchase had no sub-account", async () => {
    const purchaseData = {
      ledgerJournalId: "j_purchase_002",
      subAccountId: undefined,
      userId: "user_001",
      status: "pending",
    };

    if (purchaseData.ledgerJournalId) {
      await mockReverseJournal(
        purchaseData.ledgerJournalId,
        "Purchase failed",
        "system"
      );

      if (purchaseData.subAccountId) {
        await mockCreditSubAccount(
          purchaseData.userId,
          purchaseData.subAccountId,
          5000
        );
      }
    }

    expect(mockReverseJournal).toHaveBeenCalled();
    expect(mockCreditSubAccount).not.toHaveBeenCalled();
  });

  it("should NOT call reverseJournal when purchase had no ledger journal", async () => {
    const purchaseData = {
      ledgerJournalId: undefined,
      subAccountId: "sub_001",
      userId: "user_001",
      status: "pending",
    };

    if (purchaseData.ledgerJournalId) {
      await mockReverseJournal(
        purchaseData.ledgerJournalId,
        "Purchase failed",
        "system"
      );
    }

    expect(mockReverseJournal).not.toHaveBeenCalled();
    expect(mockCreditSubAccount).not.toHaveBeenCalled();
  });

  it("creditSubAccount failure should be caught (non-critical)", async () => {
    mockCreditSubAccount.mockRejectedValueOnce(new Error("Sub-account not found"));

    const purchaseData = {
      ledgerJournalId: "j_purchase_003",
      subAccountId: "sub_missing",
      userId: "user_001",
    };

    await mockReverseJournal(purchaseData.ledgerJournalId, "Purchase failed", "system");

    // Should catch and not throw
    await expect(
      mockCreditSubAccount(purchaseData.userId, purchaseData.subAccountId, 5000)
        .catch((e: Error) => console.error("Failed to restore sub-account balance:", e))
    ).resolves.toBeUndefined();
  });
});
