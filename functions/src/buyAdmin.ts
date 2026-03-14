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
import { refundMarketplaceEscrow } from "./ledger/marketplaceEscrow";

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

    // Feature flags use featureKey as doc ID and are toggled via isEnabled —
    // they do not have an isDeleted field since flags are never soft-deleted.
    const snapshot = await db.collection("featureFlags").get();
    const flags = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return { flags };
  }
);

/**
 * Create a new feature flag.
 */
export const adminCreateFeatureFlag = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateFeatureFlag");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createFeatureFlag",
      "adminCreateFeatureFlag"
    );

    const { featureKey, isEnabled, isGlobal, enabledCommunityIds } =
      request.data as {
        featureKey: string;
        isEnabled?: boolean;
        isGlobal?: boolean;
        enabledCommunityIds?: string[];
      };

    if (!featureKey || featureKey.trim().length === 0) {
      throw new HttpsError("invalid-argument", "featureKey is required");
    }

    // Check for duplicate
    const existing = await db.collection("featureFlags").doc(featureKey.trim()).get();
    if (existing.exists) {
      throw new HttpsError("already-exists", `Feature flag '${featureKey}' already exists`);
    }

    const data = {
      featureKey: featureKey.trim(),
      isEnabled: isEnabled ?? false,
      isGlobal: isGlobal ?? false,
      enabledCommunityIds: enabledCommunityIds ?? [],
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await db.collection("featureFlags").doc(featureKey.trim()).set(data);

    await logAdminAction(adminCtx.uid, "adminCreateFeatureFlag", "success", {
      featureKey,
    });

    logger.info(`Feature flag '${featureKey}' created by ${adminCtx.email}`);
    return { success: true, featureKey };
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

    await logAdminAction(adminCtx.uid, "adminUpdateFeatureFlag", "success", {
      flagId,
      updates,
    });

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
      subcategories,
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
      subcategories?: Array<{ id: string; name: string; emoji: string }>;
    };

    if (!name || name.trim().length === 0) {
      throw new HttpsError("invalid-argument", "name is required");
    }

    // Duplicate name check
    const duplicateSnap = await db
      .collection("buyCategories")
      .where("name", "==", name.trim())
      .limit(1)
      .get();
    if (!duplicateSnap.empty) {
      throw new HttpsError("already-exists", `Buy category '${name.trim()}' already exists`);
    }

    // Deterministic ID: cat_<nameHash>
    const nameHash = name.trim().toLowerCase().replace(/[^a-z0-9]/g, "").substring(0, 40);
    const categoryDocId = `cat_${nameHash}`;

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
      subcategories: subcategories || [],
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await db.collection("buyCategories").doc(categoryDocId).set(data);

    await logAdminAction(adminCtx.uid, "adminCreateBuyCategory", "success", {
      categoryId: categoryDocId,
      name,
    });

    logger.info(`Buy category '${name}' created by ${adminCtx.email}`);
    return { success: true, categoryId: categoryDocId };
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
      subcategories?: Array<{ id: string; name: string; emoji: string }>;
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

    await logAdminAction(adminCtx.uid, "adminUpdateBuyCategory", "success", {
      categoryId,
      updates: Object.keys(fields),
    });

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
    if (doc.data()?.isDeleted === true) {
      throw new HttpsError("failed-precondition", "Cannot toggle a deleted category");
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    if (isActive !== undefined) updates.isActive = isActive;
    if (isComingSoon !== undefined) updates.isComingSoon = isComingSoon;

    await ref.update(updates);

    await logAdminAction(adminCtx.uid, "adminToggleBuyCategory", "success", {
      categoryId,
      isActive,
      isComingSoon,
    });

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
      .where("isDeleted", "==", false)
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
      videoUrl,
      type,
      deepLinkRoute,
      brandId,
      communityIds,
      isActive,
      sortOrder,
      bgGradientType,
      brandName,
      ctaText,
      bgColorHex,
      colorIntensity,
      imageOpacity,
      imageLayout,
      showTitle,
      scheduledStart,
      scheduledEnd,
    } = request.data as {
      title: string;
      subtitle?: string;
      imageUrl?: string;
      videoUrl?: string;
      type?: string;
      deepLinkRoute?: string;
      brandId?: string;
      communityIds?: string[];
      isActive?: boolean;
      sortOrder?: number;
      bgGradientType?: string;
      brandName?: string;
      ctaText?: string;
      bgColorHex?: string;
      colorIntensity?: number;
      imageOpacity?: number;
      imageLayout?: string;
      showTitle?: boolean;
      scheduledStart?: string;
      scheduledEnd?: string;
    };

    if (!title || title.trim().length === 0) {
      throw new HttpsError("invalid-argument", "title is required");
    }

    // Validate scheduled dates
    if (scheduledStart) {
      const start = new Date(scheduledStart);
      if (isNaN(start.getTime())) {
        throw new HttpsError("invalid-argument", "Invalid date format for scheduledStart");
      }
    }
    if (scheduledEnd) {
      const end = new Date(scheduledEnd);
      if (isNaN(end.getTime())) {
        throw new HttpsError("invalid-argument", "Invalid date format for scheduledEnd");
      }
    }
    if (scheduledStart && scheduledEnd) {
      const start = new Date(scheduledStart);
      const end = new Date(scheduledEnd);
      if (start >= end) {
        throw new HttpsError("invalid-argument", "scheduledStart must be before scheduledEnd");
      }
    }

    // Validate hex color format
    if (bgColorHex) {
      const hexPattern = /^#?[0-9A-Fa-f]{6}(,#?[0-9A-Fa-f]{6})?$/;
      if (!hexPattern.test(bgColorHex)) {
        throw new HttpsError("invalid-argument", "bgColorHex must be valid hex color format (e.g., #FF5500 or FF5500,00AAFF)");
      }
    }

    // Validate gradient type
    if (bgGradientType) {
      const validGradients = ["goldOrange", "cyanBlue", "pinkPurple", "logo", "custom"];
      if (!validGradients.includes(bgGradientType)) {
        throw new HttpsError("invalid-argument", `bgGradientType must be one of: ${validGradients.join(", ")}`);
      }
    }

    // Validate image layout
    if (imageLayout) {
      if (!["full", "right"].includes(imageLayout)) {
        throw new HttpsError("invalid-argument", "imageLayout must be 'full' or 'right'");
      }
    }

    // Validate type
    if (type) {
      const validTypes = ["none", "campaign", "promotion", "trending", "collectible"];
      if (!validTypes.includes(type)) {
        throw new HttpsError("invalid-argument", `type must be one of: ${validTypes.join(", ")}`);
      }
    }

    // Validate URLs
    if (imageUrl && !imageUrl.startsWith("https://") && !imageUrl.startsWith("gs://")) {
      throw new HttpsError("invalid-argument", "imageUrl must be a valid HTTPS or GCS URL");
    }
    if (videoUrl && !videoUrl.startsWith("https://") && !videoUrl.startsWith("gs://")) {
      throw new HttpsError("invalid-argument", "videoUrl must be a valid HTTPS or GCS URL");
    }

    // Check for ordering conflicts if sortOrder is provided — exclude soft-deleted items
    if (sortOrder !== undefined && sortOrder !== null) {
      const conflictSnap = await db
        .collection("featuredItems")
        .where("sortOrder", "==", sortOrder)
        .where("isActive", "==", true)
        .where("isDeleted", "==", false)
        .limit(1)
        .get();
      if (!conflictSnap.empty) {
        throw new HttpsError(
          "already-exists",
          `A featured item already exists at sort order ${sortOrder}. Use a different order or update the existing item first.`
        );
      }
    }

    // Deterministic ID: feat_<titleHash> (idempotent — same title produces same ID)
    const titleHash = title.trim().toLowerCase().replace(/[^a-z0-9]/g, "").substring(0, 30);
    const featuredItemId = `feat_${titleHash}`;

    const data: Record<string, unknown> = {
      title: title.trim(),
      subtitle: subtitle || null,
      imageUrl: imageUrl || null,
      videoUrl: videoUrl || null,
      type: type || "campaign",
      deepLinkRoute: deepLinkRoute || null,
      brandId: brandId || null,
      communityIds: communityIds || [],
      isActive: isActive ?? true,
      isDeleted: false,
      sortOrder: sortOrder ?? 0,
      bgGradientType: bgGradientType || "goldOrange",
      brandName: brandName || null,
      ctaText: ctaText || null,
      bgColorHex: bgColorHex || null,
      colorIntensity: colorIntensity != null ? Math.max(0, Math.min(1, colorIntensity)) : 0.4,
      imageOpacity: imageOpacity != null ? Math.max(0, Math.min(1, imageOpacity)) : 1.0,
      imageLayout: imageLayout || "right",
      showTitle: showTitle !== false,
      scheduledStart: scheduledStart ? admin.firestore.Timestamp.fromDate(new Date(scheduledStart)) : null,
      scheduledEnd: scheduledEnd ? admin.firestore.Timestamp.fromDate(new Date(scheduledEnd)) : null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const ref = db.collection("featuredItems").doc(featuredItemId);
    await ref.set(data);

    await logAdminAction(adminCtx.uid, "adminCreateFeaturedItem", "success", {
      itemId: featuredItemId,
      title,
    });

    logger.info(`Featured item '${title}' created by ${adminCtx.email}`);
    return { success: true, itemId: featuredItemId };
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

    const { itemId, scheduledStart, scheduledEnd, ...fields } = request.data as {
      itemId: string;
      title?: string;
      subtitle?: string;
      imageUrl?: string;
      videoUrl?: string;
      type?: string;
      deepLinkRoute?: string;
      brandId?: string;
      communityIds?: string[];
      isActive?: boolean;
      sortOrder?: number;
      bgGradientType?: string;
      brandName?: string;
      ctaText?: string;
      bgColorHex?: string;
      colorIntensity?: number;
      imageOpacity?: number;
      imageLayout?: string;
      showTitle?: boolean;
      scheduledStart?: string;
      scheduledEnd?: string;
    };

    if (!itemId) {
      throw new HttpsError("invalid-argument", "itemId is required");
    }

    // Validate scheduled dates
    if (scheduledStart && scheduledEnd) {
      const start = new Date(scheduledStart);
      const end = new Date(scheduledEnd);
      if (isNaN(start.getTime()) || isNaN(end.getTime())) {
        throw new HttpsError("invalid-argument", "Invalid date format for scheduled dates");
      }
      if (start >= end) {
        throw new HttpsError("invalid-argument", "scheduledStart must be before scheduledEnd");
      }
    }

    // Validate hex color format
    if (fields.bgColorHex) {
      const hexPattern = /^#?[0-9A-Fa-f]{6}(,#?[0-9A-Fa-f]{6})?$/;
      if (!hexPattern.test(fields.bgColorHex)) {
        throw new HttpsError("invalid-argument", "bgColorHex must be valid hex color format (e.g., #FF5500 or FF5500,00AAFF)");
      }
    }

    // Validate gradient type
    if (fields.bgGradientType) {
      const validGradients = ["goldOrange", "cyanBlue", "pinkPurple", "logo", "custom"];
      if (!validGradients.includes(fields.bgGradientType)) {
        throw new HttpsError("invalid-argument", `bgGradientType must be one of: ${validGradients.join(", ")}`);
      }
    }

    // Validate image layout
    if (fields.imageLayout) {
      if (!["full", "right"].includes(fields.imageLayout)) {
        throw new HttpsError("invalid-argument", "imageLayout must be 'full' or 'right'");
      }
    }

    // Validate type
    if (fields.type) {
      const validTypes = ["none", "campaign", "promotion", "trending", "collectible"];
      if (!validTypes.includes(fields.type)) {
        throw new HttpsError("invalid-argument", `type must be one of: ${validTypes.join(", ")}`);
      }
    }

    // Validate URLs
    if (fields.imageUrl && !fields.imageUrl.startsWith("https://") && !fields.imageUrl.startsWith("gs://")) {
      throw new HttpsError("invalid-argument", "imageUrl must be a valid HTTPS or GCS URL");
    }
    if (fields.videoUrl && !fields.videoUrl.startsWith("https://") && !fields.videoUrl.startsWith("gs://")) {
      throw new HttpsError("invalid-argument", "videoUrl must be a valid HTTPS or GCS URL");
    }

    // Clamp opacity values
    if (fields.colorIntensity != null) {
      fields.colorIntensity = Math.max(0, Math.min(1, fields.colorIntensity));
    }
    if (fields.imageOpacity != null) {
      fields.imageOpacity = Math.max(0, Math.min(1, fields.imageOpacity));
    }

    const ref = db.collection("featuredItems").doc(itemId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `Featured item '${itemId}' not found`);
    }
    if (doc.data()?.isDeleted === true) {
      throw new HttpsError("failed-precondition", `Featured item '${itemId}' has been deleted. Reinstate it before updating.`);
    }

    // Check for ordering conflicts if sortOrder is changing
    if (fields.sortOrder !== undefined && fields.sortOrder !== null) {
      const currentSortOrder = doc.data()?.sortOrder;
      if (fields.sortOrder !== currentSortOrder) {
        const conflictSnap = await db
          .collection("featuredItems")
          .where("sortOrder", "==", fields.sortOrder)
          .where("isActive", "==", true)
          .where("isDeleted", "==", false)
          .limit(1)
          .get();
        // Exclude self from conflict check
        const hasConflict = conflictSnap.docs.some((d) => d.id !== itemId);
        if (hasConflict) {
          throw new HttpsError(
            "already-exists",
            `A featured item already exists at sort order ${fields.sortOrder}. Use a different order or update the existing item first.`
          );
        }
      }
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const [key, value] of Object.entries(fields)) {
      if (value !== undefined) updates[key] = value;
    }
    if (scheduledStart !== undefined) {
      updates.scheduledStart = scheduledStart ? admin.firestore.Timestamp.fromDate(new Date(scheduledStart)) : null;
    }
    if (scheduledEnd !== undefined) {
      updates.scheduledEnd = scheduledEnd ? admin.firestore.Timestamp.fromDate(new Date(scheduledEnd)) : null;
    }

    await ref.update(updates);

    await logAdminAction(adminCtx.uid, "adminUpdateFeaturedItem", "success", {
      itemId,
      updates: Object.keys(fields),
    });

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

    // Soft-delete (consistent with other delete operations)
    await ref.update({
      isDeleted: true,
      isActive: false,
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
      deletedBy: adminCtx.uid,
    });

    await logAdminAction(adminCtx.uid, "adminDeleteFeaturedItem", "success", {
      itemId,
      title: doc.data()?.title,
    });

    logger.info(`Featured item '${itemId}' soft-deleted by ${adminCtx.email}`);
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

    const snapshot = await db.collection("brandStorefronts").where("isDeleted", "==", false).get();
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

    // Uniqueness check: one storefront per brandId
    const existingStorefront = await db
      .collection("brandStorefronts")
      .where("brandId", "==", brandId)
      .where("isDeleted", "==", false)
      .limit(1)
      .get();
    if (!existingStorefront.empty) {
      throw new HttpsError("already-exists", `A storefront for brand '${brandId}' already exists`);
    }

    // Validate coupon fields within sections
    if (sections && Array.isArray(sections)) {
      for (const section of sections as Array<{ type?: string; coupons?: Array<Record<string, unknown>> }>) {
        if (section.coupons && Array.isArray(section.coupons)) {
          for (const coupon of section.coupons) {
            if (coupon.maxClaims !== undefined && coupon.maxClaims !== null) {
              const maxClaims = Number(coupon.maxClaims);
              if (!Number.isInteger(maxClaims) || maxClaims < 1) {
                throw new HttpsError("invalid-argument", "Coupon maxClaims must be a positive integer");
              }
            }
            if (coupon.expiresAt !== undefined && coupon.expiresAt !== null) {
              const expiryDate = new Date(coupon.expiresAt as string);
              if (isNaN(expiryDate.getTime())) {
                throw new HttpsError("invalid-argument", "Coupon expiresAt must be a valid date");
              }
              if (expiryDate.getTime() < Date.now()) {
                throw new HttpsError("invalid-argument", "Coupon expiresAt must be a future date");
              }
            }
          }
        }
      }
    }

    const data = {
      brandId,
      brandName: brandName.trim(),
      brandLogoUrl: brandLogoUrl || null,
      brandColor: brandColor || null,
      coverImageUrl: coverImageUrl || null,
      tagline: tagline || null,
      isActive: isActive ?? true,
      isDeleted: false,
      isPremium: isPremium ?? false,
      communityIds: communityIds || [],
      sections: sections || [],
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    // Deterministic ID: store_<brandId>
    const storefrontDocId = `store_${brandId}`;
    const ref = db.collection("brandStorefronts").doc(storefrontDocId);
    await ref.set(data);

    await logAdminAction(adminCtx.uid, "adminCreateBrandStorefront", "success", {
      storefrontId: storefrontDocId,
      brandName,
    });

    logger.info(
      `Brand storefront '${brandName}' created by ${adminCtx.email}`
    );
    return { success: true, storefrontId: storefrontDocId };
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

    // Validate coupon fields within sections if sections are being updated
    if (fields.sections && Array.isArray(fields.sections)) {
      for (const section of fields.sections as Array<{ type?: string; coupons?: Array<Record<string, unknown>> }>) {
        if (section.coupons && Array.isArray(section.coupons)) {
          for (const coupon of section.coupons) {
            if (coupon.maxClaims !== undefined && coupon.maxClaims !== null) {
              const maxClaims = Number(coupon.maxClaims);
              if (!Number.isInteger(maxClaims) || maxClaims < 1) {
                throw new HttpsError("invalid-argument", "Coupon maxClaims must be a positive integer");
              }
            }
            if (coupon.expiresAt !== undefined && coupon.expiresAt !== null) {
              const expiryDate = new Date(coupon.expiresAt as string);
              if (isNaN(expiryDate.getTime())) {
                throw new HttpsError("invalid-argument", "Coupon expiresAt must be a valid date");
              }
              if (expiryDate.getTime() < Date.now()) {
                throw new HttpsError("invalid-argument", "Coupon expiresAt must be a future date");
              }
            }
          }
        }
      }
    }

    const ref = db.collection("brandStorefronts").doc(storefrontId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError(
        "not-found",
        `Storefront '${storefrontId}' not found`
      );
    }
    if (doc.data()?.isDeleted === true) {
      throw new HttpsError("failed-precondition", "Cannot update a deleted storefront");
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const [key, value] of Object.entries(fields)) {
      if (value !== undefined) updates[key] = value;
    }

    await ref.update(updates);

    await logAdminAction(adminCtx.uid, "adminUpdateBrandStorefront", "success", {
      storefrontId,
      updates: Object.keys(fields),
    });

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

    // Soft-delete the storefront (never hard-delete)
    await ref.update({
      isDeleted: true,
      isActive: false,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Cascade: soft-delete all products in the storefront's products subcollection
    const productsSnap = await ref.collection("products").where("isDeleted", "!=", true).get();
    const productDocs = productsSnap.docs;
    for (let i = 0; i < productDocs.length; i += 500) {
      const chunk = productDocs.slice(i, i + 500);
      const batch = db.batch();
      for (const productDoc of chunk) {
        batch.update(productDoc.ref, {
          isDeleted: true,
          isActive: false,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    }

    // Cascade: soft-delete brand products in top-level brandProducts collection
    const brandProductsSnap = await db
      .collection("brandProducts")
      .where("storefrontId", "==", storefrontId)
      .where("isDeleted", "==", false)
      .get();
    const brandProductDocs = brandProductsSnap.docs;
    for (let i = 0; i < brandProductDocs.length; i += 500) {
      const chunk = brandProductDocs.slice(i, i + 500);
      const bpBatch = db.batch();
      for (const bpDoc of chunk) {
        bpBatch.update(bpDoc.ref, {
          isDeleted: true,
          isActive: false,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      await bpBatch.commit();
    }

    await logAdminAction(adminCtx.uid, "adminDeleteBrandStorefront", "success", {
      storefrontId,
      brandName: doc.data()?.brandName,
      productsSoftDeleted: productDocs.length + brandProductDocs.length,
    });

    logger.info(
      `Brand storefront '${storefrontId}' soft-deleted by ${adminCtx.email} (${productDocs.length} products cascaded)`
    );
    return { success: true, productsSoftDeleted: productDocs.length };
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

    await logAdminAction(adminCtx.uid, "adminApproveProvider", "success", {
      providerId,
    });

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
    if (doc.data()?.status !== "pending") {
      throw new HttpsError("failed-precondition", "Provider is not in pending status");
    }

    await ref.update({
      status: "rejected",
      rejectedAt: admin.firestore.FieldValue.serverTimestamp(),
      rejectedBy: adminCtx.uid,
      rejectionReason: reason || null,
    });

    await logAdminAction(adminCtx.uid, "adminRejectProvider", "success", {
      providerId,
      reason,
    });

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

    // Suspend the provider
    await providerRef.update({
      status: "suspended",
      suspendedAt: admin.firestore.FieldValue.serverTimestamp(),
      suspendedBy: adminCtx.uid,
      suspensionReason: reason || null,
    });

    // Cascade: remove all active/paused/pending/flagged listings (batch-size safe: chunks of 500)
    const listingsSnap = await db
      .collection("marketplaceListings")
      .where("providerId", "==", providerId)
      .where("status", "in", ["active", "paused", "pending", "flagged"])
      .get();

    const listingDocs = listingsSnap.docs;
    for (let i = 0; i < listingDocs.length; i += 500) {
      const chunk = listingDocs.slice(i, i + 500);
      const batch = db.batch();
      for (const listingDoc of chunk) {
        batch.update(listingDoc.ref, {
          status: "removed",
          removedAt: admin.firestore.FieldValue.serverTimestamp(),
          removedReason: "Provider suspended",
        });
      }
      await batch.commit();
    }

    // Cancel pending orders — track failures for admin visibility
    const pendingOrders = await db
      .collection("buyOrders")
      .where("sellerId", "==", providerDoc.data()?.userId)
      .where("status", "in", ["pending", "escrowed"])
      .get();

    let cancelledCount = 0;
    const failedOrderIds: string[] = [];
    for (const orderDoc of pendingOrders.docs) {
      const orderData = orderDoc.data();
      try {
        // Idempotency guard: skip orders already refunded
        if (orderData.refundJournalId) {
          cancelledCount++;
          continue;
        }
        if (orderData.status === "escrowed" && orderData.escrowJournalId) {
          if (!orderData.buyerId) {
            logger.error(`Order ${orderDoc.id} missing buyerId, skipping refund`);
            failedOrderIds.push(orderDoc.id);
            continue;
          }
          const journalId = await refundMarketplaceEscrow(
            orderData.buyerId,
            orderData.amount,
            orderDoc.id,
            `Refund: provider suspended`
          );
          await orderDoc.ref.update({
            status: "refunded",
            refundJournalId: journalId,
            cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
            cancelReason: "Provider suspended by admin",
          });
        } else {
          await orderDoc.ref.update({
            status: "cancelled",
            cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
            cancelReason: "Provider suspended by admin",
          });
        }
        cancelledCount++;
      } catch (err) {
        logger.error(
          `Failed to cancel order ${orderDoc.id} during provider suspension:`,
          err
        );
        failedOrderIds.push(orderDoc.id);
      }
    }

    // Notify the provider about the suspension
    const suspendProviderData = providerDoc.data();
    if (suspendProviderData?.userId) {
      try {
        await db.collection("notifications").add({
          userId: suspendProviderData.userId,
          type: "providerSuspended",
          title: "Account Suspended",
          body: reason
            ? `Your provider account has been suspended: ${reason}`
            : "Your provider account has been suspended.",
          data: { providerId },
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch (err) {
        logger.warn("Failed to create suspension notification:", err);
      }
    }

    await logAdminAction(adminCtx.uid, "adminSuspendProvider", "success", {
      providerId,
      reason,
      listingsRemoved: listingsSnap.size,
      ordersCancelled: cancelledCount,
      failedOrderIds,
    });

    logger.info(
      `Provider '${providerId}' suspended by ${adminCtx.email}: ` +
        `${listingsSnap.size} listings removed, ${cancelledCount} orders cancelled, ${failedOrderIds.length} failed`
    );
    return {
      success: true,
      providerId,
      listingsRemoved: listingsSnap.size,
      ordersCancelled: cancelledCount,
      failedOrderIds,
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

    // Notify the provider about the unsuspension
    const unsuspendProviderData = doc.data();
    if (unsuspendProviderData?.userId) {
      try {
        await db.collection("notifications").add({
          userId: unsuspendProviderData.userId,
          type: "providerUnsuspended",
          title: "Account Unsuspended",
          body: "Your provider account has been unsuspended. You can now resume selling.",
          data: { providerId },
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch (err) {
        logger.warn("Failed to create unsuspension notification:", err);
      }
    }

    await logAdminAction(adminCtx.uid, "adminUnsuspendProvider", "success", {
      providerId,
    });

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
    const listingStatus = doc.data()?.status;
    if (listingStatus === "removed" || doc.data()?.isDeleted === true) {
      throw new HttpsError("failed-precondition", "Cannot dismiss flags on a removed or deleted listing");
    }

    await ref.update({
      status: "active",
      reportCount: 0,
      reviewedAt: admin.firestore.FieldValue.serverTimestamp(),
      reviewedBy: adminCtx.uid,
    });

    await logAdminAction(adminCtx.uid, "adminDismissListingFlags", "success", {
      listingId,
    });

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
    const flagListingStatus = doc.data()?.status;
    if (!["active", "paused"].includes(flagListingStatus)) {
      throw new HttpsError("failed-precondition", `Cannot flag listing with status '${flagListingStatus}' — must be active or paused`);
    }

    await ref.update({
      status: "flagged",
      flaggedAt: admin.firestore.FieldValue.serverTimestamp(),
      flaggedBy: adminCtx.uid,
    });

    await logAdminAction(adminCtx.uid, "adminFlagListing", "success", {
      listingId,
    });

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
      isDeleted: true,
      isActive: false,
      removedAt: admin.firestore.FieldValue.serverTimestamp(),
      removedBy: adminCtx.uid,
    });

    await logAdminAction(adminCtx.uid, "adminRemoveListing", "success", {
      listingId,
      title: doc.data()?.title,
    });

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
      isDeleted: false,
      isActive: true,
      reinstatedAt: admin.firestore.FieldValue.serverTimestamp(),
      reinstatedBy: adminCtx.uid,
    });

    await logAdminAction(adminCtx.uid, "adminReinstateListing", "success", {
      listingId,
    });

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

    await logAdminAction(adminCtx.uid, "adminForceCancelOrder", "pending", {
      orderId,
      pendingActionId,
      previousStatus: order.status,
      amount: order.amount,
    });

    logger.info(`Force-cancel order '${orderId}' pending approval (action ${pendingActionId})`);
    return { success: true, pendingActionId, requiresApproval: true };
  }
);

/**
 * Force-complete an order — release escrow to seller.
 * Requires maker-checker for escrowed orders.
 */
export const adminForceCompleteOrder = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminForceCompleteOrder");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:forceCompleteOrder",
      "adminForceCompleteOrder"
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
      "buy:forceCompleteOrder",
      "adminForceCompleteOrder",
      {
        orderId,
        amount: order.amount,
        sellerId: order.sellerId,
        previousStatus: order.status,
        hasEscrow: !!order.escrowJournalId,
      },
      `Force-complete order ${orderId} — release ${order.amount} tokens to seller ${order.sellerId}`
    );

    await logAdminAction(adminCtx.uid, "adminForceCompleteOrder", "pending", {
      orderId,
      pendingActionId,
      previousStatus: order.status,
      amount: order.amount,
    });

    logger.info(`Force-complete order '${orderId}' pending approval (action ${pendingActionId})`);
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

    const { orderId, resolution, sellerPercent } = request.data as {
      orderId: string;
      resolution: "refund_buyer" | "release_seller" | "split";
      sellerPercent?: number;
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
      if (sellerPercent === undefined || typeof sellerPercent !== "number" || sellerPercent < 0 || sellerPercent > 100) {
        throw new HttpsError("invalid-argument", "sellerPercent must be 0-100 for split resolution");
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
        sellerPercent: sellerPercent ?? null,
        amount: order.amount,
        buyerId: order.buyerId,
        sellerId: order.sellerId,
      },
      `Resolve dispute on order ${orderId}: ${resolution}${resolution === "split" ? ` (${sellerPercent}% to seller)` : ""}`
    );

    await logAdminAction(adminCtx.uid, "adminResolveDispute", "pending", {
      orderId,
      resolution,
      sellerPercent,
      pendingActionId,
    });

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
      db.collection("buyOrders").limit(10000).get(),
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

    await logAdminAction(adminCtx.uid, "adminListGroupBuys", "success", {
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

    await logAdminAction(adminCtx.uid, "adminGetGroupBuyDetails", "success", {
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

    // New deadline must be later than the current deadline
    const currentDeadline = data.deadline.toDate();
    if (newDeadlineDate <= currentDeadline) {
      throw new HttpsError("invalid-argument", "New deadline must be later than the current deadline");
    }

    // Maximum extension limit: 90 days from now
    if (newDeadlineDate.getTime() > Date.now() + 90 * 24 * 60 * 60 * 1000) {
      throw new HttpsError("invalid-argument", "Deadline cannot be extended more than 90 days from now");
    }

    await db.collection("groupBuys").doc(groupBuyId).update({
      deadline: admin.firestore.Timestamp.fromDate(newDeadlineDate),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(
      adminCtx.uid,
      "adminExtendGroupBuyDeadline",
      "success",
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
      .where("status", "!=", "refunded")
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
      "adminRetryGroupBuyRefunds",
      "success",
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
      imageUrl,
      originalPrice,
      category,
      deliveryFee,
      collectionDeadline,
      fulfilmentInstructions,
      fulfilmentType,
      type,
      clusters,
      addresses,
      organizerId,
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
    let brandOrganizerId = brandData.userId || brandId;
    const brandName = brandData.name || brandData.displayName || brandId;

    // If an explicit organizerId is provided, verify the user exists
    if (organizerId && typeof organizerId === "string") {
      try {
        await admin.auth().getUser(organizerId);
        brandOrganizerId = organizerId;
      } catch {
        throw new HttpsError("not-found", `Organizer user ${organizerId} not found`);
      }
    }

    const deadlineDate = new Date(deadline);
    if (isNaN(deadlineDate.getTime()) || deadlineDate <= new Date()) {
      throw new HttpsError("invalid-argument", "deadline must be a future date");
    }

    const titleSlug = title.trim().toLowerCase().replace(/\s+/g, "_").replace(/[^a-z0-9_]/g, "").substring(0, 30);
    const groupBuyDocId = `brand_gb_${brandId}_${titleSlug}`;
    const docRef = db.collection("groupBuys").doc(groupBuyDocId);
    await docRef.set({
      id: groupBuyDocId,
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
      brandName: brandName || null,
      discountPercent: discountPercent || null,
      imageUrl: imageUrl || null,
      originalPrice: originalPrice || null,
      category: category || null,
      deliveryFee: deliveryFee || 0,
      collectionDeadline: collectionDeadline ? admin.firestore.Timestamp.fromDate(new Date(collectionDeadline)) : null,
      fulfilmentInstructions: fulfilmentInstructions || null,
      fulfilmentType: fulfilmentType || "digital",
      type: type || "digital",
      clusters: clusters || [],
      addresses: addresses || [],
      voucherCodes: [],
      organizerSuccessRate: 1.0,
      deliveryStatus: null,
      createdByAdmin: true,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(
      adminCtx.uid,
      "adminCreateBrandGroupBuy",
      "success",
      { groupBuyId: groupBuyDocId, title, brandId, targetAmount }
    );

    return { success: true, groupBuyId: groupBuyDocId };
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

    await logAdminAction(adminCtx.uid, "adminGetEscrowOverview", "success", {
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

// ============================================================================
// BRAND REVIEWS
// ============================================================================

// submitBrandReview and editBrandReview moved to brands.ts (consumer-facing functions)

/**
 * Admin: flag/unflag a brand review (hide from carousel or restore).
 */
export const adminFlagBrandReview = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminFlagBrandReview");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:flagBrandReview",
      "adminFlagBrandReview"
    );

    const { reviewId, isRemovedByAdmin } = request.data as {
      reviewId: string;
      isRemovedByAdmin: boolean;
    };

    if (!reviewId || typeof isRemovedByAdmin !== "boolean") {
      throw new HttpsError(
        "invalid-argument",
        "reviewId (string) and isRemovedByAdmin (boolean) are required"
      );
    }

    const reviewRef = db.collection("brandReviews").doc(reviewId);

    // Transaction: flag/unflag review + aggregate rating update (atomic)
    const brandId = await db.runTransaction(async (tx) => {
      const reviewDoc = await tx.get(reviewRef);
      if (!reviewDoc.exists) {
        throw new HttpsError("not-found", "Review not found");
      }

      const reviewData = reviewDoc.data()!;
      const reviewBrandId = reviewData.brandId;
      const reviewOverall = reviewData.overallRating || 0;
      const storefrontRef = db.collection("brandStorefronts").doc("store_" + reviewBrandId);

      tx.update(reviewRef, {
        isRemovedByAdmin,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      if (isRemovedByAdmin) {
        // Removing a review: decrement count and subtract rating
        tx.update(storefrontRef, {
          ratingSum: admin.firestore.FieldValue.increment(-reviewOverall),
          ratingCount: admin.firestore.FieldValue.increment(-1),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } else {
        // Restoring a review: increment count and add rating
        tx.update(storefrontRef, {
          ratingSum: admin.firestore.FieldValue.increment(reviewOverall),
          ratingCount: admin.firestore.FieldValue.increment(1),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      return reviewBrandId;
    });

    // Recompute averageRating outside transaction (best-effort)
    try {
      const storefrontRef = db.collection("brandStorefronts").doc("store_" + brandId);
      const storefrontDoc = await storefrontRef.get();
      const sfData = storefrontDoc.data();
      if (sfData && sfData.ratingCount > 0) {
        const avgRating = Math.round((sfData.ratingSum / sfData.ratingCount) * 10) / 10;
        await storefrontRef.update({ averageRating: avgRating });
      } else if (sfData) {
        await storefrontRef.update({ averageRating: 0 });
      }
    } catch (err) {
      logger.warn("Failed to update brand aggregate rating after flag:", err);
    }

    await logAdminAction(adminCtx.uid, "adminFlagBrandReview", "success", {
      reviewId,
      isRemovedByAdmin,
      brandId,
    });

    logger.info(
      `Brand review ${reviewId} ${isRemovedByAdmin ? "removed" : "restored"} by ${adminCtx.email}`
    );
    return { success: true };
  }
);

// ============================================================================
// SEED INITIAL BUY DATA
// ============================================================================

/**
 * Seed initial Buy Tab data: feature flags + buy categories.
 * Idempotent — skips docs that already exist.
 */
export const adminSeedBuyInitialData = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminSeedBuyInitialData");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:seedBuyData",
      "adminSeedBuyInitialData"
    );

    const now = admin.firestore.FieldValue.serverTimestamp();
    let created = 0;
    let skipped = 0;

    // ── Feature Flags ──
    const featureFlags: Array<{ key: string; enabled: boolean; global: boolean }> = [
      { key: "buy_vas_utilities", enabled: true, global: true },
      { key: "buy_my_regulars", enabled: true, global: true },
      { key: "buy_featured_carousel", enabled: true, global: true },
      { key: "buy_marketplace", enabled: true, global: true },
      { key: "buy_group_buys", enabled: false, global: false },
    ];

    // Transaction: atomic reads + batch writes to prevent duplicate creation from concurrent calls
    const { flagsCreated, flagsSkipped } = await db.runTransaction(async (tx) => {
      let txCreated = 0;
      let txSkipped = 0;

      for (const flag of featureFlags) {
        const ref = db.collection("featureFlags").doc(flag.key);
        const doc = await tx.get(ref);
        if (!doc.exists) {
          tx.set(ref, {
            featureKey: flag.key,
            isEnabled: flag.enabled,
            isGlobal: flag.global,
            enabledCommunityIds: [],
            createdAt: now,
            updatedAt: now,
          });
          txCreated++;
        } else {
          txSkipped++;
        }
      }

      return { flagsCreated: txCreated, flagsSkipped: txSkipped };
    });

    created += flagsCreated;
    skipped += flagsSkipped;

    // ── Buy Categories (16 marketplace service categories) ──
    const categories: Array<{
      id: string;
      name: string;
      emoji: string;
      sort: number;
      active: boolean;
      comingSoon: boolean;
      mapping?: string;
      subcategories: Array<{ id: string; name: string; emoji: string }>;
    }> = [
      {
        id: "personal-care-beauty", name: "Personal Care & Beauty", emoji: "✨", sort: 1, active: true, comingSoon: false,
        subcategories: [
          { id: "hairdresser", name: "Hairdresser", emoji: "✂️" },
          { id: "barber", name: "Barber", emoji: "✂️" },
          { id: "nail-technician", name: "Nail Technician", emoji: "🖌️" },
          { id: "body-facial-therapist", name: "Body & Facial Therapist", emoji: "✨" },
          { id: "makeup-artist", name: "Makeup Artist", emoji: "🖌️" },
          { id: "massage-therapist", name: "Massage Therapist", emoji: "🤚" },
          { id: "beauty-therapist", name: "Beauty Therapist", emoji: "🪞" },
          { id: "wellness-practitioner", name: "Wellness Practitioner", emoji: "🌸" },
          { id: "tattoo-artist", name: "Tattoo Artist", emoji: "🖊️" },
          { id: "piercing-artist", name: "Piercing Artist", emoji: "⊙" },
        ],
      },
      {
        id: "home-maintenance-trades", name: "Home Maintenance & Trades", emoji: "🔧", sort: 2, active: true, comingSoon: false,
        subcategories: [
          { id: "electrician", name: "Electrician", emoji: "⚡" },
          { id: "plumber", name: "Plumber", emoji: "🔧" },
          { id: "carpenter", name: "Carpenter", emoji: "🔨" },
          { id: "painter", name: "Painter", emoji: "🖌️" },
          { id: "builder", name: "Builder", emoji: "🧱" },
          { id: "handyman", name: "Handyman", emoji: "🧰" },
          { id: "paving", name: "Paving", emoji: "▦" },
          { id: "roofing", name: "Roofing", emoji: "🏠" },
          { id: "tiling", name: "Tiling", emoji: "⊞" },
          { id: "plastering", name: "Plastering", emoji: "🪣" },
        ],
      },
      {
        id: "outdoor-services", name: "Outdoor Services", emoji: "🍃", sort: 3, active: true, comingSoon: false,
        subcategories: [
          { id: "gardening", name: "Gardening", emoji: "🍃" },
          { id: "landscaping", name: "Landscaping", emoji: "🌳" },
          { id: "pool-maintenance", name: "Pool Maintenance", emoji: "🌊" },
          { id: "tree-care", name: "Tree Care", emoji: "🌲" },
          { id: "irrigation", name: "Irrigation", emoji: "💧" },
          { id: "fence-installation", name: "Fence Installation", emoji: "⬜" },
          { id: "pest-control", name: "Pest Control", emoji: "🐛" },
        ],
      },
      {
        id: "cleaning-household", name: "Cleaning & Household", emoji: "🧹", sort: 4, active: true, comingSoon: false,
        subcategories: [
          { id: "domestic-cleaning", name: "Domestic Cleaning", emoji: "🧹" },
          { id: "housekeeping", name: "Housekeeping", emoji: "✨" },
          { id: "laundry", name: "Laundry", emoji: "🫧" },
          { id: "ironing", name: "Ironing", emoji: "👔" },
          { id: "window-cleaning", name: "Window Cleaning", emoji: "🪟" },
        ],
      },
      {
        id: "moving-transport", name: "Moving & Transport", emoji: "🚚", sort: 5, active: true, comingSoon: false,
        subcategories: [
          { id: "removals", name: "Removals", emoji: "🚚" },
          { id: "furniture-moving", name: "Furniture Moving", emoji: "🛋️" },
          { id: "delivery", name: "Delivery", emoji: "📦" },
          { id: "courier", name: "Courier", emoji: "🚲" },
          { id: "errand-running", name: "Errand Running", emoji: "☑️" },
        ],
      },
      {
        id: "childcare-caregiving", name: "Childcare & Caregiving", emoji: "👶", sort: 6, active: true, comingSoon: false,
        subcategories: [
          { id: "babysitting", name: "Babysitting", emoji: "👶" },
          { id: "nanny", name: "Nanny", emoji: "🤝" },
          { id: "elderly-care", name: "Elderly Care", emoji: "👤" },
          { id: "caregiver", name: "Caregiver", emoji: "🤲" },
        ],
      },
      {
        id: "pet-services", name: "Pet Services", emoji: "🐾", sort: 7, active: true, comingSoon: false,
        subcategories: [
          { id: "pet-sitting", name: "Pet Sitting", emoji: "🐾" },
          { id: "pet-grooming", name: "Pet Grooming", emoji: "✂️" },
          { id: "dog-walking", name: "Dog Walking", emoji: "🐕" },
          { id: "pet-boarding", name: "Pet Boarding", emoji: "🏠" },
          { id: "pet-training", name: "Pet Training", emoji: "📣" },
        ],
      },
      {
        id: "education-tutoring", name: "Education & Tutoring", emoji: "📖", sort: 8, active: true, comingSoon: false,
        subcategories: [
          { id: "tutor", name: "Tutor", emoji: "📖" },
          { id: "language-tutor", name: "Language Tutor", emoji: "🌐" },
          { id: "music-teacher", name: "Music Teacher", emoji: "🎵" },
          { id: "art-teacher", name: "Art Teacher", emoji: "🎨" },
          { id: "exam-preparation", name: "Exam Preparation", emoji: "📋" },
        ],
      },
      {
        id: "creative-media", name: "Creative & Media", emoji: "🎨", sort: 9, active: true, comingSoon: false,
        subcategories: [
          { id: "artist", name: "Artist", emoji: "🎨" },
          { id: "photographer", name: "Photographer", emoji: "📷" },
          { id: "videographer", name: "Videographer", emoji: "📹" },
          { id: "graphic-designer", name: "Graphic Designer", emoji: "🖊️" },
          { id: "interior-decorator", name: "Interior Decorator", emoji: "🛋️" },
        ],
      },
      {
        id: "fitness-health", name: "Fitness & Health", emoji: "🏋️", sort: 10, active: true, comingSoon: false,
        subcategories: [
          { id: "personal-trainer", name: "Personal Trainer", emoji: "🏋️" },
          { id: "yoga-instructor", name: "Yoga Instructor", emoji: "🌸" },
          { id: "fitness-coach", name: "Fitness Coach", emoji: "⏱️" },
          { id: "nutrition-coach", name: "Nutrition Coach", emoji: "🍎" },
        ],
      },
      {
        id: "professional-services", name: "Professional Services", emoji: "🧮", sort: 11, active: true, comingSoon: false,
        subcategories: [
          { id: "bookkeeping", name: "Bookkeeping", emoji: "🧮" },
          { id: "tax-services", name: "Tax Services", emoji: "🧾" },
          { id: "legal-advice", name: "Legal Advice", emoji: "⚖️" },
          { id: "translator", name: "Translator", emoji: "🌐" },
          { id: "business-consulting", name: "Business Consulting", emoji: "📈" },
        ],
      },
      {
        id: "medical", name: "Medical", emoji: "🩺", sort: 12, active: true, comingSoon: false,
        subcategories: [
          { id: "doctor", name: "Doctor", emoji: "🩺" },
          { id: "dentist", name: "Dentist", emoji: "😊" },
          { id: "psychologist", name: "Psychologist", emoji: "🧠" },
          { id: "psychiatrist", name: "Psychiatrist", emoji: "🧠" },
          { id: "herbalist", name: "Herbalist", emoji: "🍃" },
        ],
      },
      {
        id: "repairs-technical", name: "Repairs & Technical", emoji: "💻", sort: 13, active: true, comingSoon: false,
        subcategories: [
          { id: "it-services", name: "IT Services", emoji: "💻" },
          { id: "computer-repair", name: "Computer Repair", emoji: "🖥️" },
          { id: "mobile-repair", name: "Mobile Repair", emoji: "📱" },
          { id: "appliance-repair", name: "Appliance Repair", emoji: "🫧" },
          { id: "electronics-repair", name: "Electronics Repair", emoji: "🔌" },
        ],
      },
      {
        id: "clothing", name: "Clothing", emoji: "✂️", sort: 14, active: true, comingSoon: false,
        subcategories: [
          { id: "seamstress", name: "Seamstress", emoji: "📌" },
          { id: "tailor", name: "Tailor", emoji: "📏" },
          { id: "clothing-alterations", name: "Clothing Alterations", emoji: "✂️" },
        ],
      },
      {
        id: "events", name: "Events", emoji: "📅", sort: 15, active: true, comingSoon: false,
        subcategories: [
          { id: "catering", name: "Catering", emoji: "🍴" },
          { id: "event-planner", name: "Event Planner", emoji: "📅" },
          { id: "dj", name: "DJ", emoji: "💿" },
          { id: "decor", name: "Decor", emoji: "🎉" },
        ],
      },
      {
        id: "labour", name: "Labour", emoji: "⛑️", sort: 16, active: true, comingSoon: false,
        subcategories: [
          { id: "domestic-worker", name: "Domestic Worker", emoji: "🧹" },
          { id: "day-laborer", name: "Day Laborer", emoji: "⛑️" },
          { id: "general-helper", name: "General Helper", emoji: "🧰" },
          { id: "construction-worker", name: "Construction Worker", emoji: "⛑️" },
        ],
      },
    ];

    // Transaction: atomic reads + writes for categories to prevent duplicates from concurrent calls
    const { catsCreated, catsSkipped } = await db.runTransaction(async (tx) => {
      let txCreated = 0;
      let txSkipped = 0;

      for (const cat of categories) {
        const ref = db.collection("buyCategories").doc(cat.id);
        const doc = await tx.get(ref);
        if (!doc.exists) {
          tx.set(ref, {
            name: cat.name,
            iconEmoji: cat.emoji,
            sortOrder: cat.sort,
            isActive: cat.active,
            isComingSoon: cat.comingSoon,
            purchaseCategoryMapping: cat.mapping || null,
            featureFlagKey: null,
            logoUrl: null,
            backgroundColor: null,
            subcategories: cat.subcategories,
            createdAt: now,
            updatedAt: now,
          });
          txCreated++;
        } else {
          txSkipped++;
        }
      }

      return { catsCreated: txCreated, catsSkipped: txSkipped };
    });

    created += catsCreated;
    skipped += catsSkipped;

    await logAdminAction(adminCtx.uid, "adminSeedBuyInitialData", "success", {
      created,
      skipped,
    });

    logger.info(`Buy data seeded by ${adminCtx.email}: ${created} created, ${skipped} skipped`);
    return { success: true, created, skipped };
  }
);

// ============================================================================
// PROVIDER MODERATION
// ============================================================================

/**
 * Ban a marketplace provider — permanently disables their account.
 * Cascades: removes all active listings, refunds open orders.
 */
export const adminBanProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminBanProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:banProvider",
      "adminBanProvider"
    );

    const { providerId, reason } = request.data;
    if (!providerId || typeof providerId !== "string") {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }

    const providerRef = db.collection("providers").doc(providerId);
    const providerDoc = await providerRef.get();
    if (!providerDoc.exists) {
      throw new HttpsError("not-found", "Provider not found");
    }

    const provider = providerDoc.data()!;
    if (provider.status === "banned") {
      return { success: true, message: "Provider is already banned" };
    }

    // Ban provider
    await providerRef.update({
      status: "banned",
      suspensionReason: reason || "Banned by admin",
      suspensionTrigger: "admin_ban",
      bannedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Remove all active/paused/pending/flagged listings (batch-size safe: chunks of 500)
    const listingsSnap = await db
      .collection("marketplaceListings")
      .where("providerId", "==", providerId)
      .where("status", "in", ["active", "paused", "pending", "flagged"])
      .get();

    const listingDocs = listingsSnap.docs;
    for (let i = 0; i < listingDocs.length; i += 500) {
      const chunk = listingDocs.slice(i, i + 500);
      const listBatch = db.batch();
      for (const doc of chunk) {
        listBatch.update(doc.ref, {
          status: "removed",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      await listBatch.commit();
    }

    // Refund open orders (escrowed/fulfilled) — track failures
    const openOrders = await db
      .collection("buyOrders")
      .where("sellerId", "==", provider.userId)
      .where("status", "in", ["escrowed", "fulfilled"])
      .get();

    let refundedCount = 0;
    const failedOrderIds: string[] = [];
    for (const doc of openOrders.docs) {
      const order = doc.data();
      try {
        // Idempotency guard: skip orders already refunded
        if (order.refundJournalId) {
          refundedCount++;
          continue;
        }
        if (!order.buyerId) {
          logger.error(`Order ${doc.id} missing buyerId, skipping refund`);
          failedOrderIds.push(doc.id);
          continue;
        }
        if (!order.escrowJournalId) {
          // No escrow was processed — just cancel
          await doc.ref.update({
            status: "cancelled",
            cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          refundedCount++;
          continue;
        }
        const journalId = await refundMarketplaceEscrow(
          order.buyerId,
          order.amount,
          doc.id,
          `Admin ban refund: provider ${providerId} banned`
        );
        await doc.ref.update({
          status: "refunded",
          refundJournalId: journalId,
          refundType: "admin_ban",
          refundedAt: admin.firestore.FieldValue.serverTimestamp(),
          cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        refundedCount++;
      } catch (err) {
        logger.error(`Failed to refund order ${doc.id} during provider ban`, err);
        failedOrderIds.push(doc.id);
      }
    }

    // Notify the provider about the ban
    if (provider.userId) {
      try {
        await db.collection("notifications").add({
          userId: provider.userId,
          type: "providerBanned",
          title: "Account Banned",
          body: reason
            ? `Your provider account has been banned: ${reason}`
            : "Your provider account has been banned.",
          data: { providerId },
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch (err) {
        logger.warn("Failed to create ban notification:", err);
      }
    }

    await logAdminAction(adminCtx.uid, "adminBanProvider", "success", {
      providerId,
      reason,
      listingsRemoved: listingsSnap.size,
      ordersRefunded: refundedCount,
      failedOrderIds,
    });

    logger.info(
      `Provider ${providerId} banned by ${adminCtx.email}: ${listingsSnap.size} listings removed, ${refundedCount} orders refunded, ${failedOrderIds.length} failed`
    );
    return { success: true, listingsRemoved: listingsSnap.size, ordersRefunded: refundedCount, failedOrderIds };
  }
);

/**
 * Reinstate a suspended or banned provider.
 */
export const adminReinstateProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminReinstateProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:reinstateProvider",
      "adminReinstateProvider"
    );

    const { providerId } = request.data;
    if (!providerId || typeof providerId !== "string") {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }

    const providerRef = db.collection("providers").doc(providerId);
    const providerDoc = await providerRef.get();
    if (!providerDoc.exists) {
      throw new HttpsError("not-found", "Provider not found");
    }

    const provider = providerDoc.data()!;
    if (provider.status === "approved") {
      return { success: true, message: "Provider is already approved" };
    }

    await providerRef.update({
      status: "approved",
      suspensionReason: null,
      suspensionTrigger: null,
      suspendedAt: null,
      bannedAt: null,
      // Preserve warningCount for audit trail — don't reset to 0
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Notify the provider about reinstatement
    if (provider.userId) {
      try {
        await db.collection("notifications").add({
          userId: provider.userId,
          type: "providerReinstated",
          title: "Account Reinstated",
          body: "Your provider account has been reinstated. You can now resume selling.",
          data: { providerId },
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch (err) {
        logger.warn("Failed to create reinstatement notification:", err);
      }
    }

    await logAdminAction(adminCtx.uid, "adminReinstateProvider", "success", {
      providerId,
      previousStatus: provider.status,
    });

    logger.info(`Provider ${providerId} reinstated by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * Admin partial refund — refund a portion of an order back to buyer.
 */
export const adminPartialRefund = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminPartialRefund");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:partialRefund",
      "adminPartialRefund"
    );

    const { orderId, refundAmount, reason } = request.data;
    if (!orderId || typeof orderId !== "string") {
      throw new HttpsError("invalid-argument", "Order ID is required");
    }
    if (!refundAmount || typeof refundAmount !== "number" || refundAmount <= 0 || !Number.isInteger(refundAmount)) {
      throw new HttpsError("invalid-argument", "Refund amount must be a positive integer");
    }

    // Two-phase approach: transaction validates and extracts data,
    // then refund + final update happen atomically outside.
    // The transaction marks the order as processing to prevent concurrent refunds.
    const orderRef = db.collection("buyOrders").doc(orderId);
    const order = await db.runTransaction(async (tx) => {
      const orderDoc = await tx.get(orderRef);
      if (!orderDoc.exists) {
        throw new HttpsError("not-found", "Order not found");
      }
      const data = orderDoc.data()!;

      if (!["escrowed", "fulfilled", "disputed", "completed"].includes(data.status)) {
        throw new HttpsError("failed-precondition", `Cannot refund order with status: ${data.status}`);
      }
      if (data.refundJournalId) {
        throw new HttpsError("failed-precondition", "This order has already been refunded");
      }
      if (!data.buyerId) {
        throw new HttpsError("failed-precondition", "Order is missing buyer ID");
      }
      if (refundAmount > data.amount) {
        throw new HttpsError("invalid-argument", "Refund amount exceeds order total");
      }

      // Mark as processing to prevent concurrent refund
      tx.update(orderRef, { disputeResolution: "partial_refund_processing" });
      return data;
    });

    // Execute refund and final update sequentially — the processing lock above
    // prevents concurrent calls from double-refunding.
    const journalId = await refundMarketplaceEscrow(
      order.buyerId,
      refundAmount,
      orderId,
      `Admin partial refund: ${reason || "Admin decision"}`
    );

    await orderRef.update({
      disputeResolution: "partial_refund",
      disputeResolutionAmount: refundAmount,
      disputeResolutionNote: reason || "Admin partial refund",
      refundJournalId: journalId,
      refundedAt: admin.firestore.FieldValue.serverTimestamp(),
      resolvedAt: admin.firestore.FieldValue.serverTimestamp(),
      status: order.status === "disputed" ? "resolved" : order.status,
    });

    await logAdminAction(adminCtx.uid, "adminPartialRefund", "success", {
      orderId,
      refundAmount,
      originalAmount: order.amount,
      reason,
    });

    logger.info(`Order ${orderId} partial refund of ${refundAmount} by ${adminCtx.email}`);
    return { success: true, journalId };
  }
);

/**
 * Admin requires buyer to return item before refund is processed.
 * Sets order to "return_required" status.
 */
export const adminRequireReturn = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminRequireReturn");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:requireReturn",
      "adminRequireReturn"
    );

    const { orderId, instructions } = request.data;
    if (!orderId || typeof orderId !== "string") {
      throw new HttpsError("invalid-argument", "Order ID is required");
    }

    const orderRef = db.collection("buyOrders").doc(orderId);
    const orderDoc = await orderRef.get();
    if (!orderDoc.exists) {
      throw new HttpsError("not-found", "Order not found");
    }
    const order = orderDoc.data()!;

    if (order.status !== "disputed") {
      throw new HttpsError("failed-precondition", "Only disputed orders can require return");
    }

    await orderRef.update({
      status: "return_required",
      disputeResolution: "return_required",
      disputeResolutionNote: instructions || "Please return the item to the seller",
      resolvedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminRequireReturn", "success", {
      orderId,
      instructions,
    });

    logger.info(`Order ${orderId} return required by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * Admin escalate dispute to SMS (for users without push notification access).
 */
export const adminEscalateToSms = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminEscalateToSms");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:escalateToSms",
      "adminEscalateToSms"
    );

    const { orderId, recipientUserId, message } = request.data;
    if (!orderId || typeof orderId !== "string") {
      throw new HttpsError("invalid-argument", "orderId must be a non-empty string");
    }
    if (!recipientUserId || typeof recipientUserId !== "string") {
      throw new HttpsError("invalid-argument", "recipientUserId must be a non-empty string");
    }
    if (!message || typeof message !== "string" || message.trim().length === 0) {
      throw new HttpsError("invalid-argument", "message must be a non-empty string");
    }

    const userDoc = await db.collection("users").doc(recipientUserId).get();
    if (!userDoc.exists) {
      throw new HttpsError("not-found", "User not found");
    }
    const phoneNumber = userDoc.data()?.phoneNumber;
    if (!phoneNumber) {
      throw new HttpsError("failed-precondition", "User has no phone number on file");
    }

    // Create SMS record for external SMS service to pick up
    await db.collection("smsQueue").doc().set({
      to: phoneNumber,
      body: message.trim().substring(0, 160),
      orderId,
      userId: recipientUserId,
      sentBy: adminCtx.uid,
      status: "pending",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminEscalateToSms", "success", {
      orderId,
      recipientUserId,
    });

    logger.info(`SMS escalation queued for order ${orderId} by ${adminCtx.email}`);
    return { success: true };
  }
);

// ============================================================================
// SELLER LEVEL CONFIG & BANNED WORDS
// ============================================================================

/**
 * Update seller level thresholds in the marketplace config.
 */
export const adminUpdateSellerLevelConfig = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateSellerLevelConfig");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateSellerLevelConfig",
      "adminUpdateSellerLevelConfig"
    );

    const { thresholds } = request.data;
    if (!thresholds || typeof thresholds !== "object") {
      throw new HttpsError("invalid-argument", "Thresholds object is required");
    }

    // Validate thresholds structure
    const requiredLevels = ["active", "trusted", "star"];
    for (const level of requiredLevels) {
      if (!thresholds[level]) {
        throw new HttpsError("invalid-argument", `Missing threshold for level: ${level}`);
      }
      if (typeof thresholds[level].sales !== "number" || typeof thresholds[level].rating !== "number") {
        throw new HttpsError("invalid-argument", `Each level needs 'sales' (number) and 'rating' (number)`);
      }
    }

    await db.collection("config").doc("marketplace").set(
      {
        sellerLevelThresholds: thresholds,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true }
    );

    await logAdminAction(adminCtx.uid, "adminUpdateSellerLevelConfig", "success", {
      thresholds,
    });

    logger.info(`Seller level config updated by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * Update banned words list in marketplace config.
 */
export const adminUpdateBannedWords = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateBannedWords");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateBannedWords",
      "adminUpdateBannedWords"
    );

    const { bannedWords } = request.data;
    if (!Array.isArray(bannedWords)) {
      throw new HttpsError("invalid-argument", "bannedWords must be an array of strings");
    }

    // Normalize and deduplicate
    const normalized = [...new Set(
      bannedWords
        .filter((w: unknown) => typeof w === "string" && w.trim().length > 0)
        .map((w: string) => w.trim().toLowerCase())
    )];

    await db.collection("config").doc("marketplace").set(
      {
        bannedWords: normalized,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true }
    );

    await logAdminAction(adminCtx.uid, "adminUpdateBannedWords", "success", {
      wordCount: normalized.length,
    });

    logger.info(`Banned words updated (${normalized.length} words) by ${adminCtx.email}`);
    return { success: true, wordCount: normalized.length };
  }
);

// ============================================================================
// BRAND PRODUCT CRUD
// ============================================================================

/**
 * List products for a brand storefront.
 */
export const adminListBrandProducts = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminListBrandProducts");
    await requireAdminPermission(
      request,
      "buy:listBrandProducts",
      "adminListBrandProducts"
    );

    const { storefrontId } = request.data;
    if (!storefrontId || typeof storefrontId !== "string") {
      throw new HttpsError("invalid-argument", "Storefront ID is required");
    }

    try {
      const productsSnap = await db
        .collection("brandProducts")
        .where("storefrontId", "==", storefrontId)
        .where("isDeleted", "==", false)
        .orderBy("sortOrder", "asc")
        .get();

      const products = productsSnap.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      return { success: true, products };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      logger.error(`adminListBrandProducts failed for ${storefrontId}: ${msg}`);
      if (msg.includes("index")) {
        throw new HttpsError(
          "failed-precondition",
          `Firestore index not ready yet. Please wait a few minutes and retry. (${msg})`
        );
      }
      throw new HttpsError("internal", `Failed to list products: ${msg}`);
    }
  }
);

/**
 * Create a brand product.
 */
export const adminCreateBrandProduct = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateBrandProduct");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createBrandProduct",
      "adminCreateBrandProduct"
    );

    const {
      storefrontId, name, description, priceZar, imageUrl, externalUrl,
      sortOrder, isFeatured, category, fulfilmentType, stockCount,
      contactMethod, voucherInstructions, collectionAddress, deliveryInfo,
    } = request.data;

    if (!storefrontId || !name) {
      throw new HttpsError("invalid-argument", "storefrontId and name are required");
    }

    // Verify storefront exists
    const storefrontDoc = await db.collection("brandStorefronts").doc(storefrontId).get();
    if (!storefrontDoc.exists) {
      throw new HttpsError("not-found", "Storefront not found");
    }

    const validFulfilmentTypes = ["digital", "physical", "catalog"];
    const safeFulfilment = validFulfilmentTypes.includes(fulfilmentType)
      ? fulfilmentType
      : "catalog";

    const productRef = db.collection("brandProducts").doc();
    await productRef.set({
      id: productRef.id,
      storefrontId,
      brandId: storefrontDoc.data()!.brandId || storefrontId,
      name: name.trim(),
      description: description?.trim() || null,
      priceZar: priceZar ?? null,
      priceTokens: priceZar ? Math.round(priceZar * 100) : null,
      imageUrl: imageUrl || null,
      externalUrl: externalUrl || null,
      sortOrder: sortOrder || 0,
      isActive: true,
      isFeatured: isFeatured === true,
      isDeleted: false,
      category: category?.trim() || null,
      fulfilmentType: safeFulfilment,
      stockCount: typeof stockCount === "number" ? stockCount : null,
      contactMethod: contactMethod?.trim() || null,
      voucherInstructions: voucherInstructions?.trim() || null,
      collectionAddress: collectionAddress?.trim() || null,
      deliveryInfo: deliveryInfo?.trim() || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminCreateBrandProduct", "success", {
      productId: productRef.id,
      storefrontId,
      name,
    });

    logger.info(`Brand product ${productRef.id} created by ${adminCtx.email}`);
    return { success: true, productId: productRef.id };
  }
);

/**
 * Update a brand product.
 */
export const adminUpdateBrandProduct = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateBrandProduct");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateBrandProduct",
      "adminUpdateBrandProduct"
    );

    const { productId, ...updates } = request.data;
    if (!productId || typeof productId !== "string") {
      throw new HttpsError("invalid-argument", "Product ID is required");
    }

    const productRef = db.collection("brandProducts").doc(productId);
    const productDoc = await productRef.get();
    if (!productDoc.exists) {
      throw new HttpsError("not-found", "Product not found");
    }

    const allowedFields = [
      "name", "description", "priceZar", "imageUrl", "externalUrl",
      "sortOrder", "isActive", "isFeatured", "category", "fulfilmentType",
      "stockCount", "contactMethod", "voucherInstructions",
      "collectionAddress", "deliveryInfo",
    ];
    const safeUpdates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const key of allowedFields) {
      if (updates[key] !== undefined) {
        safeUpdates[key] = updates[key];
      }
    }
    // Auto-calculate priceTokens when priceZar changes
    if (updates.priceZar !== undefined) {
      safeUpdates.priceTokens = updates.priceZar ? Math.round(updates.priceZar * 100) : null;
    }

    await productRef.update(safeUpdates);

    await logAdminAction(adminCtx.uid, "adminUpdateBrandProduct", "success", {
      productId,
      updatedFields: Object.keys(safeUpdates),
    });

    logger.info(`Brand product ${productId} updated by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * Delete (soft) a brand product.
 */
export const adminDeleteBrandProduct = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminDeleteBrandProduct");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:deleteBrandProduct",
      "adminDeleteBrandProduct"
    );

    const { productId } = request.data;
    if (!productId || typeof productId !== "string") {
      throw new HttpsError("invalid-argument", "Product ID is required");
    }

    const productRef = db.collection("brandProducts").doc(productId);
    const productDoc = await productRef.get();
    if (!productDoc.exists) {
      throw new HttpsError("not-found", "Product not found");
    }

    await productRef.update({
      isActive: false,
      isDeleted: true,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminDeleteBrandProduct", "success", {
      productId,
    });

    logger.info(`Brand product ${productId} deleted by ${adminCtx.email}`);
    return { success: true };
  }
);

// ============================================================================
// VAS PROVIDER & PRODUCT ADMIN
// ============================================================================

/**
 * List all VAS providers with optional category filter.
 * Includes product counts per provider.
 */
export const adminListVasProviders = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminListVasProviders");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:listVasProviders",
      "adminListVasProviders"
    );

    const { category, includeInactive } = request.data || {};

    let query: admin.firestore.Query = db.collection("serviceProviders");

    if (category && typeof category === "string") {
      query = query.where("category", "==", category);
    }

    if (!includeInactive) {
      query = query.where("isActive", "==", true);
    }

    query = query.orderBy("sortOrder");

    const snapshot = await query.get();

    const providers = await Promise.all(
      snapshot.docs.map(async (doc) => {
        const data = doc.data();
        // Count products for this provider
        const productsSnap = await db
          .collection("serviceProducts")
          .where("providerId", "==", doc.id)
          .count()
          .get();

        return {
          id: doc.id,
          ...data,
          productCount: productsSnap.data().count,
        };
      })
    );

    await logAdminAction(adminCtx.uid, "adminListVasProviders", "success", {
      category: category || "all",
      count: providers.length,
    });

    return { success: true, providers };
  }
);

/**
 * Create a VAS provider (e.g., Eskom for electricity, Vodacom for airtime).
 */
export const adminCreateVasProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateVasProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createVasProvider",
      "adminCreateVasProvider"
    );

    const { name, code, category, logoUrl, description, sortOrder } = request.data;
    if (!name || !code || !category) {
      throw new HttpsError("invalid-argument", "name, code, and category are required");
    }

    // Validate category
    const validCategories = ["airtime", "data", "electricity", "voucher", "marketplace", "school", "municipal", "insurance", "funeral", "stokvel", "gaming", "other"];
    if (!validCategories.includes(category)) {
      throw new HttpsError("invalid-argument", `category must be one of: ${validCategories.join(", ")}`);
    }

    // Validate provider name length
    const trimmedName = name.trim();
    if (trimmedName.length > 100) {
      throw new HttpsError("invalid-argument", "Provider name must be 100 characters or less");
    }

    // Validate provider code length
    const trimmedCode = code.trim().toLowerCase();
    if (trimmedCode.length < 2 || trimmedCode.length > 20) {
      throw new HttpsError("invalid-argument", "Provider code must be 2-20 characters");
    }

    // Check code uniqueness
    const existing = await db
      .collection("serviceProviders")
      .where("code", "==", code)
      .limit(1)
      .get();
    if (!existing.empty) {
      throw new HttpsError("already-exists", `Provider with code "${code}" already exists`);
    }

    const ref = db.collection("serviceProviders").doc();
    await ref.set({
      id: ref.id,
      name: name.trim(),
      code: code.trim().toLowerCase(),
      category,
      logoUrl: logoUrl || null,
      description: description?.trim() || null,
      sortOrder: sortOrder || 0,
      isActive: true,
      isDeleted: false,
      productsCount: 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminCreateVasProvider", "success", {
      providerId: ref.id,
      name,
      code,
      category,
    });

    logger.info(`VAS provider ${ref.id} (${code}) created by ${adminCtx.email}`);
    return { success: true, providerId: ref.id };
  }
);

/**
 * Update a VAS provider.
 */
export const adminUpdateVasProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateVasProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateVasProvider",
      "adminUpdateVasProvider"
    );

    const { providerId, ...updates } = request.data;
    if (!providerId) {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }

    const ref = db.collection("serviceProviders").doc(providerId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "VAS provider not found");
    }

    const allowedFields = ["name", "code", "category", "logoUrl", "description", "sortOrder"];
    const safeUpdates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const key of allowedFields) {
      if (updates[key] !== undefined) {
        safeUpdates[key] = typeof updates[key] === "string" ? updates[key].trim() : updates[key];
      }
    }

    await ref.update(safeUpdates);

    await logAdminAction(adminCtx.uid, "adminUpdateVasProvider", "success", {
      providerId,
    });

    logger.info(`VAS provider ${providerId} updated by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * Toggle VAS provider active/inactive.
 */
export const adminToggleVasProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminToggleVasProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:toggleVasProvider",
      "adminToggleVasProvider"
    );

    const { providerId } = request.data;
    if (!providerId) {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }

    const ref = db.collection("serviceProviders").doc(providerId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "VAS provider not found");
    }

    const newStatus = !doc.data()!.isActive;
    await ref.update({
      isActive: newStatus,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminToggleVasProvider", "success", {
      providerId,
      isActive: newStatus,
    });

    logger.info(`VAS provider ${providerId} toggled to ${newStatus ? "active" : "inactive"} by ${adminCtx.email}`);
    return { success: true, isActive: newStatus };
  }
);

/**
 * Soft-delete a VAS provider.
 */
export const adminDeleteVasProvider = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminDeleteVasProvider");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:deleteVasProvider",
      "adminDeleteVasProvider"
    );

    const { providerId } = request.data;
    if (!providerId) {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }

    const ref = db.collection("serviceProviders").doc(providerId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "VAS provider not found");
    }

    // Soft-delete all provider's products as part of the cascade
    const allProducts = await db.collection("serviceProducts")
      .where("providerId", "==", providerId)
      .where("isDeleted", "==", false)
      .get();

    if (!allProducts.empty) {
      for (let i = 0; i < allProducts.docs.length; i += 500) {
        const chunk = allProducts.docs.slice(i, i + 500);
        const productBatch = db.batch();
        for (const productDoc of chunk) {
          productBatch.update(productDoc.ref, {
            isActive: false,
            isDeleted: true,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
        await productBatch.commit();
      }
    }

    await ref.update({
      isActive: false,
      isDeleted: true,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminDeleteVasProvider", "success", {
      providerId,
    });

    logger.info(`VAS provider ${providerId} deleted by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * List VAS products for a specific provider. Admin-only.
 */
export const adminListVasProducts = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminListVasProducts");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:listVasProducts",
      "adminListVasProducts"
    );

    const { providerId, includeInactive, startAfterId } = request.data;
    if (!providerId || typeof providerId !== "string") {
      throw new HttpsError("invalid-argument", "providerId is required");
    }

    // Validate startAfterId if provided
    if (startAfterId !== undefined && startAfterId !== null) {
      if (typeof startAfterId !== "string" || startAfterId.trim().length === 0) {
        throw new HttpsError("invalid-argument", "startAfterId must be a non-empty string");
      }
    }

    let query: admin.firestore.Query = db
      .collection("serviceProducts")
      .where("providerId", "==", providerId)
      .where("isDeleted", "==", false);

    if (!includeInactive) {
      query = query.where("isActive", "==", true);
    }

    query = query.orderBy("sortOrder").limit(100);

    if (startAfterId && typeof startAfterId === "string" && startAfterId.trim().length > 0) {
      const startAfterDoc = await db.collection("serviceProducts").doc(startAfterId).get();
      if (startAfterDoc.exists) {
        query = query.startAfter(startAfterDoc);
      }
    }

    const snapshot = await query.get();
    const products = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
      createdAt: doc.data().createdAt?.toDate?.()?.toISOString() ?? null,
      updatedAt: doc.data().updatedAt?.toDate?.()?.toISOString() ?? null,
    }));

    await logAdminAction(adminCtx.uid, "listVasProducts", "success", { providerId });

    logger.info(`Admin ${adminCtx.email} listed ${products.length} VAS products for provider ${providerId}`);
    return { success: true, products };
  }
);

/**
 * Create a VAS product under a provider.
 */
export const adminCreateVasProduct = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateVasProduct");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createVasProduct",
      "adminCreateVasProduct"
    );

    const { providerId, name, code, priceZar, validity, metadata, sortOrder } = request.data;
    if (!providerId || !name || !code) {
      throw new HttpsError("invalid-argument", "providerId, name, and code are required");
    }
    if (typeof priceZar !== "number" || priceZar <= 0) {
      throw new HttpsError("invalid-argument", "priceZar must be a positive number");
    }

    // Validate token price bounds
    const priceTokens = Math.round(priceZar * 100);
    if (priceTokens <= 0 || priceTokens > 1000000) {
      throw new HttpsError("invalid-argument", "Calculated token price must be between 1 and 1,000,000 tokens");
    }

    // Verify provider exists
    const providerDoc = await db.collection("serviceProviders").doc(providerId).get();
    if (!providerDoc.exists) {
      throw new HttpsError("not-found", "VAS provider not found");
    }

    // Deterministic product ID based on provider and product code
    const productId = `${providerId}_${code.trim().toLowerCase().replace(/[^a-z0-9]/g, "")}`;
    const productRef = db.collection("serviceProducts").doc(productId);
    const existingProduct = await productRef.get();
    if (existingProduct.exists && !existingProduct.data()!.isDeleted) {
      throw new HttpsError("already-exists", "Product with this provider and code already exists");
    }

    // Batch: create product + increment counter atomically
    const batch = db.batch();
    batch.set(productRef, {
      id: productRef.id,
      providerId,
      providerCode: providerDoc.data()!.code,
      name: name.trim(),
      code: code.trim(),
      priceZar,
      priceTokens,
      validity: validity || null,
      metadata: metadata || {},
      sortOrder: sortOrder || 0,
      isActive: true,
      isDeleted: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    batch.update(db.collection("serviceProviders").doc(providerId), {
      productsCount: admin.firestore.FieldValue.increment(1),
    });
    await batch.commit();

    await logAdminAction(adminCtx.uid, "adminCreateVasProduct", "success", {
      productId: productRef.id,
      providerId,
      name,
      code,
      priceZar,
    });

    logger.info(`VAS product ${productRef.id} created by ${adminCtx.email}`);
    return { success: true, productId: productRef.id };
  }
);

/**
 * Update a VAS product.
 */
export const adminUpdateVasProduct = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateVasProduct");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateVasProduct",
      "adminUpdateVasProduct"
    );

    const { productId, ...updates } = request.data;
    if (!productId) {
      throw new HttpsError("invalid-argument", "Product ID is required");
    }

    const ref = db.collection("serviceProducts").doc(productId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "VAS product not found");
    }

    const allowedFields = ["name", "code", "priceZar", "validity", "metadata", "sortOrder"];
    const safeUpdates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const key of allowedFields) {
      if (updates[key] !== undefined) {
        safeUpdates[key] = updates[key];
      }
    }
    if (updates.priceZar !== undefined) {
      safeUpdates.priceTokens = Math.round(updates.priceZar * 100);
    }

    await ref.update(safeUpdates);

    await logAdminAction(adminCtx.uid, "adminUpdateVasProduct", "success", {
      productId,
    });

    logger.info(`VAS product ${productId} updated by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * Toggle a VAS product active/inactive.
 */
export const adminToggleVasProduct = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminToggleVasProduct");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:toggleVasProduct",
      "adminToggleVasProduct"
    );

    const { productId } = request.data;
    if (!productId) {
      throw new HttpsError("invalid-argument", "Product ID is required");
    }

    const ref = db.collection("serviceProducts").doc(productId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "VAS product not found");
    }

    const newStatus = !doc.data()!.isActive;
    await ref.update({
      isActive: newStatus,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminToggleVasProduct", "success", {
      productId,
      isActive: newStatus,
    });

    return { success: true, isActive: newStatus };
  }
);

/**
 * Soft-delete a VAS product.
 */
export const adminDeleteVasProduct = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminDeleteVasProduct");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:deleteVasProduct",
      "adminDeleteVasProduct"
    );

    const { productId } = request.data;
    if (!productId) {
      throw new HttpsError("invalid-argument", "Product ID is required");
    }

    const ref = db.collection("serviceProducts").doc(productId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", "VAS product not found");
    }

    const providerId = doc.data()!.providerId;

    // Batch: soft-delete product + decrement counter atomically
    const batch = db.batch();
    batch.update(ref, {
      isActive: false,
      isDeleted: true,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    if (providerId) {
      batch.update(db.collection("serviceProviders").doc(providerId), {
        productsCount: admin.firestore.FieldValue.increment(-1),
      });
    }
    await batch.commit();

    await logAdminAction(adminCtx.uid, "adminDeleteVasProduct", "success", {
      productId,
    });

    logger.info(`VAS product ${productId} deleted by ${adminCtx.email}`);
    return { success: true };
  }
);

/**
 * Bulk update VAS product prices (percentage or flat adjustment).
 */
export const adminBulkUpdateVasProductPrices = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminBulkUpdateVasProductPrices");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:bulkUpdateVasProductPrices",
      "adminBulkUpdateVasProductPrices"
    );

    const { providerId, adjustmentType, adjustmentValue } = request.data;
    if (!providerId) {
      throw new HttpsError("invalid-argument", "Provider ID is required");
    }
    if (!["percentage", "flat"].includes(adjustmentType)) {
      throw new HttpsError("invalid-argument", "adjustmentType must be 'percentage' or 'flat'");
    }
    if (typeof adjustmentValue !== "number") {
      throw new HttpsError("invalid-argument", "adjustmentValue must be a number");
    }

    const productsSnap = await db
      .collection("serviceProducts")
      .where("providerId", "==", providerId)
      .where("isActive", "==", true)
      .get();

    if (productsSnap.empty) {
      return { success: true, updatedCount: 0 };
    }

    // Build updates first, then commit in batch-size-safe chunks of 500
    const updates: Array<{ ref: FirebaseFirestore.DocumentReference; newPrice: number }> = [];
    for (const doc of productsSnap.docs) {
      const currentPrice = doc.data().priceZar;
      if (typeof currentPrice !== "number") continue;

      let newPrice: number;
      if (adjustmentType === "percentage") {
        newPrice = Math.round(currentPrice * (1 + adjustmentValue / 100) * 100) / 100;
      } else {
        newPrice = Math.round((currentPrice + adjustmentValue) * 100) / 100;
      }

      if (newPrice <= 0) continue; // Skip if adjustment would make price negative
      updates.push({ ref: doc.ref, newPrice });
    }

    let updatedCount = 0;
    for (let i = 0; i < updates.length; i += 500) {
      const chunk = updates.slice(i, i + 500);
      const batch = db.batch();
      for (const { ref, newPrice } of chunk) {
        batch.update(ref, {
          priceZar: newPrice,
          priceTokens: Math.round(newPrice * 100),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
      updatedCount += chunk.length;
    }

    await logAdminAction(adminCtx.uid, "adminBulkUpdateVasProductPrices", "success", {
      providerId,
      adjustmentType,
      adjustmentValue,
      updatedCount,
    });

    logger.info(
      `Bulk price update for provider ${providerId}: ${adjustmentType} ${adjustmentValue}, ${updatedCount} products by ${adminCtx.email}`
    );
    return { success: true, updatedCount };
  }
);

/**
 * Seed default VAS providers (idempotent — skips existing by code).
 */
export const adminSeedVasProviders = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminSeedVasProviders");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:seedVasProviders",
      "adminSeedVasProviders"
    );

    const defaultProviders = [
      // Electricity
      { name: "Eskom", code: "eskom", category: "electricity", sortOrder: 1 },
      { name: "City Power", code: "city-power", category: "electricity", sortOrder: 2 },
      { name: "Tshwane Electricity", code: "tshwane-electricity", category: "electricity", sortOrder: 3 },
      // Airtime
      { name: "Vodacom", code: "vodacom-airtime", category: "airtime", sortOrder: 1 },
      { name: "MTN", code: "mtn-airtime", category: "airtime", sortOrder: 2 },
      { name: "Cell C", code: "cellc-airtime", category: "airtime", sortOrder: 3 },
      { name: "Telkom Mobile", code: "telkom-airtime", category: "airtime", sortOrder: 4 },
      // Data
      { name: "Vodacom Data", code: "vodacom-data", category: "data", sortOrder: 1 },
      { name: "MTN Data", code: "mtn-data", category: "data", sortOrder: 2 },
      { name: "Cell C Data", code: "cellc-data", category: "data", sortOrder: 3 },
      { name: "Telkom Data", code: "telkom-data", category: "data", sortOrder: 4 },
      // Vouchers
      { name: "1ForYou", code: "1foryou", category: "voucher", sortOrder: 1 },
      { name: "Blu Voucher", code: "blu-voucher", category: "voucher", sortOrder: 2 },
      { name: "Flash", code: "flash", category: "voucher", sortOrder: 3 },
      { name: "OTT", code: "ott", category: "voucher", sortOrder: 4 },
    ];

    let created = 0;
    let skipped = 0;

    // Transaction: atomic reads + writes to prevent duplicate providers from concurrent calls.
    // Firestore transactions don't support inequality queries, so we read by deterministic doc ID.
    // Use deterministic IDs based on provider code for idempotency.
    const txResult = await db.runTransaction(async (tx) => {
      let txCreated = 0;
      let txSkipped = 0;

      for (const provider of defaultProviders) {
        const deterministicId = `vas_${provider.code.replace(/[^a-z0-9-]/g, "")}`;
        const ref = db.collection("serviceProviders").doc(deterministicId);
        const doc = await tx.get(ref);

        if (doc.exists) {
          txSkipped++;
          continue;
        }

        tx.set(ref, {
          id: deterministicId,
          name: provider.name,
          code: provider.code,
          category: provider.category,
          logoUrl: null,
          description: null,
          sortOrder: provider.sortOrder,
          isActive: true,
          isDeleted: false,
          productsCount: 0,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        txCreated++;
      }

      return { txCreated, txSkipped };
    });

    created = txResult.txCreated;
    skipped = txResult.txSkipped;

    await logAdminAction(adminCtx.uid, "adminSeedVasProviders", "success", {
      created,
      skipped,
    });

    logger.info(`VAS providers seeded by ${adminCtx.email}: ${created} created, ${skipped} skipped`);
    return { success: true, created, skipped };
  }
);

// ============================================================================
// LISTING CATEGORY MIGRATION (one-off)
// ============================================================================

/**
 * Migrate old listing category enum values to new 8-category system.
 * Idempotent — skips docs already using new category values.
 */
export const migrateListingCategories = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "migrateListingCategories");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:migrateCategories",
      "migrateListingCategories"
    );

    const newCategories = new Set([
      "foodAndDrinks", "beautyAndWellness", "homeAndProperty", "clothingAndFashion",
      "fixAndRepair", "movingAndDelivery", "kidsPetsAndCare", "everythingElse",
    ]);

    const legacyMapping: Record<string, string> = {
      services: "fixAndRepair",
      goods: "everythingElse",
      food: "foodAndDrinks",
      gigs: "fixAndRepair",
      groupBuys: "everythingElse",
      beauty: "beautyAndWellness",
      home: "homeAndProperty",
      clothing: "clothingAndFashion",
      moving: "movingAndDelivery",
      kids: "kidsPetsAndCare",
    };

    const allListings = await db.collection("marketplaceListings").get();
    let migrated = 0;
    let skipped = 0;
    let unmapped: string[] = [];

    // Process in batches of 500
    const batchSize = 500;
    let batch = db.batch();
    let batchCount = 0;

    for (const doc of allListings.docs) {
      const category = doc.data().category;

      if (newCategories.has(category)) {
        skipped++;
        continue;
      }

      const newCategory = legacyMapping[category];
      if (!newCategory) {
        unmapped.push(`${doc.id}:${category}`);
        continue;
      }

      batch.update(doc.ref, {
        category: newCategory,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      migrated++;
      batchCount++;

      if (batchCount >= batchSize) {
        await batch.commit();
        batch = db.batch();
        batchCount = 0;
      }
    }

    if (batchCount > 0) {
      await batch.commit();
    }

    await logAdminAction(adminCtx.uid, "migrateListingCategories", "success", {
      migrated,
      skipped,
      unmappedCount: unmapped.length,
    });

    logger.info(
      `Category migration by ${adminCtx.email}: ${migrated} migrated, ${skipped} skipped, ${unmapped.length} unmapped`
    );
    return { success: true, migrated, skipped, unmapped };
  }
);

// ============================================================================
// GROUP BUY REQUEST APPROVAL/REJECTION
// ============================================================================

/**
 * Approve a group buy request — creates a curated group buy from it.
 */
export const adminApproveGroupBuyRequest = onCall(
  { labels: { area: "buy_admin" } },
  async (request) => {
    requireAppCheck(request, "adminApproveGroupBuyRequest");
    const adminCtx = await requireAdminPermission(request, "buy:approveGroupBuyRequest", "adminApproveGroupBuyRequest");
    const { requestId, groupBuyTitle, targetAmount, deadline, description, type, fulfilmentType, clusters, imageUrl } = request.data;

    if (!requestId) throw new HttpsError("invalid-argument", "requestId is required");
    if (!groupBuyTitle || !targetAmount || !deadline) {
      throw new HttpsError("invalid-argument", "groupBuyTitle, targetAmount, and deadline are required");
    }

    const requestRef = db.collection("groupBuyRequests").doc(requestId);
    const requestDoc = await requestRef.get();
    if (!requestDoc.exists) throw new HttpsError("not-found", "Request not found");
    if (requestDoc.data()!.status !== "pending") {
      throw new HttpsError("failed-precondition", "Request is not in pending status");
    }

    const reqData = requestDoc.data()!;

    // Maker-checker: group buy approval is a financial operation
    const { pendingActionId } = await createPendingAction(
      adminCtx,
      "buy:approveGroupBuyRequest",
      "adminApproveGroupBuyRequest",
      {
        requestId,
        groupBuyTitle,
        targetAmount,
        deadline,
        description: description || reqData.description || "",
        type: type || "digital",
        fulfilmentType: fulfilmentType || "digital",
        clusters: clusters || [],
        imageUrl: imageUrl || null,
        communityId: reqData.communityId || null,
      },
      `Approve group buy request "${groupBuyTitle}" with target ${targetAmount} tokens`
    );

    await logAdminAction(adminCtx.uid, "adminApproveGroupBuyRequest", "pending", {
      requestId,
      pendingActionId,
      groupBuyTitle,
    });

    return { success: true, pendingActionId, requiresApproval: true };
  }
);

/**
 * Reject a group buy request.
 */
export const adminRejectGroupBuyRequest = onCall(
  { labels: { area: "buy_admin" } },
  async (request) => {
    requireAppCheck(request, "adminRejectGroupBuyRequest");
    const adminCtx = await requireAdminPermission(request, "buy:rejectGroupBuyRequest", "adminRejectGroupBuyRequest");
    const { requestId, rejectionReason } = request.data;

    if (!requestId) throw new HttpsError("invalid-argument", "requestId is required");

    const requestRef = db.collection("groupBuyRequests").doc(requestId);
    const requestDoc = await requestRef.get();
    if (!requestDoc.exists) throw new HttpsError("not-found", "Request not found");
    if (requestDoc.data()!.status !== "pending") {
      throw new HttpsError("failed-precondition", "Request is not in pending status");
    }

    const reqData = requestDoc.data()!;

    await requestRef.update({
      status: "declined",
      rejectionReason: rejectionReason || null,
      reviewedBy: adminCtx.uid,
      reviewedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Notify the requester about rejection
    const requesterUserId = reqData.userId || reqData.requesterId;
    if (requesterUserId) {
      try {
        await db.collection("notifications").add({
          userId: requesterUserId,
          type: "groupBuyRequestRejected",
          title: "Group Buy Request Declined",
          body: rejectionReason
            ? `Your group buy request was declined: ${rejectionReason}`
            : "Your group buy request was declined.",
          data: { requestId },
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch (err) {
        logger.warn("Failed to create rejection notification:", err);
      }
    }

    await logAdminAction(adminCtx.uid, "adminRejectGroupBuyRequest", "success", {
      requestId,
      rejectionReason: rejectionReason || "No reason provided",
      notifiedUserId: requesterUserId || null,
    });

    return { success: true };
  }
);

// ============================================================================
// CURATED GROUP BUY CREATION
// ============================================================================

/**
 * Create an admin-curated group buy (not brand-sponsored).
 */
export const adminCreateCuratedGroupBuy = onCall(
  { labels: { area: "buy_admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateCuratedGroupBuy");
    const adminCtx = await requireAdminPermission(request, "buy:createCuratedGroupBuy", "adminCreateCuratedGroupBuy");
    const { title, description, targetAmount, deadline, type, fulfilmentType, clusters, addresses, imageUrl, originalPrice, category, deliveryFee, collectionDeadline, fulfilmentInstructions, termsAndConditions } = request.data;

    if (!title || !targetAmount || !deadline) {
      throw new HttpsError("invalid-argument", "title, targetAmount, and deadline are required");
    }
    if (typeof targetAmount !== "number" || targetAmount <= 0) {
      throw new HttpsError("invalid-argument", "targetAmount must be a positive number");
    }
    if (description !== undefined && typeof description !== "string") {
      throw new HttpsError("invalid-argument", "description must be a string");
    }
    const validTypes = ["digital", "physical"];
    if (type && !validTypes.includes(type)) {
      throw new HttpsError("invalid-argument", `type must be one of: ${validTypes.join(", ")}`);
    }
    const validFulfilmentTypes = ["digital", "physical", "collection"];
    if (fulfilmentType && !validFulfilmentTypes.includes(fulfilmentType)) {
      throw new HttpsError("invalid-argument", `fulfilmentType must be one of: ${validFulfilmentTypes.join(", ")}`);
    }
    const deadlineDate = new Date(deadline);
    if (isNaN(deadlineDate.getTime()) || deadlineDate <= new Date()) {
      throw new HttpsError("invalid-argument", "deadline must be a valid future date");
    }

    const titleSlug = title.trim().toLowerCase().replace(/\s+/g, "_").replace(/[^a-z0-9_]/g, "").substring(0, 30);
    const groupBuyRef = db.collection("groupBuys").doc(`curated_${titleSlug}`);
    await groupBuyRef.set({
      id: groupBuyRef.id,
      title: title.trim(),
      description: description?.trim() || "",
      targetAmount,
      currentAmount: 0,
      participantCount: 0,
      minParticipants: 2,
      maxParticipants: null,
      status: "open",
      deadline: admin.firestore.Timestamp.fromDate(deadlineDate),
      organizerId: null,
      organizerName: "iMaliChat Curated",
      communityId: null,
      brandId: null,
      brandName: null,
      brandLogoUrl: null,
      discountPercent: null,
      linkedListingId: null,
      createdByAdmin: true,
      type: type || "digital",
      fulfilmentType: fulfilmentType || "digital",
      clusters: clusters || [],
      addresses: addresses || [],
      voucherCodes: [],
      imageUrl: imageUrl || null,
      originalPrice: originalPrice || null,
      collectionDeadline: collectionDeadline ? admin.firestore.Timestamp.fromDate(new Date(collectionDeadline)) : null,
      deliveryStatus: null,
      fulfilmentInstructions: fulfilmentInstructions || null,
      category: category || null,
      deliveryFee: deliveryFee || 0,
      organizerSuccessRate: 1.0,
      termsAndConditions: termsAndConditions?.trim() || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminCreateCuratedGroupBuy", "success", {
      groupBuyId: groupBuyRef.id,
      title: title.trim(),
      targetAmount,
    });

    return { success: true, groupBuyId: groupBuyRef.id };
  }
);

// ============================================================================
// GROUP BUY VOUCHER DISTRIBUTION
// ============================================================================

/**
 * Upload voucher codes for a group buy.
 */
export const adminUploadGroupBuyVouchers = onCall(
  { labels: { area: "buy_admin" } },
  async (request) => {
    requireAppCheck(request, "adminUploadGroupBuyVouchers");
    const adminCtx = await requireAdminPermission(request, "buy:uploadGroupBuyVouchers", "adminUploadGroupBuyVouchers");
    const { groupBuyId, voucherCodes } = request.data;

    if (!groupBuyId) throw new HttpsError("invalid-argument", "groupBuyId is required");
    if (!Array.isArray(voucherCodes) || voucherCodes.length === 0) {
      throw new HttpsError("invalid-argument", "voucherCodes must be a non-empty array");
    }

    // Filter out empty strings and validate
    const validCodes = voucherCodes.filter((c: unknown) => typeof c === "string" && (c as string).trim().length > 0);
    if (validCodes.length === 0) {
      throw new HttpsError("invalid-argument", "No valid voucher codes provided after filtering empty strings");
    }

    // Check for duplicates within batch
    const uniqueCodes = [...new Set(validCodes.map((c: string) => c.trim()))];
    if (uniqueCodes.length !== validCodes.length) {
      throw new HttpsError("invalid-argument", "Duplicate voucher codes detected in batch");
    }

    const gbRef = db.collection("groupBuys").doc(groupBuyId);
    const gbDoc = await gbRef.get();
    if (!gbDoc.exists) throw new HttpsError("not-found", "Group buy not found");
    if (!["targetMet", "completed"].includes(gbDoc.data()!.status)) {
      throw new HttpsError("failed-precondition", "Group buy must be in targetMet or completed status");
    }

    await gbRef.update({
      voucherCodes: uniqueCodes,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminUploadGroupBuyVouchers", "success", {
      groupBuyId,
      voucherCount: uniqueCodes.length,
    });

    return { success: true, voucherCount: uniqueCodes.length };
  }
);

/**
 * Distribute voucher codes to group buy contributors.
 */
export const adminDistributeGroupBuyVouchers = onCall(
  { labels: { area: "buy_admin" } },
  async (request) => {
    requireAppCheck(request, "adminDistributeGroupBuyVouchers");
    const adminCtx = await requireAdminPermission(request, "buy:distributeGroupBuyVouchers", "adminDistributeGroupBuyVouchers");
    const { groupBuyId } = request.data;

    if (!groupBuyId) throw new HttpsError("invalid-argument", "groupBuyId is required");

    const gbRef = db.collection("groupBuys").doc(groupBuyId);
    const gbDoc = await gbRef.get();
    if (!gbDoc.exists) throw new HttpsError("not-found", "Group buy not found");
    const gbData = gbDoc.data()!;

    // Only distribute vouchers for completed group buys
    if (gbData.status !== "completed") {
      throw new HttpsError("failed-precondition", `Group buy must be in "completed" status, currently "${gbData.status}"`);
    }

    if (!gbData.voucherCodes || gbData.voucherCodes.length === 0) {
      throw new HttpsError("failed-precondition", "No voucher codes uploaded for this group buy");
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
      return { success: true, distributed: 0, message: "No eligible contributions to distribute to" };
    }

    if (gbData.voucherCodes.length < eligibleContribs.length) {
      throw new HttpsError("failed-precondition", `Not enough voucher codes (${gbData.voucherCodes.length}) for eligible contributions (${eligibleContribs.length})`);
    }

    // Maker-checker: voucher distribution is a financial operation
    const { pendingActionId } = await createPendingAction(
      adminCtx,
      "buy:distributeGroupBuyVouchers",
      "adminDistributeGroupBuyVouchers",
      { groupBuyId, eligibleCount: eligibleContribs.length, voucherCount: gbData.voucherCodes.length },
      `Distribute ${eligibleContribs.length} vouchers for group buy "${gbData.title || groupBuyId}"`
    );

    await logAdminAction(adminCtx.uid, "adminDistributeGroupBuyVouchers", "pending", {
      groupBuyId,
      pendingActionId,
      eligibleContributions: eligibleContribs.length,
    });

    return { success: true, pendingActionId, requiresApproval: true };
  }
);

// ============================================================================
// VAS CATEGORY SEEDING
// ============================================================================

/**
 * Seed the 9 default VAS categories into the `vasCategories` collection.
 * Uses deterministic IDs for idempotency. Only creates missing docs.
 */
export const adminSeedVasCategories = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminSeedVasCategories");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:seedVasCategories",
      "adminSeedVasCategories"
    );

    const defaultVasCategories = [
      { id: "airtime", name: "Airtime", iconName: "phone", sortOrder: 1, purchaseCategoryMapping: "airtime" },
      { id: "data", name: "Data", iconName: "wifi", sortOrder: 2, purchaseCategoryMapping: "data" },
      { id: "electricity", name: "Electricity", iconName: "lightning", sortOrder: 3, purchaseCategoryMapping: "electricity" },
      { id: "voucher", name: "Vouchers", iconName: "ticket", sortOrder: 4, purchaseCategoryMapping: "voucher" },
      { id: "school_fees", name: "School Fees", iconName: "cap", sortOrder: 5, purchaseCategoryMapping: "school" },
      { id: "municipal_bill", name: "Municipal Bill", iconName: "bank", sortOrder: 6, purchaseCategoryMapping: "municipal" },
      { id: "stokvel", name: "Stokvel Contribution", iconName: "users", sortOrder: 7, purchaseCategoryMapping: "stokvel" },
      { id: "funeral", name: "Funeral", iconName: "funeral", sortOrder: 8, purchaseCategoryMapping: "funeral" },
      { id: "gaming", name: "Gaming", iconName: "gaming", sortOrder: 9, purchaseCategoryMapping: "gaming" },
    ];

    const txResult = await db.runTransaction(async (tx) => {
      // Phase 1: Read all docs first (Firestore requires reads before writes)
      const refs = defaultVasCategories.map((cat) =>
        db.collection("vasCategories").doc(cat.id)
      );
      const docs = await Promise.all(refs.map((ref) => tx.get(ref)));

      // Phase 2: Write only missing docs
      let txCreated = 0;
      let txSkipped = 0;

      for (let i = 0; i < defaultVasCategories.length; i++) {
        if (docs[i].exists) {
          txSkipped++;
          continue;
        }

        const cat = defaultVasCategories[i];
        tx.set(refs[i], {
          name: cat.name,
          iconName: cat.iconName,
          sortOrder: cat.sortOrder,
          isActive: true,
          purchaseCategoryMapping: cat.purchaseCategoryMapping,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        txCreated++;
      }

      return { txCreated, txSkipped };
    });

    await logAdminAction(adminCtx.uid, "adminSeedVasCategories", "success", {
      created: txResult.txCreated,
      skipped: txResult.txSkipped,
    });

    logger.info(`VAS categories seeded by ${adminCtx.email}: ${txResult.txCreated} created, ${txResult.txSkipped} skipped`);
    return { success: true, created: txResult.txCreated, skipped: txResult.txSkipped };
  }
);

// ============================================================================
// VAS CATEGORY CRUD
// ============================================================================

/**
 * Create a new VAS category.
 */
export const adminCreateVasCategory = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminCreateVasCategory");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:createVasCategory",
      "adminCreateVasCategory"
    );

    const { name, iconName, sortOrder, isActive, purchaseCategoryMapping } =
      request.data as {
        name: string;
        iconName?: string;
        sortOrder?: number;
        isActive?: boolean;
        purchaseCategoryMapping?: string;
      };

    if (!name || name.trim().length === 0) {
      throw new HttpsError("invalid-argument", "name is required");
    }

    // Duplicate name check
    const duplicateSnap = await db
      .collection("vasCategories")
      .where("name", "==", name.trim())
      .limit(1)
      .get();
    if (!duplicateSnap.empty) {
      throw new HttpsError("already-exists", `VAS category '${name.trim()}' already exists`);
    }

    // Deterministic ID
    const nameHash = name.trim().toLowerCase().replace(/[^a-z0-9]/g, "").substring(0, 40);
    const docId = `vas_${nameHash}`;

    const data = {
      name: name.trim(),
      iconName: iconName || "",
      sortOrder: sortOrder ?? 0,
      isActive: isActive ?? true,
      purchaseCategoryMapping: purchaseCategoryMapping || "",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await db.collection("vasCategories").doc(docId).set(data);

    await logAdminAction(adminCtx.uid, "adminCreateVasCategory", "success", {
      categoryId: docId,
      name,
    });

    logger.info(`VAS category '${name}' created by ${adminCtx.email}`);
    return { success: true, categoryId: docId };
  }
);

/**
 * Update an existing VAS category.
 */
export const adminUpdateVasCategory = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminUpdateVasCategory");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:updateVasCategory",
      "adminUpdateVasCategory"
    );

    const { categoryId, ...fields } = request.data as {
      categoryId: string;
      name?: string;
      iconName?: string;
      sortOrder?: number;
      isActive?: boolean;
      purchaseCategoryMapping?: string;
    };

    if (!categoryId) {
      throw new HttpsError("invalid-argument", "categoryId is required");
    }

    const ref = db.collection("vasCategories").doc(categoryId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `VAS category '${categoryId}' not found`);
    }

    const updates: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    for (const [key, value] of Object.entries(fields)) {
      if (value !== undefined) updates[key] = value;
    }

    await ref.update(updates);

    await logAdminAction(adminCtx.uid, "adminUpdateVasCategory", "success", {
      categoryId,
      updates: Object.keys(fields),
    });

    logger.info(`VAS category '${categoryId}' updated by ${adminCtx.email}`);
    return { success: true, categoryId };
  }
);

/**
 * Toggle a VAS category's active status.
 */
export const adminToggleVasCategory = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    requireAppCheck(request, "adminToggleVasCategory");
    const adminCtx = await requireAdminPermission(
      request,
      "buy:toggleVasCategory",
      "adminToggleVasCategory"
    );

    const { categoryId, isActive } = request.data as {
      categoryId: string;
      isActive: boolean;
    };

    if (!categoryId) {
      throw new HttpsError("invalid-argument", "categoryId is required");
    }
    if (typeof isActive !== "boolean") {
      throw new HttpsError("invalid-argument", "isActive must be a boolean");
    }

    const ref = db.collection("vasCategories").doc(categoryId);
    const doc = await ref.get();
    if (!doc.exists) {
      throw new HttpsError("not-found", `VAS category '${categoryId}' not found`);
    }

    await ref.update({
      isActive,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await logAdminAction(adminCtx.uid, "adminToggleVasCategory", "success", {
      categoryId,
      isActive,
    });

    logger.info(`VAS category '${categoryId}' toggled to ${isActive} by ${adminCtx.email}`);
    return { success: true, categoryId, isActive };
  }
);
