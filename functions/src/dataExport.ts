/**
 * Data Export Cloud Function — POPIA/GDPR Right to Data Portability
 *
 * Authenticated callable that exports all user-owned data as JSON.
 * Rate limited to 1 export per 24 hours per user.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

export const exportUserData = onCall(
  { timeoutSeconds: 300, memory: "512MiB", labels: { area: "lifecycle" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "User must be authenticated to export data."
      );
    }
    requireAppCheck(request, "exportUserData");

    const userId = request.auth.uid;

    // ── Rate limit: 1 export per 24 hours ──────────────────────────────
    const rateLimitRef = db.collection("rateLimits").doc(`${userId}_data_export`);
    const rateLimitDoc = await rateLimitRef.get();

    if (rateLimitDoc.exists) {
      const lastExport = rateLimitDoc.data()?.lastExportAt?.toDate();
      if (lastExport) {
        const hoursSince = (Date.now() - lastExport.getTime()) / (1000 * 60 * 60);
        if (hoursSince < 24) {
          throw new HttpsError(
            "resource-exhausted",
            "Data export is limited to once per 24 hours. " +
            `Please try again in ${Math.ceil(24 - hoursSince)} hours.`
          );
        }
      }
    }

    logger.info(`Data export requested by user ${userId}`);

    try {
      const exportData: Record<string, unknown> = {};

      // ── User profile ───────────────────────────────────────────────
      const userDoc = await db.collection("users").doc(userId).get();
      if (userDoc.exists) {
        exportData.profile = userDoc.data();
      }

      // ── Collections where user is referenced by field ──────────────
      // Note: wallets collection deprecated - use ledgerAccounts
      const collections: [string, string, string][] = [
        ["transactions", "userId", "transactions"],
        ["earnings", "userId", "earnings"],
        ["cashouts", "userId", "cashouts"],
        ["earnThreads", "userId", "earnThreads"],
        ["engagements", "userId", "engagements"],
        ["potEntries", "userId", "potEntries"],
        ["potWinners", "userId", "potWinners"],
        ["referralCodes", "userId", "referralCodes"],
        ["referralStats", "userId", "referralStats"],
        ["referrals", "referrerUserId", "referralsMade"],
        ["referrals", "refereeUserId", "referralsReceived"],
        ["purchases", "userId", "purchases"],
        ["contacts", "userId", "contacts"],
        ["chatMessages", "senderId", "messagesSent"],
        ["paymentRequests", "requesterId", "paymentRequestsMade"],
        ["paymentRequests", "payerId", "paymentRequestsReceived"],
      ];

      // Parallelize all collection queries with a per-collection limit
      const results = await Promise.all(
        collections.map(async ([collection, field, exportKey]) => {
          const snapshot = await db.collection(collection)
            .where(field, "==", userId)
            .limit(1000)
            .get();
          return { exportKey, snapshot };
        })
      );

      for (const { exportKey, snapshot } of results) {
        if (!snapshot.empty) {
          exportData[exportKey] = snapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));
        }
      }

      // ── Engagement Stats (streak tracking) ───────────────────────────
      const engagementStatsDoc = await db
        .collection("userEngagementStats")
        .doc(userId)
        .get();

      if (engagementStatsDoc.exists) {
        exportData.engagementStats = {
          id: engagementStatsDoc.id,
          ...engagementStatsDoc.data(),
        };
      }

      // ── Ledger Account and Sub-Accounts ──────────────────────────────
      const ledgerAccountDoc = await db
        .collection("ledgerAccounts")
        .doc(userId)
        .get();

      if (ledgerAccountDoc.exists) {
        const ledgerAccount: Record<string, unknown> = {
          id: ledgerAccountDoc.id,
          ...ledgerAccountDoc.data(),
        };

        // Get sub-accounts
        const subAccountsSnap = await db
          .collection("ledgerAccounts")
          .doc(userId)
          .collection("subAccounts")
          .get();

        if (!subAccountsSnap.empty) {
          ledgerAccount.subAccounts = subAccountsSnap.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));
        }

        exportData.ledgerAccount = ledgerAccount;
      }

      // ── Daily Scores (score history) ─────────────────────────────────
      const dailyScoresSnap = await db
        .collection("users")
        .doc(userId)
        .collection("dailyScores")
        .orderBy("date", "desc")
        .limit(365) // Last year of scores
        .get();

      if (!dailyScoresSnap.empty) {
        exportData.dailyScores = dailyScoresSnap.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
      }

      // ── Leaderboard scores (new structure: leaderboards/{type}/scores) ──
      const leaderboardTypes = ["daily", "weekly", "allTime"];
      const leaderboardData: Record<string, unknown> = {};

      for (const type of leaderboardTypes) {
        const scoreDoc = await db
          .collection("leaderboards")
          .doc(type)
          .collection("scores")
          .doc(userId)
          .get();

        if (scoreDoc.exists) {
          leaderboardData[type] = {
            id: scoreDoc.id,
            ...scoreDoc.data(),
          };
        }
      }

      if (Object.keys(leaderboardData).length > 0) {
        exportData.leaderboardScores = leaderboardData;
      }

      // ── Chat threads ──────────────────────────────────────────────
      const threads = await db.collection("chatThreads")
        .where("participantIds", "array-contains", userId)
        .limit(5000)
        .get();

      if (!threads.empty) {
        exportData.chatThreads = threads.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
      }

      // ── Record rate limit ─────────────────────────────────────────
      await rateLimitRef.set({
        userId,
        lastExportAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      logger.info(`Data export complete for user ${userId}`);

      return {
        success: true,
        exportedAt: new Date().toISOString(),
        data: exportData,
      };
    } catch (error) {
      logger.error(`Data export failed for user ${userId}:`, error);
      throw new HttpsError(
        "internal",
        "Data export failed. Please try again."
      );
    }
  }
);
