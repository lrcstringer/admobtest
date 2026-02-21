/**
 * Earn Thread Test Fixtures
 *
 * Provides mock thread data for testing thread management,
 * targeting, and client-funded token flows.
 */

import { createTimestamp } from "../mocks/firestore.mock";

// Helper functions
const daysAgo = (days: number): Date => {
  const date = new Date();
  date.setDate(date.getDate() - days);
  return date;
};

const daysFromNow = (days: number): Date => {
  const date = new Date();
  date.setDate(date.getDate() + days);
  return date;
};

/**
 * Standard active thread with client but no explicit token source.
 * processEngagement falls back to AccountId.client(clientId) for token source.
 */
export const activeThread = {
  id: "thread_001",
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#FF5733",
  title: "Test Brand Opportunities",
  description: "Earn tokens with Test Brand",
  isPinned: false,
  isFeatured: false,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: null, // No explicit token source — uses clientId fallback
  tokenDestAccountTypeId: null,
  availableOpportunities: 5,
  completedOpportunities: 100,
  completedUniqueUsers: 50,
  targeting: null,
  createdAt: createTimestamp(daysAgo(30)),
  updatedAt: createTimestamp(daysAgo(1)),
  lastActivityAt: createTimestamp(daysAgo(1)),
};

/**
 * Thread with client funding (for budget validation tests)
 */
export const clientFundedActiveThread = {
  id: "thread_funded_001",
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#FF5733",
  title: "Test Brand Opportunities",
  description: "Earn tokens with Test Brand",
  isPinned: false,
  isFeatured: false,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "client_subacc:sub_client_001",
  tokenDestAccountTypeId: null,
  availableOpportunities: 5,
  completedOpportunities: 100,
  completedUniqueUsers: 50,
  targeting: null,
  createdAt: createTimestamp(daysAgo(30)),
  updatedAt: createTimestamp(daysAgo(1)),
  lastActivityAt: createTimestamp(daysAgo(1)),
};

/**
 * Featured thread (shows first)
 */
export const featuredThread = {
  id: "thread_featured_001",
  clientId: "client_002",
  clientName: "Premium Brand",
  clientAvatarImage: "https://example.com/avatar.png",
  clientAvatarColor: "#33FF57",
  title: "Premium Brand Specials",
  description: "Exclusive premium opportunities",
  isPinned: false,
  isFeatured: true,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "sub_client_002",
  tokenDestAccountTypeId: null,
  availableOpportunities: 3,
  completedOpportunities: 200,
  completedUniqueUsers: 150,
  targeting: null,
  createdAt: createTimestamp(daysAgo(60)),
  updatedAt: createTimestamp(daysAgo(2)),
  lastActivityAt: createTimestamp(daysAgo(2)),
};

/**
 * Pinned thread (shows first, above featured)
 */
export const pinnedThread = {
  id: "thread_pinned_001",
  clientId: "client_003",
  clientName: "Priority Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#5733FF",
  title: "Priority Opportunities",
  description: "Don't miss these opportunities",
  isPinned: true,
  isFeatured: false,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "sub_client_003",
  tokenDestAccountTypeId: null,
  availableOpportunities: 2,
  completedOpportunities: 50,
  completedUniqueUsers: 30,
  targeting: null,
  createdAt: createTimestamp(daysAgo(14)),
  updatedAt: createTimestamp(daysAgo(1)),
  lastActivityAt: createTimestamp(daysAgo(1)),
};

/**
 * Thread with targeting criteria
 */
export const targetedThread = {
  id: "thread_targeted_001",
  clientId: "client_004",
  clientName: "Sports Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#FFD700",
  title: "Sports Fan Opportunities",
  description: "For sports enthusiasts only",
  isPinned: false,
  isFeatured: false,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "sub_client_004",
  tokenDestAccountTypeId: null,
  availableOpportunities: 4,
  completedOpportunities: 80,
  completedUniqueUsers: 60,
  targeting: {
    genders: ["male"],
    ageMin: 18,
    ageMax: 45,
    provinces: ["gauteng", "western_cape"],
    cities: null,
    languages: null,
    interests: ["sports"],
    devicePlatforms: null,
    accountAgeMinDays: 7,
    accountAgeMaxDays: null,
    engagementLevel: ["active"],
    previousBrandInteraction: null,
    maxAudience: 1000,
  },
  createdAt: createTimestamp(daysAgo(21)),
  updatedAt: createTimestamp(daysAgo(3)),
  lastActivityAt: createTimestamp(daysAgo(3)),
};

/**
 * Scheduled thread (future start date)
 */
export const scheduledThread = {
  id: "thread_scheduled_001",
  clientId: "client_005",
  clientName: "Future Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#00CED1",
  title: "Coming Soon",
  description: "Launching next week",
  isPinned: false,
  isFeatured: false,
  isActive: true,
  activeFrom: createTimestamp(daysFromNow(7)), // Starts in 7 days
  activeTo: createTimestamp(daysFromNow(37)), // Ends in 37 days
  tokenSourceAccountId: "sub_client_005",
  tokenDestAccountTypeId: null,
  availableOpportunities: 10,
  completedOpportunities: 0,
  completedUniqueUsers: 0,
  targeting: null,
  createdAt: createTimestamp(daysAgo(3)),
  updatedAt: createTimestamp(daysAgo(1)),
  lastActivityAt: null,
};

/**
 * Expired thread (past end date)
 */
export const expiredThread = {
  id: "thread_expired_001",
  clientId: "client_006",
  clientName: "Past Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#808080",
  title: "Expired Campaign",
  description: "This campaign has ended",
  isPinned: false,
  isFeatured: false,
  isActive: true,
  activeFrom: createTimestamp(daysAgo(30)),
  activeTo: createTimestamp(daysAgo(1)), // Ended yesterday
  tokenSourceAccountId: "sub_client_006",
  tokenDestAccountTypeId: null,
  availableOpportunities: 0,
  completedOpportunities: 500,
  completedUniqueUsers: 300,
  targeting: null,
  createdAt: createTimestamp(daysAgo(35)),
  updatedAt: createTimestamp(daysAgo(1)),
  lastActivityAt: createTimestamp(daysAgo(2)),
};

/**
 * Inactive thread
 */
export const inactiveThread = {
  id: "thread_inactive_001",
  clientId: "client_007",
  clientName: "Paused Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#A9A9A9",
  title: "Paused Campaign",
  description: "Temporarily paused",
  isPinned: false,
  isFeatured: false,
  isActive: false, // Manually deactivated
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "sub_client_007",
  tokenDestAccountTypeId: null,
  availableOpportunities: 3,
  completedOpportunities: 150,
  completedUniqueUsers: 100,
  targeting: null,
  createdAt: createTimestamp(daysAgo(45)),
  updatedAt: createTimestamp(daysAgo(5)),
  lastActivityAt: createTimestamp(daysAgo(10)),
};

/**
 * Thread with brand-restricted wallet destination
 */
export const brandWalletThread = {
  id: "thread_brand_wallet_001",
  clientId: "client_008",
  clientName: "Loyalty Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#9370DB",
  title: "Loyalty Rewards",
  description: "Earn tokens for loyalty program",
  isPinned: false,
  isFeatured: true,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "sub_client_008",
  tokenDestAccountTypeId: "brand_loyalty", // Restricted wallet type
  availableOpportunities: 6,
  completedOpportunities: 75,
  completedUniqueUsers: 40,
  targeting: null,
  createdAt: createTimestamp(daysAgo(20)),
  updatedAt: createTimestamp(daysAgo(2)),
  lastActivityAt: createTimestamp(daysAgo(2)),
};

/**
 * Thread with max audience reached
 */
export const maxAudienceThread = {
  id: "thread_max_audience_001",
  clientId: "client_009",
  clientName: "Limited Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#FF6347",
  title: "Limited Audience Campaign",
  description: "Only for first 100 users",
  isPinned: false,
  isFeatured: false,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "sub_client_009",
  tokenDestAccountTypeId: null,
  availableOpportunities: 5,
  completedOpportunities: 250,
  completedUniqueUsers: 100, // Reached max
  targeting: {
    maxAudience: 100, // Max 100 unique users
  },
  createdAt: createTimestamp(daysAgo(10)),
  updatedAt: createTimestamp(daysAgo(1)),
  lastActivityAt: createTimestamp(daysAgo(1)),
};

/**
 * Thread with empty opportunities
 */
export const emptyThread = {
  id: "thread_empty_001",
  clientId: "client_010",
  clientName: "Empty Brand",
  clientAvatarImage: null,
  clientAvatarColor: "#DCDCDC",
  title: "Coming Soon",
  description: "Opportunities coming soon",
  isPinned: false,
  isFeatured: false,
  isActive: true,
  activeFrom: null,
  activeTo: null,
  tokenSourceAccountId: "sub_client_010",
  tokenDestAccountTypeId: null,
  availableOpportunities: 0,
  completedOpportunities: 0,
  completedUniqueUsers: 0,
  targeting: null,
  createdAt: createTimestamp(daysAgo(5)),
  updatedAt: createTimestamp(daysAgo(1)),
  lastActivityAt: null,
};

/**
 * Thread with client-funded budget
 */
export const clientFundedThread = {
  ...activeThread,
  id: "thread_client_funded_001",
  clientId: "client_011",
  clientName: "Funded Brand",
  tokenSourceAccountId: "sub_client_011",
  tokenDestAccountTypeId: null,
};

/**
 * Thread with restricted wallet destination
 */
export const restrictedWalletThread = {
  ...brandWalletThread,
  id: "thread_restricted_wallet_001",
};

/**
 * Thread with depleted budget
 */
export const depletedBudgetThread = {
  ...activeThread,
  id: "thread_depleted_001",
  clientId: "client_012",
  clientName: "Depleted Brand",
  tokenSourceAccountId: "sub_depleted_001",
  isActive: true, // Still active but budget is depleted
};

/**
 * All thread fixtures for iteration
 */
export const allThreadFixtures = [
  activeThread,
  featuredThread,
  pinnedThread,
  targetedThread,
  scheduledThread,
  expiredThread,
  inactiveThread,
  brandWalletThread,
  maxAudienceThread,
  emptyThread,
];

/**
 * Create a custom thread fixture
 */
export function createThreadFixture(
  overrides: Partial<typeof activeThread>
): typeof activeThread {
  return {
    ...activeThread,
    id: `thread_custom_${Date.now()}`,
    ...overrides,
  };
}
