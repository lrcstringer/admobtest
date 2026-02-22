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
      oneTimePreKeys: string[];
      registrationId: number;
      ed25519IdentityKey?: string;
      ed25519Signature?: string;
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "uploadKeyBundle");

    const {
      identityKey, signedPreKey, signedPreKeySignature,
      oneTimePreKeys, registrationId,
      ed25519IdentityKey, ed25519Signature,
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

    const bundleDoc = await bundleRef.get();
    if (!bundleDoc.exists) {
      throw new HttpsError(
        "not-found",
        "Key bundle not found for user."
      );
    }

    const bundle = bundleDoc.data()!;
    const oneTimePreKeys: string[] = bundle.oneTimePreKeys || [];

    // Consume one one-time pre-key (FIFO)
    let consumedPreKey: string | null = null;
    if (oneTimePreKeys.length > 0) {
      consumedPreKey = oneTimePreKeys[0];
      await bundleRef.update({
        oneTimePreKeys: admin.firestore.FieldValue.arrayRemove(consumedPreKey),
      });
    }

    return {
      userId: targetUserId,
      identityKey: bundle.identityKey,
      signedPreKey: bundle.signedPreKey,
      signedPreKeySignature: bundle.signedPreKeySignature,
      oneTimePreKey: consumedPreKey,
      registrationId: bundle.registrationId || 0,
      // Ed25519 fields (null for legacy bundles without Ed25519 support)
      ed25519IdentityKey: bundle.ed25519IdentityKey || null,
      ed25519Signature: bundle.ed25519Signature || null,
    };
  }
);

/**
 * Replenish one-time pre-keys when count gets low.
 */
export const replenishOneTimePreKeys = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as { newPreKeys: string[] };
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
    };
    const userId = requireAuth(request);
    requireAppCheck(request, "rotateSignedPreKey");

    const { newSignedPreKey, newSignedPreKeySignature, newEd25519Signature } = data;
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
 * Save encrypted key backup metadata.
 */
export const saveBackupMetadata = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data as { backupVersion: number; encryptedKeysHash: string };
    const userId = requireAuth(request);
    requireAppCheck(request, "saveBackupMetadata");

    await db
      .collection("users")
      .doc(userId)
      .collection("keys")
      .doc("backup")
      .set({
        userId,
        backupExists: true,
        backupVersion: data.backupVersion || 1,
        encryptedKeysHash: data.encryptedKeysHash || null,
        lastBackupAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    return { success: true };
  }
);

/**
 * Get backup metadata for the current user.
 */
export const getBackupMetadata = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getBackupMetadata");

    const backupDoc = await db
      .collection("users")
      .doc(userId)
      .collection("keys")
      .doc("backup")
      .get();

    if (!backupDoc.exists) {
      return { backupExists: false };
    }

    const backup = backupDoc.data()!;
    return {
      backupExists: backup.backupExists || false,
      backupVersion: backup.backupVersion || 0,
      lastBackupAt: backup.lastBackupAt || null,
    };
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
