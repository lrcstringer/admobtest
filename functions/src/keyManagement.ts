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

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

function requireAuth(context: functions.https.CallableContext): string {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Authentication required."
    );
  }
  return context.auth.uid;
}

/**
 * Upload or update the user's public key bundle.
 */
export const uploadKeyBundle = functions.https.onCall(
  async (
    data: {
      identityKey: string;
      signedPreKey: string;
      signedPreKeySignature: string;
      oneTimePreKeys: string[];
      registrationId: number;
    },
    context
  ) => {
    const userId = requireAuth(context);
    requireAppCheck(context, "uploadKeyBundle");

    const { identityKey, signedPreKey, signedPreKeySignature, oneTimePreKeys, registrationId } = data;

    if (!identityKey || !signedPreKey || !signedPreKeySignature) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "identityKey, signedPreKey, and signedPreKeySignature are required."
      );
    }

    await db
      .collection("users")
      .doc(userId)
      .collection("keys")
      .doc("bundle")
      .set({
        userId,
        identityKey,
        signedPreKey,
        signedPreKeySignature,
        oneTimePreKeys: oneTimePreKeys || [],
        registrationId: registrationId || 0,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    return { success: true };
  }
);

/**
 * Fetch another user's public key bundle (consuming one one-time pre-key).
 */
export const fetchKeyBundle = functions.https.onCall(
  async (data: { targetUserId: string }, context) => {
    requireAuth(context);
    requireAppCheck(context, "fetchKeyBundle");

    const { targetUserId } = data;
    if (!targetUserId) {
      throw new functions.https.HttpsError(
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
      throw new functions.https.HttpsError(
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
    };
  }
);

/**
 * Replenish one-time pre-keys when count gets low.
 */
export const replenishOneTimePreKeys = functions.https.onCall(
  async (data: { newPreKeys: string[] }, context) => {
    const userId = requireAuth(context);
    requireAppCheck(context, "replenishOneTimePreKeys");

    const { newPreKeys } = data;
    if (!newPreKeys || !Array.isArray(newPreKeys) || newPreKeys.length === 0) {
      throw new functions.https.HttpsError(
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
export const rotateSignedPreKey = functions.https.onCall(
  async (
    data: { newSignedPreKey: string; newSignedPreKeySignature: string },
    context
  ) => {
    const userId = requireAuth(context);
    requireAppCheck(context, "rotateSignedPreKey");

    const { newSignedPreKey, newSignedPreKeySignature } = data;
    if (!newSignedPreKey || !newSignedPreKeySignature) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "newSignedPreKey and newSignedPreKeySignature are required."
      );
    }

    await db
      .collection("users")
      .doc(userId)
      .collection("keys")
      .doc("bundle")
      .update({
        signedPreKey: newSignedPreKey,
        signedPreKeySignature: newSignedPreKeySignature,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    return { success: true };
  }
);

/**
 * Save encrypted key backup metadata.
 */
export const saveBackupMetadata = functions.https.onCall(
  async (
    data: { backupVersion: number; encryptedKeysHash: string },
    context
  ) => {
    const userId = requireAuth(context);
    requireAppCheck(context, "saveBackupMetadata");

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
export const getBackupMetadata = functions.https.onCall(
  async (_data, context) => {
    const userId = requireAuth(context);
    requireAppCheck(context, "getBackupMetadata");

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
export const distributeSenderKey = functions.https.onCall(
  async (
    data: {
      communityId: string;
      recipientUserId: string;
      encryptedKeyData: string;
      e2ee: Record<string, unknown>;
      x3dhHeader?: Record<string, unknown>;
    },
    context
  ) => {
    const userId = requireAuth(context);
    requireAppCheck(context, "distributeSenderKey");

    const { communityId, recipientUserId, encryptedKeyData, e2ee, x3dhHeader } = data;
    if (!communityId || !recipientUserId || !encryptedKeyData) {
      throw new functions.https.HttpsError(
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
export const markKeyDistributionConsumed = functions.https.onCall(
  async (
    data: { communityId: string; distributionId: string },
    context
  ) => {
    const userId = requireAuth(context);
    requireAppCheck(context, "markKeyDistributionConsumed");

    const { communityId, distributionId } = data;
    if (!communityId || !distributionId) {
      throw new functions.https.HttpsError(
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
      throw new functions.https.HttpsError("not-found", "Distribution not found.");
    }

    const docData = doc.data()!;
    if (docData.toUserId !== userId) {
      throw new functions.https.HttpsError("permission-denied", "Not your key distribution.");
    }

    await ref.update({
      consumed: true,
      consumedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);
