/**
 * Reward Webhook — Retailer integration endpoint
 *
 * HTTP endpoint (not callable) for retailers/POS systems to notify
 * that a reward code was redeemed at their location.
 *
 * Authentication: HMAC-SHA256 signature using client's rewardWebhookSecret.
 * Idempotent: re-posting the same redemption is a no-op.
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as crypto from "crypto";

const db = admin.firestore();

interface WebhookPayload {
  codeHash: string;          // SHA-256 hash of the code value
  redeemedAt?: string;       // ISO 8601 timestamp
  location?: string;         // Store/branch name
  posTransactionId?: string; // POS reference
}

/**
 * Verify HMAC-SHA256 signature from the X-Signature header.
 */
function verifySignature(
  body: string,
  signature: string,
  secret: string
): boolean {
  const expected = crypto
    .createHmac("sha256", secret)
    .update(body)
    .digest("hex");

  return crypto.timingSafeEqual(
    Buffer.from(signature, "hex"),
    Buffer.from(expected, "hex")
  );
}

/**
 * POST /rewardWebhook
 *
 * Headers:
 *   X-Client-Id: <clientId>
 *   X-Signature: <HMAC-SHA256 hex of raw body using client's rewardWebhookSecret>
 *
 * Body (JSON):
 *   { codeHash, redeemedAt?, location?, posTransactionId? }
 */
export const rewardWebhook = functions.https.onRequest(async (req, res) => {
  // Only accept POST
  if (req.method !== "POST") {
    res.status(405).json({ error: "Method not allowed" });
    return;
  }

  const clientId = req.headers["x-client-id"] as string | undefined;
  const signature = req.headers["x-signature"] as string | undefined;

  if (!clientId || !signature) {
    res.status(401).json({ error: "Missing X-Client-Id or X-Signature header" });
    return;
  }

  // Look up client and their webhook secret
  const clientDoc = await db.collection("clients").doc(clientId).get();
  if (!clientDoc.exists) {
    res.status(401).json({ error: "Unknown client" });
    return;
  }

  const clientData = clientDoc.data()!;
  const secret = clientData.rewardWebhookSecret as string | undefined;

  if (!secret) {
    res.status(403).json({ error: "Client has no webhook secret configured" });
    return;
  }

  // Verify HMAC signature
  const rawBody = JSON.stringify(req.body);
  try {
    if (!verifySignature(rawBody, signature, secret)) {
      res.status(401).json({ error: "Invalid signature" });
      return;
    }
  } catch {
    res.status(401).json({ error: "Invalid signature format" });
    return;
  }

  // Parse payload
  const payload = req.body as WebhookPayload;

  if (!payload.codeHash) {
    res.status(400).json({ error: "codeHash is required" });
    return;
  }

  // Find item by codeHash
  const itemsSnapshot = await db
    .collection("rewardItems")
    .where("codeHash", "==", payload.codeHash)
    .limit(1)
    .get();

  if (itemsSnapshot.empty) {
    res.status(404).json({ error: "Reward item not found" });
    return;
  }

  const itemDoc = itemsSnapshot.docs[0];
  const item = itemDoc.data();

  // Idempotency: already redeemed → return success
  if (item.status === "redeemed") {
    res.status(200).json({
      status: "already_redeemed",
      itemId: itemDoc.id,
      redeemedAt: item.redeemedAt?.toDate?.()?.toISOString(),
    });
    return;
  }

  // Only allocated items can be redeemed
  if (item.status !== "allocated") {
    res.status(409).json({
      error: `Item status is '${item.status}', cannot redeem`,
    });
    return;
  }

  // Mark as redeemed
  const now = admin.firestore.Timestamp.now();
  const redeemedAt = payload.redeemedAt
    ? admin.firestore.Timestamp.fromDate(new Date(payload.redeemedAt))
    : now;

  await itemDoc.ref.update({
    status: "redeemed",
    redeemedAt,
    redemptionLocation: payload.location || null,
    "metadata.posTransactionId": payload.posTransactionId || null,
    "metadata.redeemedVia": "webhook",
    updatedAt: now,
  });

  // Update campaign stats
  const campaignRef = db.collection("rewardCampaigns").doc(item.campaignId);
  await campaignRef.update({
    redeemedQuantity: admin.firestore.FieldValue.increment(1),
    updatedAt: now,
  });

  // Activity log
  await db.collection("rewardActivityLog").add({
    itemId: itemDoc.id,
    campaignId: item.campaignId,
    userId: item.allocatedToUserId || null,
    action: "redeemed",
    previousStatus: "allocated",
    newStatus: "redeemed",
    performedBy: `webhook:${clientId}`,
    notes: payload.location
      ? `Redeemed at ${payload.location}`
      : "Redeemed via retailer webhook",
    metadata: {
      posTransactionId: payload.posTransactionId || null,
    },
    ipAddress: req.ip || req.headers["x-forwarded-for"] || null,
    createdAt: now,
  });

  functions.logger.info("Reward redeemed via webhook", {
    itemId: itemDoc.id,
    campaignId: item.campaignId,
    clientId,
  });

  res.status(200).json({
    status: "redeemed",
    itemId: itemDoc.id,
    redeemedAt: redeemedAt.toDate().toISOString(),
  });
});
