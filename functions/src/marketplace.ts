/**
 * Marketplace Cloud Functions
 *
 * Consumer-facing functions for the Intengiso P2P marketplace.
 * Handles provider registration, listing creation, buying, fulfilment,
 * receipt confirmation, cancellation, disputes, vouching, and reporting.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { onDocumentWritten } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import { requireAdminPermission } from "./adminAuth";
import {
  processMarketplaceEscrow,
  releaseMarketplaceEscrow,
  refundMarketplaceEscrow,
} from "./ledger/marketplaceEscrow";
import { validateMainWalletBalance, getSubAccount } from "./ledger";
import { LedgerConfig } from "./ledger/types";

const db = admin.firestore();

function requireAuth(request: { auth?: { uid: string } }): void {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
}

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

    // Use userId as doc ID — deterministic. Transaction prevents duplicate
    // registrations under concurrent requests.
    const providerRef = db.collection("providers").doc(userId);

    await db.runTransaction(async (tx) => {
      const existingDoc = await tx.get(providerRef);
      if (existingDoc.exists) {
        throw new HttpsError("already-exists", "You are already registered as a provider");
      }

      const now = admin.firestore.FieldValue.serverTimestamp();

      tx.set(providerRef, {
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
    const { title, description, category, subCategory, priceTokens, imageUrls, location,
      deliveryMethod, deliveryFee, serviceAreaType, locationData } =
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
    const providerId = providerSnap.docs[0].id;

    // Validate image URLs
    if (imageUrls && Array.isArray(imageUrls)) {
      for (const url of imageUrls) {
        if (typeof url !== "string" || (!url.startsWith("https://") && !url.startsWith("gs://"))) {
          throw new HttpsError("invalid-argument", "Image URLs must be valid HTTPS or GCS URLs");
        }
      }
    }

    const titleHash = title.trim().toLowerCase().replace(/[^a-z0-9]/g, "").substring(0, 20);
    const dateBucket = new Date().toISOString().split("T")[0];
    const listingRef = db.collection("marketplaceListings").doc(`${providerId}_${titleHash}_${dateBucket}`);
    const now = admin.firestore.Timestamp.now();
    const expiresAt = admin.firestore.Timestamp.fromMillis(
      now.toMillis() + 90 * 24 * 60 * 60 * 1000
    );

    const priceZar = Math.round((priceTokens / LedgerConfig.TOKENS_PER_ZAR) * 100) / 100;

    // Transaction to check doc doesn't already exist before setting
    await db.runTransaction(async (tx) => {
      const existingDoc = await tx.get(listingRef);
      if (existingDoc.exists) {
        throw new HttpsError("already-exists", "Listing ID collision — please try again");
      }

      tx.set(listingRef, {
        id: listingRef.id,
        title: title.trim(),
        description: description.trim(),
        category,
        subCategory: subCategory || null,
        priceTokens,
        priceZar,
        images: imageUrls || [],
        thumbnailUrl: imageUrls?.[0] || null,
        providerId,
        providerName: provider.displayName,
        providerPhotoUrl: provider.photoUrl || null,
        providerTrustScore: provider.trustScore || 0,
        providerIsVerified: provider.isVerified || false,
        communityId: provider.communityId || null,
        location: location?.trim() || null,
        deliveryMethod: deliveryMethod || null,
        deliveryFee: (typeof deliveryFee === "number" && deliveryFee >= 0) ? Math.floor(deliveryFee) : null,
        serviceAreaType: serviceAreaType || null,
        locationData: locationData || null,
        status: "active",
        viewCount: 0,
        reportCount: 0,
        expiresAt,
        createdAt: now,
        updatedAt: now,
      });
    });

    logger.info(`Listing created: ${listingRef.id} by provider ${providerId}`);

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

    // Pre-validate balance before entering the listing-reservation transaction
    if (walletId) {
      if (typeof walletId !== "string") {
        throw new HttpsError("invalid-argument", "Invalid wallet ID");
      }
      const subAccount = await getSubAccount(userId, walletId);
      if (!subAccount) {
        throw new HttpsError("not-found", "Wallet not found or does not belong to you");
      }
    } else {
      // Quick pre-check (authoritative check happens during escrow)
      const balanceCheck = await validateMainWalletBalance(userId, 0);
      if (!balanceCheck.sufficient && balanceCheck.available === 0) {
        throw new HttpsError("failed-precondition", "Insufficient balance");
      }
    }

    // Get buyer name
    const buyerDoc = await db.collection("users").doc(userId).get();
    const buyerName = buyerDoc.data()?.displayName || "Unknown";

    // Deterministic order ID: userId + listingId guarantees one active order per buyer per listing.
    const deterministicId = `${userId}_${listingId}`;
    const orderRef = db.collection("buyOrders").doc(deterministicId);
    const listingRef = db.collection("marketplaceListings").doc(listingId);

    // Transaction: atomically check listing is active, reserve it, and create order.
    // Prevents two concurrent buyers from both ordering the same single item.
    const txData = await db.runTransaction(async (tx) => {
      const [listingDoc, existingOrder] = await Promise.all([
        tx.get(listingRef),
        tx.get(orderRef),
      ]);

      if (!listingDoc.exists) {
        throw new HttpsError("not-found", "Listing not found");
      }
      const listing = listingDoc.data()!;

      if (listing.status !== "active") {
        throw new HttpsError("failed-precondition", "This listing is no longer available");
      }

      // Get provider (single read, reused for approval check and seller userId)
      const providerDoc = await tx.get(db.collection("providers").doc(listing.providerId));
      if (!providerDoc.exists) {
        throw new HttpsError("not-found", "Seller not found");
      }
      const provider = providerDoc.data()!;

      // Validate seller is an approved provider
      if (provider.status !== "approved") {
        throw new HttpsError("failed-precondition", "Seller is not an approved provider");
      }

      // If an order already exists for this buyer+listing, check its state
      if (existingOrder.exists) {
        const existingStatus = existingOrder.data()!.status;
        if (existingStatus === "escrowed" || existingStatus === "completed") {
          throw new HttpsError("already-exists", "You already have an active order for this listing");
        }
        // If previous order failed/cancelled, allow re-purchase by overwriting
      }

      if (provider.userId === userId) {
        throw new HttpsError("failed-precondition", "You cannot buy your own listing");
      }

      // Validate balance inside transaction
      if (walletId) {
        const subAccount = await getSubAccount(userId, walletId);
        if (!subAccount || subAccount.balance < listing.priceTokens) {
          throw new HttpsError("failed-precondition", "Insufficient balance");
        }
      } else {
        const mainCheck = await validateMainWalletBalance(userId, listing.priceTokens);
        if (!mainCheck.sufficient) {
          throw new HttpsError("failed-precondition", "Insufficient balance");
        }
      }

      const now = admin.firestore.FieldValue.serverTimestamp();

      // Reserve listing — mark as pending so no concurrent buyer can purchase
      tx.update(listingRef, {
        status: "pending",
        updatedAt: now,
      });

      // Create order
      tx.set(orderRef, {
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
        deliveryDeadline: admin.firestore.Timestamp.fromMillis(Date.now() + 7 * 24 * 60 * 60 * 1000),
        buyerConfirmationDeadline: admin.firestore.Timestamp.fromMillis(Date.now() + 14 * 24 * 60 * 60 * 1000),
        createdAt: now,
        escrowedAt: null,
        fulfilledAt: null,
        completedAt: null,
        disputedAt: null,
        resolvedAt: null,
        cancelledAt: null,
      });

      return {
        priceTokens: listing.priceTokens,
        title: listing.title,
      };
    });

    // Process escrow AFTER transaction succeeds — if escrow fails, revert listing + order
    let journalId: string;
    try {
      journalId = await processMarketplaceEscrow(
        userId,
        txData.priceTokens,
        orderRef.id,
        `Marketplace purchase: ${txData.title}`,
        `marketplace_escrow_${orderRef.id}`
      );
    } catch (escrowError) {
      // Revert: re-activate listing and mark order as failed
      await db.runTransaction(async (tx) => {
        tx.update(listingRef, {
          status: "active",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        tx.update(orderRef, {
          status: "failed",
          cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      });
      logger.error(`Escrow failed for order ${orderRef.id}`, escrowError);
      throw new HttpsError("internal", "Payment processing failed. Please try again.");
    }

    // Escrow succeeded — mark order as escrowed
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
        `Marketplace payment released: ${txResult.listingTitle}`,
        `marketplace_release_${orderId}`
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

      // Re-activate the listing so other buyers can purchase it
      const listingRef = db.collection("marketplaceListings").doc(order.listingId);
      const listingDoc = await tx.get(listingRef);
      if (listingDoc.exists && listingDoc.data()!.status === "pending") {
        tx.update(listingRef, { status: "active", updatedAt: admin.firestore.FieldValue.serverTimestamp() });
      }

      return {
        previousStatus: order.status as string,
        buyerId: order.buyerId,
        amount: order.amount,
        listingTitle: order.listingTitle,
        listingId: order.listingId,
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
    if (!orderId) {
      throw new HttpsError("invalid-argument", "orderId is required for vouching");
    }
    if (typeof rating !== "number" || rating < 1 || rating > 5) {
      throw new HttpsError("invalid-argument", "Rating must be between 1 and 5");
    }

    // Validate order exists and is completed
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

    // Use deterministic doc ID to prevent duplicate vouches at the Firestore level.
    const vouchDocId = `${userId}_${orderId}`;
    const vouchRef = db.collection("vouches").doc(vouchDocId);
    const providerRef = db.collection("providers").doc(providerId);

    // Single transaction: create vouch + recalculate trust score atomically.
    // Uses counter-based approach — the provider doc stores ratingSum and vouchCount,
    // which are incremented atomically. This avoids the stale-query race where
    // a non-transactional vouches query reads stale data.
    const txResult = await db.runTransaction(async (tx) => {
      const [existingVouch, providerDoc] = await Promise.all([
        tx.get(vouchRef),
        tx.get(providerRef),
      ]);

      if (existingVouch.exists) {
        throw new HttpsError("already-exists", "You already vouched for this order");
      }
      if (!providerDoc.exists) {
        throw new HttpsError("not-found", "Provider not found");
      }

      // Look up voucher's user profile for display info
      const voucherProfileDoc = await tx.get(db.collection("users").doc(userId));
      const voucherProfile = voucherProfileDoc.data();

      // Create vouch doc
      tx.set(vouchRef, {
        id: vouchRef.id,
        voucherId: userId,
        voucherName: voucherProfile?.displayName || "",
        voucherPhotoUrl: voucherProfile?.photoUrl || null,
        providerId,
        orderId: orderId || null,
        rating,
        comment: comment?.trim() || null,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Use counter-based trust score: increment ratingSum + vouchCount atomically
      const providerData = providerDoc.data()!;
      const oldRatingSum = providerData.ratingSum || 0;
      const oldVouchCount = providerData.vouchCount || 0;
      const newRatingSum = oldRatingSum + rating;
      const newVouchCount = oldVouchCount + 1;
      const newTrustScore = newVouchCount > 0 ? newRatingSum / newVouchCount : 0;
      const isVerified = newVouchCount >= 5 && newTrustScore >= 4.0;

      const effectiveVerified =
        providerData.isVerifiedOverride !== null && providerData.isVerifiedOverride !== undefined
          ? providerData.isVerifiedOverride
          : isVerified;

      tx.update(providerRef, {
        ratingSum: newRatingSum,
        vouchCount: newVouchCount,
        trustScore: Math.round(newTrustScore * 10) / 10,
        isVerified: effectiveVerified,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return { trustScore: newTrustScore, vouchCount: newVouchCount };
    });

    logger.info(
      `Vouch ${vouchRef.id} for provider ${providerId}: rating ${rating}, ` +
        `new trust ${txResult.trustScore.toFixed(1)} (${txResult.vouchCount} vouches)`
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

    // Rate limit: max 3 reports per user per day (UTC midnight boundary)
    const todayStart = new Date();
    todayStart.setUTCHours(0, 0, 0, 0);
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

    // Deterministic report ID prevents duplicate reports on retry.
    // Wrapped in a transaction for safety — the deterministic ID prevents true dupes,
    // but the transaction ensures the existence check and set are atomic.
    const reportDocId = `${userId}_${targetId}_${targetType}`;
    const reportRef = db.collection("marketplaceReports").doc(reportDocId);
    await db.runTransaction(async (tx) => {
      const existingReport = await tx.get(reportRef);
      if (existingReport.exists) {
        throw new HttpsError("already-exists", "You have already reported this item");
      }

      tx.set(reportRef, {
        id: reportRef.id,
        reporterId: userId,
        targetId,
        targetType,
        reason,
        description: description?.trim() || null,
        status: "pending",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    // Increment report count and auto-flag if threshold reached (transaction)
    if (targetType === "listing") {
      const listingRef = db.collection("marketplaceListings").doc(targetId);
      await db.runTransaction(async (tx) => {
        const listingDoc = await tx.get(listingRef);
        if (!listingDoc.exists) return;

        const currentCount = (listingDoc.data()!.reportCount || 0) + 1;
        tx.update(listingRef, {
          reportCount: currentCount,
        });

        // Auto-flag at 3+ unique reporters
        if (currentCount >= 3 && listingDoc.data()!.status === "active") {
          tx.update(listingRef, { status: "flagged" });
          logger.warn(`Listing ${targetId} auto-flagged: ${currentCount} reports`);
        }
      });
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

// ============================================================================
// LISTING MANAGEMENT
// ============================================================================

/**
 * Update an existing marketplace listing.
 * Only the owning provider can update. Cannot update removed/flagged listings.
 */
export const updateMarketplaceListing = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "updateMarketplaceListing");

    const userId = request.auth.uid;
    const { listingId, title, description, category, subCategory, priceTokens, imageUrls, location,
      deliveryMethod, deliveryFee, serviceAreaType, locationData } =
      request.data;

    if (!listingId || typeof listingId !== "string") {
      throw new HttpsError("invalid-argument", "Listing ID is required");
    }

    const listingRef = db.collection("marketplaceListings").doc(listingId);
    const listingDoc = await listingRef.get();
    if (!listingDoc.exists) {
      throw new HttpsError("not-found", "Listing not found");
    }
    const listing = listingDoc.data()!;

    // Verify ownership via provider
    const providerDoc = await db.collection("providers").doc(listing.providerId).get();
    if (!providerDoc.exists || providerDoc.data()!.userId !== userId) {
      throw new HttpsError("permission-denied", "Only the listing owner can update it");
    }

    // Cannot update terminal-status listings
    const terminalStatuses = ["removed", "flagged", "sold"];
    if (terminalStatuses.includes(listing.status)) {
      throw new HttpsError("failed-precondition", `Cannot update a ${listing.status} listing`);
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    if (title !== undefined) {
      if (typeof title !== "string" || title.trim().length < 3) {
        throw new HttpsError("invalid-argument", "Title must be at least 3 characters");
      }
      updates.title = title.trim();
    }
    if (description !== undefined) {
      if (typeof description !== "string") {
        throw new HttpsError("invalid-argument", "Description must be a string");
      }
      updates.description = description.trim();
    }
    if (category !== undefined) {
      if (typeof category !== "string") {
        throw new HttpsError("invalid-argument", "Category must be a string");
      }
      updates.category = category;
    }
    if (subCategory !== undefined) {
      updates.subCategory = subCategory || null;
    }
    if (priceTokens !== undefined) {
      if (typeof priceTokens !== "number" || priceTokens <= 0 || !Number.isInteger(priceTokens)) {
        throw new HttpsError("invalid-argument", "Price must be a positive integer");
      }
      updates.priceTokens = priceTokens;
      updates.priceZar = Math.round((priceTokens / LedgerConfig.TOKENS_PER_ZAR) * 100) / 100;
    }
    if (imageUrls !== undefined) {
      if (!Array.isArray(imageUrls)) {
        throw new HttpsError("invalid-argument", "imageUrls must be an array");
      }
      updates.images = imageUrls;
      updates.thumbnailUrl = imageUrls[0] || null;
    }
    if (location !== undefined) {
      updates.location = location?.trim() || null;
    }
    if (deliveryMethod !== undefined) {
      updates.deliveryMethod = deliveryMethod || null;
    }
    if (deliveryFee !== undefined) {
      updates.deliveryFee = (typeof deliveryFee === "number" && deliveryFee >= 0) ? Math.floor(deliveryFee) : null;
    }
    if (serviceAreaType !== undefined) {
      updates.serviceAreaType = serviceAreaType || null;
    }
    if (locationData !== undefined) {
      updates.locationData = locationData || null;
    }

    await listingRef.update(updates);

    logger.info(`Listing ${listingId} updated by ${userId}`);
    return { success: true };
  }
);

/**
 * Toggle listing status (pause/unpause/mark sold).
 * Sellers can pause/unpause/mark-sold their own active listings.
 */
export const toggleMarketplaceListingStatus = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "toggleMarketplaceListingStatus");

    const userId = request.auth.uid;
    const { listingId, action } = request.data;

    if (!listingId || typeof listingId !== "string") {
      throw new HttpsError("invalid-argument", "Listing ID is required");
    }
    const validActions = ["pause", "unpause", "markSold"];
    if (!validActions.includes(action)) {
      throw new HttpsError("invalid-argument", `Action must be one of: ${validActions.join(", ")}`);
    }

    const listingRef = db.collection("marketplaceListings").doc(listingId);

    await db.runTransaction(async (tx) => {
      const listingDoc = await tx.get(listingRef);
      if (!listingDoc.exists) {
        throw new HttpsError("not-found", "Listing not found");
      }
      const listing = listingDoc.data()!;

      // Verify ownership
      const providerDoc = await tx.get(db.collection("providers").doc(listing.providerId));
      if (!providerDoc.exists || providerDoc.data()!.userId !== userId) {
        throw new HttpsError("permission-denied", "Only the listing owner can change status");
      }

      const currentStatus = listing.status as string;
      const actionToStatus: Record<string, string> = {
        pause: "paused",
        unpause: "active",
        markSold: "sold",
      };
      const newStatus = actionToStatus[action];
      const validTransitions: Record<string, string[]> = {
        active: ["paused", "sold"],
        paused: ["active", "sold"],
      };
      if (!validTransitions[currentStatus]?.includes(newStatus)) {
        throw new HttpsError("failed-precondition", `Cannot transition from ${currentStatus} to ${newStatus}`);
      }

      const now = admin.firestore.FieldValue.serverTimestamp();

      if (action === "pause") {
        if (listing.status !== "active") {
          throw new HttpsError("failed-precondition", "Only active listings can be paused");
        }
        tx.update(listingRef, { status: "paused", pausedAt: now, updatedAt: now });
      } else if (action === "unpause") {
        if (listing.status !== "paused") {
          throw new HttpsError("failed-precondition", "Only paused listings can be unpaused");
        }
        // Track total paused days
        const pausedAt = listing.pausedAt?.toDate();
        let totalPausedDays = listing.totalPausedDays || 0;
        if (pausedAt) {
          totalPausedDays += Math.ceil((Date.now() - pausedAt.getTime()) / (86400000));
        }
        tx.update(listingRef, {
          status: "active",
          pausedAt: null,
          totalPausedDays,
          updatedAt: now,
        });
      } else if (action === "markSold") {
        if (!["active", "paused"].includes(listing.status)) {
          throw new HttpsError("failed-precondition", "Listing must be active or paused to mark as sold");
        }
        tx.update(listingRef, { status: "sold", updatedAt: now });
      }
    });

    logger.info(`Listing ${listingId} action=${action} by ${userId}`);
    return { success: true };
  }
);

/**
 * Renew an expired listing for another 90 days.
 * Resets expiresAt, increments renewalCount.
 */
export const renewMarketplaceListing = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "renewMarketplaceListing");

    const userId = request.auth.uid;
    const { listingId } = request.data;

    if (!listingId || typeof listingId !== "string") {
      throw new HttpsError("invalid-argument", "Listing ID is required");
    }

    const listingRef = db.collection("marketplaceListings").doc(listingId);

    // Transaction: atomic read + status check + update prevents TOCTOU race
    await db.runTransaction(async (tx) => {
      const listingDoc = await tx.get(listingRef);
      if (!listingDoc.exists) {
        throw new HttpsError("not-found", "Listing not found");
      }
      const listing = listingDoc.data()!;

      // Verify ownership
      const providerDoc = await tx.get(db.collection("providers").doc(listing.providerId));
      if (!providerDoc.exists || providerDoc.data()!.userId !== userId) {
        throw new HttpsError("permission-denied", "Only the listing owner can renew it");
      }

      if (listing.status !== "expired") {
        throw new HttpsError("failed-precondition", "Only expired listings can be renewed");
      }

      const now = admin.firestore.Timestamp.now();
      const newExpiry = admin.firestore.Timestamp.fromMillis(
        now.toMillis() + 90 * 24 * 60 * 60 * 1000
      );

      const renewalExpiresAt = admin.firestore.Timestamp.fromMillis(
        now.toMillis() + 30 * 24 * 60 * 60 * 1000
      );

      tx.update(listingRef, {
        status: "active",
        expiresAt: newExpiry,
        renewalExpiresAt,
        renewalCount: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    logger.info(`Listing ${listingId} renewed by ${userId}`);
    return { success: true };
  }
);

// ============================================================================
// SELLER DASHBOARD
// ============================================================================

/**
 * Get seller dashboard analytics (orders, revenue, rating summary).
 */
export const getSellerDashboard = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "getSellerDashboard");

    const userId = request.auth.uid;

    // Find provider by userId
    const providerSnap = await db
      .collection("providers")
      .where("userId", "==", userId)
      .limit(1)
      .get();
    if (providerSnap.empty) {
      throw new HttpsError("not-found", "Provider profile not found");
    }
    const providerId = providerSnap.docs[0].id;
    const provider = providerSnap.docs[0].data();

    // Count listings by status
    const listingsSnap = await db
      .collection("marketplaceListings")
      .where("providerId", "==", providerId)
      .get();

    const listingCounts: Record<string, number> = {};
    for (const doc of listingsSnap.docs) {
      const status = doc.data().status || "unknown";
      listingCounts[status] = (listingCounts[status] || 0) + 1;
    }

    // Count orders by status (as seller)
    const ordersSnap = await db
      .collection("buyOrders")
      .where("sellerId", "==", userId)
      .get();

    let totalRevenue = 0;
    let completedOrders = 0;
    let pendingOrders = 0;
    let disputedOrders = 0;
    for (const doc of ordersSnap.docs) {
      const order = doc.data();
      if (order.status === "completed") {
        totalRevenue += order.amount || 0;
        completedOrders++;
      } else if (["escrowed", "fulfilled"].includes(order.status)) {
        pendingOrders++;
      } else if (order.status === "disputed") {
        disputedOrders++;
      }
    }

    return {
      success: true,
      dashboard: {
        providerId,
        displayName: provider.displayName,
        trustScore: provider.trustScore || 0,
        vouchCount: provider.vouchCount || 0,
        isVerified: provider.isVerified || false,
        sellerLevel: provider.sellerLevel || "bronze",
        totalListings: listingsSnap.size,
        listingCounts,
        totalRevenue,
        completedOrders,
        pendingOrders,
        disputedOrders,
        totalOrders: ordersSnap.size,
      },
    };
  }
);

// ============================================================================
// OFFERS
// ============================================================================

/**
 * Make an offer on a listing (price negotiation).
 * Creates an offer doc with status "pending".
 */
export const makeOffer = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "makeOffer");

    const userId = request.auth.uid;
    const { listingId, offerAmount, message } = request.data;

    if (!listingId || typeof listingId !== "string") {
      throw new HttpsError("invalid-argument", "Listing ID is required");
    }
    if (!offerAmount || typeof offerAmount !== "number" || offerAmount <= 0 || !Number.isInteger(offerAmount)) {
      throw new HttpsError("invalid-argument", "Offer amount must be a positive integer");
    }

    // Rate limit: max 20 offers per user per day
    const today = new Date().toISOString().split("T")[0];
    const recentOffers = await db.collection("marketplaceOffers")
      .where("buyerId", "==", userId)
      .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(new Date(today)))
      .limit(20)
      .get();
    if (recentOffers.size >= 20) {
      throw new HttpsError("resource-exhausted", "Maximum 20 offers per day. Please try again tomorrow.");
    }

    const listingDoc = await db.collection("marketplaceListings").doc(listingId).get();
    if (!listingDoc.exists) {
      throw new HttpsError("not-found", "Listing not found");
    }
    const listing = listingDoc.data()!;

    if (listing.status !== "active") {
      throw new HttpsError("failed-precondition", "Listing is not active");
    }

    // Can't offer on your own listing
    const providerDoc = await db.collection("providers").doc(listing.providerId).get();
    if (providerDoc.exists && providerDoc.data()!.userId === userId) {
      throw new HttpsError("invalid-argument", "You cannot make an offer on your own listing");
    }

    // Offer amount must be less than listing price (use Buy Now for full price)
    if (offerAmount >= listing.priceTokens) {
      throw new HttpsError("invalid-argument", "Offer amount must be less than the listing price. Use Buy Now for full price purchases.");
    }

    // Validate balance
    const balanceCheck = await validateMainWalletBalance(userId, offerAmount);
    if (!balanceCheck.sufficient) {
      throw new HttpsError("failed-precondition", "Insufficient balance for this offer");
    }

    const buyerDoc = await db.collection("users").doc(userId).get();
    const buyerName = buyerDoc.data()?.displayName || "Unknown";

    // Deterministic ID prevents duplicate offers from same user on same listing
    const offerRef = db.collection("marketplaceOffers").doc(`${userId}_${listingId}`);
    const expiresAt = admin.firestore.Timestamp.fromMillis(
      Date.now() + 48 * 60 * 60 * 1000 // 48 hours
    );

    // Transaction: check for existing pending offer + create atomically
    await db.runTransaction(async (tx) => {
      const existingOffer = await tx.get(offerRef);
      if (existingOffer.exists && existingOffer.data()!.status === "pending") {
        throw new HttpsError("already-exists", "You already have a pending offer on this listing");
      }

      tx.set(offerRef, {
        id: offerRef.id,
        listingId,
        listingTitle: listing.title,
        buyerId: userId,
        buyerName,
        sellerId: providerDoc.exists ? providerDoc.data()!.userId : null,
        offerAmount,
        offerZar: offerAmount / LedgerConfig.TOKENS_PER_ZAR,
        originalPrice: listing.priceTokens,
        message: message?.trim() || null,
        status: "pending",
        expiresAt,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        respondedAt: null,
      });
    });

    logger.info(`Offer ${offerRef.id} made on listing ${listingId} by ${userId}: ${offerAmount} tokens`);
    return { success: true, offerId: offerRef.id };
  }
);

/**
 * Respond to an offer (accept/decline/counter).
 * If accepted, creates an order at the offer price and escrows tokens.
 */
export const respondToOffer = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "respondToOffer");

    const userId = request.auth.uid;
    const { offerId, action, counterAmount } = request.data;

    if (!offerId || typeof offerId !== "string") {
      throw new HttpsError("invalid-argument", "Offer ID is required");
    }
    const validActions = ["accept", "decline", "counter"];
    if (!validActions.includes(action)) {
      throw new HttpsError("invalid-argument", `Action must be one of: ${validActions.join(", ")}`);
    }

    const offerRef = db.collection("marketplaceOffers").doc(offerId);

    // Use transaction to prevent race conditions on concurrent responses
    const result = await db.runTransaction(async (tx) => {
      const offerDoc = await tx.get(offerRef);
      if (!offerDoc.exists) {
        throw new HttpsError("not-found", "Offer not found");
      }
      const offer = offerDoc.data()!;

      if (offer.sellerId !== userId) {
        throw new HttpsError("permission-denied", "Only the seller can respond to this offer");
      }
      if (offer.status !== "pending") {
        throw new HttpsError("failed-precondition", "This offer is no longer pending");
      }

      // Check expiry
      const expiresAt = offer.expiresAt?.toDate();
      if (expiresAt && expiresAt.getTime() < Date.now()) {
        tx.update(offerRef, { status: "expired" });
        throw new HttpsError("failed-precondition", "This offer has expired");
      }

      const now = admin.firestore.FieldValue.serverTimestamp();

      if (action === "decline") {
        tx.update(offerRef, { status: "declined", respondedAt: now });
        return { orderId: null };
      }

      if (action === "counter") {
        if (!counterAmount || typeof counterAmount !== "number" || counterAmount <= 0) {
          throw new HttpsError("invalid-argument", "Counter amount must be a positive integer");
        }
        // Read listing to enforce upper bound on counter offers
        const listingDoc = await tx.get(db.collection("marketplaceListings").doc(offer.listingId));
        const listingPrice = listingDoc.exists ? listingDoc.data()!.priceTokens : offer.originalPrice;
        if (counterAmount > listingPrice) {
          throw new HttpsError("invalid-argument", "Counter offer cannot exceed listing price");
        }
        tx.update(offerRef, {
          status: "countered",
          counterAmount,
          counterZar: counterAmount / LedgerConfig.TOKENS_PER_ZAR,
          respondedAt: now,
        });
        return { orderId: null };
      }

      // action === "accept"
      // Verify listing is still active
      const listingDoc = await tx.get(db.collection("marketplaceListings").doc(offer.listingId));
      if (!listingDoc.exists || listingDoc.data()!.status !== "active") {
        tx.update(offerRef, { status: "declined", respondedAt: now });
        throw new HttpsError("failed-precondition", "Listing is no longer available");
      }

      tx.update(offerRef, { status: "accepted", respondedAt: now });

      // Mark listing as pending so no concurrent buyer can purchase
      const listingRef = db.collection("marketplaceListings").doc(offer.listingId);
      tx.update(listingRef, { status: "pending" });

      // Create order at offer price (escrow done outside transaction)
      // Deterministic ID: retries reuse the same order doc instead of creating duplicates
      const orderRef = db.collection("buyOrders").doc(`offer_${offerRef.id}`);
      tx.set(orderRef, {
        id: orderRef.id,
        buyerId: offer.buyerId,
        buyerName: offer.buyerName,
        sellerId: userId,
        sellerName: listingDoc.data()!.providerName || "",
        listingId: offer.listingId,
        listingTitle: offer.listingTitle,
        amount: offer.offerAmount,
        amountZar: offer.offerZar,
        status: "pending",
        offerId: offerRef.id,
        escrowJournalId: null,
        releaseJournalId: null,
        refundJournalId: null,
        refundType: null,
        deliveryMethod: null,
        deliveryFee: 0,
        disputeReason: null,
        disputeResolution: null,
        chatConversationId: null,
        thumbnailUrl: listingDoc.data()!.thumbnailUrl || null,
        deliveryDeadline: admin.firestore.Timestamp.fromMillis(Date.now() + 7 * 24 * 60 * 60 * 1000),
        buyerConfirmationDeadline: admin.firestore.Timestamp.fromMillis(Date.now() + 14 * 24 * 60 * 60 * 1000),
        createdAt: now,
        escrowedAt: null,
        fulfilledAt: null,
        completedAt: null,
        disputedAt: null,
        resolvedAt: null,
        cancelledAt: null,
      });

      return { orderId: orderRef.id };
    });

    // If accepted, process escrow outside the transaction.
    // On failure, revert BOTH order and offer so the flow can be retried.
    if (result.orderId) {
      const offerDoc = await offerRef.get();
      const offer = offerDoc.data()!;
      const orderRef = db.collection("buyOrders").doc(result.orderId);
      try {
        const journalId = await processMarketplaceEscrow(
          offer.buyerId,
          offer.offerAmount,
          result.orderId,
          `Marketplace offer accepted: ${offer.listingTitle}`,
          `offer_escrow_${orderRef.id}`
        );
        await orderRef.update({
          status: "escrowed",
          escrowJournalId: journalId,
          escrowedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch (escrowError) {
        // Revert both order AND offer so seller can retry
        const revertBatch = db.batch();
        revertBatch.update(orderRef, {
          status: "failed",
          cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        revertBatch.update(offerRef, {
          status: "pending",
          respondedAt: null,
        });
        revertBatch.update(db.collection("marketplaceListings").doc(offer.listingId), {
          status: "active",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        await revertBatch.commit();
        logger.error(`Escrow failed for offer-order ${result.orderId}, reverted offer to pending`, escrowError);
        throw new HttpsError("internal", "Payment processing failed. Please try again.");
      }
    }

    logger.info(`Offer ${offerId} responded with action=${action}`);
    return { success: true, orderId: result.orderId };
  }
);

// ============================================================================
// SELLER-INITIATED REFUND
// ============================================================================

/**
 * Seller initiates a refund for an order.
 * Can only refund escrowed or fulfilled orders.
 */
export const sellerInitiatedRefund = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "sellerInitiatedRefund");

    const userId = request.auth.uid;
    const { orderId, reason } = request.data;

    if (!orderId || typeof orderId !== "string") {
      throw new HttpsError("invalid-argument", "Order ID is required");
    }

    const orderRef = db.collection("buyOrders").doc(orderId);

    // Use transaction to prevent race conditions
    const orderData = await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) {
        throw new HttpsError("not-found", "Order not found");
      }
      const order = orderDoc.data()!;

      if (order.sellerId !== userId) {
        throw new HttpsError("permission-denied", "Only the seller can initiate a refund");
      }

      const refundableStatuses = ["escrowed", "fulfilled"];
      if (!refundableStatuses.includes(order.status)) {
        throw new HttpsError(
          "failed-precondition",
          `Cannot refund an order with status: ${order.status}`
        );
      }

      tx.update(orderRef, {
        status: "refunding",
        refundType: "seller_initiated",
        disputeReason: reason?.trim() || "Seller initiated refund",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return order;
    });

    // Process refund outside transaction
    try {
      const journalId = await refundMarketplaceEscrow(
        orderData.buyerId,
        orderData.amount,
        orderId,
        `Seller-initiated refund: ${orderData.listingTitle}`,
        `seller_refund_${orderId}`
      );
      await orderRef.update({
        status: "refunded",
        refundJournalId: journalId,
        refundedAt: admin.firestore.FieldValue.serverTimestamp(),
        cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    } catch (refundError) {
      // Revert to previous status so manual intervention can occur
      await orderRef.update({
        status: orderData.status,
        refundType: null,
        disputeReason: null,
      });
      logger.error(`Seller refund failed for order ${orderId}`, refundError);
      throw new HttpsError("internal", "Refund processing failed. Please try again.");
    }

    logger.info(`Order ${orderId} refunded by seller ${userId}`);
    return { success: true };
  }
);

// ============================================================================
// AUTO-MODERATION: SUSPEND PROVIDER CASCADE
// ============================================================================

/**
 * Suspend a provider and cascade: pause all their active listings.
 * Triggered when provider reaches warning thresholds.
 * Can be called by admin CFs or by automated threshold checks.
 */
export const suspendProviderCascade = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "suspendProviderCascade");

    // Admin-only operation — prevents any authenticated user from suspending providers
    await requireAdminPermission(
      request,
      "buy:suspendProvider",
      "suspendProviderCascade"
    );

    const { providerId, reason, trigger } = request.data;

    if (!providerId || typeof providerId !== "string") {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }

    const providerRef = db.collection("providers").doc(providerId);
    const providerDoc = await providerRef.get();
    if (!providerDoc.exists) {
      throw new HttpsError("not-found", "Provider not found");
    }
    const provider = providerDoc.data()!;

    if (provider.status === "suspended" || provider.status === "banned") {
      return { success: true, message: "Provider is already suspended or banned" };
    }

    // Suspend provider
    await providerRef.update({
      status: "suspended",
      suspensionReason: reason || "Auto-moderation threshold exceeded",
      suspensionTrigger: trigger || "manual",
      suspendedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Cascade: pause all active listings
    const listingsSnap = await db
      .collection("marketplaceListings")
      .where("providerId", "==", providerId)
      .where("status", "==", "active")
      .get();

    if (!listingsSnap.empty) {
      const batch = db.batch();
      for (const doc of listingsSnap.docs) {
        batch.update(doc.ref, {
          status: "paused",
          pausedAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    }

    logger.info(
      `Provider ${providerId} suspended (${trigger || "manual"}), ${listingsSnap.size} listings paused`
    );

    return { success: true, listingsPaused: listingsSnap.size };
  }
);

// ============================================================================
// FAVOURITES TRIGGER
// ============================================================================

/**
 * Firestore trigger: when a savedListing doc is written, update favouriteCount.
 */
export const onFavouriteWrite = onDocumentWritten(
  { document: "savedListings/{docId}", labels: { area: "marketplace" } },
  async (event) => {
    const beforeData = event.data?.before?.data();
    const afterData = event.data?.after?.data();

    // Determine which listing was affected
    const listingId = afterData?.listingId || beforeData?.listingId;
    if (!listingId) return;

    // Count total saved listings for this listing
    const countSnap = await db
      .collection("savedListings")
      .where("listingId", "==", listingId)
      .count()
      .get();

    const favouriteCount = countSnap.data().count;

    await db.collection("marketplaceListings").doc(listingId).update({
      favouriteCount,
    });

    logger.info(`Listing ${listingId} favouriteCount updated to ${favouriteCount}`);
  }
);

// ============================================================================
// SCHEDULED JOBS
// ============================================================================

/**
 * Check delivery timers — auto-complete orders where delivery deadline has passed
 * and buyer hasn't disputed.
 * Runs every 4 hours.
 */
export const checkDeliveryTimers = onSchedule(
  {
    schedule: "0 */4 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "marketplace" },
  },
  async () => {
    const now = admin.firestore.Timestamp.now();

    // Find fulfilled orders past delivery deadline where buyer hasn't confirmed
    const overdueOrders = await db
      .collection("buyOrders")
      .where("status", "==", "fulfilled")
      .where("deliveryDeadline", "<=", now)
      .limit(100)
      .get();

    if (overdueOrders.empty) {
      logger.info("No overdue delivery orders found");
      return;
    }

    let released = 0;
    let skipped = 0;
    for (const doc of overdueOrders.docs) {
      const order = doc.data();
      // Guard: skip if already completed
      if (order.status === "completed" || order.completedAt) {
        skipped++;
        continue;
      }
      // Guard: skip if escrow was never processed or already released
      if (!order.escrowJournalId || order.releaseJournalId) {
        skipped++;
        continue;
      }
      try {
        const journalId = await releaseMarketplaceEscrow(
          order.sellerId,
          order.amount,
          doc.id,
          `Auto-release: delivery deadline passed for ${order.listingTitle}`
        );
        await doc.ref.update({
          status: "completed",
          releaseJournalId: journalId,
          completedAt: admin.firestore.FieldValue.serverTimestamp(),
          autoCompleted: true,
        });
        released++;
      } catch (err) {
        logger.error(`Failed to auto-release order ${doc.id}`, err);
      }
    }

    logger.info(`Auto-released ${released}/${overdueOrders.size} overdue orders (${skipped} skipped)`);
  }
);

/**
 * Check buyer confirmation windows — auto-complete orders where buyer hasn't
 * confirmed receipt within the confirmation window (e.g., 72 hours after fulfilment).
 * Runs every 6 hours.
 */
export const checkBuyerConfirmationWindows = onSchedule(
  {
    schedule: "0 */6 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "marketplace" },
  },
  async () => {
    const now = admin.firestore.Timestamp.now();

    const staleOrders = await db
      .collection("buyOrders")
      .where("status", "==", "fulfilled")
      .where("buyerConfirmationDeadline", "<=", now)
      .limit(100)
      .get();

    if (staleOrders.empty) {
      logger.info("No stale confirmation orders found");
      return;
    }

    let released = 0;
    let skipped = 0;
    for (const doc of staleOrders.docs) {
      const order = doc.data();
      // Guard: skip if escrow was never processed or already released
      if (!order.escrowJournalId || order.releaseJournalId) {
        skipped++;
        continue;
      }
      try {
        const journalId = await releaseMarketplaceEscrow(
          order.sellerId,
          order.amount,
          doc.id,
          `Auto-release: buyer confirmation window expired for ${order.listingTitle}`
        );
        await doc.ref.update({
          status: "completed",
          releaseJournalId: journalId,
          completedAt: admin.firestore.FieldValue.serverTimestamp(),
          autoCompleted: true,
        });
        released++;
      } catch (err) {
        logger.error(`Failed to auto-complete order ${doc.id}`, err);
      }
    }

    logger.info(`Auto-completed ${released}/${staleOrders.size} stale confirmation orders (${skipped} skipped)`);
  }
);

/**
 * Auto-refund orders where the seller hasn't responded (fulfilled) within
 * the fulfilment window (default 7 days).
 * Runs daily at 4:00 AM SAST.
 */
export const autoRefundUnresponsiveSeller = onSchedule(
  {
    schedule: "0 4 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "marketplace" },
  },
  async () => {
    const sevenDaysAgo = admin.firestore.Timestamp.fromMillis(
      Date.now() - 7 * 24 * 60 * 60 * 1000
    );

    // Find escrowed orders older than 7 days with no fulfilment
    const staleOrders = await db
      .collection("buyOrders")
      .where("status", "==", "escrowed")
      .where("escrowedAt", "<=", sevenDaysAgo)
      .limit(100)
      .get();

    if (staleOrders.empty) {
      logger.info("No unresponsive seller orders found");
      return;
    }

    let refunded = 0;
    let skipped = 0;
    for (const doc of staleOrders.docs) {
      const order = doc.data();
      // Guard: skip if already refunded
      if (order.refundJournalId) {
        skipped++;
        continue;
      }
      // Flag for admin review if escrowJournalId is missing
      if (!order.escrowJournalId) {
        logger.warn(`Order ${doc.id} has no escrowJournalId — flagging for admin review`);
        await doc.ref.update({
          adminReviewRequired: true,
          adminReviewReason: "Missing escrowJournalId during auto-refund",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        skipped++;
        continue;
      }
      if (!order.buyerId) {
        logger.error(`Order ${doc.id} missing buyerId, skipping auto-refund`);
        skipped++;
        continue;
      }
      try {
        const journalId = await refundMarketplaceEscrow(
          order.buyerId,
          order.amount,
          doc.id,
          `Auto-refund: seller unresponsive for ${order.listingTitle}`
        );
        await doc.ref.update({
          status: "refunded",
          refundJournalId: journalId,
          refundType: "auto_unresponsive_seller",
          refundedAt: admin.firestore.FieldValue.serverTimestamp(),
          cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        refunded++;
      } catch (err) {
        logger.error(`Failed to auto-refund order ${doc.id}`, err);
      }
    }

    logger.info(`Auto-refunded ${refunded}/${staleOrders.size} unresponsive seller orders (${skipped} skipped)`);

    // Also check for orders stuck in "refunding" for more than 24 hours
    const stuckRefundingOrders = await db.collection("buyOrders")
      .where("status", "==", "refunding")
      .where("updatedAt", "<=", admin.firestore.Timestamp.fromMillis(Date.now() - 24 * 60 * 60 * 1000))
      .limit(50)
      .get();

    for (const doc of stuckRefundingOrders.docs) {
      try {
        const order = doc.data();
        if (order.escrowJournalId && !order.refundJournalId) {
          const refundResult = await refundMarketplaceEscrow(
            order.buyerId,
            order.amount,
            doc.id,
            `Retry refund for stuck order: ${order.listingTitle}`,
            `seller_refund_retry_${doc.id}`
          );
          await doc.ref.update({
            status: "refunded",
            refundJournalId: refundResult || null,
            refundType: "seller_initiated",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      } catch (err) {
        logger.warn(`Failed to retry refund for stuck order ${doc.id}`, err);
      }
    }
  }
);

/**
 * Send review reminders for completed orders where buyer hasn't vouched.
 * Runs daily at 10:00 AM SAST — sends reminder 48 hours after completion.
 */
export const sendReviewReminder = onSchedule(
  {
    schedule: "0 10 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "marketplace" },
  },
  async () => {
    const twoDaysAgo = admin.firestore.Timestamp.fromMillis(
      Date.now() - 2 * 24 * 60 * 60 * 1000
    );
    const threeDaysAgo = admin.firestore.Timestamp.fromMillis(
      Date.now() - 3 * 24 * 60 * 60 * 1000
    );

    // Find orders completed 2-3 days ago
    const completedOrders = await db
      .collection("buyOrders")
      .where("status", "==", "completed")
      .where("completedAt", ">=", threeDaysAgo)
      .where("completedAt", "<=", twoDaysAgo)
      .limit(100)
      .get();

    if (completedOrders.empty) {
      logger.info("No review reminders to send");
      return;
    }

    let sent = 0;
    let skipped = 0;
    for (const doc of completedOrders.docs) {
      const order = doc.data();

      // Check if vouch already exists using deterministic vouch ID
      const vouchId = `${order.buyerId}_${doc.id}`;
      const existingVouch = await db.collection("vouches").doc(vouchId).get();
      if (existingVouch.exists) {
        skipped++;
        continue;
      }

      // Get buyer FCM token
      const buyerDoc = await db.collection("users").doc(order.buyerId).get();
      const fcmToken = buyerDoc.data()?.fcmToken;
      if (!fcmToken) continue;

      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: "How was your purchase?",
            body: `Leave a review for "${order.listingTitle}" to help other buyers`,
          },
          data: {
            type: "review_reminder",
            orderId: doc.id,
            screen: "marketplace_vouch",
          },
        });
        sent++;
      } catch (err) {
        logger.warn(`Failed to send review reminder to ${order.buyerId}`, err);
      }
    }

    logger.info(`Sent ${sent} review reminders`);
  }
);

/**
 * Expire stale offers that haven't been responded to.
 * Runs every 6 hours.
 */
export const expireOffers = onSchedule(
  {
    schedule: "0 */6 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "marketplace" },
  },
  async () => {
    const now = admin.firestore.Timestamp.now();

    const expiredOffers = await db
      .collection("marketplaceOffers")
      .where("status", "==", "pending")
      .where("expiresAt", "<=", now)
      .limit(200)
      .get();

    if (expiredOffers.empty) {
      logger.info("No expired offers found");
      return;
    }

    const batch = db.batch();
    for (const doc of expiredOffers.docs) {
      batch.update(doc.ref, {
        status: "expired",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();

    logger.info(`Expired ${expiredOffers.size} offers`);
  }
);

// ============================================================================
// DISPUTE MANAGEMENT
// ============================================================================

/**
 * Seller responds to a dispute raised by the buyer.
 */
export const respondToDispute = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    requireAuth(request);
    requireAppCheck(request, "respondToDispute");
    const userId = request.auth!.uid;
    const { orderId, response, photoUrls, proposedResolution, proposedResolutionAmount } = request.data;

    if (!orderId || !response) throw new HttpsError("invalid-argument", "orderId and response are required");
    if (response.length > 2000) throw new HttpsError("invalid-argument", "Response must be under 2000 characters");
    if (photoUrls && photoUrls.length > 5) throw new HttpsError("invalid-argument", "Maximum 5 photos allowed");
    if (photoUrls) {
      for (const url of photoUrls) {
        if (typeof url !== "string" || !url.startsWith("https://")) {
          throw new HttpsError("invalid-argument", "Photo URLs must be valid HTTPS URLs");
        }
      }
    }

    const orderRef = db.collection("buyOrders").doc(orderId);
    await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) throw new HttpsError("not-found", "Order not found");
      const order = orderDoc.data()!;
      if (order.sellerId !== userId) throw new HttpsError("permission-denied", "Only seller can respond to dispute");
      if (order.status !== "disputed") throw new HttpsError("failed-precondition", "Order is not in disputed status");

      tx.update(orderRef, {
        sellerDisputeResponse: response,
        sellerDisputePhotos: photoUrls || [],
        sellerProposedResolution: proposedResolution || null,
        disputeResolutionAmount: proposedResolutionAmount || null,
        sellerRespondedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return { success: true };
  }
);

/**
 * Buyer adds additional evidence (photos/details) to an existing dispute.
 */
export const addDisputeEvidence = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    requireAuth(request);
    requireAppCheck(request, "addDisputeEvidence");
    const userId = request.auth!.uid;
    const { orderId, photoUrls, additionalDetails } = request.data;

    if (!orderId) throw new HttpsError("invalid-argument", "orderId is required");
    if (!photoUrls || !Array.isArray(photoUrls) || photoUrls.length === 0) {
      throw new HttpsError("invalid-argument", "At least one photo URL is required");
    }
    if (photoUrls.length > 10) throw new HttpsError("invalid-argument", "Maximum 10 photos allowed");
    for (const url of photoUrls) {
      if (typeof url !== "string" || !url.startsWith("https://")) {
        throw new HttpsError("invalid-argument", "Photo URLs must be valid HTTPS URLs");
      }
    }

    const orderRef = db.collection("buyOrders").doc(orderId);
    await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) throw new HttpsError("not-found", "Order not found");
      const order = orderDoc.data()!;
      if (order.buyerId !== userId) throw new HttpsError("permission-denied", "Only buyer can add dispute evidence");
      if (order.status !== "disputed") throw new HttpsError("failed-precondition", "Order is not in disputed status");

      const existingPhotos: string[] = order.disputePhotos || [];
      const allPhotos = [...existingPhotos, ...photoUrls].slice(0, 10);

      tx.update(orderRef, {
        disputePhotos: allPhotos,
        disputeDetails: additionalDetails ? `${order.disputeDetails || ""}\n\n--- Additional evidence ---\n${additionalDetails}` : order.disputeDetails,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return { success: true };
  }
);

/**
 * Seller proposes a resolution for a disputed order (full/partial refund, replacement, or no refund).
 */
export const proposeResolution = onCall(
  { labels: { area: "marketplace" } },
  async (request) => {
    requireAuth(request);
    requireAppCheck(request, "proposeResolution");
    const userId = request.auth!.uid;
    const { orderId, resolutionType, refundAmount } = request.data;

    if (!orderId || !resolutionType) throw new HttpsError("invalid-argument", "orderId and resolutionType required");
    if (!["full_refund", "partial_refund", "replacement", "no_refund"].includes(resolutionType)) {
      throw new HttpsError("invalid-argument", "Invalid resolution type");
    }
    if (resolutionType === "partial_refund" && (!refundAmount || typeof refundAmount !== "number" || refundAmount <= 0)) {
      throw new HttpsError("invalid-argument", "Partial refund requires positive refundAmount");
    }
    if (typeof refundAmount === "number" && refundAmount < 0) {
      throw new HttpsError("invalid-argument", "Resolution amount cannot be negative");
    }

    const orderRef = db.collection("buyOrders").doc(orderId);
    await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) throw new HttpsError("not-found", "Order not found");
      const order = orderDoc.data()!;
      if (order.sellerId !== userId) throw new HttpsError("permission-denied", "Only seller can propose resolution");
      if (order.status !== "disputed") throw new HttpsError("failed-precondition", "Order must be in disputed status");
      if (typeof refundAmount === "number" && refundAmount > order.amount) {
        throw new HttpsError("invalid-argument", "Resolution amount cannot exceed order amount");
      }

      tx.update(orderRef, {
        sellerProposedResolution: resolutionType,
        disputeResolutionAmount: resolutionType === "partial_refund" ? refundAmount : null,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return { success: true };
  }
);
