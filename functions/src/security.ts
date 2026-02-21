/**
 * Security Middleware for Cloud Functions
 * Rate limiting, fraud detection, and input validation
 */

import * as admin from "firebase-admin";
import { HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import { decodeIntegrityToken, evaluateVerdict, IntegrityTier } from "./integrity";

const db = admin.firestore();

/**
 * Structural interface compatible with both Gen1 CallableContext and
 * Gen2 CallableRequest, so helpers work during the migration period.
 */
interface CallableContextCompat {
  auth?: { uid: string; token?: Record<string, unknown> };
  app?: unknown;
}

/**
 * Check App Check token on a callable context.
 * In monitoring mode (enforce=false), logs a warning but does not reject.
 * In enforcement mode (enforce=true), throws unauthenticated.
 */
export function requireAppCheck(
  context: CallableContextCompat,
  functionName: string,
  // TODO: Set to true once app is published to Google Play with Play Integrity
  enforce: boolean = false
): void {
  if (!context.app) {
    logger.warn(
      `[AppCheck] Missing app token on ${functionName} ` +
      `from user ${context.auth?.uid || "unauthenticated"}`
    );

    if (enforce) {
      throw new HttpsError(
        "unauthenticated",
        "App verification failed. Please update the app."
      );
    }
  }
}

/**
 * Require Play Integrity verification for sensitive operations.
 *
 * Decodes the integrity token, evaluates the verdict against the specified
 * tier, and logs the result to the integrityChecks collection.
 *
 * In advisory mode (enforce=false): logs warnings but does not block.
 * In enforcement mode (enforce=true): throws on failed integrity checks.
 *
 * @param data - The incoming function data (must contain integrityToken and integrityNonce)
 * @param context - The callable context
 * @param functionName - Name of the function for logging
 * @param tier - The security tier ("HIGHEST" or "HIGH")
 * @param enforce - Whether to block on failure (default: false = advisory mode)
 */
export async function requirePlayIntegrity(
  data: Record<string, unknown>,
  context: CallableContextCompat,
  functionName: string,
  tier: IntegrityTier,
  // TODO: Set to true once app is published to Google Play with Play Integrity
  enforce: boolean = false
): Promise<void> {
  const integrityToken = data.integrityToken as string | undefined;
  const integrityNonce = data.integrityNonce as string | undefined;
  const userId = context.auth?.uid || "unauthenticated";

  // If no token provided, log and optionally block
  if (!integrityToken || !integrityNonce) {
    logger.warn(
      `[PlayIntegrity] Missing integrity token/nonce on ${functionName} from user ${userId}`
    );

    await db.collection("integrityChecks").add({
      userId,
      functionName,
      tier,
      result: "missing_token",
      allowed: !enforce,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    if (enforce) {
      throw new HttpsError(
        "failed-precondition",
        "Device integrity verification required."
      );
    }
    return;
  }

  try {
    const verdict = await decodeIntegrityToken(integrityToken, integrityNonce);
    const evaluation = evaluateVerdict(verdict, tier);

    // Log the integrity check result
    await db.collection("integrityChecks").add({
      userId,
      functionName,
      tier,
      result: evaluation.allowed ? (evaluation.warn ? "warn" : "pass") : "fail",
      deviceRecognition: evaluation.deviceRecognition,
      appLicensing: evaluation.appLicensing,
      appIntegrity: evaluation.appIntegrity,
      reason: evaluation.reason,
      allowed: enforce ? evaluation.allowed : true,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    if (evaluation.warn) {
      logger.warn(
        `[PlayIntegrity] Warning on ${functionName} from user ${userId}: ${evaluation.reason}`
      );
    }

    if (!evaluation.allowed) {
      logger.warn(
        `[PlayIntegrity] Blocked on ${functionName} from user ${userId}: ${evaluation.reason}`
      );

      if (enforce) {
        throw new HttpsError(
          "failed-precondition",
          "Device integrity check failed. This operation requires a verified device."
        );
      }
    }
  } catch (error: unknown) {
    const err = error as { code?: string; message?: string };
    // Re-throw HttpsErrors (from enforce mode)
    if (err.code) {
      throw error;
    }

    logger.error(
      `[PlayIntegrity] Error decoding token on ${functionName} from user ${userId}:`,
      error
    );

    await db.collection("integrityChecks").add({
      userId,
      functionName,
      tier,
      result: "error",
      errorMessage: String(error),
      allowed: !enforce,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    if (enforce) {
      throw new HttpsError(
        "internal",
        "Device integrity verification failed."
      );
    }
  }
}

// Rate limit configurations
const RATE_LIMITS: Record<string, { maxAttempts: number; windowMinutes: number }> = {
  "earn": { maxAttempts: 100, windowMinutes: 60 },
  "transfer": { maxAttempts: 20, windowMinutes: 10 },
  "cashout": { maxAttempts: 5, windowMinutes: 60 },
  "purchase": { maxAttempts: 20, windowMinutes: 10 },
  "referral": { maxAttempts: 10, windowMinutes: 60 },
  "otp_send": { maxAttempts: 5, windowMinutes: 60 },
  "otp_verify": { maxAttempts: 10, windowMinutes: 5 },
  "device_register": { maxAttempts: 5, windowMinutes: 1440 },
  "login_request": { maxAttempts: 10, windowMinutes: 60 },
  "challenge_approve": { maxAttempts: 10, windowMinutes: 10 },
  "reward_claim": { maxAttempts: 10, windowMinutes: 60 },
  "reward_redeem": { maxAttempts: 20, windowMinutes: 60 },
};

// Fraud detection thresholds
const FRAUD_THRESHOLDS = {
  maxDailyEarnings: 100000, // 100k tokens = R1000
  maxSingleTransfer: 100000, // 100k tokens = R1000
  maxDailyTransfers: 50,
  maxDailyCashouts: 5,
  newAccountCashoutLimit: 10000, // New accounts (<7 days)
  alertThreshold: 3, // Alerts before account review
};

/**
 * Check rate limit for an action
 */
export async function checkRateLimit(
  userId: string,
  action: string
): Promise<{ allowed: boolean; message?: string }> {
  const limit = RATE_LIMITS[action];
  if (!limit) {
    return { allowed: true };
  }

  const now = new Date();
  const windowStart = new Date(now.getTime() - limit.windowMinutes * 60 * 1000);

  const rateLimitRef = db.collection("rateLimits").doc(`${userId}_${action}`);
  const doc = await rateLimitRef.get();

  if (!doc.exists) {
    // First action, create record
    await rateLimitRef.set({
      userId,
      action,
      attempts: [now.toISOString()],
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    return { allowed: true };
  }

  const data = doc.data()!;
  const attempts = (data.attempts || [])
    .map((t: string) => new Date(t))
    .filter((t: Date) => t > windowStart);

  if (attempts.length >= limit.maxAttempts) {
    return {
      allowed: false,
      message: `Rate limit exceeded. Try again in ${limit.windowMinutes} minutes.`,
    };
  }

  // Record this attempt
  attempts.push(now);
  await rateLimitRef.update({
    attempts: attempts.map((t: Date) => t.toISOString()),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { allowed: true };
}

/**
 * Check for fraud patterns in earning activity
 */
export async function checkEarningFraud(
  userId: string,
  amount: number,
  source: string
): Promise<{ allowed: boolean; alerts: string[] }> {
  const alerts: string[] = [];
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  // Get today's earnings
  const earningsSnapshot = await db.collection("earnings")
    .where("userId", "==", userId)
    .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(today))
    .get();

  const todayTotal = earningsSnapshot.docs.reduce(
    (sum, doc) => sum + (doc.data().amount || 0),
    0
  );

  // Check daily limit
  if (todayTotal + amount > FRAUD_THRESHOLDS.maxDailyEarnings) {
    alerts.push("Daily earning limit exceeded");
  }

  // Check for suspicious earning velocity
  if (earningsSnapshot.size > 50) {
    const times = earningsSnapshot.docs
      .map(doc => doc.data().createdAt?.toDate())
      .filter(Boolean)
      .sort((a, b) => b.getTime() - a.getTime())
      .slice(0, 10);

    if (times.length >= 10) {
      const avgInterval = (times[0].getTime() - times[9].getTime()) / 9;
      if (avgInterval < 30000) { // Less than 30 seconds average
        alerts.push("Abnormally fast earning pattern");
      }
    }
  }

  // Check for repeated same-source abuse
  const sameSourceCount = earningsSnapshot.docs.filter(
    doc => doc.data().source === source
  ).length;

  if (sameSourceCount > 30) {
    alerts.push("Excessive earnings from same source");
  }

  // Record alert if suspicious
  if (alerts.length > 0) {
    await recordFraudAlert(userId, "earning", alerts);
  }

  return {
    allowed: alerts.length < 2, // Allow if only minor flags
    alerts,
  };
}

/**
 * Check for fraud patterns in transfer activity
 */
export async function checkTransferFraud(
  senderId: string,
  recipientId: string,
  amount: number
): Promise<{ allowed: boolean; alerts: string[] }> {
  const alerts: string[] = [];
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  // Check single transfer limit
  if (amount > FRAUD_THRESHOLDS.maxSingleTransfer) {
    alerts.push("Transfer exceeds single transaction limit");
  }

  // Get today's transfers
  const transfersSnapshot = await db.collection("transactions")
    .where("userId", "==", senderId)
    .where("type", "==", "transfer")
    .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(today))
    .get();

  // Check daily transfer count
  if (transfersSnapshot.size >= FRAUD_THRESHOLDS.maxDailyTransfers) {
    alerts.push("Daily transfer limit reached");
  }

  // Check for circular transfers
  const reverseTransfers = await db.collection("transactions")
    .where("userId", "==", recipientId)
    .where("type", "==", "transfer")
    .where("recipientId", "==", senderId)
    .limit(5)
    .get();

  if (!reverseTransfers.empty) {
    const recentReverse = reverseTransfers.docs.find(doc => {
      const createdAt = doc.data().createdAt?.toDate();
      return createdAt && (new Date().getTime() - createdAt.getTime()) < 3600000; // Last hour
    });

    if (recentReverse) {
      alerts.push("Potential circular transfer pattern");
    }
  }

  // Check for new recipient flooding
  const uniqueRecipients = new Set(
    transfersSnapshot.docs.map(doc => doc.data().recipientId)
  );
  if (uniqueRecipients.size > 10) {
    alerts.push("Too many unique recipients today");
  }

  if (alerts.length > 0) {
    await recordFraudAlert(senderId, "transfer", alerts);
  }

  return {
    allowed: alerts.length < 2,
    alerts,
  };
}

/**
 * Check for fraud patterns in cashout requests
 */
export async function checkCashoutFraud(
  userId: string,
  amount: number
): Promise<{ allowed: boolean; alerts: string[] }> {
  const alerts: string[] = [];
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  // Get user account info
  const userDoc = await db.collection("users").doc(userId).get();
  const userData = userDoc.data();
  const accountCreatedAt = userData?.createdAt?.toDate();
  const accountAgeDays = accountCreatedAt
    ? Math.floor((new Date().getTime() - accountCreatedAt.getTime()) / (1000 * 60 * 60 * 24))
    : 999;

  // ── KYC tier enforcement ─────────────────────────────────────────
  const kycTier = userData?.kycTier || "none";

  if (kycTier === "none") {
    return {
      allowed: false,
      alerts: ["KYC verification required before cashouts are allowed"],
    };
  }

  // Basic tier: max 5,000 tokens (R50) per day
  if (kycTier === "basic" && amount > 5000) {
    alerts.push("Cashout exceeds basic KYC tier limit (R50/day)");
  }

  // Check new account limits
  if (accountAgeDays < 7 && amount > FRAUD_THRESHOLDS.newAccountCashoutLimit) {
    alerts.push("Large cashout from new account");
  }

  // Get today's cashouts
  const cashoutsSnapshot = await db.collection("cashouts")
    .where("userId", "==", userId)
    .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(today))
    .get();

  // Check daily cashout count
  if (cashoutsSnapshot.size >= FRAUD_THRESHOLDS.maxDailyCashouts) {
    alerts.push("Daily cashout limit reached");
  }

  // Check for rapid cashout after receiving large transfer
  const recentLargeTransfers = await db.collection("transactions")
    .where("recipientId", "==", userId)
    .where("type", "==", "transfer")
    .where("tokenAmount", ">", 5000)
    .orderBy("tokenAmount", "desc")
    .orderBy("createdAt", "desc")
    .limit(5)
    .get();

  if (!recentLargeTransfers.empty) {
    const mostRecent = recentLargeTransfers.docs[0].data().createdAt?.toDate();
    if (mostRecent && (new Date().getTime() - mostRecent.getTime()) < 1800000) { // 30 min
      alerts.push("Rapid cashout after receiving large transfer");
    }
  }

  if (alerts.length > 0) {
    await recordFraudAlert(userId, "cashout", alerts);
  }

  return {
    allowed: alerts.length < 2,
    alerts,
  };
}

/**
 * Check for fraud patterns in reward claim activity
 */
export async function checkRewardFraud(
  userId: string
): Promise<{ allowed: boolean; alerts: string[] }> {
  const alerts: string[] = [];
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  // Check if user is blocked
  if (await isUserBlocked(userId)) {
    return { allowed: false, alerts: ["User is blocked"] };
  }

  // Check daily reward allocations count (max 20 per day)
  const dailyAllocations = await db
    .collection("rewardItems")
    .where("allocatedToUserId", "==", userId)
    .where("allocatedAt", ">=", admin.firestore.Timestamp.fromDate(today))
    .get();

  if (dailyAllocations.size > 20) {
    alerts.push("Excessive daily reward allocations");
  }

  // Check for same-campaign rapid claims (flag if >3 same campaign in 1 hour)
  const oneHourAgo = new Date(Date.now() - 60 * 60 * 1000);
  const recentAllocations = await db
    .collection("rewardItems")
    .where("allocatedToUserId", "==", userId)
    .where("allocatedAt", ">=", admin.firestore.Timestamp.fromDate(oneHourAgo))
    .get();

  const campaignCounts = new Map<string, number>();
  for (const doc of recentAllocations.docs) {
    const cId = doc.data().campaignId;
    campaignCounts.set(cId, (campaignCounts.get(cId) || 0) + 1);
  }
  for (const [, count] of campaignCounts) {
    if (count > 3) {
      alerts.push("Rapid claims on same campaign");
      break;
    }
  }

  if (alerts.length > 0) {
    await recordFraudAlert(userId, "reward", alerts);
  }

  return {
    allowed: alerts.length < 2,
    alerts,
  };
}

/**
 * Record a fraud alert
 */
async function recordFraudAlert(
  userId: string,
  type: string,
  reasons: string[]
): Promise<void> {
  const alertRef = db.collection("fraudAlerts").doc();
  await alertRef.set({
    id: alertRef.id,
    userId,
    type,
    reasons,
    reviewed: false,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Check if user should be blocked
  const recentAlerts = await db.collection("fraudAlerts")
    .where("userId", "==", userId)
    .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(
      new Date(Date.now() - 24 * 60 * 60 * 1000)
    ))
    .get();

  if (recentAlerts.size >= FRAUD_THRESHOLDS.alertThreshold) {
    // Add to blocked users for review
    await db.collection("blockedUsers").doc(userId).set({
      userId,
      reason: "Multiple fraud alerts triggered",
      alertCount: recentAlerts.size,
      blockedAt: admin.firestore.FieldValue.serverTimestamp(),
      reviewed: false,
    }, { merge: true });

    logger.info(`User ${userId} blocked due to multiple fraud alerts`);
  }
}

/**
 * Check if user is blocked
 */
export async function isUserBlocked(userId: string): Promise<boolean> {
  const blockedDoc = await db.collection("blockedUsers").doc(userId).get();
  if (!blockedDoc.exists) {
    return false;
  }

  const data = blockedDoc.data()!;
  // Allow if manually reviewed and cleared
  if (data.reviewed && data.cleared) {
    return false;
  }

  return true;
}

/**
 * Validate input data
 */
export const validators = {
  phoneNumber: (phone: string): boolean => {
    const regex = /^(\+27|0)[6-8][0-9]{8}$/;
    return regex.test(phone.replaceAll(/[\s\-()]/g, ""));
  },

  email: (email: string): boolean => {
    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(email.trim().toLowerCase());
  },

  displayName: (name: string): boolean => {
    const regex = /^[a-zA-Z\s]{2,50}$/;
    return regex.test(name.trim());
  },

  referralCode: (code: string): boolean => {
    const regex = /^[A-Z0-9]{6,10}$/;
    return regex.test(code.trim().toUpperCase());
  },

  tokenAmount: (amount: number, min = 1, max = 10000000): boolean => {
    return Number.isInteger(amount) && amount >= min && amount <= max;
  },

  sanitizeString: (input: string): string => {
    return input
      .trim()
      .replace(/<script|javascript:|on\w+\s*=/gi, "")
      .replaceAll(/[\x00-\x1F\x7F]/g, "");
  },
};

/**
 * Clean up old rate limit records (run daily)
 */
export async function cleanupRateLimits(): Promise<void> {
  const cutoff = new Date(Date.now() - 24 * 60 * 60 * 1000); // 24 hours ago

  const oldRecords = await db.collection("rateLimits")
    .where("updatedAt", "<", admin.firestore.Timestamp.fromDate(cutoff))
    .limit(500)
    .get();

  const batch = db.batch();
  oldRecords.docs.forEach(doc => {
    batch.delete(doc.ref);
  });

  if (!oldRecords.empty) {
    await batch.commit();
    logger.info(`Cleaned up ${oldRecords.size} old rate limit records`);
  }
}
