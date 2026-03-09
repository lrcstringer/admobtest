/**
 * Buy Admin Executors — dispatched by executePendingAction in adminAuth.ts
 *
 * These functions execute the actual operations after maker-checker approval.
 * Each executor runs inside a Firestore transaction to prevent double-spend
 * from concurrent force-complete and force-cancel on the same group buy.
 */

import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { releaseGroupBuyEscrow, refundGroupBuyContribution } from "./ledger/groupBuyEscrow";
import { releaseMarketplaceEscrow, refundMarketplaceEscrow } from "./ledger/marketplaceEscrow";

const db = admin.firestore();

/**
 * Execute force-complete for a group buy.
 * Uses transaction to prevent concurrent forceComplete + forceCancel.
 */
export async function executeForceCompleteGroupBuy(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { groupBuyId } = payload as {
    groupBuyId: string;
  };

  // Transaction: re-read current data (amount may have changed since pending action was created)
  const txResult = await db.runTransaction(async (tx) => {
    const docRef = db.collection("groupBuys").doc(groupBuyId);
    const doc = await tx.get(docRef);
    if (!doc.exists) {
      throw new Error("Group buy not found");
    }

    const data = doc.data()!;
    if (!["open", "targetMet"].includes(data.status)) {
      throw new Error(
        `Cannot force-complete — status changed to "${data.status}" since approval was requested`
      );
    }

    if (!data.currentAmount || data.currentAmount <= 0) {
      throw new Error("Cannot force-complete a group buy with no contributions");
    }

    if (!data.organizerId) {
      throw new Error("Group buy has no organizer ID");
    }

    // Mark as completed inside transaction to prevent concurrent cancel
    tx.update(docRef, {
      status: "completed",
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Return live values from the transaction, NOT stale payload values
    return {
      organizerId: data.organizerId as string,
      currentAmount: data.currentAmount as number,
    };
  });

  // Release escrow outside transaction using live transactional amount
  await releaseGroupBuyEscrow(
    txResult.organizerId,
    txResult.currentAmount,
    groupBuyId,
    `Admin force-complete for group buy ${groupBuyId}`
  );

  logger.info(
    `Force-completed group buy ${groupBuyId}: ${txResult.currentAmount} tokens released to ${txResult.organizerId}`
  );

  return { groupBuyId, amount: txResult.currentAmount, organizerId: txResult.organizerId };
}

/**
 * Execute force-cancel for a group buy.
 * Uses transaction to prevent concurrent forceComplete + forceCancel.
 */
export async function executeForceCancelGroupBuy(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { groupBuyId } = payload as { groupBuyId: string };

  // Transaction: re-read status and guard against concurrent mutation
  await db.runTransaction(async (tx) => {
    const docRef = db.collection("groupBuys").doc(groupBuyId);
    const doc = await tx.get(docRef);
    if (!doc.exists) {
      throw new Error("Group buy not found");
    }

    const data = doc.data()!;
    if (["completed", "expired", "cancelled"].includes(data.status)) {
      throw new Error(
        `Cannot cancel — status changed to "${data.status}" since approval was requested`
      );
    }

    // Mark as cancelled inside transaction to prevent concurrent complete
    tx.update(docRef, {
      status: "cancelled",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  // Refund all contributors outside transaction (ledger has own idempotency)
  const contribSnap = await db
    .collection("groupBuys")
    .doc(groupBuyId)
    .collection("contributions")
    .get();

  const errors: string[] = [];
  for (const contribDoc of contribSnap.docs) {
    const contrib = contribDoc.data();
    try {
      await refundGroupBuyContribution(
        contrib.userId,
        contrib.amount,
        groupBuyId,
        `Admin force-cancel refund for group buy ${groupBuyId}`
      );
    } catch (err) {
      errors.push(`Failed to refund ${contrib.userId}: ${err}`);
      logger.error(`Force-cancel refund failed for ${contrib.userId}:`, err);
    }
  }

  logger.info(
    `Force-cancelled group buy ${groupBuyId}: ${contribSnap.size - errors.length} refunded, ${errors.length} failed`
  );

  return {
    groupBuyId,
    refundedCount: contribSnap.size - errors.length,
    errorCount: errors.length,
    errors: errors.length > 0 ? errors : undefined,
  };
}

/**
 * Execute force-cancel for a marketplace order.
 */
export async function executeForceCancelOrder(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { orderId } = payload as { orderId: string };

  // Read order data INSIDE transaction to avoid stale reads
  const txResult = await db.runTransaction(async (tx) => {
    const docRef = db.collection("buyOrders").doc(orderId);
    const doc = await tx.get(docRef);
    if (!doc.exists) {
      throw new Error("Order not found");
    }

    const data = doc.data()!;
    if (["completed", "cancelled", "refunded"].includes(data.status)) {
      throw new Error(`Cannot cancel — status is "${data.status}"`);
    }

    tx.update(docRef, {
      status: "cancelled",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      buyerId: data.buyerId as string,
      amount: data.amount as number,
      hasEscrow: !!data.escrowJournalId,
    };
  });

  // Refund buyer if escrowed (outside transaction — ledger has idempotency)
  if (txResult.hasEscrow) {
    await refundMarketplaceEscrow(
      txResult.buyerId,
      txResult.amount,
      orderId,
      `Admin force-cancel refund for order ${orderId}`
    );
  }

  return { orderId, refunded: txResult.hasEscrow };
}

/**
 * Execute dispute resolution for a marketplace order.
 */
export async function executeResolveDispute(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { orderId, resolution, splitPercent } = payload as {
    orderId: string;
    resolution: string; // "refund_buyer" | "release_seller" | "split"
    splitPercent?: number;
  };

  const orderRef = db.collection("buyOrders").doc(orderId);

  // Transaction: atomically check status and mark as resolved to prevent concurrent resolution
  const txResult = await db.runTransaction(async (tx) => {
    const orderDoc = await tx.get(orderRef);
    if (!orderDoc.exists) {
      throw new Error("Order not found");
    }

    const order = orderDoc.data()!;
    if (order.status !== "disputed") {
      throw new Error(`Order is not disputed — status is "${order.status}"`);
    }

    const resolvedStatus = resolution === "refund_buyer" ? "refunded" : "completed";
    tx.update(orderRef, {
      status: resolvedStatus,
      disputeResolution: resolution,
      disputeSplitPercent: splitPercent ?? null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      buyerId: order.buyerId as string,
      sellerId: order.sellerId as string,
      amount: order.amount as number,
    };
  });

  // Execute ledger operations outside transaction (ledger has its own idempotency)
  if (resolution === "refund_buyer") {
    await refundMarketplaceEscrow(
      txResult.buyerId,
      txResult.amount,
      orderId,
      `Dispute resolved: full refund to buyer for order ${orderId}`
    );
  } else if (resolution === "release_seller") {
    await releaseMarketplaceEscrow(
      txResult.sellerId,
      txResult.amount,
      orderId,
      `Dispute resolved: released to seller for order ${orderId}`
    );
  } else if (resolution === "split" && splitPercent !== undefined) {
    const sellerAmount = Math.floor(txResult.amount * (splitPercent / 100));
    const buyerAmount = txResult.amount - sellerAmount;
    if (sellerAmount > 0) {
      await releaseMarketplaceEscrow(
        txResult.sellerId,
        sellerAmount,
        orderId,
        `Dispute resolved: split ${splitPercent}% to seller for order ${orderId}`
      );
    }
    if (buyerAmount > 0) {
      await refundMarketplaceEscrow(
        txResult.buyerId,
        buyerAmount,
        orderId,
        `Dispute resolved: split ${100 - splitPercent}% refund to buyer for order ${orderId}`
      );
    }
  } else {
    throw new Error(`Invalid resolution: ${resolution}`);
  }

  return { orderId, resolution };
}
