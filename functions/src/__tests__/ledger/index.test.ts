/**
 * Ledger Index Tests
 *
 * Comprehensive test suite for Trust Ledger high-level transaction functions.
 * Tests cover all main operations: earning, pot wins, purchases, referrals,
 * P2P transfers, and cashouts.
 */

import {
  resetMocks,
} from "../mocks/admin.mock";

// Reset mocks before importing the module under test
jest.mock("firebase-admin", () => require("../mocks/admin.mock").mockFirebaseAdmin);

// Mock the sub-module imports
jest.mock("../../ledger/accounts", () => ({
  getOrCreateUserAccount: jest.fn().mockResolvedValue({ id: "user:test_user" }),
  createSupplierAccount: jest.fn().mockResolvedValue({ id: "supplier:test_supplier" }),
}));

jest.mock("../../ledger/journals", () => ({
  postJournal: jest.fn().mockResolvedValue({
    success: true,
    journalId: "journal_123",
    isDuplicate: false,
    data: { id: "journal_123" },
  }),
  createEarningEntries: jest.fn().mockReturnValue([
    { accountId: "system:treasury", entryType: "debit", amount: 100 },
    { accountId: "user:test_user", entryType: "credit", amount: 90 },
    { accountId: "pot:daily", entryType: "credit", amount: 5 },
    { accountId: "pot:weekly", entryType: "credit", amount: 5 },
  ]),
  createReferralEntries: jest.fn().mockReturnValue([
    { accountId: "system:referrals", entryType: "debit", amount: 200 },
    { accountId: "user:referrer", entryType: "credit", amount: 100 },
    { accountId: "user:referee", entryType: "credit", amount: 100 },
  ]),
  createTransferEntries: jest.fn().mockReturnValue([
    { accountId: "user:sender", entryType: "debit", amount: 100 },
    { accountId: "user:recipient", entryType: "credit", amount: 100 },
  ]),
}));

jest.mock("../../ledger/subAccounts", () => ({
  getOrCreateDefaultSubAccount: jest.fn().mockResolvedValue({
    subAccountId: "default_sub",
    isNew: false,
  }),
  getSubAccount: jest.fn().mockResolvedValue({
    id: "sub_123",
    balance: 1000,
    accountTypeId: "default",
    isActive: true,
  }),
  creditSubAccount: jest.fn().mockResolvedValue({ success: true }),
  debitSubAccount: jest.fn().mockResolvedValue({ success: true }),
}));

import * as ledger from "../../ledger/index";
import { getOrCreateUserAccount, createSupplierAccount } from "../../ledger/accounts";
import { postJournal, createEarningEntries } from "../../ledger/journals";
import { getOrCreateDefaultSubAccount, getSubAccount, creditSubAccount, debitSubAccount } from "../../ledger/subAccounts";

describe("Ledger Index - High-Level Transactions", () => {
  beforeEach(() => {
    resetMocks();
    jest.clearAllMocks();
    // Reset default mock implementations
    (postJournal as jest.Mock).mockResolvedValue({
      success: true,
      journalId: "journal_123",
      isDuplicate: false,
      data: { id: "journal_123" },
    });
    (getSubAccount as jest.Mock).mockResolvedValue({
      id: "sub_123",
      balance: 1000,
      accountTypeId: "default",
      isActive: true,
    });
  });

  describe("processEarningWithSplit", () => {
    it("should create user account if not exists", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(getOrCreateUserAccount).toHaveBeenCalledWith("user_001");
    });

    it("should get or create default sub-account when not provided", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(getOrCreateDefaultSubAccount).toHaveBeenCalledWith("user_001");
    });

    it("should use provided sub-account when specified", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "custom_sub"
      );

      expect(getOrCreateDefaultSubAccount).not.toHaveBeenCalled();
    });

    it("should calculate correct 90/5/5 split", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            totalAmount: 100,
            userShare: 90,
            dailyPotShare: 5,
            weeklyPotShare: 5,
          }),
        })
      );
    });

    it("should handle rounding for odd amounts", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        101,
        "eng_001",
        "Test earning"
      );

      // 90% of 101 = 90.9 -> 90
      // 5% of 101 = 5.05 -> 5
      // Remainder = 101 - 90 - 5 = 6
      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            totalAmount: 101,
            userShare: 90,
            dailyPotShare: 5,
            weeklyPotShare: 6,
          }),
        })
      );
    });

    it("should use treasury as source for non-client-funded", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(createEarningEntries).toHaveBeenCalledWith(
        "user_001",
        100,
        "system:treasury"
      );
    });

    it("should use client account as source for client-funded", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        undefined,
        null,
        undefined,
        "client_001",
        "sub_client_001"
      );

      expect(createEarningEntries).toHaveBeenCalledWith(
        "user_001",
        100,
        "client:client_001"
      );
    });

    it("should credit user sub-account with their share", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(creditSubAccount).toHaveBeenCalledWith("user_001", "default_sub", 90);
    });

    it("should not credit sub-account for duplicate journal", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should return failure when journal posting fails", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: false,
        error: "Test error",
        errorCode: "TEST_ERROR",
      });

      const result = await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(result.success).toBe(false);
      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should include custom metadata", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        undefined,
        null,
        { customField: "value" }
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            customField: "value",
          }),
        })
      );
    });

    it("should use correct idempotency key format", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "earn:eng_001",
          type: "earn",
        })
      );
    });
  });

  describe("processPotWin", () => {
    it("should create winner account if not exists", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(getOrCreateUserAccount).toHaveBeenCalledWith("winner_001");
    });

    it("should get or create default sub-account when not provided", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(getOrCreateDefaultSubAccount).toHaveBeenCalledWith("winner_001");
    });

    it("should use provided sub-account when specified", async () => {
      await ledger.processPotWin(
        "daily",
        "winner_001",
        5000,
        "draw_001",
        "custom_sub"
      );

      expect(getOrCreateDefaultSubAccount).not.toHaveBeenCalled();
    });

    it("should use daily pot account for daily wins", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "pot:daily",
              entryType: "debit",
            }),
          ]),
        })
      );
    });

    it("should use weekly pot account for weekly wins", async () => {
      await ledger.processPotWin("weekly", "winner_001", 10000, "draw_001");

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "pot:weekly",
              entryType: "debit",
            }),
          ]),
        })
      );
    });

    it("should credit winner with full pot amount", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(creditSubAccount).toHaveBeenCalledWith("winner_001", "default_sub", 5000);
    });

    it("should not credit for duplicate journal", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "pot_win:draw_001:winner_001",
          type: "pot_win",
        })
      );
    });
  });

  describe("processPurchaseTransaction", () => {
    it("should create user and supplier accounts", async () => {
      await ledger.processPurchaseTransaction(
        "user_001",
        "vodacom",
        "Vodacom",
        100,
        "purchase_001",
        "sub_001"
      );

      expect(getOrCreateUserAccount).toHaveBeenCalledWith("user_001");
      expect(createSupplierAccount).toHaveBeenCalledWith("vodacom", "Vodacom");
    });

    it("should validate sub-account balance before purchase", async () => {
      await ledger.processPurchaseTransaction(
        "user_001",
        "vodacom",
        "Vodacom",
        100,
        "purchase_001",
        "sub_001"
      );

      expect(getSubAccount).toHaveBeenCalledWith("user_001", "sub_001");
    });

    it("should return error when sub-account not found", async () => {
      (getSubAccount as jest.Mock).mockResolvedValue(null);

      const result = await ledger.processPurchaseTransaction(
        "user_001",
        "vodacom",
        "Vodacom",
        100,
        "purchase_001",
        "sub_001"
      );

      expect(result.success).toBe(false);
      expect(result.errorCode).toBe("SUB_ACCOUNT_NOT_FOUND");
    });

    it("should return error when balance insufficient", async () => {
      (getSubAccount as jest.Mock).mockResolvedValue({
        id: "sub_001",
        balance: 50, // Less than purchase amount
        accountTypeId: "default",
        isActive: true,
      });

      const result = await ledger.processPurchaseTransaction(
        "user_001",
        "vodacom",
        "Vodacom",
        100,
        "purchase_001",
        "sub_001"
      );

      expect(result.success).toBe(false);
      expect(result.errorCode).toBe("INSUFFICIENT_SUB_ACCOUNT_BALANCE");
    });

    it("should debit user sub-account on success", async () => {
      await ledger.processPurchaseTransaction(
        "user_001",
        "vodacom",
        "Vodacom",
        100,
        "purchase_001",
        "sub_001"
      );

      expect(debitSubAccount).toHaveBeenCalledWith("user_001", "sub_001", 100);
    });

    it("should not debit for duplicate journal", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processPurchaseTransaction(
        "user_001",
        "vodacom",
        "Vodacom",
        100,
        "purchase_001",
        "sub_001"
      );

      expect(debitSubAccount).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.processPurchaseTransaction(
        "user_001",
        "vodacom",
        "Vodacom",
        100,
        "purchase_001",
        "sub_001"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "purchase:purchase_001",
          type: "purchase",
        })
      );
    });
  });

  describe("processReferralRewards", () => {
    it("should create both referrer and referee accounts", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(getOrCreateUserAccount).toHaveBeenCalledWith("referrer_001");
      expect(getOrCreateUserAccount).toHaveBeenCalledWith("referee_001");
    });

    it("should get or create default sub-accounts for both users", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(getOrCreateDefaultSubAccount).toHaveBeenCalledWith("referrer_001");
      expect(getOrCreateDefaultSubAccount).toHaveBeenCalledWith("referee_001");
    });

    it("should use provided sub-accounts when specified", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001",
        "referrer_sub",
        "referee_sub"
      );

      expect(getOrCreateDefaultSubAccount).not.toHaveBeenCalledWith("referrer_001");
      expect(getOrCreateDefaultSubAccount).not.toHaveBeenCalledWith("referee_001");
    });

    it("should credit both sub-accounts on success", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(creditSubAccount).toHaveBeenCalledTimes(2);
    });

    it("should not credit for duplicate journal", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "referral:referral_001",
          type: "referral_reward",
        })
      );
    });
  });

  describe("processP2PTransfer", () => {
    it("should create both sender and recipient accounts", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(getOrCreateUserAccount).toHaveBeenCalledWith("sender_001");
      expect(getOrCreateUserAccount).toHaveBeenCalledWith("recipient_001");
    });

    it("should validate sender sub-account balance", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(getSubAccount).toHaveBeenCalledWith("sender_001", "sender_sub");
    });

    it("should return error when sender sub-account not found", async () => {
      (getSubAccount as jest.Mock).mockResolvedValue(null);

      const result = await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(result.success).toBe(false);
      expect(result.errorCode).toBe("SUB_ACCOUNT_NOT_FOUND");
    });

    it("should return error when sender balance insufficient", async () => {
      (getSubAccount as jest.Mock).mockResolvedValue({
        id: "sender_sub",
        balance: 50, // Less than transfer amount
        accountTypeId: "default",
        isActive: true,
      });

      const result = await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(result.success).toBe(false);
      expect(result.errorCode).toBe("INSUFFICIENT_SUB_ACCOUNT_BALANCE");
    });

    it("should get or create recipient default sub-account when not provided", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(getOrCreateDefaultSubAccount).toHaveBeenCalledWith("recipient_001");
    });

    it("should use provided recipient sub-account when specified", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub",
        "recipient_sub"
      );

      expect(getOrCreateDefaultSubAccount).not.toHaveBeenCalledWith("recipient_001");
    });

    it("should debit sender and credit recipient on success", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(debitSubAccount).toHaveBeenCalledWith("sender_001", "sender_sub", 100);
      expect(creditSubAccount).toHaveBeenCalledWith("recipient_001", "default_sub", 100);
    });

    it("should not transfer for duplicate journal", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(debitSubAccount).not.toHaveBeenCalled();
      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should include message in metadata when provided", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub",
        undefined,
        "Thanks!"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            message: "Thanks!",
          }),
        })
      );
    });

    it("should use correct idempotency key format", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "p2p:transfer_001",
          type: "p2p_transfer",
        })
      );
    });
  });

  describe("initiateCashout", () => {
    it("should validate sub-account exists", async () => {
      await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(getSubAccount).toHaveBeenCalledWith("user_001", "sub_001");
    });

    it("should return error when sub-account not found", async () => {
      (getSubAccount as jest.Mock).mockResolvedValue(null);

      const result = await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(result.success).toBe(false);
      expect(result.errorCode).toBe("SUB_ACCOUNT_NOT_FOUND");
    });

    it("should return error when balance insufficient", async () => {
      (getSubAccount as jest.Mock).mockResolvedValue({
        id: "sub_001",
        balance: 100, // Less than cashout amount
        accountTypeId: "default",
        isActive: true,
      });

      const result = await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(result.success).toBe(false);
      expect(result.errorCode).toBe("INSUFFICIENT_SUB_ACCOUNT_BALANCE");
    });

    it("should create journal entries for user to pending transfer", async () => {
      await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "user:user_001",
              entryType: "debit",
            }),
            expect.objectContaining({
              accountId: "cashout:pending",
              entryType: "credit",
            }),
          ]),
        })
      );
    });

    it("should debit user sub-account on success", async () => {
      await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(debitSubAccount).toHaveBeenCalledWith("user_001", "sub_001", 500);
    });

    it("should not debit for duplicate journal", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(debitSubAccount).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "cashout_init:cashout_001",
          type: "cashout_initiate",
        })
      );
    });
  });

  describe("completeCashout", () => {
    it("should create journal entries for pending to treasury transfer", async () => {
      await ledger.completeCashout("cashout_001", 500);

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "cashout:pending",
              entryType: "debit",
            }),
            expect.objectContaining({
              accountId: "system:treasury",
              entryType: "credit",
            }),
          ]),
        })
      );
    });

    it("should use correct idempotency key format", async () => {
      await ledger.completeCashout("cashout_001", 500);

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "cashout_complete:cashout_001",
          type: "cashout_complete",
        })
      );
    });

    it("should include metadata when provided", async () => {
      await ledger.completeCashout("cashout_001", 500, { bankRef: "ref_123" });

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            bankRef: "ref_123",
            amount: 500,
          }),
        })
      );
    });
  });

  describe("failCashout", () => {
    it("should create journal entries for pending to user refund", async () => {
      await ledger.failCashout(
        "user_001",
        "cashout_001",
        500,
        "Bank error",
        "sub_001"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "cashout:pending",
              entryType: "debit",
            }),
            expect.objectContaining({
              accountId: "user:user_001",
              entryType: "credit",
            }),
          ]),
        })
      );
    });

    it("should include failure reason in description", async () => {
      await ledger.failCashout(
        "user_001",
        "cashout_001",
        500,
        "Bank error",
        "sub_001"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          description: expect.stringContaining("Bank error"),
        })
      );
    });

    it("should credit user sub-account on success", async () => {
      await ledger.failCashout(
        "user_001",
        "cashout_001",
        500,
        "Bank error",
        "sub_001"
      );

      expect(creditSubAccount).toHaveBeenCalledWith("user_001", "sub_001", 500);
    });

    it("should not credit for duplicate journal", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.failCashout(
        "user_001",
        "cashout_001",
        500,
        "Bank error",
        "sub_001"
      );

      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.failCashout(
        "user_001",
        "cashout_001",
        500,
        "Bank error",
        "sub_001"
      );

      expect(postJournal).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "cashout_failed:cashout_001",
          type: "cashout_failed",
        })
      );
    });
  });

  describe("seedTreasury", () => {
    it("should return success without creating journal", async () => {
      const result = await ledger.seedTreasury(
        1000000,
        "Initial seed",
        "admin_001"
      );

      expect(result.success).toBe(true);
      expect(result.journalId).toBe("seed_not_required");
    });
  });

  describe("Idempotency", () => {
    it("should handle duplicate earning gracefully", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      const result = await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(result.success).toBe(true);
      expect(result.isDuplicate).toBe(true);
      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should handle duplicate pot win gracefully", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      const result = await ledger.processPotWin(
        "daily",
        "winner_001",
        5000,
        "draw_001"
      );

      expect(result.success).toBe(true);
      expect(result.isDuplicate).toBe(true);
      expect(creditSubAccount).not.toHaveBeenCalled();
    });

    it("should handle duplicate P2P transfer gracefully", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      const result = await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(result.success).toBe(true);
      expect(result.isDuplicate).toBe(true);
      expect(debitSubAccount).not.toHaveBeenCalled();
      expect(creditSubAccount).not.toHaveBeenCalled();
    });
  });

  describe("Error Handling", () => {
    it("should propagate journal posting errors for earning", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: false,
        error: "Database error",
        errorCode: "DB_ERROR",
      });

      const result = await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning"
      );

      expect(result.success).toBe(false);
      expect(result.error).toBe("Database error");
    });

    it("should propagate journal posting errors for pot win", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: false,
        error: "Database error",
        errorCode: "DB_ERROR",
      });

      const result = await ledger.processPotWin(
        "daily",
        "winner_001",
        5000,
        "draw_001"
      );

      expect(result.success).toBe(false);
    });

    it("should propagate journal posting errors for referral", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: false,
        error: "Database error",
        errorCode: "DB_ERROR",
      });

      const result = await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(result.success).toBe(false);
    });

    it("should propagate journal posting errors for cashout initiate", async () => {
      (postJournal as jest.Mock).mockResolvedValue({
        success: false,
        error: "Database error",
        errorCode: "DB_ERROR",
      });

      const result = await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(result.success).toBe(false);
    });
  });
});
