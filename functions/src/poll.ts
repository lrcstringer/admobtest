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

    const questionType = poll.questionType || "multipleChoice";
    const validOptionIds = (poll.options as { id: string; text: string }[]).map(
      (o) => o.id
    );

    // ===== Type-specific validation =====
    let effectiveSelections: string[] = [];
    let rankedOptions: string[] = [];
    let textResponse: string | null = null;
    let scaleRatings: Record<string, number> = {};

    switch (questionType) {
      case "multipleChoice": {
        const isMultiSelect = poll.allowMultipleSelections === true;
        if (isMultiSelect) {
          effectiveSelections = selectedOptions as string[] || [];
          if (!effectiveSelections.length) {
            throw new HttpsError("invalid-argument", "selectedOptions is required for multi-select polls");
          }
          if (poll.maxSelections && effectiveSelections.length > poll.maxSelections) {
            throw new HttpsError("invalid-argument", `Cannot select more than ${poll.maxSelections} options`);
          }
        } else {
          if (!selectedOption) {
            throw new HttpsError("invalid-argument", "selectedOption is required");
          }
          effectiveSelections = [selectedOption];
        }

        // Validate option IDs (allow 'other' if enabled)
        const allowOther = poll.allowOtherOption === true;
        for (const optId of effectiveSelections) {
          if (optId === "other") {
            if (!allowOther) throw new HttpsError("invalid-argument", "'Other' option is not enabled for this poll");
            continue;
          }
          if (!validOptionIds.includes(optId)) throw new HttpsError("invalid-argument", `Invalid option: ${optId}`);
        }

        // Validate otherText
        if (effectiveSelections.includes("other")) {
          if (!otherText || typeof otherText !== "string" || otherText.trim().length === 0) {
            throw new HttpsError("invalid-argument", "otherText is required when 'Other' is selected");
          }
          if (otherText.length > 200) throw new HttpsError("invalid-argument", "otherText must be 200 characters or less");
        }
        break;
      }

      case "ranking": {
        rankedOptions = data.rankedOptions as string[] || [];
        if (!rankedOptions.length || rankedOptions.length !== validOptionIds.length) {
          throw new HttpsError("invalid-argument", `Must rank all ${validOptionIds.length} options`);
        }
        // Every option must appear exactly once
        const sortedRanked = [...rankedOptions].sort();
        const sortedValid = [...validOptionIds].sort();
        if (sortedRanked.join(",") !== sortedValid.join(",")) {
          throw new HttpsError("invalid-argument", "Ranked options must contain exactly the poll's options");
        }
        break;
      }

      case "text": {
        textResponse = data.textResponse as string | null;
        if (!textResponse || typeof textResponse !== "string" || textResponse.trim().length === 0) {
          throw new HttpsError("invalid-argument", "textResponse is required");
        }
        const minLen = poll.textMinLength || 1;
        const maxLen = poll.textMaxLength || 500;
        if (textResponse.trim().length < minLen) {
          throw new HttpsError("invalid-argument", `Response must be at least ${minLen} characters`);
        }
        if (textResponse.trim().length > maxLen) {
          throw new HttpsError("invalid-argument", `Response must be ${maxLen} characters or less`);
        }
        textResponse = textResponse.trim();
        break;
      }

      case "scale": {
        scaleRatings = data.scaleRatings as Record<string, number> || {};
        const sMin = poll.scaleMin || 1;
        const sMax = poll.scaleMax || 10;

        // Must rate every option
        for (const optId of validOptionIds) {
          if (scaleRatings[optId] === undefined || scaleRatings[optId] === null) {
            throw new HttpsError("invalid-argument", `Rating required for option ${optId}`);
          }
          const val = scaleRatings[optId];
          if (typeof val !== "number" || !Number.isInteger(val) || val < sMin || val > sMax) {
            throw new HttpsError("invalid-argument", `Rating for ${optId} must be an integer between ${sMin} and ${sMax}`);
          }
        }
        // No extra keys
        for (const key of Object.keys(scaleRatings)) {
          if (!validOptionIds.includes(key)) {
            throw new HttpsError("invalid-argument", `Unknown option: ${key}`);
          }
        }
        break;
      }

      default:
        throw new HttpsError("invalid-argument", `Unsupported questionType: ${questionType}`);
    }

    // For single-select backward compat, primary option is first selection
    const primaryOption = effectiveSelections.length > 0 ? effectiveSelections[0] : "";

    // Check for existing response (idempotency check)
    const responseRef = pollRef.collection("responses").doc(userId);
    const existingResponse = await responseRef.get();

    if (existingResponse.exists) {
      const existing = existingResponse.data()!;
      if (existing.status === "valid") {
        // Idempotency check based on question type
        let isSame = false;
        switch (questionType) {
          case "multipleChoice": {
            const existingSel: string[] = existing.selectedOptions || [existing.selectedOption];
            isSame = effectiveSelections.length === existingSel.length &&
              effectiveSelections.every((s) => existingSel.includes(s));
            break;
          }
          case "ranking": {
            const existingRanked: string[] = existing.rankedOptions || [];
            isSame = rankedOptions.length === existingRanked.length &&
              rankedOptions.every((s, i) => existingRanked[i] === s);
            break;
          }
          case "text":
            isSame = existing.textResponse === textResponse;
            break;
          case "scale": {
            const existingRatings: Record<string, number> = existing.scaleRatings || {};
            isSame = Object.keys(scaleRatings).length === Object.keys(existingRatings).length &&
              Object.entries(scaleRatings).every(([k, v]) => existingRatings[k] === v);
            break;
          }
        }
        if (isSame) {
          return { success: true, alreadyVoted: true, tokensEarned: 0 };
        }
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
      const pollInTx = await tx.get(pollRef);
      if (!pollInTx.exists || pollInTx.data()!.status !== "open") {
        throw new HttpsError("failed-precondition", "Poll is no longer open");
      }

      const responseInTx = await tx.get(responseRef);
      if (responseInTx.exists && responseInTx.data()!.status === "valid") {
        return; // Race condition: another request already voted
      }

      // Build counter updates based on question type
      const counterUpdates: Record<string, unknown> = {
        totalRespondents: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      switch (questionType) {
        case "multipleChoice":
          for (const optId of effectiveSelections) {
            if (optId !== "other") {
              counterUpdates[`optionCounts.${optId}`] = admin.firestore.FieldValue.increment(1);
            }
          }
          break;

        case "ranking": {
          // Maintain a running average rank for each option so getPollResults
          // can return materialized averages without reading all response docs.
          // Formula: new_avg = ((old_avg * (n-1)) + rank) / n  (1-based rank)
          // n is the NEW totalRespondents (after increment above).
          // We rely on the poll doc read at the top of the transaction for
          // the current averageRanks map; initialise missing entries to 0.
          const currentAverageRanks =
            (pollInTx.data()!.averageRanks || {}) as Record<string, number>;
          const currentTotal = (pollInTx.data()!.totalRespondents || 0); // before increment
          const newTotal = currentTotal + 1;
          for (let i = 0; i < rankedOptions.length; i++) {
            const optId = rankedOptions[i];
            const rank = i + 1; // 1-based
            const oldAvg = currentAverageRanks[optId] || 0;
            const newAvg = ((oldAvg * currentTotal) + rank) / newTotal;
            counterUpdates[`averageRanks.${optId}`] = Math.round(newAvg * 100) / 100;
          }
          break;
        }

        case "text":
          // No counters to update for text — just respondent count
          break;

        case "scale":
          // Update rating distribution atomically
          for (const [optId, rating] of Object.entries(scaleRatings)) {
            counterUpdates[`ratingDistribution.${optId}.${rating}`] = admin.firestore.FieldValue.increment(1);
          }
          break;
      }

      tx.update(pollRef, counterUpdates);

      // Create response document with type-specific fields
      tx.set(responseRef, {
        userId,
        pollId,
        // multipleChoice fields (backward compat)
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
        // Ranking fields
        rankedOptions: rankedOptions.length > 0 ? rankedOptions : null,
        // Text fields
        textResponse: textResponse || null,
        // Scale fields
        scaleRatings: Object.keys(scaleRatings).length > 0 ? scaleRatings : null,
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

    const questionType = poll.questionType || "multipleChoice";
    const validOptionIds = (poll.options as { id: string; text: string }[]).map((o) => o.id);

    // ===== Type-specific validation for new vote =====
    let effectiveNew: string[] = [];
    let newRankedOptions: string[] = [];
    let newTextResponse: string | null = null;
    let newScaleRatings: Record<string, number> = {};

    switch (questionType) {
      case "multipleChoice": {
        const isMultiSelect = poll.allowMultipleSelections === true;
        const allowOther = poll.allowOtherOption === true;
        if (isMultiSelect) {
          effectiveNew = newOptions as string[] || [];
          if (!effectiveNew.length) throw new HttpsError("invalid-argument", "newOptions is required for multi-select polls");
          if (poll.maxSelections && effectiveNew.length > poll.maxSelections) {
            throw new HttpsError("invalid-argument", `Cannot select more than ${poll.maxSelections} options`);
          }
        } else {
          if (!newOption) throw new HttpsError("invalid-argument", "newOption is required");
          effectiveNew = [newOption];
        }
        for (const optId of effectiveNew) {
          if (optId === "other") {
            if (!allowOther) throw new HttpsError("invalid-argument", "'Other' option is not enabled");
            continue;
          }
          if (!validOptionIds.includes(optId)) throw new HttpsError("invalid-argument", `Invalid option: ${optId}`);
        }
        if (effectiveNew.includes("other")) {
          if (!otherText || typeof otherText !== "string" || otherText.trim().length === 0) {
            throw new HttpsError("invalid-argument", "otherText is required when 'Other' is selected");
          }
          if (otherText.length > 200) throw new HttpsError("invalid-argument", "otherText must be 200 characters or less");
        }
        break;
      }

      case "ranking": {
        newRankedOptions = data.rankedOptions as string[] || [];
        if (!newRankedOptions.length || newRankedOptions.length !== validOptionIds.length) {
          throw new HttpsError("invalid-argument", `Must rank all ${validOptionIds.length} options`);
        }
        const sortedNew = [...newRankedOptions].sort();
        const sortedValid = [...validOptionIds].sort();
        if (sortedNew.join(",") !== sortedValid.join(",")) {
          throw new HttpsError("invalid-argument", "Ranked options must contain exactly the poll's options");
        }
        break;
      }

      case "text": {
        newTextResponse = data.textResponse as string | null;
        if (!newTextResponse || typeof newTextResponse !== "string" || newTextResponse.trim().length === 0) {
          throw new HttpsError("invalid-argument", "textResponse is required");
        }
        const minLen = poll.textMinLength || 1;
        const maxLen = poll.textMaxLength || 500;
        if (newTextResponse.trim().length < minLen) throw new HttpsError("invalid-argument", `Response must be at least ${minLen} characters`);
        if (newTextResponse.trim().length > maxLen) throw new HttpsError("invalid-argument", `Response must be ${maxLen} characters or less`);
        newTextResponse = newTextResponse.trim();
        break;
      }

      case "scale": {
        newScaleRatings = data.scaleRatings as Record<string, number> || {};
        const sMin = poll.scaleMin || 1;
        const sMax = poll.scaleMax || 10;
        for (const optId of validOptionIds) {
          if (newScaleRatings[optId] === undefined || newScaleRatings[optId] === null) {
            throw new HttpsError("invalid-argument", `Rating required for option ${optId}`);
          }
          const val = newScaleRatings[optId];
          if (typeof val !== "number" || !Number.isInteger(val) || val < sMin || val > sMax) {
            throw new HttpsError("invalid-argument", `Rating for ${optId} must be an integer between ${sMin} and ${sMax}`);
          }
        }
        break;
      }

      default:
        throw new HttpsError("invalid-argument", `Unsupported questionType: ${questionType}`);
    }

    const responseRef = pollRef.collection("responses").doc(userId);

    await db.runTransaction(async (tx) => {
      const responseDoc = await tx.get(responseRef);
      if (!responseDoc.exists || responseDoc.data()!.status !== "valid") {
        throw new HttpsError("failed-precondition", "No valid vote to change");
      }

      const response = responseDoc.data()!;

      // Idempotency check
      let isSame = false;
      switch (questionType) {
        case "multipleChoice": {
          const oldSel: string[] = response.selectedOptions || [response.selectedOption];
          isSame = effectiveNew.length === oldSel.length && effectiveNew.every((s) => oldSel.includes(s));
          break;
        }
        case "ranking": {
          const oldRanked: string[] = response.rankedOptions || [];
          isSame = newRankedOptions.every((s, i) => oldRanked[i] === s);
          break;
        }
        case "text":
          isSame = response.textResponse === newTextResponse;
          break;
        case "scale": {
          const oldRatings: Record<string, number> = response.scaleRatings || {};
          isSame = Object.entries(newScaleRatings).every(([k, v]) => oldRatings[k] === v);
          break;
        }
      }
      if (isSame) return;

      // Build counter updates — totalRespondents stays the same
      const counterUpdates: Record<string, unknown> = {
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      switch (questionType) {
        case "multipleChoice": {
          const oldSelections: string[] = response.selectedOptions || [response.selectedOption];
          for (const optId of oldSelections) {
            if (optId !== "other") counterUpdates[`optionCounts.${optId}`] = admin.firestore.FieldValue.increment(-1);
          }
          for (const optId of effectiveNew) {
            if (optId !== "other") {
              const key = `optionCounts.${optId}`;
              if (counterUpdates[key]) { delete counterUpdates[key]; }
              else { counterUpdates[key] = admin.firestore.FieldValue.increment(1); }
            }
          }
          break;
        }

        case "ranking": {
          // Update running average ranks for the changed order.
          // totalRespondents is unchanged (same user, different order).
          // Remove old contribution and add new contribution for each option.
          const oldRanked: string[] = response.rankedOptions || [];
          const pollDataCv = (await tx.get(pollRef)).data()!;
          const currentTotal = pollDataCv.totalRespondents || 0;
          const currentAvgRanks =
            (pollDataCv.averageRanks || {}) as Record<string, number>;
          if (currentTotal > 0) {
            for (let i = 0; i < newRankedOptions.length; i++) {
              const optId = newRankedOptions[i];
              const newRank = i + 1;
              const oldRankIdx = oldRanked.indexOf(optId);
              const oldRank = oldRankIdx >= 0 ? oldRankIdx + 1 : newRank;
              const oldAvg = currentAvgRanks[optId] || 0;
              // Subtract old rank contribution, add new rank contribution
              const newAvg =
                ((oldAvg * currentTotal) - oldRank + newRank) / currentTotal;
              counterUpdates[`averageRanks.${optId}`] =
                Math.round(newAvg * 100) / 100;
            }
          }
          break;
        }

        case "text":
          // No counters for text
          break;

        case "scale": {
          // Decrement old ratings, increment new ratings in distribution
          const oldRatings: Record<string, number> = response.scaleRatings || {};
          for (const [optId, oldVal] of Object.entries(oldRatings)) {
            counterUpdates[`ratingDistribution.${optId}.${oldVal}`] = admin.firestore.FieldValue.increment(-1);
          }
          for (const [optId, newVal] of Object.entries(newScaleRatings)) {
            const key = `ratingDistribution.${optId}.${newVal}`;
            if (counterUpdates[key]) { delete counterUpdates[key]; }
            else { counterUpdates[key] = admin.firestore.FieldValue.increment(1); }
          }
          break;
        }
      }

      tx.update(pollRef, counterUpdates);

      // Update response with type-specific fields
      const responseUpdate: Record<string, unknown> = {
        voteCount: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      switch (questionType) {
        case "multipleChoice": {
          const oldSelections: string[] = response.selectedOptions || [response.selectedOption];
          responseUpdate.selectedOption = effectiveNew[0];
          responseUpdate.selectedOptions = effectiveNew;
          responseUpdate.previousOption = oldSelections[0];
          responseUpdate.otherText = effectiveNew.includes("other") ? otherText?.trim() : null;
          break;
        }
        case "ranking":
          responseUpdate.rankedOptions = newRankedOptions;
          break;
        case "text":
          responseUpdate.textResponse = newTextResponse;
          break;
        case "scale":
          responseUpdate.scaleRatings = newScaleRatings;
          break;
      }

      tx.update(responseRef, responseUpdate);
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

    const questionType = poll.questionType || "multipleChoice";

    // Get user's full response (type-specific)
    const responseData = hasVoted ? responseDoc.data()! : null;
    const userSelections: string[] = hasVoted
      ? (responseData!.selectedOptions || [responseData!.selectedOption])
      : [];
    const userOtherText: string | null = hasVoted
      ? (responseData!.otherText || null)
      : null;
    const userRankedOptions: string[] = hasVoted
      ? (responseData!.rankedOptions || [])
      : [];
    const userTextResponse: string | null = hasVoted
      ? (responseData!.textResponse || null)
      : null;
    const userScaleRatings: Record<string, number> = hasVoted
      ? (responseData!.scaleRatings || {})
      : {};

    // Build type-specific results
    let results: Record<string, unknown> | null = null;
    if (canSeeResults) {
      switch (questionType) {
        case "multipleChoice":
          results = { totalRespondents, optionCounts, percentages };
          break;

        case "ranking": {
          // Use the materialised averageRanks maintained by submitPollVote /
          // changePollVote — no O(N) collection read required.
          const averageRanks =
            (poll.averageRanks || {}) as Record<string, number>;
          results = { totalRespondents, averageRanks };
          break;
        }

        case "text":
          // For text, just return respondent count — individual responses are private
          results = { totalRespondents };
          break;

        case "scale": {
          // Compute average ratings from ratingDistribution (no extra reads needed)
          const dist = (poll.ratingDistribution || {}) as Record<string, Record<string, number>>;
          const averageRatings: Record<string, number> = {};
          for (const [optId, counts] of Object.entries(dist)) {
            let totalScore = 0;
            let totalCount = 0;
            for (const [rating, count] of Object.entries(counts)) {
              totalScore += parseInt(rating) * count;
              totalCount += count;
            }
            averageRatings[optId] = totalCount > 0 ? Math.round((totalScore / totalCount) * 100) / 100 : 0;
          }
          results = {
            totalRespondents,
            averageRatings,
            ratingDistribution: dist,
          };
          break;
        }

        default:
          results = { totalRespondents, optionCounts, percentages };
      }
    }

    return {
      pollId,
      question: poll.question,
      options: poll.options,
      questionType,
      status: poll.status,
      hasVoted,
      userVote,
      userSelections,
      userOtherText,
      userRankedOptions,
      userTextResponse,
      userScaleRatings,
      allowChangeVote: poll.allowChangeVote || false,
      allowMultipleSelections: poll.allowMultipleSelections || false,
      maxSelections: poll.maxSelections || null,
      allowOtherOption: poll.allowOtherOption || false,
      resultVisibility,
      closesAt: poll.closesAt?.toDate?.()?.toISOString() || null,
      minResponsesForResults: poll.minResponsesForResults || null,
      // Scale config (needed by client for rendering)
      ...(questionType === "scale" ? {
        scaleMin: poll.scaleMin || 1,
        scaleMax: poll.scaleMax || 10,
        scaleMinLabel: poll.scaleMinLabel || null,
        scaleMaxLabel: poll.scaleMaxLabel || null,
        scaleIntermediateLabels: poll.scaleIntermediateLabels || [],
      } : {}),
      // Text config
      ...(questionType === "text" ? {
        textMinLength: poll.textMinLength || 1,
        textMaxLength: poll.textMaxLength || 500,
      } : {}),
      results,
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

      // Determine question type from poll doc
      const pollInTx = await tx.get(pollRef);
      const pollDataInTx = pollInTx.data()!;
      const qType = pollDataInTx.questionType || "multipleChoice";

      // Decrement counters based on question type
      const counterUpdates: Record<string, unknown> = {
        totalRespondents: admin.firestore.FieldValue.increment(-1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };

      switch (qType) {
        case "multipleChoice": {
          const selections: string[] = response.selectedOptions || [response.selectedOption];
          for (const optId of selections) {
            if (optId !== "other") {
              counterUpdates[`optionCounts.${optId}`] = admin.firestore.FieldValue.increment(-1);
            }
          }
          break;
        }
        case "ranking": {
          // Remove this response's contribution from the running averages.
          const ranked: string[] = response.rankedOptions || [];
          const pollDataInv = pollDataInTx;
          const invTotal = (pollDataInv.totalRespondents || 1); // before decrement
          const newInvTotal = invTotal - 1;
          const invAvgRanks =
            (pollDataInv.averageRanks || {}) as Record<string, number>;
          if (ranked.length > 0 && newInvTotal > 0) {
            for (let i = 0; i < ranked.length; i++) {
              const optId = ranked[i];
              const rank = i + 1;
              const oldAvg = invAvgRanks[optId] || 0;
              const newAvg =
                ((oldAvg * invTotal) - rank) / newInvTotal;
              counterUpdates[`averageRanks.${optId}`] =
                Math.round(newAvg * 100) / 100;
            }
          } else if (newInvTotal === 0) {
            // Last respondent removed — zero out all averages
            for (const optId of Object.keys(invAvgRanks)) {
              counterUpdates[`averageRanks.${optId}`] = 0;
            }
          }
          break;
        }
        case "text":
          // Just decrement respondent count
          break;
        case "scale": {
          // Decrement rating distribution
          const ratings: Record<string, number> = response.scaleRatings || {};
          for (const [optId, rating] of Object.entries(ratings)) {
            counterUpdates[`ratingDistribution.${optId}.${rating}`] = admin.firestore.FieldValue.increment(-1);
          }
          break;
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
