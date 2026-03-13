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

  // Release escrow outside transaction using live transactional amount.
  // If release fails, revert status so it can be retried.
  try {
    await releaseGroupBuyEscrow(
      txResult.organizerId,
      txResult.currentAmount,
      groupBuyId,
      `Admin force-complete for group buy ${groupBuyId}`
    );
  } catch (releaseError) {
    logger.error(`Escrow release failed for force-complete ${groupBuyId}, reverting to targetMet`, releaseError);
    await db.collection("groupBuys").doc(groupBuyId).update({
      status: "targetMet",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    throw releaseError;
  }

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
 * Execute force-complete for a marketplace order.
 * Releases escrow to seller inside a transaction.
 */
export async function executeForceCompleteOrder(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { orderId } = payload as { orderId: string };

  const txResult = await db.runTransaction(async (tx) => {
    const docRef = db.collection("buyOrders").doc(orderId);
    const doc = await tx.get(docRef);
    if (!doc.exists) {
      throw new Error("Order not found");
    }

    const data = doc.data()!;
    if (["completed", "cancelled", "refunded"].includes(data.status)) {
      throw new Error(`Cannot force-complete — status is "${data.status}"`);
    }

    tx.update(docRef, {
      status: "completed",
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      sellerId: data.sellerId as string,
      amount: data.amount as number,
      hasEscrow: !!data.escrowJournalId,
    };
  });

  // Release escrow to seller. If release fails, revert status so it can be retried.
  if (txResult.hasEscrow) {
    try {
      await releaseMarketplaceEscrow(
        txResult.sellerId,
        txResult.amount,
        orderId,
        `Admin force-complete: release to seller for order ${orderId}`
      );
    } catch (releaseError) {
      logger.error(`Escrow release failed for force-complete order ${orderId}, reverting to fulfilled`, releaseError);
      await db.collection("buyOrders").doc(orderId).update({
        status: "fulfilled",
        completedAt: null,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      throw releaseError;
    }
  }

  return { orderId, released: txResult.hasEscrow };
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

  // Refund buyer if escrowed (outside transaction — ledger has idempotency).
  // If refund fails, revert status so it can be retried.
  if (txResult.hasEscrow) {
    try {
      await refundMarketplaceEscrow(
        txResult.buyerId,
        txResult.amount,
        orderId,
        `Admin force-cancel refund for order ${orderId}`
      );
    } catch (refundError) {
      logger.error(`Refund failed for force-cancel order ${orderId}, reverting to disputed`, refundError);
      await db.collection("buyOrders").doc(orderId).update({
        status: "disputed",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      throw refundError;
    }
  }

  return { orderId, refunded: txResult.hasEscrow };
}

/**
 * Execute dispute resolution for a marketplace order.
 */
export async function executeResolveDispute(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { orderId, resolution, sellerPercent } = payload as {
    orderId: string;
    resolution: string; // "refund_buyer" | "release_seller" | "split"
    sellerPercent?: number;
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
      disputeSellerPercent: sellerPercent ?? null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      buyerId: order.buyerId as string,
      sellerId: order.sellerId as string,
      amount: order.amount as number,
    };
  });

  // Execute ledger operations outside transaction (ledger has its own idempotency).
  // If ledger fails, revert status to "disputed" so it can be retried.
  try {
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
    } else if (resolution === "split" && sellerPercent !== undefined) {
      const sellerAmount = Math.floor(txResult.amount * (sellerPercent / 100));
      const buyerAmount = txResult.amount - sellerAmount;
      if (sellerAmount > 0) {
        await releaseMarketplaceEscrow(
          txResult.sellerId,
          sellerAmount,
          orderId,
          `Dispute resolved: split ${sellerPercent}% to seller for order ${orderId}`
        );
      }
      if (buyerAmount > 0) {
        await refundMarketplaceEscrow(
          txResult.buyerId,
          buyerAmount,
          orderId,
          `Dispute resolved: split ${100 - sellerPercent}% refund to buyer for order ${orderId}`
        );
      }
    } else {
      throw new Error(`Invalid resolution: ${resolution}`);
    }
  } catch (ledgerError) {
    logger.error(`Ledger operation failed for dispute resolution on order ${orderId}, reverting to disputed`, ledgerError);
    await orderRef.update({
      status: "disputed",
      disputeResolution: null,
      disputeSellerPercent: null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    throw ledgerError;
  }

  return { orderId, resolution };
}

/**
 * Execute group buy request approval after maker-checker.
 * Creates the group buy and marks the request as approved.
 */
export async function executeApproveGroupBuyRequest(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const {
    requestId,
    groupBuyTitle,
    targetAmount,
    deadline,
    description,
    type,
    fulfilmentType,
    clusters,
    imageUrl,
    communityId,
  } = payload as {
    requestId: string;
    groupBuyTitle: string;
    targetAmount: number;
    deadline: string;
    description: string;
    type: string;
    fulfilmentType: string;
    clusters: string[];
    imageUrl: string | null;
    communityId: string | null;
  };

  const requestRef = db.collection("groupBuyRequests").doc(requestId);
  const requestDoc = await requestRef.get();
  if (!requestDoc.exists) {
    throw new Error("Request not found");
  }
  if (requestDoc.data()!.status !== "pending") {
    throw new Error("Request is no longer in pending status");
  }

  const approvalSlug = groupBuyTitle.trim().toLowerCase().replace(/\s+/g, "_").substring(0, 30);
  const groupBuyRef = db.collection("groupBuys").doc(`approved_${approvalSlug}_${Date.now()}`);

  const batch = db.batch();
  batch.set(groupBuyRef, {
    id: groupBuyRef.id,
    title: groupBuyTitle,
    description: description || "",
    targetAmount,
    currentAmount: 0,
    participantCount: 0,
    minParticipants: 2,
    maxParticipants: null,
    status: "open",
    deadline: admin.firestore.Timestamp.fromDate(new Date(deadline)),
    organizerId: null,
    organizerName: "iMaliChat Curated",
    communityId: communityId || null,
    brandId: null,
    brandName: null,
    brandLogoUrl: null,
    discountPercent: null,
    linkedListingId: null,
    createdByAdmin: true,
    type: type || "digital",
    fulfilmentType: fulfilmentType || "digital",
    clusters: clusters || [],
    addresses: [],
    voucherCodes: [],
    imageUrl: imageUrl || null,
    originalPrice: null,
    collectionDeadline: null,
    deliveryStatus: null,
    fulfilmentInstructions: null,
    category: null,
    deliveryFee: 0,
    organizerSuccessRate: 1.0,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  batch.update(requestRef, {
    status: "approved",
    convertedGroupBuyId: groupBuyRef.id,
    reviewedAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  await batch.commit();

  logger.info(`Group buy request ${requestId} approved, created group buy ${groupBuyRef.id}`);
  return { requestId, groupBuyId: groupBuyRef.id };
}

/**
 * Execute voucher distribution after maker-checker approval.
 */
export async function executeDistributeGroupBuyVouchers(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { groupBuyId } = payload as { groupBuyId: string };

  const gbRef = db.collection("groupBuys").doc(groupBuyId);
  const gbDoc = await gbRef.get();
  if (!gbDoc.exists) {
    throw new Error("Group buy not found");
  }
  const gbData = gbDoc.data()!;

  if (gbData.status !== "completed") {
    throw new Error(`Group buy must be in "completed" status, currently "${gbData.status}"`);
  }

  if (!gbData.voucherCodes || gbData.voucherCodes.length === 0) {
    throw new Error("No voucher codes uploaded for this group buy");
  }

  const contribsSnap = await db.collection("groupBuys").doc(groupBuyId)
    .collection("contributions")
    .where("hasCollected", "!=", true)
    .get();

  // Filter to only eligible contributions (not refunded, with positive amount)
  const eligibleContribs = contribsSnap.docs.filter((doc) => {
    const data = doc.data();
    return data.status !== "refunded" && (data.amount > 0);
  });

  if (eligibleContribs.length === 0) {
    return { groupBuyId, distributed: 0, message: "No eligible contributions" };
  }

  if (gbData.voucherCodes.length < eligibleContribs.length) {
    throw new Error(`Not enough voucher codes (${gbData.voucherCodes.length}) for eligible contributions (${eligibleContribs.length})`);
  }

  const batch = db.batch();
  let distributed = 0;

  eligibleContribs.forEach((doc, index) => {
    batch.update(doc.ref, {
      voucherCode: gbData.voucherCodes[index],
      hasCollected: true,
      collectedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    distributed++;
  });

  await batch.commit();

  logger.info(`Distributed ${distributed} vouchers for group buy ${groupBuyId}`);
  return { groupBuyId, distributed };
}
