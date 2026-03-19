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
import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import { requireAppCheck } from "./security";
import { checkAndCloseExpiredPoll } from "./helpers/pollHelpers";

const db = admin.firestore();

/**
 * Submit a poll vote (first vote).
 *
 * Idempotent: if the user already voted for the same option, returns success
 * without modifying counters. If they voted for a different option, returns
 * ALREADY_VOTED_DIFFERENT so the client can call changePollVote instead.
 */
export const submitPollVote = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    await requireAppCheck(request, "submitPollVote");

    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = request.auth.uid;
    const {
      pollId,
      selectedOption, // Single-select: string
      selectedOptions, // Multi-select: string[]
      otherText, // Free-text for "Other" option
    } = data;

    if (!pollId) {
      throw new HttpsError("invalid-argument", "pollId is required");
    }

    // Validate poll exists and is open
    const pollRef = db.collection("polls").doc(pollId);
    const pollDoc = await pollRef.get();
    if (!pollDoc.exists) {
      throw new HttpsError("not-found", "Poll not found");
    }

    const poll = pollDoc.data()!;

    // Inline-close if expired
    const wasClosed = await checkAndCloseExpiredPoll(pollRef, poll);
    if (wasClosed || poll.status !== "open") {
      throw new HttpsError(
        "failed-precondition",
        wasClosed ? "This poll has expired" : "Poll is not open for voting"
      );
    }

    const validOptionIds = (poll.options as { id: string; text: string }[]).map(
      (o) => o.id
    );

    // Determine effective selections based on multi-select mode
    const isMultiSelect = poll.allowMultipleSelections === true;
    let effectiveSelections: string[];

    if (isMultiSelect) {
      effectiveSelections = selectedOptions as string[] || [];
      if (!effectiveSelections.length) {
        throw new HttpsError("invalid-argument", "selectedOptions is required for multi-select polls");
      }
      // Validate maxSelections
      if (poll.maxSelections && effectiveSelections.length > poll.maxSelections) {
        throw new HttpsError("invalid-argument", `Cannot select more than ${poll.maxSelections} options`);
      }
    } else {
      if (!selectedOption) {
        throw new HttpsError("invalid-argument", "selectedOption is required");
      }
      effectiveSelections = [selectedOption];
    }

    // Validate all selected options are valid IDs (allow 'other' if enabled)
    const allowOther = poll.allowOtherOption === true;
    for (const optId of effectiveSelections) {
      if (optId === "other") {
        if (!allowOther) {
          throw new HttpsError("invalid-argument", "'Other' option is not enabled for this poll");
        }
        continue;
      }
      if (!validOptionIds.includes(optId)) {
        throw new HttpsError("invalid-argument", `Invalid option: ${optId}`);
      }
    }

    // Validate otherText
    if (effectiveSelections.includes("other")) {
      if (!otherText || typeof otherText !== "string" || otherText.trim().length === 0) {
        throw new HttpsError("invalid-argument", "otherText is required when 'Other' is selected");
      }
      if (otherText.length > 200) {
        throw new HttpsError("invalid-argument", "otherText must be 200 characters or less");
      }
    }

    // For single-select backward compat, primary option is first selection
    const primaryOption = effectiveSelections[0];

    // Check for existing response (idempotency check)
    const responseRef = pollRef.collection("responses").doc(userId);
    const existingResponse = await responseRef.get();

    if (existingResponse.exists) {
      const existing = existingResponse.data()!;
      if (existing.status === "valid") {
        // Check if exact same selections — idempotent
        const existingSelections: string[] = existing.selectedOptions || [existing.selectedOption];
        const sameSelections = effectiveSelections.length === existingSelections.length &&
          effectiveSelections.every((s) => existingSelections.includes(s));
        if (sameSelections) {
          return { success: true, alreadyVoted: true, tokensEarned: 0 };
        }
        // Different selections — client must use changePollVote
        throw new HttpsError("already-exists", "ALREADY_VOTED_DIFFERENT");
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
      logger.warn("Failed to fetch user demographics for poll:", e);
    }

    // Atomic transaction: increment counters + create response
    await db.runTransaction(async (tx) => {
      // Re-read poll inside transaction for consistency
      const pollInTx = await tx.get(pollRef);
      if (!pollInTx.exists || pollInTx.data()!.status !== "open") {
        throw new HttpsError(
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

      // Increment counters — one respondent, but increment each selected option
      const counterUpdates: Record<string, unknown> = {
        totalRespondents: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      for (const optId of effectiveSelections) {
        if (optId !== "other") {
          counterUpdates[`optionCounts.${optId}`] = admin.firestore.FieldValue.increment(1);
        }
      }
      tx.update(pollRef, counterUpdates);

      // Create response document (keyed by userId)
      tx.set(responseRef, {
        userId,
        pollId,
        selectedOption: primaryOption,
        selectedOptions: effectiveSelections,
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
        otherText: effectiveSelections.includes("other") ? otherText?.trim() : null,
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
export const changePollVote = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    await requireAppCheck(request, "changePollVote");

    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = request.auth.uid;
    const {
      pollId,
      newOption, // Single-select: string
      newOptions, // Multi-select: string[]
      otherText,
    } = data;

    if (!pollId) {
      throw new HttpsError("invalid-argument", "pollId is required");
    }

    // Validate poll
    const pollRef = db.collection("polls").doc(pollId);
    const pollDoc = await pollRef.get();
    if (!pollDoc.exists) {
      throw new HttpsError("not-found", "Poll not found");
    }

    const poll = pollDoc.data()!;
    if (poll.status !== "open") {
      throw new HttpsError("failed-precondition", "Poll is not open for voting");
    }
    if (!poll.allowChangeVote) {
      throw new HttpsError("failed-precondition", "Vote changes are not allowed for this poll");
    }

    const validOptionIds = (poll.options as { id: string; text: string }[]).map((o) => o.id);
    const isMultiSelect = poll.allowMultipleSelections === true;
    const allowOther = poll.allowOtherOption === true;

    let effectiveNew: string[];
    if (isMultiSelect) {
      effectiveNew = newOptions as string[] || [];
      if (!effectiveNew.length) {
        throw new HttpsError("invalid-argument", "newOptions is required for multi-select polls");
      }
      if (poll.maxSelections && effectiveNew.length > poll.maxSelections) {
        throw new HttpsError("invalid-argument", `Cannot select more than ${poll.maxSelections} options`);
      }
    } else {
      if (!newOption) {
        throw new HttpsError("invalid-argument", "newOption is required");
      }
      effectiveNew = [newOption];
    }

    for (const optId of effectiveNew) {
      if (optId === "other") {
        if (!allowOther) throw new HttpsError("invalid-argument", "'Other' option is not enabled");
        continue;
      }
      if (!validOptionIds.includes(optId)) {
        throw new HttpsError("invalid-argument", `Invalid option: ${optId}`);
      }
    }

    if (effectiveNew.includes("other")) {
      if (!otherText || typeof otherText !== "string" || otherText.trim().length === 0) {
        throw new HttpsError("invalid-argument", "otherText is required when 'Other' is selected");
      }
      if (otherText.length > 200) {
        throw new HttpsError("invalid-argument", "otherText must be 200 characters or less");
      }
    }

    const responseRef = pollRef.collection("responses").doc(userId);

    await db.runTransaction(async (tx) => {
      const responseDoc = await tx.get(responseRef);
      if (!responseDoc.exists || responseDoc.data()!.status !== "valid") {
        throw new HttpsError("failed-precondition", "No valid vote to change");
      }

      const response = responseDoc.data()!;
      const oldSelections: string[] = response.selectedOptions || [response.selectedOption];

      // Check if selections are the same (idempotent)
      const sameSelections = effectiveNew.length === oldSelections.length &&
        effectiveNew.every((s) => oldSelections.includes(s));
      if (sameSelections) return;

      // Decrement old options, increment new options
      // totalRespondents stays the same
      const counterUpdates: Record<string, unknown> = {
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      for (const optId of oldSelections) {
        if (optId !== "other") {
          counterUpdates[`optionCounts.${optId}`] = admin.firestore.FieldValue.increment(-1);
        }
      }
      for (const optId of effectiveNew) {
        if (optId !== "other") {
          // If key already exists from decrement, net it out
          const key = `optionCounts.${optId}`;
          if (counterUpdates[key]) {
            // Was decremented, now incrementing — cancel out (net 0)
            delete counterUpdates[key];
          } else {
            counterUpdates[key] = admin.firestore.FieldValue.increment(1);
          }
        }
      }
      tx.update(pollRef, counterUpdates);

      // Update response
      tx.update(responseRef, {
        selectedOption: effectiveNew[0],
        selectedOptions: effectiveNew,
        previousOption: oldSelections[0],
        voteCount: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        otherText: effectiveNew.includes("other") ? otherText?.trim() : null,
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
export const getPollResults = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    await requireAppCheck(request, "getPollResults");

    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }

    const userId = request.auth.uid;
    const { pollId } = data;

    if (!pollId) {
      throw new HttpsError(
        "invalid-argument",
        "pollId is required"
      );
    }

    const pollRef = db.collection("polls").doc(pollId);
    const pollDoc = await pollRef.get();
    if (!pollDoc.exists) {
      throw new HttpsError("not-found", "Poll not found");
    }

    const poll = pollDoc.data()!;

    // Inline-close if expired (updates Firestore, but we continue to show results)
    await checkAndCloseExpiredPoll(pollRef, poll);

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
      request.auth.token.admin === true ||
      request.auth.token.superAdmin === true;

    const resultVisibility = poll.resultVisibility || "immediate";
    let canSeeResults = isAdmin ||
      poll.status === "closed" ||
      poll.status === "archived";

    if (!canSeeResults && hasVoted) {
      switch (resultVisibility) {
        case "immediate":
          canSeeResults = true;
          break;
        case "afterClose":
          canSeeResults = false; // Only after close (handled above)
          break;
        case "afterThreshold":
          canSeeResults = (poll.totalRespondents || 0) >= (poll.minResponsesForResults || 0);
          break;
        default:
          // Legacy fallback: use showResultsAfterVote boolean
          canSeeResults = poll.showResultsAfterVote === true;
      }
    }

    const totalRespondents = poll.totalRespondents || 0;
    const optionCounts = (poll.optionCounts || {}) as Record<string, number>;

    // Calculate percentages
    const percentages: Record<string, number> = {};
    if (canSeeResults && totalRespondents > 0) {
      for (const [optId, count] of Object.entries(optionCounts)) {
        percentages[optId] = Math.round((count / totalRespondents) * 100);
      }
    }

    // Get user's full response for multi-select
    const userSelections: string[] = hasVoted
      ? (responseDoc.data()!.selectedOptions || [responseDoc.data()!.selectedOption])
      : [];
    const userOtherText: string | null = hasVoted
      ? (responseDoc.data()!.otherText || null)
      : null;

    return {
      pollId,
      question: poll.question,
      options: poll.options,
      status: poll.status,
      hasVoted,
      userVote,
      userSelections,
      userOtherText,
      allowChangeVote: poll.allowChangeVote || false,
      allowMultipleSelections: poll.allowMultipleSelections || false,
      maxSelections: poll.maxSelections || null,
      allowOtherOption: poll.allowOtherOption || false,
      resultVisibility,
      closesAt: poll.closesAt?.toDate?.()?.toISOString() || null,
      minResponsesForResults: poll.minResponsesForResults || null,
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
export const invalidatePollResponse = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    // Admin-only
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }
    const token = request.auth.token;
    if (!token.admin && !token.superAdmin) {
      throw new HttpsError(
        "permission-denied",
        "Admin access required"
      );
    }

    const { pollId, userId, reason } = data;
    if (!pollId || !userId) {
      throw new HttpsError(
        "invalid-argument",
        "pollId and userId are required"
      );
    }

    const pollRef = db.collection("polls").doc(pollId);
    const responseRef = pollRef.collection("responses").doc(userId);

    await db.runTransaction(async (tx) => {
      const responseDoc = await tx.get(responseRef);
      if (!responseDoc.exists) {
        throw new HttpsError(
          "not-found",
          "Response not found"
        );
      }

      const response = responseDoc.data()!;
      if (response.status === "invalidated") {
        throw new HttpsError(
          "failed-precondition",
          "Response already invalidated"
        );
      }

      // Decrement counters for all selected options
      const selections: string[] = response.selectedOptions || [response.selectedOption];
      const counterUpdates: Record<string, unknown> = {
        totalRespondents: admin.firestore.FieldValue.increment(-1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      for (const optId of selections) {
        if (optId !== "other") {
          counterUpdates[`optionCounts.${optId}`] = admin.firestore.FieldValue.increment(-1);
        }
      }
      tx.update(pollRef, counterUpdates);

      // Mark response as invalidated (keep for audit trail)
      tx.update(responseRef, {
        status: "invalidated",
        invalidatedAt: admin.firestore.FieldValue.serverTimestamp(),
        invalidatedBy: request.auth!.uid,
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
