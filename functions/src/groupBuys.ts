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
import { requireAdminPermission } from "./adminAuth";

const db = admin.firestore();

// Helper: deterministic contribution doc ID
function getContributionDocId(userId: string, groupBuyId: string): string {
  return `${userId}_${groupBuyId}`;
}

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
    await requireAppCheck(request, "createGroupBuy");

    const userId = request.auth.uid;
    const {
      title,
      description,
      targetAmount,
      deadline,
      linkedListingId,
      minParticipants,
      maxParticipants,
      imageUrl,
    } = request.data;

    // Validate required fields
    if (!title || typeof title !== "string" || title.trim().length < 3 || title.trim().length > 200) {
      throw new HttpsError("invalid-argument", "Title must be between 3 and 200 characters");
    }
    if (!description || typeof description !== "string" || description.trim().length > 5000) {
      throw new HttpsError("invalid-argument", "Description is required and must not exceed 5000 characters");
    }
    if (!targetAmount || typeof targetAmount !== "number" || targetAmount <= 0 || !Number.isInteger(targetAmount) || targetAmount > 10000000) {
      throw new HttpsError("invalid-argument", "Target amount must be a positive integer up to 10,000,000");
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
    if (maxPart !== null && maxPart !== undefined && maxPart <= 0) {
      throw new HttpsError("invalid-argument", "Maximum participants must be greater than 0");
    }
    if (maxPart !== null && (typeof maxPart !== "number" || maxPart < minPart || maxPart > 10000)) {
      throw new HttpsError("invalid-argument", "Maximum participants must be between minimum participants and 10,000");
    }

    // Get user profile for organizer name
    const userDoc = await db.collection("users").doc(userId).get();
    const userData = userDoc.data();
    const organizerName = userData?.displayName || userData?.email || "Unknown Organizer";
    const communityId = userData?.communityId || null;

    // Validate linked listing if provided
    if (linkedListingId) {
      const listingDoc = await db.collection("marketplaceListings").doc(linkedListingId).get();
      if (!listingDoc.exists || listingDoc.data()!.status !== "active") {
        throw new HttpsError("not-found", "Linked listing not found or is not active");
      }
    }

    // Deterministic ID prevents duplicate creation on client retry.
    // Uses userId + title hash + date bucket.
    const titleHash = title.trim().toLowerCase().replace(/[^a-z0-9]/g, "").substring(0, 20);
    const dateBucket = new Date().toISOString().split("T")[0];
    const groupBuyRef = db.collection("groupBuys").doc(`${userId}_${titleHash}_${dateBucket}`);
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
      createdByAdmin: false,
      type: "digital",
      fulfilmentType: "digital",
      clusters: [],
      addresses: [],
      voucherCodes: [],
      imageUrl: imageUrl?.toString().trim() || null,
      originalPrice: null,
      collectionDeadline: null,
      deliveryStatus: null,
      fulfilmentInstructions: null,
      category: null,
      deliveryFee: 0,
      organizerSuccessRate: 1.0,
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
    await requireAppCheck(request, "joinGroupBuy");

    const userId = request.auth.uid;
    const { groupBuyId, amount, walletId, deliveryAddress } = request.data;

    if (!groupBuyId || typeof groupBuyId !== "string") {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }
    if (!amount || typeof amount !== "number" || amount <= 0 || !Number.isInteger(amount)) {
      throw new HttpsError("invalid-argument", "Amount must be a positive integer");
    }

    // Pre-validate wallet balance — fast-fail optimization only.
    // The authoritative balance check happens inside processGroupBuyEscrow(),
    // which runs atomically within the ledger's double-entry transaction.
    // This pre-check is NOT relied upon for correctness (no TOCTOU risk).
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
    // Deterministic ID prevents duplicate contributions on client retry
    const contribDocId = getContributionDocId(userId, groupBuyId);
    const contribRef = groupBuyRef.collection("contributions").doc(contribDocId);

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

      // Check duplicate via deterministic doc ID — tolerate retries where escrow failed
      const existingContrib = await tx.get(contribRef);
      let isRetry = false;
      if (existingContrib.exists) {
        const existing = existingContrib.data()!;
        if (existing.journalId && existing.journalId !== "") {
          // Fully completed contribution — true duplicate
          throw new HttpsError("already-exists", "You have already joined this group buy");
        }
        // Contribution exists but escrow wasn't completed — allow retry
        // Don't create new contribution or update counts, just proceed to escrow
        isRetry = true;
      }

      // Calculate target status using transactional read values
      const newAmount = isRetry ? groupBuy.currentAmount : groupBuy.currentAmount + amount;
      const targetMet = newAmount >= groupBuy.targetAmount;

      if (!isRetry) {
        // Write contribution + update group buy atomically within transaction
        tx.set(contribRef, {
          id: contribRef.id,
          userId,
          userName,
          amount,
          journalId: "", // Placeholder — updated after escrow
          walletId: walletId || "primary",
          deliveryAddress: deliveryAddress || null,
          contributedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        const statusUpdate: Record<string, unknown> = {
          currentAmount: admin.firestore.FieldValue.increment(amount),
          participantCount: admin.firestore.FieldValue.increment(1),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        };
        // Only flip status if currently "open" — prevents redundant writes on concurrent joins
        if (groupBuy.status === "open" && targetMet) {
          statusUpdate.status = "targetMet";
        }

        tx.update(groupBuyRef, statusUpdate);
      }

      return { newAmount, targetMet, title: groupBuy.title, isRetry };
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
      // Compensating transaction: delete contribution, decrement counts.
      // Re-read the group buy doc to get CURRENT amounts before deciding whether to revert status.
      logger.error(`Escrow failed for group buy ${groupBuyId}, reverting contribution`, escrowError);
      await db.runTransaction(async (tx) => {
        const freshGroupBuyDoc = await tx.get(groupBuyRef);
        const freshGroupBuy = freshGroupBuyDoc.data();
        tx.delete(contribRef);

        const updateData: Record<string, unknown> = {
          currentAmount: admin.firestore.FieldValue.increment(-amount),
          participantCount: admin.firestore.FieldValue.increment(-1),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        };

        // Only revert status to "open" if after decrementing, currentAmount will be below target
        if (result.targetMet && freshGroupBuy) {
          const currentAmountAfterRevert = (freshGroupBuy.currentAmount || 0) - amount;
          if (currentAmountAfterRevert < (freshGroupBuy.targetAmount || 0)) {
            updateData.status = "open";
          }
        }

        tx.update(groupBuyRef, updateData);
      });
      throw new HttpsError("internal", "Payment processing failed. Please try again.");
    }

    // Update the contribution with the real journal ID
    await contribRef.update({ journalId });

    logger.info(
      `User ${userId} joined group buy ${groupBuyId} with ${amount} tokens. ` +
      `New total: ${result.newAmount}/${result.title}. Target met: ${result.targetMet}`
    );

    // Issue #11: Notify organizer when group buy reaches target
    if (result.targetMet) {
      try {
        const groupBuyDoc = await groupBuyRef.get();
        const groupBuy = groupBuyDoc.data();
        if (groupBuy && groupBuy.organizerId && groupBuy.organizerId !== userId) {
          const organizerDoc = await db.collection("users").doc(groupBuy.organizerId).get();
          const organizerToken = organizerDoc.data()?.fcmToken;
          if (organizerToken) {
            await admin.messaging().send({
              token: organizerToken,
              notification: {
                title: "Group buy target reached!",
                body: `"${result.title}" has reached its target amount. You can now complete the deal.`,
              },
              data: { type: "groupBuyTargetMet", groupBuyId },
            });
          }
        }
        logger.info(`Target-met notification sent for group buy ${groupBuyId}`);
      } catch (notifErr) {
        // Notification failure is non-critical
        logger.warn(`Failed to send target-met notification for group buy ${groupBuyId}`, notifErr);
      }
    }

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
    await requireAppCheck(request, "completeGroupBuy");

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

      // Only organizer can complete — or admins for admin-curated deals
      const isOrganizer = groupBuy.organizerId === userId;
      const isCreatedByAdmin = groupBuy.createdByAdmin === true;
      let isAdmin = false;
      if (!isOrganizer && isCreatedByAdmin) {
        try {
          await requireAdminPermission(request, "buy:forceCompleteGroupBuy", "completeGroupBuy");
          isAdmin = true;
        } catch {
          // Not an admin — fall through to permission denied
        }
      }
      if (!isOrganizer && !isAdmin) {
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
        vendorId: groupBuy.vendorId || null,
        brandId: groupBuy.brandId || null,
        currentAmount: groupBuy.currentAmount,
        title: groupBuy.title,
      };
    });

    // Release escrow outside transaction (ledger has its own idempotency).
    // If release fails, revert status to "targetMet" so it can be retried.
    // Guard: admin-curated deals may have null organizerId — use vendorId/brandId as fallback.
    const escrowRecipientId = txResult.organizerId || txResult.vendorId || txResult.brandId;
    if (!escrowRecipientId) {
      logger.error(`Group buy ${groupBuyId} has no organizerId, vendorId, or brandId — flagging for manual review`);
      await groupBuyRef.update({
        status: "targetMet",
        adminReviewRequired: true,
        adminReviewReason: "No escrow recipient: organizerId, vendorId, and brandId are all null",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      throw new HttpsError("internal", "This group buy requires manual review — no payment recipient found.");
    }

    let releaseJournalId: string;
    try {
      releaseJournalId = await releaseGroupBuyEscrow(
        escrowRecipientId,
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
    await requireAppCheck(request, "leaveGroupBuy");

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

      if (userId === groupBuy.organizerId) {
        throw new HttpsError("failed-precondition", "Organizers cannot leave their own group buy. Use cancel instead.");
      }

      // Prevent leaving when in terminal or cancelling states
      if (["cancelling", "cancelled", "completed"].includes(groupBuy.status)) {
        throw new HttpsError(
          "failed-precondition",
          `Cannot leave a group buy with status: ${groupBuy.status}`
        );
      }

      // Only allow leaving when status is "open"
      if (groupBuy.status !== "open") {
        throw new HttpsError(
          "failed-precondition",
          "Cannot leave a group buy that is no longer open"
        );
      }

      // Find user's contribution via deterministic doc ID (cheaper than query)
      const contribRef = groupBuyRef.collection("contributions").doc(getContributionDocId(userId, groupBuyId));
      const contribDoc = await tx.get(contribRef);

      if (!contribDoc.exists) {
        throw new HttpsError("not-found", "You have not joined this group buy");
      }

      const contrib = contribDoc.data()!;

      // Delete contribution and update group buy atomically
      const groupBuyUpdate: Record<string, unknown> = {
        currentAmount: admin.firestore.FieldValue.increment(-contrib.amount),
        participantCount: admin.firestore.FieldValue.increment(-1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      // R5-3: Decrement collectedCount if the contribution had been collected
      if (contrib.hasCollected === true) {
        groupBuyUpdate.collectedCount = admin.firestore.FieldValue.increment(-1);
      }

      tx.delete(contribRef);
      tx.update(groupBuyRef, groupBuyUpdate);

      return {
        amount: contrib.amount,
        title: groupBuy.title,
        walletId: contrib.walletId || "primary",
        hasCollected: contrib.hasCollected === true,
      };
    });

    // R5-11: Validate the contribution's walletId is still valid before refunding
    let refundWalletId = result.walletId;
    if (refundWalletId && refundWalletId !== "primary") {
      const walletDoc = await getSubAccount(userId, refundWalletId);
      if (!walletDoc) {
        logger.warn(
          `Wallet ${refundWalletId} no longer exists for user ${userId}. ` +
          `Falling back to primary wallet for refund.`
        );
        refundWalletId = "primary";
      }
    }

    // Refund escrow AFTER transaction succeeds (ledger has its own idempotency).
    // If refund fails, run a compensating transaction to re-add the contribution.
    try {
      await refundGroupBuyContribution(
        userId,
        result.amount,
        groupBuyId,
        `User left group buy: ${result.title}`
      );
    } catch (refundError) {
      logger.error(`Refund failed for leaveGroupBuy ${groupBuyId}, reverting removal`, refundError);
      const userDoc = await db.collection("users").doc(userId).get();
      const userName = userDoc.data()?.displayName || "Unknown";
      await db.runTransaction(async (tx) => {
        const contribRef = groupBuyRef.collection("contributions").doc(getContributionDocId(userId, groupBuyId));
        tx.set(contribRef, {
          id: contribRef.id,
          userId,
          userName,
          amount: result.amount,
          journalId: "",
          walletId: result.walletId || "primary",
          contributedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        tx.update(groupBuyRef, {
          currentAmount: admin.firestore.FieldValue.increment(result.amount),
          participantCount: admin.firestore.FieldValue.increment(1),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      });
      throw new HttpsError("internal", "Refund processing failed. Please try again.");
    }

    logger.info(
      `User ${userId} left group buy ${groupBuyId}. ` +
      `Refunded ${result.amount} tokens.`
    );

    // Notify organizer about member leaving (non-critical)
    try {
      const groupBuyDoc = await db.collection("groupBuys").doc(groupBuyId).get();
      const groupBuy = groupBuyDoc.data();
      if (groupBuy && groupBuy.organizerId && groupBuy.organizerId !== userId) {
        const organizerDoc = await db.collection("users").doc(groupBuy.organizerId).get();
        const organizerToken = organizerDoc.data()?.fcmToken;
        if (organizerToken) {
          await admin.messaging().send({
            token: organizerToken,
            notification: {
              title: "Member left group buy",
              body: `A participant has left "${groupBuy.title}"`,
            },
            data: { type: "groupBuyLeave", groupBuyId },
          });
        }
      }
    } catch (e) {
      // Notification failures are non-critical — don't block the response
      logger.warn(`Failed to send leave notification for group buy ${groupBuyId}`, e);
    }

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
    await requireAppCheck(request, "suggestGroupBuyDeal");

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

    const descHash = (brandOrStore || description || "").trim().toLowerCase().replace(/[^a-z0-9]/g, "").substring(0, 20);
    const dateBucket = new Date().toISOString().split("T")[0];
    const requestRef = db.collection("groupBuyRequests").doc(`${userId}_${descHash}_${dateBucket}`);
    const now = admin.firestore.FieldValue.serverTimestamp();

    await requestRef.set({
      id: requestRef.id,
      userId,
      userName,
      description: description.trim(),
      brandOrStore: brandOrStore.trim(),
      estimatedPrice: estimatedPrice ? Math.min(Math.max(0, Math.floor(Number(estimatedPrice))), 10000000) : null,
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

    // R5-10: Limit to 20 per run to prevent timeout on large result sets
    const expiredSnapshot = await db
      .collection("groupBuys")
      .where("status", "in", ["open"])
      .where("deadline", "<=", now)
      .orderBy("deadline")
      .limit(20)
      .get();

    if (expiredSnapshot.empty) {
      logger.info("No expired group buys found");
    } else {
      logger.info(`Found ${expiredSnapshot.size} expired group buys to process`);
    }

    for (const doc of expiredSnapshot.docs) {
      const groupBuy = doc.data();
      const groupBuyId = doc.id;

      try {
        // Load all contributions
        const contribsSnapshot = await doc.ref
          .collection("contributions")
          .limit(500)
          .get();

        // Refund each contributor
        let refundedCount = 0;
        let failedCount = 0;
        for (const contribDoc of contribsSnapshot.docs) {
          const contrib = contribDoc.data();
          if (contrib.status === "refunded") continue; // Skip already refunded
          try {
            await refundGroupBuyContribution(
              contrib.userId,
              contrib.amount,
              groupBuyId,
              `Group buy expired: ${groupBuy.title}`
            );
            // Mark contribution as refunded so subsequent runs skip it
            await contribDoc.ref.update({ status: "refunded" });
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

    // Issue #15: Auto-complete group buys with status "targetMet" past their collectionDeadline
    const pastCollectionDeadline = await db
      .collection("groupBuys")
      .where("status", "==", "targetMet")
      .where("collectionDeadline", "<=", now)
      .limit(20)
      .get();

    if (!pastCollectionDeadline.empty) {
      logger.info(`Found ${pastCollectionDeadline.size} targetMet group buys past collection deadline`);
    }

    for (const doc of pastCollectionDeadline.docs) {
      const groupBuy = doc.data();
      try {
        await doc.ref.update({
          status: "completed",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Release escrowed funds — use organizer, vendorId, or brandId as recipient
        const recipientId = groupBuy.organizerId || groupBuy.vendorId || groupBuy.brandId;
        if (!recipientId) {
          logger.error(`Auto-completed group buy ${doc.id} has no escrow recipient — flagging for manual review`);
          await doc.ref.update({
            status: "targetMet",
            adminReviewRequired: true,
            adminReviewReason: "No escrow recipient: organizerId, vendorId, and brandId are all null",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          continue;
        }

        try {
          await releaseGroupBuyEscrow(
            recipientId,
            groupBuy.currentAmount,
            doc.id,
            `Group buy auto-completed: ${groupBuy.title}`
          );
          logger.info(`Auto-completed group buy ${doc.id} and released escrow (past collection deadline)`);
        } catch (escrowErr) {
          // Revert status so it can be retried
          logger.error(`Escrow release failed for auto-completed group buy ${doc.id}, reverting to targetMet`, escrowErr);
          await doc.ref.update({
            status: "targetMet",
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      } catch (err) {
        logger.error(`Error auto-completing group buy ${doc.id}:`, err);
      }
    }

    // G-6: Auto-cancel stale "targetMet" group buys with no collectionDeadline after 14 days.
    // These users are locked in with no clear resolution path — auto-cancel with refunds.
    const fourteenDaysAgo = admin.firestore.Timestamp.fromMillis(Date.now() - 14 * 24 * 60 * 60 * 1000);
    const staleTargetMetSnapshot = await db
      .collection("groupBuys")
      .where("status", "==", "targetMet")
      .where("updatedAt", "<=", fourteenDaysAgo)
      .limit(20)
      .get();

    // Filter out those with a collectionDeadline (those are handled by the section above)
    const staleWithoutDeadline = staleTargetMetSnapshot.docs.filter((doc) => {
      const data = doc.data();
      return !data.collectionDeadline;
    });

    if (staleWithoutDeadline.length > 0) {
      logger.info(`Found ${staleWithoutDeadline.length} stale targetMet group buys (no collectionDeadline, >14 days) to auto-cancel`);
    }

    for (const doc of staleWithoutDeadline) {
      const groupBuy = doc.data();
      const groupBuyId = doc.id;

      try {
        // Refund all contributions
        const contribsSnapshot = await doc.ref.collection("contributions").limit(500).get();
        let refundedCount = 0;
        let failedCount = 0;

        for (const contribDoc of contribsSnapshot.docs) {
          const contrib = contribDoc.data();
          if (contrib.status === "refunded") continue; // Skip already refunded
          try {
            await refundGroupBuyContribution(
              contrib.userId,
              contrib.amount,
              groupBuyId,
              `Group buy auto-cancelled (stale targetMet): ${groupBuy.title}`
            );
            await contribDoc.ref.update({ status: "refunded" });
            refundedCount++;
          } catch (err) {
            failedCount++;
            logger.error(`Failed to refund ${contrib.userId} for stale group buy ${groupBuyId}:`, err);
          }
        }

        await doc.ref.update({
          status: "cancelled",
          cancelReason: "Auto-cancelled: targetMet for over 14 days with no collection deadline",
          refundedCount,
          failedRefundCount: failedCount,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        logger.info(`Stale targetMet group buy ${groupBuyId} auto-cancelled. Refunded ${refundedCount}, failed ${failedCount}`);
      } catch (err) {
        logger.error(`Error auto-cancelling stale group buy ${groupBuyId}:`, err);
      }
    }

    // Resume incomplete cancellations: "cancelling" group buys still have unrefunded contributions.
    // cancelCommunityGroupBuy processes max 50 per invocation — this picks up the remainder.
    const staleCancellingSnapshot = await db
      .collection("groupBuys")
      .where("status", "==", "cancelling")
      .limit(10)
      .get();

    for (const doc of staleCancellingSnapshot.docs) {
      const groupBuy = doc.data();
      const groupBuyId = doc.id;

      try {
        const contribs = await doc.ref.collection("contributions").limit(50).get();

        if (contribs.empty) {
          // All contributions already refunded and deleted — finalize status
          await doc.ref.update({
            status: "cancelled",
            cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          logger.info(`Finalized cancellation of group buy ${groupBuyId} (no remaining contributions)`);
          continue;
        }

        let refundedCount = 0;
        let failedCount = 0;

        for (const contribDoc of contribs.docs) {
          const contrib = contribDoc.data();
          try {
            await refundGroupBuyContribution(
              contrib.userId,
              contrib.amount,
              groupBuyId,
              `Group buy cancelled: ${groupBuy.title}`
            );
            await contribDoc.ref.delete();
            refundedCount++;
          } catch (err) {
            failedCount++;
            logger.error(`Failed to refund ${contrib.userId} for cancelling group buy ${groupBuyId}`, err);
          }
        }

        // Check if more contributions remain
        const remaining = await doc.ref.collection("contributions").limit(1).get();
        if (remaining.empty) {
          await doc.ref.update({
            status: "cancelled",
            refundedCount: admin.firestore.FieldValue.increment(refundedCount),
            failedRefundCount: admin.firestore.FieldValue.increment(failedCount),
            cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          logger.info(`Completed cancellation of group buy ${groupBuyId}. Refunded ${refundedCount}, failed ${failedCount}`);
        } else {
          await doc.ref.update({
            refundedCount: admin.firestore.FieldValue.increment(refundedCount),
            failedRefundCount: admin.firestore.FieldValue.increment(failedCount),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
          logger.info(`Partial cancellation of group buy ${groupBuyId}: refunded ${refundedCount}, more remain`);
        }
      } catch (err) {
        logger.error(`Error processing cancelling group buy ${groupBuyId}:`, err);
      }
    }
  }
);

// ============================================================================
// CONFIRM COLLECTION (Physical Fulfilment)
// ============================================================================

/**
 * Confirm that a participant has collected their physical item.
 * Can be called by the organizer or the participant themselves.
 */
export const confirmGroupBuyCollection = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    await requireAppCheck(request, "confirmGroupBuyCollection");

    const userId = request.auth.uid;
    const { groupBuyId, contributionId } = request.data;

    if (!groupBuyId || !contributionId) {
      throw new HttpsError("invalid-argument", "groupBuyId and contributionId are required");
    }

    const groupBuyRef = db.collection("groupBuys").doc(groupBuyId);
    const contribRef = groupBuyRef.collection("contributions").doc(contributionId);

    await db.runTransaction(async (tx) => {
      const [groupBuyDoc, contribDoc] = await Promise.all([
        tx.get(groupBuyRef),
        tx.get(contribRef),
      ]);

      if (!groupBuyDoc.exists) {
        throw new HttpsError("not-found", "Group buy not found");
      }
      if (!contribDoc.exists) {
        throw new HttpsError("not-found", "Contribution not found");
      }

      const groupBuy = groupBuyDoc.data()!;
      const contrib = contribDoc.data()!;

      // Verify the caller is the contribution owner or the group buy organizer
      if (contrib.userId !== userId && userId !== groupBuy.organizerId) {
        throw new HttpsError("permission-denied", "Only the contributor or organizer can confirm collection");
      }

      // R5-4/R5-5: Idempotency guard — if already collected, return early
      if (contrib.hasCollected === true) {
        throw new HttpsError("failed-precondition", "Already marked as collected");
      }

      // Only allow collection confirmation when group buy is completed
      if (groupBuy.status !== "completed") {
        throw new HttpsError("failed-precondition", "Group buy must be completed before confirming collection");
      }

      tx.update(contribRef, {
        hasCollected: true,
        collectedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Increment collectedCount on the group buy
      tx.update(groupBuyRef, {
        collectedCount: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    logger.info(`Collection confirmed for contribution ${contributionId} in group buy ${groupBuyId}`);
    return { success: true };
  }
);

// ============================================================================
// CANCEL COMMUNITY GROUP BUY
// ============================================================================

/**
 * Community organizer cancels their own group buy.
 * Refunds all contributions.
 */
export const cancelCommunityGroupBuy = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    await requireAppCheck(request, "cancelCommunityGroupBuy");

    const userId = request.auth.uid;
    const { groupBuyId, reason } = request.data;

    if (!groupBuyId || typeof groupBuyId !== "string") {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }

    const groupBuyRef = db.collection("groupBuys").doc(groupBuyId);

    // Verify ownership and status in transaction
    const groupBuyData = await db.runTransaction(async (tx) => {
      const doc = await tx.get(groupBuyRef);
      if (!doc.exists) {
        throw new HttpsError("not-found", "Group buy not found");
      }
      const data = doc.data()!;

      // Only organizer can cancel — or admins for admin-curated deals
      const isOrganizer = data.organizerId === userId;
      const isCreatedByAdmin = data.createdByAdmin === true;
      let isAdmin = false;
      if (!isOrganizer && isCreatedByAdmin) {
        try {
          await requireAdminPermission(request, "buy:forceCancelGroupBuy", "cancelCommunityGroupBuy");
          isAdmin = true;
        } catch {
          // Not an admin — fall through to permission denied
        }
      }
      if (!isOrganizer && !isAdmin) {
        throw new HttpsError("permission-denied", "Only the organizer can cancel this group buy");
      }
      if (!["open", "targetMet", "cancelling"].includes(data.status)) {
        throw new HttpsError("failed-precondition", `Cannot cancel a group buy with status: ${data.status}`);
      }

      // Only update status/reason if not already cancelling (re-invocation case)
      if (data.status !== "cancelling") {
        tx.update(groupBuyRef, {
          status: "cancelling",
          cancelReason: reason?.trim() || "Cancelled by organizer",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      return data;
    });

    // R5-9: Batch refunds — process max 50 per invocation to avoid timeout.
    const BATCH_LIMIT = 50;
    const contribs = await groupBuyRef.collection("contributions").limit(BATCH_LIMIT + 1).get();
    const hasMore = contribs.size > BATCH_LIMIT;
    const docsToProcess = hasMore ? contribs.docs.slice(0, BATCH_LIMIT) : contribs.docs;

    let refunded = 0;
    let failed = 0;

    for (const contribDoc of docsToProcess) {
      const contrib = contribDoc.data();
      try {
        await refundGroupBuyContribution(
          contrib.userId,
          contrib.amount,
          groupBuyId,
          `Group buy cancelled: ${groupBuyData.title}`
        );
        // Delete the contribution after successful refund so re-invocation skips it
        await contribDoc.ref.delete();
        refunded++;
      } catch (err) {
        failed++;
        logger.error(`Failed to refund ${contrib.userId} for cancelled group buy ${groupBuyId}`, err);
      }
    }

    if (hasMore) {
      // More contributors remain — keep status as "cancelling" for re-invocation
      await groupBuyRef.update({
        refundedCount: admin.firestore.FieldValue.increment(refunded),
        failedRefundCount: admin.firestore.FieldValue.increment(failed),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      logger.info(
        `Group buy ${groupBuyId} partial cancel: processed ${refunded}/${docsToProcess.length}. ` +
        `More contributors remain — re-invoke to continue.`
      );
      return { success: true, partial: true, processed: refunded, failedCount: failed };
    }

    await groupBuyRef.update({
      status: "cancelled",
      refundedCount: admin.firestore.FieldValue.increment(refunded),
      failedRefundCount: admin.firestore.FieldValue.increment(failed),
      cancelledAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    logger.info(`Group buy ${groupBuyId} cancelled by ${userId}. Refunded ${refunded}/${docsToProcess.length}`);
    return { success: true, partial: false, refundedCount: refunded, failedCount: failed };
  }
);

// ============================================================================
// UPDATE DELIVERY STATUS
// ============================================================================

/**
 * Update the delivery status of a group buy (Preparing/Shipped/Delivered).
 * Only organizer or admin can update.
 */
export const updateGroupBuyDeliveryStatus = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    await requireAppCheck(request, "updateGroupBuyDeliveryStatus");

    const userId = request.auth.uid;
    const { groupBuyId, deliveryStatus, trackingInfo } = request.data;

    if (!groupBuyId || typeof groupBuyId !== "string") {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }
    const validStatuses = ["pending", "preparing", "in_transit", "shipped", "delivered"];
    if (!validStatuses.includes(deliveryStatus)) {
      throw new HttpsError("invalid-argument", `deliveryStatus must be one of: ${validStatuses.join(", ")}`);
    }

    // Normalize frontend values to canonical backend values
    const statusMap: Record<string, string> = { pending: "preparing", in_transit: "shipped" };
    const normalizedStatus = statusMap[deliveryStatus] || deliveryStatus;

    const groupBuyRef = db.collection("groupBuys").doc(groupBuyId);

    await db.runTransaction(async (tx) => {
      const groupBuyDoc = await tx.get(groupBuyRef);
      if (!groupBuyDoc.exists) {
        throw new HttpsError("not-found", "Group buy not found");
      }
      const groupBuy = groupBuyDoc.data()!;

      const isOrganizer = groupBuy.organizerId === userId;
      const isCreatedByAdmin = groupBuy.createdByAdmin === true;
      let isAdmin = false;
      if (!isOrganizer && isCreatedByAdmin) {
        try {
          await requireAdminPermission(request, "buy:forceCompleteGroupBuy", "updateGroupBuyDeliveryStatus");
          isAdmin = true;
        } catch {
          // Not an admin — fall through to permission denied
        }
      }
      if (!isOrganizer && !isAdmin) {
        throw new HttpsError("permission-denied", "Only the organizer or admin can update delivery status");
      }

      if (!["completed", "targetMet"].includes(groupBuy.status)) {
        throw new HttpsError("failed-precondition", "Group buy must be completed or target met to update delivery");
      }

      const updates: Record<string, unknown> = {
        deliveryStatus: normalizedStatus,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      if (trackingInfo) {
        updates.trackingInfo = trackingInfo.trim();
      }

      tx.update(groupBuyRef, updates);
    });

    logger.info(`Group buy ${groupBuyId} delivery status updated to ${normalizedStatus} by ${userId}`);
    return { success: true };
  }
);

// ============================================================================
// EXTEND DEADLINE (organizer)
// ============================================================================

/**
 * Extend the deadline of an open group buy.
 * Only the organizer can extend.
 */
export const extendGroupBuyDeadline = onCall(
  { labels: { area: "groupbuys" } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "User must be authenticated");
    }
    await requireAppCheck(request, "extendGroupBuyDeadline");

    const userId = request.auth.uid;
    const { groupBuyId, newDeadline } = request.data;

    if (!groupBuyId || typeof groupBuyId !== "string") {
      throw new HttpsError("invalid-argument", "groupBuyId is required");
    }
    if (!newDeadline || typeof newDeadline !== "string") {
      throw new HttpsError("invalid-argument", "newDeadline is required");
    }

    const newDeadlineDate = new Date(newDeadline);
    if (isNaN(newDeadlineDate.getTime())) {
      throw new HttpsError("invalid-argument", "Invalid date format for newDeadline");
    }
    if (newDeadlineDate.getTime() <= Date.now()) {
      throw new HttpsError("invalid-argument", "New deadline must be in the future");
    }

    const groupBuyRef = db.collection("groupBuys").doc(groupBuyId);

    await db.runTransaction(async (tx) => {
      const groupBuyDoc = await tx.get(groupBuyRef);
      if (!groupBuyDoc.exists) {
        throw new HttpsError("not-found", "Group buy not found");
      }
      const groupBuy = groupBuyDoc.data()!;

      if (groupBuy.organizerId !== userId) {
        throw new HttpsError("permission-denied", "Only the organizer can extend the deadline");
      }

      if (groupBuy.status !== "open") {
        throw new HttpsError(
          "failed-precondition",
          `Cannot extend deadline — status is "${groupBuy.status}"`
        );
      }

      // New deadline must be after the current deadline
      const currentDeadline = groupBuy.deadline?.toDate?.() ?? new Date(groupBuy.deadline);
      if (newDeadlineDate.getTime() <= currentDeadline.getTime()) {
        throw new HttpsError("invalid-argument", "New deadline must be after the current deadline");
      }

      tx.update(groupBuyRef, {
        deadline: admin.firestore.Timestamp.fromDate(newDeadlineDate),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    logger.info(`Group buy ${groupBuyId} deadline extended to ${newDeadline} by organizer ${userId}`);
    return { success: true };
  }
);

// ============================================================================
// SCHEDULED: GROUP BUY REMINDERS
// ============================================================================

/**
 * Send reminders for group buys:
 * - Deals ending in 24 hours
 * - Collection deadlines approaching (1 day away)
 * Runs daily at 9:00 AM SAST.
 */
export const sendGroupBuyReminders = onSchedule(
  {
    schedule: "0 9 * * *",
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "groupbuys" },
  },
  async () => {
    const now = Date.now();
    const in24Hours = admin.firestore.Timestamp.fromMillis(now + 24 * 60 * 60 * 1000);
    const nowTs = admin.firestore.Timestamp.now();

    // 1. Deals ending in 24 hours
    const endingSoon = await db
      .collection("groupBuys")
      .where("status", "==", "open")
      .where("deadline", ">=", nowTs)
      .where("deadline", "<=", in24Hours)
      .get();

    let endingReminders = 0;
    for (const doc of endingSoon.docs) {
      const groupBuy = doc.data();
      const contribs = await doc.ref.collection("contributions").limit(500).get();

      for (const contribDoc of contribs.docs) {
        const contrib = contribDoc.data();
        const userDoc = await db.collection("users").doc(contrib.userId).get();
        const fcmToken = userDoc.data()?.fcmToken;
        if (!fcmToken) continue;

        try {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Group buy ending soon!",
              body: `"${groupBuy.title}" ends in 24 hours. Share with friends to reach the target!`,
            },
            data: {
              type: "group_buy_ending_soon",
              groupBuyId: doc.id,
              screen: "group_buy_detail",
            },
          });
          endingReminders++;
        } catch (err) {
          logger.warn(`Failed to send ending reminder to ${contrib.userId}`, err);
        }
      }
    }

    // 2. Collection deadlines approaching (1 day away)
    const collectionApproaching = await db
      .collection("groupBuys")
      .where("status", "in", ["completed", "targetMet"])
      .where("collectionDeadline", ">=", nowTs)
      .where("collectionDeadline", "<=", in24Hours)
      .get();

    let collectionReminders = 0;
    for (const doc of collectionApproaching.docs) {
      const groupBuy = doc.data();
      const contribs = await doc.ref.collection("contributions").limit(500).get();

      for (const contribDoc of contribs.docs) {
        const contrib = contribDoc.data();
        if (contrib.hasCollected) continue; // Skip already collected

        const userDoc = await db.collection("users").doc(contrib.userId).get();
        const fcmToken = userDoc.data()?.fcmToken;
        if (!fcmToken) continue;

        try {
          await admin.messaging().send({
            token: fcmToken,
            notification: {
              title: "Collection deadline approaching",
              body: `Collect your "${groupBuy.title}" item within 24 hours!`,
            },
            data: {
              type: "group_buy_collection_deadline",
              groupBuyId: doc.id,
              screen: "group_buy_detail",
            },
          });
          collectionReminders++;
        } catch (err) {
          logger.warn(`Failed to send collection reminder to ${contrib.userId}`, err);
        }
      }
    }

    logger.info(`Group buy reminders sent: ${endingReminders} ending soon, ${collectionReminders} collection deadlines`);
  }
);
