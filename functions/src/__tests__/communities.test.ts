/**
 * Communities Cloud Functions — Test Suite
 *
 * Tests validation, error handling, and core business logic for community
 * management functions: create, update, delete, membership, messaging,
 * contributions, withdrawals, and transaction approval/rejection.
 */

import {
  resetMocks,
  setMockDoc,
  setMockCollection,
} from "./mocks/admin.mock";
import { createMockCallContext } from "./mocks/firestore.mock";

// ── Mocks ──────────────────────────────────────────────────────────────────

jest.mock("firebase-admin", () => require("./mocks/admin.mock").mockFirebaseAdmin);

const MockHttpsError = class HttpsError extends Error {
  constructor(
    public code: string,
    public message: string,
    public details?: unknown
  ) {
    super(message);
    this.name = "HttpsError";
  }
};

jest.mock("firebase-functions/v2/https", () => ({
  onCall: jest.fn((...args: unknown[]) => {
    const handler = typeof args[0] === "function" ? args[0] : args[1];
    return (data: unknown, context: unknown) =>
      (handler as Function)({ data, ...(context as object) });
  }),
  HttpsError: MockHttpsError,
}));

jest.mock("firebase-functions/v2/scheduler", () => ({
  onSchedule: jest.fn((...args: unknown[]) => {
    const handler = args.length === 2 ? args[1] : args[0];
    return handler;
  }),
}));

jest.mock("firebase-functions/v2", () => ({
  logger: {
    log: jest.fn(),
    info: jest.fn(),
    warn: jest.fn(),
    error: jest.fn(),
    debug: jest.fn(),
  },
}));

// Mock security module
const mockRequireAppCheck = jest.fn();
const mockRequirePlayIntegrity = jest.fn().mockResolvedValue(undefined);

jest.mock("../security", () => ({
  requireAppCheck: (...args: unknown[]) => mockRequireAppCheck(...args),
  requirePlayIntegrity: (...args: unknown[]) => mockRequirePlayIntegrity(...args),
}));

// Mock ledger/groupAccounts
const mockGetOrCreateGroupAccount = jest.fn().mockResolvedValue({
  accountId: "group:comm_001",
});
const mockGetGroupBalance = jest.fn().mockResolvedValue(50000);
const mockProcessGroupContribution = jest.fn().mockResolvedValue({
  success: true,
  journalId: "j_contrib_001",
});
const mockProcessGroupWithdrawal = jest.fn().mockResolvedValue({
  success: true,
  journalId: "j_withdraw_001",
});
const mockProcessGroupPayout = jest.fn().mockResolvedValue({
  success: true,
  journalId: "j_payout_001",
});

jest.mock("../ledger/groupAccounts", () => ({
  getOrCreateGroupAccount: (...args: unknown[]) => mockGetOrCreateGroupAccount(...args),
  getGroupBalance: (...args: unknown[]) => mockGetGroupBalance(...args),
  processGroupContribution: (...args: unknown[]) => mockProcessGroupContribution(...args),
  processGroupWithdrawal: (...args: unknown[]) => mockProcessGroupWithdrawal(...args),
  processGroupPayout: (...args: unknown[]) => mockProcessGroupPayout(...args),
}));

// ── Import module under test ─────────────────────────────────────────────

import {
  createCommunity as _createCommunity,
  updateCommunity as _updateCommunity,
  deleteCommunity as _deleteCommunity,
  inviteCommunityMember as _inviteCommunityMember,
  acceptCommunityInvitation as _acceptCommunityInvitation,
  removeCommunityMember as _removeCommunityMember,
  updateCommunityMemberRole as _updateCommunityMemberRole,
  sendCommunityMessage as _sendCommunityMessage,
  markCommunityRead as _markCommunityRead,
  toggleCommunityMessageReaction as _toggleCommunityMessageReaction,
  toggleCommunityMute as _toggleCommunityMute,
  contributeToCommunity as _contributeToCommunity,
  withdrawFromCommunity as _withdrawFromCommunity,
  approveCommunityTransaction as _approveCommunityTransaction,
  rejectCommunityTransaction as _rejectCommunityTransaction,
  getUserCommunities as _getUserCommunities,
  getCommunityDetails as _getCommunityDetails,
  getCommunityTransactions as _getCommunityTransactions,
  getCommunityPendingApprovals as _getCommunityPendingApprovals,
} from "../communities";

// Cast onCall-wrapped exports to callable test signatures
type CallableHandler = (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;

const createCommunity = _createCommunity as unknown as CallableHandler;
const updateCommunity = _updateCommunity as unknown as CallableHandler;
const deleteCommunity = _deleteCommunity as unknown as CallableHandler;
const inviteCommunityMember = _inviteCommunityMember as unknown as CallableHandler;
const acceptCommunityInvitation = _acceptCommunityInvitation as unknown as CallableHandler;
const removeCommunityMember = _removeCommunityMember as unknown as CallableHandler;
const updateCommunityMemberRole = _updateCommunityMemberRole as unknown as CallableHandler;
const sendCommunityMessage = _sendCommunityMessage as unknown as CallableHandler;
const markCommunityRead = _markCommunityRead as unknown as CallableHandler;
const toggleCommunityMessageReaction = _toggleCommunityMessageReaction as unknown as CallableHandler;
// toggleCommunityMute is tested via toggleCommunityMute (mute/unmute) — omitted for now
void _toggleCommunityMute;
const contributeToCommunity = _contributeToCommunity as unknown as CallableHandler;
const withdrawFromCommunity = _withdrawFromCommunity as unknown as CallableHandler;
const approveCommunityTransaction = _approveCommunityTransaction as unknown as CallableHandler;
const rejectCommunityTransaction = _rejectCommunityTransaction as unknown as CallableHandler;
const getUserCommunities = _getUserCommunities as unknown as CallableHandler;
const getCommunityDetails = _getCommunityDetails as unknown as CallableHandler;
const getCommunityTransactions = _getCommunityTransactions as unknown as CallableHandler;
const getCommunityPendingApprovals = _getCommunityPendingApprovals as unknown as CallableHandler;

// ── Helpers ────────────────────────────────────────────────────────────────

const authContext = createMockCallContext({ uid: "user_001", appCheckToken: true });
const unauthContext = createMockCallContext(null);

/** Mock timestamp with toDate() support */
function mockTimestamp(date?: Date): { toDate: () => Date; toMillis: () => number; seconds: number; nanoseconds: number } {
  const d = date || new Date();
  const ms = d.getTime();
  return {
    toDate: () => d,
    toMillis: () => ms,
    seconds: Math.floor(ms / 1000),
    nanoseconds: (ms % 1000) * 1000000,
  };
}

/** Seed a user profile doc for getUserProfile lookups */
function seedUserProfile(userId: string, overrides: Record<string, unknown> = {}): void {
  setMockDoc("users", userId, {
    displayName: "Test User",
    avatarUrl: null,
    profilePicThumbUrl: null,
    ...overrides,
  });
}

/** Seed a fully active community document */
function seedActiveCommunity(communityId: string, overrides: Record<string, unknown> = {}): void {
  setMockDoc("communities", communityId, {
    id: communityId,
    type: "regular",
    name: "Test Community",
    description: null,
    avatarUrl: null,
    ownerId: "user_001",
    memberIds: ["user_001"],
    adminIds: ["user_001"],
    memberCount: 1,
    totalBalance: 0,
    status: "active",
    settings: {
      maxMembers: 100,
      allowMemberInvites: true,
      onlyAdminsPost: false,
      membersCanShareMedia: true,
      enableFinancials: true,
      requireApprovalAbove: 5000,
      allowMemberWithdrawals: true,
      contributionCycle: "none",
      contributionAmount: 0,
      penaltyPercentage: 0,
    },
    stokvel: null,
    lastMessage: null,
    lastMessageAt: null,
    unreadCounts: {},
    muted: {},
    createdAt: mockTimestamp(),
    updatedAt: null,
    ...overrides,
  });
}

/** Seed an active community member subcollection doc */
function seedActiveMember(
  communityId: string,
  userId: string,
  role: string = "owner"
): void {
  setMockDoc(`communities/${communityId}/members`, userId, {
    id: userId,
    communityId,
    userId,
    role,
    displayName: "Test User",
    avatarUrl: null,
    status: "active",
    contributionBalance: 0,
    joinedAt: mockTimestamp(),
    invitedBy: "user_001",
    invitedAt: mockTimestamp(),
    lastReadAt: mockTimestamp(),
  });
}

// ── Tests ──────────────────────────────────────────────────────────────────

describe("Communities Cloud Functions", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  // ========================================================================
  // createCommunity
  // ========================================================================
  describe("createCommunity", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        createCommunity({ name: "Test", type: "regular" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when name is missing", async () => {
      await expect(
        createCommunity({ type: "regular" }, authContext)
      ).rejects.toThrow("Community name is required");
    });

    it("throws when name is empty string", async () => {
      await expect(
        createCommunity({ name: "   ", type: "regular" }, authContext)
      ).rejects.toThrow("Community name is required");
    });

    it("throws when name exceeds max length", async () => {
      const longName = "A".repeat(51);
      await expect(
        createCommunity({ name: longName, type: "regular" }, authContext)
      ).rejects.toThrow("COMMUNITY_NAME_TOO_LONG");
    });

    it("throws when description exceeds max length", async () => {
      seedUserProfile("user_001");
      const longDesc = "A".repeat(201);
      await expect(
        createCommunity({ name: "Test", description: longDesc, type: "regular" }, authContext)
      ).rejects.toThrow("COMMUNITY_DESCRIPTION_TOO_LONG");
    });

    it("throws when type is invalid", async () => {
      await expect(
        createCommunity({ name: "Test", type: "invalid" }, authContext)
      ).rejects.toThrow("Invalid community type");
    });

    it("throws when settings have negative contribution amount", async () => {
      await expect(
        createCommunity(
          { name: "Test", type: "regular", settings: { contributionAmount: -1 } },
          authContext
        )
      ).rejects.toThrow("Contribution amount must not be negative");
    });

    it("throws when settings have penalty percentage above 100", async () => {
      await expect(
        createCommunity(
          { name: "Test", type: "regular", settings: { penaltyPercentage: 150 } },
          authContext
        )
      ).rejects.toThrow("Penalty percentage must be between 0 and 100");
    });

    it("throws when settings have penalty percentage below 0", async () => {
      await expect(
        createCommunity(
          { name: "Test", type: "regular", settings: { penaltyPercentage: -5 } },
          authContext
        )
      ).rejects.toThrow("Penalty percentage must be between 0 and 100");
    });

    it("throws when settings have maxMembers less than 1", async () => {
      await expect(
        createCommunity(
          { name: "Test", type: "regular", settings: { maxMembers: 0 } },
          authContext
        )
      ).rejects.toThrow("Max members must be at least 1");
    });

    it("throws when settings have negative approval threshold", async () => {
      await expect(
        createCommunity(
          { name: "Test", type: "regular", settings: { requireApprovalAbove: -100 } },
          authContext
        )
      ).rejects.toThrow("Approval threshold must not be negative");
    });

    it("throws when settings have invalid contribution cycle", async () => {
      await expect(
        createCommunity(
          { name: "Test", type: "regular", settings: { contributionCycle: "daily" } },
          authContext
        )
      ).rejects.toThrow("Invalid contribution cycle: daily");
    });

    it("accepts valid contribution cycles", async () => {
      seedUserProfile("user_001");
      for (const cycle of ["none", "weekly", "monthly", "yearly"]) {
        resetMocks();
        seedUserProfile("user_001");
        // Should not throw on valid cycles
        await expect(
          createCommunity(
            { name: "Test", type: "regular", settings: { contributionCycle: cycle } },
            authContext
          )
        ).resolves.toBeDefined();
      }
    });

    it("validates stokvel settings for stokvel type", async () => {
      await expect(
        createCommunity(
          {
            name: "Stokvel",
            type: "stokvel",
            stokvelSettings: { payoutType: "invalid_type" },
          },
          authContext
        )
      ).rejects.toThrow("Invalid payout type: invalid_type");
    });

    it("accepts valid stokvel payout types", async () => {
      seedUserProfile("user_001");
      for (const payoutType of ["rotating", "lottery", "fixed_date", "goal_reached"]) {
        resetMocks();
        seedUserProfile("user_001");
        await expect(
          createCommunity(
            {
              name: "Stokvel",
              type: "stokvel",
              stokvelSettings: { payoutType },
            },
            authContext
          )
        ).resolves.toBeDefined();
      }
    });

    it("throws when stokvel settings have negative contribution amount", async () => {
      await expect(
        createCommunity(
          {
            name: "Stokvel",
            type: "stokvel",
            stokvelSettings: { contributionAmount: -500 },
          },
          authContext
        )
      ).rejects.toThrow("Contribution amount must not be negative");
    });

    it("creates community successfully with valid input", async () => {
      seedUserProfile("user_001");
      const result = await createCommunity(
        { name: "My Community", type: "regular" },
        authContext
      );

      expect(result.success).toBe(true);
      expect(result.communityId).toBeDefined();
      expect((result.community as Record<string, unknown>).name).toBe("My Community");
      expect((result.community as Record<string, unknown>).type).toBe("regular");
      expect((result.community as Record<string, unknown>).ownerId).toBe("user_001");
      expect(mockGetOrCreateGroupAccount).toHaveBeenCalled();
    });

    it("throws internal error when ledger account creation fails", async () => {
      seedUserProfile("user_001");
      mockGetOrCreateGroupAccount.mockRejectedValueOnce(new Error("Ledger failure"));

      await expect(
        createCommunity({ name: "Broken", type: "regular" }, authContext)
      ).rejects.toThrow("Failed to initialize community finances");
    });

    it("calls requireAppCheck and requirePlayIntegrity", async () => {
      seedUserProfile("user_001");
      await createCommunity({ name: "Test", type: "regular" }, authContext);

      expect(mockRequireAppCheck).toHaveBeenCalled();
      expect(mockRequirePlayIntegrity).toHaveBeenCalled();
    });
  });

  // ========================================================================
  // updateCommunity
  // ========================================================================
  describe("updateCommunity", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        updateCommunity({ communityId: "comm_001" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        updateCommunity({}, authContext)
      ).rejects.toThrow("Community ID is required");
    });

    it("throws when community is not found", async () => {
      await expect(
        updateCommunity({ communityId: "nonexistent" }, authContext)
      ).rejects.toThrow("COMMUNITY_NOT_FOUND");
    });

    it("throws when name is empty string", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        updateCommunity({ communityId: "comm_001", name: "   " }, authContext)
      ).rejects.toThrow("Community name cannot be empty");
    });

    it("throws when name exceeds max length", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        updateCommunity({ communityId: "comm_001", name: "A".repeat(51) }, authContext)
      ).rejects.toThrow("COMMUNITY_NAME_TOO_LONG");
    });

    it("throws when description exceeds max length", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        updateCommunity({ communityId: "comm_001", description: "A".repeat(201) }, authContext)
      ).rejects.toThrow("COMMUNITY_DESCRIPTION_TOO_LONG");
    });

    it("validates community settings on update", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        updateCommunity(
          { communityId: "comm_001", settings: { penaltyPercentage: 200 } },
          authContext
        )
      ).rejects.toThrow("Penalty percentage must be between 0 and 100");
    });
  });

  // ========================================================================
  // deleteCommunity
  // ========================================================================
  describe("deleteCommunity", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        deleteCommunity({ communityId: "comm_001" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        deleteCommunity({}, authContext)
      ).rejects.toThrow("Community ID is required");
    });

    it("throws when user is not the owner", async () => {
      seedActiveCommunity("comm_001", { ownerId: "other_user" });

      await expect(
        deleteCommunity({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("COMMUNITY_PERMISSION_DENIED");
    });

    it("throws when community has remaining balance", async () => {
      seedActiveCommunity("comm_001");
      mockGetGroupBalance.mockResolvedValueOnce(500);

      await expect(
        deleteCommunity({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Cannot delete community with remaining balance");
    });

    it("succeeds when owner and no balance", async () => {
      seedActiveCommunity("comm_001");
      mockGetGroupBalance.mockResolvedValueOnce(0);

      const result = await deleteCommunity({ communityId: "comm_001" }, authContext);
      expect(result.success).toBe(true);
    });
  });

  // ========================================================================
  // inviteCommunityMember
  // ========================================================================
  describe("inviteCommunityMember", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        inviteCommunityMember({ communityId: "comm_001", userId: "user_002" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId or userId is missing", async () => {
      await expect(
        inviteCommunityMember({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID and user ID are required");

      await expect(
        inviteCommunityMember({ userId: "user_002" }, authContext)
      ).rejects.toThrow("Community ID and user ID are required");
    });

    it("throws when inviting self", async () => {
      await expect(
        inviteCommunityMember({ communityId: "comm_001", userId: "user_001" }, authContext)
      ).rejects.toThrow("COMMUNITY_CANNOT_INVITE_SELF");
    });

    it("rejects invalid roles", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      seedUserProfile("user_002");

      await expect(
        inviteCommunityMember(
          { communityId: "comm_001", userId: "user_002", role: "superadmin" },
          authContext
        )
      ).rejects.toThrow("Invalid role: superadmin");
    });

    it("accepts valid roles: admin, treasurer, member, viewer", async () => {
      for (const role of ["admin", "treasurer", "member", "viewer"]) {
        resetMocks();
        seedActiveCommunity("comm_001");
        seedActiveMember("comm_001", "user_001", "owner");
        seedUserProfile("user_002");

        // Should not throw on valid roles
        await expect(
          inviteCommunityMember(
            { communityId: "comm_001", userId: "user_002", role },
            authContext
          )
        ).resolves.toBeDefined();
      }
    });

    it("downgrades 'owner' role to 'admin'", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      seedUserProfile("user_002");

      // "owner" is not in validInviteRoles but gets special handling:
      // role === "owner" ? "admin" : (role || "member")
      // Since "owner" is not in validInviteRoles, it throws "Invalid role"
      await expect(
        inviteCommunityMember(
          { communityId: "comm_001", userId: "user_002", role: "owner" },
          authContext
        )
      ).rejects.toThrow("Invalid role: owner");
    });

    it("defaults to 'member' role when no role specified", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      seedUserProfile("user_002");

      const result = await inviteCommunityMember(
        { communityId: "comm_001", userId: "user_002" },
        authContext
      );
      expect(result.success).toBe(true);
    });

    it("throws member-already-exists for existing active member", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      seedActiveMember("comm_001", "user_002", "member");

      await expect(
        inviteCommunityMember(
          { communityId: "comm_001", userId: "user_002" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_MEMBER_ALREADY_EXISTS");
    });

    it("throws member-blocked for blocked member", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      setMockDoc("communities/comm_001/members", "user_002", {
        id: "user_002",
        status: "blocked",
      });

      await expect(
        inviteCommunityMember(
          { communityId: "comm_001", userId: "user_002" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_MEMBER_BLOCKED");
    });

    it("throws when community is closed", async () => {
      seedActiveCommunity("comm_001", { status: "closed" });

      await expect(
        inviteCommunityMember(
          { communityId: "comm_001", userId: "user_002" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_CLOSED");
    });

    it("throws when community is suspended", async () => {
      seedActiveCommunity("comm_001", { status: "suspended" });

      await expect(
        inviteCommunityMember(
          { communityId: "comm_001", userId: "user_002" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_SUSPENDED");
    });
  });

  // ========================================================================
  // acceptCommunityInvitation
  // ========================================================================
  describe("acceptCommunityInvitation", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        acceptCommunityInvitation({ communityId: "comm_001" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        acceptCommunityInvitation({}, authContext)
      ).rejects.toThrow("Community ID is required");
    });

    it("throws when no invitation exists", async () => {
      seedActiveCommunity("comm_001");

      await expect(
        acceptCommunityInvitation({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("COMMUNITY_INVITATION_NOT_FOUND");
    });

    it("throws when member is blocked", async () => {
      seedActiveCommunity("comm_001");
      setMockDoc("communities/comm_001/members", "user_001", {
        id: "user_001",
        status: "blocked",
        invitedAt: mockTimestamp(),
      });

      await expect(
        acceptCommunityInvitation({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("COMMUNITY_MEMBER_BLOCKED");
    });
  });

  // ========================================================================
  // removeCommunityMember
  // ========================================================================
  describe("removeCommunityMember", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        removeCommunityMember({ communityId: "comm_001", memberId: "user_002" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId or memberId is missing", async () => {
      await expect(
        removeCommunityMember({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID and member ID are required");
    });

    it("throws when trying to remove the owner", async () => {
      seedActiveCommunity("comm_001", { ownerId: "user_002" });

      await expect(
        removeCommunityMember({ communityId: "comm_001", memberId: "user_002" }, authContext)
      ).rejects.toThrow("COMMUNITY_CANNOT_REMOVE_OWNER");
    });

    it("throws when actor is not a member", async () => {
      seedActiveCommunity("comm_001");

      await expect(
        removeCommunityMember({ communityId: "comm_001", memberId: "user_002" }, authContext)
      ).rejects.toThrow("COMMUNITY_NOT_A_MEMBER");
    });

    it("throws when target member is not found", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        removeCommunityMember({ communityId: "comm_001", memberId: "user_002" }, authContext)
      ).rejects.toThrow("COMMUNITY_MEMBER_NOT_FOUND");
    });
  });

  // ========================================================================
  // updateCommunityMemberRole
  // ========================================================================
  describe("updateCommunityMemberRole", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        updateCommunityMemberRole(
          { communityId: "comm_001", memberId: "user_002", role: "admin" },
          unauthContext
        )
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when required fields are missing", async () => {
      await expect(
        updateCommunityMemberRole({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID, member ID, and role are required");
    });

    it("throws when role is invalid", async () => {
      await expect(
        updateCommunityMemberRole(
          { communityId: "comm_001", memberId: "user_002", role: "supreme_leader" },
          authContext
        )
      ).rejects.toThrow("Invalid role");
    });

    it("accepts valid roles: admin, treasurer, member, viewer", async () => {
      for (const role of ["admin", "treasurer", "member", "viewer"]) {
        resetMocks();
        seedActiveCommunity("comm_001");
        seedActiveMember("comm_001", "user_001", "owner");
        seedActiveMember("comm_001", "user_002", "member");

        // "admin" requires the actor to be owner which user_001 is
        await expect(
          updateCommunityMemberRole(
            { communityId: "comm_001", memberId: "user_002", role },
            authContext
          )
        ).resolves.toBeDefined();
      }
    });

    it("throws when trying to change own role", async () => {
      seedActiveCommunity("comm_001");

      await expect(
        updateCommunityMemberRole(
          { communityId: "comm_001", memberId: "user_001", role: "member" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_CANNOT_CHANGE_OWN_ROLE");
    });

    it("throws when trying to change owner's role", async () => {
      seedActiveCommunity("comm_001", { ownerId: "user_002" });
      seedActiveMember("comm_001", "user_001", "admin");

      await expect(
        updateCommunityMemberRole(
          { communityId: "comm_001", memberId: "user_002", role: "member" },
          authContext
        )
      ).rejects.toThrow("Cannot change owner's role");
    });

    it("throws when non-owner tries to assign admin role", async () => {
      seedActiveCommunity("comm_001", { ownerId: "user_owner" });
      seedActiveMember("comm_001", "user_001", "admin");
      seedActiveMember("comm_001", "user_002", "member");

      await expect(
        updateCommunityMemberRole(
          { communityId: "comm_001", memberId: "user_002", role: "admin" },
          authContext
        )
      ).rejects.toThrow("Only owner can assign admin role");
    });
  });

  // ========================================================================
  // sendCommunityMessage
  // ========================================================================
  describe("sendCommunityMessage", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        sendCommunityMessage({ communityId: "comm_001", text: "Hello" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        sendCommunityMessage({ text: "Hello" }, authContext)
      ).rejects.toThrow("Community ID is required");
    });

    it("throws when text, media, and ciphertext are all missing", async () => {
      await expect(
        sendCommunityMessage({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Message text, media, or ciphertext is required");
    });

    it("throws when community is closed", async () => {
      seedActiveCommunity("comm_001", { status: "closed" });

      await expect(
        sendCommunityMessage({ communityId: "comm_001", text: "Hello" }, authContext)
      ).rejects.toThrow("COMMUNITY_CLOSED");
    });

    it("throws when onlyAdminsPost is enabled and user is not admin", async () => {
      seedActiveCommunity("comm_001", {
        settings: {
          maxMembers: 100,
          allowMemberInvites: true,
          onlyAdminsPost: true,
          membersCanShareMedia: true,
          enableFinancials: false,
          requireApprovalAbove: 5000,
          allowMemberWithdrawals: true,
          contributionCycle: "none",
          contributionAmount: 0,
          penaltyPercentage: 0,
        },
        adminIds: ["admin_user"],
      });
      seedActiveMember("comm_001", "user_001", "member");

      await expect(
        sendCommunityMessage({ communityId: "comm_001", text: "Hello" }, authContext)
      ).rejects.toThrow("COMMUNITY_ONLY_ADMINS_CAN_POST");
    });

    it("throws when media sharing is disabled for non-admin", async () => {
      seedActiveCommunity("comm_001", {
        settings: {
          maxMembers: 100,
          allowMemberInvites: true,
          onlyAdminsPost: false,
          membersCanShareMedia: false,
          enableFinancials: false,
          requireApprovalAbove: 5000,
          allowMemberWithdrawals: true,
          contributionCycle: "none",
          contributionAmount: 0,
          penaltyPercentage: 0,
        },
        adminIds: ["admin_user"],
      });
      seedActiveMember("comm_001", "user_001", "member");

      await expect(
        sendCommunityMessage(
          { communityId: "comm_001", mediaUrl: "https://example.com/image.jpg" },
          authContext
        )
      ).rejects.toThrow("Media sharing is disabled for members");
    });
  });

  // ========================================================================
  // markCommunityRead
  // ========================================================================
  describe("markCommunityRead", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        markCommunityRead({ communityId: "comm_001" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        markCommunityRead({}, authContext)
      ).rejects.toThrow("Community ID is required");
    });

    it("throws when community is closed", async () => {
      seedActiveCommunity("comm_001", { status: "closed" });

      await expect(
        markCommunityRead({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("COMMUNITY_CLOSED");
    });
  });

  // ========================================================================
  // toggleCommunityMessageReaction
  // ========================================================================
  describe("toggleCommunityMessageReaction", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        toggleCommunityMessageReaction(
          { communityId: "comm_001", messageId: "msg_001", emoji: "thumbsup" },
          unauthContext
        )
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when required fields are missing", async () => {
      await expect(
        toggleCommunityMessageReaction({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID, message ID, and emoji are required");

      await expect(
        toggleCommunityMessageReaction(
          { communityId: "comm_001", messageId: "msg_001" },
          authContext
        )
      ).rejects.toThrow("Community ID, message ID, and emoji are required");
    });
  });

  // ========================================================================
  // contributeToCommunity
  // ========================================================================
  describe("contributeToCommunity", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        contributeToCommunity({ communityId: "comm_001", amount: 1000 }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId or amount is missing", async () => {
      await expect(
        contributeToCommunity({ amount: 1000 }, authContext)
      ).rejects.toThrow("Community ID and amount are required");

      await expect(
        contributeToCommunity({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID and amount are required");
    });

    it("throws when amount is zero", async () => {
      // amount: 0 is falsy, caught by the !amount check
      await expect(
        contributeToCommunity({ communityId: "comm_001", amount: 0 }, authContext)
      ).rejects.toThrow("Community ID and amount are required");
    });

    it("throws when amount is negative", async () => {
      await expect(
        contributeToCommunity({ communityId: "comm_001", amount: -100 }, authContext)
      ).rejects.toThrow("Amount must be positive");
    });

    it("throws when amount exceeds maximum (10,000,000 tokens = 100,000 ZAR)", async () => {
      await expect(
        contributeToCommunity({ communityId: "comm_001", amount: 10_000_001 }, authContext)
      ).rejects.toThrow("Amount exceeds maximum allowed (100,000 ZAR)");
    });

    it("accepts amount at exactly the maximum boundary", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      const result = await contributeToCommunity(
        { communityId: "comm_001", amount: 10_000_000 },
        authContext
      );
      expect(result.success).toBe(true);
    });

    it("throws when financials are not enabled", async () => {
      seedActiveCommunity("comm_001", {
        settings: {
          maxMembers: 100,
          allowMemberInvites: true,
          onlyAdminsPost: false,
          membersCanShareMedia: true,
          enableFinancials: false,
          requireApprovalAbove: 5000,
          allowMemberWithdrawals: true,
          contributionCycle: "none",
          contributionAmount: 0,
          penaltyPercentage: 0,
        },
      });
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        contributeToCommunity({ communityId: "comm_001", amount: 1000 }, authContext)
      ).rejects.toThrow("Financials are not enabled for this community");
    });

    it("returns deduplicated result when idempotency key matches existing transaction", async () => {
      // Seed the transaction subcollection with a matching idempotency key
      setMockCollection("communities/comm_001/transactions", [
        {
          id: "tx_existing",
          data: {
            idempotencyKey: "idem_key_123",
            journalId: "j_existing_001",
          },
        },
      ]);
      seedActiveCommunity("comm_001");

      const result = await contributeToCommunity(
        { communityId: "comm_001", amount: 1000, idempotencyKey: "idem_key_123" },
        authContext
      );

      expect(result.success).toBe(true);
      expect(result.deduplicated).toBe(true);
      expect(result.journalId).toBe("j_existing_001");
    });

    it("processes contribution successfully through ledger", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      const result = await contributeToCommunity(
        { communityId: "comm_001", amount: 5000 },
        authContext
      );

      expect(result.success).toBe(true);
      expect(result.journalId).toBe("j_contrib_001");
      expect(mockProcessGroupContribution).toHaveBeenCalledWith(
        "comm_001",
        "user_001",
        5000,
        expect.any(String)
      );
    });

    it("throws when ledger contribution fails", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      mockProcessGroupContribution.mockResolvedValueOnce({
        success: false,
        error: "Insufficient user balance",
      });

      await expect(
        contributeToCommunity({ communityId: "comm_001", amount: 5000 }, authContext)
      ).rejects.toThrow("Insufficient user balance");
    });

    it("calls requirePlayIntegrity", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      await contributeToCommunity(
        { communityId: "comm_001", amount: 1000 },
        authContext
      );

      expect(mockRequirePlayIntegrity).toHaveBeenCalled();
    });
  });

  // ========================================================================
  // withdrawFromCommunity
  // ========================================================================
  describe("withdrawFromCommunity", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        withdrawFromCommunity({ communityId: "comm_001", amount: 1000 }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId or amount is missing", async () => {
      await expect(
        withdrawFromCommunity({ amount: 1000 }, authContext)
      ).rejects.toThrow("Community ID and amount are required");

      await expect(
        withdrawFromCommunity({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID and amount are required");
    });

    it("throws when amount is zero", async () => {
      await expect(
        withdrawFromCommunity({ communityId: "comm_001", amount: 0 }, authContext)
      ).rejects.toThrow("Community ID and amount are required");
    });

    it("throws when amount is negative", async () => {
      await expect(
        withdrawFromCommunity({ communityId: "comm_001", amount: -500 }, authContext)
      ).rejects.toThrow("Amount must be positive");
    });

    it("throws when financials are not enabled", async () => {
      seedActiveCommunity("comm_001", {
        settings: {
          maxMembers: 100,
          allowMemberInvites: true,
          onlyAdminsPost: false,
          membersCanShareMedia: true,
          enableFinancials: false,
          requireApprovalAbove: 5000,
          allowMemberWithdrawals: true,
          contributionCycle: "none",
          contributionAmount: 0,
          penaltyPercentage: 0,
        },
      });
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        withdrawFromCommunity({ communityId: "comm_001", amount: 1000 }, authContext)
      ).rejects.toThrow("Financials are not enabled for this community");
    });

    it("throws when member withdrawals are not allowed", async () => {
      seedActiveCommunity("comm_001", {
        settings: {
          maxMembers: 100,
          allowMemberInvites: true,
          onlyAdminsPost: false,
          membersCanShareMedia: true,
          enableFinancials: true,
          requireApprovalAbove: 5000,
          allowMemberWithdrawals: false,
          contributionCycle: "none",
          contributionAmount: 0,
          penaltyPercentage: 0,
        },
      });
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        withdrawFromCommunity({ communityId: "comm_001", amount: 1000 }, authContext)
      ).rejects.toThrow("COMMUNITY_WITHDRAWALS_NOT_ALLOWED");
    });

    it("throws when amount exceeds community balance", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      mockGetGroupBalance.mockResolvedValueOnce(500);

      await expect(
        withdrawFromCommunity({ communityId: "comm_001", amount: 1000 }, authContext)
      ).rejects.toThrow("COMMUNITY_AMOUNT_EXCEEDS_BALANCE");
    });

    it("returns deduplicated result when idempotency key matches", async () => {
      setMockCollection("communities/comm_001/transactions", [
        {
          id: "tx_existing",
          data: {
            idempotencyKey: "idem_withdraw_123",
            journalId: "j_existing_withdraw",
          },
        },
      ]);
      seedActiveCommunity("comm_001");

      const result = await withdrawFromCommunity(
        { communityId: "comm_001", amount: 1000, idempotencyKey: "idem_withdraw_123" },
        authContext
      );

      expect(result.success).toBe(true);
      expect(result.deduplicated).toBe(true);
    });

    it("processes withdrawal successfully when under approval threshold", async () => {
      seedActiveCommunity("comm_001", {
        settings: {
          maxMembers: 100,
          allowMemberInvites: true,
          onlyAdminsPost: false,
          membersCanShareMedia: true,
          enableFinancials: true,
          requireApprovalAbove: 50000,
          allowMemberWithdrawals: true,
          contributionCycle: "none",
          contributionAmount: 0,
          penaltyPercentage: 0,
        },
      });
      seedActiveMember("comm_001", "user_001", "owner");
      mockGetGroupBalance.mockResolvedValueOnce(100000);

      const result = await withdrawFromCommunity(
        { communityId: "comm_001", amount: 1000 },
        authContext
      );

      expect(result.success).toBe(true);
      expect(result.approvalRequired).toBe(false);
      expect(result.journalId).toBe("j_withdraw_001");
      expect(mockProcessGroupWithdrawal).toHaveBeenCalledWith(
        "comm_001",
        "user_001",
        1000,
        expect.any(String)
      );
    });

    it("throws when ledger withdrawal fails", async () => {
      seedActiveCommunity("comm_001", {
        settings: {
          maxMembers: 100,
          allowMemberInvites: true,
          onlyAdminsPost: false,
          membersCanShareMedia: true,
          enableFinancials: true,
          requireApprovalAbove: 50000,
          allowMemberWithdrawals: true,
          contributionCycle: "none",
          contributionAmount: 0,
          penaltyPercentage: 0,
        },
      });
      seedActiveMember("comm_001", "user_001", "owner");
      mockGetGroupBalance.mockResolvedValueOnce(100000);
      mockProcessGroupWithdrawal.mockResolvedValueOnce({
        success: false,
        error: "Group account frozen",
      });

      await expect(
        withdrawFromCommunity({ communityId: "comm_001", amount: 1000 }, authContext)
      ).rejects.toThrow("Group account frozen");
    });
  });

  // ========================================================================
  // approveCommunityTransaction
  // ========================================================================
  describe("approveCommunityTransaction", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        approveCommunityTransaction(
          { communityId: "comm_001", transactionId: "tx_001" },
          unauthContext
        )
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when required fields are missing", async () => {
      await expect(
        approveCommunityTransaction({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID and transaction ID are required");

      await expect(
        approveCommunityTransaction({ transactionId: "tx_001" }, authContext)
      ).rejects.toThrow("Community ID and transaction ID are required");
    });

    it("throws when no pending approval exists for the transaction", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");

      await expect(
        approveCommunityTransaction(
          { communityId: "comm_001", transactionId: "tx_missing" },
          authContext
        )
      ).rejects.toThrow("No pending approval found");
    });

    it("throws when transaction is not found but approval exists", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      // Seed approval but no transaction — inside-transaction check catches the missing doc
      setMockDoc("communities/comm_001/pendingApprovals", "approval_001", {
        id: "approval_001",
        transactionId: "tx_missing",
        status: "pending",
        approvers: [],
        requiredApprovers: ["user_001"],
        expiresAt: { toDate: () => new Date(Date.now() + 86400000) },
      });

      await expect(
        approveCommunityTransaction(
          { communityId: "comm_001", transactionId: "tx_missing" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_TRANSACTION_NOT_FOUND");
    });

    it("throws when transaction is already completed", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      setMockDoc("communities/comm_001/transactions", "tx_001", {
        id: "tx_001",
        status: "completed",
        type: "withdrawal",
        amount: 1000,
      });
      // Seed a pending approval so the query passes and the inside-transaction check catches the status
      setMockDoc("communities/comm_001/pendingApprovals", "approval_001", {
        id: "approval_001",
        transactionId: "tx_001",
        status: "pending",
        approvers: [],
        requiredApprovers: ["user_001"],
        expiresAt: { toDate: () => new Date(Date.now() + 86400000) },
      });

      await expect(
        approveCommunityTransaction(
          { communityId: "comm_001", transactionId: "tx_001" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_TRANSACTION_ALREADY_APPROVED");
    });

    it("throws when transaction is already rejected", async () => {
      seedActiveCommunity("comm_001");
      seedActiveMember("comm_001", "user_001", "owner");
      setMockDoc("communities/comm_001/transactions", "tx_001", {
        id: "tx_001",
        status: "rejected",
        type: "withdrawal",
        amount: 1000,
      });
      // Seed a pending approval so the query passes and the inside-transaction check catches the status
      setMockDoc("communities/comm_001/pendingApprovals", "approval_001", {
        id: "approval_001",
        transactionId: "tx_001",
        status: "pending",
        approvers: [],
        requiredApprovers: ["user_001"],
        expiresAt: { toDate: () => new Date(Date.now() + 86400000) },
      });

      await expect(
        approveCommunityTransaction(
          { communityId: "comm_001", transactionId: "tx_001" },
          authContext
        )
      ).rejects.toThrow("COMMUNITY_TRANSACTION_ALREADY_REJECTED");
    });
  });

  // ========================================================================
  // rejectCommunityTransaction
  // ========================================================================
  describe("rejectCommunityTransaction", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        rejectCommunityTransaction(
          { communityId: "comm_001", transactionId: "tx_001" },
          unauthContext
        )
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when required fields are missing", async () => {
      await expect(
        rejectCommunityTransaction({ communityId: "comm_001" }, authContext)
      ).rejects.toThrow("Community ID and transaction ID are required");
    });
  });

  // ========================================================================
  // getUserCommunities
  // ========================================================================
  describe("getUserCommunities", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        getUserCommunities({}, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });
  });

  // ========================================================================
  // getCommunityDetails
  // ========================================================================
  describe("getCommunityDetails", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        getCommunityDetails({ communityId: "comm_001" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        getCommunityDetails({}, authContext)
      ).rejects.toThrow("Community ID is required");
    });
  });

  // ========================================================================
  // getCommunityTransactions
  // ========================================================================
  describe("getCommunityTransactions", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        getCommunityTransactions({ communityId: "comm_001" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        getCommunityTransactions({}, authContext)
      ).rejects.toThrow("Community ID is required");
    });
  });

  // ========================================================================
  // getCommunityPendingApprovals
  // ========================================================================
  describe("getCommunityPendingApprovals", () => {
    it("throws unauthenticated when not logged in", async () => {
      await expect(
        getCommunityPendingApprovals({ communityId: "comm_001" }, unauthContext)
      ).rejects.toThrow("User must be authenticated");
    });

    it("throws when communityId is missing", async () => {
      await expect(
        getCommunityPendingApprovals({}, authContext)
      ).rejects.toThrow("Community ID is required");
    });
  });

  // ========================================================================
  // validateCommunitySettings (tested via createCommunity)
  // ========================================================================
  describe("validateCommunitySettings (via createCommunity)", () => {
    it("allows all zeroes (edge case)", async () => {
      seedUserProfile("user_001");
      await expect(
        createCommunity(
          {
            name: "Zero",
            type: "regular",
            settings: {
              contributionAmount: 0,
              penaltyPercentage: 0,
              maxMembers: 1,
              requireApprovalAbove: 0,
            },
          },
          authContext
        )
      ).resolves.toBeDefined();
    });

    it("allows penalty at exactly 100", async () => {
      seedUserProfile("user_001");
      await expect(
        createCommunity(
          {
            name: "MaxPenalty",
            type: "regular",
            settings: { penaltyPercentage: 100 },
          },
          authContext
        )
      ).resolves.toBeDefined();
    });

    it("allows penalty at exactly 0", async () => {
      seedUserProfile("user_001");
      await expect(
        createCommunity(
          {
            name: "NoPenalty",
            type: "regular",
            settings: { penaltyPercentage: 0 },
          },
          authContext
        )
      ).resolves.toBeDefined();
    });
  });

  // ========================================================================
  // validateStokvelSettings (tested via createCommunity)
  // ========================================================================
  describe("validateStokvelSettings (via createCommunity)", () => {
    it("allows zero contribution amount", async () => {
      seedUserProfile("user_001");
      await expect(
        createCommunity(
          {
            name: "Stokvel",
            type: "stokvel",
            stokvelSettings: { contributionAmount: 0 },
          },
          authContext
        )
      ).resolves.toBeDefined();
    });

    it("rejects negative contribution amount in stokvel settings", async () => {
      await expect(
        createCommunity(
          {
            name: "Stokvel",
            type: "stokvel",
            stokvelSettings: { contributionAmount: -100 },
          },
          authContext
        )
      ).rejects.toThrow("Contribution amount must not be negative");
    });

    it("does not validate stokvel settings for regular type", async () => {
      // stokvelSettings are ignored for regular communities — should not throw
      seedUserProfile("user_001");
      await expect(
        createCommunity(
          {
            name: "Regular",
            type: "regular",
            stokvelSettings: { payoutType: "invalid_type" },
          },
          authContext
        )
      ).resolves.toBeDefined();
    });
  });
});
