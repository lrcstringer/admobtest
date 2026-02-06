/**
 * Engagement Test Fixtures
 *
 * Provides mock engagement data for testing engagement lifecycle,
 * evidence validation, and completion flows.
 */

import { createTimestamp } from "../mocks/firestore.mock";

// Helper functions
const minutesAgo = (minutes: number): Date => {
  const date = new Date();
  date.setMinutes(date.getMinutes() - minutes);
  return date;
};

const hoursAgo = (hours: number): Date => {
  const date = new Date();
  date.setHours(date.getHours() - hours);
  return date;
};

const daysAgo = (days: number): Date => {
  const date = new Date();
  date.setDate(date.getDate() - days);
  return date;
};

/**
 * Just started engagement
 */
export const startedEngagement = {
  id: "eng_started_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_video_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "started",
  rewardAmount: 100,
  streakPoints: 1,
  watchDurationSeconds: 0,
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [],
  tokensEarned: null,
  failureReason: null,
  attemptNumber: 1,
  createdAt: createTimestamp(minutesAgo(5)),
  updatedAt: createTimestamp(minutesAgo(5)),
  completedAt: null,
};

/**
 * Watching engagement (video in progress)
 */
export const watchingEngagement = {
  id: "eng_watching_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_video_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "watching",
  rewardAmount: 100,
  streakPoints: 1,
  watchDurationSeconds: 15, // Half done
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [
    {
      watchDurationMs: 15000,
      videoStartedAt: createTimestamp(minutesAgo(3)),
      screenVisible: true,
      appInForeground: true,
    },
  ],
  tokensEarned: null,
  failureReason: null,
  attemptNumber: 1,
  createdAt: createTimestamp(minutesAgo(5)),
  updatedAt: createTimestamp(minutesAgo(2)),
  completedAt: null,
};

/**
 * Surveying engagement (video complete, answering questions)
 */
export const surveyingEngagement = {
  id: "eng_surveying_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_survey_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "surveying",
  rewardAmount: 150,
  streakPoints: 2,
  watchDurationSeconds: 30, // Video complete
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [
    {
      watchDurationMs: 30000,
      videoStartedAt: createTimestamp(minutesAgo(5)),
      screenVisible: true,
      appInForeground: true,
    },
  ],
  tokensEarned: null,
  failureReason: null,
  attemptNumber: 1,
  createdAt: createTimestamp(minutesAgo(10)),
  updatedAt: createTimestamp(minutesAgo(3)),
  completedAt: null,
};

/**
 * Completed engagement
 */
export const completedEngagement = {
  id: "eng_completed_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_video_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "completed",
  rewardAmount: 100,
  streakPoints: 1,
  watchDurationSeconds: 32,
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [
    {
      watchDurationMs: 32000,
      videoStartedAt: createTimestamp(hoursAgo(1)),
      screenVisible: true,
      appInForeground: true,
      deviceFingerprint: "device_123",
    },
  ],
  tokensEarned: 90, // 90% of 100
  totalTokensGenerated: 100,
  ledgerJournalId: "journal_123",
  failureReason: null,
  attemptNumber: 1,
  bonusApplied: false,
  bonusMultiplier: null,
  streakDayAtCompletion: 3,
  multiplierApplied: 1.2,
  createdAt: createTimestamp(hoursAgo(2)),
  updatedAt: createTimestamp(hoursAgo(1)),
  completedAt: createTimestamp(hoursAgo(1)),
};

/**
 * Completed engagement with bonus applied
 */
export const completedWithBonusEngagement = {
  id: "eng_completed_bonus_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_bonus_random_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "completed",
  rewardAmount: 200, // 100 * 2x bonus multiplier
  streakPoints: 1,
  watchDurationSeconds: 35,
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [
    {
      watchDurationMs: 35000,
      videoStartedAt: createTimestamp(hoursAgo(3)),
      screenVisible: true,
      appInForeground: true,
      deviceFingerprint: "device_123",
    },
  ],
  tokensEarned: 180, // 90% of 200
  totalTokensGenerated: 200,
  ledgerJournalId: "journal_bonus_123",
  failureReason: null,
  attemptNumber: 1,
  bonusApplied: true,
  bonusMultiplier: 2.0,
  streakDayAtCompletion: 5,
  multiplierApplied: 1.2,
  createdAt: createTimestamp(hoursAgo(4)),
  updatedAt: createTimestamp(hoursAgo(3)),
  completedAt: createTimestamp(hoursAgo(3)),
};

/**
 * Failed engagement (evidence validation failed)
 */
export const failedEngagement = {
  id: "eng_failed_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_video_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "failed",
  rewardAmount: 100,
  streakPoints: 1,
  watchDurationSeconds: 5, // Didn't watch enough
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [
    {
      watchDurationMs: 5000, // Only 5 seconds
      videoStartedAt: createTimestamp(hoursAgo(2)),
      screenVisible: false, // Screen wasn't visible
      appInForeground: false,
    },
  ],
  tokensEarned: null,
  failureReason: "Invalid evidence",
  attemptNumber: 1,
  createdAt: createTimestamp(hoursAgo(3)),
  updatedAt: createTimestamp(hoursAgo(2)),
  completedAt: null,
};

/**
 * Abandoned engagement
 */
export const abandonedEngagement = {
  id: "eng_abandoned_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_video_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "abandoned",
  rewardAmount: 100,
  streakPoints: 1,
  watchDurationSeconds: 10,
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [],
  tokensEarned: null,
  failureReason: null,
  attemptNumber: 1,
  createdAt: createTimestamp(hoursAgo(5)),
  updatedAt: createTimestamp(hoursAgo(4)),
  completedAt: null,
};

/**
 * Rewarded engagement (legacy status)
 */
export const rewardedEngagement = {
  id: "eng_rewarded_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_video_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "rewarded",
  rewardAmount: 100,
  streakPoints: 1,
  watchDurationSeconds: 35,
  requiredDurationSeconds: 30,
  answers: [],
  evidence: [
    {
      watchDurationMs: 35000,
      videoStartedAt: createTimestamp(daysAgo(1)),
      screenVisible: true,
      appInForeground: true,
    },
  ],
  tokensEarned: 90,
  totalTokensGenerated: 100,
  ledgerJournalId: "journal_456",
  failureReason: null,
  attemptNumber: 1,
  createdAt: createTimestamp(daysAgo(1)),
  updatedAt: createTimestamp(daysAgo(1)),
  completedAt: createTimestamp(daysAgo(1)),
};

/**
 * Survey engagement ready for submission
 */
export const surveyReadyEngagement = {
  id: "eng_survey_ready_001",
  userId: "user_active_001",
  earnOpportunityId: "opp_survey_001",
  threadId: "thread_001",
  clientId: "client_001",
  status: "surveying",
  rewardAmount: 150,
  streakPoints: 2,
  watchDurationSeconds: 60,
  requiredDurationSeconds: 60,
  answers: [
    {
      questionId: "q1",
      selectedOption: "Daily",
      answeredAt: createTimestamp(minutesAgo(2)),
    },
    {
      questionId: "q2",
      selectedOption: "4", // Correct attention check
      answeredAt: createTimestamp(minutesAgo(1)),
    },
    {
      questionId: "q3",
      selectedOption: "Yes",
      answeredAt: createTimestamp(new Date()),
    },
  ],
  evidence: [],
  tokensEarned: null,
  failureReason: null,
  attemptNumber: 1,
  createdAt: createTimestamp(minutesAgo(15)),
  updatedAt: createTimestamp(new Date()),
  completedAt: null,
};

/**
 * Valid video evidence
 */
export const validVideoEvidence = {
  deviceFingerprint: "device_abc123",
  integrityToken: "integrity_token_xyz",
  watchDurationMs: 35000,
  videoSeeked: false,
  screenVisible: true,
  appInForeground: true,
  surveyResponseTimesMs: [],
  videoStartedAt: createTimestamp(minutesAgo(5)),
  surveySubmittedAt: null,
  clientAttentionScore: 95,
};

/**
 * Valid survey evidence
 */
export const validSurveyEvidence = {
  deviceFingerprint: "device_abc123",
  integrityToken: "integrity_token_xyz",
  watchDurationMs: 60000,
  videoSeeked: false,
  screenVisible: true,
  appInForeground: true,
  surveyResponseTimesMs: [3500, 2800, 4200], // Time per question in ms
  videoStartedAt: createTimestamp(minutesAgo(10)),
  surveySubmittedAt: createTimestamp(new Date()),
  clientAttentionScore: 88,
  responses: [
    { questionId: "q1", answer: "Daily" },
    { questionId: "q2", answer: "4" },
    { questionId: "q3", answer: "Yes" },
  ],
};

/**
 * Invalid evidence (suspicious patterns)
 */
export const invalidEvidence = {
  deviceFingerprint: "device_abc123",
  integrityToken: null, // No integrity token
  watchDurationMs: 1000, // Only 1 second
  videoSeeked: true, // Skipped
  screenVisible: false, // Screen wasn't visible
  appInForeground: false, // App in background
  surveyResponseTimesMs: [100, 100, 100], // Suspiciously fast
  videoStartedAt: createTimestamp(minutesAgo(1)),
  surveySubmittedAt: createTimestamp(new Date()),
  clientAttentionScore: 10,
};

/**
 * Poll evidence
 */
export const validPollEvidence = {
  deviceFingerprint: "device_abc123",
  screenVisible: true,
  appInForeground: true,
  selectedOption: "Chocolate",
};

/**
 * Image view evidence
 */
export const validImageEvidence = {
  deviceFingerprint: "device_abc123",
  viewDurationMs: 5000, // 5 seconds viewing
  viewed: true,
  screenVisible: true,
  appInForeground: true,
};

/**
 * All engagement fixtures for iteration
 */
export const allEngagementFixtures = [
  startedEngagement,
  watchingEngagement,
  surveyingEngagement,
  completedEngagement,
  completedWithBonusEngagement,
  failedEngagement,
  abandonedEngagement,
  rewardedEngagement,
  surveyReadyEngagement,
];

/**
 * Create engagements for daily limit testing
 * Returns array of 30 completed engagements for today
 */
export function createDailyLimitEngagements(
  userId: string
): Array<typeof completedEngagement> {
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  return Array.from({ length: 30 }, (_, i) => ({
    ...completedEngagement,
    id: `eng_daily_${i + 1}`,
    userId,
    earnOpportunityId: `opp_video_${i + 1}`,
    createdAt: createTimestamp(today),
    completedAt: createTimestamp(today),
  }));
}

/**
 * Create a custom engagement fixture
 */
export function createEngagementFixture(
  overrides: Partial<typeof startedEngagement>
): typeof startedEngagement {
  return {
    ...startedEngagement,
    id: `eng_custom_${Date.now()}`,
    ...overrides,
  };
}
