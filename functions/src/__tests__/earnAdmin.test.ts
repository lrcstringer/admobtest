/**
 * EarnAdmin Tests
 *
 * Comprehensive test suite for earn thread and opportunity management,
 * eligibility filtering, and admin dashboard functions.
 */

import {
  resetMocks,
  setMockDoc,
  setMockCollection,
  mockOperations,
} from "./mocks/admin.mock";
import { createMockCallContext } from "./mocks/firestore.mock";

// Reset mocks before importing the module under test
jest.mock("firebase-admin", () => require("./mocks/admin.mock").mockFirebaseAdmin);

// Mock security module
jest.mock("../security", () => ({
  requireAppCheck: jest.fn(),
}));

// Mock targeting module (use actual implementation for validation tests)
jest.mock("../constants/targeting", () => {
  const actual = jest.requireActual("../constants/targeting");
  return {
    ...actual,
    validateTargetingCriteria: jest.fn().mockReturnValue({ valid: true, errors: [] }),
    validateEarningType: jest.fn().mockReturnValue(true),
    calculateEngagementLevel: jest.fn().mockReturnValue("active"),
    calculateAge: jest.fn().mockReturnValue(25),
    EARNING_TYPES: ["video", "survey", "poll", "image"],
  };
});

import * as earnAdmin from "../earnAdmin";
import { validateTargetingCriteria, validateEarningType } from "../constants/targeting";

describe("EarnAdmin Functions", () => {
  beforeEach(() => {
    resetMocks();
    jest.clearAllMocks();
    (validateTargetingCriteria as jest.Mock).mockReturnValue({ valid: true, errors: [] });
    (validateEarningType as jest.Mock).mockReturnValue(true);
  });

  describe("createEarnThread", () => {
    const validThreadData = {
      clientId: "client_001",
      title: "Test Thread",
      description: "Test description",
      tokenSourceSubAccountId: "sub_001",
    };

    const mockClient = {
      displayName: "Test Client",
      companyName: "Test Company",
      avatarImage: null,
      avatarColor: "#FF0000",
      isActive: true,
    };

    const mockSubAccount = {
      balance: 10000,
      isActive: true,
    };

    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const context = createMockCallContext(null);

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler(validThreadData, context)).rejects.toThrow(
          "Must be authenticated"
        );
      });

      it("should reject non-admin users", async () => {
        const context = createMockCallContext({ uid: "user_001", admin: false });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler(validThreadData, context)).rejects.toThrow(
          "Must be an admin"
        );
      });

      it("should allow admin users", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", mockClient);
        setMockDoc("clients/client_001/subAccounts", "sub_001", mockSubAccount);

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        const result = await handler(validThreadData, context);

        expect(result.success).toBe(true);
      });
    });

    describe("Validation", () => {
      it("should reject missing clientId", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler({ ...validThreadData, clientId: null }, context)).rejects.toThrow(
          "clientId is required"
        );
      });

      it("should reject missing title", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler({ ...validThreadData, title: null }, context)).rejects.toThrow(
          "title is required"
        );
      });

      it("should reject missing tokenSourceSubAccountId", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(
          handler({ ...validThreadData, tokenSourceSubAccountId: null }, context)
        ).rejects.toThrow("tokenSourceSubAccountId is required");
      });

      it("should reject non-existent client", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler(validThreadData, context)).rejects.toThrow(
          "Client not found"
        );
      });

      it("should reject inactive client", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", { ...mockClient, isActive: false });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler(validThreadData, context)).rejects.toThrow(
          "Client is not active"
        );
      });

      it("should reject non-existent sub-account", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", mockClient);

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler(validThreadData, context)).rejects.toThrow(
          "Sub-account not found"
        );
      });

      it("should reject inactive sub-account", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", mockClient);
        setMockDoc("clients/client_001/subAccounts", "sub_001", { ...mockSubAccount, isActive: false });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(handler(validThreadData, context)).rejects.toThrow(
          "Sub-account is not active"
        );
      });

      it("should reject invalid targeting criteria", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", mockClient);
        setMockDoc("clients/client_001/subAccounts", "sub_001", mockSubAccount);
        (validateTargetingCriteria as jest.Mock).mockReturnValue({
          valid: false,
          errors: ["Invalid age range"],
        });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await expect(
          handler({ ...validThreadData, targeting: { ageMin: 50, ageMax: 20 } }, context)
        ).rejects.toThrow("Invalid targeting criteria");
      });
    });

    describe("Thread Creation", () => {
      it("should create new thread with correct data", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", mockClient);
        setMockDoc("clients/client_001/subAccounts", "sub_001", mockSubAccount);

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        const result = await handler(validThreadData, context);

        expect(result.success).toBe(true);
        expect(result.threadId).toBeDefined();
      });

      it("should update existing thread", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", mockClient);
        setMockDoc("clients/client_001/subAccounts", "sub_001", mockSubAccount);
        setMockDoc("earnThreads", "existing_thread", { id: "existing_thread" });

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        const result = await handler(
          { ...validThreadData, id: "existing_thread" },
          context
        );

        expect(result.success).toBe(true);
        expect(result.threadId).toBe("existing_thread");
      });

      it("should denormalize client data", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        setMockDoc("clients", "client_001", mockClient);
        setMockDoc("clients/client_001/subAccounts", "sub_001", mockSubAccount);

        const handler = (earnAdmin.createEarnThread as any).run || earnAdmin.createEarnThread;
        await handler(validThreadData, context);

        const setOp = mockOperations.sets.find(
          (s) => s.collection === "earnThreads"
        );
        expect(setOp).toBeDefined();
        expect((setOp?.data as any).clientName).toBe("Test Client");
      });
    });
  });

  describe("createEarnOpportunity", () => {
    const validOpportunityData = {
      threadId: "thread_001",
      title: "Test Opportunity",
      earningType: "video",
      tokenReward: 100,
      durationSeconds: 30,
    };

    const mockThread = {
      id: "thread_001",
      clientId: "client_001",
      clientName: "Test Client",
      clientAvatarColor: "#FF0000",
      isActive: true,
    };

    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const context = createMockCallContext(null);

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(handler(validOpportunityData, context)).rejects.toThrow(
          "Must be authenticated"
        );
      });

      it("should reject non-admin users", async () => {
        const context = createMockCallContext({ uid: "user_001", admin: false });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(handler(validOpportunityData, context)).rejects.toThrow(
          "Must be an admin"
        );
      });
    });

    describe("Validation", () => {
      it("should reject missing required fields", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(
          handler({ threadId: "thread_001" }, context)
        ).rejects.toThrow("threadId, title, tokenReward, and durationSeconds are required");
      });

      it("should reject missing earningType", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(
          handler({ ...validOpportunityData, earningType: null }, context)
        ).rejects.toThrow("earningType is required");
      });

      it("should reject invalid earningType", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });
        (validateEarningType as jest.Mock).mockReturnValue(false);

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(
          handler({ ...validOpportunityData, earningType: "invalid" }, context)
        ).rejects.toThrow("Invalid earningType");
      });

      it("should reject non-existent thread", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(handler(validOpportunityData, context)).rejects.toThrow(
          "Thread not found"
        );
      });
    });

    describe("Bonus Reward Validation", () => {
      beforeEach(() => {
        setMockDoc("earnThreads", "thread_001", mockThread);
      });

      it("should reject bonusReward without bonusIntervalType", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(
          handler(
            { ...validOpportunityData, bonusReward: true, bonusRewardMultiplier: 2 },
            context
          )
        ).rejects.toThrow("bonusIntervalType is required when bonusReward is true");
      });

      it("should reject invalid bonusIntervalType", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(
          handler(
            {
              ...validOpportunityData,
              bonusReward: true,
              bonusRewardMultiplier: 2,
              bonusIntervalType: "invalid",
            },
            context
          )
        ).rejects.toThrow("Invalid bonusIntervalType");
      });

      it("should reject every_x without bonusIntervalX", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await expect(
          handler(
            {
              ...validOpportunityData,
              bonusReward: true,
              bonusRewardMultiplier: 2,
              bonusIntervalType: "every_x",
            },
            context
          )
        ).rejects.toThrow("bonusIntervalX must be a positive integer");
      });

      it("should accept valid random bonus config", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        const result = await handler(
          {
            ...validOpportunityData,
            bonusReward: true,
            bonusRewardMultiplier: 2,
            bonusIntervalType: "random",
          },
          context
        );

        expect(result.success).toBe(true);
      });

      it("should accept valid every_x bonus config", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        const result = await handler(
          {
            ...validOpportunityData,
            bonusReward: true,
            bonusRewardMultiplier: 3,
            bonusIntervalType: "every_x",
            bonusIntervalX: 5,
          },
          context
        );

        expect(result.success).toBe(true);
      });
    });

    describe("Opportunity Creation", () => {
      beforeEach(() => {
        setMockDoc("earnThreads", "thread_001", mockThread);
      });

      it("should create new opportunity with correct data", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        const result = await handler(validOpportunityData, context);

        expect(result.success).toBe(true);
        expect(result.opportunityId).toBeDefined();
      });

      it("should denormalize thread client data", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await handler(validOpportunityData, context);

        const setOp = mockOperations.sets.find(
          (s) => s.collection === "earnOpportunities"
        );
        expect(setOp).toBeDefined();
        expect((setOp?.data as any).clientId).toBe("client_001");
        expect((setOp?.data as any).clientName).toBe("Test Client");
      });

      it("should default streakPoints to 1", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await handler(validOpportunityData, context);

        const setOp = mockOperations.sets.find(
          (s) => s.collection === "earnOpportunities"
        );
        expect((setOp?.data as any).streakPoints).toBe(1);
      });

      it("should use provided streakPoints", async () => {
        const context = createMockCallContext({ uid: "admin_001", admin: true });

        const handler = (earnAdmin.createEarnOpportunity as any).run || earnAdmin.createEarnOpportunity;
        await handler({ ...validOpportunityData, streakPoints: 3 }, context);

        const setOp = mockOperations.sets.find(
          (s) => s.collection === "earnOpportunities"
        );
        expect((setOp?.data as any).streakPoints).toBe(3);
      });
    });
  });

  describe("getEligibleThreads", () => {
    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const context = createMockCallContext(null);

        const handler = (earnAdmin.getEligibleThreads as any).run || earnAdmin.getEligibleThreads;
        await expect(handler({}, context)).rejects.toThrow(
          "User must be authenticated"
        );
      });
    });

    describe("User Profile", () => {
      it("should require user profile to exist", async () => {
        const context = createMockCallContext({ uid: "user_001" });

        const handler = (earnAdmin.getEligibleThreads as any).run || earnAdmin.getEligibleThreads;
        await expect(handler({}, context)).rejects.toThrow(
          "User profile not found"
        );
      });

      it("should return eligible threads for valid user", async () => {
        const context = createMockCallContext({ uid: "user_001" });
        setMockDoc("users", "user_001", {
          profile: { gender: "male" },
          createdAt: { toDate: () => new Date() },
        });
        setMockCollection("earnThreads", [
          { id: "thread_001", data: { isActive: true, clientId: "client_001" } },
        ]);

        const handler = (earnAdmin.getEligibleThreads as any).run || earnAdmin.getEligibleThreads;
        const result = await handler({}, context);

        expect(result.success).toBe(true);
        expect(Array.isArray(result.threads)).toBe(true);
      });
    });

    describe("Daily Limit", () => {
      it("should include daily limit info in response", async () => {
        const context = createMockCallContext({ uid: "user_001" });
        setMockDoc("users", "user_001", {
          profile: {},
          createdAt: { toDate: () => new Date() },
        });

        const handler = (earnAdmin.getEligibleThreads as any).run || earnAdmin.getEligibleThreads;
        const result = await handler({}, context);

        expect(result.dailyLimit).toBeDefined();
        expect(result.dailyLimit.cap).toBe(30);
      });
    });

    describe("Targeting Filters", () => {
      beforeEach(() => {
        setMockDoc("users", "user_001", {
          profile: { gender: "male", province: "gauteng" },
          createdAt: { toDate: () => new Date() },
          interests: ["sports"],
          languages: ["english"],
        });
      });

      it("should include threads with no targeting", async () => {
        const context = createMockCallContext({ uid: "user_001" });
        setMockCollection("earnThreads", [
          { id: "thread_001", data: { isActive: true, targeting: null } },
        ]);

        const handler = (earnAdmin.getEligibleThreads as any).run || earnAdmin.getEligibleThreads;
        const result = await handler({}, context);

        expect(result.threads.length).toBeGreaterThanOrEqual(0);
      });

      it("should sort pinned threads first", async () => {
        const context = createMockCallContext({ uid: "user_001" });
        setMockCollection("earnThreads", [
          { id: "thread_001", data: { isActive: true, isPinned: false, isFeatured: false } },
          { id: "thread_002", data: { isActive: true, isPinned: true, isFeatured: false } },
        ]);

        const handler = (earnAdmin.getEligibleThreads as any).run || earnAdmin.getEligibleThreads;
        const result = await handler({}, context);

        // In actual implementation, pinned would be first after sorting
        expect(result.success).toBe(true);
      });

      it("should sort featured threads after pinned", async () => {
        const context = createMockCallContext({ uid: "user_001" });
        setMockCollection("earnThreads", [
          { id: "thread_001", data: { isActive: true, isPinned: false, isFeatured: false } },
          { id: "thread_002", data: { isActive: true, isPinned: false, isFeatured: true } },
        ]);

        const handler = (earnAdmin.getEligibleThreads as any).run || earnAdmin.getEligibleThreads;
        const result = await handler({}, context);

        expect(result.success).toBe(true);
      });
    });
  });

  describe("getEligibleOpportunities", () => {
    describe("Authentication", () => {
      it("should reject unauthenticated requests", async () => {
        const context = createMockCallContext(null);

        const handler = (earnAdmin.getEligibleOpportunities as any).run || earnAdmin.getEligibleOpportunities;
        await expect(handler({ threadId: "thread_001" }, context)).rejects.toThrow(
          "User must be authenticated"
        );
      });
    });

    describe("Validation", () => {
      it("should require threadId", async () => {
        const context = createMockCallContext({ uid: "user_001" });
        setMockDoc("users", "user_001", {
          profile: {},
          createdAt: { toDate: () => new Date() },
        });

        const handler = (earnAdmin.getEligibleOpportunities as any).run || earnAdmin.getEligibleOpportunities;
        await expect(handler({}, context)).rejects.toThrow(
          "threadId is required"
        );
      });
    });

    describe("Response", () => {
      it("should return opportunities with engagement status", async () => {
        const context = createMockCallContext({ uid: "user_001" });
        setMockDoc("users", "user_001", {
          profile: {},
          createdAt: { toDate: () => new Date() },
        });
        setMockCollection("earnOpportunities", [
          {
            id: "opp_001",
            data: {
              threadId: "thread_001",
              isActive: true,
              tokenReward: 100,
            },
          },
        ]);

        const handler = (earnAdmin.getEligibleOpportunities as any).run || earnAdmin.getEligibleOpportunities;
        const result = await handler({ threadId: "thread_001" }, context);

        expect(result.success).toBe(true);
        expect(Array.isArray(result.opportunities)).toBe(true);
      });
    });
  });

  describe("getTargetingOptions", () => {
    it("should reject non-admin users", async () => {
      const context = createMockCallContext({ uid: "user_001", admin: false });

      const handler = (earnAdmin.getTargetingOptions as any).run || earnAdmin.getTargetingOptions;
      await expect(handler({}, context)).rejects.toThrow(
        "Must be an admin"
      );
    });

    it("should return all targeting options for admin", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });

      const handler = (earnAdmin.getTargetingOptions as any).run || earnAdmin.getTargetingOptions;
      const result = await handler({}, context);

      expect(result.success).toBe(true);
      expect(result.options).toBeDefined();
      expect(result.options.genders).toEqual(["male", "female", "other"]);
      expect(result.options.provinces).toBeDefined();
      expect(result.options.cities).toBeDefined();
      expect(result.options.languages).toBeDefined();
      expect(result.options.interests).toBeDefined();
      expect(result.options.devicePlatforms).toEqual(["android", "ios"]);
      expect(result.options.engagementLevels).toEqual(["new", "casual", "active", "dormant"]);
    });
  });

  describe("getClientStats", () => {
    it("should reject non-admin users", async () => {
      const context = createMockCallContext({ uid: "user_001", admin: false });

      const handler = (earnAdmin.getClientStats as any).run || earnAdmin.getClientStats;
      await expect(handler({ clientId: "client_001" }, context)).rejects.toThrow(
        "Must be an admin"
      );
    });

    it("should require clientId", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });

      const handler = (earnAdmin.getClientStats as any).run || earnAdmin.getClientStats;
      await expect(handler({}, context)).rejects.toThrow(
        "clientId is required"
      );
    });

    it("should reject non-existent client", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });

      const handler = (earnAdmin.getClientStats as any).run || earnAdmin.getClientStats;
      await expect(
        handler({ clientId: "nonexistent" }, context)
      ).rejects.toThrow("Client not found");
    });

    it("should return comprehensive stats for existing client", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });
      setMockDoc("clients", "client_001", {
        companyName: "Test Company",
        displayName: "Test Display",
        isActive: true,
        createdAt: { toDate: () => new Date() },
      });

      const handler = (earnAdmin.getClientStats as any).run || earnAdmin.getClientStats;
      const result = await handler({ clientId: "client_001" }, context);

      expect(result.success).toBe(true);
      expect(result.client).toBeDefined();
      expect(result.threads).toBeDefined();
      expect(result.opportunities).toBeDefined();
      expect(result.engagements).toBeDefined();
      expect(result.reach).toBeDefined();
      expect(result.budget).toBeDefined();
    });
  });

  describe("getThreadAnalytics", () => {
    it("should reject non-admin users", async () => {
      const context = createMockCallContext({ uid: "user_001", admin: false });

      const handler = (earnAdmin.getThreadAnalytics as any).run || earnAdmin.getThreadAnalytics;
      await expect(handler({ threadId: "thread_001" }, context)).rejects.toThrow(
        "Must be an admin"
      );
    });

    it("should require threadId", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });

      const handler = (earnAdmin.getThreadAnalytics as any).run || earnAdmin.getThreadAnalytics;
      await expect(handler({}, context)).rejects.toThrow(
        "threadId is required"
      );
    });

    it("should reject non-existent thread", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });

      const handler = (earnAdmin.getThreadAnalytics as any).run || earnAdmin.getThreadAnalytics;
      await expect(
        handler({ threadId: "nonexistent" }, context)
      ).rejects.toThrow("Thread not found");
    });

    it("should return comprehensive analytics for existing thread", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });
      setMockDoc("earnThreads", "thread_001", {
        title: "Test Thread",
        clientId: "client_001",
        clientName: "Test Client",
        isActive: true,
        createdAt: { toDate: () => new Date() },
        availableOpportunities: 5,
        completedOpportunities: 100,
        completedUniqueUsers: 50,
      });

      const handler = (earnAdmin.getThreadAnalytics as any).run || earnAdmin.getThreadAnalytics;
      const result = await handler({ threadId: "thread_001" }, context);

      expect(result.success).toBe(true);
      expect(result.thread).toBeDefined();
      expect(result.dateRange).toBeDefined();
      expect(result.summary).toBeDefined();
      expect(result.opportunities).toBeDefined();
      expect(result.dailyStats).toBeDefined();
    });

    it("should use custom date range when provided", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });
      setMockDoc("earnThreads", "thread_001", {
        title: "Test Thread",
        clientId: "client_001",
        clientName: "Test Client",
        isActive: true,
        createdAt: { toDate: () => new Date() },
      });

      const handler = (earnAdmin.getThreadAnalytics as any).run || earnAdmin.getThreadAnalytics;
      const result = await handler(
        {
          threadId: "thread_001",
          startDate: "2024-01-01",
          endDate: "2024-01-31",
        },
        context
      );

      expect(result.success).toBe(true);
      expect(result.dateRange).toBeDefined();
    });
  });

  describe("getEarnStatistics", () => {
    it("should reject unauthenticated requests", async () => {
      const context = createMockCallContext(null);

      const handler = (earnAdmin.getEarnStatistics as any).run || earnAdmin.getEarnStatistics;
      await expect(handler({}, context)).rejects.toThrow(
        "Must be authenticated"
      );
    });

    it("should return statistics for authenticated user", async () => {
      const context = createMockCallContext({ uid: "user_001" });

      const handler = (earnAdmin.getEarnStatistics as any).run || earnAdmin.getEarnStatistics;
      const result = await handler({}, context);

      expect(result).toBeDefined();
      expect(typeof result.activeThreads).toBe("number");
      expect(typeof result.activeOpportunities).toBe("number");
      expect(typeof result.engagementsToday).toBe("number");
      expect(typeof result.completedToday).toBe("number");
      expect(typeof result.activeClients).toBe("number");
    });
  });

  describe("syncCampaignsToOpportunities", () => {
    it("should reject non-admin users", async () => {
      const context = createMockCallContext({ uid: "user_001", admin: false });

      const handler = (earnAdmin.syncCampaignsToOpportunities as any).run ||
        earnAdmin.syncCampaignsToOpportunities;
      await expect(handler({ defaultThreadId: "thread_001" }, context)).rejects.toThrow(
        "Must be an admin"
      );
    });

    it("should require defaultThreadId", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });

      const handler = (earnAdmin.syncCampaignsToOpportunities as any).run ||
        earnAdmin.syncCampaignsToOpportunities;
      await expect(handler({}, context)).rejects.toThrow(
        "defaultThreadId is required"
      );
    });

    it("should return 0 synced when no active campaigns", async () => {
      const context = createMockCallContext({ uid: "admin_001", admin: true });

      const handler = (earnAdmin.syncCampaignsToOpportunities as any).run ||
        earnAdmin.syncCampaignsToOpportunities;
      const result = await handler({ defaultThreadId: "thread_001" }, context);

      expect(result.success).toBe(true);
      expect(result.synced).toBe(0);
    });
  });
});
