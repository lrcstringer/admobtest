/**
 * Voice & Video Calling Cloud Functions — Test Suite
 *
 * Tests: initiateCall, answerCall, endCall, getTurnCredentials,
 *        onCallUpdated, cleanupStaleCalls
 */

import { resetMocks, mockOperations, mockFirestore } from "./mocks/admin.mock";
import {
  createMockCallContext,
  setupMockDocument,
  createTimestamp,
} from "./mocks/firestore.mock";

// ── Mocks ──────────────────────────────────────────────────────────────

const mockSend = jest.fn().mockResolvedValue("message-id");

jest.mock("firebase-admin", () => {
  const mock = require("./mocks/admin.mock").mockFirebaseAdmin;
  // Add messaging mock
  mock.messaging = jest.fn().mockReturnValue({ send: mockSend });
  return mock;
});

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

jest.mock("firebase-functions/v2/firestore", () => ({
  onDocumentUpdated: jest.fn((...args: unknown[]) => {
    const handler = typeof args[0] === "function" ? args[0] : args[1];
    return handler;
  }),
}));

jest.mock("firebase-functions/v2/scheduler", () => ({
  onSchedule: jest.fn((...args: unknown[]) => {
    const handler = typeof args[0] === "function" ? args[0] : args[1];
    return handler;
  }),
}));

// ── Import functions under test ──────────────────────────────────────

import {
  initiateCall,
  answerCall,
  endCall,
  getTurnCredentials,
  onCallUpdated,
  cleanupStaleCalls,
} from "../calls";

// ── Helpers ──────────────────────────────────────────────────────────

function createCallContext(uid: string) {
  return createMockCallContext({ uid, appCheckToken: true });
}

function setupConversation(convId: string, participants: string[]) {
  const participantMap: Record<string, { displayName: string; avatarUrl: string }> = {};
  participants.forEach((uid) => {
    participantMap[uid] = { displayName: `User ${uid}`, avatarUrl: "" };
  });
  setupMockDocument("conversations", convId, {
    participantIds: participants,
    participants: participantMap,
  });
}

function setupCallDoc(callId: string, data: Record<string, unknown>) {
  setupMockDocument("calls", callId, data);
}

function setupUserDoc(uid: string, data: Record<string, unknown>) {
  setupMockDocument("users", uid, data);
}

// ── Tests ────────────────────────────────────────────────────────────

describe("calls Cloud Functions", () => {
  beforeEach(() => {
    resetMocks();
    jest.clearAllMocks();
  });

  // ─── initiateCall ───────────────────────────────────────────────────

  describe("initiateCall", () => {
    it("should create a call document with ringing status", async () => {
      setupConversation("conv_1", ["caller_1", "callee_1"]);
      setupUserDoc("callee_1", { fcmToken: "token_123" });

      const context = createCallContext("caller_1");
      const result = await (initiateCall as Function)(
        {
          conversationId: "conv_1",
          recipientId: "callee_1",
          callType: "voice",
        },
        context
      );

      expect(result.success).toBe(true);
      expect(result.callId).toBeDefined();
    });

    it("should reject unauthenticated requests", async () => {
      const context = createMockCallContext(null);
      await expect(
        (initiateCall as Function)(
          { conversationId: "conv_1", recipientId: "callee_1", callType: "voice" },
          context
        )
      ).rejects.toThrow("User must be authenticated");
    });

    it("should reject missing required fields", async () => {
      const context = createCallContext("caller_1");
      await expect(
        (initiateCall as Function)(
          { conversationId: "", recipientId: "callee_1", callType: "voice" },
          context
        )
      ).rejects.toThrow("Missing required fields");
    });

    it("should reject invalid callType", async () => {
      const context = createCallContext("caller_1");
      await expect(
        (initiateCall as Function)(
          { conversationId: "conv_1", recipientId: "callee_1", callType: "invalid" },
          context
        )
      ).rejects.toThrow("callType must be voice or video");
    });

    it("should reject if conversation not found", async () => {
      const context = createCallContext("caller_1");
      await expect(
        (initiateCall as Function)(
          { conversationId: "missing_conv", recipientId: "callee_1", callType: "voice" },
          context
        )
      ).rejects.toThrow("Conversation not found");
    });

    it("should reject if user is not a participant", async () => {
      setupConversation("conv_1", ["other_1", "callee_1"]);

      const context = createCallContext("caller_1");
      await expect(
        (initiateCall as Function)(
          { conversationId: "conv_1", recipientId: "callee_1", callType: "voice" },
          context
        )
      ).rejects.toThrow("Not a participant");
    });

    it("should succeed for video calls", async () => {
      setupConversation("conv_1", ["caller_1", "callee_1"]);
      setupUserDoc("callee_1", { fcmToken: "fcm_token_callee" });

      const context = createCallContext("caller_1");
      const result = await (initiateCall as Function)(
        { conversationId: "conv_1", recipientId: "callee_1", callType: "video" },
        context
      );

      expect(result.success).toBe(true);
      expect(result.callId).toBeDefined();
    });

    it("should reject if recipient is not in the conversation", async () => {
      setupConversation("conv_1", ["caller_1", "other_user"]);

      const context = createCallContext("caller_1");
      await expect(
        (initiateCall as Function)(
          { conversationId: "conv_1", recipientId: "callee_1", callType: "voice" },
          context
        )
      ).rejects.toThrow("Recipient not in conversation");
    });

    it("should reject if an active call already exists on the conversation", async () => {
      setupConversation("conv_1", ["caller_1", "callee_1"]);
      setupCallDoc("existing_active", {
        conversationId: "conv_1",
        status: "active",
        callerId: "caller_1",
        calleeId: "callee_1",
      });

      const context = createCallContext("caller_1");
      await expect(
        (initiateCall as Function)(
          { conversationId: "conv_1", recipientId: "callee_1", callType: "voice" },
          context
        )
      ).rejects.toThrow("Call already in progress");
    });
  });

  // ─── answerCall ─────────────────────────────────────────────────────

  describe("answerCall", () => {
    it("should transition call from ringing to active", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ringing",
        conversationId: "conv_1",
      });

      const context = createCallContext("callee_1");
      const result = await (answerCall as Function)(
        { callId: "call_1" },
        context
      );

      expect(result.success).toBe(true);
      // Verify the update was called with active status
      const updateOp = mockOperations.updates.find(
        (u) => u.collection === "calls" && u.doc === "call_1"
      );
      expect(updateOp).toBeDefined();
      expect((updateOp?.data as Record<string, unknown>)?.status).toBe("active");
    });

    it("should reject if not the callee", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ringing",
      });

      const context = createCallContext("caller_1"); // Wrong user
      await expect(
        (answerCall as Function)({ callId: "call_1" }, context)
      ).rejects.toThrow("Only the callee can answer");
    });

    it("should reject answering a non-ringing call", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ended",
      });

      const context = createCallContext("callee_1");
      await expect(
        (answerCall as Function)({ callId: "call_1" }, context)
      ).rejects.toThrow("Cannot answer call in 'ended' state");
    });

    it("should reject if call not found", async () => {
      const context = createCallContext("callee_1");
      await expect(
        (answerCall as Function)({ callId: "nonexistent" }, context)
      ).rejects.toThrow("Call not found");
    });

    it("should reject missing callId", async () => {
      const context = createCallContext("callee_1");
      await expect(
        (answerCall as Function)({ callId: "" }, context)
      ).rejects.toThrow("callId is required");
    });
  });

  // ─── endCall ────────────────────────────────────────────────────────

  describe("endCall", () => {
    it("should end an active call and write system message", async () => {
      const answeredAt = createTimestamp(new Date(Date.now() - 120_000)); // 2 min ago
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "active",
        callType: "voice",
        callerName: "Test Caller",
        conversationId: "conv_1",
        answeredAt,
      });

      const context = createCallContext("caller_1");
      const result = await (endCall as Function)(
        { callId: "call_1", reason: "normal" },
        context
      );

      expect(result.success).toBe(true);

      // Verify system message was written
      const systemMsgSets = mockOperations.sets.filter(
        (s) => s.collection.includes("messages")
      );
      expect(systemMsgSets.length).toBeGreaterThanOrEqual(1);
      const msgData = systemMsgSets[0]?.data as Record<string, unknown>;
      expect(msgData?.systemEventType).toBe("call_ended");
      expect(msgData?.type).toBe("system");
    });

    it("should be idempotent — return success for already-ended calls", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ended",
        callType: "voice",
        callerName: "Test",
        conversationId: "conv_1",
      });

      const context = createCallContext("caller_1");
      const result = await (endCall as Function)(
        { callId: "call_1" },
        context
      );

      expect(result.success).toBe(true);
      // Should NOT write a duplicate system message
      const systemMsgSets = mockOperations.sets.filter(
        (s) => s.collection.includes("messages")
      );
      expect(systemMsgSets.length).toBe(0);
    });

    it("should set status to missed when reason is missed", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ringing",
        callType: "voice",
        callerName: "Test",
        conversationId: "conv_1",
        answeredAt: null,
      });

      const context = createCallContext("caller_1");
      await (endCall as Function)(
        { callId: "call_1", reason: "missed" },
        context
      );

      const updateOp = mockOperations.updates.find(
        (u) => u.collection === "calls" && u.doc === "call_1"
      );
      expect((updateOp?.data as Record<string, unknown>)?.status).toBe("missed");
    });

    it("should set status to declined when reason is declined", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ringing",
        callType: "video",
        callerName: "Test",
        conversationId: "conv_1",
        answeredAt: null,
      });

      const context = createCallContext("callee_1");
      await (endCall as Function)(
        { callId: "call_1", reason: "declined" },
        context
      );

      const updateOp = mockOperations.updates.find(
        (u) => u.collection === "calls" && u.doc === "call_1"
      );
      expect((updateOp?.data as Record<string, unknown>)?.status).toBe("declined");
    });

    it("should set status to busy when reason is busy", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ringing",
        callType: "voice",
        callerName: "Test",
        conversationId: "conv_1",
        answeredAt: null,
      });

      const context = createCallContext("callee_1");
      await (endCall as Function)(
        { callId: "call_1", reason: "busy" },
        context
      );

      const updateOp = mockOperations.updates.find(
        (u) => u.collection === "calls" && u.doc === "call_1"
      );
      expect((updateOp?.data as Record<string, unknown>)?.status).toBe("busy");
    });

    it("should reject non-participants", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "active",
      });

      const context = createCallContext("stranger_1");
      await expect(
        (endCall as Function)({ callId: "call_1" }, context)
      ).rejects.toThrow("Not a participant");
    });

    it("should reject missing callId", async () => {
      const context = createCallContext("caller_1");
      await expect(
        (endCall as Function)({ callId: "" }, context)
      ).rejects.toThrow("callId is required");
    });

    it("should set status to cancelled when reason is cancelled", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ringing",
        callType: "voice",
        callerName: "Test",
        conversationId: "conv_1",
        answeredAt: null,
      });

      const context = createCallContext("caller_1");
      await (endCall as Function)(
        { callId: "call_1", reason: "cancelled" },
        context
      );

      const updateOp = mockOperations.updates.find(
        (u) => u.collection === "calls" && u.doc === "call_1"
      );
      expect((updateOp?.data as Record<string, unknown>)?.status).toBe("cancelled");
    });

    it("should set status to failed when reason is reconnection_failed", async () => {
      setupCallDoc("call_1", {
        callId: "call_1",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "active",
        callType: "voice",
        callerName: "Test",
        conversationId: "conv_1",
        answeredAt: createTimestamp(new Date(Date.now() - 60_000)),
      });

      const context = createCallContext("caller_1");
      await (endCall as Function)(
        { callId: "call_1", reason: "reconnection_failed" },
        context
      );

      const updateOp = mockOperations.updates.find(
        (u) => u.collection === "calls" && u.doc === "call_1"
      );
      expect((updateOp?.data as Record<string, unknown>)?.status).toBe("failed");
    });

    it("should write cancelled system message text", async () => {
      setupCallDoc("call_canc", {
        callId: "call_canc",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "ringing",
        callType: "video",
        callerName: "Caller",
        conversationId: "conv_1",
        answeredAt: null,
      });

      const context = createCallContext("caller_1");
      await (endCall as Function)(
        { callId: "call_canc", reason: "cancelled" },
        context
      );

      const systemMsgSets = mockOperations.sets.filter(
        (s) => s.collection.includes("messages")
      );
      expect(systemMsgSets.length).toBeGreaterThanOrEqual(1);
      const msgData = systemMsgSets[0]?.data as Record<string, unknown>;
      expect(msgData?.textContent).toBe("Cancelled video call");
    });

    it("should set status to failed when reason is error", async () => {
      setupCallDoc("call_err", {
        callId: "call_err",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "active",
        callType: "voice",
        callerName: "Test",
        conversationId: "conv_1",
        answeredAt: createTimestamp(new Date(Date.now() - 10_000)),
      });

      const context = createCallContext("caller_1");
      await (endCall as Function)(
        { callId: "call_err", reason: "error" },
        context
      );

      const updateOp = mockOperations.updates.find(
        (u) => u.collection === "calls" && u.doc === "call_err"
      );
      expect((updateOp?.data as Record<string, unknown>)?.status).toBe("failed");
      expect((updateOp?.data as Record<string, unknown>)?.endReason).toBe("error");
    });

    it("should throw not-found when call does not exist", async () => {
      const context = createCallContext("caller_1");
      await expect(
        (endCall as Function)({ callId: "nonexistent_call" }, context)
      ).rejects.toThrow("Call not found");
    });
  });

  // ─── getTurnCredentials ─────────────────────────────────────────────

  describe("getTurnCredentials", () => {
    const originalEnv = process.env;

    beforeEach(() => {
      process.env = {
        ...originalEnv,
        CLOUDFLARE_TURN_KEY_ID: "test_key_id",
        CLOUDFLARE_TURN_API_TOKEN: "test_token",
      };
    });

    afterEach(() => {
      process.env = originalEnv;
    });

    it("should reject unauthenticated requests", async () => {
      const context = createMockCallContext(null);
      await expect(
        (getTurnCredentials as Function)({}, context)
      ).rejects.toThrow("User must be authenticated");
    });

    it("should reject if TURN not configured", async () => {
      process.env.CLOUDFLARE_TURN_KEY_ID = "";
      process.env.CLOUDFLARE_TURN_API_TOKEN = "";

      const context = createCallContext("user_1");
      await expect(
        (getTurnCredentials as Function)({}, context)
      ).rejects.toThrow("TURN not configured");
    });

    it("should throw when Cloudflare API returns non-200", async () => {
      const originalFetch = global.fetch;
      global.fetch = jest.fn().mockResolvedValueOnce({
        ok: false,
        status: 502,
      }) as unknown as typeof fetch;

      try {
        const context = createCallContext("user_1");
        await expect(
          (getTurnCredentials as Function)({}, context)
        ).rejects.toThrow("Failed to generate TURN credentials");
      } finally {
        global.fetch = originalFetch;
      }
    });

    it("should return TURN credentials with STUN servers on success", async () => {
      const originalFetch = global.fetch;
      global.fetch = jest.fn().mockResolvedValueOnce({
        ok: true,
        json: async () => ({
          iceServers: [
            { urls: "turn:example.com", username: "u", credential: "p" },
          ],
        }),
      }) as unknown as typeof fetch;

      try {
        const context = createCallContext("user_1");
        const result = await (getTurnCredentials as Function)({}, context);

        expect(result.iceServers).toBeDefined();
        expect(result.iceServers.length).toBe(3); // 2 STUN + 1 TURN
        expect(result.iceServers[0].urls).toContain("stun:");
        expect(result.iceServers[1].urls).toContain("stun:");
        expect(result.iceServers[2].urls).toBe("turn:example.com");
        expect(result.ttl).toBe(7200);
      } finally {
        global.fetch = originalFetch;
      }
    });
  });

  // ─── cleanupStaleCalls ──────────────────────────────────────────────

  describe("cleanupStaleCalls", () => {
    it("should execute without errors when no stale calls exist", async () => {
      await expect((cleanupStaleCalls as Function)()).resolves.not.toThrow();
    });

    it("should mark stale ringing calls as missed with system message", async () => {
      setupCallDoc("stale_ring_1", {
        callId: "stale_ring_1",
        conversationId: "conv_cleanup_1",
        callerId: "user_a",
        calleeId: "user_b",
        callerName: "Alice",
        callType: "voice",
        status: "ringing",
        createdAt: createTimestamp(new Date(Date.now() - 60_000)),
      });

      await (cleanupStaleCalls as Function)();

      // Verify update to missed status
      const missedUpdate = mockOperations.updates.find(
        (u) => (u.data as Record<string, unknown>)?.status === "missed"
      );
      expect(missedUpdate).toBeDefined();
      expect((missedUpdate?.data as Record<string, unknown>)?.endReason).toBe("missed");

      // Verify system message written
      const msgSets = mockOperations.sets.filter(
        (s) => s.collection.includes("messages")
      );
      expect(msgSets.length).toBeGreaterThanOrEqual(1);
      const missedMsg = msgSets.find(
        (s) =>
          ((s.data as Record<string, unknown>)?.textContent as string)?.includes("Missed")
      );
      expect(missedMsg).toBeDefined();
      expect((missedMsg?.data as Record<string, unknown>)?.systemEventType).toBe("call_ended");
    });

    it("should end stale active calls with system message when both heartbeats stale", async () => {
      const staleTs = createTimestamp(new Date(Date.now() - 60_000));
      const answeredTs = createTimestamp(new Date(Date.now() - 300_000));
      setupCallDoc("stale_active_1", {
        callId: "stale_active_1",
        conversationId: "conv_cleanup_2",
        callerId: "user_c",
        calleeId: "user_d",
        callerName: "Charlie",
        callType: "video",
        status: "active",
        callerHeartbeat: staleTs,
        calleeHeartbeat: staleTs,
        answeredAt: answeredTs,
      });

      await (cleanupStaleCalls as Function)();

      // Verify update to ended with peer_offline
      const endedUpdate = mockOperations.updates.find(
        (u) => (u.data as Record<string, unknown>)?.endReason === "peer_offline"
      );
      expect(endedUpdate).toBeDefined();
      expect((endedUpdate?.data as Record<string, unknown>)?.status).toBe("ended");
      expect((endedUpdate?.data as Record<string, unknown>)?.durationSeconds).toBeGreaterThan(0);

      // Verify system message for stale active call
      const msgSets = mockOperations.sets.filter(
        (s) => s.collection.includes("messages")
      );
      const endedMsg = msgSets.find(
        (s) =>
          ((s.data as Record<string, unknown>)?.systemEventData as Record<string, unknown>)
            ?.endReason === "peer_offline"
      );
      expect(endedMsg).toBeDefined();
      expect((endedMsg?.data as Record<string, unknown>)?.textContent).toMatch(/Video call/);
    });

    it("should skip active calls where callee heartbeat is recent", async () => {
      const recentTs = createTimestamp(new Date());
      const staleTs = createTimestamp(new Date(Date.now() - 60_000));
      setupCallDoc("alive_callee", {
        callId: "alive_callee",
        conversationId: "conv_cleanup_3",
        callerId: "user_e",
        calleeId: "user_f",
        callerName: "Eve",
        callType: "voice",
        status: "active",
        callerHeartbeat: staleTs,
        calleeHeartbeat: recentTs,
        answeredAt: createTimestamp(new Date(Date.now() - 120_000)),
      });

      await (cleanupStaleCalls as Function)();

      // Should NOT have a peer_offline update (callee is still alive)
      const peerOfflineUpdate = mockOperations.updates.find(
        (u) => (u.data as Record<string, unknown>)?.endReason === "peer_offline"
      );
      expect(peerOfflineUpdate).toBeUndefined();
    });

    it("should end stale active calls when calleeHeartbeat is null (never answered heartbeat)", async () => {
      const staleTs = createTimestamp(new Date(Date.now() - 60_000));
      const answeredTs = createTimestamp(new Date(Date.now() - 120_000));
      setupCallDoc("null_hb", {
        callId: "null_hb",
        conversationId: "conv_cleanup_4",
        callerId: "user_g",
        calleeId: "user_h",
        callerName: "Grace",
        callType: "voice",
        status: "active",
        callerHeartbeat: staleTs,
        calleeHeartbeat: null,
        answeredAt: answeredTs,
      });

      await (cleanupStaleCalls as Function)();

      // null calleeHeartbeat means falsy check → NOT skipped → should be ended
      const endedUpdate = mockOperations.updates.find(
        (u) => (u.data as Record<string, unknown>)?.endReason === "peer_offline"
      );
      expect(endedUpdate).toBeDefined();
      expect((endedUpdate?.data as Record<string, unknown>)?.status).toBe("ended");
    });
  });

  // ─── onCallUpdated ────────────────────────────────────────────────────

  describe("onCallUpdated", () => {
    it("should delete ICE candidate subcollections on terminal status transition", async () => {
      const callerCands = [
        { id: "cand_1", ref: { id: "cand_1", path: "calls/c1/callerCandidates/cand_1" } },
        { id: "cand_2", ref: { id: "cand_2", path: "calls/c1/callerCandidates/cand_2" } },
      ];
      const calleeCands = [
        { id: "cand_3", ref: { id: "cand_3", path: "calls/c1/calleeCandidates/cand_3" } },
      ];

      const mockRef = {
        collection: jest.fn().mockImplementation((name: string) => ({
          get: jest.fn().mockResolvedValue({
            docs: name === "callerCandidates" ? callerCands : calleeCands,
            size: name === "callerCandidates" ? callerCands.length : calleeCands.length,
          }),
        })),
      };

      const event = {
        data: {
          before: { data: () => ({ status: "active" }) },
          after: { data: () => ({ status: "ended" }), ref: mockRef },
        },
      };

      const batch = mockFirestore.batch();
      batch.delete.mockClear();
      batch.commit.mockClear();

      await (onCallUpdated as Function)(event);

      expect(batch.delete).toHaveBeenCalledTimes(3);
      expect(batch.commit).toHaveBeenCalledTimes(1);
    });

    it("should not clean up when status stays non-terminal", async () => {
      const event = {
        data: {
          before: { data: () => ({ status: "ringing" }) },
          after: { data: () => ({ status: "active" }), ref: {} },
        },
      };

      const batch = mockFirestore.batch();
      batch.delete.mockClear();
      batch.commit.mockClear();

      await (onCallUpdated as Function)(event);

      expect(batch.delete).not.toHaveBeenCalled();
      expect(batch.commit).not.toHaveBeenCalled();
    });

    it("should not commit when subcollections are empty", async () => {
      const mockRef = {
        collection: jest.fn().mockImplementation(() => ({
          get: jest.fn().mockResolvedValue({ docs: [], size: 0 }),
        })),
      };

      const event = {
        data: {
          before: { data: () => ({ status: "active" }) },
          after: { data: () => ({ status: "ended" }), ref: mockRef },
        },
      };

      const batch = mockFirestore.batch();
      batch.delete.mockClear();
      batch.commit.mockClear();

      await (onCallUpdated as Function)(event);

      expect(batch.delete).not.toHaveBeenCalled();
      expect(batch.commit).not.toHaveBeenCalled();
    });

    it("should not clean up when both statuses are terminal", async () => {
      const event = {
        data: {
          before: { data: () => ({ status: "ended" }) },
          after: { data: () => ({ status: "ended" }), ref: {} },
        },
      };

      const batch = mockFirestore.batch();
      batch.delete.mockClear();
      batch.commit.mockClear();

      await (onCallUpdated as Function)(event);

      expect(batch.delete).not.toHaveBeenCalled();
    });

    it("should handle missing event data gracefully", async () => {
      const event = {
        data: {
          before: { data: () => null },
          after: { data: () => null },
        },
      };

      await expect((onCallUpdated as Function)(event)).resolves.not.toThrow();
    });
  });

  // ─── formatDuration (tested indirectly via endCall) ─────────────────

  describe("formatDuration (via endCall system message)", () => {
    it("should format call duration in m:ss format", async () => {
      const answeredAt = createTimestamp(new Date(Date.now() - 125_000)); // 2 min 5 sec ago
      setupCallDoc("call_dur", {
        callId: "call_dur",
        callerId: "caller_1",
        calleeId: "callee_1",
        status: "active",
        callType: "voice",
        callerName: "Caller",
        conversationId: "conv_1",
        answeredAt,
      });

      const context = createCallContext("caller_1");
      await (endCall as Function)({ callId: "call_dur", reason: "normal" }, context);

      const msgSets = mockOperations.sets.filter(
        (s) => s.collection.includes("messages")
      );
      expect(msgSets.length).toBeGreaterThanOrEqual(1);
      const text = (msgSets[0].data as Record<string, unknown>)?.textContent as string;
      // Should match pattern "Voice call, X:XX"
      expect(text).toMatch(/Voice call, \d+:\d{2}/);
    });
  });
});
