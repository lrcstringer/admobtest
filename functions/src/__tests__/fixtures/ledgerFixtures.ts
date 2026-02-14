/**
 * Ledger Test Fixtures
 *
 * Provides mock data for testing Trust Ledger operations,
 * token splits, and financial transactions.
 */

import { createTimestamp } from "../mocks/firestore.mock";

// Helper functions
const daysAgo = (days: number): Date => {
  const date = new Date();
  date.setDate(date.getDate() - days);
  return date;
};

/**
 * Standard client with healthy budget
 */
export const healthyBudgetClient = {
  id: "client_001",
  name: "Test Brand",
  email: "brand@test.com",
  isActive: true,
  createdAt: createTimestamp(daysAgo(90)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Client sub-account with healthy balance
 */
export const healthySubAccount = {
  id: "sub_client_001",
  accountId: "client:client_001",
  accountTypeId: "brand_main",
  name: "Main Budget",
  balance: 100000, // 100,000 tokens (R1,000)
  isActive: true,
  createdAt: createTimestamp(daysAgo(90)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Client sub-account with low balance (< 20%)
 */
export const lowBalanceSubAccount = {
  id: "sub_client_low_001",
  accountId: "client:client_002",
  accountTypeId: "brand_main",
  name: "Low Budget",
  balance: 1500, // 1,500 tokens (R15) - Below warning threshold
  isActive: true,
  createdAt: createTimestamp(daysAgo(60)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Client sub-account with depleted balance
 */
export const depletedSubAccount = {
  id: "sub_client_depleted_001",
  accountId: "client:client_003",
  accountTypeId: "brand_main",
  name: "Depleted Budget",
  balance: 50, // 50 tokens - Not enough for most engagements
  isActive: true,
  createdAt: createTimestamp(daysAgo(30)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Inactive sub-account
 */
export const inactiveSubAccount = {
  id: "sub_client_inactive_001",
  accountId: "client:client_004",
  accountTypeId: "brand_main",
  name: "Inactive Budget",
  balance: 50000,
  isActive: false, // Deactivated
  createdAt: createTimestamp(daysAgo(90)),
  updatedAt: createTimestamp(daysAgo(7)),
};

/**
 * User ledger account
 */
export const userLedgerAccount = {
  id: "user:user_active_001",
  type: "user",
  name: "Active User",
  balance: 5000, // 5,000 tokens (R50)
  createdAt: createTimestamp(daysAgo(90)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * User default sub-account
 */
export const userDefaultSubAccount = {
  id: "sub_user_001",
  accountId: "user:user_active_001",
  accountTypeId: "default",
  name: "Main Wallet",
  balance: 4500,
  isActive: true,
  createdAt: createTimestamp(daysAgo(90)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * User brand-restricted sub-account
 */
export const userBrandSubAccount = {
  id: "sub_user_brand_001",
  accountId: "user:user_active_001",
  accountTypeId: "brand_loyalty",
  name: "Loyalty Wallet",
  balance: 500,
  isActive: true,
  restrictions: {
    brandId: "client_008",
    usableAt: ["brand_store"],
  },
  createdAt: createTimestamp(daysAgo(20)),
  updatedAt: createTimestamp(daysAgo(2)),
};

/**
 * System treasury account
 */
export const treasuryAccount = {
  id: "system:treasury",
  type: "system",
  name: "Treasury",
  balance: 10000000, // 10 million tokens
  createdAt: createTimestamp(daysAgo(365)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Daily pot account
 */
export const dailyPotAccount = {
  id: "pot:daily",
  type: "pot",
  name: "Daily Pot",
  balance: 25000, // 25,000 tokens
  createdAt: createTimestamp(daysAgo(365)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Weekly pot account
 */
export const weeklyPotAccount = {
  id: "pot:weekly",
  type: "pot",
  name: "Weekly Pot",
  balance: 150000, // 150,000 tokens
  createdAt: createTimestamp(daysAgo(365)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Sample earning journal entry
 */
export const earningJournal = {
  id: "journal_earn_001",
  type: "earning",
  description: "Video completion reward",
  totalAmount: 100,
  entries: [
    {
      accountId: "user:user_active_001",
      amount: 90,
      type: "credit",
      description: "User earning (90%)",
    },
    {
      accountId: "pot:daily",
      amount: 5,
      type: "credit",
      description: "Daily pot contribution (5%)",
    },
    {
      accountId: "pot:weekly",
      amount: 5,
      type: "credit",
      description: "Weekly pot contribution (5%)",
    },
    {
      accountId: "client:client_001",
      amount: 100,
      type: "debit",
      description: "Client budget deduction",
    },
  ],
  metadata: {
    engagementId: "eng_completed_001",
    opportunityId: "opp_video_001",
    threadId: "thread_001",
    userId: "user_active_001",
    clientId: "client_001",
  },
  idempotencyKey: "earn:eng_completed_001",
  status: "posted",
  createdAt: createTimestamp(daysAgo(1)),
  postedAt: createTimestamp(daysAgo(1)),
};

/**
 * Sample earning journal with bonus
 */
export const bonusEarningJournal = {
  id: "journal_earn_bonus_001",
  type: "earning",
  description: "Video completion reward with bonus",
  totalAmount: 200, // 100 * 2x bonus
  entries: [
    {
      accountId: "user:user_active_001",
      amount: 180,
      type: "credit",
      description: "User earning (90%)",
    },
    {
      accountId: "pot:daily",
      amount: 10,
      type: "credit",
      description: "Daily pot contribution (5%)",
    },
    {
      accountId: "pot:weekly",
      amount: 10,
      type: "credit",
      description: "Weekly pot contribution (5%)",
    },
    {
      accountId: "client:client_001",
      amount: 200,
      type: "debit",
      description: "Client budget deduction",
    },
  ],
  metadata: {
    engagementId: "eng_bonus_001",
    opportunityId: "opp_bonus_001",
    threadId: "thread_001",
    userId: "user_active_001",
    clientId: "client_001",
    bonusApplied: true,
    bonusMultiplier: 2.0,
  },
  idempotencyKey: "earn:eng_bonus_001",
  status: "posted",
  createdAt: createTimestamp(daysAgo(1)),
  postedAt: createTimestamp(daysAgo(1)),
};

/**
 * Sample pot win journal
 */
export const potWinJournal = {
  id: "journal_pot_win_001",
  type: "pot_win",
  description: "Daily pot winner",
  totalAmount: 5000,
  entries: [
    {
      accountId: "user:user_active_001",
      amount: 5000,
      type: "credit",
      description: "Pot winnings",
    },
    {
      accountId: "pot:daily",
      amount: 5000,
      type: "debit",
      description: "Pot payout",
    },
  ],
  metadata: {
    potDrawId: "draw_daily_001",
    potType: "daily",
    winnerId: "user_active_001",
  },
  idempotencyKey: "pot_win:draw_daily_001:user_active_001",
  status: "posted",
  createdAt: createTimestamp(daysAgo(1)),
  postedAt: createTimestamp(daysAgo(1)),
};

/**
 * Sample P2P transfer journal
 */
export const p2pTransferJournal = {
  id: "journal_p2p_001",
  type: "p2p_transfer",
  description: "Token transfer",
  totalAmount: 500,
  entries: [
    {
      accountId: "user:user_sender_001",
      amount: 500,
      type: "debit",
      description: "Transfer sent",
    },
    {
      accountId: "user:user_recipient_001",
      amount: 500,
      type: "credit",
      description: "Transfer received",
    },
  ],
  metadata: {
    transferId: "transfer_001",
    senderId: "user_sender_001",
    recipientId: "user_recipient_001",
    message: "Thanks!",
  },
  idempotencyKey: "p2p:transfer_001",
  status: "posted",
  createdAt: createTimestamp(daysAgo(2)),
  postedAt: createTimestamp(daysAgo(2)),
};

/**
 * Account type definition for brand wallets
 */
export const brandAccountType = {
  id: "brand_loyalty",
  name: "Brand Loyalty Wallet",
  description: "Tokens restricted to brand store",
  isRestricted: true,
  restrictions: {
    transferable: false,
    usableAt: ["brand_store"],
  },
  createdAt: createTimestamp(daysAgo(180)),
};

/**
 * Default account type
 */
export const defaultAccountType = {
  id: "default",
  name: "Main Wallet",
  description: "Default unrestricted wallet",
  isRestricted: false,
  restrictions: null,
  createdAt: createTimestamp(daysAgo(365)),
};

/**
 * All ledger fixtures for iteration
 */
export const allLedgerFixtures = {
  accounts: [
    userLedgerAccount,
    treasuryAccount,
    dailyPotAccount,
    weeklyPotAccount,
  ],
  subAccounts: [
    healthySubAccount,
    lowBalanceSubAccount,
    depletedSubAccount,
    inactiveSubAccount,
    userDefaultSubAccount,
    userBrandSubAccount,
  ],
  journals: [
    earningJournal,
    bonusEarningJournal,
    potWinJournal,
    p2pTransferJournal,
  ],
  accountTypes: [brandAccountType, defaultAccountType],
  clients: [healthyBudgetClient],
};

/**
 * Calculate expected token split
 */
export function calculateTokenSplit(totalAmount: number): {
  userShare: number;
  dailyPotShare: number;
  weeklyPotShare: number;
} {
  const dailyPotShare = totalAmount * 0.05;
  const weeklyPotShare = totalAmount * 0.05;
  const userShare = totalAmount - dailyPotShare - weeklyPotShare;
  return { userShare, dailyPotShare, weeklyPotShare };
}

/**
 * Create a custom journal fixture
 */
export function createJournalFixture(
  overrides: Partial<typeof earningJournal>
): typeof earningJournal {
  return {
    ...earningJournal,
    id: `journal_custom_${Date.now()}`,
    idempotencyKey: `custom:${Date.now()}`,
    ...overrides,
  };
}
