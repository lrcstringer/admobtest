/**
 * Authentication Cloud Functions
 * Custom OTP verification using MyMobileAPI
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as crypto from "crypto";
import { checkRateLimit, requireAppCheck, validators } from "./security";

const db = admin.firestore();

// OTP Configuration
const OTP_CONFIG = {
  codeLength: 4,
  expiryMinutes: 5,
  maxAttempts: 5,
  resendCooldownSeconds: 60,
};

/**
 * Generate a random 4-digit OTP code (1000-9999)
 */
function generateOtp(): string {
  return Math.floor(1000 + Math.random() * 9000).toString();
}

/**
 * Generate a random salt for hashing
 */
function generateSalt(): string {
  return crypto.randomBytes(16).toString("hex");
}

/**
 * Hash the OTP code with salt using SHA-256
 */
function hashCode(code: string, salt: string): string {
  return crypto.createHash("sha256").update(code + salt).digest("hex");
}

/**
 * Normalize phone number to E.164 format (+27...)
 */
function normalizePhoneNumber(phone: string): string {
  // Remove spaces, dashes, parentheses
  let cleaned = phone.replace(/[\s\-()]/g, "");

  // Convert 0 prefix to +27
  if (cleaned.startsWith("0")) {
    cleaned = "+27" + cleaned.substring(1);
  }

  // Add + if missing for numbers starting with 27
  if (cleaned.startsWith("27") && !cleaned.startsWith("+")) {
    cleaned = "+" + cleaned;
  }

  return cleaned;
}

/**
 * Send SMS via MyMobileAPI
 */
async function sendSmsViaMyMobileApi(
  phoneNumber: string,
  message: string
): Promise<{ success: boolean; messageId?: string; error?: string }> {
  const clientId = process.env.MYMOBILEAPI_CLIENT_ID;
  const apiKey = process.env.MYMOBILEAPI_API_KEY;
  const senderId = process.env.MYMOBILEAPI_SENDER_ID || "iMali";

  if (!clientId || !apiKey) {
    console.error("MyMobileAPI credentials not configured");
    return { success: false, error: "SMS service not configured" };
  }

  try {
    // Basic Auth: Base64 encode "clientId:apiKey"
    const authString = Buffer.from(`${clientId}:${apiKey}`).toString("base64");

    const response = await fetch("https://rest.mymobileapi.com/v3/BulkMessages", {
      method: "POST",
      headers: {
        "Authorization": `Basic ${authString}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        sendOptions: {
          senderId: senderId,
        },
        messages: [
          {
            destination: phoneNumber,
            content: message,
          },
        ],
      }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error("MyMobileAPI error:", response.status, errorText);
      return { success: false, error: `SMS API error: ${response.status}` };
    }

    const data = await response.json();
    console.log("SMS sent successfully:", data);
    return { success: true, messageId: data.eventId?.toString() };
  } catch (error) {
    console.error("SMS send error:", error);
    return { success: false, error: String(error) };
  }
}

/**
 * Send OTP to phone number
 *
 * @param phoneNumber - South African phone number
 * @returns { success: boolean, message: string }
 */
export const sendOtp = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "sendOtp");

  const { phoneNumber } = data;

  // Validate phone number
  if (!phoneNumber || !validators.phoneNumber(phoneNumber)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid South African phone number. Use format: 0612345678 or +27612345678"
    );
  }

  // Normalize phone number to E.164 format
  const normalizedPhone = normalizePhoneNumber(phoneNumber);

  // Check rate limit (prevent OTP spam)
  const rateLimitResult = await checkRateLimit(normalizedPhone, "otp_send");
  if (!rateLimitResult.allowed) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      rateLimitResult.message || "Too many OTP requests. Please try again later."
    );
  }

  // Check resend cooldown
  const existingDoc = await db
    .collection("verification_codes")
    .doc(normalizedPhone)
    .get();

  if (existingDoc.exists) {
    const existingData = existingDoc.data()!;
    const createdAt = existingData.createdAt?.toDate();
    if (createdAt) {
      const secondsSinceCreated = (Date.now() - createdAt.getTime()) / 1000;
      if (secondsSinceCreated < OTP_CONFIG.resendCooldownSeconds) {
        const waitTime = Math.ceil(
          OTP_CONFIG.resendCooldownSeconds - secondsSinceCreated
        );
        throw new functions.https.HttpsError(
          "resource-exhausted",
          `Please wait ${waitTime} seconds before requesting a new code.`
        );
      }
    }
  }

  // Generate OTP and hash
  const code = generateOtp();
  const salt = generateSalt();
  const hashedCode = hashCode(code, salt);

  const now = admin.firestore.Timestamp.now();
  const expiresAt = admin.firestore.Timestamp.fromMillis(
    now.toMillis() + OTP_CONFIG.expiryMinutes * 60 * 1000
  );

  // Store verification document
  await db.collection("verification_codes").doc(normalizedPhone).set({
    phoneNumber: normalizedPhone,
    hashedCode,
    salt,
    attempts: 0,
    createdAt: now,
    expiresAt,
    status: "pending",
  });

  // Send SMS
  const appHash = process.env.SMS_APP_HASH || "";
  const message = `Your iMali verification code is: ${code}. Valid for ${OTP_CONFIG.expiryMinutes} minutes. Do not share this code.${appHash ? `\n${appHash}` : ""}`;
  const smsResult = await sendSmsViaMyMobileApi(normalizedPhone, message);

  if (!smsResult.success) {
    // Delete the verification document if SMS failed
    await db.collection("verification_codes").doc(normalizedPhone).delete();
    throw new functions.https.HttpsError(
      "internal",
      "Failed to send SMS. Please try again."
    );
  }

  console.log(
    `OTP sent to ${normalizedPhone}, messageId: ${smsResult.messageId}`
  );

  return {
    success: true,
    message: "Verification code sent",
  };
});

/**
 * Verify OTP and return custom auth token
 *
 * @param phoneNumber - South African phone number
 * @param code - 4-digit verification code
 * @returns { success: boolean, customToken: string, userId: string, isNewUser: boolean }
 */
export const verifyOtp = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "verifyOtp");

  const { phoneNumber, code } = data;

  // Validate phone number
  if (!phoneNumber || !validators.phoneNumber(phoneNumber)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid phone number"
    );
  }

  // Validate code format
  if (!code || !/^\d{4}$/.test(code)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid verification code format. Must be 4 digits."
    );
  }

  const normalizedPhone = normalizePhoneNumber(phoneNumber);

  // Check rate limit for verification attempts
  const rateLimitResult = await checkRateLimit(normalizedPhone, "otp_verify");
  if (!rateLimitResult.allowed) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      "Too many verification attempts. Please request a new code."
    );
  }

  // Get verification document
  const docRef = db.collection("verification_codes").doc(normalizedPhone);
  const doc = await docRef.get();

  if (!doc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "No verification in progress. Please request a new code."
    );
  }

  const verificationData = doc.data()!;

  // Check if already verified or locked
  if (verificationData.status === "verified") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Code already used. Please request a new one."
    );
  }

  if (verificationData.status === "locked") {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      "Too many failed attempts. Please request a new code."
    );
  }

  // Check expiry
  const expiresAt = verificationData.expiresAt?.toDate();
  if (!expiresAt || Date.now() > expiresAt.getTime()) {
    await docRef.update({ status: "expired" });
    throw new functions.https.HttpsError(
      "deadline-exceeded",
      "Verification code has expired. Please request a new one."
    );
  }

  // Check attempts
  const attempts = verificationData.attempts || 0;
  if (attempts >= OTP_CONFIG.maxAttempts) {
    await docRef.update({ status: "locked" });
    throw new functions.https.HttpsError(
      "resource-exhausted",
      "Maximum attempts exceeded. Please request a new code."
    );
  }

  // Verify code
  const hashedInput = hashCode(code, verificationData.salt);

  if (hashedInput !== verificationData.hashedCode) {
    // Increment attempts
    const newAttempts = attempts + 1;
    await docRef.update({
      attempts: newAttempts,
      lastAttemptAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    const remainingAttempts = OTP_CONFIG.maxAttempts - newAttempts;
    if (remainingAttempts <= 0) {
      await docRef.update({ status: "locked" });
      throw new functions.https.HttpsError(
        "resource-exhausted",
        "Maximum attempts exceeded. Please request a new code."
      );
    }

    throw new functions.https.HttpsError(
      "failed-precondition",
      `Invalid code. ${remainingAttempts} attempt${remainingAttempts === 1 ? "" : "s"} remaining.`
    );
  }

  // Create or get Firebase Auth user BEFORE marking as verified,
  // so that if user creation fails the code can be retried.
  const userId = `phone_${normalizedPhone.replace(/\+/g, "")}`;
  let isNewUser = false;

  try {
    await admin.auth().getUser(userId);
  } catch (error: unknown) {
    const authError = error as { code?: string };
    if (authError.code === "auth/user-not-found") {
      // Create user without phoneNumber field to avoid requiring
      // Phone Auth provider. Phone number is stored in Firestore instead.
      await admin.auth().createUser({
        uid: userId,
        displayName: normalizedPhone,
      });
      isNewUser = true;
    } else {
      throw error;
    }
  }

  // Generate custom token
  const customToken = await admin.auth().createCustomToken(userId);

  // Only mark as verified and clean up AFTER user creation + token generation succeed
  await docRef.update({
    status: "verified",
    verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  await docRef.delete();

  console.log(`User ${userId} verified successfully, isNewUser: ${isNewUser}`);

  // Handle the user doc: stamp lastLoginAt if it's a complete doc,
  // or delete it if it's a stale partial doc (e.g. from a previous
  // merge-write that created only {lastLoginAt} without phoneNumber).
  // A partial doc causes the client's .set() to be treated as UPDATE
  // by Firestore, which fails the security rule that checks phoneNumber.
  db.collection("users").doc(userId).get().then((userDoc) => {
    if (!userDoc.exists) return null;

    if (userDoc.data()?.phoneNumber) {
      // Complete doc — stamp lastLoginAt
      return db.collection("users").doc(userId).set(
        { lastLoginAt: admin.firestore.FieldValue.serverTimestamp() },
        { merge: true }
      );
    }

    // Stale partial doc (no phoneNumber) — delete it so the client's
    // .set() is treated as CREATE, not UPDATE.
    console.warn(`Deleting stale partial user doc for ${userId} (no phoneNumber)`);
    return db.collection("users").doc(userId).delete();
  }).catch((err: unknown) => console.warn("Failed to handle user doc:", err));

  // Check if user has any trusted devices
  const trustedDevices = await db.collection("devices")
    .where("userId", "==", userId)
    .where("trusted", "==", true)
    .where("revoked", "==", false)
    .limit(1)
    .get();

  const hasTrustedDevice = !trustedDevices.empty;

  return {
    success: true,
    customToken,
    userId,
    isNewUser,
    hasTrustedDevice,
    requiresDeviceRegistration: !hasTrustedDevice,
  };
});

/**
 * Register a device as trusted for the authenticated user.
 *
 * Stores the device's public key (from Keystore/Secure Enclave),
 * FCM token, and device metadata. Server-only write to devices collection.
 *
 * @param publicKeyPem - ECDSA P-256 public key in PEM format
 * @param fcmToken - Firebase Cloud Messaging token
 * @param platform - "android" or "ios"
 * @param deviceModel - Device model name
 * @param osVersion - OS version string
 * @param appVersion - App version string
 * @param manufacturer - Device manufacturer
 * @param hardwareBacked - Whether key is hardware-backed
 * @param strongBox - Whether StrongBox/Secure Enclave is used
 */
export const registerDevice = functions.https.onCall(async (data, context) => {
  // Require authentication
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated to register a device."
    );
  }
  requireAppCheck(context, "registerDevice");

  const userId = context.auth.uid;
  const {
    publicKeyPem,
    fcmToken,
    platform,
    deviceModel,
    osVersion,
    appVersion,
    manufacturer,
    hardwareBacked,
    strongBox,
  } = data;

  // Validate required fields
  if (!publicKeyPem || !fcmToken || !platform) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "publicKeyPem, fcmToken, and platform are required."
    );
  }

  // Validate public key format
  if (!publicKeyPem.startsWith("-----BEGIN PUBLIC KEY-----")) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid public key format. Must be PEM encoded."
    );
  }

  // Rate limit device registration (5 per day)
  const rateLimitResult = await checkRateLimit(userId, "device_register");
  if (!rateLimitResult.allowed) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      rateLimitResult.message || "Too many device registrations. Try again later."
    );
  }

  const now = admin.firestore.FieldValue.serverTimestamp();
  const sanitizedPlatform = validators.sanitizeString(platform);
  const sanitizedModel = deviceModel ? validators.sanitizeString(deviceModel) : null;

  // Look for an existing device for this user + platform + model to upsert
  const existingDevices = await db.collection("devices")
    .where("userId", "==", userId)
    .where("platform", "==", sanitizedPlatform)
    .where("revoked", "==", false)
    .limit(1)
    .get();

  let deviceRef: FirebaseFirestore.DocumentReference;

  if (!existingDevices.empty) {
    // Update existing device record (new keypair, fresh FCM token)
    deviceRef = existingDevices.docs[0].ref;
    await deviceRef.update({
      publicKeyPem,
      fcmToken,
      osVersion: osVersion ? validators.sanitizeString(osVersion) : null,
      appVersion: appVersion ? validators.sanitizeString(appVersion) : null,
      hardwareBacked: hardwareBacked === true,
      strongBox: strongBox === true,
      trusted: true,
      lastUsedAt: now,
    });

    // Clean up any other duplicate device records for this user
    const allDevices = await db.collection("devices")
      .where("userId", "==", userId)
      .where("revoked", "==", false)
      .get();

    const batch = db.batch();
    let cleaned = 0;
    allDevices.forEach((doc) => {
      if (doc.id !== deviceRef.id) {
        batch.update(doc.ref, { revoked: true, revokedAt: now });
        cleaned++;
      }
    });
    if (cleaned > 0) {
      await batch.commit();
      console.log(`Cleaned up ${cleaned} duplicate device record(s) for ${userId}`);
    }

    console.log(`Device ${deviceRef.id} updated for user ${userId}`);
  } else {
    // Create new device document
    deviceRef = db.collection("devices").doc();

    const deviceData = {
      userId,
      publicKeyPem,
      fcmToken,
      platform: sanitizedPlatform,
      deviceModel: sanitizedModel,
      osVersion: osVersion ? validators.sanitizeString(osVersion) : null,
      appVersion: appVersion ? validators.sanitizeString(appVersion) : null,
      manufacturer: manufacturer ? validators.sanitizeString(manufacturer) : null,
      hardwareBacked: hardwareBacked === true,
      strongBox: strongBox === true,
      trusted: true,
      revoked: false,
      registeredAt: now,
      lastUsedAt: now,
    };

    await deviceRef.set(deviceData);
    console.log(`Device ${deviceRef.id} registered for user ${userId}`);
  }

  // Update user's primary device if they don't have one
  const userDoc = await db.collection("users").doc(userId).get();
  if (userDoc.exists) {
    const userData = userDoc.data();
    if (!userData?.primaryDeviceId) {
      await db.collection("users").doc(userId).update({
        primaryDeviceId: deviceRef.id,
      });
    }
  }

  return {
    deviceId: deviceRef.id,
    userId,
    publicKeyPem,
    fcmToken,
    platform,
    deviceModel: deviceModel || null,
    osVersion: osVersion || null,
    appVersion: appVersion || null,
    manufacturer: manufacturer || null,
    hardwareBacked: hardwareBacked === true,
    strongBox: strongBox === true,
    trusted: true,
    revoked: false,
    registeredAt: new Date().toISOString(),
    lastUsedAt: new Date().toISOString(),
  };
});

/**
 * Revoke a device's trusted status.
 *
 * @param deviceId - The device document ID to revoke
 */
export const revokeDevice = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated."
    );
  }
  requireAppCheck(context, "revokeDevice");

  const { deviceId } = data;
  if (!deviceId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "deviceId is required."
    );
  }

  const deviceDoc = await db.collection("devices").doc(deviceId).get();
  if (!deviceDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Device not found.");
  }

  const deviceData = deviceDoc.data()!;
  if (deviceData.userId !== context.auth.uid) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only revoke your own devices."
    );
  }

  await db.collection("devices").doc(deviceId).update({
    trusted: false,
    revoked: true,
    revokedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log(`Device ${deviceId} revoked by user ${context.auth.uid}`);

  return { success: true };
});

/**
 * Update the FCM token for a registered device.
 *
 * @param deviceId - The device document ID
 * @param fcmToken - The new FCM token
 */
export const updateDeviceFcmToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated."
    );
  }
  requireAppCheck(context, "updateDeviceFcmToken");

  const { deviceId, fcmToken } = data;
  if (!deviceId || !fcmToken) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "deviceId and fcmToken are required."
    );
  }

  const deviceDoc = await db.collection("devices").doc(deviceId).get();
  if (!deviceDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Device not found.");
  }

  const deviceData = deviceDoc.data()!;
  if (deviceData.userId !== context.auth.uid) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only update your own devices."
    );
  }

  await db.collection("devices").doc(deviceId).update({
    fcmToken,
    lastUsedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true };
});

// ============================================
// Push-Based Login Challenges
// ============================================

/**
 * Request a push-based login for a returning user.
 *
 * Looks up trusted devices for the phone number. If found, creates
 * an auth challenge with a random nonce and sends an FCM push.
 *
 * @param phoneNumber - South African phone number
 * @returns { challengeId, hasTrustedDevice }
 */
export const loginRequest = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "loginRequest");

  const { phoneNumber } = data;

  if (!phoneNumber || !validators.phoneNumber(phoneNumber)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid South African phone number."
    );
  }

  const normalizedPhone = normalizePhoneNumber(phoneNumber);

  // Rate limit login requests
  const rateLimitResult = await checkRateLimit(normalizedPhone, "login_request");
  if (!rateLimitResult.allowed) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      rateLimitResult.message || "Too many login requests. Please try again later."
    );
  }

  // Find the user by phone number
  const userId = `phone_${normalizedPhone.replace(/\+/g, "")}`;

  let userExists = false;
  try {
    await admin.auth().getUser(userId);
    userExists = true;
  } catch (error: unknown) {
    const authError = error as { code?: string };
    if (authError.code !== "auth/user-not-found") {
      throw error;
    }
  }

  if (!userExists) {
    // No user found — no trusted device possible
    return {
      challengeId: null,
      hasTrustedDevice: false,
    };
  }

  // Find trusted devices for this user
  const trustedDevices = await db.collection("devices")
    .where("userId", "==", userId)
    .where("trusted", "==", true)
    .where("revoked", "==", false)
    .get();

  if (trustedDevices.empty) {
    return {
      challengeId: null,
      hasTrustedDevice: false,
    };
  }

  // Generate challenge nonce
  const nonce = crypto.randomBytes(32).toString("base64");
  const now = admin.firestore.Timestamp.now();
  const expiresAt = admin.firestore.Timestamp.fromMillis(
    now.toMillis() + 3 * 60 * 1000 // 3 minutes
  );

  // Create challenge document
  const challengeRef = db.collection("authChallenges").doc();
  await challengeRef.set({
    userId,
    phoneNumber: normalizedPhone,
    nonce,
    status: "pending",
    createdAt: now,
    expiresAt,
  });

  // Send FCM to all trusted devices
  const fcmTokens: string[] = [];
  trustedDevices.forEach((doc) => {
    const deviceData = doc.data();
    if (deviceData.fcmToken) {
      fcmTokens.push(deviceData.fcmToken);
    }
  });

  if (fcmTokens.length > 0) {
    try {
      const sendResult = await admin.messaging().sendEachForMulticast({
        tokens: fcmTokens,
        // Data-only message — no "notification" field.
        // This ensures onMessage fires reliably in the foreground on Android.
        // The Flutter app handles displaying any UI in response.
        data: {
          type: "auth_challenge",
          challengeId: challengeRef.id,
          nonce,
          title: "Login Request",
          body: "Tap to approve login to iMali",
        },
        android: {
          priority: "high",
          ttl: 180000, // 3 minutes
        },
        apns: {
          headers: {
            "apns-priority": "10",
            "apns-expiration": String(Math.floor(Date.now() / 1000) + 180),
          },
          payload: {
            aps: {
              "content-available": 1,
            },
          },
        },
      });

      // Check which tokens are stale and clean them up
      const staleTokenIndices: number[] = [];
      sendResult.responses.forEach((resp, idx) => {
        if (!resp.success) {
          const errCode = resp.error?.code;
          if (
            errCode === "messaging/registration-token-not-registered" ||
            errCode === "messaging/invalid-registration-token" ||
            errCode === "messaging/invalid-argument"
          ) {
            staleTokenIndices.push(idx);
            console.log(`Stale FCM token detected at index ${idx}: ${errCode}`);
          }
        }
      });

      // If ALL tokens were stale, clean up and fall back to OTP
      if (staleTokenIndices.length === fcmTokens.length) {
        console.log(
          `All ${fcmTokens.length} FCM token(s) are stale for ${userId}. ` +
          `Cleaning up and falling back to OTP.`
        );

        // Revoke stale device records
        const batch = db.batch();
        const staleNow = admin.firestore.FieldValue.serverTimestamp();
        trustedDevices.forEach((doc) => {
          batch.update(doc.ref, {
            trusted: false,
            revoked: true,
            revokedAt: staleNow,
            revokeReason: "stale_fcm_token",
          });
        });
        await batch.commit();

        // Delete the challenge we just created (no one can receive it)
        await challengeRef.delete();

        return {
          challengeId: null,
          hasTrustedDevice: false,
        };
      }

      // If SOME tokens were stale, clean up just those devices
      if (staleTokenIndices.length > 0) {
        const staleBatch = db.batch();
        const staleNow = admin.firestore.FieldValue.serverTimestamp();
        staleTokenIndices.forEach((idx) => {
          const staleToken = fcmTokens[idx];
          trustedDevices.forEach((doc) => {
            if (doc.data().fcmToken === staleToken) {
              staleBatch.update(doc.ref, {
                trusted: false,
                revoked: true,
                revokedAt: staleNow,
                revokeReason: "stale_fcm_token",
              });
            }
          });
        });
        await staleBatch.commit();
      }

      const delivered = sendResult.successCount;
      console.log(
        `Push challenge sent: ${delivered}/${fcmTokens.length} delivered for ${userId}`
      );
    } catch (error) {
      console.error("FCM send error:", error);
      // Don't fail the request — user can still use OTP
    }
  }

  return {
    challengeId: challengeRef.id,
    hasTrustedDevice: true,
  };
});

/**
 * Approve a push-based login challenge.
 *
 * Verifies the ECDSA signature of the nonce using the device's stored
 * public key, then issues a custom auth token.
 *
 * @param challengeId - The challenge document ID
 * @param signedNonce - Base64-encoded ECDSA signature of the nonce
 * @param deviceId - The device document ID that signed the nonce
 * @returns { customToken, userId }
 */
export const approveLogin = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "approveLogin");

  const { challengeId, signedNonce, deviceId } = data;

  if (!challengeId || !signedNonce || !deviceId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "challengeId, signedNonce, and deviceId are required."
    );
  }

  // Rate limit challenge approvals
  const rateLimitResult = await checkRateLimit(deviceId, "challenge_approve");
  if (!rateLimitResult.allowed) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      rateLimitResult.message || "Too many approval attempts."
    );
  }

  // Get challenge
  const challengeRef = db.collection("authChallenges").doc(challengeId);
  const challengeDoc = await challengeRef.get();

  if (!challengeDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Challenge not found.");
  }

  const challengeData = challengeDoc.data()!;

  // Check challenge status
  if (challengeData.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `Challenge is ${challengeData.status}, not pending.`
    );
  }

  // Check expiry
  const expiresAt = challengeData.expiresAt?.toDate();
  if (!expiresAt || Date.now() > expiresAt.getTime()) {
    await challengeRef.update({ status: "expired" });
    throw new functions.https.HttpsError(
      "deadline-exceeded",
      "Challenge has expired."
    );
  }

  // Get device and verify ownership
  const deviceDoc = await db.collection("devices").doc(deviceId).get();
  if (!deviceDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Device not found.");
  }

  const deviceData = deviceDoc.data()!;
  if (deviceData.userId !== challengeData.userId) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Device does not belong to the challenge user."
    );
  }

  if (!deviceData.trusted || deviceData.revoked) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Device is not trusted."
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
        status: "denied",
        respondedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      throw new functions.https.HttpsError(
        "permission-denied",
        "Invalid signature."
      );
    }
  } catch (error: unknown) {
    const err = error as { code?: string; message?: string };
    if (err.code) {
      throw error; // Re-throw HttpsError
    }
    console.error("Signature verification error:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Signature verification failed."
    );
  }

  // Signature valid — generate custom token first, then approve challenge
  const customToken = await admin.auth().createCustomToken(challengeData.userId);

  // Write customToken to the challenge document so the requesting client
  // (watching via Firestore snapshot) can exchange it for a Firebase session.
  await challengeRef.update({
    status: "approved",
    customToken,
    deviceId,
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
  ).catch((err: unknown) => console.warn("Failed to stamp lastLoginAt:", err));

  console.log(`Challenge ${challengeId} approved by device ${deviceId}`);

  return {
    customToken,
    userId: challengeData.userId,
  };
});

/**
 * Deny a push-based login challenge.
 *
 * @param challengeId - The challenge document ID
 */
export const denyLogin = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated."
    );
  }
  requireAppCheck(context, "denyLogin");

  const { challengeId } = data;
  if (!challengeId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "challengeId is required."
    );
  }

  const challengeRef = db.collection("authChallenges").doc(challengeId);
  const challengeDoc = await challengeRef.get();

  if (!challengeDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Challenge not found.");
  }

  const challengeData = challengeDoc.data()!;
  if (challengeData.userId !== context.auth.uid) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only deny your own challenges."
    );
  }

  if (challengeData.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Challenge is no longer pending."
    );
  }

  await challengeRef.update({
    status: "denied",
    respondedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log(`Challenge ${challengeId} denied by user ${context.auth.uid}`);

  return { success: true };
});

/**
 * Check the status of a push-based login challenge.
 *
 * This is used by the requesting (unauthenticated) client to poll for
 * challenge status updates, since Firestore security rules require
 * authentication for direct document reads.
 *
 * @param challengeId - The challenge document ID
 * @returns { status, customToken? }
 */
export const checkChallengeStatus = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "checkChallengeStatus");

  const { challengeId } = data;

  if (!challengeId || typeof challengeId !== "string") {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "challengeId is required."
    );
  }

  // Rate limit polling (generous limit per challengeId)
  const rateLimitResult = await checkRateLimit(challengeId, "challenge_poll");
  if (!rateLimitResult.allowed) {
    throw new functions.https.HttpsError(
      "resource-exhausted",
      rateLimitResult.message || "Too many status checks."
    );
  }

  const challengeRef = db.collection("authChallenges").doc(challengeId);
  const challengeDoc = await challengeRef.get();

  if (!challengeDoc.exists) {
    return { status: "expired", customToken: null };
  }

  const challengeData = challengeDoc.data()!;

  // Check if expired
  const expiresAt = challengeData.expiresAt?.toDate();
  if (expiresAt && Date.now() > expiresAt.getTime()) {
    if (challengeData.status === "pending") {
      await challengeRef.update({ status: "expired" });
    }
    return { status: "expired", customToken: null };
  }

  const status = challengeData.status || "pending";

  if (status === "approved" && challengeData.customToken) {
    return {
      status: "approved",
      customToken: challengeData.customToken,
    };
  }

  return { status, customToken: null };
});

// ============================================
// Risk Events
// ============================================

/**
 * Create a risk event for a user.
 *
 * @param type - Risk event type: simChange, geoChange, largeTransaction, newDevice, suspiciousActivity
 * @param severity - low, medium, high, critical
 * @param details - Optional description
 * @param deviceId - Optional device that triggered the event
 */
export const createRiskEvent = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated."
    );
  }
  requireAppCheck(context, "createRiskEvent");

  const userId = context.auth.uid;
  const { type, severity, details, deviceId } = data;

  if (!type || !severity) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "type and severity are required."
    );
  }

  const validTypes = ["simChange", "geoChange", "largeTransaction", "newDevice", "suspiciousActivity"];
  const validSeverities = ["low", "medium", "high", "critical"];

  if (!validTypes.includes(type)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      `Invalid risk event type: ${type}`
    );
  }

  if (!validSeverities.includes(severity)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      `Invalid severity: ${severity}`
    );
  }

  const eventRef = db.collection("riskEvents").doc();
  const now = admin.firestore.FieldValue.serverTimestamp();

  await eventRef.set({
    userId,
    type,
    severity,
    status: "pending",
    details: details ? validators.sanitizeString(details) : null,
    deviceId: deviceId || null,
    createdAt: now,
    resolvedAt: null,
  });

  console.log(`Risk event ${eventRef.id} created for user ${userId}: ${type} (${severity})`);

  // For high/critical events, send push notification to user's devices
  if (severity === "high" || severity === "critical") {
    const trustedDevices = await db.collection("devices")
      .where("userId", "==", userId)
      .where("trusted", "==", true)
      .where("revoked", "==", false)
      .get();

    const fcmTokens: string[] = [];
    trustedDevices.forEach((doc) => {
      const devData = doc.data();
      if (devData.fcmToken) {
        fcmTokens.push(devData.fcmToken);
      }
    });

    if (fcmTokens.length > 0) {
      try {
        await admin.messaging().sendEachForMulticast({
          tokens: fcmTokens,
          notification: {
            title: "Security Alert",
            body: `A ${severity}-risk security event was detected on your account.`,
          },
          data: {
            type: "risk_event",
            eventId: eventRef.id,
            riskType: type,
            severity,
          },
        });
      } catch (error) {
        console.error("FCM notification error:", error);
      }
    }
  }

  return {
    eventId: eventRef.id,
    type,
    severity,
    status: "pending",
  };
});

/**
 * Resolve a risk event after step-up authentication.
 *
 * @param eventId - The risk event document ID
 */
export const resolveRiskEvent = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated."
    );
  }
  requireAppCheck(context, "resolveRiskEvent");

  const { eventId } = data;
  if (!eventId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "eventId is required."
    );
  }

  const eventRef = db.collection("riskEvents").doc(eventId);
  const eventDoc = await eventRef.get();

  if (!eventDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Risk event not found.");
  }

  const eventData = eventDoc.data()!;
  if (eventData.userId !== context.auth.uid) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "You can only resolve your own risk events."
    );
  }

  if (eventData.status !== "pending") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Risk event is not pending."
    );
  }

  await eventRef.update({
    status: "resolved",
    resolvedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log(`Risk event ${eventId} resolved by user ${context.auth.uid}`);

  return { success: true };
});

/**
 * Notify existing trusted devices when a new device logs in.
 *
 * Called after registerDevice when the user already has other trusted devices.
 *
 * @param userId - The user who registered a new device
 * @param newDeviceModel - Model name of the new device
 * @param newDevicePlatform - Platform of the new device (android/ios)
 * @param excludeDeviceId - The new device ID (don't notify it)
 */
export const notifyNewDeviceLogin = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated."
    );
  }
  requireAppCheck(context, "notifyNewDeviceLogin");

  const userId = context.auth.uid;
  const { newDeviceModel, newDevicePlatform, excludeDeviceId } = data;

  // Get all trusted devices except the new one
  const trustedDevices = await db.collection("devices")
    .where("userId", "==", userId)
    .where("trusted", "==", true)
    .where("revoked", "==", false)
    .get();

  const fcmTokens: string[] = [];
  trustedDevices.forEach((doc) => {
    if (doc.id !== excludeDeviceId) {
      const devData = doc.data();
      if (devData.fcmToken) {
        fcmTokens.push(devData.fcmToken);
      }
    }
  });

  if (fcmTokens.length === 0) {
    return { notified: 0 };
  }

  const deviceDesc = newDeviceModel
    ? `${newDeviceModel} (${newDevicePlatform || "unknown"})`
    : "a new device";

  try {
    await admin.messaging().sendEachForMulticast({
      tokens: fcmTokens,
      notification: {
        title: "New Device Login",
        body: `Your iMali account was accessed from ${deviceDesc}. If this wasn't you, secure your account.`,
      },
      data: {
        type: "new_device_login",
        newDeviceModel: newDeviceModel || "",
        newDevicePlatform: newDevicePlatform || "",
      },
    });

    console.log(`New device notification sent to ${fcmTokens.length} device(s) for user ${userId}`);
    return { notified: fcmTokens.length };
  } catch (error) {
    console.error("New device notification error:", error);
    return { notified: 0 };
  }
});
