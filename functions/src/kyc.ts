/**
 * KYC/AML Cloud Functions
 *
 * Provides Know-Your-Customer verification infrastructure.
 * Integrates with third-party KYC provider (Onfido, Jumio, or SA-specific).
 *
 * KYC Tiers:
 * - none: No verification — cashouts blocked
 * - basic: Self-declared info — R50/day (5,000 tokens) cashout limit
 * - verified: Full ID verification — full limits apply
 */

import { onCall, onRequest, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Initiate a KYC verification session.
 *
 * Creates a verification session with the third-party provider and returns
 * the session URL/ID for the client to redirect to.
 */
export const initiateKyc = onCall(
  { timeoutSeconds: 60, memory: "256MiB", labels: { area: "auth" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated to initiate KYC."
      );
    }
    requireAppCheck(request, "initiateKyc");

    const userId = request.auth.uid;

    // Check current KYC status
    const userDoc = await db.collection("users").doc(userId).get();
    const userData = userDoc.data();

    if (userData?.kycTier === "verified") {
      throw new HttpsError(
        "already-exists",
        "Account is already fully verified."
      );
    }

    try {
      // TODO: Integrate with actual KYC provider (Onfido, Jumio, etc.)
      // For now, create a pending verification record
      const verificationRef = db.collection("kycVerifications").doc();
      await verificationRef.set({
        id: verificationRef.id,
        userId,
        status: "pending",
        requestedTier: "verified",
        currentTier: userData?.kycTier || "none",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      logger.info(`KYC verification initiated for user ${userId}`);

      return {
        success: true,
        verificationId: verificationRef.id,
        // TODO: Return provider session URL when integrated
        // sessionUrl: providerSession.url,
      };
    } catch (error) {
      logger.error(`KYC initiation failed for user ${userId}:`, error);
      throw new HttpsError(
        "internal",
        "Failed to initiate verification. Please try again."
      );
    }
  });

/**
 * KYC webhook handler for receiving verification results from the provider.
 *
 * This is an HTTP function (not callable) because it receives
 * POST requests from the third-party KYC provider.
 */
export const kycWebhook = onRequest(
  { timeoutSeconds: 30, memory: "256MiB", cors: false, invoker: "public", labels: { area: "auth" } },
  async (req, res) => {
    if (req.method !== "POST") {
      res.status(405).send("Method not allowed");
      return;
    }

    // TODO: Verify webhook signature from KYC provider
    // const signature = req.headers['x-provider-signature'];
    // if (!verifySignature(signature, req.body)) { ... }

    try {
      const { verificationId, status, tier } = req.body;

      if (!verificationId || !status) {
        res.status(400).send("Missing required fields");
        return;
      }

      const verificationRef = db.collection("kycVerifications").doc(verificationId);
      const verificationDoc = await verificationRef.get();

      if (!verificationDoc.exists) {
        res.status(404).send("Verification not found");
        return;
      }

      const verificationData = verificationDoc.data()!;
      const userId = verificationData.userId;

      // Update verification record
      await verificationRef.update({
        status,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // If approved, update user's KYC tier
      if (status === "approved" && tier) {
        await db.collection("users").doc(userId).update({
          kycTier: tier,
          kycVerifiedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        logger.info(`KYC approved for user ${userId}: tier=${tier}`);
      } else if (status === "rejected") {
        logger.info(`KYC rejected for user ${userId}`);
      }

      res.status(200).json({ success: true });
    } catch (error) {
      logger.error("KYC webhook processing error:", error);
      res.status(500).send("Internal error");
    }
  });

/**
 * Get current KYC status for the authenticated user.
 */
export const getKycStatus = onCall(
  { timeoutSeconds: 10, memory: "128MiB", labels: { area: "auth" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated."
      );
    }
    requireAppCheck(request, "getKycStatus");

    const userId = request.auth.uid;
    const userDoc = await db.collection("users").doc(userId).get();
    const userData = userDoc.data();

    // Get latest verification if any
    const verifications = await db.collection("kycVerifications")
      .where("userId", "==", userId)
      .orderBy("createdAt", "desc")
      .limit(1)
      .get();

    const latestVerification = verifications.empty
      ? null
      : { id: verifications.docs[0].id, ...verifications.docs[0].data() };

    return {
      kycTier: userData?.kycTier || "none",
      kycVerifiedAt: userData?.kycVerifiedAt || null,
      latestVerification,
    };
  });
