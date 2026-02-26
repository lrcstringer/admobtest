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
