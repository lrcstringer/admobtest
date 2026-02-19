/**
 * Communities E2EE Cloud Functions — Test Suite
 *
 * Tests the E2EE-specific aspects of sendCommunityMessage:
 * - Ciphertext storage
 * - E2EE metadata (protocol, chainId, msgNum)
 * - textContent=null when encrypted
 * - No x3dhHeader (Sender Key protocol)
 * - Plaintext backwards compatibility
 * - encryptedPreviews on community update
 */

import { resetMocks, mockFirestore } from "./mocks/admin.mock";
import { createMockCallContext } from "./mocks/firestore.mock";

// ── Mocks ──────────────────────────────────────────────────────────────────

jest.mock("firebase-admin", () => require("./mocks/admin.mock").mockFirebaseAdmin);

jest.mock("firebase-functions", () => ({
  https: {
    onCall: jest.fn((handler) => handler),
    HttpsError: class HttpsError extends Error {
      constructor(
        public code: string,
        public message: string,
        public details?: unknown
      ) {
        super(message);
        this.name = "HttpsError";
      }
    },
  },
  pubsub: {
    schedule: jest.fn(() => ({
      timeZone: jest.fn(() => ({
        onRun: jest.fn((handler) => handler),
      })),
    })),
  },
  logger: { log: jest.fn(), info: jest.fn(), warn: jest.fn(), error: jest.fn() },
}));

const mockRequireAppCheck = jest.fn();
jest.mock("../security", () => ({
  requireAppCheck: (...args: unknown[]) => mockRequireAppCheck(...args),
  requirePlayIntegrity: jest.fn(),
}));

jest.mock("../ledger/groupAccounts", () => ({
  getOrCreateGroupAccount: jest.fn().mockResolvedValue({ success: true }),
  getGroupBalance: jest.fn().mockResolvedValue(0),
  processGroupContribution: jest.fn().mockResolvedValue({ success: true, journalId: "j1" }),
  processGroupWithdrawal: jest.fn().mockResolvedValue({ success: true, journalId: "j2" }),
  processGroupPayout: jest.fn().mockResolvedValue({ success: true, journalId: "j3" }),
}));

jest.mock("../ledger/types", () => ({}));

jest.mock("../helpers/communityHelpers", () => {
  return {
    CommunityConfig: {
      COLLECTION: "communities",
      SUBCOLLECTION_MEMBERS: "members",
      SUBCOLLECTION_MESSAGES: "messages",
      SUBCOLLECTION_TRANSACTIONS: "transactions",
      SUBCOLLECTION_APPROVALS: "pendingApprovals",
      DEFAULT_APPROVAL_THRESHOLD: 5000,
      DEFAULT_PENALTY_PERCENTAGE: 5,
      DEFAULT_CONTRIBUTION_AMOUNT: 1000,
      MAX_NAME_LENGTH: 50,
      MAX_DESCRIPTION_LENGTH: 200,
      MAX_MEMBERS: 100,
      MIN_MEMBERS_FOR_STOKVEL: 3,
      APPROVAL_EXPIRY_HOURS: 72,
      INVITATION_EXPIRY_DAYS: 7,
    },
    CommunityErrorCodes: {
      NOT_FOUND: "COMMUNITY_NOT_FOUND",
      ONLY_ADMINS_CAN_POST: "ONLY_ADMINS_CAN_POST",
      PERMISSION_DENIED: "PERMISSION_DENIED",
    },
    requireAuth: jest.fn((context: { auth?: { uid: string } | null }) => {
      if (!context.auth) {
        const HttpsError = require("firebase-functions").https.HttpsError;
        throw new HttpsError("unauthenticated", "User must be authenticated");
      }
      return context.auth.uid;
    }),
    getCommunityOrThrow: jest.fn().mockImplementation(async () => ({
      id: "comm_001",
      type: "regular",
      name: "Test Community",
      status: "active",
      ownerId: "user_001",
      memberIds: ["user_001", "user_002", "user_003"],
      adminIds: ["user_001"],
      settings: {
        onlyAdminsPost: false,
        membersCanShareMedia: true,
      },
    })),
    requireActiveCommunity: jest.fn(),
    requireCommunityMember: jest.fn().mockImplementation(async () => ({
      userId: "user_001",
      displayName: "Alice",
      avatarUrl: null,
      role: "owner",
      status: "active",
    })),
    getMemberPermissions: jest.fn().mockReturnValue({ maxTransferWithoutApproval: 10000 }),
    requirePermission: jest.fn(),
    getUserProfile: jest.fn().mockResolvedValue({
      displayName: "Alice",
      profilePicThumbUrl: null,
    }),
    getDefaultCommunitySettings: jest.fn().mockReturnValue({}),
    getDefaultStokvelSettings: jest.fn().mockReturnValue({}),
    truncate: jest.fn((text: string, maxLen: number) =>
      text.length > maxLen ? text.substring(0, maxLen) + "..." : text
    ),
    getCommunityMember: jest.fn(),
  };
});

// ── Import module under test ────────────────────────────────────────────────

import { sendCommunityMessage as _sendCommunityMessage } from "../communities";

type CallableFn = (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;
const sendCommunityMessage = _sendCommunityMessage as unknown as CallableFn;

// ── Helpers ─────────────────────────────────────────────────────────────────

const authContext = createMockCallContext({ uid: "user_001", appCheckToken: true });

/**
 * Extract the message data from the batch mock's set calls.
 * sendCommunityMessage uses batch.set(msgRef, message).
 */
function getMessageFromBatch(): Record<string, unknown> | undefined {
  const batchMock = mockFirestore.batch();
  const setCalls = (batchMock.set as jest.Mock).mock.calls;
  for (const call of setCalls) {
    const data = call[1] as Record<string, unknown>;
    if (data && data.senderId) {
      return data;
    }
  }
  return undefined;
}

/**
 * Extract the community update data from the batch mock's update calls.
 */
function getCommunityUpdateFromBatch(): Record<string, unknown> | undefined {
  const batchMock = mockFirestore.batch();
  const updateCalls = (batchMock.update as jest.Mock).mock.calls;
  for (const call of updateCalls) {
    const data = call[1] as Record<string, unknown>;
    if (data && "lastMessage" in data) {
      return data;
    }
  }
  return undefined;
}

// ============================================================================
// sendCommunityMessage — E2EE Tests
// ============================================================================

describe("sendCommunityMessage — E2EE", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("accepts ciphertext and stores it in the message document", async () => {
    const result = await sendCommunityMessage(
      {
        communityId: "comm_001",
        ciphertext: "sender_key_encrypted_payload",
        e2ee: { protocol: "senderKey", chainId: "chain_001", msgNum: 0 },
      },
      authContext
    );

    expect(result.success).toBe(true);
    expect(result.messageId).toBeDefined();

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.ciphertext).toBe("sender_key_encrypted_payload");
  });

  it("stores e2ee metadata (protocol, chainId, msgNum)", async () => {
    const e2eeMeta = {
      protocol: "senderKey",
      chainId: "chain_abc",
      msgNum: 42,
    };

    await sendCommunityMessage(
      {
        communityId: "comm_001",
        ciphertext: "encrypted_data",
        e2ee: e2eeMeta,
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.e2ee).toEqual(e2eeMeta);
  });

  it("sets textContent to null when ciphertext is present", async () => {
    await sendCommunityMessage(
      {
        communityId: "comm_001",
        ciphertext: "encrypted_data",
        e2ee: { protocol: "senderKey" },
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.textContent).toBeNull();
  });

  it("does not include x3dhHeader (Sender Key protocol uses distributeSenderKey instead)", async () => {
    await sendCommunityMessage(
      {
        communityId: "comm_001",
        ciphertext: "encrypted_data",
        e2ee: { protocol: "senderKey", chainId: "chain_001" },
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    // Community messages use Sender Key protocol — no x3dhHeader field
    expect(msgData).not.toHaveProperty("x3dhHeader");
  });

  it("supports plaintext backwards compatibility", async () => {
    await sendCommunityMessage(
      {
        communityId: "comm_001",
        text: "Hello community, this is plaintext!",
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.textContent).toBe("Hello community, this is plaintext!");
    expect(msgData!.ciphertext).toBeNull();
    expect(msgData!.e2ee).toBeNull();
  });

  it("rejects messages with no text, no ciphertext, and no media", async () => {
    await expect(
      sendCommunityMessage(
        { communityId: "comm_001" },
        authContext
      )
    ).rejects.toThrow("Message text, media, or ciphertext is required");
  });

  it("passes encryptedPreviews to community update when provided", async () => {
    const previews = {
      user_002: "encrypted_preview_for_bob",
      user_003: "encrypted_preview_for_charlie",
    };

    const result = await sendCommunityMessage(
      {
        communityId: "comm_001",
        ciphertext: "encrypted_data",
        e2ee: { protocol: "senderKey" },
        encryptedPreviews: previews,
      },
      authContext
    );

    expect(result.success).toBe(true);

    const commUpdate = getCommunityUpdateFromBatch();
    expect(commUpdate).toBeDefined();
    expect(commUpdate!.lastMessageEncryptedPreviews).toEqual(previews);
  });
});
