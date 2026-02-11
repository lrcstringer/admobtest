/**
 * Poll Cloud Functions
 *
 * Handles poll voting with atomic counters, idempotent submissions,
 * vote changes, and fraud rollback.
 *
 * Polls are first-class entities in `polls/{pollId}` with aggregated
 * counters. Responses are stored in `polls/{pollId}/responses/{userId}`.
 */

import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Submit a poll vote (first vote).
 *
 * Idempotent: if the user already voted for the same option, returns success
 * without modifying counters. If they voted for a different option, returns
 * ALREADY_VOTED_DIFFERENT so the client can call changePollVote instead.
 */
export const submitPollVote = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "submitPollVote");

    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const { pollId, selectedOption } = data;

    if (!pollId || !selectedOption) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "pollId and selectedOption are required"
      );
    }

    // Validate poll exists and is open
    const pollRef = db.collection("polls").doc(pollId);
    const pollDoc = await pollRef.get();
    if (!pollDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Poll not found");
    }

    const poll = pollDoc.data()!;
    if (poll.status !== "open") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Poll is not open for voting"
      );
    }

    // Validate selectedOption is a valid option ID
    const validOptionIds = (poll.options as { id: string; text: string }[]).map(
      (o) => o.id
    );
    if (!validOptionIds.includes(selectedOption)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Invalid option: ${selectedOption}`
      );
    }

    // Check for existing response (idempotency check)
    const responseRef = pollRef.collection("responses").doc(userId);
    const existingResponse = await responseRef.get();

    if (existingResponse.exists) {
      const existing = existingResponse.data()!;
      if (existing.status === "valid") {
        if (existing.selectedOption === selectedOption) {
          // Exact same vote — idempotent, return success without counter change
          return { success: true, alreadyVoted: true, tokensEarned: 0 };
        }
        // Different option — client must use changePollVote
        throw new functions.https.HttpsError(
          "already-exists",
          "ALREADY_VOTED_DIFFERENT"
        );
      }
      // If status === "invalidated", allow re-vote as if new (fall through)
    }

    // Get user demographics for segmented analytics
    let demographics: Record<string, string | null> | null = null;
    try {
      const userDoc = await db.collection("users").doc(userId).get();
      if (userDoc.exists) {
        const userData = userDoc.data()!;
        demographics = {
          province: userData.province || null,
          gender: userData.gender || null,
          ageGroup: calculateAgeGroup(userData.dateOfBirth),
        };
      }
    } catch (e) {
      console.warn("Failed to fetch user demographics for poll:", e);
    }

    // Atomic transaction: increment counters + create response
    await db.runTransaction(async (tx) => {
      // Re-read poll inside transaction for consistency
      const pollInTx = await tx.get(pollRef);
      if (!pollInTx.exists || pollInTx.data()!.status !== "open") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Poll is no longer open"
        );
      }

      // Re-check response inside transaction
      const responseInTx = await tx.get(responseRef);
      if (
        responseInTx.exists &&
        responseInTx.data()!.status === "valid"
      ) {
        // Race condition: another request already voted
        return;
      }

      // Increment counters
      tx.update(pollRef, {
        totalRespondents: admin.firestore.FieldValue.increment(1),
        [`optionCounts.${selectedOption}`]:
          admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Create response document (keyed by userId)
      tx.set(responseRef, {
        userId,
        pollId,
        selectedOption,
        previousOption: null,
        voteCount: 1,
        respondedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        status: "valid",
        invalidatedAt: null,
        invalidatedBy: null,
        invalidationReason: null,
        engagementId: null,
        tokensAwarded: false,
        demographics,
      });
    });

    return { success: true, alreadyVoted: false };
  }
);

/**
 * Change an existing poll vote.
 *
 * Atomically decrements the old option counter and increments the new one.
 * totalRespondents stays unchanged (user is still one respondent).
 * No additional tokens are awarded for vote changes.
 */
export const changePollVote = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "changePollVote");

    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const { pollId, newOption } = data;

    if (!pollId || !newOption) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "pollId and newOption are required"
      );
    }

    // Validate poll
    const pollRef = db.collection("polls").doc(pollId);
    const pollDoc = await pollRef.get();
    if (!pollDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Poll not found");
    }

    const poll = pollDoc.data()!;
    if (poll.status !== "open") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Poll is not open for voting"
      );
    }
    if (!poll.allowChangeVote) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Vote changes are not allowed for this poll"
      );
    }

    // Validate new option
    const validOptionIds = (poll.options as { id: string; text: string }[]).map(
      (o) => o.id
    );
    if (!validOptionIds.includes(newOption)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Invalid option: ${newOption}`
      );
    }

    const responseRef = pollRef.collection("responses").doc(userId);

    await db.runTransaction(async (tx) => {
      const responseDoc = await tx.get(responseRef);
      if (!responseDoc.exists || responseDoc.data()!.status !== "valid") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "No valid vote to change"
        );
      }

      const response = responseDoc.data()!;
      const oldOption = response.selectedOption;

      if (oldOption === newOption) {
        return; // No change needed — idempotent
      }

      // Decrement old option, increment new option
      // totalRespondents stays the same
      tx.update(pollRef, {
        [`optionCounts.${oldOption}`]:
          admin.firestore.FieldValue.increment(-1),
        [`optionCounts.${newOption}`]:
          admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Update response
      tx.update(responseRef, {
        selectedOption: newOption,
        previousOption: oldOption,
        voteCount: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return { success: true, tokensEarned: 0 };
  }
);

/**
 * Get poll results.
 *
 * Results are visible if: poll is closed/archived, OR showResultsAfterVote
 * is true and user has voted, OR caller is admin.
 */
export const getPollResults = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "getPollResults");

    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const { pollId } = data;

    if (!pollId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "pollId is required"
      );
    }

    const pollRef = db.collection("polls").doc(pollId);
    const pollDoc = await pollRef.get();
    if (!pollDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Poll not found");
    }

    const poll = pollDoc.data()!;

    // Check if user has voted
    const responseDoc = await pollRef
      .collection("responses")
      .doc(userId)
      .get();
    const hasVoted =
      responseDoc.exists && responseDoc.data()!.status === "valid";
    const userVote = hasVoted ? responseDoc.data()!.selectedOption : null;

    // Determine if results should be visible
    const isAdmin =
      context.auth.token.admin === true ||
      context.auth.token.superAdmin === true;
    const canSeeResults =
      isAdmin ||
      poll.status === "closed" ||
      poll.status === "archived" ||
      (poll.showResultsAfterVote && hasVoted);

    const totalRespondents = poll.totalRespondents || 0;
    const optionCounts = (poll.optionCounts || {}) as Record<string, number>;

    // Calculate percentages
    const percentages: Record<string, number> = {};
    if (canSeeResults && totalRespondents > 0) {
      for (const [optId, count] of Object.entries(optionCounts)) {
        percentages[optId] = Math.round((count / totalRespondents) * 100);
      }
    }

    return {
      pollId,
      question: poll.question,
      options: poll.options,
      status: poll.status,
      hasVoted,
      userVote,
      allowChangeVote: poll.allowChangeVote || false,
      results: canSeeResults
        ? { totalRespondents, optionCounts, percentages }
        : null,
    };
  }
);

/**
 * Invalidate a poll response (admin fraud rollback).
 *
 * Decrements counters and marks the response as invalidated.
 * Keeps the document for audit trail.
 */
export const invalidatePollResponse = functions.https.onCall(
  async (data, context) => {
    // Admin-only
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }
    const token = context.auth.token;
    if (!token.admin && !token.superAdmin) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Admin access required"
      );
    }

    const { pollId, userId, reason } = data;
    if (!pollId || !userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "pollId and userId are required"
      );
    }

    const pollRef = db.collection("polls").doc(pollId);
    const responseRef = pollRef.collection("responses").doc(userId);

    await db.runTransaction(async (tx) => {
      const responseDoc = await tx.get(responseRef);
      if (!responseDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Response not found"
        );
      }

      const response = responseDoc.data()!;
      if (response.status === "invalidated") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Response already invalidated"
        );
      }

      const selectedOption = response.selectedOption;

      // Decrement counters
      tx.update(pollRef, {
        totalRespondents: admin.firestore.FieldValue.increment(-1),
        [`optionCounts.${selectedOption}`]:
          admin.firestore.FieldValue.increment(-1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Mark response as invalidated (keep for audit trail)
      tx.update(responseRef, {
        status: "invalidated",
        invalidatedAt: admin.firestore.FieldValue.serverTimestamp(),
        invalidatedBy: context.auth!.uid,
        invalidationReason: reason || "Fraud",
      });
    });

    return { success: true };
  }
);

/**
 * Helper: calculate age group from date of birth
 */
function calculateAgeGroup(
  dateOfBirth: string | { toDate: () => Date } | null | undefined
): string | null {
  if (!dateOfBirth) return null;

  let dob: Date;
  if (typeof dateOfBirth === "string") {
    dob = new Date(dateOfBirth);
  } else if (typeof dateOfBirth === "object" && "toDate" in dateOfBirth) {
    dob = dateOfBirth.toDate();
  } else {
    return null;
  }

  const now = new Date();
  let age = now.getFullYear() - dob.getFullYear();
  const monthDiff = now.getMonth() - dob.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && now.getDate() < dob.getDate())) {
    age--;
  }

  if (age < 18) return "under_18";
  if (age <= 24) return "18-24";
  if (age <= 34) return "25-34";
  if (age <= 44) return "35-44";
  if (age <= 54) return "45-54";
  return "55+";
}
