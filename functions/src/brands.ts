/**
 * Brand-Following Cloud Functions
 *
 * Manages user-to-brand follow/unfollow relationships.
 * Maintains both the user's followedBrands array and the
 * brandFollowers/{clientId}/followers subcollection in sync.
 *
 * Extracted from conversations.ts to keep that file focused on
 * P2P messaging logic.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import { requireAdminPermission } from "./adminAuth";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

function requireAuth(request: { auth?: { uid: string } }): string {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  return request.auth.uid;
}

// ============================================================================
// STOREFRONT COUPONS
// ============================================================================

/**
 * Claim a coupon from a brand storefront.
 * Creates a top-level storefrontCoupons doc keyed by storefrontId+userId (deterministic).
 */
export const claimStorefrontCoupon = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "claimStorefrontCoupon");

    const { storefrontId, couponId, couponCode } = request.data;
    if (!storefrontId || !couponId) {
      throw new HttpsError("invalid-argument", "storefrontId and couponId are required");
    }

    // Deterministic doc ID prevents duplicate claims
    const claimDocId = `${storefrontId}_${userId}_${couponId}`;
    const claimRef = db.collection("storefrontCoupons").doc(claimDocId);
    const storefrontRef = db.collection("brandStorefronts").doc(storefrontId);

    // Transaction: atomic check-and-claim prevents race between existence check and set
    await db.runTransaction(async (tx) => {
      const [existingClaim, storefrontDoc] = await Promise.all([
        tx.get(claimRef),
        tx.get(storefrontRef),
      ]);

      if (existingClaim.exists) {
        throw new HttpsError("already-exists", "You have already claimed this coupon");
      }
      if (!storefrontDoc.exists) {
        throw new HttpsError("not-found", "Storefront not found");
      }

      // Find the coupon — check top-level coupons array first (Flutter stores coupons here),
      // then fall back to sections[].coupons[] for backward compatibility.
      const storefrontData = storefrontDoc.data()!;
      let couponDef: { id?: string; maxClaims?: number; expiresAt?: string } | undefined;

      // Path 1: Top-level coupons array (current Flutter format)
      const topLevelCoupons = storefrontData.coupons as Array<{ id?: string; maxClaims?: number; expiresAt?: string }> | undefined;
      if (topLevelCoupons) {
        couponDef = topLevelCoupons.find((c) => c.id === couponId);
      }

      // Path 2: Nested sections[].coupons[] (legacy format, backward compatibility)
      if (!couponDef) {
        const sections = storefrontData.sections as Array<{ type?: string; coupons?: Array<{ id?: string; maxClaims?: number; expiresAt?: string }> }> | undefined;
        if (sections) {
          for (const section of sections) {
            if (section.coupons) {
              couponDef = section.coupons.find((c) => c.id === couponId);
              if (couponDef) break;
            }
          }
        }
      }

      // Validate coupon expiry — reject if coupon has a past expiresAt
      if (couponDef?.expiresAt) {
        const expiryDate = new Date(couponDef.expiresAt);
        if (!isNaN(expiryDate.getTime()) && expiryDate.getTime() < Date.now()) {
          throw new HttpsError("failed-precondition", "This coupon has expired");
        }
      }

      // Validate maxClaims — use atomic increment to prevent race conditions.
      // The claimRef set (below) provides per-user idempotency.
      // The counter on the storefront doc provides global limit enforcement.
      if (couponDef?.maxClaims && couponDef.maxClaims > 0) {
        const couponCounterRef = db.collection("storefrontCouponCounters").doc(`${storefrontId}_${couponId}`);
        const counterDoc = await tx.get(couponCounterRef);
        const currentCount = counterDoc.exists ? (counterDoc.data()!.count || 0) : 0;
        if (currentCount >= couponDef.maxClaims) {
          throw new HttpsError("resource-exhausted", "This coupon has reached its maximum number of claims");
        }
        // Atomically increment the counter inside the transaction
        tx.set(couponCounterRef, { count: currentCount + 1, storefrontId, couponId }, { merge: true });
      }

      tx.set(claimRef, {
        id: claimDocId,
        storefrontId,
        userId,
        couponId,
        couponCode: couponCode || null,
        brandId: storefrontData.brandId || storefrontId,
        claimedAt: admin.firestore.FieldValue.serverTimestamp(),
        isRedeemed: false,
        redeemedAt: null,
      });
    });

    logger.info(`Coupon ${couponId} claimed by ${userId} from storefront ${storefrontId}`);
    return { success: true, couponCode: couponCode || couponId };
  }
);

/**
 * Redeem a previously claimed coupon (mark it as used).
 * Updates the claim doc with isRedeemed: true and redeemedAt timestamp.
 */
export const redeemStorefrontCoupon = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "redeemStorefrontCoupon");

    const { storefrontId, couponId } = request.data;
    if (!storefrontId || !couponId) {
      throw new HttpsError("invalid-argument", "storefrontId and couponId are required");
    }

    const claimDocId = `${storefrontId}_${userId}_${couponId}`;
    const claimRef = db.collection("storefrontCoupons").doc(claimDocId);

    await db.runTransaction(async (tx) => {
      const claimDoc = await tx.get(claimRef);

      if (!claimDoc.exists) {
        throw new HttpsError("not-found", "Coupon claim not found. You must claim the coupon before redeeming it.");
      }

      const claimData = claimDoc.data()!;
      if (claimData.isRedeemed) {
        throw new HttpsError("already-exists", "This coupon has already been redeemed");
      }

      tx.update(claimRef, {
        isRedeemed: true,
        redeemedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    logger.info(`Coupon ${couponId} redeemed by ${userId} from storefront ${storefrontId}`);
    return { success: true };
  }
);

/**
 * Get all coupon IDs the current user has claimed for a given storefront.
 * Used to hydrate the UI on screen revisit so claimed coupons stay greyed out.
 */
export const getClaimedCoupons = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getClaimedCoupons");

    const { storefrontId } = request.data;
    if (!storefrontId || typeof storefrontId !== "string") {
      throw new HttpsError("invalid-argument", "storefrontId is required");
    }

    const snapshot = await db
      .collection("storefrontCoupons")
      .where("storefrontId", "==", storefrontId)
      .where("userId", "==", userId)
      .select("couponId")
      .get();

    const couponIds = snapshot.docs.map((doc) => doc.data().couponId as string);
    return { success: true, couponIds };
  }
);

// ============================================================================
// STOREFRONT VIEWS
// ============================================================================

/**
 * Record a storefront view for analytics.
 * Writes to brandAnalytics/{brandId}/daily/{date} with increment.
 */
export const recordStorefrontView = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "recordStorefrontView");

    const { storefrontId } = request.data;
    if (!storefrontId || typeof storefrontId !== "string") {
      throw new HttpsError("invalid-argument", "storefrontId is required");
    }

    const storefrontDoc = await db.collection("brandStorefronts").doc(storefrontId).get();
    if (!storefrontDoc.exists) {
      throw new HttpsError("not-found", "Storefront not found");
    }
    const brandId = storefrontDoc.data()!.brandId || storefrontId;

    // Record daily analytics — use deterministic visitor doc instead of
    // unbounded array to avoid hitting Firestore's 1MB doc limit on popular brands.
    const today = admin.firestore.Timestamp.now().toDate().toISOString().split("T")[0]; // YYYY-MM-DD
    const dailyRef = db
      .collection("brandAnalytics")
      .doc(brandId)
      .collection("daily")
      .doc(today);

    // Always increment total views
    await dailyRef.set(
      {
        date: today,
        brandId,
        storefrontViews: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true }
    );

    // Track unique visitors via deterministic subcollection doc (bounded per-user).
    // Transaction also atomically increments the storefront totalViews counter
    // to avoid race conditions with concurrent view recordings.
    const visitorRef = dailyRef.collection("visitors").doc(userId);
    await db.runTransaction(async (tx) => {
      const visitorDoc = await tx.get(visitorRef);
      // Increment total view count on storefront inside the transaction
      tx.update(storefrontDoc.ref, {
        totalViews: admin.firestore.FieldValue.increment(1),
      });
      if (!visitorDoc.exists) {
        tx.set(visitorRef, { viewedAt: admin.firestore.FieldValue.serverTimestamp() });
        tx.update(dailyRef, {
          uniqueVisitorCount: admin.firestore.FieldValue.increment(1),
        });
      }
    });

    return { success: true };
  }
);

// ============================================================================
// BRAND ANALYTICS
// ============================================================================

/**
 * Get brand analytics for a date range.
 */
export const getBrandAnalytics = onCall(
  { labels: { area: "social" } },
  async (request) => {
    requireAppCheck(request, "getBrandAnalytics");
    await requireAdminPermission(request, "buy:getBrandAnalytics", "getBrandAnalytics");

    const { brandId, startDate, endDate } = request.data;
    if (!brandId || typeof brandId !== "string") {
      throw new HttpsError("invalid-argument", "brandId is required");
    }

    const start = startDate || new Date(Date.now() - 30 * 86400000).toISOString().split("T")[0];
    const end = endDate || new Date().toISOString().split("T")[0];

    const dailySnap = await db
      .collection("brandAnalytics")
      .doc(brandId)
      .collection("daily")
      .where("date", ">=", start)
      .where("date", "<=", end)
      .orderBy("date", "desc")
      .get();

    let totalViews = 0;
    let totalUniqueVisitors = 0;
    const dailyData = dailySnap.docs.map((doc) => {
      const data = doc.data();
      totalViews += data.storefrontViews || 0;
      const dayUniqueCount = data.uniqueVisitorCount || 0;
      totalUniqueVisitors += dayUniqueCount;
      return {
        date: data.date,
        storefrontViews: data.storefrontViews || 0,
        uniqueVisitorCount: dayUniqueCount,
      };
    });

    // Get follower count
    const clientDoc = await db.collection("clients").doc(brandId).get();
    const followerCount = clientDoc.data()?.followerCount || 0;

    return {
      success: true,
      analytics: {
        brandId,
        period: { start, end },
        totalViews,
        totalUniqueVisitors,
        followerCount,
        daily: dailyData,
      },
    };
  }
);

// ============================================================================
// TOGGLE BRAND FOLLOW
// ============================================================================

/**
 * Toggle follow/unfollow for a brand.
 * Uses transaction to atomically check state and toggle, preventing
 * followerCount race conditions under concurrent calls.
 */
export const toggleBrandFollow = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "toggleBrandFollow");

    const { brandId } = request.data;
    if (!brandId || typeof brandId !== "string") {
      throw new HttpsError("invalid-argument", "brandId is required");
    }

    const followerRef = db.collection("brandFollowers").doc(brandId).collection("followers").doc(userId);
    const clientRef = db.collection("clients").doc(brandId);
    const userRef = db.collection("users").doc(userId);

    const isFollowing = await db.runTransaction(async (tx) => {
      const [followerDoc, clientDoc] = await Promise.all([
        tx.get(followerRef),
        tx.get(clientRef),
      ]);

      const isCurrentlyFollowing = followerDoc.exists;

      if (isCurrentlyFollowing) {
        // Unfollow — verify brand exists
        if (!clientDoc.exists) {
          throw new HttpsError("not-found", "Brand not found");
        }
        tx.update(userRef, {
          followedBrands: admin.firestore.FieldValue.arrayRemove(brandId),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        tx.delete(followerRef);
        const currentCount = clientDoc.data()?.followerCount || 0;
        const newCount = Math.max(0, currentCount - 1);
        tx.update(clientRef, {
          followerCount: newCount,
        });
        return false;
      } else {
        // Follow — verify brand is active
        if (!clientDoc.exists || clientDoc.data()?.isActive !== true) {
          throw new HttpsError("not-found", "Brand not found");
        }
        tx.update(userRef, {
          followedBrands: admin.firestore.FieldValue.arrayUnion(brandId),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        tx.set(followerRef, {
          userId,
          followedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        tx.update(clientRef, {
          followerCount: admin.firestore.FieldValue.increment(1),
        });
        return true;
      }
    });

    logger.info(`toggleBrandFollow: user ${userId} ${isFollowing ? "followed" : "unfollowed"} brand ${brandId}`);
    return { success: true, isFollowing };
  }
);

// ============================================================================
// BRAND STOREFRONT LISTING (consumer-facing, filters soft-deleted)
// ============================================================================

/**
 * List active brand storefronts for consumers.
 * Filters out soft-deleted and inactive storefronts.
 */
export const getActiveBrandStorefronts = onCall(
  { labels: { area: "social" } },
  async (request) => {
    requireAuth(request);
    requireAppCheck(request, "getActiveBrandStorefronts");

    const snapshot = await db
      .collection("brandStorefronts")
      .where("isActive", "==", true)
      .where("isDraft", "==", false)
      .get();

    // Additional client-side filter for isDeleted to handle docs
    // that may have isDeleted set without isActive being toggled
    const storefronts = snapshot.docs
      .filter((doc) => {
        const data = doc.data();
        return data.isDeleted !== true;
      })
      .map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

    return { success: true, storefronts };
  }
);

// ============================================================================
// FOLLOWED & AVAILABLE BRANDS
// ============================================================================

/**
 * Get brands the current user follows.
 * Reads the user's followedBrands array, then fetches each brand's client doc
 * to return structured brand objects.
 */
export const getFollowedBrands = onCall(
  { labels: { area: "social" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "getFollowedBrands");

    const userId = request.auth.uid;
    const userDoc = await db.collection("users").doc(userId).get();
    if (!userDoc.exists) {
      return { success: true, brands: [] };
    }

    const followedBrands: string[] = userDoc.data()?.followedBrands || [];
    if (followedBrands.length === 0) {
      return { success: true, brands: [] };
    }

    // Firestore 'in' queries support max 30 items; chunk if needed
    const brands: Array<{ id: string; name: string; logoUrl: string | null; category: string | null }> = [];
    for (let i = 0; i < followedBrands.length; i += 30) {
      const chunk = followedBrands.slice(i, i + 30);
      const clientSnap = await db
        .collection("clients")
        .where(admin.firestore.FieldPath.documentId(), "in", chunk)
        .get();

      for (const doc of clientSnap.docs) {
        const data = doc.data();
        if (data.isActive !== false) {
          brands.push({
            id: doc.id,
            name: data.companyName || data.name || data.displayName || doc.id,
            logoUrl: data.logoUrl || null,
            category: data.category || null,
          });
        }
      }
    }

    return { success: true, brands };
  }
);

/**
 * Get available brands (active, non-deleted storefronts).
 * Returns a lightweight list of brand objects for consumer browsing.
 */
export const getAvailableBrands = onCall(
  { labels: { area: "social" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "getAvailableBrands");

    const snapshot = await db
      .collection("brandStorefronts")
      .where("isActive", "==", true)
      .get();

    const brands = snapshot.docs
      .filter((doc) => doc.data().isDeleted !== true)
      .map((doc) => {
        const data = doc.data();
        return {
          id: doc.id,
          name: data.brandName || doc.id,
          logoUrl: data.brandLogoUrl || null,
          category: data.category || null,
        };
      });

    return { success: true, brands };
  }
);

// ============================================================================
// BRAND REVIEWS (consumer-facing)
// ============================================================================

/**
 * Submit a brand review (consumer-facing).
 * One review per order — orderId is the uniqueness key.
 */
export const submitBrandReview = onCall(
  { labels: { area: "buy" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "submitBrandReview");

    const userId = request.auth.uid;
    const {
      brandId,
      orderId,
      qualityRating,
      valueRating,
      serviceRating,
      comment,
    } = request.data as {
      brandId: string;
      orderId: string;
      qualityRating: number;
      valueRating: number;
      serviceRating: number;
      comment?: string;
    };

    if (!brandId || !orderId) {
      throw new HttpsError("invalid-argument", "brandId and orderId are required");
    }

    // Validate ratings are 1-5
    for (const [name, val] of Object.entries({ qualityRating, valueRating, serviceRating })) {
      if (typeof val !== "number" || val < 1 || val > 5 || !Number.isInteger(val)) {
        throw new HttpsError("invalid-argument", `${name} must be an integer between 1 and 5`);
      }
    }

    // Get user display name
    const userDoc = await db.collection("users").doc(userId).get();
    const userName = userDoc.data()?.displayName || "iMali User";

    const overallRating = Math.round(((qualityRating + valueRating + serviceRating) / 3) * 10) / 10;

    // Simple auto-filter: flag if comment contains obvious profanity placeholder
    const isFiltered = comment
      ? /\b(fuck|shit|damn|ass|bitch)\b/i.test(comment)
      : false;

    // Deterministic doc ID prevents duplicates even under concurrent requests
    const reviewDocId = `${userId}_${brandId}_${orderId}`;
    const reviewRef = db.collection("brandReviews").doc(reviewDocId);
    const storefrontRef = db.collection("brandStorefronts").doc("store_" + brandId);

    // Transaction: duplicate check + review creation + aggregate update (atomic)
    await db.runTransaction(async (tx) => {
      const existingReview = await tx.get(reviewRef);
      if (existingReview.exists) {
        throw new HttpsError("already-exists", "You have already reviewed this order");
      }

      tx.set(reviewRef, {
        brandId,
        userId,
        userName,
        orderId,
        qualityRating,
        valueRating,
        serviceRating,
        overallRating,
        comment: comment?.trim() || null,
        isFiltered,
        isRemovedByAdmin: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: null,
      });

      // Update aggregate rating using FieldValue.increment for atomicity
      tx.update(storefrontRef, {
        ratingSum: admin.firestore.FieldValue.increment(overallRating),
        ratingCount: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    // Recompute averageRating outside transaction (non-critical, best-effort)
    try {
      const storefrontDoc = await storefrontRef.get();
      const sfData = storefrontDoc.data();
      if (sfData && sfData.ratingCount > 0) {
        const avgRating = Math.round((sfData.ratingSum / sfData.ratingCount) * 10) / 10;
        await storefrontRef.update({ averageRating: avgRating });
      }
    } catch (err) {
      logger.warn("Failed to recompute averageRating:", err);
    }

    logger.info(`Brand review submitted by ${userId} for brand ${brandId}`);
    return { success: true, reviewId: reviewDocId, isFiltered };
  }
);

/**
 * Edit an existing brand review (by the original author only).
 * Wraps review update + aggregate rating update in a single transaction.
 */
export const editBrandReview = onCall(
  { labels: { area: "buy" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "editBrandReview");

    const userId = request.auth.uid;
    const {
      reviewId,
      qualityRating,
      valueRating,
      serviceRating,
      comment,
    } = request.data as {
      reviewId: string;
      qualityRating?: number;
      valueRating?: number;
      serviceRating?: number;
      comment?: string;
    };

    if (!reviewId) {
      throw new HttpsError("invalid-argument", "reviewId is required");
    }

    // Validate optional rating updates upfront
    for (const [key, val] of Object.entries({ qualityRating, valueRating, serviceRating })) {
      if (val !== undefined) {
        if (typeof val !== "number" || val < 1 || val > 5 || !Number.isInteger(val)) {
          throw new HttpsError("invalid-argument", `${key} must be an integer between 1 and 5`);
        }
      }
    }

    const reviewRef = db.collection("brandReviews").doc(reviewId);

    // Transaction: review update + aggregate rating update (atomic)
    await db.runTransaction(async (tx) => {
      const reviewDoc = await tx.get(reviewRef);

      if (!reviewDoc.exists) {
        throw new HttpsError("not-found", "Review not found");
      }

      const reviewData = reviewDoc.data()!;
      if (reviewData.userId !== userId) {
        throw new HttpsError("permission-denied", "You can only edit your own reviews");
      }

      const updates: Record<string, unknown> = {
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      if (qualityRating !== undefined) updates.qualityRating = qualityRating;
      if (valueRating !== undefined) updates.valueRating = valueRating;
      if (serviceRating !== undefined) updates.serviceRating = serviceRating;

      if (comment !== undefined) {
        updates.comment = comment?.trim() || null;
        updates.isFiltered = comment
          ? /\b(fuck|shit|damn|ass|bitch)\b/i.test(comment)
          : false;
      }

      // Recompute overall if any rating changed
      const q = (updates.qualityRating ?? reviewData.qualityRating) as number;
      const v = (updates.valueRating ?? reviewData.valueRating) as number;
      const s = (updates.serviceRating ?? reviewData.serviceRating) as number;
      const newOverallRating = Math.round(((q + v + s) / 3) * 10) / 10;
      updates.overallRating = newOverallRating;

      const oldOverallRating = reviewData.overallRating as number;
      const ratingDiff = newOverallRating - oldOverallRating;

      tx.update(reviewRef, updates);

      // Update aggregate rating atomically within the same transaction
      if (ratingDiff !== 0) {
        const brandId = reviewData.brandId;
        const storefrontRef = db.collection("brandStorefronts").doc("store_" + brandId);
        tx.update(storefrontRef, {
          ratingSum: admin.firestore.FieldValue.increment(ratingDiff),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    });

    // Recompute averageRating outside transaction (best-effort)
    try {
      const freshReview = await reviewRef.get();
      const brandId = freshReview.data()?.brandId;
      if (brandId) {
        const storefrontRef = db.collection("brandStorefronts").doc("store_" + brandId);
        const storefrontDoc = await storefrontRef.get();
        const sfData = storefrontDoc.data();
        if (sfData && sfData.ratingCount > 0) {
          const avgRating = Math.round((sfData.ratingSum / sfData.ratingCount) * 10) / 10;
          await storefrontRef.update({ averageRating: avgRating });
        }
      }
    } catch (err) {
      logger.warn("Failed to update brand aggregate rating after edit:", err);
    }

    logger.info(`Brand review ${reviewId} updated by ${userId}`);
    return { success: true };
  }
);
