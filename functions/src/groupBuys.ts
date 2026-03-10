/**
 * Group Buy (Hlangana) Cloud Functions
 *
 * Consumer-facing functions for group buying deals.
 * Handles creation, joining, completion, and scheduled expiry checks.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import {
  processGroupBuyEscrow,
  releaseGroupBuyEscrow,
  refundGroupBuyContribution,
} from "./ledger/groupBuyEscrow";
import { validateMainWalletBalance, getSubAccount } from "./ledger";

const db = admin.firestore();

// ============================================================================
// CREATE GROUP BUY
// ============================================================================

/**
 * Create a new community-organized group buy.
 * Only authenticated users can create group buys.
 */
export const createGroupBuy = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "createGroupBuy");

    const userId = request.auth.uid;
    const {
      title,
      description,
      targetAmount,
      deadline,
      linkedListingId,
      minParticipants,
      maxParticipants,
    } = request.data;

    // Validate required fields
    if (!title || typeof title !== "string" || title.trim().length < 3) {
      throw new HttpsError("invalid-argument", "Title must be at least 3 characters");
    }
    if (!description || typeof description !== "string") {
      throw new HttpsError("invalid-argument", "Description is required");
    }
    if (!targetAmount || typeof targetAmount !== "number" || targetAmount <= 0 || !Number.isInteger(targetAmount)) {
      throw new HttpsError("invalid-argument", "Target amount must be a positive integer");
    }
    if (!deadline) {
      throw new HttpsError("invalid-argument", "Deadline is required");
    }

    const deadlineDate = new Date(deadline);
    if (isNaN(deadlineDate.getTime()) || deadlineDate <= new Date()) {
      throw new HttpsError("invalid-argument", "Deadline must be in the future");
    }

    // Validate min/max participants
    const minPart = minParticipants || 2;
    const maxPart = maxParticipants || null;
    if (typeof minPart !== "number" || minPart < 2) {
      throw new HttpsError("invalid-argument", "Minimum participants must be at least 2");
    }
    if (maxPart !== null && (typeof maxPart !== "number" || maxPart < minPart)) {
      throw new HttpsError("invalid-argument", "Maximum participants must be >= minimum participants");
    }

    // Get user profile for organizer name
    const userDoc = await db.collection("users").doc(userId).get();
    const userData = userDoc.data();
    const organizerName = userData?.displayName || "Unknown";
    const communityId = userData?.communityId || null;

    const groupBuyRef = db.collection("groupBuys").doc();
    const now = admin.firestore.FieldValue.serverTimestamp();

    await groupBuyRef.set({
      id: groupBuyRef.id,
      title: title.trim(),
      description: description.trim(),
      linkedListingId: linkedListingId || null,
      organizerId: userId,
      organizerName,
      communityId,
      targetAmount,
      currentAmount: 0,
      minParticipants: minPart,
      maxParticipants: maxPart,
      deadline: admin.firestore.Timestamp.fromDate(deadlineDate),
      status: "open",
      participantCount: 0,
      sponsorType: "community",
      brandId: null,
      brandName: null,
      brandLogoUrl: null,
      discountPercent: null,
      createdAt: now,
      updatedAt: now,
    });

    logger.info(`Group buy created: ${groupBuyRef.id} by ${userId}`);

    return { success: true, groupBuyId: groupBuyRef.id };
  }
);

// ============================================================================
// JOIN GROUP BUY
// ============================================================================

/**
 * Join a group buy with a token contribution.
 * Escrows the contributor's tokens into GROUP_BUY_ESCROW.
 */
export const joinGroupBuy = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "joinGroupBuy");

    const userId = request.auth.uid;
    const { groupBuyId, amount, walletId } = request.data;

    if (!groupBuyId || typeof groupBuyId !== "string") {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }
    if (!amount || typeof amount !== "number" || amount <= 0 || !Number.isInteger(amount)) {
      throw new HttpsError("invalid-argument", "Amount must be a positive integer");
    }

    // Pre-validate wallet balance before entering transaction
    if (walletId) {
      const subAccount = await getSubAccount(userId, walletId);
      if (!subAccount || subAccount.balance < amount) {
        throw new HttpsError("failed-precondition", "Insufficient balance in selected wallet");
      }
    } else {
      const balanceCheck = await validateMainWalletBalance(userId, amount);
      if (!balanceCheck.sufficient) {
        throw new HttpsError("failed-precondition", "Insufficient balance");
      }
    }

    // Get user name upfront
    const userDoc = await db.collection("users").doc(userId).get();
    const userName = userDoc.data()?.displayName || "Unknown";

    // Use a Firestore transaction for atomic read-check-write
    // This prevents TOCTOU races: concurrent joins exceeding maxParticipants
    const groupBuyRef = db.collection("groupBuys").doc(groupBuyId);
    const contribRef = groupBuyRef.collection("contributions").doc();

    const result = await db.runTransaction(async (tx) => {
      const groupBuyDoc = await tx.get(groupBuyRef);
      if (!groupBuyDoc.exists) {
        throw new HttpsError("not-found", "Group buy not found");
      }

      const groupBuy = groupBuyDoc.data()!;
      if (groupBuy.status !== "open") {
        throw new HttpsError("failed-precondition", "This group buy is no longer accepting contributions");
      }

      // Check deadline
      const deadline = groupBuy.deadline?.toDate?.() || new Date(groupBuy.deadline);
      if (new Date() > deadline) {
        throw new HttpsError("failed-precondition", "This group buy has expired");
      }

      // Check max participants (transactional read — no TOCTOU)
      if (groupBuy.maxParticipants && groupBuy.participantCount >= groupBuy.maxParticipants) {
        throw new HttpsError("failed-precondition", "This group buy is full");
      }

      // Check duplicate contribution within transaction
      const existingContrib = await tx.get(
        groupBuyRef
          .collection("contributions")
          .where("userId", "==", userId)
          .limit(1)
      );
      if (!existingContrib.empty) {
        throw new HttpsError("already-exists", "You have already joined this group buy");
      }

      // Calculate target status using transactional read values
      const newAmount = groupBuy.currentAmount + amount;
      const targetMet = newAmount >= groupBuy.targetAmount;

      // Write contribution + update group buy atomically within transaction
      tx.set(contribRef, {
        id: contribRef.id,
        userId,
        userName,
        amount,
        journalId: "", // Placeholder — updated after escrow
        contributedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      tx.update(groupBuyRef, {
        currentAmount: admin.firestore.FieldValue.increment(amount),
        participantCount: admin.firestore.FieldValue.increment(1),
        status: targetMet ? "targetMet" : "open",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return { newAmount, targetMet, title: groupBuy.title };
    });

    // Process escrow AFTER transaction succeeds (ledger has its own idempotency).
    // If escrow fails, run a compensating transaction to revert the contribution.
    let journalId: string;
    try {
      journalId = await processGroupBuyEscrow(
        userId,
        amount,
        groupBuyId,
        `Group buy contribution: ${result.title}`
      );
    } catch (escrowError) {
      // Compensating transaction: delete contribution, decrement counts
      logger.error(`Escrow failed for group buy ${groupBuyId}, reverting contribution`, escrowError);
      await db.runTransaction(async (tx) => {
        tx.delete(contribRef);
        tx.update(groupBuyRef, {
          currentAmount: admin.firestore.FieldValue.increment(-amount),
          participantCount: admin.firestore.FieldValue.increment(-1),
          // If we had flipped to targetMet, revert to open
          ...(result.targetMet ? { status: "open" } : {}),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      });
      throw new HttpsError("internal", "Payment processing failed. Please try again.");
    }

    // Update the contribution with the real journal ID
    await contribRef.update({ journalId });

    logger.info(
      `User ${userId} joined group buy ${groupBuyId} with ${amount} tokens. ` +
      `New total: ${result.newAmount}/${result.title}. Target met: ${result.targetMet}`
    );

    return {
      success: true,
      contributionId: contribRef.id,
      journalId,
      targetMet: result.targetMet,
    };
  }
);

// ============================================================================
// COMPLETE GROUP BUY
// ============================================================================

/**
 * Complete a group buy — releases escrowed funds to the organizer.
 * Can be called by the organizer when target is met.
 */
export const completeGroupBuy = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "completeGroupBuy");

    const userId = request.auth.uid;
    const { groupBuyId } = request.data;

    if (!groupBuyId || typeof groupBuyId !== "string") {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }

    const groupBuyRef = db.collection("groupBuys").doc(groupBuyId);

    // Use transaction to prevent TOCTOU race (concurrent completeGroupBuy calls)
    const txResult = await db.runTransaction(async (tx) => {
      const groupBuyDoc = await tx.get(groupBuyRef);
      if (!groupBuyDoc.exists) {
        throw new HttpsError("not-found", "Group buy not found");
      }

      const groupBuy = groupBuyDoc.data()!;

      // Only organizer can complete
      if (groupBuy.organizerId !== userId) {
        throw new HttpsError("permission-denied", "Only the organizer can complete this group buy");
      }

      if (groupBuy.status !== "targetMet") {
        throw new HttpsError(
          "failed-precondition",
          "Group buy can only be completed when target is met"
        );
      }

      // Mark as completed inside transaction
      tx.update(groupBuyRef, {
        status: "completed",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {
        organizerId: groupBuy.organizerId,
        currentAmount: groupBuy.currentAmount,
        title: groupBuy.title,
      };
    });

    // Release escrow outside transaction (ledger has its own idempotency).
    // If release fails, revert status to "targetMet" so it can be retried.
    let releaseJournalId: string;
    try {
      releaseJournalId = await releaseGroupBuyEscrow(
        txResult.organizerId,
        txResult.currentAmount,
        groupBuyId,
        `Group buy completed: ${txResult.title}`
      );
    } catch (releaseError) {
      logger.error(`Escrow release failed for group buy ${groupBuyId}, reverting to targetMet`, releaseError);
      await groupBuyRef.update({
        status: "targetMet",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      throw new HttpsError("internal", "Payment release failed. Please try again.");
    }

    logger.info(
      `Group buy ${groupBuyId} completed. ${txResult.currentAmount} tokens ` +
      `released to organizer ${txResult.organizerId}`
    );

    return { success: true, releaseJournalId };
  }
);

// ============================================================================
// SCHEDULED: CHECK EXPIRED GROUP BUYS
// ============================================================================

/**
 * Runs every 30 minutes. Finds expired group buys and refunds all contributions.
 */
// ============================================================================
// LEAVE GROUP BUY
// ============================================================================

/**
 * Leave a group buy before target is met. Refunds the user's contribution.
 * Only allowed when status is still "open" (not "targetMet" or terminal).
 */
export const leaveGroupBuy = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "leaveGroupBuy");

    const userId = request.auth.uid;
    const { groupBuyId } = request.data;

    if (!groupBuyId || typeof groupBuyId !== "string") {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }

    const groupBuyRef = db.collection("groupBuys").doc(groupBuyId);

    // Use transaction to atomically check status, find contribution, update counts
    const result = await db.runTransaction(async (tx) => {
      const groupBuyDoc = await tx.get(groupBuyRef);
      if (!groupBuyDoc.exists) {
        throw new HttpsError("not-found", "Group buy not found");
      }

      const groupBuy = groupBuyDoc.data()!;

      // Only allow leaving when status is "open"
      if (groupBuy.status !== "open") {
        throw new HttpsError(
          "failed-precondition",
          "Cannot leave a group buy that is no longer open"
        );
      }

      // Find user's contribution within transaction
      const contribSnapshot = await tx.get(
        groupBuyRef
          .collection("contributions")
          .where("userId", "==", userId)
          .limit(1)
      );

      if (contribSnapshot.empty) {
        throw new HttpsError("not-found", "You have not joined this group buy");
      }

      const contribDoc = contribSnapshot.docs[0];
      const contrib = contribDoc.data();

      // Delete contribution and update group buy atomically
      tx.delete(contribDoc.ref);
      tx.update(groupBuyRef, {
        currentAmount: admin.firestore.FieldValue.increment(-contrib.amount),
        participantCount: admin.firestore.FieldValue.increment(-1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return { amount: contrib.amount, title: groupBuy.title };
    });

    // Refund escrow AFTER transaction succeeds (ledger has its own idempotency)
    await refundGroupBuyContribution(
      userId,
      result.amount,
      groupBuyId,
      `User left group buy: ${result.title}`
    );

    logger.info(
      `User ${userId} left group buy ${groupBuyId}. ` +
      `Refunded ${result.amount} tokens.`
    );

    return { success: true, refundedAmount: result.amount };
  }
);

// ============================================================================
// SUGGEST A DEAL
// ============================================================================

/**
 * Submit a group buy deal suggestion from a user.
 * Goes into groupBuyRequests collection for admin review.
 */
export const suggestGroupBuyDeal = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    requireAppCheck(request, "suggestGroupBuyDeal");

    const userId = request.auth.uid;
    const {
      description,
      brandOrStore,
      estimatedPrice,
      sourceUrl,
      imageUrl,
      wantsToJoin,
    } = request.data;

    if (!description || typeof description !== "string" || description.trim().length < 10) {
      throw new HttpsError("invalid-argument", "Description must be at least 10 characters");
    }
    if (!brandOrStore || typeof brandOrStore !== "string" || brandOrStore.trim().length < 2) {
      throw new HttpsError("invalid-argument", "Brand or store name is required");
    }

    // Get user profile for display name
    const userDoc = await db.collection("users").doc(userId).get();
    const userName = userDoc.data()?.displayName || "Unknown";

    const requestRef = db.collection("groupBuyRequests").doc();
    const now = admin.firestore.FieldValue.serverTimestamp();

    await requestRef.set({
      id: requestRef.id,
      userId,
      userName,
      description: description.trim(),
      brandOrStore: brandOrStore.trim(),
      estimatedPrice: estimatedPrice?.toString().trim() || null,
      sourceUrl: sourceUrl?.toString().trim() || null,
      imageUrl: imageUrl?.toString().trim() || null,
      wantsToJoin: wantsToJoin === true,
      status: "pending", // pending | approved | rejected
      adminNotes: null,
      convertedGroupBuyId: null,
      createdAt: now,
      updatedAt: now,
    });

    logger.info(`Group buy suggestion ${requestRef.id} submitted by ${userId}`);

    return { success: true, requestId: requestRef.id };
  }
);

// ============================================================================
// SCHEDULED: CHECK EXPIRED GROUP BUYS
// ============================================================================

export const checkExpiredGroupBuys = onSchedule(
  {
    schedule: "every 30 minutes",
    region: "europe-west1",
    labels: { area: "groupbuys" },
    timeoutSeconds: 300,
  },
  async () => {
    const now = admin.firestore.Timestamp.now();

    // Find open or targetMet group buys that are past deadline
    const expiredSnapshot = await db
      .collection("groupBuys")
      .where("status", "in", ["open", "targetMet"])
      .where("deadline", "<=", now)
      .get();

    if (expiredSnapshot.empty) {
      logger.info("No expired group buys found");
      return;
    }

    logger.info(`Found ${expiredSnapshot.size} expired group buys to process`);

    for (const doc of expiredSnapshot.docs) {
      const groupBuy = doc.data();
      const groupBuyId = doc.id;

      try {
        // Load all contributions
        const contribsSnapshot = await doc.ref
          .collection("contributions")
          .get();

        // Refund each contributor
        let refundedCount = 0;
        let failedCount = 0;
        for (const contribDoc of contribsSnapshot.docs) {
          const contrib = contribDoc.data();
          try {
            await refundGroupBuyContribution(
              contrib.userId,
              contrib.amount,
              groupBuyId,
              `Group buy expired: ${groupBuy.title}`
            );
            refundedCount++;
            logger.info(
              `Refunded ${contrib.amount} tokens to ${contrib.userId} ` +
              `for expired group buy ${groupBuyId}`
            );
          } catch (err) {
            failedCount++;
            // Log but continue — don't let one failed refund block others
            logger.error(
              `Failed to refund ${contrib.userId} for group buy ${groupBuyId}:`,
              err
            );
          }
        }

        // Update status — track failed refunds so admin can retry
        await doc.ref.update({
          status: "expired",
          refundedCount,
          failedRefundCount: failedCount,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        logger.info(`Group buy ${groupBuyId} marked as expired. Refunded ${contribsSnapshot.size} contributions.`);
      } catch (err) {
        logger.error(`Error processing expired group buy ${groupBuyId}:`, err);
      }
    }
  }
);
