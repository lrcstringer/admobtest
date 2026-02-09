/**
 * Engagement Cloud Functions Tests
 *
 * Comprehensive test suite for engagement processing logic.
 * Tests cover all functions: startEngagement, processEngagement,
 * updateEngagementProgress, abandonEngagement, and validateEngagementEvidence.
 */

import {
  setMockDoc,
  resetMocks,
  mockOperations,
} from "./mocks/admin.mock";
import {
  createMockCallContext,
} from "./mocks/firestore.mock";
import { activeUser } from "./fixtures/userFixtures";
import {
  videoOpportunity,
  surveyOpportunity,
  randomBonusOpportunity,
  everyXBonusOpportunity,
  expiredOpportunity,
  inactiveOpportunity,
  adMobOpportunity,
} from "./fixtures/opportunityFixtures";
import {
  startedEngagement,
  watchingEngagement,
  surveyingEngagement,
  completedEngagement,
  failedEngagement,
  abandonedEngagement,
  videoEvidence,
  surveyEvidence,
  pollEvidence,
  adVideoWatchingEngagement,
  validAdVideoEvidenceWithTransactionId,
  validAdVideoEvidenceWithFlag,
  validAdVideoEvidenceWithDuration,
  invalidAdVideoEvidence,
} from "./fixtures/engagementFixtures";
import {
  activeThread,
} from "./fixtures/threadFixtures";
import {
  healthySubAccount,
  depletedSubAccount,
} from "./fixtures/ledgerFixtures";

// Mock the imported modules
jest.mock("../security", () => ({
  requireAppCheck: jest.fn(),
  requirePlayIntegrity: jest.fn().mockResolvedValue(undefined),
}));

jest.mock("../ledger", () => ({
  processEarningWithSplit: jest.fn().mockResolvedValue({
    success: true,
    journalId: "journal_test_001",
  }),
  LedgerConfig: {
    EARNING_USER_SHARE: 0.9,
    EARNING_DAILY_POT_SHARE: 0.05,
    EARNING_WEEKLY_POT_SHARE: 0.05,
  },
  getOrCreateDefaultSubAccount: jest.fn().mockResolvedValue({
    subAccountId: "sub_default_001",
    created: false,
  }),
}));

jest.mock("../engagementStats", () => ({
  updateEngagementStats: jest.fn().mockResolvedValue({
    currentStreak: 1,
    longestStreak: 1,
    multiplier: 1.0,
    isNewDay: true,
    streakBroken: false,
  }),
}));

jest.mock("../dailyScores", () => ({
  updateDailyScore: jest.fn().mockResolvedValue(90),
  updateReferrerAssistScore: jest.fn().mockResolvedValue(undefined),
  updateLeaderboardScores: jest.fn().mockResolvedValue(undefined),
}));

jest.mock("../bonus", () => ({
  shouldAwardBonus: jest.fn().mockReturnValue({
    awarded: false,
    newState: {
      totalVideosWatched: 1,
      totalBonusesAwarded: 0,
      totalEligible: 1,
      videosSinceLastBonus: 1,
      recentResults: [false],
    },
    diagnostics: {},
  }),
  shouldAwardEveryXBonus: jest.fn().mockReturnValue(false),
  stateFromFirestore: jest.fn().mockReturnValue({
    totalVideosWatched: 0,
    totalBonusesAwarded: 0,
    totalEligible: 0,
    videosSinceLastBonus: 10,
    recentResults: [],
  }),
  stateToFirestore: jest.fn().mockReturnValue({}),
  DEFAULT_BONUS_CONFIG: {
    targetRate: 0.2,
    correctionK: 3.0,
    minProbability: 0.02,
    maxProbability: 0.5,
    cooldownAfterBonus: 3,
    windowSize: 10,
    maxBonusesInWindow: 3,
  },
}));

// Import the module after mocking dependencies
import * as engagement from "../engagement";
import { processEarningWithSplit } from "../ledger";
import { updateEngagementStats } from "../engagementStats";
import { updateDailyScore, updateLeaderboardScores } from "../dailyScores";
import { shouldAwardBonus, shouldAwardEveryXBonus } from "../bonus";

describe("Engagement Cloud Functions", () => {
  beforeEach(() => {
    resetMocks();
    jest.clearAllMocks();
  });

  // ============================================================================
  // startEngagement Tests
  // ============================================================================

  describe("startEngagement", () => {
    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;
        const context = createMockCallContext({ uid: undefined });

        await expect(
          handler({ earnOpportunityId: "opp_001" }, context)
        ).rejects.toThrow();
      });

      it("should accept authenticated requests", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", videoOpportunity.threadId, activeThread);

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;
        const result = await handler({ earnOpportunityId: "opp_001" }, context);

        expect(result.success).toBe(true);
      });
    });

    describe("Opportunity Validation", () => {
      it("should reject non-existent opportunity", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        // Don't set any opportunity document

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;

        await expect(
          handler({ earnOpportunityId: "opp_nonexistent" }, context)
        ).rejects.toThrow();
      });

      it("should reject inactive opportunity", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("earnOpportunities", "opp_inactive", inactiveOpportunity);

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;

        await expect(
          handler({ earnOpportunityId: "opp_inactive" }, context)
        ).rejects.toThrow();
      });

      it("should reject expired opportunity", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("earnOpportunities", "opp_expired", expiredOpportunity);

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;

        await expect(
          handler({ earnOpportunityId: "opp_expired" }, context)
        ).rejects.toThrow();
      });

      it("should accept valid active opportunity", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", videoOpportunity.threadId, activeThread);

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;
        const result = await handler({ earnOpportunityId: "opp_001" }, context);

        expect(result.success).toBe(true);
        expect(result.rewardAmount).toBe(videoOpportunity.tokenReward);
      });
    });

    describe("Budget Pre-check", () => {
      it("should reject when client sub-account is inactive", async () => {
        const context = createMockCallContext({ uid: activeUser.id });

        const threadWithBudget = {
          ...activeThread,
          clientId: "client_001",
          tokenSourceSubAccountId: "sub_001",
        };

        setMockDoc("earnOpportunities", "opp_001", {
          ...videoOpportunity,
          threadId: "thread_001",
        });
        setMockDoc("earnThreads", "thread_001", threadWithBudget);
        setMockDoc("clients/client_001/subAccounts", "sub_001", {
          ...healthySubAccount,
          isActive: false,
        });

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;

        await expect(
          handler({ earnOpportunityId: "opp_001" }, context)
        ).rejects.toThrow();
      });

      it("should reject when client budget is insufficient", async () => {
        const context = createMockCallContext({ uid: activeUser.id });

        const threadWithBudget = {
          ...activeThread,
          clientId: "client_001",
          tokenSourceSubAccountId: "sub_001",
        };

        setMockDoc("earnOpportunities", "opp_001", {
          ...videoOpportunity,
          tokenReward: 200,
          threadId: "thread_001",
        });
        setMockDoc("earnThreads", "thread_001", threadWithBudget);
        setMockDoc("clients/client_001/subAccounts", "sub_001", {
          ...depletedSubAccount,
          balance: 50, // Less than 200 reward
        });

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;

        await expect(
          handler({ earnOpportunityId: "opp_001" }, context)
        ).rejects.toThrow();
      });

      it("should allow when client budget is sufficient", async () => {
        const context = createMockCallContext({ uid: activeUser.id });

        const threadWithBudget = {
          ...activeThread,
          clientId: "client_001",
          tokenSourceSubAccountId: "sub_001",
        };

        setMockDoc("earnOpportunities", "opp_001", {
          ...videoOpportunity,
          tokenReward: 100,
          threadId: "thread_001",
        });
        setMockDoc("earnThreads", "thread_001", threadWithBudget);
        setMockDoc("clients/client_001/subAccounts", "sub_001", {
          ...healthySubAccount,
          balance: 10000, // Plenty of budget
        });

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;
        const result = await handler({ earnOpportunityId: "opp_001" }, context);

        expect(result.success).toBe(true);
      });
    });

    describe("Record Creation", () => {
      it("should create engagement with correct fields", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("earnOpportunities", "opp_001", {
          ...videoOpportunity,
          threadId: "thread_001",
          streakPoints: 2,
        });
        setMockDoc("earnThreads", "thread_001", {
          ...activeThread,
          clientId: "client_001",
        });

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;
        const result = await handler({ earnOpportunityId: "opp_001" }, context);

        expect(result.success).toBe(true);
        expect(result.engagementId).toBeDefined();
        expect(result.rewardAmount).toBe(videoOpportunity.tokenReward);

        // Check that set operation was called
        expect(mockOperations.sets.length).toBeGreaterThan(0);
      });
    });

    describe("Legacy Campaign Support", () => {
      it("should reject missing type for legacy campaign flow", async () => {
        const context = createMockCallContext({ uid: activeUser.id });

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;

        await expect(
          handler({ campaignId: "campaign_001" }, context)
        ).rejects.toThrow();
      });

      it("should reject missing earnOpportunityId and campaignId", async () => {
        const context = createMockCallContext({ uid: activeUser.id });

        const handler = (engagement.startEngagement as unknown as { run?: Function }).run || engagement.startEngagement;

        await expect(
          handler({}, context)
        ).rejects.toThrow();
      });
    });
  });

  // ============================================================================
  // processEngagement Tests
  // ============================================================================

  describe("processEngagement", () => {
    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        const context = createMockCallContext({ uid: undefined });

        await expect(
          handler({ engagementId: "eng_001", evidence: {} }, context)
        ).rejects.toThrow();
      });
    });

    describe("Ownership Validation", () => {
      it("should reject if user does not own engagement", async () => {
        const context = createMockCallContext({ uid: "different_user" });
        setMockDoc("engagements", "eng_001", {
          ...startedEngagement,
          userId: activeUser.id, // Different user
        });

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

        await expect(
          handler({ engagementId: "eng_001", evidence: videoEvidence }, context)
        ).rejects.toThrow();
      });

      it("should allow owner to process engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          threadId: "thread_001",
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        const result = await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(result.success).toBe(true);
      });
    });

    describe("Status Validation", () => {
      it("should reject already completed engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...completedEngagement,
          userId: activeUser.id,
        });

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

        await expect(
          handler({ engagementId: "eng_001", evidence: videoEvidence }, context)
        ).rejects.toThrow();
      });

      it("should reject rewarded engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...completedEngagement,
          userId: activeUser.id,
          status: "rewarded",
        });

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

        await expect(
          handler({ engagementId: "eng_001", evidence: videoEvidence }, context)
        ).rejects.toThrow();
      });

      it("should reject failed engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...failedEngagement,
          userId: activeUser.id,
        });

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

        await expect(
          handler({ engagementId: "eng_001", evidence: videoEvidence }, context)
        ).rejects.toThrow();
      });

      it("should reject abandoned engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...abandonedEngagement,
          userId: activeUser.id,
        });

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

        await expect(
          handler({ engagementId: "eng_001", evidence: videoEvidence }, context)
        ).rejects.toThrow();
      });

      it("should accept started engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...startedEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          threadId: "thread_001",
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        const result = await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(result.success).toBe(true);
      });

      it("should accept watching engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          threadId: "thread_001",
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        const result = await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(result.success).toBe(true);
      });
    });

    describe("Evidence Validation", () => {
      describe("Video Evidence", () => {
        it("should accept valid watchDurationMs evidence", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            type: "video",
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: { watchDurationMs: 15000 } },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should accept valid watchPercentage evidence", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            type: "video",
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: { watchPercentage: 95, videoId: "vid_001" } },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should reject watchPercentage below 80%", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            type: "video",
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", videoOpportunity);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: { watchPercentage: 50, videoId: "vid_001" } },
              context
            )
          ).rejects.toThrow();
        });

        it("should reject zero watchDurationMs", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            type: "video",
          });

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: { watchDurationMs: 0 } },
              context
            )
          ).rejects.toThrow();
        });
      });

      describe("Survey Evidence", () => {
        it("should accept valid survey responses", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...surveyingEngagement,
            userId: activeUser.id,
            type: "survey",
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", surveyOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: surveyEvidence },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should reject empty survey responses", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...surveyingEngagement,
            userId: activeUser.id,
            type: "survey",
          });

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: { responses: [] } },
              context
            )
          ).rejects.toThrow();
        });

        it("should reject missing responses array", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...surveyingEngagement,
            userId: activeUser.id,
            type: "survey",
          });

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: {} },
              context
            )
          ).rejects.toThrow();
        });
      });

      describe("Poll Evidence", () => {
        it("should accept valid poll selection", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...startedEngagement,
            userId: activeUser.id,
            type: "poll",
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: pollEvidence },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should reject poll without selectedOption", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...startedEngagement,
            userId: activeUser.id,
            type: "poll",
          });

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: {} },
              context
            )
          ).rejects.toThrow();
        });
      });

      describe("Image Evidence", () => {
        it("should accept viewDurationMs evidence", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...startedEngagement,
            userId: activeUser.id,
            type: "image",
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: { viewDurationMs: 3000 } },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should accept viewed: true evidence", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...startedEngagement,
            userId: activeUser.id,
            type: "image",
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: { viewed: true } },
            context
          );

          expect(result.success).toBe(true);
        });
      });

      describe("AdMob Video (adVideo) Evidence", () => {
        it("should accept adTransactionId evidence", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);
          setMockDoc("earnThreads", "imalichat_watch_earn", {
            ...activeThread,
            id: "imalichat_watch_earn",
            clientId: "imalichat",
          });
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: validAdVideoEvidenceWithTransactionId },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should accept adFullyWatched flag evidence", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);
          setMockDoc("earnThreads", "imalichat_watch_earn", {
            ...activeThread,
            id: "imalichat_watch_earn",
            clientId: "imalichat",
          });
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: validAdVideoEvidenceWithFlag },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should accept watchDurationMs >= 25 seconds", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);
          setMockDoc("earnThreads", "imalichat_watch_earn", {
            ...activeThread,
            id: "imalichat_watch_earn",
            clientId: "imalichat",
          });
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: validAdVideoEvidenceWithDuration },
            context
          );

          expect(result.success).toBe(true);
        });

        it("should reject adVideo with insufficient watch duration", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: invalidAdVideoEvidence },
              context
            )
          ).rejects.toThrow();
        });

        it("should reject adVideo with empty evidence", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: {} },
              context
            )
          ).rejects.toThrow();
        });

        it("should accept adVideo at exact 25 second threshold", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);
          setMockDoc("earnThreads", "imalichat_watch_earn", {
            ...activeThread,
            id: "imalichat_watch_earn",
            clientId: "imalichat",
          });
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: { watchDurationMs: 25000 } }, // Exact 25 seconds
            context
          );

          expect(result.success).toBe(true);
        });

        it("should reject adVideo just under 25 second threshold", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

          await expect(
            handler(
              { engagementId: "eng_001", evidence: { watchDurationMs: 24999 } }, // Just under 25 seconds
              context
            )
          ).rejects.toThrow();
        });

        it("should prioritize adTransactionId over watchDurationMs", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...adVideoWatchingEngagement,
            userId: activeUser.id,
          });
          setMockDoc("earnOpportunities", "opp_admob_001", adMobOpportunity);
          setMockDoc("earnThreads", "imalichat_watch_earn", {
            ...activeThread,
            id: "imalichat_watch_earn",
            clientId: "imalichat",
          });
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          // Even with short watch duration, transaction ID should make it valid
          const result = await handler(
            {
              engagementId: "eng_001",
              evidence: { adTransactionId: "admob_txn_123", watchDurationMs: 1000 },
            },
            context
          );

          expect(result.success).toBe(true);
        });
      });
    });

    describe("Bonus Rewards", () => {
      describe("Random Bonus Mode", () => {
        it("should apply bonus when algorithm awards it", async () => {
          (shouldAwardBonus as jest.Mock).mockReturnValueOnce({
            awarded: true,
            newState: {
              totalVideosWatched: 1,
              totalBonusesAwarded: 1,
              totalEligible: 1,
              videosSinceLastBonus: 0,
              recentResults: [true],
            },
            diagnostics: {},
          });

          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            earnOpportunityId: "opp_bonus",
            rewardAmount: 100,
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_bonus", {
            ...randomBonusOpportunity,
            tokenReward: 100,
            bonusRewardMultiplier: 2.0,
          });
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, {
            ...activeUser,
            bonusEngineState: {},
          });

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: videoEvidence },
            context
          );

          expect(result.success).toBe(true);
          expect(result.bonusApplied).toBe(true);
          expect(result.bonusMultiplier).toBe(2.0);
        });

        it("should not apply bonus when algorithm denies it", async () => {
          (shouldAwardBonus as jest.Mock).mockReturnValueOnce({
            awarded: false,
            newState: {
              totalVideosWatched: 1,
              totalBonusesAwarded: 0,
              totalEligible: 1,
              videosSinceLastBonus: 1,
              recentResults: [false],
            },
            diagnostics: {},
          });

          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            earnOpportunityId: "opp_bonus",
            rewardAmount: 100,
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_bonus", randomBonusOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: videoEvidence },
            context
          );

          expect(result.success).toBe(true);
          expect(result.bonusApplied).toBe(false);
        });
      });

      describe("Every X Bonus Mode", () => {
        it("should apply bonus on Xth completion", async () => {
          (shouldAwardEveryXBonus as jest.Mock).mockReturnValueOnce(true);

          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            earnOpportunityId: "opp_every_x",
            rewardAmount: 100,
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_every_x", {
            ...everyXBonusOpportunity,
            bonusRewardMultiplier: 3.0,
          });
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, {
            ...activeUser,
            opportunityCompletions: {
              opp_every_x: 4, // Will be 5th completion
            },
          });

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: videoEvidence },
            context
          );

          expect(result.success).toBe(true);
          expect(result.bonusApplied).toBe(true);
          expect(result.bonusMultiplier).toBe(3.0);
        });

        it("should not apply bonus on non-Xth completion", async () => {
          (shouldAwardEveryXBonus as jest.Mock).mockReturnValueOnce(false);

          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            earnOpportunityId: "opp_every_x",
            rewardAmount: 100,
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_every_x", everyXBonusOpportunity);
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, {
            ...activeUser,
            opportunityCompletions: {
              opp_every_x: 2, // Will be 3rd completion (not 5th)
            },
          });

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: videoEvidence },
            context
          );

          expect(result.success).toBe(true);
          expect(result.bonusApplied).toBe(false);
        });
      });

      describe("No Bonus Configured", () => {
        it("should not apply bonus when opportunity has no bonus config", async () => {
          const context = createMockCallContext({ uid: activeUser.id });
          setMockDoc("engagements", "eng_001", {
            ...watchingEngagement,
            userId: activeUser.id,
            earnOpportunityId: "opp_001",
            threadId: "thread_001",
          });
          setMockDoc("earnOpportunities", "opp_001", {
            ...videoOpportunity,
            bonusReward: false,
          });
          setMockDoc("earnThreads", "thread_001", activeThread);
          setMockDoc("users", activeUser.id, activeUser);

          const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
          const result = await handler(
            { engagementId: "eng_001", evidence: videoEvidence },
            context
          );

          expect(result.success).toBe(true);
          expect(result.bonusApplied).toBe(false);
        });
      });
    });

    describe("Token Split Calculation", () => {
      it("should calculate correct 90/5/5 split", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          rewardAmount: 100,
          threadId: "thread_001",
        });
        setMockDoc("earnOpportunities", "opp_001", {
          ...videoOpportunity,
          tokenReward: 100,
        });
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        const result = await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(result.success).toBe(true);
        expect(result.tokensEarned).toBe(90); // 90% to user
        expect(result.totalGenerated).toBe(100); // Total
        expect(result.dailyPotContribution).toBe(5); // 5% to daily
        expect(result.weeklyPotContribution).toBe(5); // 5% to weekly
      });

      it("should call processEarningWithSplit", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          rewardAmount: 100,
          threadId: "thread_001",
          clientId: "client_001",
          type: "video",
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", {
          ...activeThread,
          clientId: "client_001",
          tokenSourceSubAccountId: "sub_001",
        });
        // Add the sub-account document at the correct subcollection path
        setMockDoc("clients/client_001/subAccounts", "sub_001", {
          ...healthySubAccount,
          id: "sub_001",
          balance: 10000,
          isActive: true,
        });
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(processEarningWithSplit).toHaveBeenCalled();
      });
    });

    describe("Streak and Score Updates", () => {
      it("should call updateEngagementStats with user share", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          rewardAmount: 100,
          threadId: "thread_001",
          streakPoints: 2,
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        const result = await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(result.success).toBe(true);
        expect(updateEngagementStats).toHaveBeenCalledWith(activeUser.id, 90, 2);
      });

      it("should return streak info in response", async () => {
        (updateEngagementStats as jest.Mock).mockResolvedValueOnce({
          currentStreak: 3,
          longestStreak: 5,
          multiplier: 1.1,
          isNewDay: false,
          streakBroken: false,
        });

        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          threadId: "thread_001",
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        const result = await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(result.success).toBe(true);
        expect(result.streakDay).toBe(3);
        expect(result.multiplierApplied).toBe(1.1);
        expect(result.streakBroken).toBe(false);
      });

      it("should update leaderboard scores", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          threadId: "thread_001",
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
        await handler(
          { engagementId: "eng_001", evidence: videoEvidence },
          context
        );

        expect(updateDailyScore).toHaveBeenCalled();
        expect(updateLeaderboardScores).toHaveBeenCalled();
      });
    });

    describe("Ledger Processing Failure", () => {
      it("should throw when ledger processing fails", async () => {
        (processEarningWithSplit as jest.Mock).mockResolvedValueOnce({
          success: false,
          error: "Insufficient funds",
        });

        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
          earnOpportunityId: "opp_001",
          threadId: "thread_001",
        });
        setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
        setMockDoc("earnThreads", "thread_001", activeThread);
        setMockDoc("users", activeUser.id, activeUser);

        const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

        await expect(
          handler(
            { engagementId: "eng_001", evidence: videoEvidence },
            context
          )
        ).rejects.toThrow();
      });
    });
  });

  // ============================================================================
  // updateEngagementProgress Tests
  // ============================================================================

  describe("updateEngagementProgress", () => {
    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;
        const context = createMockCallContext({ uid: undefined });

        await expect(
          handler({ engagementId: "eng_001", progress: 50 }, context)
        ).rejects.toThrow();
      });
    });

    describe("Ownership Validation", () => {
      it("should reject if user does not own engagement", async () => {
        const context = createMockCallContext({ uid: "different_user" });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;

        await expect(
          handler({ engagementId: "eng_001", progress: 50 }, context)
        ).rejects.toThrow();
      });
    });

    describe("Status Validation", () => {
      it("should allow updates for started engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...startedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;
        const result = await handler(
          { engagementId: "eng_001", progress: 25 },
          context
        );

        expect(result.success).toBe(true);
        expect(result.progress).toBe(25);
      });

      it("should allow updates for watching engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;
        const result = await handler(
          { engagementId: "eng_001", progress: 75 },
          context
        );

        expect(result.success).toBe(true);
      });

      it("should allow updates for surveying engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...surveyingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;
        const result = await handler(
          { engagementId: "eng_001", progress: 60 },
          context
        );

        expect(result.success).toBe(true);
      });

      it("should reject updates for completed engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...completedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;

        await expect(
          handler({ engagementId: "eng_001", progress: 100 }, context)
        ).rejects.toThrow();
      });

      it("should reject updates for failed engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...failedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;

        await expect(
          handler({ engagementId: "eng_001", progress: 50 }, context)
        ).rejects.toThrow();
      });
    });

    describe("Progress Updates", () => {
      it("should update progress value", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;
        const result = await handler(
          { engagementId: "eng_001", progress: 75 },
          context
        );

        expect(result.success).toBe(true);
        expect(result.progress).toBe(75);
      });

      it("should update watchDurationSeconds", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;
        const result = await handler(
          { engagementId: "eng_001", watchDurationSeconds: 45 },
          context
        );

        expect(result.success).toBe(true);
      });

      it("should update status to valid active status", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...startedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
          engagement.updateEngagementProgress;
        const result = await handler(
          { engagementId: "eng_001", status: "watching" },
          context
        );

        expect(result.success).toBe(true);
      });
    });
  });

  // ============================================================================
  // abandonEngagement Tests
  // ============================================================================

  describe("abandonEngagement", () => {
    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;
        const context = createMockCallContext({ uid: undefined });

        await expect(
          handler({ engagementId: "eng_001" }, context)
        ).rejects.toThrow();
      });
    });

    describe("Ownership Validation", () => {
      it("should reject if user does not own engagement", async () => {
        const context = createMockCallContext({ uid: "different_user" });
        setMockDoc("engagements", "eng_001", {
          ...startedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;

        await expect(
          handler({ engagementId: "eng_001" }, context)
        ).rejects.toThrow();
      });
    });

    describe("Status Validation", () => {
      it("should allow abandoning started engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...startedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;
        const result = await handler({ engagementId: "eng_001" }, context);

        expect(result.success).toBe(true);
      });

      it("should allow abandoning watching engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;
        const result = await handler({ engagementId: "eng_001" }, context);

        expect(result.success).toBe(true);
      });

      it("should allow abandoning surveying engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...surveyingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;
        const result = await handler({ engagementId: "eng_001" }, context);

        expect(result.success).toBe(true);
      });

      it("should reject abandoning completed engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...completedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;

        await expect(
          handler({ engagementId: "eng_001" }, context)
        ).rejects.toThrow();
      });

      it("should reject abandoning failed engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...failedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;

        await expect(
          handler({ engagementId: "eng_001" }, context)
        ).rejects.toThrow();
      });

      it("should reject abandoning already abandoned engagement", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...abandonedEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;

        await expect(
          handler({ engagementId: "eng_001" }, context)
        ).rejects.toThrow();
      });
    });

    describe("State Update", () => {
      it("should update status to abandoned", async () => {
        const context = createMockCallContext({ uid: activeUser.id });
        setMockDoc("engagements", "eng_001", {
          ...watchingEngagement,
          userId: activeUser.id,
        });

        const handler =
          (engagement.abandonEngagement as unknown as { run?: Function }).run || engagement.abandonEngagement;
        await handler({ engagementId: "eng_001" }, context);

        // Check that update was called
        expect(mockOperations.updates.length).toBeGreaterThan(0);
        const engUpdate = mockOperations.updates.find(
          (op) => op.collection === "engagements" && op.doc === "eng_001"
        );
        expect(engUpdate).toBeDefined();
        expect((engUpdate?.data as Record<string, unknown>)?.status).toBe("abandoned");
      });
    });
  });

  // ============================================================================
  // Edge Cases
  // ============================================================================

  describe("Edge Cases", () => {
    it("should handle non-existent engagement gracefully", async () => {
      const context = createMockCallContext({ uid: activeUser.id });
      // Don't set any engagement document

      const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;

      await expect(
        handler(
          { engagementId: "eng_nonexistent", evidence: videoEvidence },
          context
        )
      ).rejects.toThrow();
    });

    it("should handle engagement with legacy in_progress status", async () => {
      const context = createMockCallContext({ uid: activeUser.id });
      setMockDoc("engagements", "eng_001", {
        ...startedEngagement,
        userId: activeUser.id,
        status: "in_progress", // Legacy status
      });

      const handler =
        (engagement.updateEngagementProgress as unknown as { run?: Function }).run ||
        engagement.updateEngagementProgress;
      const result = await handler(
        { engagementId: "eng_001", progress: 50 },
        context
      );

      expect(result.success).toBe(true);
    });

    it("should handle engagement without threadId", async () => {
      const context = createMockCallContext({ uid: activeUser.id });
      setMockDoc("engagements", "eng_001", {
        ...watchingEngagement,
        userId: activeUser.id,
        earnOpportunityId: "opp_001",
        threadId: null, // No thread
      });
      setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
      setMockDoc("users", activeUser.id, activeUser);

      const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
      const result = await handler(
        { engagementId: "eng_001", evidence: videoEvidence },
        context
      );

      expect(result.success).toBe(true);
    });

    it("should handle engagement without clientId", async () => {
      const context = createMockCallContext({ uid: activeUser.id });
      setMockDoc("engagements", "eng_001", {
        ...watchingEngagement,
        userId: activeUser.id,
        earnOpportunityId: "opp_001",
        threadId: "thread_001",
        clientId: null, // No client
      });
      setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
      setMockDoc("earnThreads", "thread_001", {
        ...activeThread,
        clientId: null,
      });
      setMockDoc("users", activeUser.id, activeUser);

      const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
      const result = await handler(
        { engagementId: "eng_001", evidence: videoEvidence },
        context
      );

      expect(result.success).toBe(true);
    });

    it("should default streakPoints to 1 when not specified", async () => {
      const context = createMockCallContext({ uid: activeUser.id });
      setMockDoc("engagements", "eng_001", {
        ...watchingEngagement,
        userId: activeUser.id,
        earnOpportunityId: "opp_001",
        threadId: "thread_001",
        streakPoints: undefined, // Not set
      });
      setMockDoc("earnOpportunities", "opp_001", videoOpportunity);
      setMockDoc("earnThreads", "thread_001", activeThread);
      setMockDoc("users", activeUser.id, activeUser);

      const handler = (engagement.processEngagement as unknown as { run?: Function }).run || engagement.processEngagement;
      await handler(
        { engagementId: "eng_001", evidence: videoEvidence },
        context
      );

      // updateEngagementStats should be called with default streakPoints = 1
      expect(updateEngagementStats).toHaveBeenCalledWith(
        activeUser.id,
        expect.any(Number),
        1
      );
    });
  });
});
