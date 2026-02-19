/**
 * Conversations E2EE Cloud Functions — Test Suite
 *
 * Tests the E2EE-specific aspects of sendConversationMessage:
 * - Ciphertext storage
 * - E2EE metadata (protocol, sessionId, messageNumber)
 * - X3DH header storage
 * - textContent=null when encrypted
 * - Rejection of empty messages (no text, no ciphertext, no media)
 * - Plaintext backwards compatibility
 * - encryptedPreviews on conversation update
 */

import { resetMocks, mockFirestore } from "./mocks/admin.mock";
import {
  createMockCallContext,
  setupMockDocument,
} from "./mocks/firestore.mock";

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
  logger: { log: jest.fn(), info: jest.fn(), warn: jest.fn(), error: jest.fn() },
}));

const mockRequireAppCheck = jest.fn();
jest.mock("../security", () => ({
  requireAppCheck: (...args: unknown[]) => mockRequireAppCheck(...args),
  requirePlayIntegrity: jest.fn(),
}));

jest.mock("../ledger", () => ({
  processP2PTransfer: jest.fn(),
  getDefaultSubAccount: jest.fn(),
  validateSubAccountAllows: jest.fn(),
  validateSubAccountBalance: jest.fn(),
  validateMainWalletBalance: jest.fn(),
}));

// ── Import module under test ────────────────────────────────────────────────

import { sendConversationMessage as _sendConversationMessage } from "../conversations";

type CallableFn = (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;
const sendConversationMessage = _sendConversationMessage as unknown as CallableFn;

// ── Helpers ─────────────────────────────────────────────────────────────────

const authContext = createMockCallContext({ uid: "user_001", appCheckToken: true });

function setupConversation(): void {
  setupMockDocument("conversations", "conv_001", {
    id: "conv_001",
    type: "p2p",
    participantIds: ["user_001", "user_002"],
    participants: {
      user_001: { displayName: "Alice", avatarUrl: null },
      user_002: { displayName: "Bob", avatarUrl: null },
    },
    unreadCounts: { user_001: 0, user_002: 0 },
  });

  // Sender profile
  setupMockDocument("users", "user_001", {
    displayName: "Alice",
    profilePicThumbUrl: null,
  });
}

/**
 * Extract the message data from the batch mock's set calls.
 * sendConversationMessage uses batch.set(messageRef, message) so we
 * access the batch mock rather than mockOperations.sets.
 */
function getMessageFromBatch(): Record<string, unknown> | undefined {
  const batchMock = mockFirestore.batch();
  // batch() returns the same mock object each time due to mockReturnValue
  const setCalls = (batchMock.set as jest.Mock).mock.calls;
  // Find the call where the data has an 'id' and 'senderId' (message doc)
  for (const call of setCalls) {
    const data = call[1] as Record<string, unknown>;
    if (data && data.senderId) {
      return data;
    }
  }
  return undefined;
}

/**
 * Extract the conversation update data from the batch mock's update calls.
 */
function getConversationUpdateFromBatch(): Record<string, unknown> | undefined {
  const batchMock = mockFirestore.batch();
  const updateCalls = (batchMock.update as jest.Mock).mock.calls;
  // Find the update call that has lastMessageText (conversation update)
  for (const call of updateCalls) {
    const data = call[1] as Record<string, unknown>;
    if (data && "lastMessageText" in data) {
      return data;
    }
  }
  return undefined;
}

// ============================================================================
// sendConversationMessage — E2EE Tests
// ============================================================================

describe("sendConversationMessage — E2EE", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
    setupConversation();
  });

  it("accepts ciphertext and stores it in the message document", async () => {
    const result = await sendConversationMessage(
      {
        conversationId: "conv_001",
        ciphertext: "base64_encrypted_payload",
        e2ee: { protocol: "x3dh+doubleRatchet", sessionId: "sess_001", messageNumber: 0 },
      },
      authContext
    );

    expect(result.success).toBe(true);
    expect(result.messageId).toBeDefined();

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.ciphertext).toBe("base64_encrypted_payload");
  });

  it("stores e2ee metadata in the message document", async () => {
    const e2eeMeta = {
      protocol: "x3dh+doubleRatchet",
      sessionId: "sess_abc",
      messageNumber: 5,
    };

    await sendConversationMessage(
      {
        conversationId: "conv_001",
        ciphertext: "encrypted_data",
        e2ee: e2eeMeta,
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.e2ee).toEqual(e2eeMeta);
  });

  it("stores x3dhHeader when provided", async () => {
    const x3dhHeader = {
      identityKey: "ik_sender",
      ephemeralKey: "ek_abc",
      preKeyId: 42,
    };

    await sendConversationMessage(
      {
        conversationId: "conv_001",
        ciphertext: "encrypted_data",
        e2ee: { protocol: "x3dh" },
        x3dhHeader,
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.x3dhHeader).toEqual(x3dhHeader);
  });

  it("sets textContent to null when ciphertext is present", async () => {
    await sendConversationMessage(
      {
        conversationId: "conv_001",
        ciphertext: "encrypted_data",
        e2ee: { protocol: "x3dh" },
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.textContent).toBeNull();
  });

  it("rejects messages with no text, no ciphertext, and no media", async () => {
    await expect(
      sendConversationMessage(
        { conversationId: "conv_001" },
        authContext
      )
    ).rejects.toThrow("Either text, mediaUrl, or ciphertext is required");
  });

  it("supports plaintext backwards compatibility", async () => {
    await sendConversationMessage(
      {
        conversationId: "conv_001",
        text: "Hello, this is plaintext!",
      },
      authContext
    );

    const msgData = getMessageFromBatch();
    expect(msgData).toBeDefined();
    expect(msgData!.textContent).toBe("Hello, this is plaintext!");
    expect(msgData!.ciphertext).toBeNull();
    expect(msgData!.e2ee).toBeNull();
    expect(msgData!.x3dhHeader).toBeNull();
  });

  it("sets lastMessageText to null on conversation when ciphertext is present", async () => {
    await sendConversationMessage(
      {
        conversationId: "conv_001",
        ciphertext: "encrypted_data",
        e2ee: { protocol: "x3dh" },
      },
      authContext
    );

    const convUpdate = getConversationUpdateFromBatch();
    expect(convUpdate).toBeDefined();
    expect(convUpdate!.lastMessageText).toBeNull();
  });

  it("passes encryptedPreviews to conversation update when provided", async () => {
    const previews = {
      user_002: "encrypted_preview_for_bob",
    };

    const result = await sendConversationMessage(
      {
        conversationId: "conv_001",
        ciphertext: "encrypted_data",
        e2ee: { protocol: "x3dh" },
        encryptedPreviews: previews,
      },
      authContext
    );

    expect(result.success).toBe(true);

    const convUpdate = getConversationUpdateFromBatch();
    expect(convUpdate).toBeDefined();
    expect(convUpdate!.lastMessageEncryptedPreviews).toEqual(previews);
  });
});
