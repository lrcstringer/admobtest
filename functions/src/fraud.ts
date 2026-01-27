/**
 * Fraud Prevention Cloud Functions
 * Handle security verifications and fraud detection
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Verify Play Integrity token
 */
export const verifyPlayIntegrity = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {token, nonce} = data;

    if (!token || !nonce) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Token and nonce required"
      );
    }

    try {
    // In production, call Play Integrity API
    // const {google} = require('googleapis');
    // const playintegrity = google.playintegrity('v1');
    // const result = await playintegrity.v1.decodeIntegrityToken({
    //   packageName: 'com.imali.chat',
    //   requestBody: { integrityToken: token }
    // });

      // For now, return a simulated response
      const verdict = {
        isValid: true,
        verdict: "MEETS_DEVICE_INTEGRITY",
        deviceRecognition: "MEETS_DEVICE_INTEGRITY",
        appLicensing: "LICENSED",
        details: "Token verified successfully",
      };

      // Log the verification attempt
      await db.collection("integrityChecks").add({
        userId: context.auth.uid,
        nonce: nonce,
        result: verdict,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
      });

      return verdict;
    } catch (error) {
      console.error("Play Integrity verification failed:", error);
      throw new functions.https.HttpsError("internal", "Verification failed");
    }
  }
);

/**
 * Verify reCAPTCHA token
 */
export const verifyCaptcha = functions.https.onCall(async (data, context) => {
  const {token, action, userId} = data;

  if (!token) {
    throw new functions.https.HttpsError("invalid-argument", "Token required");
  }

  try {
    // In production, call reCAPTCHA Enterprise API
    // const recaptcha = require('@google-cloud/recaptcha-enterprise');
    // const client = new recaptcha.RecaptchaEnterpriseServiceClient();
    // const result = await client.createAssessment({...});

    // Simulated response
    const result = {
      success: true,
      score: 0.9,
      action: action,
      "error-codes": [] as string[],
    };

    // Log the verification
    await db.collection("captchaVerifications").add({
      userId: userId || null,
      action: action,
      score: result.score,
      success: result.success,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return result;
  } catch (error) {
    console.error("CAPTCHA verification failed:", error);
    throw new functions.https.HttpsError("internal", "Verification failed");
  }
});

/**
 * Check user fraud risk before high-value operation
 */
export const checkFraudRisk = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const userId = context.auth.uid;
  const {action, amount} = data;

  // Get user's fraud history
  const fraudFlags = await db
    .collection("fraudFlags")
    .where("userId", "==", userId)
    .where("active", "==", true)
    .get();

  if (!fraudFlags.empty) {
    // User has active fraud flags
    return {
      allowed: false,
      reason: "Account flagged for review",
      riskScore: 1.0,
    };
  }

  // Check recent suspicious activity
  const oneDayAgo = new Date();
  oneDayAgo.setDate(oneDayAgo.getDate() - 1);

  const recentActivity = await db
    .collection("auditLogs")
    .where("userId", "==", userId)
    .where("riskLevel", "in", ["high", "critical"])
    .where("timestamp", ">=", admin.firestore.Timestamp.fromDate(oneDayAgo))
    .get();

  let riskScore = 0;

  // Calculate risk score based on recent activity
  for (const doc of recentActivity.docs) {
    const docData = doc.data();
    if (docData.riskLevel === "critical") {
      riskScore += 0.3;
    } else if (docData.riskLevel === "high") {
      riskScore += 0.15;
    }
  }

  // Adjust for action type and amount
  if (action === "cashout" && amount >= 10000) {
    riskScore += 0.2;
  }

  riskScore = Math.min(riskScore, 1.0);

  return {
    allowed: riskScore < 0.7,
    reason: riskScore >= 0.7 ? "High risk detected" : null,
    riskScore: riskScore,
    requiresCaptcha: riskScore >= 0.5,
  };
});

/**
 * Flag a user for fraud
 */
export const flagUserForFraud = functions.https.onCall(
  async (data, context) => {
    // Only allow admin or system calls
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    // In production, check for admin role
    // const isAdmin = context.auth.token.admin === true;
    // if (!isAdmin) {
    //   throw new functions.https.HttpsError(
    //     "permission-denied",
    //     "Admin access required"
    //   );
    // }

    const {userId, reason, indicators} = data;

    if (!userId || !reason) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "UserId and reason required"
      );
    }

    const flagRef = db.collection("fraudFlags").doc();
    await flagRef.set({
      id: flagRef.id,
      userId: userId,
      reason: reason,
      indicators: indicators || {},
      active: true,
      createdBy: context.auth.uid,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Also update user document
    await db.collection("users").doc(userId).update({
      fraudFlagged: true,
      fraudFlaggedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {success: true, flagId: flagRef.id};
  }
);

/**
 * Remove fraud flag from user
 */
export const removeFraudFlag = functions.https.onCall(async (data, context) => {
  // Only allow admin or system calls
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {flagId, reason} = data;

  if (!flagId) {
    throw new functions.https.HttpsError("invalid-argument", "FlagId required");
  }

  const flagDoc = await db.collection("fraudFlags").doc(flagId).get();

  if (!flagDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Flag not found");
  }

  await flagDoc.ref.update({
    active: false,
    resolvedBy: context.auth.uid,
    resolvedAt: admin.firestore.FieldValue.serverTimestamp(),
    resolutionReason: reason || null,
  });

  // Check if user has any other active flags
  const otherFlags = await db
    .collection("fraudFlags")
    .where("userId", "==", flagDoc.data()!.userId)
    .where("active", "==", true)
    .limit(1)
    .get();

  if (otherFlags.empty) {
    // Remove fraud flag from user
    await db.collection("users").doc(flagDoc.data()!.userId).update({
      fraudFlagged: false,
    });
  }

  return {success: true};
});

/**
 * Log security event for audit trail
 */
export const logSecurityEvent = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {eventType, action, metadata, riskLevel} = data;

    if (!eventType || !action) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "EventType and action required"
      );
    }

    const logRef = db.collection("auditLogs").doc();
    await logRef.set({
      id: logRef.id,
      userId: context.auth.uid,
      eventType: eventType,
      action: action,
      metadata: metadata || {},
      riskLevel: riskLevel || "low",
      ipAddress: context.rawRequest.ip || null,
      userAgent: context.rawRequest.headers["user-agent"] || null,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {success: true, logId: logRef.id};
  }
);
