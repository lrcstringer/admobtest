/**
 * Authentication Cloud Functions
 * Custom OTP verification using MyMobileAPI
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as crypto from "crypto";
import { checkRateLimit, validators } from "./security";

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
  const message = `Your iMali verification code is: ${code}. Valid for ${OTP_CONFIG.expiryMinutes} minutes. Do not share this code.`;
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

  // Code is valid - mark as verified
  await docRef.update({
    status: "verified",
    verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Create or get Firebase Auth user
  // Use phone number without + as userId for consistency
  const userId = `phone_${normalizedPhone.replace(/\+/g, "")}`;
  let isNewUser = false;

  try {
    await admin.auth().getUser(userId);
  } catch (error: unknown) {
    const authError = error as { code?: string };
    if (authError.code === "auth/user-not-found") {
      await admin.auth().createUser({
        uid: userId,
        phoneNumber: normalizedPhone,
      });
      isNewUser = true;
    } else {
      throw error;
    }
  }

  // Generate custom token
  const customToken = await admin.auth().createCustomToken(userId);

  // Clean up verification document
  await docRef.delete();

  console.log(`User ${userId} verified successfully, isNewUser: ${isNewUser}`);

  return {
    success: true,
    customToken,
    userId,
    isNewUser,
  };
});
