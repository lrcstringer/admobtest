/**
 * Marketplace Cloud Functions
 *
 * Consumer-facing functions for the Intengiso P2P marketplace.
 * Handles provider registration, listing creation, buying, fulfilment,
 * receipt confirmation, cancellation, disputes, vouching, and reporting.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import {
  processMarketplaceEscrow,
  releaseMarketplaceEscrow,
  refundMarketplaceEscrow,
} from "./ledger/marketplaceEscrow";
import { validateMainWalletBalance, getSubAccount } from "./ledger";
import { LedgerConfig } from "./ledger/types";

const db = admin.firestore();

// ============================================================================
// PROVIDER REGISTRATION
// ============================================================================

/**
 * Register as a marketplace provider.
 * Returns the new provider ID. Status starts as "pending" (admin approval).
 */
export const registerMarketplaceProvider = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "registerMarketplaceProvider");

    const userId = request.auth.uid;
    const { displayName, bio, servicesDescription, photoUrl, communityId } =
      request.data;

    if (!displayName || typeof displayName !== "string" || displayName.trim().length < 2) {
      throw new HttpsError("invalid-argument", "Display name must be at least 2 characters");
    }

    // Use userId as doc ID — deterministic, prevents duplicate registrations
    // even under concurrent requests (Firestore set will simply overwrite,
    // but we check existence first within a transaction-like pattern).
    const providerRef = db.collection("providers").doc(userId);
    const existingDoc = await providerRef.get();
    if (existingDoc.exists) {
      throw new HttpsError("already-exists", "You are already registered as a provider");
    }

    const now = admin.firestore.FieldValue.serverTimestamp();

    await providerRef.set({
      id: providerRef.id,
      userId,
      displayName: displayName.trim(),
      bio: bio?.trim() || null,
      servicesDescription: servicesDescription?.trim() || null,
      photoUrl: photoUrl || null,
      communityId: communityId || null,
      status: "pending",
      trustScore: 0,
      vouchCount: 0,
      completedOrders: 0,
      isVerified: false,
      isVerifiedOverride: null,
      customerIds: [],
      createdAt: now,
      updatedAt: now,
    });

    logger.info(`Provider registered: ${providerRef.id} by user ${userId}`);

    return { success: true, providerId: providerRef.id };
  }
);

// ============================================================================
// LISTING MANAGEMENT
// ============================================================================

/**
 * Create a marketplace listing.
 * Goes live immediately (no admin approval). Sets expiresAt = now + 90 days.
 */
export const createMarketplaceListing = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "createMarketplaceListing");

    const userId = request.auth.uid;
    const { title, description, category, subCategory, priceTokens, imageUrls, location } =
      request.data;

    // Validate required fields
    if (!title || typeof title !== "string" || title.trim().length < 3) {
      throw new HttpsError("invalid-argument", "Title must be at least 3 characters");
    }
    if (!description || typeof description !== "string") {
      throw new HttpsError("invalid-argument", "Description is required");
    }
    if (!category || typeof category !== "string") {
      throw new HttpsError("invalid-argument", "Category is required");
    }
    if (!priceTokens || typeof priceTokens !== "number" || priceTokens <= 0 || !Number.isInteger(priceTokens)) {
      throw new HttpsError("invalid-argument", "Price must be a positive integer");
    }

    // Verify user is an approved provider
    const providerSnap = await db
      .collection("providers")
      .where("userId", "==", userId)
      .where("status", "==", "approved")
      .limit(1)
      .get();
    if (providerSnap.empty) {
      throw new HttpsError(
        "permission-denied",
        "You must be an approved provider to create listings"
      );
    }
    const provider = providerSnap.docs[0].data();

    const listingRef = db.collection("marketplaceListings").doc();
    const now = admin.firestore.Timestamp.now();
    const expiresAt = admin.firestore.Timestamp.fromMillis(
      now.toMillis() + 90 * 24 * 60 * 60 * 1000
    );

    const priceZar = priceTokens / LedgerConfig.TOKENS_PER_ZAR;

    await listingRef.set({
      id: listingRef.id,
      title: title.trim(),
      description: description.trim(),
      category,
      subCategory: subCategory || null,
      priceTokens,
      priceZar,
      images: imageUrls || [],
      thumbnailUrl: imageUrls?.[0] || null,
      providerId: providerSnap.docs[0].id,
      providerName: provider.displayName,
      providerPhotoUrl: provider.photoUrl || null,
      providerTrustScore: provider.trustScore || 0,
      providerIsVerified: provider.isVerified || false,
      communityId: provider.communityId || null,
      location: location?.trim() || null,
      status: "active",
      viewCount: 0,
      reportCount: 0,
      expiresAt,
      createdAt: now,
      updatedAt: now,
    });

    logger.info(`Listing created: ${listingRef.id} by provider ${providerSnap.docs[0].id}`);

    return { success: true, listingId: listingRef.id };
  }
);

// ============================================================================
// ORDER LIFECYCLE
// ============================================================================

/**
 * Buy a marketplace item — creates order and escrows tokens.
 */
export const buyMarketplaceItem = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "buyMarketplaceItem");

    const userId = request.auth.uid;
    const { listingId, walletId } = request.data;

    if (!listingId) {
      throw new HttpsError("invalid-argument", "Listing ID is required");
    }

    // Get listing
    const listingDoc = await db.collection("marketplaceListings").doc(listingId).get();
    if (!listingDoc.exists) {
      throw new HttpsError("not-found", "Listing not found");
    }
    const listing = listingDoc.data()!;

    if (listing.status !== "active") {
      throw new HttpsError("failed-precondition", "This listing is no longer available");
    }

    // Get provider to find seller userId
    const providerDoc = await db.collection("providers").doc(listing.providerId).get();
    if (!providerDoc.exists) {
      throw new HttpsError("not-found", "Seller not found");
    }
    const provider = providerDoc.data()!;

    // Can't buy your own listing
    if (provider.userId === userId) {
      throw new HttpsError("failed-precondition", "You cannot buy your own listing");
    }

    // Validate balance
    if (walletId) {
      const subAccount = await getSubAccount(userId, walletId);
      if (!subAccount || subAccount.balance < listing.priceTokens) {
        throw new HttpsError("failed-precondition", "Insufficient balance");
      }
    } else {
      const balanceCheck = await validateMainWalletBalance(userId, listing.priceTokens);
      if (!balanceCheck.sufficient) {
        throw new HttpsError("failed-precondition", "Insufficient balance");
      }
    }

    // Get buyer name
    const buyerDoc = await db.collection("users").doc(userId).get();
    const buyerName = buyerDoc.data()?.displayName || "Unknown";

    // Create order with "pending" status — only set to "escrowed" after
    // escrow succeeds, preventing orphaned orders if escrow processing fails.
    const orderRef = db.collection("buyOrders").doc();
    const now = admin.firestore.FieldValue.serverTimestamp();

    await orderRef.set({
      id: orderRef.id,
      buyerId: userId,
      buyerName,
      sellerId: provider.userId,
      sellerName: provider.displayName,
      listingId,
      listingTitle: listing.title,
      amount: listing.priceTokens,
      amountZar: listing.priceZar,
      status: "pending",
      escrowJournalId: null,
      releaseJournalId: null,
      refundJournalId: null,
      disputeReason: null,
      disputeResolution: null,
      chatConversationId: null,
      thumbnailUrl: listing.thumbnailUrl || null,
      createdAt: now,
      escrowedAt: null,
      fulfilledAt: null,
      completedAt: null,
      disputedAt: null,
      resolvedAt: null,
      cancelledAt: null,
    });

    // Process escrow — if this fails, order stays "pending" (safe state)
    let journalId: string;
    try {
      journalId = await processMarketplaceEscrow(
        userId,
        listing.priceTokens,
        orderRef.id,
        `Marketplace purchase: ${listing.title}`
      );
    } catch (escrowError) {
      // Clean up the pending order so it doesn't linger
      await orderRef.update({
        status: "failed",
        cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      logger.error(`Escrow failed for order ${orderRef.id}`, escrowError);
      throw new HttpsError("internal", "Payment processing failed. Please try again.");
    }

    // Escrow succeeded — atomically mark order as escrowed
    await orderRef.update({
      status: "escrowed",
      escrowJournalId: journalId,
      escrowedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    logger.info(`Order ${orderRef.id} created, escrow journal ${journalId}`);

    return { success: true, orderId: orderRef.id };
  }
);

/**
 * Seller confirms fulfilment (e.g., item delivered/ready).
 */
export const confirmMarketplaceFulfilment = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "confirmMarketplaceFulfilment");

    const userId = request.auth.uid;
    const { orderId } = request.data;

    if (!orderId) {
      throw new HttpsError("invalid-argument", "Order ID is required");
    }

    const orderRef = db.collection("buyOrders").doc(orderId);

    // Use transaction to prevent concurrent status changes
    await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) {
        throw new HttpsError("not-found", "Order not found");
      }
      const order = orderDoc.data()!;

      if (order.sellerId !== userId) {
        throw new HttpsError("permission-denied", "Only the seller can mark as fulfilled");
      }
      if (order.status !== "escrowed") {
        throw new HttpsError("failed-precondition", "Order must be in escrow to mark as fulfilled");
      }

      tx.update(orderRef, {
        status: "fulfilled",
        fulfilledAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    logger.info(`Order ${orderId} marked fulfilled by seller ${userId}`);

    return { success: true };
  }
);

/**
 * Buyer confirms receipt — releases escrow to seller.
 */
export const confirmMarketplaceReceipt = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "confirmMarketplaceReceipt");

    const userId = request.auth.uid;
    const { orderId } = request.data;

    if (!orderId) {
      throw new HttpsError("invalid-argument", "Order ID is required");
    }

    const orderRef = db.collection("buyOrders").doc(orderId);

    // Use transaction to prevent TOCTOU race (concurrent receipt + cancel)
    const txResult = await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) {
        throw new HttpsError("not-found", "Order not found");
      }
      const order = orderDoc.data()!;

      if (order.buyerId !== userId) {
        throw new HttpsError("permission-denied", "Only the buyer can confirm receipt");
      }
      if (order.status !== "fulfilled") {
        throw new HttpsError("failed-precondition", "Seller must mark as fulfilled first");
      }

      tx.update(orderRef, {
        status: "completed",
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        sellerId: order.sellerId,
        amount: order.amount,
        listingTitle: order.listingTitle,
      };
    });

    // Release escrow outside transaction (ledger has its own idempotency).
    // If release fails, revert order status to "fulfilled" so it can be retried.
    let releaseJournalId: string;
    try {
      releaseJournalId = await releaseMarketplaceEscrow(
        txResult.sellerId,
        txResult.amount,
        orderId,
        `Marketplace payment released: ${txResult.listingTitle}`
      );
    } catch (releaseError) {
      logger.error(`Escrow release failed for order ${orderId}, reverting to fulfilled`, releaseError);
      await orderRef.update({
        status: "fulfilled",
        completedAt: null,
      });
      throw new HttpsError("internal", "Payment release failed. Please try again.");
    }

    // Update journal ID + increment provider completedOrders
    await orderRef.update({ releaseJournalId });

    const providerSnap = await db
      .collection("providers")
      .where("userId", "==", txResult.sellerId)
      .limit(1)
      .get();
    if (!providerSnap.empty) {
      await providerSnap.docs[0].ref.update({
        completedOrders: admin.firestore.FieldValue.increment(1),
      });
    }

    logger.info(`Order ${orderId} completed, escrow released, journal ${releaseJournalId}`);

    return { success: true };
  }
);

/**
 * Cancel a marketplace order — refunds escrow to buyer.
 * Only allowed before fulfilment (status: escrowed).
 */
export const cancelMarketplaceOrder = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "cancelMarketplaceOrder");

    const userId = request.auth.uid;
    const { orderId } = request.data;

    if (!orderId) {
      throw new HttpsError("invalid-argument", "Order ID is required");
    }

    const orderRef = db.collection("buyOrders").doc(orderId);

    // Use transaction to prevent TOCTOU race (concurrent cancel + receipt)
    const txResult = await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) {
        throw new HttpsError("not-found", "Order not found");
      }
      const order = orderDoc.data()!;

      // Either party can cancel before fulfilment
      if (order.buyerId !== userId && order.sellerId !== userId) {
        throw new HttpsError("permission-denied", "Only buyer or seller can cancel");
      }
      if (order.status !== "escrowed" && order.status !== "pending") {
        throw new HttpsError(
          "failed-precondition",
          "Only pending or escrowed orders can be cancelled"
        );
      }

      tx.update(orderRef, {
        status: "cancelled",
        cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        previousStatus: order.status as string,
        buyerId: order.buyerId,
        amount: order.amount,
        listingTitle: order.listingTitle,
      };
    });

    // Only refund escrow if tokens were actually escrowed.
    // "pending" orders never had escrow processed, so refunding would corrupt the ledger.
    if (txResult.previousStatus === "escrowed") {
      const refundJournalId = await refundMarketplaceEscrow(
        txResult.buyerId,
        txResult.amount,
        orderId,
        `Marketplace order cancelled: ${txResult.listingTitle}`
      );

      await orderRef.update({ refundJournalId });

      logger.info(`Order ${orderId} cancelled, refund journal ${refundJournalId}`);
    } else {
      logger.info(`Order ${orderId} cancelled (was pending, no escrow to refund)`);
    }

    return { success: true };
  }
);

// ============================================================================
// DISPUTES
// ============================================================================

/**
 * Raise a dispute on an active order.
 */
export const disputeMarketplaceOrder = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "disputeMarketplaceOrder");

    const userId = request.auth.uid;
    const { orderId, reason } = request.data;

    if (!orderId) {
      throw new HttpsError("invalid-argument", "Order ID is required");
    }
    if (!reason || typeof reason !== "string" || reason.trim().length < 10) {
      throw new HttpsError("invalid-argument", "Reason must be at least 10 characters");
    }

    const orderRef = db.collection("buyOrders").doc(orderId);

    // Use transaction to prevent concurrent dispute + receipt/cancel
    await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) {
        throw new HttpsError("not-found", "Order not found");
      }
      const order = orderDoc.data()!;

      if (order.buyerId !== userId && order.sellerId !== userId) {
        throw new HttpsError("permission-denied", "Only buyer or seller can raise a dispute");
      }
      if (order.status !== "escrowed" && order.status !== "fulfilled") {
        throw new HttpsError("failed-precondition", "Order must be active to dispute");
      }

      tx.update(orderRef, {
        status: "disputed",
        disputeReason: reason.trim(),
        disputedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    logger.info(`Order ${orderId} disputed by ${userId}: ${reason.trim().substring(0, 50)}`);

    return { success: true };
  }
);

// ============================================================================
// VOUCHING / SOCIAL PROOF
// ============================================================================

/**
 * Vouch for a provider after a completed order.
 */
export const vouchForProvider = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "vouchForProvider");

    const userId = request.auth.uid;
    const { providerId, orderId, rating, comment } = request.data;

    if (!providerId) {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }
    if (typeof rating !== "number" || rating < 1 || rating > 5) {
      throw new HttpsError("invalid-argument", "Rating must be between 1 and 5");
    }

    // Validate order exists and is completed (if orderId provided)
    if (orderId) {
      const orderDoc = await db.collection("buyOrders").doc(orderId).get();
      if (!orderDoc.exists) {
        throw new HttpsError("not-found", "Order not found");
      }
      const order = orderDoc.data()!;
      if (order.status !== "completed") {
        throw new HttpsError("failed-precondition", "Order must be completed to vouch");
      }
      if (order.buyerId !== userId) {
        throw new HttpsError("permission-denied", "Only the buyer can vouch for this order");
      }
    }

    // Use deterministic doc ID to prevent duplicate vouches at the Firestore level.
    // If orderId is provided, key on userId_orderId; otherwise userId_providerId.
    const vouchDocId = orderId ? `${userId}_${orderId}` : `${userId}_${providerId}`;
    const vouchRef = db.collection("vouches").doc(vouchDocId);

    // Check for existing vouch (deterministic ID makes this a simple get)
    const existingVouch = await vouchRef.get();
    if (existingVouch.exists) {
      throw new HttpsError("already-exists", "You already vouched for this order");
    }

    await vouchRef.set({
      id: vouchRef.id,
      voucherId: userId,
      providerId,
      orderId: orderId || null,
      rating,
      comment: comment?.trim() || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Recalculate provider trust score
    const allVouches = await db
      .collection("vouches")
      .where("providerId", "==", providerId)
      .get();

    const totalRating = allVouches.docs.reduce(
      (sum, doc) => sum + (doc.data().rating || 0),
      0
    );
    const vouchCount = allVouches.size;
    const trustScore = vouchCount > 0 ? totalRating / vouchCount : 0;
    const isVerified = vouchCount >= 5 && trustScore >= 4.0;

    const providerRef = db.collection("providers").doc(providerId);
    const providerDoc = await providerRef.get();
    if (providerDoc.exists) {
      const providerData = providerDoc.data()!;
      // Respect admin override
      const effectiveVerified =
        providerData.isVerifiedOverride !== null && providerData.isVerifiedOverride !== undefined
          ? providerData.isVerifiedOverride
          : isVerified;

      await providerRef.update({
        trustScore: Math.round(trustScore * 10) / 10,
        vouchCount,
        isVerified: effectiveVerified,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    logger.info(
      `Vouch ${vouchRef.id} for provider ${providerId}: rating ${rating}, ` +
        `new trust ${trustScore.toFixed(1)} (${vouchCount} vouches)`
    );

    return { success: true };
  }
);

// ============================================================================
// REPORTING
// ============================================================================

/**
 * Report a listing or provider.
 * Auto-flags listing if 3+ reports from different users.
 */
export const reportMarketplaceItem = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "reportMarketplaceItem");

    const userId = request.auth.uid;
    const { targetId, targetType, reason, description } = request.data;

    if (!targetId || !targetType || !reason) {
      throw new HttpsError("invalid-argument", "Target ID, type, and reason are required");
    }
    if (targetType !== "listing" && targetType !== "provider") {
      throw new HttpsError("invalid-argument", "Target type must be 'listing' or 'provider'");
    }

    // Rate limit: max 3 reports per user per day
    const todayStart = new Date();
    todayStart.setHours(0, 0, 0, 0);
    const recentReports = await db
      .collection("marketplaceReports")
      .where("reporterId", "==", userId)
      .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(todayStart))
      .get();
    if (recentReports.size >= 3) {
      throw new HttpsError(
        "resource-exhausted",
        "You can submit up to 3 reports per day"
      );
    }

    // Create report
    const reportRef = db.collection("marketplaceReports").doc();
    await reportRef.set({
      id: reportRef.id,
      reporterId: userId,
      targetId,
      targetType,
      reason,
      description: description?.trim() || null,
      status: "pending",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Increment report count and auto-flag if threshold reached
    if (targetType === "listing") {
      const listingRef = db.collection("marketplaceListings").doc(targetId);
      await listingRef.update({
        reportCount: admin.firestore.FieldValue.increment(1),
      });

      // Check if should auto-flag (3+ unique reporters)
      const allReports = await db
        .collection("marketplaceReports")
        .where("targetId", "==", targetId)
        .where("targetType", "==", "listing")
        .get();
      const uniqueReporters = new Set(allReports.docs.map((d) => d.data().reporterId));
      if (uniqueReporters.size >= 3) {
        await listingRef.update({ status: "flagged" });
        logger.warn(`Listing ${targetId} auto-flagged: ${uniqueReporters.size} unique reporters`);
      }
    }

    logger.info(`Report ${reportRef.id}: ${targetType} ${targetId} by ${userId}`);

    return { success: true };
  }
);

// ============================================================================
// SCHEDULED JOBS
// ============================================================================

/**
 * Daily job: expire listings older than 90 days.
 * Runs at 3:30 AM SAST.
 */
export const checkExpiredListings = onSchedule(
  {
    schedule: "30 3 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "marketplace" },
  },
  async () => {
    const now = admin.firestore.Timestamp.now();
    const expiredSnap = await db
      .collection("marketplaceListings")
      .where("status", "==", "active")
      .where("expiresAt", "<=", now)
      .limit(200)
      .get();

    if (expiredSnap.empty) {
      logger.info("No expired listings found");
      return;
    }

    const batch = db.batch();
    for (const doc of expiredSnap.docs) {
      batch.update(doc.ref, {
        status: "expired",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();

    logger.info(`Expired ${expiredSnap.size} listings`);
  }
);
