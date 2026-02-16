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
  initializeSystemAccounts: jest.fn().mockResolvedValue(undefined),
}));

// postJournal receives (journalInput, transaction?) — tests only care about journalInput
const _postJournalSpy = jest.fn().mockResolvedValue({
  success: true,
  journalId: "journal_123",
  isDuplicate: false,
  data: { id: "journal_123" },
});

jest.mock("../../ledger/journals", () => ({
  postJournal: (...args: unknown[]) => _postJournalSpy(args[0]),
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

// creditSubAccount/debitSubAccount receive (userId, subId, amount, transaction?)
// Tests only care about the first 3 args
const _creditSubAccountSpy = jest.fn().mockResolvedValue({ success: true });
const _debitSubAccountSpy = jest.fn().mockResolvedValue({ success: true });

jest.mock("../../ledger/subAccounts", () => ({
  getDefaultSubAccount: jest.fn().mockResolvedValue({
    subAccountId: "default_sub",
    isNew: false,
  }),
  getSubAccount: jest.fn().mockResolvedValue({
    id: "sub_123",
    balance: 1000,
    accountTypeId: "default",
    isActive: true,
  }),
  creditSubAccount: (...args: unknown[]) => _creditSubAccountSpy(args[0], args[1], args[2]),
  debitSubAccount: (...args: unknown[]) => _debitSubAccountSpy(args[0], args[1], args[2]),
}));

import * as ledger from "../../ledger/index";
import { getOrCreateUserAccount, createSupplierAccount } from "../../ledger/accounts";
import { createEarningEntries } from "../../ledger/journals";
import { getSubAccount } from "../../ledger/subAccounts";

describe("Ledger Index - High-Level Transactions", () => {
  beforeEach(() => {
    resetMocks();
    jest.clearAllMocks();
    // Reset default mock implementations
    _postJournalSpy.mockResolvedValue({
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
        "Test earning",
        "system:treasury"
      );

      expect(getOrCreateUserAccount).toHaveBeenCalledWith("user_001");
    });

    it("should not credit sub-account when userSubAccountId is not provided", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury"
      );

      // No sub-account provided → tokens go to main wallet only (journal, no sub-account op)
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should credit provided sub-account when specified", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury",
        "custom_sub"
      );

      expect(_creditSubAccountSpy).toHaveBeenCalledWith("user_001", "custom_sub", 90);
    });

    it("should calculate correct 90/5/5 split", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury"
      );

      expect(_postJournalSpy).toHaveBeenCalledWith(
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
        "Test earning",
        "system:treasury"
      );

      // Math.floor(101 * 0.05) = 5 for both pots
      // userShare = 101 - 5 - 5 = 91
      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            totalAmount: 101,
            dailyPotShare: 5,
            weeklyPotShare: 5,
            userShare: 91,
          }),
        })
      );
    });

    it("should use treasury as source for non-client-funded", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury"
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
        "client:client_001",
        undefined,
        null
      );

      expect(createEarningEntries).toHaveBeenCalledWith(
        "user_001",
        100,
        "client:client_001"
      );
    });

    it("should credit user sub-account with their share when sub-account provided", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury",
        "brand_sub_001"
      );

      expect(_creditSubAccountSpy).toHaveBeenCalledWith("user_001", "brand_sub_001", 90);
    });

    it("should not credit sub-account for duplicate journal", async () => {
      _postJournalSpy.mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury"
      );

      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should return failure when journal posting fails", async () => {
      _postJournalSpy.mockResolvedValue({
        success: false,
        error: "Test error",
        errorCode: "TEST_ERROR",
      });

      const result = await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury"
      );

      expect(result.success).toBe(false);
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should include custom metadata", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury",
        undefined,
        null,
        { customField: "value" }
      );

      expect(_postJournalSpy).toHaveBeenCalledWith(
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
        "Test earning",
        "system:treasury"
      );

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

    it("should not credit sub-account when not provided (main wallet)", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      // No subAccountId → tokens go to main wallet (journal only)
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should credit provided sub-account when specified", async () => {
      await ledger.processPotWin(
        "daily",
        "winner_001",
        5000,
        "draw_001",
        "custom_sub"
      );

      expect(_creditSubAccountSpy).toHaveBeenCalledWith("winner_001", "custom_sub", 5000);
    });

    it("should use daily pot account for daily wins", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

    it("should credit winner sub-account with full pot amount when provided", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001", "winner_sub");

      expect(_creditSubAccountSpy).toHaveBeenCalledWith("winner_001", "winner_sub", 5000);
    });

    it("should not credit for duplicate journal", async () => {
      _postJournalSpy.mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.processPotWin("daily", "winner_001", 5000, "draw_001");

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

      expect(_debitSubAccountSpy).toHaveBeenCalledWith("user_001", "sub_001", 100);
    });

    it("should not debit for duplicate journal", async () => {
      _postJournalSpy.mockResolvedValue({
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

      expect(_debitSubAccountSpy).not.toHaveBeenCalled();
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

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

    it("should not credit sub-accounts when not provided (main wallet)", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      // No sub-account IDs → tokens go to main wallet (journal only)
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should credit both sub-accounts when specified", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001",
        "referrer_sub",
        "referee_sub"
      );

      expect(_creditSubAccountSpy).toHaveBeenCalledTimes(2);
    });

    it("should not credit for duplicate journal", async () => {
      _postJournalSpy.mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.processReferralRewards(
        "referrer_001",
        "referee_001",
        "referral_001"
      );

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

    it("should not credit recipient sub-account when not provided (main wallet)", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      // No recipientSubAccountId → recipient receives to main wallet (journal only)
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should credit recipient sub-account when specified", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub",
        "recipient_sub"
      );

      expect(_creditSubAccountSpy).toHaveBeenCalledWith("recipient_001", "recipient_sub", 100);
    });

    it("should debit sender sub-account on success", async () => {
      await ledger.processP2PTransfer(
        "sender_001",
        "recipient_001",
        100,
        "transfer_001",
        "sender_sub"
      );

      expect(_debitSubAccountSpy).toHaveBeenCalledWith("sender_001", "sender_sub", 100);
    });

    it("should not transfer for duplicate journal", async () => {
      _postJournalSpy.mockResolvedValue({
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

      expect(_debitSubAccountSpy).not.toHaveBeenCalled();
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
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

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "user:user_001",
              entryType: "debit",
            }),
            expect.objectContaining({
              accountId: "system:cashout_pending",
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

      expect(_debitSubAccountSpy).toHaveBeenCalledWith("user_001", "sub_001", 500);
    });

    it("should not debit for duplicate journal", async () => {
      _postJournalSpy.mockResolvedValue({
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

      expect(_debitSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.initiateCashout(
        "user_001",
        500,
        "cashout_001",
        "sub_001"
      );

      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "cashout_init:cashout_001",
          type: "cashout_initiate",
        })
      );
    });
  });

  describe("completeCashout", () => {
    it("should create journal entries for pending to supplier transfer", async () => {
      await ledger.completeCashout("cashout_001", 500, "bank_supplier");

      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "system:cashout_pending",
              entryType: "debit",
            }),
            expect.objectContaining({
              accountId: "supplier:bank_supplier",
              entryType: "credit",
            }),
          ]),
        })
      );
    });

    it("should use correct idempotency key format", async () => {
      await ledger.completeCashout("cashout_001", 500, "bank_supplier");

      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "cashout_complete:cashout_001",
          type: "cashout_complete",
        })
      );
    });

    it("should include metadata when provided", async () => {
      await ledger.completeCashout("cashout_001", 500, "bank_supplier", { bankRef: "ref_123" });

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          entries: expect.arrayContaining([
            expect.objectContaining({
              accountId: "system:cashout_pending",
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

      expect(_postJournalSpy).toHaveBeenCalledWith(
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

      expect(_creditSubAccountSpy).toHaveBeenCalledWith("user_001", "sub_001", 500);
    });

    it("should not credit for duplicate journal", async () => {
      _postJournalSpy.mockResolvedValue({
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

      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should use correct idempotency key format", async () => {
      await ledger.failCashout(
        "user_001",
        "cashout_001",
        500,
        "Bank error",
        "sub_001"
      );

      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          idempotencyKey: "cashout_failed:cashout_001",
          type: "cashout_failed",
        })
      );
    });
  });

  describe("Math.floor split verification", () => {
    it("should use Math.floor for 90/5/5 split on odd amounts (107 tokens)", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        107,
        "eng_floor_001",
        "Floor test",
        "system:treasury"
      );

      // Math.floor(107 * 0.05) = Math.floor(5.35) = 5 for both pots
      // userShare = 107 - 5 - 5 = 97
      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            totalAmount: 107,
            dailyPotShare: 5,
            weeklyPotShare: 5,
            userShare: 97,
          }),
        })
      );
    });

    it("should use Math.floor for 90/5/5 split on 1 token (minimum)", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        1,
        "eng_floor_002",
        "Floor test min",
        "system:treasury"
      );

      // Math.floor(1 * 0.05) = Math.floor(0.05) = 0 for both pots
      // userShare = 1 - 0 - 0 = 1
      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            totalAmount: 1,
            dailyPotShare: 0,
            weeklyPotShare: 0,
            userShare: 1,
          }),
        })
      );
    });

    it("should use Math.floor for 90/5/5 split on 99 tokens", async () => {
      await ledger.processEarningWithSplit(
        "user_001",
        99,
        "eng_floor_003",
        "Floor test 99",
        "system:treasury"
      );

      // Math.floor(99 * 0.05) = Math.floor(4.95) = 4 for both pots
      // userShare = 99 - 4 - 4 = 91
      expect(_postJournalSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          metadata: expect.objectContaining({
            totalAmount: 99,
            dailyPotShare: 4,
            weeklyPotShare: 4,
            userShare: 91,
          }),
        })
      );
    });

    it("should ensure split sums to totalAmount (no tokens lost or created)", async () => {
      // Test a range of amounts to verify no rounding errors
      const testAmounts = [1, 10, 19, 50, 99, 100, 101, 107, 200, 999, 1000];

      for (const amount of testAmounts) {
        jest.clearAllMocks();
        _postJournalSpy.mockResolvedValue({
          success: true,
          journalId: `journal_${amount}`,
          isDuplicate: false,
          data: { id: `journal_${amount}` },
        });

        await ledger.processEarningWithSplit(
          "user_001",
          amount,
          `eng_sum_${amount}`,
          `Sum test ${amount}`,
          "system:treasury"
        );

        const callArgs = _postJournalSpy.mock.calls[0][0];
        const meta = callArgs.metadata;
        const total = meta.userShare + meta.dailyPotShare + meta.weeklyPotShare;
        expect(total).toBe(amount);
      }
    });
  });

  describe("Idempotency", () => {
    it("should handle duplicate earning gracefully", async () => {
      _postJournalSpy.mockResolvedValue({
        success: true,
        journalId: "journal_123",
        isDuplicate: true,
      });

      const result = await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury"
      );

      expect(result.success).toBe(true);
      expect(result.isDuplicate).toBe(true);
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should handle duplicate pot win gracefully", async () => {
      _postJournalSpy.mockResolvedValue({
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
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });

    it("should handle duplicate P2P transfer gracefully", async () => {
      _postJournalSpy.mockResolvedValue({
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
      expect(_debitSubAccountSpy).not.toHaveBeenCalled();
      expect(_creditSubAccountSpy).not.toHaveBeenCalled();
    });
  });

  describe("Error Handling", () => {
    it("should propagate journal posting errors for earning", async () => {
      _postJournalSpy.mockResolvedValue({
        success: false,
        error: "Database error",
        errorCode: "DB_ERROR",
      });

      const result = await ledger.processEarningWithSplit(
        "user_001",
        100,
        "eng_001",
        "Test earning",
        "system:treasury"
      );

      expect(result.success).toBe(false);
      expect(result.error).toBe("Database error");
    });

    it("should propagate journal posting errors for pot win", async () => {
      _postJournalSpy.mockResolvedValue({
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
      _postJournalSpy.mockResolvedValue({
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
      _postJournalSpy.mockResolvedValue({
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
