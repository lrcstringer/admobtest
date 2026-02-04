/**
 * Account Deletion Cloud Function
 *
 * Authenticated callable that deletes ALL user data from Firestore,
 * then deletes the Firebase Auth account via Admin SDK.
 *
 * This replaces the client-side user.delete() approach, which:
 * - Required recent authentication (could throw requires-recent-login)
 * - Did not delete the Firestore users/{userId} document
 * - Left the onUserDeleted trigger as the only cleanup (which only covered 4 collections)
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Delete a user's account and all associated data.
 *
 * Must be called by the authenticated user themselves.
 * Performs complete data cleanup across all Firestore collections,
 * then deletes the Firebase Auth account via Admin SDK.
 *
 * @returns {{ success: boolean }}
 */
export const deleteUserAccount = functions
  .runWith({ timeoutSeconds: 540, memory: "512MB" })
  .https.onCall(async (data, context) => {
    // Require authentication — only the user themselves can delete
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated to delete their account."
      );
    }
    requireAppCheck(context, "deleteUserAccount");

    const userId = context.auth.uid;

    console.log(`Account deletion requested by user ${userId}`);

    // ── Pre-check: reject if there are pending cashouts ───────────────
    const pendingCashouts = await db.collection("cashouts")
      .where("userId", "==", userId)
      .where("status", "==", "processing")
      .limit(1)
      .get();

    if (!pendingCashouts.empty) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Cannot delete account while cashouts are being processed. " +
        "Please wait for pending cashouts to complete."
      );
    }

    try {
      // ── Phase 0: Read user data before deletion ───────────────────
      //
      // Capture phone number and device IDs so we can clean up rate
      // limit documents keyed by those identifiers (not just userId).

      const identifiers: string[] = [userId];

      const userDoc = await db.collection("users").doc(userId).get();
      if (userDoc.exists) {
        const userData = userDoc.data();
        if (userData?.phoneNumber) {
          identifiers.push(userData.phoneNumber);
        }
      }

      const deviceDocs = await db.collection("devices")
        .where("userId", "==", userId)
        .get();
      for (const doc of deviceDocs.docs) {
        const deviceId = doc.data()?.deviceId;
        if (deviceId) {
          identifiers.push(deviceId);
        }
      }

      // ── Phase 1: Delete user-specific documents (by field query) ────
      //
      // Collections where user is referenced by a field (not doc ID).
      // Each entry: [collectionName, fieldName]

      const fieldQueryCollections: [string, string][] = [
        // Financial (wallets collection deprecated - use ledgerAccounts)
        ["transactions", "userId"],
        ["cashouts", "userId"],
        ["earnings", "userId"],
        // Earning & engagement
        ["earnThreads", "userId"],
        ["engagements", "userId"],
        // Gamification
        ["potEntries", "userId"],
        ["potWinners", "userId"],
        ["leaderboard", "userId"],
        // Referrals
        ["referralCodes", "userId"],
        ["referralStats", "userId"],
        ["referrals", "referrerId"],
        ["referrals", "refereeUserId"],
        // Purchases
        ["purchases", "userId"],
        // Contacts
        ["contacts", "userId"],
        // Devices & auth
        ["devices", "userId"],
        ["authChallenges", "userId"],
        ["biometricChallenges", "userId"],
        // Security & fraud
        ["fraudFlags", "userId"],
        ["fraudAlerts", "userId"],
        ["riskEvents", "userId"],
        ["auditLogs", "userId"],
        ["integrityChecks", "userId"],
        ["captchaVerifications", "userId"],
        // Chat — sender side (delete messages the user sent)
        ["chatMessages", "senderId"],
        // Payment requests — requester side
        ["paymentRequests", "requesterId"],
      ];

      for (const [collection, field] of fieldQueryCollections) {
        await deleteByFieldQuery(collection, field, userId);
      }

      // ── Phase 2: Anonymize chat messages where user is recipient ────
      //
      // We don't delete these because the sender still needs their
      // conversation history. Instead, we replace the recipientId.

      await anonymizeChatRecipient(userId);

      // ── Phase 3: Clean up chat threads ──────────────────────────────
      //
      // Remove user from participantIds arrays. If the thread has no
      // remaining participants, delete it entirely.

      await cleanupChatThreads(userId);

      // ── Phase 4: Delete payment requests where user is payer ────────

      await deleteByFieldQuery("paymentRequests", "payerId", userId);

      // ── Phase 5: Delete documents by ID ─────────────────────────────
      //
      // Some collections use userId as document ID.

      const docIdCollections = [
        "leaderboard",
        "referralStats",
        "referralCodes",
        "blockedUsers",
        "userEngagementStats", // New: streak tracking
      ];

      const docIdBatch = db.batch();
      for (const collection of docIdCollections) {
        docIdBatch.delete(db.collection(collection).doc(userId));
      }
      await docIdBatch.commit();

      // ── Phase 5b: Delete ledgerAccounts subcollections ────────────────
      //
      // Delete subAccounts subcollection, then the ledgerAccount document.

      const subAccountsSnap = await db
        .collection("ledgerAccounts")
        .doc(userId)
        .collection("subAccounts")
        .get();

      if (!subAccountsSnap.empty) {
        const subAccountBatch = db.batch();
        subAccountsSnap.docs.forEach((doc) => {
          subAccountBatch.delete(doc.ref);
        });
        await subAccountBatch.commit();
        console.log(`  Deleted ${subAccountsSnap.size} subAccounts for user`);
      }

      await db.collection("ledgerAccounts").doc(userId).delete();
      console.log("  Deleted ledgerAccount document");

      // ── Phase 5c: Delete dailyScores subcollection ────────────────────
      //
      // User's daily score history stored as users/{userId}/dailyScores/{date}

      const dailyScoresSnap = await db
        .collection("users")
        .doc(userId)
        .collection("dailyScores")
        .get();

      if (!dailyScoresSnap.empty) {
        const dailyScoresBatch = db.batch();
        dailyScoresSnap.docs.forEach((doc) => {
          dailyScoresBatch.delete(doc.ref);
        });
        await dailyScoresBatch.commit();
        console.log(`  Deleted ${dailyScoresSnap.size} dailyScores for user`);
      }

      // ── Phase 6: Delete rate limit documents ────────────────────────
      //
      // Rate limit docs have composite IDs: ${identifier}_${action}
      // where identifier may be userId, phone number, or device ID.

      await deleteRateLimits(identifiers);

      // ── Phase 7: Delete the user document itself ────────────────────

      await db.collection("users").doc(userId).delete();

      // ── Phase 8: Delete Firebase Auth account ───────────────────────

      await admin.auth().deleteUser(userId);

      console.log(
        `Account deletion complete for user ${userId}: ` +
        `all Firestore data and Auth account removed.`
      );

      return { success: true };
    } catch (error) {
      console.error(`Account deletion failed for user ${userId}:`, error);
      throw new functions.https.HttpsError(
        "internal",
        "Account deletion failed. Please try again or contact support."
      );
    }
  });

// ── Helper Functions ──────────────────────────────────────────────────────

/**
 * Delete all documents in a collection where field == value.
 * Uses batched writes (max 500 per batch) for efficiency.
 */
async function deleteByFieldQuery(
  collectionName: string,
  field: string,
  value: string
): Promise<void> {
  let deleted = 0;

  // Loop to handle collections with >500 matching documents
  while (true) {
    const snapshot = await db.collection(collectionName)
      .where(field, "==", value)
      .limit(500)
      .get();

    if (snapshot.empty) break;

    const batch = db.batch();
    snapshot.docs.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
    deleted += snapshot.size;

    if (snapshot.size < 500) break;
  }

  if (deleted > 0) {
    console.log(
      `  Deleted ${deleted} docs from ${collectionName} (${field}=${value})`
    );
  }
}

/**
 * Anonymize chat messages where the deleted user is the recipient.
 *
 * We don't delete these because the sender still needs their
 * conversation history. Instead, we clear recipient-identifying info.
 */
async function anonymizeChatRecipient(userId: string): Promise<void> {
  let updated = 0;

  while (true) {
    const snapshot = await db.collection("chatMessages")
      .where("recipientId", "==", userId)
      .limit(500)
      .get();

    if (snapshot.empty) break;

    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
      batch.update(doc.ref, {
        recipientId: "deleted_user",
      });
    });
    await batch.commit();
    updated += snapshot.size;

    if (snapshot.size < 500) break;
  }

  if (updated > 0) {
    console.log(`  Anonymized ${updated} chat messages (recipient)`);
  }
}

/**
 * Remove user from chat thread participant lists.
 * Delete threads that become empty.
 */
async function cleanupChatThreads(userId: string): Promise<void> {
  const threads = await db.collection("chatThreads")
    .where("participantIds", "array-contains", userId)
    .get();

  if (threads.empty) return;

  const batch = db.batch();
  let deleted = 0;
  let updated = 0;

  for (const doc of threads.docs) {
    const data = doc.data();
    const participants: string[] = data.participantIds || [];
    const remaining = participants.filter((id: string) => id !== userId);

    if (remaining.length === 0) {
      batch.delete(doc.ref);
      deleted++;
    } else {
      batch.update(doc.ref, {
        participantIds: remaining,
      });
      updated++;
    }
  }

  await batch.commit();
  console.log(
    `  Chat threads: ${deleted} deleted, ${updated} updated (removed participant)`
  );
}

/**
 * Delete rate limit documents for all identifiers associated with the user.
 * Rate limit doc IDs use format: ${identifier}_${action}
 * where identifier can be userId, phone number, or device ID.
 */
async function deleteRateLimits(identifiers: string[]): Promise<void> {
  const rateLimitsRef = db.collection("rateLimits");
  let totalDeleted = 0;

  for (const identifier of identifiers) {
    const snapshot = await rateLimitsRef
      .where(admin.firestore.FieldPath.documentId(), ">=", identifier)
      .where(
        admin.firestore.FieldPath.documentId(),
        "<",
        identifier + "\uf8ff"
      )
      .get();

    if (snapshot.empty) continue;

    const batch = db.batch();
    snapshot.docs.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
    totalDeleted += snapshot.size;
  }

  if (totalDeleted > 0) {
    console.log(`  Deleted ${totalDeleted} rate limit docs for user`);
  }
}
