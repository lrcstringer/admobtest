/**
 * Reward Allocation Engine — Escrow-Based
 *
 * Reward items follow the same escrow pattern as tokens:
 *   startEngagement:    reserveRewardItem()   → item becomes "reserved"
 *   processEngagement:  confirmRewardReservation() → item becomes "allocated"
 *   abandon/failure:    releaseRewardReservation()  → item returns to "available"
 *
 * This guarantees that reward allocation is deterministic and never fire-and-forget.
 * If a reward item can't be reserved, the engagement doesn't start.
 * At completion, confirming a reserved item is a simple status change — guaranteed.
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as crypto from "crypto";
import { requireAdminPermission } from "./adminAuth";
import { requireAppCheck } from "./security";

const db = admin.firestore();

// ============================================================================
// RESERVE REWARD ITEM (called from startEngagement)
// ============================================================================

interface ReservationResult {
  itemId: string;
  itemIds?: string[];
  campaignName: string;
  rewardType: string;
}

/**
 * Reserve a reward item for an engagement.
 * Mirrors createEscrowReservation() for tokens.
 *
 * Idempotent: if item is already reserved for this engagementId, returns it.
 * Throws on failure — engagement should not start if reservation fails.
 */
export async function reserveRewardItem(
  userId: string,
  campaignId: string,
  engagementId: string,
  quantity: number = 1
): Promise<ReservationResult> {
  functions.logger.info("Reserving reward item", {
    userId,
    campaignId,
    engagementId,
    quantity,
  });

  // Step 1: Idempotency check — already reserved for this engagement?
  const existingReserved = await db
    .collection("rewardItems")
    .where("reservedForEngagementId", "==", engagementId)
    .where("campaignId", "==", campaignId)
    .limit(quantity)
    .get();

  if (!existingReserved.empty && existingReserved.size >= quantity) {
    functions.logger.info("Reward already reserved for this engagement", {
      engagementId,
      itemId: existingReserved.docs[0].id,
    });
    const campaign = await db.collection("rewardCampaigns").doc(campaignId).get();
    const campaignData = campaign.data();
    return {
      itemId: existingReserved.docs[0].id,
      ...(quantity > 1
        ? { itemIds: existingReserved.docs.map((d) => d.id) }
        : {}),
      campaignName: campaignData?.name || "",
      rewardType: campaignData?.rewardType || "",
    };
  }

  // Step 2: Campaign validation
  const campaignDoc = await db
    .collection("rewardCampaigns")
    .doc(campaignId)
    .get();

  if (!campaignDoc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      "Reward campaign not found"
    );
  }

  const campaign = campaignDoc.data()!;

  if (campaign.isDeleted === true) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "This offer is currently unavailable"
    );
  }

  if (campaign.status !== "active") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "This offer is currently unavailable"
    );
  }

  const now = new Date();
  const startsAt = campaign.startsAt?.toDate?.() || new Date(0);
  const endsAt = campaign.endsAt?.toDate?.() || new Date(0);

  if (now < startsAt || now > endsAt) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "This offer is currently unavailable"
    );
  }

  if ((campaign.remainingQuantity ?? 0) < quantity) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "This offer is currently unavailable"
    );
  }

  // Step 3: Per-user limit check (fix #4 — no .limit(10) bypass)
  const maxPerUser = campaign.maxPerUser || 1;
  const [allocatedItems, reservedItems] = await Promise.all([
    db
      .collection("rewardItems")
      .where("allocatedToUserId", "==", userId)
      .where("campaignId", "==", campaignId)
      .get(),
    db
      .collection("rewardItems")
      .where("reservedForUserId", "==", userId)
      .where("campaignId", "==", campaignId)
      .get(),
  ]);

  const totalClaimed = allocatedItems.size + reservedItems.size;
  if (totalClaimed + quantity > maxPerUser) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "This offer is currently unavailable"
    );
  }

  // Step 4: A/B variant assignment (deterministic per user+campaign)
  let abVariant: string | null = null;
  if (campaign.abTest?.enabled && Array.isArray(campaign.abTest.variants)) {
    const hash = crypto
      .createHash("md5")
      .update(`${userId}:${campaignId}`)
      .digest();
    const bucket = hash.readUInt16BE(0) % 100;
    let cumulative = 0;
    for (const variant of campaign.abTest.variants) {
      cumulative += variant.weight || 0;
      if (bucket < cumulative) {
        abVariant = variant.id;
        break;
      }
    }
    if (!abVariant) {
      abVariant = campaign.abTest.variants[0]?.id || "control";
    }
  }

  // Step 5: Reserve item(s) — atomic transaction with retry
  const reservedItemIds: string[] = [];

  for (let itemIndex = 0; itemIndex < quantity; itemIndex++) {
    const idempotencyId =
      quantity === 1 ? engagementId : `${engagementId}_r${itemIndex}`;

    // Query available items (sample 20 to reduce contention)
    const availableItems = await db
      .collection("rewardItems")
      .where("campaignId", "==", campaignId)
      .where("status", "==", "available")
      .limit(20)
      .get();

    if (availableItems.empty) {
      // If we already reserved some items in a multi-quantity request, release them
      for (const alreadyReservedId of reservedItemIds) {
        await releaseRewardReservation(alreadyReservedId, engagementId);
      }
      throw new functions.https.HttpsError(
        "failed-precondition",
        "This offer is currently unavailable"
      );
    }

    const randomIndex = Math.floor(Math.random() * availableItems.size);
    const candidates = availableItems.docs;
    const maxRetries = 3;
    let reservedItemId: string | null = null;

    for (let attempt = 0; attempt < maxRetries; attempt++) {
      const pickIndex = (randomIndex + attempt) % candidates.length;
      const candidate = candidates[pickIndex];
      const itemRef = db.collection("rewardItems").doc(candidate.id);
      const campaignRef = db.collection("rewardCampaigns").doc(campaignId);

      try {
        await db.runTransaction(async (txn) => {
          const itemDoc = await txn.get(itemRef);
          if (!itemDoc.exists || itemDoc.data()?.status !== "available") {
            throw new Error("Item no longer available");
          }

          const nowTimestamp = admin.firestore.FieldValue.serverTimestamp();

          txn.update(itemRef, {
            status: "reserved",
            reservedForUserId: userId,
            reservedForEngagementId: engagementId,
            reservedAt: nowTimestamp,
            expiresAt: campaign.itemExpiresAt || null,
            metadata: {
              ...itemDoc.data()?.metadata,
              engagementId: idempotencyId,
              ...(abVariant ? { abVariant } : {}),
            },
            updatedAt: nowTimestamp,
          });

          txn.update(campaignRef, {
            remainingQuantity: admin.firestore.FieldValue.increment(-1),
            updatedAt: nowTimestamp,
          });
        });

        reservedItemId = candidate.id;
        break;
      } catch (txnError) {
        functions.logger.warn(
          `Reservation attempt ${attempt + 1} failed, retrying`,
          { itemId: candidate.id, error: txnError }
        );
        if (attempt === maxRetries - 1) {
          // Release any partially reserved items
          for (const alreadyReservedId of reservedItemIds) {
            await releaseRewardReservation(alreadyReservedId, engagementId);
          }
          throw new functions.https.HttpsError(
            "failed-precondition",
            "This offer is currently unavailable"
          );
        }
      }
    }

    if (reservedItemId) {
      reservedItemIds.push(reservedItemId);
    }
  }

  // #8 — Post-reservation per-user limit re-check (TOCTOU guard for concurrent requests)
  if (reservedItemIds.length > 0) {
    const [finalAllocated, finalReserved] = await Promise.all([
      db
        .collection("rewardItems")
        .where("allocatedToUserId", "==", userId)
        .where("campaignId", "==", campaignId)
        .get(),
      db
        .collection("rewardItems")
        .where("reservedForUserId", "==", userId)
        .where("campaignId", "==", campaignId)
        .get(),
    ]);
    const finalTotal = finalAllocated.size + finalReserved.size;
    if (finalTotal > maxPerUser) {
      // Concurrent request pushed us over the limit — release our reservations
      for (const id of reservedItemIds) {
        await releaseRewardReservation(id, engagementId);
      }
      throw new functions.https.HttpsError(
        "failed-precondition",
        "This offer is currently unavailable"
      );
    }
  }

  functions.logger.info("Reward item(s) reserved successfully", {
    userId,
    campaignId,
    engagementId,
    itemIds: reservedItemIds,
  });

  return {
    itemId: reservedItemIds[0],
    ...(quantity > 1 ? { itemIds: reservedItemIds } : {}),
    campaignName: campaign.name || "",
    rewardType: campaign.rewardType || "",
  };
}

// ============================================================================
// CONFIRM REWARD RESERVATION (called from processEngagement)
// ============================================================================

/**
 * Confirm a reserved reward item — transition from "reserved" to "allocated".
 * Mirrors processEscrowCompletion() for tokens.
 *
 * This is a simple status change on an already-reserved item — guaranteed to succeed.
 */
export async function confirmRewardReservation(
  itemId: string,
  userId: string,
  engagementId: string
): Promise<string> {
  const itemRef = db.collection("rewardItems").doc(itemId);

  await db.runTransaction(async (txn) => {
    const itemDoc = await txn.get(itemRef);
    if (!itemDoc.exists) {
      throw new Error(`Reserved reward item ${itemId} not found`);
    }

    const item = itemDoc.data()!;
    if (
      item.status !== "reserved" ||
      item.reservedForEngagementId !== engagementId
    ) {
      throw new Error(
        `Item reservation mismatch: status=${item.status}, ` +
          `expected engagementId=${engagementId}, got=${item.reservedForEngagementId}`
      );
    }

    const nowTimestamp = admin.firestore.FieldValue.serverTimestamp();

    txn.update(itemRef, {
      status: "allocated",
      allocatedToUserId: userId,
      allocatedAt: nowTimestamp,
      reservedForUserId: null,
      reservedForEngagementId: null,
      updatedAt: nowTimestamp,
    });

    // Update campaign allocated counter
    const campaignRef = db
      .collection("rewardCampaigns")
      .doc(item.campaignId);
    txn.update(campaignRef, {
      allocatedQuantity: admin.firestore.FieldValue.increment(1),
      updatedAt: nowTimestamp,
    });
  });

  // Post-transaction: fire-and-forget non-critical operations
  const itemDoc = await itemRef.get();
  const item = itemDoc.data();

  // Activity log
  db.collection("rewardActivityLog")
    .add({
      itemId,
      campaignId: item?.campaignId,
      userId,
      action: "allocated",
      previousStatus: "reserved",
      newStatus: "allocated",
      performedBy: "system",
      notes: `Confirmed via engagement ${engagementId}`,
      metadata: { engagementId },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    })
    .catch((e) =>
      functions.logger.warn("Failed to write allocation activity log", {
        error: e,
      })
    );

  // Campaign exhaustion check
  if (item?.campaignId) {
    db.collection("rewardCampaigns")
      .doc(item.campaignId)
      .get()
      .then(async (campaignDoc) => {
        if (
          campaignDoc.exists &&
          (campaignDoc.data()?.remainingQuantity ?? 0) <= 0
        ) {
          await campaignDoc.ref.update({
            status: "exhausted",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      })
      .catch((e) =>
        functions.logger.warn("Failed to check campaign exhaustion", {
          error: e,
        })
      );
  }

  // Push notification
  if (item?.campaignId) {
    db.collection("users")
      .doc(userId)
      .get()
      .then(async (userDoc) => {
        const fcmToken = userDoc.data()?.fcmToken;
        if (fcmToken) {
          const campaignDoc = await db
            .collection("rewardCampaigns")
            .doc(item.campaignId)
            .get();
          const campaignData = campaignDoc.data();
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "New Reward!",
              body: `You earned a ${campaignData?.name || "reward"} from ${campaignData?.clientName || "a brand"}! Check your rewards.`,
            },
            data: {
              type: "reward_allocated",
              itemId,
              campaignId: item.campaignId,
            },
          });
        }
      })
      .catch((e) =>
        functions.logger.warn("Failed to send allocation notification", {
          error: e,
        })
      );
  }

  functions.logger.info("Reward reservation confirmed", {
    itemId,
    userId,
    engagementId,
  });

  return itemId;
}

// ============================================================================
// RELEASE REWARD RESERVATION (called on engagement failure/abandon/expiry)
// ============================================================================

/**
 * Release a reserved reward item — return it to the available pool.
 * Mirrors reverseJournal() / releaseEscrowReservation() for tokens.
 *
 * Idempotent: if item is not reserved or doesn't match, silently returns.
 */
export async function releaseRewardReservation(
  itemId: string,
  engagementId: string
): Promise<void> {
  const itemRef = db.collection("rewardItems").doc(itemId);

  await db.runTransaction(async (txn) => {
    const itemDoc = await txn.get(itemRef);
    if (!itemDoc.exists) {
      return; // Item doesn't exist — idempotent
    }

    const item = itemDoc.data()!;
    if (
      item.status !== "reserved" ||
      item.reservedForEngagementId !== engagementId
    ) {
      return; // Already released or mismatched — idempotent
    }

    const nowTimestamp = admin.firestore.FieldValue.serverTimestamp();

    txn.update(itemRef, {
      status: "available",
      reservedForUserId: null,
      reservedForEngagementId: null,
      reservedAt: null,
      updatedAt: nowTimestamp,
    });

    // Return to campaign pool
    const campaignRef = db
      .collection("rewardCampaigns")
      .doc(item.campaignId);
    txn.update(campaignRef, {
      remainingQuantity: admin.firestore.FieldValue.increment(1),
      updatedAt: nowTimestamp,
    });
  });

  // Activity log (fire-and-forget)
  db.collection("rewardActivityLog")
    .add({
      itemId,
      action: "reservation_released",
      previousStatus: "reserved",
      newStatus: "available",
      performedBy: "system",
      notes: `Reservation released for engagement ${engagementId}`,
      metadata: { engagementId },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    })
    .catch((e) =>
      functions.logger.warn("Failed to write release activity log", {
        error: e,
      })
    );

  functions.logger.info("Reward reservation released", {
    itemId,
    engagementId,
  });
}

// ============================================================================
// PROCESS REWARD ALLOCATION (admin callable — secured)
// ============================================================================

/**
 * Admin-only callable for manually triggering reward allocation.
 * Useful for edge-case recovery. Requires admin permission.
 */
export const processRewardAllocation = functions.https.onCall(
  async (
    data: {
      userId: string;
      campaignId: string;
      engagementId: string;
    },
    context
  ) => {
    requireAppCheck(context, "processRewardAllocation");
    await requireAdminPermission(
      context,
      "rewards:processAllocation",
      "processRewardAllocation"
    );

    const { userId, campaignId, engagementId } = data;

    if (!userId || !campaignId || !engagementId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId, campaignId, and engagementId are required"
      );
    }

    // Reserve and immediately confirm
    const reservation = await reserveRewardItem(
      userId,
      campaignId,
      engagementId
    );
    const confirmedItemId = await confirmRewardReservation(
      reservation.itemId,
      userId,
      engagementId
    );

    return {
      success: true,
      itemId: confirmedItemId,
    };
  }
);
