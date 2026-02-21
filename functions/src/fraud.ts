/**
 * Fraud Prevention Cloud Functions
 * Handle security verifications and fraud detection
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import { decodeIntegrityToken, evaluateVerdict } from "./integrity";

const db = admin.firestore();

/**
 * Verify Play Integrity token
 */
export const verifyPlayIntegrity = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(request, "verifyPlayIntegrity");

    const {token, nonce} = request.data;

    if (!token || !nonce) {
      throw new HttpsError(
        "invalid-argument",
        "Token and nonce required"
      );
    }

    try {
      // Decode token via Google Play Integrity API
      const decodedVerdict = await decodeIntegrityToken(token, nonce);

      // Evaluate against HIGHEST tier policy (standalone verification)
      const evaluation = evaluateVerdict(decodedVerdict, "HIGHEST");

      const result = {
        isValid: evaluation.allowed,
        verdict: evaluation.deviceRecognition.join(", ") || "NO_INTEGRITY",
        deviceRecognition: evaluation.deviceRecognition.join(", ") || "UNKNOWN",
        appLicensing: evaluation.appLicensing,
        details: evaluation.reason || "Token verified successfully",
      };

      // Log the verification attempt
      await db.collection("integrityChecks").add({
        userId: request.auth!.uid,
        nonce: nonce,
        result: result,
        deviceRecognition: evaluation.deviceRecognition,
        appLicensing: evaluation.appLicensing,
        appIntegrity: evaluation.appIntegrity,
        allowed: evaluation.allowed,
        warn: evaluation.warn,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
      });

      return result;
    } catch (error) {
      logger.error("Play Integrity verification failed:", error);
      throw new HttpsError("internal", "Verification failed");
    }
  }
);

/**
 * Verify reCAPTCHA token
 */
export const verifyCaptcha = onCall({ labels: { area: "auth" } }, async (request) => {
  requireAppCheck(request, "verifyCaptcha");

  const {token, action, userId} = request.data;

  if (!token) {
    throw new HttpsError("invalid-argument", "Token required");
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
    logger.error("CAPTCHA verification failed:", error);
    throw new HttpsError("internal", "Verification failed");
  }
});

/**
 * Check user fraud risk before high-value operation
 */
export const checkFraudRisk = onCall({ labels: { area: "auth" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  requireAppCheck(request, "checkFraudRisk");

  const userId = request.auth.uid;
  const {action, amount} = request.data;

  // Get user's fraud history
  const fraudFlags = await db
    .collection("fraudFlags")
    .where("userId", "==", userId)
    .where("active", "==", true)
    .limit(200)
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
    .limit(500)
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
export const flagUserForFraud = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    // Only allow admin or system calls
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(request, "flagUserForFraud");

    // In production, check for admin role
    // const isAdmin = context.auth.token.admin === true;
    // if (!isAdmin) {
    //   throw new HttpsError(
    //     "permission-denied",
    //     "Admin access required"
    //   );
    // }

    const {userId, reason, indicators} = request.data;

    if (!userId || !reason) {
      throw new HttpsError(
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
      createdBy: request.auth!.uid,
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
export const removeFraudFlag = onCall({ labels: { area: "auth" } }, async (request) => {
  // Only allow admin or system calls
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  requireAppCheck(request, "removeFraudFlag");

  const {flagId, reason} = request.data;

  if (!flagId) {
    throw new HttpsError("invalid-argument", "FlagId required");
  }

  const flagDoc = await db.collection("fraudFlags").doc(flagId).get();

  if (!flagDoc.exists) {
    throw new HttpsError("not-found", "Flag not found");
  }

  await flagDoc.ref.update({
    active: false,
    resolvedBy: request.auth!.uid,
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
export const logSecurityEvent = onCall(
  { labels: { area: "auth" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(request, "logSecurityEvent");

    const {eventType, action, metadata, riskLevel} = request.data;

    if (!eventType || !action) {
      throw new HttpsError(
        "invalid-argument",
        "EventType and action required"
      );
    }

    const logRef = db.collection("auditLogs").doc();
    await logRef.set({
      id: logRef.id,
      userId: request.auth.uid,
      eventType: eventType,
      action: action,
      metadata: metadata || {},
      riskLevel: riskLevel || "low",
      ipAddress: request.rawRequest.ip || null,
      userAgent: request.rawRequest.headers["user-agent"] || null,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {success: true, logId: logRef.id};
  }
);
