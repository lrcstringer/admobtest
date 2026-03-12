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
// BRAND ACCOUNTS
// ============================================================================

/**
 * Follow a brand. Adds clientId to user's followedBrands array
 * and creates a brandFollowers/{clientId}/followers/{userId} doc.
 */
export const followBrand = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "followBrand");

    const { clientId } = request.data;

    if (!clientId || typeof clientId !== "string") {
      throw new HttpsError("invalid-argument", "clientId is required");
    }

    // Verify client exists and is active
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (!clientDoc.exists || clientDoc.data()?.isActive !== true) {
      throw new HttpsError("not-found", "Brand not found");
    }

    const batch = db.batch();

    // Add to user's followedBrands array
    batch.update(db.collection("users").doc(userId), {
      followedBrands: admin.firestore.FieldValue.arrayUnion(clientId),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create follower document
    batch.set(
      db.collection("brandFollowers").doc(clientId).collection("followers").doc(userId),
      {
        userId,
        followedAt: admin.firestore.FieldValue.serverTimestamp(),
      }
    );

    // Increment follower count on client doc
    batch.update(db.collection("clients").doc(clientId), {
      followerCount: admin.firestore.FieldValue.increment(1),
    });

    await batch.commit();

    logger.info(`followBrand: user ${userId} followed brand ${clientId}`);
    return { success: true };
  }
);

/**
 * Unfollow a brand. Removes clientId from user's followedBrands array
 * and deletes the brandFollowers doc.
 */
export const unfollowBrand = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "unfollowBrand");

    const { clientId } = request.data;

    if (!clientId || typeof clientId !== "string") {
      throw new HttpsError("invalid-argument", "clientId is required");
    }

    const batch = db.batch();

    // Remove from user's followedBrands array
    batch.update(db.collection("users").doc(userId), {
      followedBrands: admin.firestore.FieldValue.arrayRemove(clientId),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Delete follower document
    batch.delete(
      db.collection("brandFollowers").doc(clientId).collection("followers").doc(userId)
    );

    // Decrement follower count on client doc
    batch.update(db.collection("clients").doc(clientId), {
      followerCount: admin.firestore.FieldValue.increment(-1),
    });

    await batch.commit();

    logger.info(`unfollowBrand: user ${userId} unfollowed brand ${clientId}`);
    return { success: true };
  }
);

/**
 * Get user's followed brands with full client profile data.
 */
export const getFollowedBrands = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getFollowedBrands");

    const userDoc = await db.collection("users").doc(userId).get();
    const followedBrandIds: string[] = userDoc.data()?.followedBrands || [];

    if (followedBrandIds.length === 0) {
      return { success: true, brands: [] };
    }

    // Fetch brand details in batches of 30
    const brands: Array<Record<string, unknown>> = [];
    const batchSize = 30;

    for (let i = 0; i < followedBrandIds.length; i += batchSize) {
      const batchIds = followedBrandIds.slice(i, i + batchSize);

      // Firestore __name__ whereIn for doc IDs
      const snap = await db
        .collection("clients")
        .where(admin.firestore.FieldPath.documentId(), "in", batchIds)
        .get();

      for (const doc of snap.docs) {
        const data = doc.data();
        if (data.isActive !== true || data.isDeleted === true) continue;

        brands.push({
          id: doc.id,
          name: data.displayName || data.companyName || "Brand",
          logoUrl: data.avatarImage || null,
          avatarColor: data.avatarColor || null,
          description: data.industry || null,
          isFollowed: true,
          followerCount: data.followerCount || 0,
        });
      }
    }

    return { success: true, brands };
  }
);

/**
 * Get available brands that support brand messaging.
 * Returns active clients with isBrandMessagingEnabled = true.
 */
export const getAvailableBrands = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getAvailableBrands");

    const userDoc = await db.collection("users").doc(userId).get();
    const followedBrandIds: string[] = userDoc.data()?.followedBrands || [];
    const followedSet = new Set(followedBrandIds);

    // Query active clients with brand messaging enabled
    const snap = await db
      .collection("clients")
      .where("isActive", "==", true)
      .where("isBrandMessagingEnabled", "==", true)
      .limit(50)
      .get();

    const brands: Array<Record<string, unknown>> = [];

    for (const doc of snap.docs) {
      const data = doc.data();
      if (data.isDeleted === true) continue;

      brands.push({
        id: doc.id,
        name: data.displayName || data.companyName || "Brand",
        logoUrl: data.avatarImage || null,
        avatarColor: data.avatarColor || null,
        description: data.industry || null,
        isFollowed: followedSet.has(doc.id),
        followerCount: data.followerCount || 0,
      });
    }

    return { success: true, brands };
  }
);

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

    const existing = await claimRef.get();
    if (existing.exists) {
      throw new HttpsError("already-exists", "You have already claimed this coupon");
    }

    // Verify storefront exists
    const storefrontDoc = await db.collection("brandStorefronts").doc(storefrontId).get();
    if (!storefrontDoc.exists) {
      throw new HttpsError("not-found", "Storefront not found");
    }

    await claimRef.set({
      id: claimDocId,
      storefrontId,
      userId,
      couponId,
      couponCode: couponCode || null,
      brandId: storefrontDoc.data()!.brandId || storefrontId,
      claimedAt: admin.firestore.FieldValue.serverTimestamp(),
      isRedeemed: false,
      redeemedAt: null,
    });

    logger.info(`Coupon ${couponId} claimed by ${userId} from storefront ${storefrontId}`);
    return { success: true, couponCode: couponCode || couponId };
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

    const { storefrontId } = request.data;
    if (!storefrontId || typeof storefrontId !== "string") {
      throw new HttpsError("invalid-argument", "storefrontId is required");
    }

    const storefrontDoc = await db.collection("brandStorefronts").doc(storefrontId).get();
    if (!storefrontDoc.exists) {
      throw new HttpsError("not-found", "Storefront not found");
    }
    const brandId = storefrontDoc.data()!.brandId || storefrontId;

    // Increment total view count on storefront
    await storefrontDoc.ref.update({
      totalViews: admin.firestore.FieldValue.increment(1),
    });

    // Record daily analytics
    const today = new Date().toISOString().split("T")[0]; // YYYY-MM-DD
    const dailyRef = db
      .collection("brandAnalytics")
      .doc(brandId)
      .collection("daily")
      .doc(today);

    await dailyRef.set(
      {
        date: today,
        brandId,
        storefrontViews: admin.firestore.FieldValue.increment(1),
        uniqueVisitors: admin.firestore.FieldValue.arrayUnion(userId),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true }
    );

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
    requireAuth(request);

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
    const totalUniqueVisitors = new Set<string>();
    const dailyData = dailySnap.docs.map((doc) => {
      const data = doc.data();
      totalViews += data.storefrontViews || 0;
      const visitors = data.uniqueVisitors || [];
      visitors.forEach((v: string) => totalUniqueVisitors.add(v));
      return {
        date: data.date,
        storefrontViews: data.storefrontViews || 0,
        uniqueVisitorCount: visitors.length,
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
        totalUniqueVisitors: totalUniqueVisitors.size,
        followerCount,
        daily: dailyData,
      },
    };
  }
);

// ============================================================================
// MUTUAL FOLLOWERS
// ============================================================================

/**
 * Get mutual followers between the current user and a brand's followers.
 * Shows which of the user's contacts also follow this brand.
 */
export const getBrandMutualFollowers = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    requireAppCheck(request, "getBrandMutualFollowers");

    const { brandId, limit: maxResults } = request.data;
    if (!brandId || typeof brandId !== "string") {
      throw new HttpsError("invalid-argument", "brandId is required");
    }

    // Get user's contacts
    const userDoc = await db.collection("users").doc(userId).get();
    const userContacts: string[] = userDoc.data()?.contacts || [];

    if (userContacts.length === 0) {
      return { success: true, mutualFollowers: [], count: 0 };
    }

    const resultLimit = Math.min(maxResults || 10, 30);

    // Check which contacts also follow this brand
    const mutualFollowers: Array<{ userId: string; displayName: string; photoUrl: string | null }> = [];

    // Process in batches of 10
    for (let i = 0; i < userContacts.length && mutualFollowers.length < resultLimit; i += 10) {
      const batchIds = userContacts.slice(i, i + 10);
      const followersSnap = await db
        .collection("brandFollowers")
        .doc(brandId)
        .collection("followers")
        .where(admin.firestore.FieldPath.documentId(), "in", batchIds)
        .get();

      for (const doc of followersSnap.docs) {
        if (mutualFollowers.length >= resultLimit) break;
        const contactDoc = await db.collection("users").doc(doc.id).get();
        const contactData = contactDoc.data();
        mutualFollowers.push({
          userId: doc.id,
          displayName: contactData?.displayName || "User",
          photoUrl: contactData?.photoUrl || null,
        });
      }
    }

    return {
      success: true,
      mutualFollowers,
      count: mutualFollowers.length,
    };
  }
);

// ============================================================================
// TOGGLE BRAND FOLLOW
// ============================================================================

/**
 * Toggle follow/unfollow for a brand.
 * Checks current state and performs the opposite action atomically.
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

    // Check if user currently follows this brand
    const followerDoc = await db
      .collection("brandFollowers")
      .doc(brandId)
      .collection("followers")
      .doc(userId)
      .get();

    const isCurrentlyFollowing = followerDoc.exists;
    const batch = db.batch();

    if (isCurrentlyFollowing) {
      // Unfollow
      batch.update(db.collection("users").doc(userId), {
        followedBrands: admin.firestore.FieldValue.arrayRemove(brandId),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      batch.delete(
        db.collection("brandFollowers").doc(brandId).collection("followers").doc(userId)
      );
      batch.update(db.collection("clients").doc(brandId), {
        followerCount: admin.firestore.FieldValue.increment(-1),
      });
    } else {
      // Verify brand exists and is active
      const clientDoc = await db.collection("clients").doc(brandId).get();
      if (!clientDoc.exists || clientDoc.data()?.isActive !== true) {
        throw new HttpsError("not-found", "Brand not found");
      }

      // Follow
      batch.update(db.collection("users").doc(userId), {
        followedBrands: admin.firestore.FieldValue.arrayUnion(brandId),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      batch.set(
        db.collection("brandFollowers").doc(brandId).collection("followers").doc(userId),
        {
          userId,
          followedAt: admin.firestore.FieldValue.serverTimestamp(),
        }
      );
      batch.update(db.collection("clients").doc(brandId), {
        followerCount: admin.firestore.FieldValue.increment(1),
      });
    }

    await batch.commit();

    const isFollowing = !isCurrentlyFollowing;
    logger.info(`toggleBrandFollow: user ${userId} ${isFollowing ? "followed" : "unfollowed"} brand ${brandId}`);
    return { success: true, isFollowing };
  }
);
