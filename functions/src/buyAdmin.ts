/**
 * Buy Admin Cloud Functions
 *
 * Admin functions for managing feature flags, buy categories,
 * and monitoring VAS purchase stats.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import { requireAdminPermission, logAdminAction, createPendingAction } from "./adminAuth";

const db = admin.firestore();

// ============================================================================
// FEATURE FLAG MANAGEMENT
// ============================================================================

/**
 * List all feature flags.
 */
export const adminListFeatureFlags = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminListFeatureFlags");
    await requireAdminPermission(
      request,
      "buy:listFeatureFlags",
      "adminListFeatureFlags"
    );

    const snapshot = await db.collection("featureFlags").get();
    const flags = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return { flags };
  }
);

/**
 * Update a feature flag (toggle, scope, community targeting).
 */
export const adminUpdateFeatureFlag = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateFeatureFlag");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateFeatureFlag",
      "adminUpdateFeatureFlag"
    );

    const { flagId, isEnabled, isGlobal, enabledCommunityIds } =
      request.data as {
        flagId: string;
        isEnabled?: boolean;
        isGlobal?: boolean;
        enabledCommunityIds?: string[];
      };

    if (!flagId) {
      throw new HttpsError("invalid-argument", "flagId is required");
    }

    const ref = db.collection("featureFlags").doc(flagId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `Feature flag '${flagId}' not found`);
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    if (isEnabled !== undefined) updates.isEnabled = isEnabled;
    if (isGlobal !== undefined) updates.isGlobal = isGlobal;
    if (enabledCommunityIds !== undefined)
      updates.enabledCommunityIds = enabledCommunityIds;

    await ref.update(updates);

    logAdminAction(adminCtx.uid, "adminUpdateFeatureFlag", "success", {
      flagId,
      updates,
    }).catch(() => {});

    logger.info(`Feature flag '${flagId}' updated by ${adminCtx.email}`);
    return { success: true, flagId };
  }
);

// ============================================================================
// BUY CATEGORY MANAGEMENT
// ============================================================================

/**
 * Create a new buy category.
 */
export const adminCreateBuyCategory = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateBuyCategory");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createCategory",
      "adminCreateBuyCategory"
    );

    const {
      name,
      iconEmoji,
      sortOrder,
      isActive,
      isComingSoon,
      purchaseCategoryMapping,
      featureFlagKey,
      logoUrl,
      backgroundColor,
    } = request.data as {
      name: string;
      iconEmoji?: string;
      sortOrder?: number;
      isActive?: boolean;
      isComingSoon?: boolean;
      purchaseCategoryMapping?: string;
      featureFlagKey?: string;
      logoUrl?: string;
      backgroundColor?: string;
    };

    if (!name || name.trim().length === 0) {
      throw new HttpsError("invalid-argument", "name is required");
    }

    const data = {
      name: name.trim(),
      iconEmoji: iconEmoji || "",
      sortOrder: sortOrder ?? 0,
      isActive: isActive ?? true,
      isComingSoon: isComingSoon ?? false,
      purchaseCategoryMapping: purchaseCategoryMapping || null,
      featureFlagKey: featureFlagKey || null,
      logoUrl: logoUrl || null,
      backgroundColor: backgroundColor || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const ref = await db.collection("buyCategories").add(data);

    logAdminAction(adminCtx.uid, "adminCreateBuyCategory", "success", {
      categoryId: ref.id,
      name,
    }).catch(() => {});

    logger.info(`Buy category '${name}' created by ${adminCtx.email}`);
    return { success: true, categoryId: ref.id };
  }
);

/**
 * Update an existing buy category.
 */
export const adminUpdateBuyCategory = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateBuyCategory");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateCategory",
      "adminUpdateBuyCategory"
    );

    const { categoryId, ...fields } = request.data as {
      categoryId: string;
      name?: string;
      iconEmoji?: string;
      sortOrder?: number;
      isActive?: boolean;
      isComingSoon?: boolean;
      purchaseCategoryMapping?: string;
      featureFlagKey?: string;
      logoUrl?: string;
      backgroundColor?: string;
    };

    if (!categoryId) {
      throw new HttpsError("invalid-argument", "categoryId is required");
    }

    const ref = db.collection("buyCategories").doc(categoryId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `Category '${categoryId}' not found`);
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const [key, value] of Object.entries(fields)) {
      if (value !== undefined) updates[key] = value;
    }

    await ref.update(updates);

    logAdminAction(adminCtx.uid, "adminUpdateBuyCategory", "success", {
      categoryId,
      updates: Object.keys(fields),
    }).catch(() => {});

    logger.info(`Buy category '${categoryId}' updated by ${adminCtx.email}`);
    return { success: true, categoryId };
  }
);

/**
 * Toggle a buy category's active/coming-soon status.
 */
export const adminToggleBuyCategory = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminToggleBuyCategory");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:toggleCategory",
      "adminToggleBuyCategory"
    );

    const { categoryId, isActive, isComingSoon } = request.data as {
      categoryId: string;
      isActive?: boolean;
      isComingSoon?: boolean;
    };

    if (!categoryId) {
      throw new HttpsError("invalid-argument", "categoryId is required");
    }

    const ref = db.collection("buyCategories").doc(categoryId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `Category '${categoryId}' not found`);
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    if (isActive !== undefined) updates.isActive = isActive;
    if (isComingSoon !== undefined) updates.isComingSoon = isComingSoon;

    await ref.update(updates);

    logAdminAction(adminCtx.uid, "adminToggleBuyCategory", "success", {
      categoryId,
      isActive,
      isComingSoon,
    }).catch(() => {});

    logger.info(
      `Buy category '${categoryId}' toggled by ${adminCtx.email}`
    );
    return { success: true, categoryId };
  }
);

// ============================================================================
// FEATURED ITEM MANAGEMENT
// ============================================================================

/**
 * List all featured items.
 */
export const adminListFeaturedItems = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminListFeaturedItems");
    await requireAdminPermission(
      request,
      "buy:listFeaturedItems",
      "adminListFeaturedItems"
    );

    const snapshot = await db
      .collection("featuredItems")
      .orderBy("sortOrder")
      .get();
    const items = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return { items };
  }
);

/**
 * Create a new featured item.
 */
export const adminCreateFeaturedItem = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateFeaturedItem");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createFeaturedItem",
      "adminCreateFeaturedItem"
    );

    const {
      title,
      subtitle,
      imageUrl,
      type,
      deepLinkRoute,
      brandId,
      communityIds,
      isActive,
      sortOrder,
      bgGradientType,
    } = request.data as {
      title: string;
      subtitle?: string;
      imageUrl?: string;
      type?: string;
      deepLinkRoute?: string;
      brandId?: string;
      communityIds?: string[];
      isActive?: boolean;
      sortOrder?: number;
      bgGradientType?: string;
    };

    if (!title || title.trim().length === 0) {
      throw new HttpsError("invalid-argument", "title is required");
    }

    const data = {
      title: title.trim(),
      subtitle: subtitle || null,
      imageUrl: imageUrl || null,
      type: type || "campaign",
      deepLinkRoute: deepLinkRoute || null,
      brandId: brandId || null,
      communityIds: communityIds || [],
      isActive: isActive ?? true,
      sortOrder: sortOrder ?? 0,
      bgGradientType: bgGradientType || "goldOrange",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const ref = await db.collection("featuredItems").add(data);

    logAdminAction(adminCtx.uid, "adminCreateFeaturedItem", "success", {
      itemId: ref.id,
      title,
    }).catch(() => {});

    logger.info(`Featured item '${title}' created by ${adminCtx.email}`);
    return { success: true, itemId: ref.id };
  }
);

/**
 * Update an existing featured item.
 */
export const adminUpdateFeaturedItem = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateFeaturedItem");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateFeaturedItem",
      "adminUpdateFeaturedItem"
    );

    const { itemId, ...fields } = request.data as {
      itemId: string;
      title?: string;
      subtitle?: string;
      imageUrl?: string;
      type?: string;
      deepLinkRoute?: string;
      brandId?: string;
      communityIds?: string[];
      isActive?: boolean;
      sortOrder?: number;
      bgGradientType?: string;
    };

    if (!itemId) {
      throw new HttpsError("invalid-argument", "itemId is required");
    }

    const ref = db.collection("featuredItems").doc(itemId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `Featured item '${itemId}' not found`);
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const [key, value] of Object.entries(fields)) {
      if (value !== undefined) updates[key] = value;
    }

    await ref.update(updates);

    logAdminAction(adminCtx.uid, "adminUpdateFeaturedItem", "success", {
      itemId,
      updates: Object.keys(fields),
    }).catch(() => {});

    logger.info(`Featured item '${itemId}' updated by ${adminCtx.email}`);
    return { success: true, itemId };
  }
);

/**
 * Delete a featured item.
 */
export const adminDeleteFeaturedItem = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminDeleteFeaturedItem");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:deleteFeaturedItem",
      "adminDeleteFeaturedItem"
    );

    const { itemId } = request.data as { itemId: string };
    if (!itemId) {
      throw new HttpsError("invalid-argument", "itemId is required");
    }

    const ref = db.collection("featuredItems").doc(itemId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `Featured item '${itemId}' not found`);
    }

    await ref.delete();

    logAdminAction(adminCtx.uid, "adminDeleteFeaturedItem", "success", {
      itemId,
      title: doc.data()?.title,
    }).catch(() => {});

    logger.info(`Featured item '${itemId}' deleted by ${adminCtx.email}`);
    return { success: true };
  }
);

// ============================================================================
// BRAND STOREFRONT MANAGEMENT
// ============================================================================

/**
 * List all brand storefronts.
 */
export const adminListBrandStorefronts = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminListBrandStorefronts");
    await requireAdminPermission(
      request,
      "buy:listBrandStorefronts",
      "adminListBrandStorefronts"
    );

    const snapshot = await db.collection("brandStorefronts").get();
    const storefronts = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return { storefronts };
  }
);

/**
 * Create a new brand storefront.
 */
export const adminCreateBrandStorefront = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateBrandStorefront");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createBrandStorefront",
      "adminCreateBrandStorefront"
    );

    const {
      brandId,
      brandName,
      brandLogoUrl,
      brandColor,
      coverImageUrl,
      tagline,
      isActive,
      isPremium,
      communityIds,
      sections,
    } = request.data as {
      brandId: string;
      brandName: string;
      brandLogoUrl?: string;
      brandColor?: string;
      coverImageUrl?: string;
      tagline?: string;
      isActive?: boolean;
      isPremium?: boolean;
      communityIds?: string[];
      sections?: unknown[];
    };

    if (!brandName || !brandId) {
      throw new HttpsError(
        "invalid-argument",
        "brandName and brandId are required"
      );
    }

    const data = {
      brandId,
      brandName: brandName.trim(),
      brandLogoUrl: brandLogoUrl || null,
      brandColor: brandColor || null,
      coverImageUrl: coverImageUrl || null,
      tagline: tagline || null,
      isActive: isActive ?? true,
      isPremium: isPremium ?? false,
      communityIds: communityIds || [],
      sections: sections || [],
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const ref = await db.collection("brandStorefronts").add(data);

    logAdminAction(adminCtx.uid, "adminCreateBrandStorefront", "success", {
      storefrontId: ref.id,
      brandName,
    }).catch(() => {});

    logger.info(
      `Brand storefront '${brandName}' created by ${adminCtx.email}`
    );
    return { success: true, storefrontId: ref.id };
  }
);

/**
 * Update an existing brand storefront.
 */
export const adminUpdateBrandStorefront = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateBrandStorefront");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateBrandStorefront",
      "adminUpdateBrandStorefront"
    );

    const { storefrontId, ...fields } = request.data as {
      storefrontId: string;
      brandName?: string;
      brandLogoUrl?: string;
      brandColor?: string;
      coverImageUrl?: string;
      tagline?: string;
      isActive?: boolean;
      isPremium?: boolean;
      communityIds?: string[];
      sections?: unknown[];
    };

    if (!storefrontId) {
      throw new HttpsError("invalid-argument", "storefrontId is required");
    }

    const ref = db.collection("brandStorefronts").doc(storefrontId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError(
        "not-found",
        `Storefront '${storefrontId}' not found`
      );
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const [key, value] of Object.entries(fields)) {
      if (value !== undefined) updates[key] = value;
    }

    await ref.update(updates);

    logAdminAction(adminCtx.uid, "adminUpdateBrandStorefront", "success", {
      storefrontId,
      updates: Object.keys(fields),
    }).catch(() => {});

    logger.info(
      `Brand storefront '${storefrontId}' updated by ${adminCtx.email}`
    );
    return { success: true, storefrontId };
  }
);

/**
 * Delete a brand storefront.
 */
export const adminDeleteBrandStorefront = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminDeleteBrandStorefront");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:deleteBrandStorefront",
      "adminDeleteBrandStorefront"
    );

    const { storefrontId } = request.data as { storefrontId: string };
    if (!storefrontId) {
      throw new HttpsError("invalid-argument", "storefrontId is required");
    }

    const ref = db.collection("brandStorefronts").doc(storefrontId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError(
        "not-found",
        `Storefront '${storefrontId}' not found`
      );
    }

    await ref.delete();

    logAdminAction(adminCtx.uid, "adminDeleteBrandStorefront", "success", {
      storefrontId,
      brandName: doc.data()?.brandName,
    }).catch(() => {});

    logger.info(
      `Brand storefront '${storefrontId}' deleted by ${adminCtx.email}`
    );
    return { success: true };
  }
);

// ============================================================================
// MARKETPLACE PROVIDER MANAGEMENT
// ============================================================================

/**
 * Approve a pending marketplace provider.
 */
export const adminApproveProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminApproveProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:approveProvider",
      "adminApproveProvider"
    );

    const { providerId } = request.data as { providerId: string };
    if (!providerId) {
      throw new HttpsError("invalid-argument", "providerId is required");
    }

    const ref = db.collection("providers").doc(providerId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Provider not found");
    }
    if (doc.data()?.status !== "pending") {
      throw new HttpsError("failed-precondition", "Provider is not pending");
    }

    await ref.update({
      status: "approved",
      approvedAt: admin.firestore.FieldValue.serverTimestamp(),
      approvedBy: adminCtx.uid,
    });

    logAdminAction(adminCtx.uid, "adminApproveProvider", "success", {
      providerId,
    }).catch(() => {});

    logger.info(`Provider '${providerId}' approved by ${adminCtx.email}`);
    return { success: true, providerId };
  }
);

/**
 * Reject a pending marketplace provider.
 */
export const adminRejectProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminRejectProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:rejectProvider",
      "adminRejectProvider"
    );

    const { providerId, reason } = request.data as {
      providerId: string;
      reason: string;
    };
    if (!providerId) {
      throw new HttpsError("invalid-argument", "providerId is required");
    }

    const ref = db.collection("providers").doc(providerId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Provider not found");
    }

    await ref.update({
      status: "rejected",
      rejectedAt: admin.firestore.FieldValue.serverTimestamp(),
      rejectedBy: adminCtx.uid,
      rejectionReason: reason || null,
    });

    logAdminAction(adminCtx.uid, "adminRejectProvider", "success", {
      providerId,
      reason,
    }).catch(() => {});

    logger.info(`Provider '${providerId}' rejected by ${adminCtx.email}`);
    return { success: true, providerId };
  }
);

/**
 * Suspend an active marketplace provider.
 * Cascades: removes all active listings, cancels pending orders with refund.
 */
export const adminSuspendProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminSuspendProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:suspendProvider",
      "adminSuspendProvider"
    );

    const { providerId, reason } = request.data as {
      providerId: string;
      reason: string;
    };
    if (!providerId) {
      throw new HttpsError("invalid-argument", "providerId is required");
    }

    const providerRef = db.collection("providers").doc(providerId);
    const providerDoc = await providerRef.get();
    if (!providerDoc.exists) {
      throw new HttpsError("not-found", "Provider not found");
    }

    const batch = db.batch();

    // Suspend the provider
    batch.update(providerRef, {
      status: "suspended",
      suspendedAt: admin.firestore.FieldValue.serverTimestamp(),
      suspendedBy: adminCtx.uid,
      suspensionReason: reason || null,
    });

    // Cascade: remove all active listings
    const listingsSnap = await db
      .collection("marketplaceListings")
      .where("providerId", "==", providerId)
      .where("status", "==", "active")
      .get();
    for (const listingDoc of listingsSnap.docs) {
      batch.update(listingDoc.ref, {
        status: "removed",
        removedAt: admin.firestore.FieldValue.serverTimestamp(),
        removedReason: "Provider suspended",
      });
    }

    await batch.commit();

    // Cancel pending orders (non-batched due to potential escrow refunds)
    const pendingOrders = await db
      .collection("buyOrders")
      .where("sellerId", "==", providerDoc.data()?.userId)
      .where("status", "in", ["pending", "escrowed"])
      .get();

    let cancelledCount = 0;
    for (const orderDoc of pendingOrders.docs) {
      const orderData = orderDoc.data();
      try {
        if (orderData.status === "escrowed" && orderData.escrowJournalId) {
          const { refundMarketplaceEscrow } = await import(
            "./ledger/marketplaceEscrow"
          );
          await refundMarketplaceEscrow(
            orderData.buyerId,
            orderData.amount,
            orderDoc.id,
            `Refund: provider suspended`
          );
        }
        await orderDoc.ref.update({
          status: "cancelled",
          cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
          cancelReason: "Provider suspended by admin",
        });
        cancelledCount++;
      } catch (err) {
        logger.error(
          `Failed to cancel order ${orderDoc.id} during provider suspension:`,
          err
        );
      }
    }

    logAdminAction(adminCtx.uid, "adminSuspendProvider", "success", {
      providerId,
      reason,
      listingsRemoved: listingsSnap.size,
      ordersCancelled: cancelledCount,
    }).catch(() => {});

    logger.info(
      `Provider '${providerId}' suspended by ${adminCtx.email}: ` +
        `${listingsSnap.size} listings removed, ${cancelledCount} orders cancelled`
    );
    return {
      success: true,
      providerId,
      listingsRemoved: listingsSnap.size,
      ordersCancelled: cancelledCount,
    };
  }
);

/**
 * Unsuspend a suspended marketplace provider.
 */
export const adminUnsuspendProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUnsuspendProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:unsuspendProvider",
      "adminUnsuspendProvider"
    );

    const { providerId } = request.data as { providerId: string };
    if (!providerId) {
      throw new HttpsError("invalid-argument", "providerId is required");
    }

    const ref = db.collection("providers").doc(providerId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Provider not found");
    }
    if (doc.data()?.status !== "suspended") {
      throw new HttpsError(
        "failed-precondition",
        "Provider is not suspended"
      );
    }

    await ref.update({
      status: "approved",
      unsuspendedAt: admin.firestore.FieldValue.serverTimestamp(),
      unsuspendedBy: adminCtx.uid,
    });

    logAdminAction(adminCtx.uid, "adminUnsuspendProvider", "success", {
      providerId,
    }).catch(() => {});

    logger.info(`Provider '${providerId}' unsuspended by ${adminCtx.email}`);
    return { success: true, providerId };
  }
);

// ============================================================================
// MARKETPLACE LISTING MODERATION
// ============================================================================

/**
 * Dismiss flags on a listing (approve after review).
 */
export const adminDismissListingFlags = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminDismissListingFlags");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:approveListing",
      "adminDismissListingFlags"
    );

    const { listingId } = request.data as { listingId: string };
    if (!listingId) {
      throw new HttpsError("invalid-argument", "listingId is required");
    }

    const ref = db.collection("marketplaceListings").doc(listingId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Listing not found");
    }

    await ref.update({
      status: "active",
      reportCount: 0,
      reviewedAt: admin.firestore.FieldValue.serverTimestamp(),
      reviewedBy: adminCtx.uid,
    });

    logAdminAction(adminCtx.uid, "adminDismissListingFlags", "success", {
      listingId,
    }).catch(() => {});

    return { success: true, listingId };
  }
);

/**
 * Flag a listing for review.
 */
export const adminFlagListing = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminFlagListing");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:flagListing",
      "adminFlagListing"
    );

    const { listingId } = request.data as { listingId: string };
    if (!listingId) {
      throw new HttpsError("invalid-argument", "listingId is required");
    }

    const ref = db.collection("marketplaceListings").doc(listingId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Listing not found");
    }

    await ref.update({
      status: "flagged",
      flaggedAt: admin.firestore.FieldValue.serverTimestamp(),
      flaggedBy: adminCtx.uid,
    });

    logAdminAction(adminCtx.uid, "adminFlagListing", "success", {
      listingId,
    }).catch(() => {});

    return { success: true, listingId };
  }
);

/**
 * Remove a listing (soft-delete).
 */
export const adminRemoveListing = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminRemoveListing");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:removeListing",
      "adminRemoveListing"
    );

    const { listingId } = request.data as { listingId: string };
    if (!listingId) {
      throw new HttpsError("invalid-argument", "listingId is required");
    }

    const ref = db.collection("marketplaceListings").doc(listingId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Listing not found");
    }

    await ref.update({
      status: "removed",
      removedAt: admin.firestore.FieldValue.serverTimestamp(),
      removedBy: adminCtx.uid,
    });

    logAdminAction(adminCtx.uid, "adminRemoveListing", "success", {
      listingId,
      title: doc.data()?.title,
    }).catch(() => {});

    return { success: true, listingId };
  }
);

/**
 * Reinstate a removed listing.
 */
export const adminReinstateListing = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminReinstateListing");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:reinstateListing",
      "adminReinstateListing"
    );

    const { listingId } = request.data as { listingId: string };
    if (!listingId) {
      throw new HttpsError("invalid-argument", "listingId is required");
    }

    const ref = db.collection("marketplaceListings").doc(listingId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Listing not found");
    }
    if (doc.data()?.status !== "removed") {
      throw new HttpsError(
        "failed-precondition",
        "Listing is not in removed status"
      );
    }

    await ref.update({
      status: "active",
      reinstatedAt: admin.firestore.FieldValue.serverTimestamp(),
      reinstatedBy: adminCtx.uid,
    });

    logAdminAction(adminCtx.uid, "adminReinstateListing", "success", {
      listingId,
    }).catch(() => {});

    return { success: true, listingId };
  }
);

// ============================================================================
// MARKETPLACE ORDER & DISPUTE MANAGEMENT
// ============================================================================

/**
 * Force-cancel an order with buyer refund.
 * Requires maker-checker for escrowed orders.
 */
export const adminForceCancelOrder = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminForceCancelOrder");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:forceCancelOrder",
      "adminForceCancelOrder"
    );

    const { orderId } = request.data as { orderId: string };
    if (!orderId) {
      throw new HttpsError("invalid-argument", "orderId is required");
    }

    const ref = db.collection("buyOrders").doc(orderId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Order not found");
    }

    const order = doc.data()!;
    if (["completed", "cancelled", "refunded"].includes(order.status)) {
      throw new HttpsError(
        "failed-precondition",
        "Order is already in terminal state"
      );
    }

    // Financial operation — route through maker-checker
    const { pendingActionId } = await createPendingAction(
      adminCtx,
      "buy:forceCancelOrder",
      "adminForceCancelOrder",
      {
        orderId,
        amount: order.amount,
        buyerId: order.buyerId,
        previousStatus: order.status,
        hasEscrow: !!order.escrowJournalId,
      },
      `Force-cancel order ${orderId} — refund ${order.amount} tokens to buyer ${order.buyerId}`
    );

    logAdminAction(adminCtx.uid, "adminForceCancelOrder", "pending", {
      orderId,
      pendingActionId,
      previousStatus: order.status,
      amount: order.amount,
    }).catch(() => {});

    logger.info(`Force-cancel order '${orderId}' pending approval (action ${pendingActionId})`);
    return { success: true, pendingActionId, requiresApproval: true };
  }
);

/**
 * Resolve a disputed order.
 * Resolution: 'refund_buyer' | 'release_seller'
 */
export const adminResolveDispute = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminResolveDispute");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:resolveDispute",
      "adminResolveDispute"
    );

    const { orderId, resolution, splitPercent } = request.data as {
      orderId: string;
      resolution: "refund_buyer" | "release_seller" | "split";
      splitPercent?: number;
    };
    if (!orderId || !resolution) {
      throw new HttpsError(
        "invalid-argument",
        "orderId and resolution are required"
      );
    }
    if (!["refund_buyer", "release_seller", "split"].includes(resolution)) {
      throw new HttpsError(
        "invalid-argument",
        "resolution must be 'refund_buyer', 'release_seller', or 'split'"
      );
    }
    if (resolution === "split") {
      if (splitPercent === undefined || typeof splitPercent !== "number" || splitPercent < 0 || splitPercent > 100) {
        throw new HttpsError("invalid-argument", "splitPercent must be 0-100 for split resolution");
      }
    }

    const ref = db.collection("buyOrders").doc(orderId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Order not found");
    }

    const order = doc.data()!;
    if (order.status !== "disputed") {
      throw new HttpsError(
        "failed-precondition",
        "Order is not in disputed state"
      );
    }

    // Financial operation — route through maker-checker
    const { pendingActionId } = await createPendingAction(
      adminCtx,
      "buy:resolveDispute",
      "adminResolveDispute",
      {
        orderId,
        resolution,
        splitPercent: splitPercent ?? null,
        amount: order.amount,
        buyerId: order.buyerId,
        sellerId: order.sellerId,
      },
      `Resolve dispute on order ${orderId}: ${resolution}${resolution === "split" ? ` (${splitPercent}% to seller)` : ""}`
    );

    logAdminAction(adminCtx.uid, "adminResolveDispute", "pending", {
      orderId,
      resolution,
      splitPercent,
      pendingActionId,
    }).catch(() => {});

    logger.info(
      `Dispute resolution '${resolution}' for order '${orderId}' pending approval (action ${pendingActionId})`
    );
    return { success: true, pendingActionId, requiresApproval: true };
  }
);

// ============================================================================
// MARKETPLACE ANALYTICS
// ============================================================================

/**
 * Get marketplace analytics and KPIs.
 */
export const adminGetMarketplaceAnalytics = onCall(
  { labels: { area: "admin" }, timeoutSeconds: 60 },
  async (request) => {
    requireAppCheck(request, "adminGetMarketplaceAnalytics");
    await requireAdminPermission(
      request,
      "buy:getMarketplaceAnalytics",
      "adminGetMarketplaceAnalytics"
    );

    const [ordersSnap, providersSnap, listingsSnap] = await Promise.all([
      db.collection("buyOrders").get(),
      db.collection("providers").where("status", "==", "approved").get(),
      db
        .collection("marketplaceListings")
        .where("status", "==", "active")
        .get(),
    ]);

    const orders = ordersSnap.docs.map((d) => d.data());
    const completedOrders = orders.filter((o) => o.status === "completed");
    const disputedOrders = orders.filter((o) => o.status === "disputed");
    const gmv = completedOrders.reduce(
      (acc, o) => acc + (o.amount || 0),
      0
    );
    const escrowBalance = orders
      .filter((o) =>
        ["escrowed", "fulfilled", "disputed"].includes(o.status)
      )
      .reduce((acc, o) => acc + (o.amount || 0), 0);

    // Top providers by completed orders
    const providerCounts: Record<string, { count: number; name: string }> =
      {};
    for (const o of completedOrders) {
      const sid = o.sellerId || "";
      if (!providerCounts[sid]) {
        providerCounts[sid] = { count: 0, name: o.sellerName || sid };
      }
      providerCounts[sid].count++;
    }
    const topProviders = Object.entries(providerCounts)
      .sort((a, b) => b[1].count - a[1].count)
      .slice(0, 10)
      .map(([providerId, data]) => ({
        providerId,
        providerName: data.name,
        completedOrders: data.count,
      }));

    // Top categories
    const categoryCounts: Record<string, number> = {};
    for (const doc of listingsSnap.docs) {
      const cat = doc.data().category || "other";
      categoryCounts[cat] = (categoryCounts[cat] || 0) + 1;
    }
    const topCategories = Object.entries(categoryCounts)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5)
      .map(([category, count]) => ({ category, count }));

    return {
      gmv,
      activeProviders: providersSnap.size,
      activeListings: listingsSnap.size,
      completedOrders: completedOrders.length,
      escrowBalance,
      disputeRate:
        orders.length > 0
          ? Math.round((disputedOrders.length / orders.length) * 100)
          : 0,
      totalOrders: orders.length,
      topProviders,
      topCategories,
    };
  }
);

// ============================================================================
// VAS PURCHASE STATS
// ============================================================================

/**
 * Get aggregated VAS purchase statistics.
 */
export const adminGetBuyPurchaseStats = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminGetBuyPurchaseStats");
    await requireAdminPermission(
      request,
      "buy:getPurchaseStats",
      "adminGetBuyPurchaseStats"
    );

    // Today's date range
    const now = new Date();
    const todayStart = new Date(
      now.getFullYear(),
      now.getMonth(),
      now.getDate()
    );

    // Count today's purchases
    const todaySnapshot = await db
      .collection("purchases")
      .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(todayStart))
      .get();

    let todayCount = 0;
    let completedCount = 0;
    let failedCount = 0;
    let totalRevenue = 0;

    for (const doc of todaySnapshot.docs) {
      const data = doc.data();
      todayCount++;
      if (data.status === "completed") {
        completedCount++;
        totalRevenue += data.amountTokens || data.priceTokens || 0;
      } else if (data.status === "failed") {
        failedCount++;
      }
    }

    const successRate =
      todayCount > 0 ? Math.round((completedCount / todayCount) * 100) : 0;

    return {
      todayCount,
      completedCount,
      failedCount,
      totalRevenue,
      successRate,
    };
  }
);

// ============================================================================
// GROUP BUY MANAGEMENT
// ============================================================================

/**
 * List all group buys with optional filtering.
 */
export const adminListGroupBuys = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminListGroupBuys");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:listGroupBuys",
      "adminListGroupBuys"
    );

    const { status, communityId, limit: queryLimit } = request.data ?? {};

    let query: admin.firestore.Query = db.collection("groupBuys");

    if (status) {
      query = query.where("status", "==", status);
    }
    if (communityId) {
      query = query.where("communityId", "==", communityId);
    }

    const safeLimit = Math.min(Math.max(queryLimit || 100, 1), 500);
    query = query.orderBy("createdAt", "desc").limit(safeLimit);

    const snapshot = await query.get();
    const groupBuys = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    await logAdminAction(adminCtx.uid, "buy:listGroupBuys", "adminListGroupBuys", {
      count: groupBuys.length,
      status: status || "all",
    });

    return { groupBuys };
  }
);

/**
 * Get full details for a group buy including contributions.
 */
export const adminGetGroupBuyDetails = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminGetGroupBuyDetails");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:getGroupBuyDetails",
      "adminGetGroupBuyDetails"
    );

    const { groupBuyId } = request.data ?? {};
    if (!groupBuyId) {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }

    const doc = await db.collection("groupBuys").doc(groupBuyId).get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Group buy not found");
    }

    const contribSnap = await db
      .collection("groupBuys")
      .doc(groupBuyId)
      .collection("contributions")
      .orderBy("contributedAt", "desc")
      .get();

    const contributions = contribSnap.docs.map((d) => ({
      id: d.id,
      ...d.data(),
    }));

    await logAdminAction(adminCtx.uid, "buy:getGroupBuyDetails", "adminGetGroupBuyDetails", {
      groupBuyId,
    });

    return {
      groupBuy: { id: doc.id, ...doc.data() },
      contributions,
    };
  }
);

/**
 * Extend a group buy's deadline.
 */
export const adminExtendGroupBuyDeadline = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminExtendGroupBuyDeadline");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:extendGroupBuyDeadline",
      "adminExtendGroupBuyDeadline"
    );

    const { groupBuyId, newDeadline, reason } = request.data ?? {};
    if (!groupBuyId || !newDeadline) {
      throw new HttpsError(
        "invalid-argument",
        "groupBuyId and newDeadline are required"
      );
    }

    const doc = await db.collection("groupBuys").doc(groupBuyId).get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Group buy not found");
    }
    const data = doc.data()!;
    if (data.status !== "open") {
      throw new HttpsError(
        "failed-precondition",
        `Cannot extend deadline — status is "${data.status}"`
      );
    }

    const newDeadlineDate = new Date(newDeadline);
    if (isNaN(newDeadlineDate.getTime())) {
      throw new HttpsError("invalid-argument", "Invalid deadline date");
    }
    if (newDeadlineDate <= new Date()) {
      throw new HttpsError("invalid-argument", "New deadline must be in the future");
    }

    await db.collection("groupBuys").doc(groupBuyId).update({
      deadline: admin.firestore.Timestamp.fromDate(newDeadlineDate),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(
      adminCtx.uid,
      "buy:extendGroupBuyDeadline",
      "adminExtendGroupBuyDeadline",
      { groupBuyId, newDeadline, reason: reason || "" }
    );

    return { success: true };
  }
);

/**
 * Force-complete a group buy (releases escrow to organizer).
 * MAKER-CHECKER required — creates a pending action for second admin approval.
 */
export const adminForceCompleteGroupBuy = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminForceCompleteGroupBuy");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:forceCompleteGroupBuy",
      "adminForceCompleteGroupBuy"
    );

    const { groupBuyId } = request.data ?? {};
    if (!groupBuyId) {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }

    const doc = await db.collection("groupBuys").doc(groupBuyId).get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Group buy not found");
    }
    const data = doc.data()!;
    if (!["open", "targetMet"].includes(data.status)) {
      throw new HttpsError(
        "failed-precondition",
        `Cannot force-complete — status is "${data.status}"`
      );
    }

    // Guard: cannot complete a group buy with 0 tokens
    if (!data.currentAmount || data.currentAmount <= 0) {
      throw new HttpsError(
        "failed-precondition",
        "Cannot force-complete a group buy with no contributions"
      );
    }

    if (!data.organizerId) {
      throw new HttpsError(
        "failed-precondition",
        "Group buy has no organizer — cannot release escrow"
      );
    }

    // MAKER-CHECKER: create pending action instead of executing immediately
    return createPendingAction(
      adminCtx,
      "buy:forceCompleteGroupBuy",
      "adminForceCompleteGroupBuy",
      { groupBuyId, amount: data.currentAmount, organizerId: data.organizerId, title: data.title },
      `Force-complete group buy "${data.title}" — release ${data.currentAmount} tokens to organizer ${data.organizerId}`
    );
  }
);

/**
 * Force-cancel a group buy (refunds all participants).
 * MAKER-CHECKER required — creates a pending action for second admin approval.
 */
export const adminForceCancelGroupBuy = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminForceCancelGroupBuy");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:forceCancelGroupBuy",
      "adminForceCancelGroupBuy"
    );

    const { groupBuyId } = request.data ?? {};
    if (!groupBuyId) {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }

    const doc = await db.collection("groupBuys").doc(groupBuyId).get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Group buy not found");
    }
    const data = doc.data()!;
    if (["completed", "expired", "cancelled"].includes(data.status)) {
      throw new HttpsError(
        "failed-precondition",
        `Cannot cancel — status is "${data.status}"`
      );
    }

    // MAKER-CHECKER: create pending action instead of executing immediately
    return createPendingAction(
      adminCtx,
      "buy:forceCancelGroupBuy",
      "adminForceCancelGroupBuy",
      { groupBuyId, title: data.title, currentAmount: data.currentAmount },
      `Force-cancel group buy "${data.title}" — refund all participants (${data.currentAmount} tokens in escrow)`
    );
  }
);

/**
 * Retry failed refunds for an expired/cancelled group buy.
 */
export const adminRetryGroupBuyRefunds = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminRetryGroupBuyRefunds");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:retryGroupBuyRefunds",
      "adminRetryGroupBuyRefunds"
    );

    const { groupBuyId } = request.data ?? {};
    if (!groupBuyId) {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }

    const doc = await db.collection("groupBuys").doc(groupBuyId).get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "Group buy not found");
    }
    const data = doc.data()!;
    if (!["expired", "cancelled"].includes(data.status)) {
      throw new HttpsError(
        "failed-precondition",
        "Can only retry refunds for expired/cancelled group buys"
      );
    }

    const contribSnap = await db
      .collection("groupBuys")
      .doc(groupBuyId)
      .collection("contributions")
      .get();

    const { refundGroupBuyContribution } = await import("./ledger/groupBuyEscrow");
    let refunded = 0;
    const errors: string[] = [];

    for (const contribDoc of contribSnap.docs) {
      const contrib = contribDoc.data();
      try {
        await refundGroupBuyContribution(
          contrib.userId,
          contrib.amount,
          groupBuyId,
          `Retry refund for group buy "${data.title}"`
        );
        refunded++;
      } catch (err: unknown) {
        // Idempotent — if already refunded, the idempotency key will reject
        const errMsg = err instanceof Error ? err.message : String(err);
        if (errMsg.includes("idempotency") || errMsg.includes("duplicate")) {
          // Already refunded — count as success
          refunded++;
        } else {
          errors.push(`Failed to refund ${contrib.userId}: ${errMsg}`);
          logger.error(`Retry refund failed for ${contrib.userId}:`, err);
        }
      }
    }

    await logAdminAction(
      adminCtx.uid,
      "buy:retryGroupBuyRefunds",
      "adminRetryGroupBuyRefunds",
      { groupBuyId, refunded, errorCount: errors.length }
    );

    return { success: true, refunded, errors: errors.length > 0 ? errors : undefined };
  }
);

/**
 * Create a brand-sponsored group buy on behalf of a brand partner.
 */
export const adminCreateBrandGroupBuy = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateBrandGroupBuy");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createBrandGroupBuy",
      "adminCreateBrandGroupBuy"
    );

    const {
      title,
      description,
      targetAmount,
      deadline,
      linkedListingId,
      minParticipants,
      maxParticipants,
      brandId,
      brandLogoUrl,
      discountPercent,
      communityId,
    } = request.data ?? {};

    if (!title || !targetAmount || !deadline) {
      throw new HttpsError(
        "invalid-argument",
        "title, targetAmount, and deadline are required"
      );
    }
    if (!brandId) {
      throw new HttpsError("invalid-argument", "brandId is required for brand group buys");
    }

    // Look up the brand's client doc to get the correct organizer account
    const brandDoc = await db.collection("clients").doc(brandId).get();
    if (!brandDoc.exists) {
      throw new HttpsError("not-found", `Brand client ${brandId} not found`);
    }
    const brandData = brandDoc.data()!;
    const brandOrganizerId = brandData.userId || brandId;
    const brandName = brandData.name || brandData.displayName || brandId;

    const deadlineDate = new Date(deadline);
    if (isNaN(deadlineDate.getTime()) || deadlineDate <= new Date()) {
      throw new HttpsError("invalid-argument", "deadline must be a future date");
    }

    const docRef = await db.collection("groupBuys").add({
      title,
      description: description || "",
      targetAmount,
      currentAmount: 0,
      deadline: admin.firestore.Timestamp.fromDate(deadlineDate),
      linkedListingId: linkedListingId || null,
      minParticipants: minParticipants || 2,
      maxParticipants: maxParticipants || null,
      organizerId: brandOrganizerId,
      organizerName: `Brand: ${brandName}`,
      communityId: communityId || null,
      status: "open",
      participantCount: 0,
      sponsorType: "brand",
      brandId,
      brandLogoUrl: brandLogoUrl || null,
      discountPercent: discountPercent || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(
      adminCtx.uid,
      "buy:createBrandGroupBuy",
      "adminCreateBrandGroupBuy",
      { groupBuyId: docRef.id, title, brandId, targetAmount }
    );

    return { success: true, groupBuyId: docRef.id };
  }
);

// ============================================================================
// ESCROW OVERVIEW
// ============================================================================

/**
 * Get consolidated escrow overview with reconciliation data.
 */
export const adminGetEscrowOverview = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminGetEscrowOverview");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:getEscrowOverview",
      "adminGetEscrowOverview"
    );

    // Marketplace escrow: orders in escrowed/fulfilled/disputed state
    const marketplaceSnap = await db
      .collection("buyOrders")
      .where("status", "in", ["escrowed", "fulfilled", "disputed"])
      .get();

    const marketplaceEscrows = marketplaceSnap.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    const marketplaceEscrowTotal = marketplaceEscrows.reduce(
      (total, o) => total + ((o as Record<string, unknown>).amount as number || 0),
      0
    );

    // Group buy escrow: open or targetMet
    const groupBuySnap = await db
      .collection("groupBuys")
      .where("status", "in", ["open", "targetMet"])
      .get();

    const groupBuyEscrows = groupBuySnap.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    const groupBuyEscrowTotal = groupBuyEscrows.reduce(
      (total, g) =>
        total + ((g as Record<string, unknown>).currentAmount as number || 0),
      0
    );

    // Stale escrow check (marketplace orders > 14 days)
    const fourteenDaysAgo = new Date();
    fourteenDaysAgo.setDate(fourteenDaysAgo.getDate() - 14);
    const staleEscrowCount = marketplaceEscrows.filter((o) => {
      const created = (o as Record<string, unknown>).createdAt as
        admin.firestore.Timestamp | undefined;
      return created && created.toDate() < fourteenDaysAgo;
    }).length;

    // Ledger reconciliation — read system account balances
    let marketplaceLedgerBalance: number | null = null;
    let groupBuyLedgerBalance: number | null = null;
    let reconciliationStatus = "unknown";

    try {
      const [marketplaceAccDoc, groupBuyAccDoc] = await Promise.all([
        db.collection("ledgerAccounts").doc("system:marketplace_escrow").get(),
        db.collection("ledgerAccounts").doc("system:group_buy_escrow").get(),
      ]);

      if (marketplaceAccDoc.exists) {
        marketplaceLedgerBalance = marketplaceAccDoc.data()?.balance ?? 0;
      }
      if (groupBuyAccDoc.exists) {
        groupBuyLedgerBalance = groupBuyAccDoc.data()?.balance ?? 0;
      }

      const marketplaceMatches =
        marketplaceLedgerBalance === null ||
        marketplaceLedgerBalance === marketplaceEscrowTotal;
      const groupBuyMatches =
        groupBuyLedgerBalance === null ||
        groupBuyLedgerBalance === groupBuyEscrowTotal;

      reconciliationStatus =
        marketplaceMatches && groupBuyMatches ? "balanced" : "discrepancy";
    } catch (err) {
      logger.warn("Failed to read escrow system accounts for recon:", err);
    }

    await logAdminAction(adminCtx.uid, "buy:getEscrowOverview", "adminGetEscrowOverview", {
      marketplaceCount: marketplaceEscrows.length,
      groupBuyCount: groupBuyEscrows.length,
      totalEscrow: marketplaceEscrowTotal + groupBuyEscrowTotal,
    });

    return {
      totalEscrow: marketplaceEscrowTotal + groupBuyEscrowTotal,
      marketplaceEscrow: marketplaceEscrowTotal,
      groupBuyEscrow: groupBuyEscrowTotal,
      marketplaceCount: marketplaceEscrows.length,
      groupBuyCount: groupBuyEscrows.length,
      staleEscrowCount,
      marketplaceLedgerBalance,
      groupBuyLedgerBalance,
      reconciliationStatus,
      marketplaceEscrows,
      groupBuyEscrows,
    };
  }
);
