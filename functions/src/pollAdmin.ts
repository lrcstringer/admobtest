/**
 * Poll Admin Cloud Functions
 *
 * Admin CRUD for polls: create, update, open, close, get details.
 * When creating a poll, also creates a linked EarnOpportunity.
 */

import * as admin from "firebase-admin";
import { onCall, HttpsError } from "firebase-functions/v2/https";
import { requireAdminPermission, logAdminAction } from "./adminAuth";
import { checkAndCloseExpiredPoll } from "./helpers/pollHelpers";

const db = admin.firestore();


/**
 * Create a new poll with a linked EarnOpportunity.
 *
 * Creates both the poll document and the opportunity document atomically.
 * The poll starts in "draft" status — call openPoll to activate it.
 */
export const createPoll = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    const adminCtx = await requireAdminPermission(request, "poll:create", "createPoll");

    const {
      threadId,
      question,
      options, // Array of { text: string, mediaUrl?: string, mediaType?: string }
      isAnonymous = false,
      allowChangeVote = true,
      // New poll enhancement fields
      allowMultipleSelections = false,
      maxSelections = null,
      closesAt = null, // ISO 8601 UTC string
      minResponsesForResults = null,
      resultVisibility = "immediate", // 'immediate' | 'afterClose' | 'afterThreshold'
      allowOtherOption = false,
      tokenReward = 10,
      durationSeconds = 15,
      targeting = null,
      tokenBudget = null,
      dailyLimitPerUser = null,
      opportunityImage = null,
      // Legacy — ignored if resultVisibility is provided
      showResultsAfterVote = true,
    } = data;

    // Validate required fields
    if (!threadId || !question || !options) {
      throw new HttpsError(
        "invalid-argument",
        "threadId, question, and options are required"
      );
    }

    // Validate options
    if (!Array.isArray(options) || options.length < 2 || options.length > 6) {
      throw new HttpsError(
        "invalid-argument",
        "Must provide 2-6 options"
      );
    }

    // Validate resultVisibility
    const validVisibilities = ["immediate", "afterClose", "afterThreshold"];
    if (!validVisibilities.includes(resultVisibility)) {
      throw new HttpsError(
        "invalid-argument",
        `resultVisibility must be one of: ${validVisibilities.join(", ")}`
      );
    }

    // Validate afterThreshold requires minResponsesForResults
    if (resultVisibility === "afterThreshold" && (!minResponsesForResults || minResponsesForResults < 1)) {
      throw new HttpsError(
        "invalid-argument",
        "minResponsesForResults is required when resultVisibility is 'afterThreshold'"
      );
    }

    // Validate multi-select constraints
    if (allowMultipleSelections && maxSelections !== null && maxSelections !== undefined) {
      if (maxSelections < 2 || maxSelections > options.length) {
        throw new HttpsError(
          "invalid-argument",
          `maxSelections must be between 2 and ${options.length}`
        );
      }
    }

    // Validate closesAt is in the future
    if (closesAt) {
      const closesAtDate = new Date(closesAt);
      if (isNaN(closesAtDate.getTime()) || closesAtDate.getTime() <= Date.now()) {
        throw new HttpsError(
          "invalid-argument",
          "closesAt must be a valid future date in ISO 8601 format"
        );
      }
    }

    // Verify thread exists
    const threadDoc = await db.collection("earnThreads").doc(threadId).get();
    if (!threadDoc.exists) {
      throw new HttpsError(
        "not-found",
        "Thread not found. Create the thread first."
      );
    }
    const threadData = threadDoc.data()!;

    // Generate option IDs (preserve media fields)
    const pollOptions = (options as { text: string; mediaUrl?: string; mediaType?: string }[]).map(
      (opt, idx) => ({
        id: `opt_${idx}`,
        text: opt.text,
        ...(opt.mediaUrl ? { mediaUrl: opt.mediaUrl, mediaType: opt.mediaType || "image" } : {}),
      })
    );

    // Initialize option counts
    const optionCounts: Record<string, number> = {};
    for (const opt of pollOptions) {
      optionCounts[opt.id] = 0;
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const pollRef = db.collection("polls").doc();
    const oppRef = db.collection("earnOpportunities").doc();

    // Create both documents in a batch
    const batch = db.batch();

    // Create poll document
    batch.set(pollRef, {
      id: pollRef.id,
      opportunityId: oppRef.id,
      threadId,
      clientId: threadData.clientId,
      question,
      options: pollOptions,
      status: "draft",
      isAnonymous,
      allowChangeVote,
      allowMultipleSelections,
      maxSelections: maxSelections || null,
      closesAt: closesAt ? new Date(closesAt) : null,
      minResponsesForResults: minResponsesForResults || null,
      resultVisibility,
      allowOtherOption,
      showResultsAfterVote, // Legacy field
      openedAt: null,
      closedAt: null,
      totalRespondents: 0,
      optionCounts,
      createdAt: now,
      updatedAt: now,
      createdBy: request.auth!.uid,
    });

    // Create linked EarnOpportunity (inactive until poll is opened)
    batch.set(oppRef, {
      id: oppRef.id,
      threadId,
      title: question,
      description: null,
      earningType: "poll",
      tokenReward,
      streakPoints: 1,
      mediaType: "text",
      mediaUrl: null,
      questions: [{
        id: "poll_vote",
        text: question,
        orderIndex: 0,
        questionType: allowMultipleSelections ? "multiSelect" : "singleSelect",
        isRequired: true,
        options: pollOptions.map((o: { id: string; text: string }) => o.text),
        ...(allowMultipleSelections && maxSelections ? { maxSelections } : {}),
      }],
      durationSeconds,
      expiresAt: null,
      isActive: false, // Activated when poll is opened
      targeting: targeting || null,
      bonusReward: false,
      bonusRewardMultiplier: 1.0,
      bonusIntervalType: null,
      bonusIntervalX: null,
      dailyLimitPerUser: dailyLimitPerUser ?? null,
      adUnitId: null,
      pollId: pollRef.id,
      clientId: threadData.clientId,
      clientName: threadData.clientName,
      clientAvatarImage: threadData.clientAvatarImage ?? null,
      clientAvatarColor: threadData.clientAvatarColor ?? null,
      threadImage: threadData.threadImage ?? null,
      opportunityImage: opportunityImage ?? null,
      tokenBudget: tokenBudget ?? null,
      tokenSpent: 0,
      budgetExhausted: false,
      createdAt: now,
      updatedAt: now,
    });

    await batch.commit();

    logAdminAction(adminCtx.uid, "createPoll", "success", { pollId: pollRef.id, opportunityId: oppRef.id, threadId, question }).catch(() => {});

    return {
      success: true,
      pollId: pollRef.id,
      opportunityId: oppRef.id,
    };
  }
);

/**
 * Update a poll (admin only).
 *
 * Question and options can only be changed while in "draft" status.
 * Config fields (showResultsAfterVote, allowChangeVote, etc.) can be
 * changed while draft or open.
 */
export const updatePoll = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    const adminCtx = await requireAdminPermission(request, "poll:update", "updatePoll");

    const { pollId, ...updates } = data;
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

    // Only allow updates in draft or open status
    if (poll.status !== "draft" && poll.status !== "open") {
      throw new HttpsError(
        "failed-precondition",
        "Can only update polls in draft or open status"
      );
    }

    const updateData: Record<string, unknown> = {
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    // Question and options only editable in draft
    if (updates.question !== undefined || updates.options !== undefined) {
      if (poll.status !== "draft") {
        throw new HttpsError(
          "failed-precondition",
          "Question and options can only be changed while poll is in draft status"
        );
      }
      if (updates.question !== undefined) {
        updateData.question = updates.question;
      }
      if (updates.options !== undefined) {
        const opts = updates.options as { text: string; mediaUrl?: string; mediaType?: string }[];
        if (opts.length < 2 || opts.length > 6) {
          throw new HttpsError(
            "invalid-argument",
            "Must provide 2-6 options"
          );
        }
        const pollOptions = opts.map((opt, idx) => ({
          id: `opt_${idx}`,
          text: opt.text,
          ...(opt.mediaUrl ? { mediaUrl: opt.mediaUrl, mediaType: opt.mediaType || "image" } : {}),
        }));
        updateData.options = pollOptions;
        // Reset counters
        const optionCounts: Record<string, number> = {};
        for (const opt of pollOptions) {
          optionCounts[opt.id] = 0;
        }
        updateData.optionCounts = optionCounts;
      }
    }

    // Config fields (editable in draft or open)
    if (updates.isAnonymous !== undefined)
      updateData.isAnonymous = updates.isAnonymous;
    if (updates.allowChangeVote !== undefined)
      updateData.allowChangeVote = updates.allowChangeVote;
    if (updates.showResultsAfterVote !== undefined)
      updateData.showResultsAfterVote = updates.showResultsAfterVote;

    // New config fields
    if (updates.allowMultipleSelections !== undefined)
      updateData.allowMultipleSelections = updates.allowMultipleSelections;
    if (updates.maxSelections !== undefined)
      updateData.maxSelections = updates.maxSelections;
    if (updates.closesAt !== undefined)
      updateData.closesAt = updates.closesAt ? new Date(updates.closesAt) : null;
    if (updates.minResponsesForResults !== undefined)
      updateData.minResponsesForResults = updates.minResponsesForResults;
    if (updates.resultVisibility !== undefined) {
      const validVis = ["immediate", "afterClose", "afterThreshold"];
      if (!validVis.includes(updates.resultVisibility)) {
        throw new HttpsError("invalid-argument", `resultVisibility must be one of: ${validVis.join(", ")}`);
      }
      updateData.resultVisibility = updates.resultVisibility;
    }
    if (updates.allowOtherOption !== undefined)
      updateData.allowOtherOption = updates.allowOtherOption;

    await pollRef.update(updateData);

    // Sync denormalized data to linked opportunity
    if (poll.opportunityId) {
      const oppUpdate: Record<string, unknown> = {
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      if (updates.question !== undefined) {
        oppUpdate.title = updates.question;
      }
      // Rebuild questions array if options, question, or multi-select changed
      if (updates.options !== undefined || updates.question !== undefined ||
          updates.allowMultipleSelections !== undefined || updates.maxSelections !== undefined) {
        const finalQuestion = updates.question ?? poll.question;
        const finalOptions = updateData.options ?? poll.options;
        const finalMulti = updates.allowMultipleSelections ?? poll.allowMultipleSelections;
        const finalMax = updates.maxSelections ?? poll.maxSelections;
        oppUpdate.questions = [{
          id: "poll_vote",
          text: finalQuestion,
          orderIndex: 0,
          questionType: finalMulti ? "multiSelect" : "singleSelect",
          isRequired: true,
          options: (finalOptions as { id: string; text: string }[]).map((o) => o.text),
          ...(finalMulti && finalMax ? { maxSelections: finalMax } : {}),
        }];
      }
      if (Object.keys(oppUpdate).length > 1) {
        await db.collection("earnOpportunities").doc(poll.opportunityId).update(oppUpdate);
      }
    }

    logAdminAction(adminCtx.uid, "updatePoll", "success", { pollId, updatedFields: Object.keys(updates) }).catch(() => {});

    return { success: true };
  }
);

/**
 * Open a poll (transition draft → open).
 * Activates the linked EarnOpportunity.
 */
export const openPoll = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    const adminCtx = await requireAdminPermission(request, "poll:open", "openPoll");

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
    if (poll.status !== "draft") {
      throw new HttpsError(
        "failed-precondition",
        `Cannot open poll in "${poll.status}" status. Must be "draft".`
      );
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const batch = db.batch();

    // Open the poll
    batch.update(pollRef, {
      status: "open",
      openedAt: now,
      updatedAt: now,
    });

    // Activate the linked opportunity
    if (poll.opportunityId) {
      const oppRef = db.collection("earnOpportunities").doc(poll.opportunityId);
      batch.update(oppRef, {
        isActive: true,
        updatedAt: now,
      });

      // Increment thread's available opportunities count
      const threadRef = db.collection("earnThreads").doc(poll.threadId);
      batch.update(threadRef, {
        availableOpportunities: admin.firestore.FieldValue.increment(1),
        lastActivityAt: now,
      });
    }

    await batch.commit();

    logAdminAction(adminCtx.uid, "openPoll", "success", { pollId, opportunityId: poll.opportunityId }).catch(() => {});

    return { success: true };
  }
);

/**
 * Close a poll (transition open → closed).
 * Deactivates the linked EarnOpportunity.
 */
export const closePoll = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    const adminCtx = await requireAdminPermission(request, "poll:close", "closePoll");

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
    if (poll.status !== "open") {
      throw new HttpsError(
        "failed-precondition",
        `Cannot close poll in "${poll.status}" status. Must be "open".`
      );
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const batch = db.batch();

    // Close the poll
    batch.update(pollRef, {
      status: "closed",
      closedAt: now,
      updatedAt: now,
    });

    // Deactivate the linked opportunity
    if (poll.opportunityId) {
      const oppRef = db.collection("earnOpportunities").doc(poll.opportunityId);
      batch.update(oppRef, {
        isActive: false,
        updatedAt: now,
      });

      // Decrement thread's available opportunities count
      const threadRef = db.collection("earnThreads").doc(poll.threadId);
      batch.update(threadRef, {
        availableOpportunities: admin.firestore.FieldValue.increment(-1),
        lastActivityAt: now,
      });
    }

    await batch.commit();

    logAdminAction(adminCtx.uid, "closePoll", "success", { pollId, opportunityId: poll.opportunityId, totalRespondents: poll.totalRespondents }).catch(() => {});

    return { success: true };
  }
);

/**
 * Reopen a closed poll (transition closed → open).
 * Reactivates the linked EarnOpportunity.
 */
export const reopenPoll = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    const adminCtx = await requireAdminPermission(request, "poll:open", "reopenPoll");

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
    if (poll.status !== "closed") {
      throw new HttpsError(
        "failed-precondition",
        `Cannot reopen poll in "${poll.status}" status. Must be "closed".`
      );
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const batch = db.batch();

    // Reopen the poll
    batch.update(pollRef, {
      status: "open",
      closedAt: null,
      updatedAt: now,
    });

    // Reactivate the linked opportunity
    if (poll.opportunityId) {
      const oppRef = db.collection("earnOpportunities").doc(poll.opportunityId);
      batch.update(oppRef, {
        isActive: true,
        updatedAt: now,
      });

      // Increment thread's available opportunities count
      const threadRef = db.collection("earnThreads").doc(poll.threadId);
      batch.update(threadRef, {
        availableOpportunities: admin.firestore.FieldValue.increment(1),
        lastActivityAt: now,
      });
    }

    await batch.commit();

    logAdminAction(adminCtx.uid, "reopenPoll", "success", { pollId, opportunityId: poll.opportunityId }).catch(() => {});

    return { success: true };
  }
);

/**
 * Get poll admin details including all responses and segmented counts.
 */
export const getPollAdminDetails = onCall(
  { labels: { area: "polls" } },
  async (request) => {
    const data = request.data;
    await requireAdminPermission(request, "poll:getDetails", "getPollAdminDetails");

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

    // Inline-close if expired
    await checkAndCloseExpiredPoll(pollRef, poll);

    // Get all responses
    const responsesSnapshot = await pollRef
      .collection("responses")
      .orderBy("respondedAt", "desc")
      .get();

    const responses = responsesSnapshot.docs.map((doc) => {
      const d = doc.data();
      return {
        ...d,
        respondedAt: d.respondedAt?.toDate?.()?.toISOString() || null,
        updatedAt: d.updatedAt?.toDate?.()?.toISOString() || null,
        invalidatedAt: d.invalidatedAt?.toDate?.()?.toISOString() || null,
      } as Record<string, unknown>;
    });

    // Calculate segmented counts from responses
    const segmentedCounts = {
      byProvince: {} as Record<string, Record<string, number>>,
      byGender: {} as Record<string, Record<string, number>>,
      byAgeGroup: {} as Record<string, Record<string, number>>,
    };

    for (const r of responses) {
      if (r.status !== "valid") continue;
      const demo = r.demographics as Record<string, string | null> | null;
      if (!demo) continue;

      const opt = r.selectedOption as string;

      // By province
      if (demo.province) {
        if (!segmentedCounts.byProvince[demo.province]) {
          segmentedCounts.byProvince[demo.province] = {};
        }
        segmentedCounts.byProvince[demo.province][opt] =
          (segmentedCounts.byProvince[demo.province][opt] || 0) + 1;
      }

      // By gender
      if (demo.gender) {
        if (!segmentedCounts.byGender[demo.gender]) {
          segmentedCounts.byGender[demo.gender] = {};
        }
        segmentedCounts.byGender[demo.gender][opt] =
          (segmentedCounts.byGender[demo.gender][opt] || 0) + 1;
      }

      // By age group
      if (demo.ageGroup) {
        if (!segmentedCounts.byAgeGroup[demo.ageGroup]) {
          segmentedCounts.byAgeGroup[demo.ageGroup] = {};
        }
        segmentedCounts.byAgeGroup[demo.ageGroup][opt] =
          (segmentedCounts.byAgeGroup[demo.ageGroup][opt] || 0) + 1;
      }
    }

    const totalRespondents = poll.totalRespondents || 0;
    const optionCounts = (poll.optionCounts || {}) as Record<string, number>;
    const percentages: Record<string, number> = {};
    if (totalRespondents > 0) {
      for (const [optId, count] of Object.entries(optionCounts)) {
        percentages[optId] = Math.round((count / totalRespondents) * 100);
      }
    }

    return {
      poll: {
        ...poll,
        createdAt: poll.createdAt?.toDate?.()?.toISOString() || null,
        updatedAt: poll.updatedAt?.toDate?.()?.toISOString() || null,
        openedAt: poll.openedAt?.toDate?.()?.toISOString() || null,
        closedAt: poll.closedAt?.toDate?.()?.toISOString() || null,
      },
      results: {
        totalRespondents,
        optionCounts,
        percentages,
      },
      responses,
      segmentedCounts,
    };
  }
);
