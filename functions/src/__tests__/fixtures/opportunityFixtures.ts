/**
 * Earn Opportunity Test Fixtures
 *
 * Provides mock opportunity data for testing engagement flows, bonus rewards,
 * and targeting functionality.
 */

import { createTimestamp } from "../mocks/firestore.mock";

// Helper to create future dates
const daysFromNow = (days: number): Date => {
  const date = new Date();
  date.setDate(date.getDate() + days);
  return date;
};

const daysAgo = (days: number): Date => {
  const date = new Date();
  date.setDate(date.getDate() - days);
  return date;
};

/**
 * Standard video opportunity
 */
export const videoOpportunity = {
  id: "opp_video_001",
  threadId: "thread_001",
  title: "Watch Product Demo Video",
  description: "Watch our product demo and earn tokens",
  earningType: "video",
  tokenReward: 100,
  streakPoints: 1,
  mediaType: "video",
  mediaUrl: "https://example.com/video.mp4",
  questions: [],
  durationSeconds: 30,
  expiresAt: createTimestamp(daysFromNow(30)),
  isActive: true,
  // Client info (denormalized from thread)
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarColor: "#FF5733",
  // No bonus
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  // No targeting
  targeting: null,
  createdAt: createTimestamp(daysAgo(7)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Survey opportunity with questions
 */
export const surveyOpportunity = {
  id: "opp_survey_001",
  threadId: "thread_001",
  title: "Brand Awareness Survey",
  description: "Answer questions about our brand",
  earningType: "survey",
  tokenReward: 150,
  streakPoints: 2,
  mediaType: "text",
  mediaUrl: null,
  questions: [
    {
      id: "q1",
      text: "How often do you use our product?",
      options: ["Daily", "Weekly", "Monthly", "Never"],
      orderIndex: 0,
      isAttentionCheck: false,
      correctAnswer: null,
    },
    {
      id: "q2",
      text: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
      orderIndex: 1,
      isAttentionCheck: true,
      correctAnswer: "4",
    },
    {
      id: "q3",
      text: "Would you recommend us to a friend?",
      options: ["Yes", "No", "Maybe"],
      orderIndex: 2,
      isAttentionCheck: false,
      correctAnswer: null,
    },
  ],
  durationSeconds: 60,
  expiresAt: createTimestamp(daysFromNow(14)),
  isActive: true,
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarColor: "#FF5733",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(5)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Poll opportunity
 */
export const pollOpportunity = {
  id: "opp_poll_001",
  threadId: "thread_002",
  title: "Quick Product Poll",
  description: "Tell us your preference",
  earningType: "poll",
  tokenReward: 50,
  streakPoints: 1,
  mediaType: "text",
  mediaUrl: null,
  questions: [
    {
      id: "poll1",
      text: "Which flavor do you prefer?",
      options: ["Vanilla", "Chocolate", "Strawberry", "Other"],
      orderIndex: 0,
      isAttentionCheck: false,
      correctAnswer: null,
    },
  ],
  durationSeconds: 15,
  expiresAt: createTimestamp(daysFromNow(7)),
  isActive: true,
  clientId: "client_002",
  clientName: "Food Brand",
  clientAvatarColor: "#33FF57",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(3)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Opportunity with RANDOM bonus configuration
 */
export const randomBonusOpportunity = {
  id: "opp_bonus_random_001",
  threadId: "thread_001",
  title: "Lucky Bonus Video",
  description: "Watch and maybe win a bonus!",
  earningType: "video",
  tokenReward: 100,
  streakPoints: 1,
  mediaType: "video",
  mediaUrl: "https://example.com/bonus-video.mp4",
  questions: [],
  durationSeconds: 30,
  expiresAt: createTimestamp(daysFromNow(30)),
  isActive: true,
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarColor: "#FF5733",
  // Random bonus config
  bonusReward: true,
  bonusRewardMultiplier: 2.0, // 2x multiplier
  bonusIntervalType: "random",
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(7)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Opportunity with EVERY_X bonus configuration
 */
export const everyXBonusOpportunity = {
  id: "opp_bonus_every_x_001",
  threadId: "thread_001",
  title: "Streak Bonus Video",
  description: "Every 5th completion gets a bonus!",
  earningType: "video",
  tokenReward: 100,
  streakPoints: 1,
  mediaType: "video",
  mediaUrl: "https://example.com/streak-video.mp4",
  questions: [],
  durationSeconds: 30,
  expiresAt: createTimestamp(daysFromNow(30)),
  isActive: true,
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarColor: "#FF5733",
  // Every X bonus config
  bonusReward: true,
  bonusRewardMultiplier: 1.5, // 1.5x multiplier
  bonusIntervalType: "every_x",
  bonusIntervalX: 5, // Every 5th completion
  targeting: null,
  createdAt: createTimestamp(daysAgo(7)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Opportunity with targeting criteria
 */
export const targetedOpportunity = {
  id: "opp_targeted_001",
  threadId: "thread_003",
  title: "Gauteng Sports Fans Only",
  description: "Exclusive for Gauteng sports enthusiasts",
  earningType: "video",
  tokenReward: 200,
  streakPoints: 2,
  mediaType: "video",
  mediaUrl: "https://example.com/sports.mp4",
  questions: [],
  durationSeconds: 45,
  expiresAt: createTimestamp(daysFromNow(21)),
  isActive: true,
  clientId: "client_003",
  clientName: "Sports Brand",
  clientAvatarColor: "#5733FF",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  // Targeting criteria
  targeting: {
    genders: ["male"],
    ageMin: 18,
    ageMax: 45,
    provinces: ["gauteng"],
    cities: null,
    languages: null,
    interests: ["sports"],
    devicePlatforms: null,
    accountAgeMinDays: 7,
    accountAgeMaxDays: null,
    engagementLevel: ["active"],
    previousBrandInteraction: null,
    maxAudience: null,
  },
  createdAt: createTimestamp(daysAgo(10)),
  updatedAt: createTimestamp(daysAgo(2)),
};

/**
 * Expired opportunity
 */
export const expiredOpportunity = {
  id: "opp_expired_001",
  threadId: "thread_001",
  title: "Expired Opportunity",
  description: "This opportunity has expired",
  earningType: "video",
  tokenReward: 100,
  streakPoints: 1,
  mediaType: "video",
  mediaUrl: "https://example.com/expired.mp4",
  questions: [],
  durationSeconds: 30,
  expiresAt: createTimestamp(daysAgo(1)), // Expired yesterday
  isActive: true,
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarColor: "#FF5733",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(30)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Inactive opportunity
 */
export const inactiveOpportunity = {
  id: "opp_inactive_001",
  threadId: "thread_001",
  title: "Inactive Opportunity",
  description: "This opportunity is disabled",
  earningType: "video",
  tokenReward: 100,
  streakPoints: 1,
  mediaType: "video",
  mediaUrl: "https://example.com/inactive.mp4",
  questions: [],
  durationSeconds: 30,
  expiresAt: createTimestamp(daysFromNow(30)),
  isActive: false, // Disabled
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarColor: "#FF5733",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(14)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * High-value survey opportunity (formerly trivia — now survey with attention checks)
 */
export const triviaOpportunity = {
  id: "opp_trivia_001",
  threadId: "thread_002",
  title: "Brain Teaser Challenge",
  description: "Test your knowledge and earn big",
  earningType: "survey",
  tokenReward: 300,
  streakPoints: 3,
  mediaType: "text",
  mediaUrl: null,
  questions: [
    {
      id: "t1",
      text: "What is the capital of South Africa (legislative)?",
      options: ["Pretoria", "Cape Town", "Johannesburg", "Bloemfontein"],
      orderIndex: 0,
      isAttentionCheck: false,
      correctAnswer: "Cape Town",
    },
    {
      id: "t2",
      text: "Which year did South Africa host the FIFA World Cup?",
      options: ["2006", "2010", "2014", "2018"],
      orderIndex: 1,
      isAttentionCheck: false,
      correctAnswer: "2010",
    },
  ],
  durationSeconds: 120,
  expiresAt: createTimestamp(daysFromNow(14)),
  isActive: true,
  clientId: "client_002",
  clientName: "Quiz Brand",
  clientAvatarColor: "#FFD700",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(5)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * AdMob rewarded video opportunity (IMaliChat platform)
 */
export const adMobOpportunity = {
  id: "opp_admob_001",
  threadId: "imalichat_watch_earn",
  title: "Watch Ad",
  description: "Watch a short video ad to earn tokens",
  earningType: "adVideo",
  tokenReward: 5,
  streakPoints: 1,
  mediaType: "adMob",
  mediaUrl: null,
  adUnitId: "ca-app-pub-9331591670168644/1108724925",
  questions: [
    {
      id: "admob_q1",
      text: "Did you watch the full video ad?",
      options: ["Yes, I watched it completely", "Most of it", "Not really"],
      orderIndex: 0,
      isAttentionCheck: true,
      correctAnswer: "Yes, I watched it completely",
    },
  ],
  durationSeconds: 30,
  dailyLimitPerUser: 3,
  expiresAt: null, // No expiry for system opportunities
  isActive: true,
  clientId: "imalichat",
  clientName: "IMaliChat",
  clientAvatarColor: "#4CAF50",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(30)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * Image-based survey opportunity (formerly rating — now survey with likert/star question types)
 */
export const imageOpportunity = {
  id: "opp_image_001",
  threadId: "thread_001",
  title: "View New Product Image",
  description: "Check out our new product and give feedback",
  earningType: "survey",
  tokenReward: 75,
  streakPoints: 1,
  mediaType: "image",
  mediaUrl: "https://example.com/product.jpg",
  questions: [
    {
      id: "r1",
      text: "How would you rate this product design?",
      options: ["1 - Poor", "2 - Fair", "3 - Good", "4 - Excellent"],
      orderIndex: 0,
      isAttentionCheck: false,
      correctAnswer: null,
    },
  ],
  durationSeconds: 20,
  expiresAt: createTimestamp(daysFromNow(7)),
  isActive: true,
  clientId: "client_001",
  clientName: "Test Brand",
  clientAvatarColor: "#FF5733",
  bonusReward: false,
  bonusRewardMultiplier: 1.0,
  bonusIntervalType: null,
  bonusIntervalX: null,
  targeting: null,
  createdAt: createTimestamp(daysAgo(2)),
  updatedAt: createTimestamp(daysAgo(1)),
};

/**
 * All opportunity fixtures for iteration
 */
export const allOpportunityFixtures = [
  videoOpportunity,
  surveyOpportunity,
  pollOpportunity,
  randomBonusOpportunity,
  everyXBonusOpportunity,
  targetedOpportunity,
  expiredOpportunity,
  inactiveOpportunity,
  triviaOpportunity,
  imageOpportunity,
];

/**
 * Create a custom opportunity fixture
 */
export function createOpportunityFixture(
  overrides: Partial<typeof videoOpportunity>
): typeof videoOpportunity {
  return {
    ...videoOpportunity,
    id: `opp_custom_${Date.now()}`,
    ...overrides,
  };
}
