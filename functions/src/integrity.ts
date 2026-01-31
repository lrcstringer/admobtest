/**
 * Play Integrity Token Decoding and Verdict Evaluation
 *
 * Decodes Play Integrity tokens via the Google Play Integrity API,
 * then evaluates the verdict against tiered policy rules.
 */

import { google } from "googleapis";

// Expected package name for the app
const PACKAGE_NAME = "com.example.imalichat";

/**
 * Integrity tier levels for policy enforcement.
 *
 * HIGHEST: cashout, sendTokens, processEngagement — block on basic-only
 * HIGH: processEarning, processPurchase, applyReferralCode — warn on basic-only
 */
export type IntegrityTier = "HIGHEST" | "HIGH";

/**
 * Result of decoding and evaluating a Play Integrity token.
 */
export interface IntegrityCheckResult {
  allowed: boolean;
  warn: boolean;
  deviceRecognition: string[];
  appLicensing: string;
  appIntegrity: string;
  reason: string | null;
  rawVerdict: Record<string, unknown>;
}

/**
 * Decode a Play Integrity token using the Google Play Integrity API.
 *
 * Requires the Google Cloud project to have the Play Integrity API enabled,
 * and the Cloud Functions service account must have permission to call it.
 *
 * @param token - The integrity token from the client
 * @param expectedNonce - The raw nonce string sent to the client (will be base64-encoded for comparison)
 * @returns The decoded token payload
 */
export async function decodeIntegrityToken(
  token: string,
  expectedNonce: string
): Promise<Record<string, unknown>> {
  const auth = new google.auth.GoogleAuth({
    scopes: ["https://www.googleapis.com/auth/playintegrity"],
  });

  const playintegrity = google.playintegrity({
    version: "v1",
    auth,
  });

  const response = await playintegrity.v1.decodeIntegrityToken({
    packageName: PACKAGE_NAME,
    requestBody: {
      integrityToken: token,
    },
  });

  const payload = response.data.tokenPayloadExternal;

  if (!payload) {
    throw new Error("Empty token payload from Play Integrity API");
  }

  // Verify nonce matches.
  // The client base64-encodes the raw nonce before passing it to the Play
  // Integrity API, so the token payload contains the base64-encoded form.
  // We base64-encode the expected nonce here to compare correctly.
  const encodedExpectedNonce = Buffer.from(expectedNonce, "utf-8").toString("base64");
  const receivedNonce = payload.requestDetails?.nonce;
  if (receivedNonce !== encodedExpectedNonce) {
    throw new Error("Nonce mismatch: possible replay attack");
  }

  // Verify package name
  const receivedPackage = payload.appIntegrity?.packageName;
  if (receivedPackage && receivedPackage !== PACKAGE_NAME) {
    throw new Error(`Package name mismatch: ${receivedPackage}`);
  }

  return payload as Record<string, unknown>;
}

/**
 * Evaluate a decoded Play Integrity verdict against tiered policy rules.
 *
 * Policy:
 *   HIGHEST tier (cashout, sendTokens, processEngagement):
 *     - MEETS_DEVICE_INTEGRITY or higher: Allow
 *     - MEETS_BASIC_INTEGRITY only: Block
 *     - No integrity labels: Block
 *     - UNLICENSED app: Block
 *
 *   HIGH tier (processEarning, processPurchase, applyReferralCode):
 *     - MEETS_DEVICE_INTEGRITY or higher: Allow
 *     - MEETS_BASIC_INTEGRITY only: Warn + allow
 *     - No integrity labels: Block
 *     - UNLICENSED app: Warn + allow
 *
 * @param verdict - The raw verdict payload from decodeIntegrityToken
 * @param tier - The security tier for the operation
 * @returns The evaluation result with allow/warn/block decision
 */
export function evaluateVerdict(
  verdict: Record<string, unknown>,
  tier: IntegrityTier
): IntegrityCheckResult {
  // Extract device integrity recognition verdicts
  const deviceIntegrity = verdict.deviceIntegrity as
    | { deviceRecognitionVerdict?: string[] }
    | undefined;
  const deviceLabels = deviceIntegrity?.deviceRecognitionVerdict || [];

  // Extract app integrity
  const appIntegrity = verdict.appIntegrity as
    | { appRecognitionVerdict?: string }
    | undefined;
  const appRecognition = appIntegrity?.appRecognitionVerdict || "UNRECOGNIZED";

  // Extract account details (licensing)
  const accountDetails = verdict.accountDetails as
    | { appLicensingVerdict?: string }
    | undefined;
  const licensingVerdict = accountDetails?.appLicensingVerdict || "UNEVALUATED";

  const baseResult: IntegrityCheckResult = {
    allowed: true,
    warn: false,
    deviceRecognition: deviceLabels,
    appLicensing: licensingVerdict,
    appIntegrity: appRecognition,
    reason: null,
    rawVerdict: verdict,
  };

  // Check for no device integrity labels at all
  if (deviceLabels.length === 0) {
    return {
      ...baseResult,
      allowed: false,
      reason: "No device integrity labels — possible emulator or rooted device",
    };
  }

  const meetsDevice = deviceLabels.includes("MEETS_DEVICE_INTEGRITY");
  const meetsStrong = deviceLabels.includes("MEETS_STRONG_INTEGRITY");
  const meetsBasicOnly =
    deviceLabels.includes("MEETS_BASIC_INTEGRITY") &&
    !meetsDevice &&
    !meetsStrong;

  // Device integrity check
  if (meetsBasicOnly) {
    if (tier === "HIGHEST") {
      return {
        ...baseResult,
        allowed: false,
        reason:
          "Only MEETS_BASIC_INTEGRITY — insufficient for high-value operation",
      };
    } else {
      // HIGH tier: warn but allow
      baseResult.warn = true;
      baseResult.reason = "Only MEETS_BASIC_INTEGRITY — proceeding with warning";
    }
  }

  // App licensing check
  if (licensingVerdict === "UNLICENSED") {
    if (tier === "HIGHEST") {
      return {
        ...baseResult,
        allowed: false,
        reason: "App is UNLICENSED — blocked for high-value operation",
      };
    } else {
      // HIGH tier: warn but allow
      baseResult.warn = true;
      baseResult.reason = baseResult.reason
        ? `${baseResult.reason}; app is UNLICENSED`
        : "App is UNLICENSED — proceeding with warning";
    }
  }

  return baseResult;
}
