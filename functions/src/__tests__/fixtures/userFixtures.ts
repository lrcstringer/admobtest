/**
 * User Test Fixtures
 *
 * Provides mock user data for testing targeting, eligibility, and engagement flows.
 */

import { createTimestamp } from "../mocks/firestore.mock";

// Helper to create dates relative to now
const daysAgo = (days: number): Date => {
  const date = new Date();
  date.setDate(date.getDate() - days);
  return date;
};

const yearsAgo = (years: number): Date => {
  const date = new Date();
  date.setFullYear(date.getFullYear() - years);
  return date;
};

/**
 * Standard active user with complete profile
 */
export const activeUser = {
  id: "user_active_001",
  email: "active@test.com",
  phoneNumber: "+27821234567",
  displayName: "Active User",
  // Profile fields
  gender: "male",
  dateOfBirth: createTimestamp(yearsAgo(28)), // 28 years old
  province: "gauteng",
  city: "Johannesburg",
  languages: ["en", "zu"],
  interests: ["sports", "technology"],
  // Account metadata
  createdAt: createTimestamp(daysAgo(90)), // 90 days old
  lastLoginAt: createTimestamp(daysAgo(1)),
  // Engagement tracking
  interactedClientIds: ["client_001"],
  bonusEngineState: null,
  opportunityCompletions: {},
};

/**
 * New user (< 7 days old) for engagement level testing
 */
export const newUser = {
  id: "user_new_001",
  email: "newuser@test.com",
  phoneNumber: "+27829876543",
  displayName: "New User",
  gender: "female",
  dateOfBirth: createTimestamp(yearsAgo(22)), // 22 years old
  province: "western_cape",
  city: "Cape Town",
  languages: ["en", "af"],
  interests: ["music", "fashion"],
  createdAt: createTimestamp(daysAgo(3)), // 3 days old (new)
  lastLoginAt: createTimestamp(new Date()),
  interactedClientIds: [],
  bonusEngineState: null,
  opportunityCompletions: {},
};

/**
 * Dormant user (no activity in 30+ days)
 */
export const dormantUser = {
  id: "user_dormant_001",
  email: "dormant@test.com",
  phoneNumber: "+27823334444",
  displayName: "Dormant User",
  gender: "male",
  dateOfBirth: createTimestamp(yearsAgo(35)), // 35 years old
  province: "kwazulu_natal",
  city: "Durban",
  languages: ["en", "zu"],
  interests: ["sports"],
  createdAt: createTimestamp(daysAgo(180)), // 6 months old
  lastLoginAt: createTimestamp(daysAgo(45)), // Last active 45 days ago
  interactedClientIds: ["client_001", "client_002"],
  bonusEngineState: null,
  opportunityCompletions: {},
};

/**
 * User with incomplete profile (no gender, DOB)
 */
export const incompleteProfileUser = {
  id: "user_incomplete_001",
  email: "incomplete@test.com",
  phoneNumber: "+27824445555",
  displayName: "Incomplete User",
  gender: null,
  dateOfBirth: null,
  province: null,
  city: null,
  languages: [],
  interests: [],
  createdAt: createTimestamp(daysAgo(30)),
  lastLoginAt: createTimestamp(daysAgo(2)),
  interactedClientIds: [],
  bonusEngineState: null,
  opportunityCompletions: {},
};

/**
 * User with bonus engine state (for bonus algorithm testing)
 */
export const userWithBonusState = {
  id: "user_bonus_001",
  email: "bonus@test.com",
  phoneNumber: "+27825556666",
  displayName: "Bonus User",
  gender: "female",
  dateOfBirth: createTimestamp(yearsAgo(30)),
  province: "gauteng",
  city: "Pretoria",
  languages: ["en"],
  interests: ["technology"],
  createdAt: createTimestamp(daysAgo(60)),
  lastLoginAt: createTimestamp(new Date()),
  interactedClientIds: ["client_001"],
  bonusEngineState: {
    totalVideosWatched: 20,
    totalBonusesAwarded: 4,
    totalEligible: 18,
    videosSinceLastBonus: 5,
    recentResults: [false, false, false, false, false],
  },
  opportunityCompletions: {
    opp_001: 5,
    opp_002: 3,
  },
};

/**
 * User with opportunity completion history (for every_x bonus testing)
 */
export const userWithCompletionHistory = {
  id: "user_completions_001",
  email: "completions@test.com",
  phoneNumber: "+27826667777",
  displayName: "Completion User",
  gender: "male",
  dateOfBirth: createTimestamp(yearsAgo(25)),
  province: "eastern_cape",
  city: "Port Elizabeth",
  languages: ["en", "xh"],
  interests: ["music", "gaming"],
  createdAt: createTimestamp(daysAgo(120)),
  lastLoginAt: createTimestamp(new Date()),
  interactedClientIds: ["client_001", "client_002", "client_003"],
  bonusEngineState: null,
  opportunityCompletions: {
    opp_every_x_001: 4, // Next completion (5th) should trigger bonus
    opp_every_x_002: 9, // Next completion (10th) should trigger bonus
  },
};

/**
 * User with 29 daily completions (at limit boundary)
 */
export const userAtDailyLimit = {
  id: "user_limit_001",
  email: "limit@test.com",
  phoneNumber: "+27827778888",
  displayName: "Limit User",
  gender: "female",
  dateOfBirth: createTimestamp(yearsAgo(27)),
  province: "gauteng",
  city: "Johannesburg",
  languages: ["en"],
  interests: ["sports"],
  createdAt: createTimestamp(daysAgo(60)),
  lastLoginAt: createTimestamp(new Date()),
  interactedClientIds: [],
  bonusEngineState: null,
  opportunityCompletions: {},
  // Note: Daily completions are tracked separately in engagements collection
};

/**
 * User on Android device
 */
export const androidUser = {
  id: "user_android_001",
  email: "android@test.com",
  phoneNumber: "+27828889999",
  displayName: "Android User",
  gender: "male",
  dateOfBirth: createTimestamp(yearsAgo(32)),
  province: "limpopo",
  city: "Polokwane",
  languages: ["en", "st"],
  interests: ["sports", "news"],
  createdAt: createTimestamp(daysAgo(45)),
  lastLoginAt: createTimestamp(new Date()),
  interactedClientIds: [],
  bonusEngineState: null,
  opportunityCompletions: {},
};

/**
 * User on iOS device
 */
export const iosUser = {
  id: "user_ios_001",
  email: "ios@test.com",
  phoneNumber: "+27829990000",
  displayName: "iOS User",
  gender: "female",
  dateOfBirth: createTimestamp(yearsAgo(29)),
  province: "western_cape",
  city: "Stellenbosch",
  languages: ["en", "af"],
  interests: ["fashion", "food"],
  createdAt: createTimestamp(daysAgo(30)),
  lastLoginAt: createTimestamp(new Date()),
  interactedClientIds: [],
  bonusEngineState: null,
  opportunityCompletions: {},
};

/**
 * All user fixtures for iteration
 */
export const allUserFixtures = [
  activeUser,
  newUser,
  dormantUser,
  incompleteProfileUser,
  userWithBonusState,
  userWithCompletionHistory,
  userAtDailyLimit,
  androidUser,
  iosUser,
];

/**
 * Create a custom user fixture
 */
export function createUserFixture(
  overrides: Partial<typeof activeUser>
): typeof activeUser {
  return {
    ...activeUser,
    id: `user_custom_${Date.now()}`,
    ...overrides,
  };
}
