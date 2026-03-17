/**
 * Biometric Authentication Cloud Functions
 *
 * Two-step challenge-response flow for biometric login on trusted devices:
 * 1. requestBiometricChallenge — generates a nonce for the device to sign
 * 2. verifyBiometricChallenge — verifies the ECDSA signature and issues a custom token
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import * as crypto from "crypto";
import { checkRateLimit, requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Request a biometric login challenge.
 *
 * The client calls this with its deviceId. The server verifies the device
 * is trusted, generates a random nonce, stores it in Firestore with a
 * short TTL, and returns it to the client for signing.
 *
 * @param {string} deviceId - The registered device ID
 * @returns {{ challengeId: string, nonce: string }}
 */
export const requestBiometricChallenge = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data;
    await requireAppCheck(request, "requestBiometricChallenge");

    const { deviceId } = data;

    if (!deviceId || typeof deviceId !== "string") {
      throw new HttpsError(
        "invalid-argument",
        "deviceId is required."
      );
    }

    // Rate limit: max 5 challenge requests per device per 5 minutes
    const rateLimitResult = await checkRateLimit(
      deviceId,
      "biometric_challenge"
    );
    if (!rateLimitResult.allowed) {
      throw new HttpsError(
        "resource-exhausted",
        rateLimitResult.message || "Too many attempts. Try again later."
      );
    }

    // Verify device exists, is trusted, and not revoked
    const deviceDoc = await db.collection("devices").doc(deviceId).get();
    if (!deviceDoc.exists) {
      throw new HttpsError("not-found", "Device not found.");
    }

    const deviceData = deviceDoc.data()!;
    if (!deviceData.trusted || deviceData.revoked) {
      throw new HttpsError(
        "permission-denied",
        "Device is not trusted."
      );
    }

    if (!deviceData.userId) {
      throw new HttpsError(
        "failed-precondition",
        "Device has no associated user."
      );
    }

    // Generate a cryptographically random nonce (32 bytes, base64-encoded)
    const nonce = crypto.randomBytes(32).toString("base64");
    const now = admin.firestore.FieldValue.serverTimestamp();
    const expiresAt = new Date(Date.now() + 60 * 1000); // 60 seconds

    // Store challenge in Firestore
    const challengeRef = db.collection("biometricChallenges").doc();
    await challengeRef.set({
      deviceId,
      userId: deviceData.userId,
      nonce,
      status: "pending",
      createdAt: now,
      expiresAt,
    });

    logger.info(
      `Biometric challenge ${challengeRef.id} created for device ${deviceId}`
    );

    return {
      challengeId: challengeRef.id,
      nonce,
    };
  }
);

/**
 * Verify a biometric login challenge.
 *
 * The client signs the nonce with its hardware-backed private key (after
 * the user authenticates with biometrics/PIN) and submits the signature.
 * The server verifies it against the device's stored public key and
 * issues a Firebase custom auth token.
 *
 * @param {string} challengeId - The challenge document ID
 * @param {string} signedNonce - Base64-encoded ECDSA signature of the nonce
 * @param {string} deviceId - The registered device ID
 * @returns {{ customToken: string, userId: string }}
 */
export const verifyBiometricChallenge = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    const data = request.data;
    await requireAppCheck(request, "verifyBiometricChallenge");

    const { challengeId, signedNonce, deviceId } = data;

    if (!challengeId || !signedNonce || !deviceId) {
      throw new HttpsError(
        "invalid-argument",
        "challengeId, signedNonce, and deviceId are required."
      );
    }

    // Rate limit: max 5 verification attempts per device per 5 minutes
    const rateLimitResult = await checkRateLimit(
      deviceId,
      "biometric_verify"
    );
    if (!rateLimitResult.allowed) {
      throw new HttpsError(
        "resource-exhausted",
        rateLimitResult.message || "Too many attempts. Try again later."
      );
    }

    // Get the challenge document
    const challengeRef = db
      .collection("biometricChallenges")
      .doc(challengeId);
    const challengeDoc = await challengeRef.get();

    if (!challengeDoc.exists) {
      throw new HttpsError(
        "not-found",
        "Challenge not found."
      );
    }

    const challengeData = challengeDoc.data()!;

    // Verify challenge belongs to this device
    if (challengeData.deviceId !== deviceId) {
      throw new HttpsError(
        "permission-denied",
        "Challenge does not belong to this device."
      );
    }

    // Check challenge status
    if (challengeData.status !== "pending") {
      throw new HttpsError(
        "failed-precondition",
        `Challenge is ${challengeData.status}, not pending.`
      );
    }

    // Check expiry
    const expiresAt = challengeData.expiresAt?.toDate();
    if (!expiresAt || Date.now() > expiresAt.getTime()) {
      await challengeRef.update({ status: "expired" });
      throw new HttpsError(
        "deadline-exceeded",
        "Challenge has expired."
      );
    }

    // Get device and verify it's still trusted
    const deviceDoc = await db.collection("devices").doc(deviceId).get();
    if (!deviceDoc.exists) {
      throw new HttpsError("not-found", "Device not found.");
    }

    const deviceData = deviceDoc.data()!;
    if (!deviceData.trusted || deviceData.revoked) {
      throw new HttpsError(
        "permission-denied",
        "Device is not trusted."
      );
    }

    if (deviceData.userId !== challengeData.userId) {
      throw new HttpsError(
        "permission-denied",
        "Device user mismatch."
      );
    }

    // Verify ECDSA signature
    const publicKeyPem = deviceData.publicKeyPem;
    try {
      const verifier = crypto.createVerify("SHA256");
      // The client's native keystore base64-decodes the nonce to raw bytes
      // before signing, so we must verify against the same raw bytes.
      const nonceBytes = Buffer.from(challengeData.nonce, "base64");
      verifier.update(nonceBytes);
      verifier.end();

      const signatureBuffer = Buffer.from(signedNonce, "base64");
      const isValid = verifier.verify(publicKeyPem, signatureBuffer);

      if (!isValid) {
        await challengeRef.update({
          status: "failed",
          respondedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        throw new HttpsError(
          "permission-denied",
          "Invalid signature."
        );
      }
    } catch (error: unknown) {
      const err = error as { code?: string; message?: string };
      if (err.code) {
        throw error; // Re-throw HttpsError
      }
      logger.error("Signature verification error:", error);
      throw new HttpsError(
        "internal",
        "Signature verification failed."
      );
    }

    // Signature valid — generate custom token
    const customToken = await admin
      .auth()
      .createCustomToken(challengeData.userId);

    // Mark challenge as completed
    await challengeRef.update({
      status: "completed",
      respondedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update device last used
    await db.collection("devices").doc(deviceId).update({
      lastUsedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Stamp lastLoginAt (fire-and-forget — non-blocking)
    db.collection("users").doc(challengeData.userId).set(
      { lastLoginAt: admin.firestore.FieldValue.serverTimestamp() },
      { merge: true }
    ).catch((err: unknown) => logger.warn("Failed to stamp lastLoginAt:", err));

    logger.info(
      `Biometric challenge ${challengeId} verified for device ${deviceId}, user ${challengeData.userId}`
    );

    return {
      customToken,
      userId: challengeData.userId,
    };
  }
);
