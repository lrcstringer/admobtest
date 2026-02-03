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

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Initiate a KYC verification session.
 *
 * Creates a verification session with the third-party provider and returns
 * the session URL/ID for the client to redirect to.
 */
export const initiateKyc = functions
  .runWith({ timeoutSeconds: 60, memory: "256MB" })
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated to initiate KYC."
      );
    }
    requireAppCheck(context, "initiateKyc");

    const userId = context.auth.uid;

    // Check current KYC status
    const userDoc = await db.collection("users").doc(userId).get();
    const userData = userDoc.data();

    if (userData?.kycTier === "verified") {
      throw new functions.https.HttpsError(
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

      console.log(`KYC verification initiated for user ${userId}`);

      return {
        success: true,
        verificationId: verificationRef.id,
        // TODO: Return provider session URL when integrated
        // sessionUrl: providerSession.url,
      };
    } catch (error) {
      console.error(`KYC initiation failed for user ${userId}:`, error);
      throw new functions.https.HttpsError(
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
export const kycWebhook = functions
  .runWith({ timeoutSeconds: 30, memory: "256MB" })
  .https.onRequest(async (req, res) => {
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

        console.log(`KYC approved for user ${userId}: tier=${tier}`);
      } else if (status === "rejected") {
        console.log(`KYC rejected for user ${userId}`);
      }

      res.status(200).json({ success: true });
    } catch (error) {
      console.error("KYC webhook processing error:", error);
      res.status(500).send("Internal error");
    }
  });

/**
 * Get current KYC status for the authenticated user.
 */
export const getKycStatus = functions
  .runWith({ timeoutSeconds: 10, memory: "128MB" })
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated."
      );
    }
    requireAppCheck(context, "getKycStatus");

    const userId = context.auth.uid;
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
