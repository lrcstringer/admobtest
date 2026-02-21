/**
 * Reward Sponsor Report — Self-service reporting for brand sponsors
 *
 * Allows authenticated users with a `sponsorClientId` custom claim
 * to query their own campaign performance without admin access.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Get campaign performance report for the sponsor's own client account.
 * Auth: requires authenticated user with `sponsorClientId` custom claim.
 */
export const getSponsorCampaignReport = onCall(
  { labels: { area: "rewards" } },
  async (request) => {
    requireAppCheck(request, "getSponsorCampaignReport");

    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const sponsorClientId = request.auth.token.sponsorClientId as
      | string
      | undefined;

    if (!sponsorClientId) {
      throw new HttpsError(
        "permission-denied",
        "No sponsor access configured. Contact your admin."
      );
    }

    // Get all campaigns for this client
    const campaignsSnapshot = await db
      .collection("rewardCampaigns")
      .where("clientId", "==", sponsorClientId)
      .where("isDeleted", "==", false)
      .orderBy("createdAt", "desc")
      .limit(200)
      .get();

    if (campaignsSnapshot.empty) {
      return { campaigns: [], summary: null };
    }

    const campaigns = [];
    let totalAllocated = 0;
    let totalRedeemed = 0;
    let totalExpired = 0;
    let totalRevoked = 0;
    let totalQuantity = 0;

    for (const doc of campaignsSnapshot.docs) {
      const c = doc.data();
      const allocated = c.allocatedQuantity || 0;
      const redeemed = c.redeemedQuantity || 0;
      const remaining = c.remainingQuantity || 0;
      const reserved = c.reservedCount || 0;
      const expired = c.expiredCount || 0;
      const revoked = c.revokedCount || 0;
      const total = c.totalQuantity || 0;

      totalAllocated += allocated;
      totalRedeemed += redeemed;
      totalExpired += expired;
      totalRevoked += revoked;
      totalQuantity += total;

      campaigns.push({
        id: c.id,
        name: c.name,
        status: c.status,
        rewardType: c.rewardType,
        totalQuantity: total,
        remainingQuantity: remaining,
        reservedCount: reserved,
        allocatedQuantity: allocated,
        redeemedQuantity: redeemed,
        expiredCount: expired,
        revokedCount: revoked,
        redemptionRate:
          allocated > 0
            ? Math.round((redeemed / allocated) * 10000) / 100
            : 0,
        startsAt: c.startsAt?.toDate?.()?.toISOString() || null,
        endsAt: c.endsAt?.toDate?.()?.toISOString() || null,
        createdAt: c.createdAt?.toDate?.()?.toISOString() || null,
      });
    }

    // Per-campaign daily timeline (last 30 days) for the most recent 5 campaigns
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    thirtyDaysAgo.setHours(0, 0, 0, 0);

    const recentCampaignIds = campaigns.slice(0, 5).map((c) => c.id);
    const timeline: Record<string, Array<{ date: string; allocations: number; redemptions: number }>> = {};

    for (const campaignId of recentCampaignIds) {
      const activitySnapshot = await db
        .collection("rewardActivityLog")
        .where("campaignId", "==", campaignId)
        .where("action", "in", ["allocated", "redeemed"])
        .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(thirtyDaysAgo))
        .limit(1000)
        .get();

      const dailyMap = new Map<string, { allocations: number; redemptions: number }>();

      for (const logDoc of activitySnapshot.docs) {
        const log = logDoc.data();
        const date = log.createdAt?.toDate?.();
        if (!date) continue;
        const dateKey = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;

        if (!dailyMap.has(dateKey)) {
          dailyMap.set(dateKey, { allocations: 0, redemptions: 0 });
        }
        const day = dailyMap.get(dateKey)!;
        if (log.action === "allocated") day.allocations++;
        if (log.action === "redeemed") day.redemptions++;
      }

      timeline[campaignId] = Array.from(dailyMap.entries())
        .sort(([a], [b]) => a.localeCompare(b))
        .map(([date, stats]) => ({ date, ...stats }));
    }

    return {
      campaigns,
      timeline,
      summary: {
        totalCampaigns: campaigns.length,
        totalQuantity,
        totalAllocated,
        totalRedeemed,
        totalExpired,
        totalRevoked,
        overallRedemptionRate:
          totalAllocated > 0
            ? Math.round((totalRedeemed / totalAllocated) * 10000) / 100
            : 0,
      },
    };
  }
);
