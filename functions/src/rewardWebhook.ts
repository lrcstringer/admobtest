/**
 * Reward Webhook — Retailer integration endpoint
 *
 * HTTP endpoint (not callable) for retailers/POS systems to notify
 * that a reward code was redeemed at their location.
 *
 * Authentication: HMAC-SHA256 signature using client's rewardWebhookSecret.
 * Idempotent: re-posting the same redemption is a no-op.
 */

import { onRequest } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
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
export const rewardWebhook = onRequest({ cors: false, invoker: "public", labels: { area: "rewards" } }, async (req, res) => {
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

  // #13 — Timestamp validation (replay protection)
  if (payload.redeemedAt) {
    const redeemedAt = new Date(payload.redeemedAt);
    const now = Date.now();
    if (isNaN(redeemedAt.getTime())) {
      res.status(400).json({ error: "Invalid redeemedAt format" });
      return;
    }
    // Reject if more than 5 minutes in the future
    if (redeemedAt.getTime() > now + 5 * 60 * 1000) {
      res.status(400).json({ error: "redeemedAt is in the future" });
      return;
    }
    // Reject if more than 24 hours in the past
    if (redeemedAt.getTime() < now - 24 * 60 * 60 * 1000) {
      res.status(400).json({ error: "redeemedAt is too far in the past" });
      return;
    }
  }

  // #14 — Rate limiting: max 100 calls per minute per client (atomic via transaction)
  const rateLimitRef = db.collection("rateLimits").doc(`webhook:${clientId}`);
  const currentTime = Date.now();

  try {
    await db.runTransaction(async (txn) => {
      const rateLimitDoc = await txn.get(rateLimitRef);
      if (rateLimitDoc.exists) {
        const rlData = rateLimitDoc.data()!;
        const windowStart = rlData.windowStart || 0;
        const count = rlData.count || 0;

        if (currentTime - windowStart >= 60000) {
          // Window expired — reset atomically
          txn.set(rateLimitRef, { windowStart: currentTime, count: 1 });
        } else if (count >= 100) {
          throw new Error("rate_limited");
        } else {
          txn.update(rateLimitRef, {
            count: admin.firestore.FieldValue.increment(1),
          });
        }
      } else {
        txn.set(rateLimitRef, { windowStart: currentTime, count: 1 });
      }
    });
  } catch (rlError: unknown) {
    if (rlError instanceof Error && rlError.message === "rate_limited") {
      res.status(429).json({ error: "Rate limit exceeded. Try again later." });
      return;
    }
    // Non-rate-limit transaction errors — continue (don't block webhook for rate limit infra failure)
    logger.warn("Rate limit transaction error", { error: rlError });
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

  // #1 + #4 — Atomic redemption in transaction (prevents double-count race condition
  // and validates campaign existence before counter update)
  const now = admin.firestore.Timestamp.now();
  const redeemedAt = payload.redeemedAt
    ? admin.firestore.Timestamp.fromDate(new Date(payload.redeemedAt))
    : now;

  const itemRef = itemDoc.ref;
  const campaignId = item.campaignId;

  try {
    await db.runTransaction(async (txn) => {
      // Re-read item inside transaction for consistency
      const freshItemDoc = await txn.get(itemRef);
      const freshItem = freshItemDoc.data();

      if (!freshItemDoc.exists || !freshItem) {
        throw new Error("item_not_found");
      }

      // Idempotency re-check inside transaction
      if (freshItem.status === "redeemed") {
        throw new Error("already_redeemed");
      }

      if (freshItem.status !== "allocated") {
        throw new Error(`invalid_status:${freshItem.status}`);
      }

      // #4 — Validate campaign exists and is not deleted
      const campaignRef = db.collection("rewardCampaigns").doc(campaignId);
      const campaignDoc = await txn.get(campaignRef);
      if (!campaignDoc.exists || campaignDoc.data()?.isDeleted === true) {
        throw new Error("campaign_unavailable");
      }

      // Update item status
      txn.update(itemRef, {
        status: "redeemed",
        redeemedAt,
        redemptionLocation: payload.location || null,
        "metadata.posTransactionId": payload.posTransactionId || null,
        "metadata.redeemedVia": "webhook",
        updatedAt: now,
      });

      // Campaign counter update handled by onRewardItemWritten trigger
    });
  } catch (txnError: unknown) {
    const errMsg = txnError instanceof Error ? txnError.message : "";
    if (errMsg === "already_redeemed") {
      res.status(200).json({
        status: "already_redeemed",
        itemId: itemDoc.id,
      });
      return;
    }
    if (errMsg === "campaign_unavailable") {
      res.status(410).json({ error: "Campaign no longer available" });
      return;
    }
    if (errMsg.startsWith("invalid_status:")) {
      res.status(409).json({ error: `Item status is '${errMsg.split(":")[1]}', cannot redeem` });
      return;
    }
    logger.error("Webhook redemption transaction failed", { error: txnError });
    res.status(500).json({ error: "Internal error processing redemption" });
    return;
  }

  // Activity log (fire-and-forget, outside transaction)
  db.collection("rewardActivityLog").add({
    itemId: itemDoc.id,
    campaignId,
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
  }).catch((e) => logger.warn("Failed to write webhook activity log", { error: e }));

  logger.info("Reward redeemed via webhook", {
    itemId: itemDoc.id,
    campaignId,
    clientId,
  });

  res.status(200).json({
    status: "redeemed",
    itemId: itemDoc.id,
    redeemedAt: redeemedAt.toDate().toISOString(),
  });
});
