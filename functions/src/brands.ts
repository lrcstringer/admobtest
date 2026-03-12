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

      tx.set(claimRef, {
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
    });

    logger.info(`Coupon ${couponId} claimed by ${userId} from storefront ${storefrontId}`);
    return { success: true, couponCode: couponCode || couponId };
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

    // Increment total view count on storefront
    await storefrontDoc.ref.update({
      totalViews: admin.firestore.FieldValue.increment(1),
    });

    // Record daily analytics — use deterministic visitor doc instead of
    // unbounded array to avoid hitting Firestore's 1MB doc limit on popular brands.
    const today = new Date().toISOString().split("T")[0]; // YYYY-MM-DD
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
    // Transaction prevents race: two concurrent calls could both see !exists and double-increment.
    const visitorRef = dailyRef.collection("visitors").doc(userId);
    await db.runTransaction(async (tx) => {
      const visitorDoc = await tx.get(visitorRef);
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
    requireAuth(request);
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
        // Unfollow
        tx.update(userRef, {
          followedBrands: admin.firestore.FieldValue.arrayRemove(brandId),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        tx.delete(followerRef);
        if (clientDoc.exists) {
          const currentCount = clientDoc.data()?.followerCount || 0;
          if (currentCount > 0) {
            tx.update(clientRef, {
              followerCount: admin.firestore.FieldValue.increment(-1),
            });
          }
        }
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
