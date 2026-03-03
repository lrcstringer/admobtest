/**
 * Key Management Cloud Functions
 *
 * Manages public key bundles for E2EE messaging.
 * Users upload their public key bundles (identity key, signed pre-key, one-time pre-keys).
 * Other users fetch bundles to establish encrypted sessions.
 *
 * Collections:
 *   users/{userId}/keys/bundle — public key bundle
 *   users/{userId}/keys/backup — encrypted backup metadata
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import { requireCommunityMember } from "./helpers/communityHelpers";

const db = admin.firestore();

function requireAuth(context: { auth?: { uid: string; token: Record<string, unknown> } }): string {
  if (!context.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Authentication required."
    );
  }
  return context.auth.uid;
}

/**
 * Upload or update the user's public key bundle.
 */
export const uploadKeyBundle = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as {
      identityKey: string;
      signedPreKey: string;
      signedPreKeySignature: string;
      oneTimePreKeys: Array<{ id: number; key: string }>;
      registrationId: number;
      ed25519IdentityKey?: string;
      ed25519Signature?: string;
      // v2 fields
      signedPreKeyId?: number;
      protocolVersion?: number;
      previousSignedPreKey?: string;
      previousSignedPreKeyId?: number;
      previousSignedPreKeySignature?: string;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "uploadKeyBundle");

    const {
      identityKey, signedPreKey, signedPreKeySignature,
      oneTimePreKeys, registrationId,
      ed25519IdentityKey, ed25519Signature,
      signedPreKeyId, protocolVersion,
      previousSignedPreKey, previousSignedPreKeyId,
      previousSignedPreKeySignature,
    } = data;

    if (!identityKey || !signedPreKey || !signedPreKeySignature) {
      throw new HttpsError(
        "invalid-argument",
        "identityKey, signedPreKey, and signedPreKeySignature are required."
      );
    }

    const bundleData: Record<string, unknown> = {
      userId,
      identityKey,
      signedPreKey,
      signedPreKeySignature,
      oneTimePreKeys: oneTimePreKeys || [],
      registrationId: registrationId || 0,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    // Store Ed25519 fields if provided (new clients)
    if (ed25519IdentityKey) {
      bundleData.ed25519IdentityKey = ed25519IdentityKey;
    }
    if (ed25519Signature) {
      bundleData.ed25519Signature = ed25519Signature;
    }

    // Store v2 protocol fields if provided
    if (signedPreKeyId != null) {
      bundleData.signedPreKeyId = signedPreKeyId;
    }
    if (protocolVersion != null) {
      bundleData.protocolVersion = protocolVersion;
    }
    if (previousSignedPreKey) {
      bundleData.previousSignedPreKey = previousSignedPreKey;
      bundleData.previousSignedPreKeyId = previousSignedPreKeyId;
      bundleData.previousSignedPreKeySignature = previousSignedPreKeySignature;
    }

    const batch = db.batch();

    batch.set(
      db.collection("users").doc(userId).collection("keys").doc("bundle"),
      bundleData
    );

    // Store identity key on user profile so peers can detect key changes
    // without fetching the full key bundle (which consumes an OTK).
    batch.update(
      db.collection("users").doc(userId),
      { e2eeIdentityKey: identityKey }
    );

    await batch.commit();

    return { success: true };
  }
);

/**
 * Fetch another user's public key bundle (consuming one one-time pre-key).
 */
export const fetchKeyBundle = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as { targetUserId: string };
    requireAuth(request);
    requireAppCheck(request, "fetchKeyBundle");

    const { targetUserId } = data;
    if (!targetUserId) {
      throw new HttpsError(
        "invalid-argument",
        "targetUserId is required."
      );
    }

    const bundleRef = db
      .collection("users")
      .doc(targetUserId)
      .collection("keys")
      .doc("bundle");

    // Use a transaction to atomically read + consume one OTK.
    // Without this, two concurrent fetchKeyBundle calls could consume
    // the same OTK, causing permanent decryption failure for one sender.
    const result = await db.runTransaction(async (txn) => {
      const bundleDoc = await txn.get(bundleRef);
      if (!bundleDoc.exists) {
        throw new HttpsError(
          "not-found",
          "Key bundle not found for user."
        );
      }

      const bundle = bundleDoc.data()!;
      const oneTimePreKeys: Array<{ id: number; key: string }> =
        bundle.oneTimePreKeys || [];

      // Consume one one-time pre-key (FIFO).
      let consumedPreKey: string | null = null;
      let consumedPreKeyId: number | null = null;
      if (oneTimePreKeys.length > 0) {
        const first = oneTimePreKeys[0];
        consumedPreKey = first.key;
        consumedPreKeyId = first.id;
        txn.update(bundleRef, {
          oneTimePreKeys: admin.firestore.FieldValue.arrayRemove(first),
        });
      }

      return {
        userId: targetUserId,
        identityKey: bundle.identityKey,
        signedPreKey: bundle.signedPreKey,
        signedPreKeySignature: bundle.signedPreKeySignature,
        oneTimePreKey: consumedPreKey,
        oneTimePreKeyId: consumedPreKeyId,
        oneTimePreKeyCount: oneTimePreKeys.length - (consumedPreKey ? 1 : 0),
        registrationId: bundle.registrationId || 0,
        ed25519IdentityKey: bundle.ed25519IdentityKey || null,
        ed25519Signature: bundle.ed25519Signature || null,
        updatedAt: bundle.updatedAt?.toDate?.()?.toISOString?.() || null,
        // v2 fields
        signedPreKeyId: bundle.signedPreKeyId ?? null,
        protocolVersion: bundle.protocolVersion ?? 2,
        previousSignedPreKey: bundle.previousSignedPreKey ?? null,
        previousSignedPreKeyId: bundle.previousSignedPreKeyId ?? null,
        previousSignedPreKeySignature: bundle.previousSignedPreKeySignature ?? null,
      };
    });

    return result;
  }
);

/**
 * Replenish one-time pre-keys when count gets low.
 */
export const replenishOneTimePreKeys = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as {
      newPreKeys: Array<{ id: number; key: string }>;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "replenishOneTimePreKeys");

    const { newPreKeys } = data;
    if (!newPreKeys || !Array.isArray(newPreKeys) || newPreKeys.length === 0) {
      throw new HttpsError(
        "invalid-argument",
        "newPreKeys array is required."
      );
    }

    await db
      .collection("users")
      .doc(userId)
      .collection("keys")
      .doc("bundle")
      .update({
        oneTimePreKeys: admin.firestore.FieldValue.arrayUnion(...newPreKeys),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    return { success: true, addedCount: newPreKeys.length };
  }
);

/**
 * Rotate the signed pre-key.
 */
export const rotateSignedPreKey = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as {
      newSignedPreKey: string;
      newSignedPreKeySignature: string;
      newEd25519Signature?: string;
      // v2 fields
      signedPreKeyId?: number;
      previousSignedPreKey?: string;
      previousSignedPreKeyId?: number;
      previousSignedPreKeySignature?: string;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "rotateSignedPreKey");

    const {
      newSignedPreKey, newSignedPreKeySignature, newEd25519Signature,
      signedPreKeyId, previousSignedPreKey,
      previousSignedPreKeyId, previousSignedPreKeySignature,
    } = data;
    if (!newSignedPreKey || !newSignedPreKeySignature) {
      throw new HttpsError(
        "invalid-argument",
        "newSignedPreKey and newSignedPreKeySignature are required."
      );
    }

    const updateData: Record<string, unknown> = {
      signedPreKey: newSignedPreKey,
      signedPreKeySignature: newSignedPreKeySignature,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    if (newEd25519Signature) {
      updateData.ed25519Signature = newEd25519Signature;
    }

    // v2: store SPK ID and previous SPK grace-period fields
    if (signedPreKeyId != null) {
      updateData.signedPreKeyId = signedPreKeyId;
    }
    if (previousSignedPreKey) {
      updateData.previousSignedPreKey = previousSignedPreKey;
      updateData.previousSignedPreKeyId = previousSignedPreKeyId ?? null;
      updateData.previousSignedPreKeySignature =
        previousSignedPreKeySignature ?? null;
    } else {
      // Clear previous SPK fields if not provided (grace period expired)
      updateData.previousSignedPreKey =
        admin.firestore.FieldValue.delete();
      updateData.previousSignedPreKeyId =
        admin.firestore.FieldValue.delete();
      updateData.previousSignedPreKeySignature =
        admin.firestore.FieldValue.delete();
    }

    await db
      .collection("users")
      .doc(userId)
      .collection("keys")
      .doc("bundle")
      .update(updateData);

    return { success: true };
  }
);

/**
 * Save an encrypted key backup (blob + metadata).
 * Replaces old saveBackupMetadata — now stores the actual encrypted blob.
 */
export const saveKeyBackup = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as { backupVersion: number; encryptedBlob: string };
    const userId = requireAuth(request);
    requireAppCheck(request, "saveKeyBackup");

    const { backupVersion, encryptedBlob } = data;

    if (!encryptedBlob || typeof encryptedBlob !== "string") {
      throw new HttpsError("invalid-argument", "encryptedBlob required");
    }
    if (encryptedBlob.length > 50000) {
      throw new HttpsError("invalid-argument", "Backup too large");
    }

    await db.collection("users").doc(userId).collection("keys").doc("backup").set({
      userId,
      backupExists: true,
      backupVersion: backupVersion || 1,
      encryptedBlob,
      lastBackupAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);

/**
 * Get the encrypted key backup for the current user.
 * Returns the encrypted blob so the client can decrypt locally.
 */
export const getKeyBackup = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getKeyBackup");

    const doc = await db.collection("users").doc(userId).collection("keys").doc("backup").get();
    if (!doc.exists || !doc.data()?.encryptedBlob) {
      return { backupExists: false };
    }

    const backupData = doc.data()!;
    return {
      backupExists: true,
      encryptedBlob: backupData.encryptedBlob,
      backupVersion: backupData.backupVersion,
      lastBackupAt: backupData.lastBackupAt,
    };
  }
);

/**
 * Save the per-user backup secret (write-once).
 * This secret is used to derive the encryption key for the key backup.
 * Only allows creating, not overwriting — prevents an attacker from
 * replacing the secret to decrypt a future backup.
 */
export const saveBackupSecret = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as { secret: string };
    const userId = requireAuth(request);
    requireAppCheck(request, "saveBackupSecret");

    const { secret } = data;

    if (!secret || typeof secret !== "string") {
      throw new HttpsError("invalid-argument", "secret required");
    }

    // M20: Use transaction to prevent TOCTOU race — two concurrent calls
    // could both pass the existence check and both call .set(), overwriting
    // the first secret.
    const secretRef = db.collection("users").doc(userId)
      .collection("keys").doc("backupSecret");
    await db.runTransaction(async (transaction) => {
      const existing = await transaction.get(secretRef);
      if (existing.exists) {
        throw new HttpsError("already-exists", "Backup secret already exists");
      }
      transaction.set(secretRef, {
        userId,
        secret,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return { success: true };
  }
);

/**
 * Get the per-user backup secret.
 * Used by the client to derive the key for decrypting the key backup.
 */
export const getBackupSecret = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getBackupSecret");

    const doc = await db.collection("users").doc(userId)
      .collection("keys").doc("backupSecret").get();
    if (!doc.exists) {
      return { secret: null };
    }

    return { secret: doc.data()!.secret };
  }
);

/**
 * Distribute a sender key to a community member via encrypted P2P channel.
 * The key data is pre-encrypted by the sender using Signal Protocol.
 */
export const distributeSenderKey = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as {
      communityId: string;
      recipientUserId: string;
      encryptedKeyData: string;
      e2ee: Record<string, unknown>;
      x3dhHeader?: Record<string, unknown>;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "distributeSenderKey");

    const { communityId, recipientUserId, encryptedKeyData, e2ee, x3dhHeader } = data;
    if (!communityId || !recipientUserId || !encryptedKeyData) {
      throw new HttpsError(
        "invalid-argument",
        "communityId, recipientUserId, and encryptedKeyData are required."
      );
    }

    // H5: Validate sender is an active community member
    await requireCommunityMember(communityId, userId);

    // H5: Validate payload size (prevent abuse)
    if (encryptedKeyData.length > 50000) {
      throw new HttpsError("invalid-argument", "Encrypted key data exceeds maximum size");
    }

    await db
      .collection("communities")
      .doc(communityId)
      .collection("keyDistribution")
      .add({
        fromUserId: userId,
        toUserId: recipientUserId,
        encryptedKeyData,
        e2ee: e2ee || null,
        x3dhHeader: x3dhHeader || null,
        consumed: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    return { success: true };
  }
);

/**
 * Mark a sender key distribution as consumed.
 */
export const markKeyDistributionConsumed = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as { communityId: string; distributionId: string };
    const userId = requireAuth(request);
    requireAppCheck(request, "markKeyDistributionConsumed");

    const { communityId, distributionId } = data;
    if (!communityId || !distributionId) {
      throw new HttpsError(
        "invalid-argument",
        "communityId and distributionId are required."
      );
    }

    const ref = db
      .collection("communities")
      .doc(communityId)
      .collection("keyDistribution")
      .doc(distributionId);

    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Distribution not found.");
    }

    const docData = doc.data()!;
    if (docData.toUserId !== userId) {
      throw new HttpsError("permission-denied", "Not your key distribution.");
    }

    await ref.update({
      consumed: true,
      consumedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);
