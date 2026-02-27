/**
 * Key Management Cloud Functions — Test Suite
 *
 * Tests all E2EE key management functions:
 * - uploadKeyBundle
 * - fetchKeyBundle
 * - replenishOneTimePreKeys
 * - rotateSignedPreKey
 * - saveKeyBackup
 * - getKeyBackup
 * - distributeSenderKey
 * - markKeyDistributionConsumed
 */

import { resetMocks, mockOperations } from "./mocks/admin.mock";
import {
  createMockCallContext,
  setupMockDocument,
} from "./mocks/firestore.mock";

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
    // Support onCall(handler) and onCall(opts, handler)
    const handler = typeof args[0] === "function" ? args[0] : args[1];
    // Return adapter: tests call fn(data, context), handler expects request object
    return (data: unknown, context: unknown) =>
      (handler as Function)({ data, ...(context as object) });
  }),
  HttpsError: MockHttpsError,
}));

const mockRequireAppCheck = jest.fn();
jest.mock("../security", () => ({
  requireAppCheck: (...args: unknown[]) => mockRequireAppCheck(...args),
  requirePlayIntegrity: jest.fn(),
}));

// ── Import module under test ────────────────────────────────────────────────

import {
  uploadKeyBundle as _uploadKeyBundle,
  fetchKeyBundle as _fetchKeyBundle,
  replenishOneTimePreKeys as _replenishOneTimePreKeys,
  rotateSignedPreKey as _rotateSignedPreKey,
  saveKeyBackup as _saveKeyBackup,
  getKeyBackup as _getKeyBackup,
  distributeSenderKey as _distributeSenderKey,
  markKeyDistributionConsumed as _markKeyDistributionConsumed,
} from "../keyManagement";

// onCall mock returns the raw handler — cast to callable
type CallableFn = (data: Record<string, unknown>, context: unknown) => Promise<Record<string, unknown>>;

const uploadKeyBundle = _uploadKeyBundle as unknown as CallableFn;
const fetchKeyBundle = _fetchKeyBundle as unknown as CallableFn;
const replenishOneTimePreKeys = _replenishOneTimePreKeys as unknown as CallableFn;
const rotateSignedPreKey = _rotateSignedPreKey as unknown as CallableFn;
const saveKeyBackup = _saveKeyBackup as unknown as CallableFn;
const getKeyBackup = _getKeyBackup as unknown as CallableFn;
const distributeSenderKey = _distributeSenderKey as unknown as CallableFn;
const markKeyDistributionConsumed = _markKeyDistributionConsumed as unknown as CallableFn;

// ── Helpers ─────────────────────────────────────────────────────────────────

const authContext = createMockCallContext({ uid: "user_001", appCheckToken: true });
const otherAuthContext = createMockCallContext({ uid: "user_002", appCheckToken: true });
const unauthContext = createMockCallContext(null);

const validKeyBundle = {
  identityKey: "identity_key_base64",
  signedPreKey: "signed_pre_key_base64",
  signedPreKeySignature: "signature_base64",
  oneTimePreKeys: ["otk_1", "otk_2", "otk_3"],
  registrationId: 12345,
};

// ============================================================================
// uploadKeyBundle
// ============================================================================

describe("uploadKeyBundle", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      uploadKeyBundle(validKeyBundle, unauthContext)
    ).rejects.toThrow("Authentication required.");
  });

  it("stores all key components in Firestore", async () => {
    const result = await uploadKeyBundle(validKeyBundle, authContext);

    expect(result.success).toBe(true);

    // Verify the set operation was recorded
    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    expect(setOp).toBeDefined();

    const data = setOp!.data as Record<string, unknown>;
    expect(data.identityKey).toBe("identity_key_base64");
    expect(data.signedPreKey).toBe("signed_pre_key_base64");
    expect(data.signedPreKeySignature).toBe("signature_base64");
    expect(data.oneTimePreKeys).toEqual(["otk_1", "otk_2", "otk_3"]);
  });

  it("stores registrationId", async () => {
    await uploadKeyBundle(validKeyBundle, authContext);

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    expect(setOp).toBeDefined();

    const data = setOp!.data as Record<string, unknown>;
    expect(data.registrationId).toBe(12345);
  });

  it("stores userId in the document", async () => {
    await uploadKeyBundle(validKeyBundle, authContext);

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.userId).toBe("user_001");
  });

  it("overwrites an existing key bundle", async () => {
    // Upload first bundle
    await uploadKeyBundle(validKeyBundle, authContext);

    // Upload second bundle with different keys
    const updatedBundle = {
      ...validKeyBundle,
      identityKey: "new_identity_key",
    };
    const result = await uploadKeyBundle(updatedBundle, authContext);

    expect(result.success).toBe(true);

    // Should have two set operations (both overwrites)
    const setOps = mockOperations.sets.filter(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    expect(setOps.length).toBe(2);
  });

  it("validates identityKey is required", async () => {
    const invalidBundle = { ...validKeyBundle, identityKey: "" };
    await expect(
      uploadKeyBundle(invalidBundle, authContext)
    ).rejects.toThrow("identityKey, signedPreKey, and signedPreKeySignature are required.");
  });

  it("validates signedPreKey is required", async () => {
    const invalidBundle = { ...validKeyBundle, signedPreKey: "" };
    await expect(
      uploadKeyBundle(invalidBundle, authContext)
    ).rejects.toThrow("identityKey, signedPreKey, and signedPreKeySignature are required.");
  });

  it("validates signedPreKeySignature is required", async () => {
    const invalidBundle = { ...validKeyBundle, signedPreKeySignature: "" };
    await expect(
      uploadKeyBundle(invalidBundle, authContext)
    ).rejects.toThrow("identityKey, signedPreKey, and signedPreKeySignature are required.");
  });

  it("defaults oneTimePreKeys to empty array when not provided", async () => {
    const bundleWithoutOTKs = {
      identityKey: "identity_key_base64",
      signedPreKey: "signed_pre_key_base64",
      signedPreKeySignature: "signature_base64",
      oneTimePreKeys: undefined as unknown as string[],
      registrationId: 12345,
    };

    await uploadKeyBundle(bundleWithoutOTKs as Record<string, unknown>, authContext);

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.oneTimePreKeys).toEqual([]);
  });

  it("defaults registrationId to 0 when not provided", async () => {
    const bundleWithoutRegId = {
      identityKey: "identity_key_base64",
      signedPreKey: "signed_pre_key_base64",
      signedPreKeySignature: "signature_base64",
      oneTimePreKeys: ["otk_1"],
      registrationId: undefined as unknown as number,
    };

    await uploadKeyBundle(bundleWithoutRegId as Record<string, unknown>, authContext);

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.registrationId).toBe(0);
  });

  it("sets updatedAt as server timestamp", async () => {
    await uploadKeyBundle(validKeyBundle, authContext);

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.updatedAt).toEqual({ _serverTimestamp: true });
  });

  it("calls requireAppCheck", async () => {
    await uploadKeyBundle(validKeyBundle, authContext);
    expect(mockRequireAppCheck).toHaveBeenCalledWith(expect.objectContaining(authContext), "uploadKeyBundle");
  });
});

// ============================================================================
// fetchKeyBundle
// ============================================================================

describe("fetchKeyBundle", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      fetchKeyBundle({ targetUserId: "user_002" }, unauthContext)
    ).rejects.toThrow("Authentication required.");
  });

  it("requires targetUserId", async () => {
    await expect(
      fetchKeyBundle({ targetUserId: "" }, authContext)
    ).rejects.toThrow("targetUserId is required.");
  });

  it("returns public bundle for existing user", async () => {
    setupMockDocument("users/user_002/keys", "bundle", {
      userId: "user_002",
      identityKey: "target_identity_key",
      signedPreKey: "target_signed_pre_key",
      signedPreKeySignature: "target_signature",
      oneTimePreKeys: ["otk_a", "otk_b"],
      registrationId: 67890,
    });

    const result = await fetchKeyBundle({ targetUserId: "user_002" }, authContext);

    expect(result.identityKey).toBe("target_identity_key");
    expect(result.signedPreKey).toBe("target_signed_pre_key");
    expect(result.signedPreKeySignature).toBe("target_signature");
    expect(result.userId).toBe("user_002");
    expect(result.registrationId).toBe(67890);
  });

  it("atomically consumes one one-time pre-key (FIFO)", async () => {
    setupMockDocument("users/user_002/keys", "bundle", {
      userId: "user_002",
      identityKey: "target_identity_key",
      signedPreKey: "target_signed_pre_key",
      signedPreKeySignature: "target_signature",
      oneTimePreKeys: [
        { id: 1, key: "otk_first" },
        { id: 2, key: "otk_second" },
      ],
      registrationId: 100,
    });

    const result = await fetchKeyBundle({ targetUserId: "user_002" }, authContext);

    // Should return the first OTK's key
    expect(result.oneTimePreKey).toBe("otk_first");
    expect(result.oneTimePreKeyId).toBe(1);

    // Should have called update to remove the consumed OTK via arrayRemove
    const updateOp = mockOperations.updates.find(
      (op) => op.collection === "users/user_002/keys" && op.doc === "bundle"
    );
    expect(updateOp).toBeDefined();
    const updateData = updateOp!.data as Record<string, unknown>;
    expect(updateData.oneTimePreKeys).toEqual({
      _arrayRemove: [{ id: 1, key: "otk_first" }],
    });
  });

  it("returns null oneTimePreKey when no OTKs available", async () => {
    setupMockDocument("users/user_002/keys", "bundle", {
      userId: "user_002",
      identityKey: "target_identity_key",
      signedPreKey: "target_signed_pre_key",
      signedPreKeySignature: "target_signature",
      oneTimePreKeys: [],
      registrationId: 100,
    });

    const result = await fetchKeyBundle({ targetUserId: "user_002" }, authContext);

    expect(result.oneTimePreKey).toBeNull();
    // Should NOT have called update since there are no OTKs to remove
    const updateOp = mockOperations.updates.find(
      (op) => op.collection === "users/user_002/keys" && op.doc === "bundle"
    );
    expect(updateOp).toBeUndefined();
  });

  it("throws not-found when user has no key bundle", async () => {
    // No bundle set up for user_002
    await expect(
      fetchKeyBundle({ targetUserId: "user_002" }, authContext)
    ).rejects.toThrow("Key bundle not found for user.");
  });

  it("defaults registrationId to 0 when not in bundle", async () => {
    setupMockDocument("users/user_002/keys", "bundle", {
      userId: "user_002",
      identityKey: "target_identity_key",
      signedPreKey: "target_signed_pre_key",
      signedPreKeySignature: "target_signature",
      oneTimePreKeys: [],
    });

    const result = await fetchKeyBundle({ targetUserId: "user_002" }, authContext);
    expect(result.registrationId).toBe(0);
  });

  it("calls requireAppCheck", async () => {
    setupMockDocument("users/user_002/keys", "bundle", {
      userId: "user_002",
      identityKey: "k",
      signedPreKey: "k",
      signedPreKeySignature: "k",
      oneTimePreKeys: [],
    });

    await fetchKeyBundle({ targetUserId: "user_002" }, authContext);
    expect(mockRequireAppCheck).toHaveBeenCalledWith(expect.objectContaining(authContext), "fetchKeyBundle");
  });
});

// ============================================================================
// replenishOneTimePreKeys
// ============================================================================

describe("replenishOneTimePreKeys", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      replenishOneTimePreKeys({ newPreKeys: ["otk_new"] }, unauthContext)
    ).rejects.toThrow("Authentication required.");
  });

  it("rejects empty newPreKeys array", async () => {
    await expect(
      replenishOneTimePreKeys({ newPreKeys: [] }, authContext)
    ).rejects.toThrow("newPreKeys array is required.");
  });

  it("rejects missing newPreKeys field", async () => {
    await expect(
      replenishOneTimePreKeys({} as Record<string, unknown>, authContext)
    ).rejects.toThrow("newPreKeys array is required.");
  });

  it("adds new pre-keys via arrayUnion", async () => {
    const newKeys = ["otk_new_1", "otk_new_2", "otk_new_3"];
    const result = await replenishOneTimePreKeys({ newPreKeys: newKeys }, authContext);

    expect(result.success).toBe(true);
    expect(result.addedCount).toBe(3);

    const updateOp = mockOperations.updates.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    expect(updateOp).toBeDefined();

    const data = updateOp!.data as Record<string, unknown>;
    expect(data.oneTimePreKeys).toEqual({
      _arrayUnion: ["otk_new_1", "otk_new_2", "otk_new_3"],
    });
    expect(data.updatedAt).toEqual({ _serverTimestamp: true });
  });

  it("calls requireAppCheck", async () => {
    await replenishOneTimePreKeys({ newPreKeys: ["otk"] }, authContext);
    expect(mockRequireAppCheck).toHaveBeenCalledWith(expect.objectContaining(authContext), "replenishOneTimePreKeys");
  });
});

// ============================================================================
// rotateSignedPreKey
// ============================================================================

describe("rotateSignedPreKey", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      rotateSignedPreKey(
        { newSignedPreKey: "new_spk", newSignedPreKeySignature: "new_sig" },
        unauthContext
      )
    ).rejects.toThrow("Authentication required.");
  });

  it("validates newSignedPreKey is required", async () => {
    await expect(
      rotateSignedPreKey(
        { newSignedPreKey: "", newSignedPreKeySignature: "sig" },
        authContext
      )
    ).rejects.toThrow("newSignedPreKey and newSignedPreKeySignature are required.");
  });

  it("validates newSignedPreKeySignature is required", async () => {
    await expect(
      rotateSignedPreKey(
        { newSignedPreKey: "spk", newSignedPreKeySignature: "" },
        authContext
      )
    ).rejects.toThrow("newSignedPreKey and newSignedPreKeySignature are required.");
  });

  it("updates the signed pre-key in Firestore", async () => {
    const result = await rotateSignedPreKey(
      { newSignedPreKey: "rotated_spk", newSignedPreKeySignature: "rotated_sig" },
      authContext
    );

    expect(result.success).toBe(true);

    const updateOp = mockOperations.updates.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "bundle"
    );
    expect(updateOp).toBeDefined();

    const data = updateOp!.data as Record<string, unknown>;
    expect(data.signedPreKey).toBe("rotated_spk");
    expect(data.signedPreKeySignature).toBe("rotated_sig");
    expect(data.updatedAt).toEqual({ _serverTimestamp: true });
  });

  it("calls requireAppCheck", async () => {
    await rotateSignedPreKey(
      { newSignedPreKey: "spk", newSignedPreKeySignature: "sig" },
      authContext
    );
    expect(mockRequireAppCheck).toHaveBeenCalledWith(expect.objectContaining(authContext), "rotateSignedPreKey");
  });
});

// ============================================================================
// saveKeyBackup
// ============================================================================

describe("saveKeyBackup", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      saveKeyBackup({ backupVersion: 1, encryptedBlob: "encrypted_data" }, unauthContext)
    ).rejects.toThrow("Authentication required.");
  });

  it("stores backup data in Firestore", async () => {
    const result = await saveKeyBackup(
      { backupVersion: 2, encryptedBlob: "encrypted_blob_data" },
      authContext
    );

    expect(result.success).toBe(true);

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "backup"
    );
    expect(setOp).toBeDefined();

    const data = setOp!.data as Record<string, unknown>;
    expect(data.userId).toBe("user_001");
    expect(data.backupExists).toBe(true);
    expect(data.backupVersion).toBe(2);
    expect(data.encryptedBlob).toBe("encrypted_blob_data");
    expect(data.lastBackupAt).toEqual({ _serverTimestamp: true });
    expect(data.updatedAt).toEqual({ _serverTimestamp: true });
  });

  it("defaults backupVersion to 1 when not provided", async () => {
    await saveKeyBackup(
      { backupVersion: undefined as unknown as number, encryptedBlob: "blob" },
      authContext
    );

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "users/user_001/keys" && op.doc === "backup"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.backupVersion).toBe(1);
  });

  it("rejects missing encryptedBlob", async () => {
    await expect(
      saveKeyBackup(
        { backupVersion: 1, encryptedBlob: "" },
        authContext
      )
    ).rejects.toThrow("encryptedBlob required");
  });

  it("rejects oversized encryptedBlob", async () => {
    const hugeBlob = "x".repeat(50001);
    await expect(
      saveKeyBackup(
        { backupVersion: 1, encryptedBlob: hugeBlob },
        authContext
      )
    ).rejects.toThrow("Backup too large");
  });

  it("calls requireAppCheck", async () => {
    await saveKeyBackup(
      { backupVersion: 1, encryptedBlob: "blob" },
      authContext
    );
    expect(mockRequireAppCheck).toHaveBeenCalledWith(expect.objectContaining(authContext), "saveKeyBackup");
  });
});

// ============================================================================
// getKeyBackup
// ============================================================================

describe("getKeyBackup", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      getKeyBackup({}, unauthContext)
    ).rejects.toThrow("Authentication required.");
  });

  it("returns backup data when backup exists", async () => {
    setupMockDocument("users/user_001/keys", "backup", {
      userId: "user_001",
      backupExists: true,
      encryptedBlob: "encrypted_data_here",
      backupVersion: 3,
      lastBackupAt: { toDate: () => new Date("2026-01-15T10:00:00Z") },
    });

    const result = await getKeyBackup({}, authContext);

    expect(result.backupExists).toBe(true);
    expect(result.encryptedBlob).toBe("encrypted_data_here");
    expect(result.backupVersion).toBe(3);
  });

  it("returns backupExists=false when no backup document exists", async () => {
    // No backup document set up
    const result = await getKeyBackup({}, authContext);

    expect(result.backupExists).toBe(false);
  });

  it("returns backupExists=false when encryptedBlob is missing", async () => {
    setupMockDocument("users/user_001/keys", "backup", {
      userId: "user_001",
      backupExists: true,
      backupVersion: 1,
    });

    const result = await getKeyBackup({}, authContext);
    expect(result.backupExists).toBe(false);
  });

  it("calls requireAppCheck", async () => {
    await getKeyBackup({}, authContext);
    expect(mockRequireAppCheck).toHaveBeenCalledWith(expect.objectContaining(authContext), "getKeyBackup");
  });
});

// ============================================================================
// distributeSenderKey
// ============================================================================

describe("distributeSenderKey", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      distributeSenderKey(
        {
          communityId: "comm_001",
          recipientUserId: "user_002",
          encryptedKeyData: "encrypted_data",
          e2ee: {},
        },
        unauthContext
      )
    ).rejects.toThrow("Authentication required.");
  });

  it("validates communityId is required", async () => {
    await expect(
      distributeSenderKey(
        {
          communityId: "",
          recipientUserId: "user_002",
          encryptedKeyData: "encrypted_data",
          e2ee: {},
        },
        authContext
      )
    ).rejects.toThrow("communityId, recipientUserId, and encryptedKeyData are required.");
  });

  it("validates recipientUserId is required", async () => {
    await expect(
      distributeSenderKey(
        {
          communityId: "comm_001",
          recipientUserId: "",
          encryptedKeyData: "encrypted_data",
          e2ee: {},
        },
        authContext
      )
    ).rejects.toThrow("communityId, recipientUserId, and encryptedKeyData are required.");
  });

  it("validates encryptedKeyData is required", async () => {
    await expect(
      distributeSenderKey(
        {
          communityId: "comm_001",
          recipientUserId: "user_002",
          encryptedKeyData: "",
          e2ee: {},
        },
        authContext
      )
    ).rejects.toThrow("communityId, recipientUserId, and encryptedKeyData are required.");
  });

  it("creates a keyDistribution doc in Firestore", async () => {
    const result = await distributeSenderKey(
      {
        communityId: "comm_001",
        recipientUserId: "user_002",
        encryptedKeyData: "encrypted_sender_key_data",
        e2ee: { protocol: "senderKey", version: 1 },
        x3dhHeader: { ephemeralKey: "ek_123" },
      },
      authContext
    );

    expect(result.success).toBe(true);

    // The function uses .add() which is tracked in sets
    const setOp = mockOperations.sets.find(
      (op) => op.collection === "communities/comm_001/keyDistribution"
    );
    expect(setOp).toBeDefined();

    const data = setOp!.data as Record<string, unknown>;
    expect(data.fromUserId).toBe("user_001");
    expect(data.toUserId).toBe("user_002");
    expect(data.encryptedKeyData).toBe("encrypted_sender_key_data");
    expect(data.consumed).toBe(false);
    expect(data.createdAt).toEqual({ _serverTimestamp: true });
  });

  it("stores e2ee metadata", async () => {
    const e2eeData = { protocol: "senderKey", version: 1, chainId: "chain_abc" };

    await distributeSenderKey(
      {
        communityId: "comm_001",
        recipientUserId: "user_002",
        encryptedKeyData: "data",
        e2ee: e2eeData,
      },
      authContext
    );

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "communities/comm_001/keyDistribution"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.e2ee).toEqual(e2eeData);
  });

  it("stores x3dhHeader when provided", async () => {
    const header = { ephemeralKey: "ek", identityKey: "ik" };

    await distributeSenderKey(
      {
        communityId: "comm_001",
        recipientUserId: "user_002",
        encryptedKeyData: "data",
        e2ee: {},
        x3dhHeader: header,
      },
      authContext
    );

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "communities/comm_001/keyDistribution"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.x3dhHeader).toEqual(header);
  });

  it("sets consumed=false on creation", async () => {
    await distributeSenderKey(
      {
        communityId: "comm_001",
        recipientUserId: "user_002",
        encryptedKeyData: "data",
        e2ee: {},
      },
      authContext
    );

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "communities/comm_001/keyDistribution"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.consumed).toBe(false);
  });

  it("sets e2ee to null when not provided", async () => {
    await distributeSenderKey(
      {
        communityId: "comm_001",
        recipientUserId: "user_002",
        encryptedKeyData: "data",
        e2ee: undefined as unknown as Record<string, unknown>,
      },
      authContext
    );

    const setOp = mockOperations.sets.find(
      (op) => op.collection === "communities/comm_001/keyDistribution"
    );
    const data = setOp!.data as Record<string, unknown>;
    expect(data.e2ee).toBeNull();
  });

  it("calls requireAppCheck", async () => {
    await distributeSenderKey(
      {
        communityId: "comm_001",
        recipientUserId: "user_002",
        encryptedKeyData: "data",
        e2ee: {},
      },
      authContext
    );
    expect(mockRequireAppCheck).toHaveBeenCalledWith(expect.objectContaining(authContext), "distributeSenderKey");
  });
});

// ============================================================================
// markKeyDistributionConsumed
// ============================================================================

describe("markKeyDistributionConsumed", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    resetMocks();
  });

  it("requires authentication", async () => {
    await expect(
      markKeyDistributionConsumed(
        { communityId: "comm_001", distributionId: "dist_001" },
        unauthContext
      )
    ).rejects.toThrow("Authentication required.");
  });

  it("validates communityId is required", async () => {
    await expect(
      markKeyDistributionConsumed(
        { communityId: "", distributionId: "dist_001" },
        authContext
      )
    ).rejects.toThrow("communityId and distributionId are required.");
  });

  it("validates distributionId is required", async () => {
    await expect(
      markKeyDistributionConsumed(
        { communityId: "comm_001", distributionId: "" },
        authContext
      )
    ).rejects.toThrow("communityId and distributionId are required.");
  });

  it("sets consumed=true and consumedAt", async () => {
    setupMockDocument("communities/comm_001/keyDistribution", "dist_001", {
      fromUserId: "user_002",
      toUserId: "user_001",
      encryptedKeyData: "data",
      consumed: false,
    });

    const result = await markKeyDistributionConsumed(
      { communityId: "comm_001", distributionId: "dist_001" },
      authContext
    );

    expect(result.success).toBe(true);

    const updateOp = mockOperations.updates.find(
      (op) =>
        op.collection === "communities/comm_001/keyDistribution" &&
        op.doc === "dist_001"
    );
    expect(updateOp).toBeDefined();

    const data = updateOp!.data as Record<string, unknown>;
    expect(data.consumed).toBe(true);
    expect(data.consumedAt).toEqual({ _serverTimestamp: true });
  });

  it("only the recipient can consume the distribution", async () => {
    setupMockDocument("communities/comm_001/keyDistribution", "dist_001", {
      fromUserId: "user_001",
      toUserId: "user_002",
      encryptedKeyData: "data",
      consumed: false,
    });

    // user_001 is not the recipient (toUserId is user_002)
    await expect(
      markKeyDistributionConsumed(
        { communityId: "comm_001", distributionId: "dist_001" },
        authContext
      )
    ).rejects.toThrow("Not your key distribution.");
  });

  it("throws not-found when distribution does not exist", async () => {
    await expect(
      markKeyDistributionConsumed(
        { communityId: "comm_001", distributionId: "nonexistent" },
        authContext
      )
    ).rejects.toThrow("Distribution not found.");
  });

  it("allows recipient to consume their own distribution", async () => {
    // user_002 is the recipient
    setupMockDocument("communities/comm_001/keyDistribution", "dist_001", {
      fromUserId: "user_001",
      toUserId: "user_002",
      encryptedKeyData: "data",
      consumed: false,
    });

    const result = await markKeyDistributionConsumed(
      { communityId: "comm_001", distributionId: "dist_001" },
      otherAuthContext // user_002
    );

    expect(result.success).toBe(true);
  });

  it("calls requireAppCheck", async () => {
    setupMockDocument("communities/comm_001/keyDistribution", "dist_001", {
      fromUserId: "user_002",
      toUserId: "user_001",
      encryptedKeyData: "data",
      consumed: false,
    });

    await markKeyDistributionConsumed(
      { communityId: "comm_001", distributionId: "dist_001" },
      authContext
    );
    expect(mockRequireAppCheck).toHaveBeenCalledWith(
      expect.objectContaining(authContext),
      "markKeyDistributionConsumed"
    );
  });
});
