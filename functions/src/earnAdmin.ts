/**
 * Admin functions for managing earn threads and opportunities
 *
 * These functions are used to populate and manage the earn-related collections:
 * - earnThreads: Campaign groupings for earn opportunities (updated from brand to client model)
 * - earnOpportunities: Individual video/survey tasks
 *
 * These should be called from admin panel or via Firebase console
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import { requireAdminPermission, logAdminAction } from "./adminAuth";
import {
  TargetingCriteria,
  validateTargetingCriteria,
  validateEarningType,
  EARNING_TYPES,
  calculateEngagementLevel,
  calculateAge,
} from "./constants/targeting";
import {
  isUserEligibleForTargeting,
  checkBrandInteraction,
  buildUserTargetingContext,
} from "./targetingUtils";
import {
  notifyNewThread,
  notifyNewOpportunity,
} from "./earnNotifications";
import { AccountId, AccountTypeRules } from "./ledger/types";
import { createAccount, getBalance } from "./ledger/accounts";
import { createAccountType } from "./ledger/subAccounts";

const db = admin.firestore();


// ============================================================================
// EARN THREAD MANAGEMENT
// ============================================================================

/**
 * Create or update an earn thread (campaign)
 * Admin-only function
 *
 * Updated signature: uses clientId instead of brandId, supports targeting
 */
export const createEarnThread = functions.https.onCall(async (data, context) => {
  try {
  const adminCtx = await requireAdminPermission(context, "earn:createThread", "createEarnThread");

  const {
    // Thread ID (optional - auto-generates if not provided)
    id,
    // Client reference (required)
    clientId,
    // Thread display
    title,
    description,
    // Token source configuration — full ledger account ID (e.g. "client:abc" or "client_subacc:xyz")
    tokenSourceAccountId,
    tokenDestAccountTypeId,
    // Optional override for auto-created sub-account name (defaults to title)
    subAccountName,
    // Inline account type creation (optional) — creates a SubAccountTypeDefinition
    // { name?: string, description?: string, rules: AccountTypeRules }
    inlineAccountType,
    // Display & behavior flags
    isPinned = false,
    isFeatured = false,
    isActive = true,
    // Scheduling
    activeFrom,
    activeTo,
    // Audience targeting
    targeting,
    // Optional thread image URL (uploaded by admin client-side)
    threadImage,
  } = data;

  // Validate required fields
  if (!clientId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "clientId is required"
    );
  }
  if (!title) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "title is required"
    );
  }

  // Fetch client document for denormalization
  const clientDoc = await db.collection("clients").doc(clientId).get();
  if (!clientDoc.exists) {
    throw new functions.https.HttpsError(
      "not-found",
      `Client not found: ${clientId}`
    );
  }
  const clientData = clientDoc.data()!;

  if (!clientData.isActive) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Client is not active"
    );
  }

  // Resolve token source account ID.
  // If provided, it should be a full ledger account ID (e.g. "client:abc" or "client_subacc:xyz").
  // If not provided, auto-create a client sub-account.
  let resolvedTokenSourceAccountId = tokenSourceAccountId || null;
  const subAccountsCol = db
    .collection("clients")
    .doc(clientId)
    .collection("subAccounts");

  if (resolvedTokenSourceAccountId) {
    // An explicit token source was selected — validate it's a known format
    if (
      !AccountId.isClientAccount(resolvedTokenSourceAccountId) &&
      !AccountId.isClientSubAccount(resolvedTokenSourceAccountId)
    ) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "tokenSourceAccountId must be a client or client_subacc ledger account ID"
      );
    }
  } else {
    // No token source selected — auto-create one named after the campaign title
    // (or the explicit subAccountName override if provided).
    const resolvedSubAccountName = subAccountName || title;

    // Check for an existing sub-account with the same name first.
    const nameCheck = await subAccountsCol
      .where("name", "==", resolvedSubAccountName)
      .limit(1)
      .get();

    if (!nameCheck.empty) {
      const existing = nameCheck.docs[0];
      const existingData = existing.data();
      const existingLedgerAccountId = existingData.ledgerAccountId || AccountId.clientSubAccount(existing.id);
      return {
        success: false,
        duplicateSubAccount: true,
        existingSubAccountId: existing.id,
        existingTokenSourceAccountId: existingLedgerAccountId,
        existingSubAccountName: existingData.name,
        message: `A sub-account named "${resolvedSubAccountName}" already exists. Reuse it?`,
      };
    }

    // Create new Firestore metadata doc + ledger account
    const subAccountRef = subAccountsCol.doc();
    const tsNow = admin.firestore.FieldValue.serverTimestamp();
    const ledgerAccountId = AccountId.clientSubAccount(subAccountRef.id);

    // Create ledger account
    await createAccount({
      type: "client_subacc",
      name: `${resolvedSubAccountName} — ${clientId}`,
      ownerId: subAccountRef.id,
      metadata: { clientId, subAccountFirestoreId: subAccountRef.id },
    });

    // Create Firestore metadata doc
    await subAccountRef.set({
      id: subAccountRef.id,
      name: resolvedSubAccountName,
      ledgerAccountId,
      isActive: true,
      budgetExhausted: false,
      warningNotifiedAt: null,
      depletedAt: null,
      createdAt: tsNow,
      updatedAt: tsNow,
      createdBy: context.auth!.uid,
    });

    resolvedTokenSourceAccountId = ledgerAccountId;
    console.log(`Auto-created sub-account "${subAccountRef.id}" (ledger: ${ledgerAccountId}) for client ${clientId}`);
  }

  // Resolve token dest account type — use existing or create inline
  let resolvedTokenDestAccountTypeId = tokenDestAccountTypeId || null;

  if (inlineAccountType && !resolvedTokenDestAccountTypeId) {
    // Validate inline account type data
    const rules = inlineAccountType.rules;
    if (!rules || typeof rules !== "object") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "inlineAccountType.rules is required and must be an object"
      );
    }
    if (!Array.isArray(rules.allowedOfframps)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "inlineAccountType.rules.allowedOfframps must be an array"
      );
    }

    // Create the account type via existing ledger helper
    const accountTypeRef = db.collection("accountTypes").doc();
    const accountTypeName = inlineAccountType.name || title;
    const accountTypeDescription =
      inlineAccountType.description || `Account type for campaign: ${title}`;

    const validatedRules: AccountTypeRules = {
      allowedOfframps: rules.allowedOfframps,
      allowP2pSend: rules.allowP2pSend !== false,
      allowP2pReceive: rules.allowP2pReceive !== false,
      allowCashout: rules.allowCashout !== false,
      expiryDays: typeof rules.expiryDays === "number" ? rules.expiryDays : null,
    };

    await createAccountType(
      accountTypeRef.id,
      accountTypeName,
      accountTypeDescription,
      validatedRules,
      { advertiserId: clientId },
    );

    resolvedTokenDestAccountTypeId = accountTypeRef.id;
    console.log(
      `Auto-created account type "${accountTypeRef.id}" for campaign "${title}"`
    );
  }

  // Validate targeting criteria if provided
  if (targeting) {
    const validationResult = validateTargetingCriteria(targeting);
    if (!validationResult.valid) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Invalid targeting criteria: ${validationResult.errors.join("; ")}`
      );
    }
  }

  // Prepare thread document
  const threadRef = id
    ? db.collection("earnThreads").doc(id)
    : db.collection("earnThreads").doc();
  const now = admin.firestore.FieldValue.serverTimestamp();

  const existingThread = await threadRef.get();

  // Denormalized client fields
  const clientName = clientData.displayName || clientData.companyName;
  const clientAvatarImage = clientData.avatarImage || null;
  const clientAvatarColor = clientData.avatarColor || null;

  // Parse dates if provided
  const parsedActiveFrom = activeFrom
    ? admin.firestore.Timestamp.fromDate(new Date(activeFrom))
    : null;
  const parsedActiveTo = activeTo
    ? admin.firestore.Timestamp.fromDate(new Date(activeTo))
    : null;

  if (existingThread.exists) {
    // Update existing thread
    await threadRef.update({
      clientId,
      clientName,
      clientAvatarImage,
      clientAvatarColor,
      threadImage: threadImage || null,
      title,
      description: description || null,
      tokenSourceAccountId: resolvedTokenSourceAccountId,
      tokenDestAccountTypeId: resolvedTokenDestAccountTypeId,
      isPinned,
      isFeatured,
      isActive,
      activeFrom: parsedActiveFrom,
      activeTo: parsedActiveTo,
      targeting: targeting || null,
      updatedAt: now,
    });
  } else {
    // Create new thread
    await threadRef.set({
      id: threadRef.id,
      clientId,
      clientName,
      clientAvatarImage,
      clientAvatarColor,
      threadImage: threadImage || null,
      title,
      description: description || null,
      tokenSourceAccountId: resolvedTokenSourceAccountId,
      tokenDestAccountTypeId: resolvedTokenDestAccountTypeId,
      isPinned,
      isFeatured,
      isActive,
      activeFrom: parsedActiveFrom,
      activeTo: parsedActiveTo,
      targeting: targeting || null,
      availableOpportunities: 0,
      completedOpportunities: 0,
      completedUniqueUsers: 0,
      createdAt: now,
      lastActivityAt: now,
      updatedAt: now,
    });
  }

  // Send notifications if thread is active (fire-and-forget)
  if (isActive) {
    const clientName = clientData.displayName || clientData.companyName || "Unknown";
    notifyNewThread(threadRef.id, title, clientId, clientName, targeting || null)
      .catch((err) => console.warn("notifyNewThread failed (non-fatal):", err));
  }

  logAdminAction(adminCtx.uid, "createEarnThread", "success", { threadId: threadRef.id, clientId, title, tokenSourceAccountId: resolvedTokenSourceAccountId }).catch(() => {});

  return {
    success: true,
    threadId: threadRef.id,
    tokenSourceAccountId: resolvedTokenSourceAccountId,
    tokenDestAccountTypeId: resolvedTokenDestAccountTypeId,
  };
  } catch (error: unknown) {
    // Log the actual error for debugging
    console.error("createEarnThread FAILED:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error; // re-throw known errors as-is
    }
    throw new functions.https.HttpsError(
      "internal",
      `createEarnThread failed: ${error instanceof Error ? error.message : String(error)}`
    );
  }
});

/**
 * Create or update an earn opportunity
 * Admin-only function
 *
 * Updated: requires earningType, supports targeting
 */
export const createEarnOpportunity = functions.https.onCall(
  async (data, context) => {
    const adminCtx = await requireAdminPermission(context, "earn:createOpportunity", "createEarnOpportunity");

    const {
      id,
      threadId,
      title,
      description,
      earningType,
      tokenReward,
      streakPoints = 1, // Default to 1 if not provided
      mediaType = "video",
      mediaUrl,
      questions = [],
      durationSeconds,
      expiresAt,
      isActive = true,
      targeting,
      // Bonus reward fields
      bonusReward = false,
      bonusRewardMultiplier = 1.0,
      bonusIntervalType = null,
      bonusIntervalX = null,
      // AdMob / per-user limits
      dailyLimitPerUser = null,
      adUnitId = null,
      // Budget cap (optional)
      tokenBudget = null,
      // Optional opportunity image URL (uploaded by admin client-side)
      opportunityImage = null,
      // Reward campaign linkage (for dual rewards)
      rewardCampaignId = null,
      // Poll reference (for poll-type opportunities)
      pollId = null,
      // Upload configuration (for upload-type opportunities)
      uploadPrompt = null,
      uploadContextMediaUrl = null,
      uploadContextMediaType = null,
      uploadVideoEnabled = false,
      uploadImageEnabled = false,
      uploadTextEnabled = false,
      uploadVideoRequired = false,
      uploadImageRequired = false,
      uploadTextRequired = false,
      uploadVideoMaxSeconds = 60,
      uploadTextMinChars = 10,
      uploadTextMaxChars = 1500,
      requiresAdminReview = false,
      // Pin/feature flags for ordering
      isPinned = false,
      isFeatured = false,
    } = data;

    // Validate required fields
    if (!threadId || !title || !tokenReward || !durationSeconds) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "threadId, title, tokenReward, and durationSeconds are required"
      );
    }

    // Validate earningType
    if (!earningType) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "earningType is required"
      );
    }
    if (!validateEarningType(earningType)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        `Invalid earningType: ${earningType}. Valid values: ${EARNING_TYPES.join(", ")}`
      );
    }

    // Verify thread exists
    const threadDoc = await db.collection("earnThreads").doc(threadId).get();
    if (!threadDoc.exists) {
      throw new functions.https.HttpsError(
        "not-found",
        "Thread not found. Create the thread first."
      );
    }

    const threadData = threadDoc.data()!;

    // Balance check: prevent activation when token source has zero balance
    if (isActive) {
      const tokenSource = threadData.tokenSourceAccountId
        || AccountId.client(threadData.clientId);
      const sourceBalance = await getBalance(tokenSource);
      if (sourceBalance <= 0) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Cannot activate opportunity: token source account has zero balance"
        );
      }
    }

    // Validate targeting criteria if provided
    if (targeting) {
      const validationResult = validateTargetingCriteria(targeting);
      if (!validationResult.valid) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          `Invalid targeting criteria: ${validationResult.errors.join("; ")}`
        );
      }
    }

    // Validate bonus reward configuration
    if (bonusReward) {
      if (typeof bonusRewardMultiplier !== "number" || bonusRewardMultiplier < 1) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "bonusRewardMultiplier must be a number >= 1"
        );
      }

      if (!bonusIntervalType) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "bonusIntervalType is required when bonusReward is true"
        );
      }

      const validIntervalTypes = ["random", "every_x"];
      if (!validIntervalTypes.includes(bonusIntervalType)) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          `Invalid bonusIntervalType: ${bonusIntervalType}. Valid values: ${validIntervalTypes.join(", ")}`
        );
      }

      if (bonusIntervalType === "every_x") {
        if (
          typeof bonusIntervalX !== "number" ||
          bonusIntervalX < 1 ||
          !Number.isInteger(bonusIntervalX)
        ) {
          throw new functions.https.HttpsError(
            "invalid-argument",
            "bonusIntervalX must be a positive integer when bonusIntervalType is 'every_x'"
          );
        }
      }
    }

    // Validate reward campaign linkage if provided
    let resolvedRewardCampaignName: string | null = null;
    let resolvedRewardType: string | null = null;
    if (rewardCampaignId) {
      const rewardCampaignDoc = await db
        .collection("rewardCampaigns")
        .doc(rewardCampaignId)
        .get();

      if (!rewardCampaignDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          `Reward campaign not found: ${rewardCampaignId}`
        );
      }

      const rewardCampaign = rewardCampaignDoc.data()!;

      if (rewardCampaign.isDeleted === true) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Reward campaign has been deleted"
        );
      }

      // Verify campaign belongs to the same client as the thread
      if (rewardCampaign.clientId !== threadData.clientId) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Reward campaign must belong to the same client as the thread"
        );
      }

      resolvedRewardCampaignName = rewardCampaign.name || null;
      resolvedRewardType = rewardCampaign.rewardType || null;
    }

    // Validate upload configuration
    if (earningType === "upload") {
      if (!uploadVideoEnabled && !uploadImageEnabled && !uploadTextEnabled) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "At least one upload type (video, image, or text) must be enabled"
        );
      }
      if (!uploadPrompt) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "uploadPrompt is required for upload opportunities"
        );
      }
    }

    const opportunityRef = id
      ? db.collection("earnOpportunities").doc(id)
      : db.collection("earnOpportunities").doc();

    const now = admin.firestore.FieldValue.serverTimestamp();
    const opportunityId = opportunityRef.id;

    const existingOpportunity = await opportunityRef.get();
    const wasActive = existingOpportunity.exists
      ? existingOpportunity.data()?.isActive
      : false;

    const opportunityData = {
      id: opportunityId,
      threadId,
      title,
      description: description || null,
      earningType,
      tokenReward,
      streakPoints: streakPoints ?? 1, // Ensure it's always set
      mediaType,
      mediaUrl: mediaUrl || null,
      questions,
      durationSeconds,
      expiresAt: expiresAt
        ? admin.firestore.Timestamp.fromDate(new Date(expiresAt))
        : null,
      isActive,
      targeting: targeting || null,
      // Bonus reward configuration
      bonusReward: bonusReward || false,
      bonusRewardMultiplier: bonusReward ? bonusRewardMultiplier : 1.0,
      bonusIntervalType: bonusReward ? bonusIntervalType : null,
      bonusIntervalX: bonusReward && bonusIntervalType === "every_x" ? bonusIntervalX : null,
      // AdMob / per-user limits
      dailyLimitPerUser: dailyLimitPerUser ?? null,
      adUnitId: adUnitId ?? null,
      // Denormalized from thread
      clientId: threadData.clientId,
      clientName: threadData.clientName,
      clientAvatarImage: threadData.clientAvatarImage ?? null,
      clientAvatarColor: threadData.clientAvatarColor,
      threadImage: threadData.threadImage ?? null,
      opportunityImage: opportunityImage ?? null,
      // Reward campaign linkage
      rewardCampaignId: rewardCampaignId ?? null,
      rewardCampaignName: resolvedRewardCampaignName,
      rewardType: resolvedRewardType,
      // Poll reference
      pollId: pollId ?? null,
      // Upload configuration
      uploadPrompt: uploadPrompt ?? null,
      uploadContextMediaUrl: uploadContextMediaUrl ?? null,
      uploadContextMediaType: uploadContextMediaType ?? null,
      uploadVideoEnabled: uploadVideoEnabled ?? false,
      uploadImageEnabled: uploadImageEnabled ?? false,
      uploadTextEnabled: uploadTextEnabled ?? false,
      uploadVideoRequired: uploadVideoRequired ?? false,
      uploadImageRequired: uploadImageRequired ?? false,
      uploadTextRequired: uploadTextRequired ?? false,
      uploadVideoMaxSeconds: uploadVideoMaxSeconds ?? 60,
      uploadTextMinChars: uploadTextMinChars ?? 10,
      uploadTextMaxChars: uploadTextMaxChars ?? 1500,
      requiresAdminReview: requiresAdminReview ?? false,
      // Pin/feature flags for ordering
      isPinned: isPinned ?? false,
      isFeatured: isFeatured ?? false,
      // Budget cap fields
      tokenBudget: tokenBudget ?? null,
      tokenSpent: existingOpportunity.exists
        ? (existingOpportunity.data()?.tokenSpent ?? 0)
        : 0,
      budgetExhausted: existingOpportunity.exists
        ? (existingOpportunity.data()?.budgetExhausted ?? false)
        : false,
      updatedAt: now,
    };

    if (existingOpportunity.exists) {
      await opportunityRef.update(opportunityData);
    } else {
      await opportunityRef.set({
        ...opportunityData,
        createdAt: now,
      });
    }

    // Update thread's available opportunities count
    if (isActive !== wasActive) {
      const increment = isActive ? 1 : -1;
      await db
        .collection("earnThreads")
        .doc(threadId)
        .update({
          availableOpportunities: admin.firestore.FieldValue.increment(increment),
          lastActivityAt: now,
        });
    }

    // Send notifications if opportunity is active (fire-and-forget)
    if (isActive) {
      notifyNewOpportunity(
        opportunityId,
        threadId,
        threadData.title || title,
        threadData.clientId,
        threadData.clientName || "Unknown",
        tokenReward,
        earningType,
        targeting || null
      ).catch((err) =>
        console.warn("notifyNewOpportunity failed (non-fatal):", err)
      );
    }

    logAdminAction(adminCtx.uid, "createEarnOpportunity", "success", { opportunityId, threadId, earningType, tokenReward }).catch(() => {});

    return { success: true, opportunityId };
  }
);

/**
 * Reset an opportunity's budget tracking.
 * Resets tokenSpent to 0, optionally sets a new tokenBudget, and clears budgetExhausted.
 * Admin-only function.
 */
export const adminResetOpportunityBudget = functions.https.onCall(
  async (data: { opportunityId: string; newBudget?: number | null }, context) => {
    const adminCtx = await requireAdminPermission(context, "earn:resetBudget", "adminResetOpportunityBudget");

    const { opportunityId, newBudget } = data;

    if (!opportunityId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "opportunityId is required"
      );
    }

    const oppRef = db.collection("earnOpportunities").doc(opportunityId);
    const oppDoc = await oppRef.get();

    if (!oppDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Opportunity not found");
    }

    const updates: Record<string, unknown> = {
      tokenSpent: 0,
      budgetExhausted: false,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    // If newBudget is explicitly provided, update it (null = unlimited)
    if (newBudget !== undefined) {
      updates.tokenBudget = newBudget;
    }

    await oppRef.update(updates);

    logAdminAction(adminCtx.uid, "adminResetOpportunityBudget", "success", { opportunityId, newBudget: newBudget ?? null }).catch(() => {});

    return { success: true, opportunityId };
  }
);

/**
 * Sync campaigns to earnOpportunities
 * Converts campaigns collection entries to earnOpportunities format
 * Admin-only function (legacy migration helper)
 */
export const syncCampaignsToOpportunities = functions.https.onCall(
  async (data, context) => {
    const adminCtx = await requireAdminPermission(context, "earn:syncCampaigns", "syncCampaignsToOpportunities");

    const { defaultThreadId } = data;

    if (!defaultThreadId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "defaultThreadId is required"
      );
    }

    // Get all active campaigns
    const campaignsSnapshot = await db
      .collection("campaigns")
      .where("status", "==", "active")
      .get();

    if (campaignsSnapshot.empty) {
      return { success: true, synced: 0 };
    }

    const batch = db.batch();
    const now = admin.firestore.FieldValue.serverTimestamp();
    let syncedCount = 0;

    for (const campaignDoc of campaignsSnapshot.docs) {
      const campaign = campaignDoc.data();

      // Check if opportunity already exists for this campaign
      const existingOpportunity = await db
        .collection("earnOpportunities")
        .where("campaignId", "==", campaignDoc.id)
        .limit(1)
        .get();

      if (existingOpportunity.empty) {
        const opportunityRef = db.collection("earnOpportunities").doc();

        batch.set(opportunityRef, {
          id: opportunityRef.id,
          threadId: defaultThreadId,
          title: campaign.title || campaign.name || "Earn Opportunity",
          description: campaign.description || null,
          earningType: campaign.type || "video",
          tokenReward: campaign.rewardPerEngagement || 10,
          mediaType: campaign.type || "video",
          mediaUrl: campaign.mediaUrl || campaign.videoUrl || "",
          questions: campaign.questions || [],
          durationSeconds: campaign.videoDuration || 30,
          expiresAt: campaign.endDate || null,
          isActive: true,
          targeting: null,
          clientName: campaign.brandName || null,
          clientAvatarColor: null,
          campaignId: campaignDoc.id,
          createdAt: now,
          updatedAt: now,
        });

        syncedCount++;
      }
    }

    if (syncedCount > 0) {
      await batch.commit();

      // Update thread's available opportunities count
      await db
        .collection("earnThreads")
        .doc(defaultThreadId)
        .update({
          availableOpportunities: admin.firestore.FieldValue.increment(syncedCount),
          lastActivityAt: now,
        });
    }

    logAdminAction(adminCtx.uid, "syncCampaignsToOpportunities", "success", { defaultThreadId, syncedCount }).catch(() => {});

    return { success: true, synced: syncedCount };
  }
);

/**
 * Deactivate expired opportunities and threads
 * Run daily to clean up expired items
 *
 * Extended to also handle thread scheduling (activeFrom/activeTo)
 */
export const deactivateExpiredOpportunities = functions.pubsub
  .schedule("0 1 * * *") // 1 AM daily
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();

    // ========================================================================
    // 1. Deactivate expired opportunities
    // ========================================================================
    const expiredOpportunities = await db
      .collection("earnOpportunities")
      .where("isActive", "==", true)
      .where("expiresAt", "<=", now)
      .get();

    if (!expiredOpportunities.empty) {
      const batch = db.batch();
      const threadUpdates: Map<string, number> = new Map();

      for (const doc of expiredOpportunities.docs) {
        const data = doc.data();
        batch.update(doc.ref, {
          isActive: false,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Track thread updates
        const threadId = data.threadId;
        threadUpdates.set(threadId, (threadUpdates.get(threadId) || 0) + 1);
      }

      await batch.commit();

      // Update thread counts
      for (const [threadId, count] of threadUpdates) {
        await db
          .collection("earnThreads")
          .doc(threadId)
          .update({
            availableOpportunities: admin.firestore.FieldValue.increment(-count),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
      }

      console.log(
        `Deactivated ${expiredOpportunities.size} expired opportunities`
      );
    }

    // ========================================================================
    // 2. Deactivate threads past their activeTo date
    // ========================================================================
    const expiredThreads = await db
      .collection("earnThreads")
      .where("isActive", "==", true)
      .where("activeTo", "<=", now)
      .get();

    if (!expiredThreads.empty) {
      const batch = db.batch();

      for (const doc of expiredThreads.docs) {
        batch.update(doc.ref, {
          isActive: false,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      console.log(`Deactivated ${expiredThreads.size} expired threads`);
    }

    // ========================================================================
    // 3. Guard against prematurely activated threads (activeFrom > now)
    // This handles threads that might have been incorrectly set to active
    // ========================================================================
    const prematureThreads = await db
      .collection("earnThreads")
      .where("isActive", "==", true)
      .where("activeFrom", ">", now)
      .get();

    if (!prematureThreads.empty) {
      const batch = db.batch();

      for (const doc of prematureThreads.docs) {
        batch.update(doc.ref, {
          isActive: false,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      console.log(
        `Deactivated ${prematureThreads.size} prematurely activated threads`
      );
    }

    return null;
  });

// ============================================================================
// USER-FACING ELIGIBILITY FUNCTIONS
// ============================================================================

/**
 * Return only the fields the client needs for the thread list.
 * Strips targeting rules, token source IDs, and other server-only data
 * to reduce payload size.
 */
function slimThread(id: string, t: admin.firestore.DocumentData) {
  return {
    id,
    clientId: t.clientId,
    clientName: t.clientName,
    clientAvatarColor: t.clientAvatarColor ?? null,
    clientAvatarImage: t.clientAvatarImage ?? null,
    threadImage: t.threadImage ?? null,
    title: t.title,
    description: t.description ?? null,
    isPinned: t.isPinned ?? false,
    isFeatured: t.isFeatured ?? false,
    isActive: t.isActive ?? true,
    availableOpportunities: t.availableOpportunities ?? 0,
    completedOpportunities: t.completedOpportunities ?? 0,
    completedUniqueUsers: t.completedUniqueUsers ?? 0,
    lastActivityAt: t.lastActivityAt ?? null,
    createdAt: t.createdAt ?? null,
  };
}

/**
 * Get eligible threads for the current user
 *
 * This Cloud Function replaces direct Firestore reads for earnThreads.
 * It applies server-side targeting filters based on user profile.
 */
export const getEligibleThreads = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "getEligibleThreads");

    const userCtx = await buildUserTargetingContext(context);
    const { profile: userProfile } = userCtx;

    // ========================================================================
    // Get all active threads and filter by targeting
    // ========================================================================
    const now = admin.firestore.Timestamp.now();

    const threadsSnapshot = await db
      .collection("earnThreads")
      .where("isActive", "==", true)
      .get();

    const eligibleThreads: admin.firestore.DocumentData[] = [];

    for (const threadDoc of threadsSnapshot.docs) {
      const thread = threadDoc.data();

      // Check scheduling constraints
      if (thread.activeFrom && thread.activeFrom.toMillis() > now.toMillis()) {
        continue;
      }
      if (thread.activeTo && thread.activeTo.toMillis() < now.toMillis()) {
        continue;
      }

      // Skip budget-exhausted or soft-deleted threads
      if (thread.budgetExhausted === true) continue;
      if (thread.isDeleted === true) continue;

      const targeting: TargetingCriteria | null = thread.targeting || null;
      const completedUniqueUsers = thread.completedUniqueUsers || 0;

      if (
        isUserEligibleForTargeting(userProfile, targeting, completedUniqueUsers) &&
        checkBrandInteraction(targeting, userProfile.interactedClientIds, thread.clientId)
      ) {
        eligibleThreads.push(slimThread(threadDoc.id, thread));
      }
    }

    // Sort by: pinned first, then featured, then lastActivityAt descending
    eligibleThreads.sort((a, b) => {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      if (a.isFeatured && !b.isFeatured) return -1;
      if (!a.isFeatured && b.isFeatured) return 1;
      const aTime = a.lastActivityAt?.toMillis() || 0;
      const bTime = b.lastActivityAt?.toMillis() || 0;
      return bTime - aTime;
    });

    return {
      success: true,
      threads: eligibleThreads,
      userAttributes: {
        engagementLevel: userProfile.engagementLevel,
        accountAgeDays: userProfile.accountAgeDays,
        devicePlatform: userProfile.devicePlatform,
      },
      dailyLimit: {
        completions: userCtx.dailyCompletions,
        cap: userCtx.dailyEarnCap,
        limitReached: userCtx.dailyLimitReached,
      },
    };
  }
);

/**
 * Get eligible opportunities for a specific thread
 *
 * This Cloud Function replaces direct Firestore reads for earnOpportunities.
 * It applies server-side targeting filters and returns engagement status.
 */
export const getEligibleOpportunities = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }
    requireAppCheck(context, "getEligibleOpportunities");

    const userId = context.auth.uid;
    const { threadId } = data;

    if (!threadId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "threadId is required"
      );
    }

    // ========================================================================
    // 1. Run all independent queries in parallel
    // ========================================================================
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const [threadDoc, userDoc, recentEngagementsQuery, thirtyDayEngagementsQuery, opportunitiesSnapshot, existingEngagements] =
      await Promise.all([
        db.collection("earnThreads").doc(threadId).get(),
        db.collection("users").doc(userId).get(),
        db.collection("engagements")
          .where("userId", "==", userId)
          .where("status", "==", "completed")
          .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(sevenDaysAgo))
          .count()
          .get(),
        db.collection("engagements")
          .where("userId", "==", userId)
          .where("status", "==", "completed")
          .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(thirtyDaysAgo))
          .count()
          .get(),
        db.collection("earnOpportunities")
          .where("threadId", "==", threadId)
          .where("isActive", "==", true)
          .get(),
        db.collection("engagements")
          .where("userId", "==", userId)
          .where("threadId", "==", threadId)
          .get(),
      ]);

    // Early exit if parent thread is budget-exhausted
    if (threadDoc.exists && threadDoc.data()?.budgetExhausted === true) {
      return { opportunities: [] };
    }

    if (!userDoc.exists) {
      throw new functions.https.HttpsError("not-found", "User profile not found");
    }

    const userData = userDoc.data()!;
    const userProfile = userData.profile || {};

    // Extract user attributes for targeting
    const userGender = userProfile.gender || userData.gender || null;
    const userDateOfBirth = userProfile.dateOfBirth?.toDate?.() ||
      userData.dateOfBirth?.toDate?.() ||
      null;
    const userAge = userDateOfBirth ? calculateAge(userDateOfBirth) : null;
    const userProvince = userProfile.province || userData.province || null;
    const userCity = userProfile.city || userData.city || null;
    const userLanguages: string[] = userProfile.languages || userData.languages || [];
    const userInterests: string[] = userProfile.interests || userData.interests || [];

    // Calculate account age
    const userCreatedAt = userData.createdAt?.toDate?.() || new Date();
    const accountAgeDays = Math.floor(
      (Date.now() - userCreatedAt.getTime()) / (1000 * 60 * 60 * 24)
    );

    // Get device platform from context
    const userAgent = context.rawRequest?.headers?.["user-agent"] || "";
    let devicePlatform: string | null = null;
    if (userAgent.toLowerCase().includes("android")) {
      devicePlatform = "android";
    } else if (
      userAgent.toLowerCase().includes("iphone") ||
      userAgent.toLowerCase().includes("ipad")
    ) {
      devicePlatform = "ios";
    }

    const recentCompletedEngagements = recentEngagementsQuery.data().count;
    const hasEngagementIn30Days = thirtyDayEngagementsQuery.data().count > 0;

    const userEngagementLevel = calculateEngagementLevel(
      userCreatedAt,
      recentCompletedEngagements,
      hasEngagementIn30Days
    );

    // Map opportunity ID to engagement status
    const engagementStatusMap = new Map<string, { status: string; engagementId: string }>();
    for (const engDoc of existingEngagements.docs) {
      const eng = engDoc.data();
      const oppId = eng.earnOpportunityId;
      if (oppId) {
        // Keep the most recent/relevant status
        const existing = engagementStatusMap.get(oppId);
        if (!existing || eng.status === "completed") {
          engagementStatusMap.set(oppId, {
            status: eng.status,
            engagementId: engDoc.id,
          });
        }
      }
    }

    // ========================================================================
    // 4. Filter opportunities by targeting
    // ========================================================================
    const now = admin.firestore.Timestamp.now();
    const eligibleOpportunities: admin.firestore.DocumentData[] = [];

    for (const oppDoc of opportunitiesSnapshot.docs) {
      const opp = oppDoc.data();

      // Check expiry
      if (opp.expiresAt && opp.expiresAt.toMillis() < now.toMillis()) {
        continue;
      }

      // Skip budget-exhausted opportunities
      if (opp.budgetExhausted === true) {
        continue;
      }

      // Skip soft-deleted opportunities
      if (opp.isDeleted === true) {
        continue;
      }

      // Check targeting criteria (if present)
      if (opp.targeting) {
        const targeting: TargetingCriteria = opp.targeting;
        let isEligible = true;

        // Apply same targeting logic as threads (AND with thread targeting)
        // Gender filter
        if (targeting.genders && targeting.genders.length > 0) {
          if (!userGender || !targeting.genders.includes(userGender)) {
            isEligible = false;
          }
        }

        // Age filter
        if (isEligible && targeting.ageMin !== undefined && targeting.ageMin !== null) {
          if (userAge === null || userAge < targeting.ageMin) {
            isEligible = false;
          }
        }
        if (isEligible && targeting.ageMax !== undefined && targeting.ageMax !== null) {
          if (userAge === null || userAge > targeting.ageMax) {
            isEligible = false;
          }
        }

        // Province filter
        if (isEligible && targeting.provinces && targeting.provinces.length > 0) {
          if (!userProvince || !targeting.provinces.includes(userProvince.toLowerCase())) {
            isEligible = false;
          }
        }

        // City filter
        if (isEligible && targeting.cities && targeting.cities.length > 0) {
          if (!userCity || !targeting.cities.map((c) => c.toLowerCase()).includes(userCity.toLowerCase())) {
            isEligible = false;
          }
        }

        // Language filter (ANY match)
        if (isEligible && targeting.languages && targeting.languages.length > 0) {
          const hasMatchingLanguage = userLanguages.some((l) =>
            targeting.languages!.includes(l as never)
          );
          if (!hasMatchingLanguage) {
            isEligible = false;
          }
        }

        // Interest filter (ANY match)
        if (isEligible && targeting.interests && targeting.interests.length > 0) {
          const hasMatchingInterest = userInterests.some((i) =>
            targeting.interests!.includes(i as never)
          );
          if (!hasMatchingInterest) {
            isEligible = false;
          }
        }

        // Device platform filter
        if (isEligible && targeting.devicePlatforms && targeting.devicePlatforms.length > 0) {
          if (!devicePlatform || !targeting.devicePlatforms.includes(devicePlatform as never)) {
            isEligible = false;
          }
        }

        // Account age filter
        if (isEligible && targeting.accountAgeMinDays !== undefined && targeting.accountAgeMinDays !== null) {
          if (accountAgeDays < targeting.accountAgeMinDays) {
            isEligible = false;
          }
        }
        if (isEligible && targeting.accountAgeMaxDays !== undefined && targeting.accountAgeMaxDays !== null) {
          if (accountAgeDays > targeting.accountAgeMaxDays) {
            isEligible = false;
          }
        }

        // Engagement level filter
        if (isEligible && targeting.engagementLevel && targeting.engagementLevel.length > 0) {
          if (!targeting.engagementLevel.includes(userEngagementLevel as never)) {
            isEligible = false;
          }
        }

        if (!isEligible) {
          continue;
        }
      }

      // Include opportunity with engagement status
      const engStatus = engagementStatusMap.get(oppDoc.id);
      eligibleOpportunities.push({
        id: oppDoc.id,
        ...opp,
        userEngagementStatus: engStatus?.status || null,
        userEngagementId: engStatus?.engagementId || null,
      });
    }

    // Sort by: in-progress first, completed last, then pinned, featured, tokenReward
    eligibleOpportunities.sort((a, b) => {
      // In-progress engagements first
      const aInProgress = a.userEngagementStatus === "started" || a.userEngagementStatus === "watching";
      const bInProgress = b.userEngagementStatus === "started" || b.userEngagementStatus === "watching";
      if (aInProgress && !bInProgress) return -1;
      if (!aInProgress && bInProgress) return 1;

      // Already completed last
      const aCompleted = a.userEngagementStatus === "completed";
      const bCompleted = b.userEngagementStatus === "completed";
      if (aCompleted && !bCompleted) return 1;
      if (!aCompleted && bCompleted) return -1;

      // Pinned opportunities first
      const aPinned = a.isPinned === true;
      const bPinned = b.isPinned === true;
      if (aPinned && !bPinned) return -1;
      if (!aPinned && bPinned) return 1;

      // Featured opportunities next
      const aFeatured = a.isFeatured === true;
      const bFeatured = b.isFeatured === true;
      if (aFeatured && !bFeatured) return -1;
      if (!aFeatured && bFeatured) return 1;

      // Then by token reward (highest first)
      return (b.tokenReward || 0) - (a.tokenReward || 0);
    });

    return {
      success: true,
      opportunities: eligibleOpportunities,
    };
  }
);

// ============================================================================
// ADMIN DASHBOARD FUNCTIONS
// ============================================================================

/**
 * Get targeting options for admin UI dropdowns
 * Returns available values for each targeting field
 */
export const getTargetingOptions = functions.https.onCall(
  async (data, context) => {
    await requireAdminPermission(context, "earn:getTargeting", "getTargetingOptions");

    // South African provinces
    const provinces = [
      "eastern cape",
      "free state",
      "gauteng",
      "kwazulu-natal",
      "limpopo",
      "mpumalanga",
      "north west",
      "northern cape",
      "western cape",
    ];

    // Major cities
    const cities = [
      "johannesburg",
      "cape town",
      "durban",
      "pretoria",
      "port elizabeth",
      "bloemfontein",
      "east london",
      "polokwane",
      "nelspruit",
      "kimberley",
      "pietermaritzburg",
      "rustenburg",
      "witbank",
      "vereeniging",
      "soweto",
      "benoni",
      "tembisa",
      "kempton park",
      "boksburg",
      "sandton",
    ];

    // Official South African languages
    const languages = [
      "english",
      "afrikaans",
      "zulu",
      "xhosa",
      "sotho",
      "tswana",
      "pedi",
      "venda",
      "tsonga",
      "swati",
      "ndebele",
    ];

    // Interest categories
    const interests = [
      "sports",
      "music",
      "movies",
      "gaming",
      "fashion",
      "food",
      "travel",
      "technology",
      "finance",
      "health",
      "education",
      "news",
      "social media",
      "shopping",
      "family",
      "automotive",
      "entertainment",
      "lifestyle",
    ];

    return {
      success: true,
      options: {
        genders: ["male", "female", "other"],
        provinces,
        cities,
        languages,
        interests,
        devicePlatforms: ["android", "ios"],
        engagementLevels: ["new", "casual", "active", "dormant"],
        earningTypes: EARNING_TYPES,
        previousBrandInteraction: ["include", "exclude", "any"],
      },
    };
  }
);

/**
 * Get detailed statistics for a specific client
 * Admin-only function
 */
export const getClientStats = functions.https.onCall(
  async (data, context) => {
    await requireAdminPermission(context, "earn:getClientStats", "getClientStats");

    const { clientId } = data;

    if (!clientId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "clientId is required"
      );
    }

    // Verify client exists
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (!clientDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Client not found");
    }
    const clientData = clientDoc.data()!;

    // Get thread count
    const threadsSnapshot = await db
      .collection("earnThreads")
      .where("clientId", "==", clientId)
      .get();

    const activeThreads = threadsSnapshot.docs.filter(
      (d) => d.data().isActive
    ).length;

    // Get opportunity count
    const opportunitiesSnapshot = await db
      .collection("earnOpportunities")
      .where("clientId", "==", clientId)
      .get();

    const activeOpportunities = opportunitiesSnapshot.docs.filter(
      (d) => d.data().isActive
    ).length;

    // Get engagement stats
    const allEngagementsQuery = await db
      .collection("engagements")
      .where("clientId", "==", clientId)
      .count()
      .get();

    const completedEngagementsQuery = await db
      .collection("engagements")
      .where("clientId", "==", clientId)
      .where("status", "==", "completed")
      .count()
      .get();

    // Get today's stats
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const todayStart = admin.firestore.Timestamp.fromDate(today);

    const todayEngagementsQuery = await db
      .collection("engagements")
      .where("clientId", "==", clientId)
      .where("createdAt", ">=", todayStart)
      .count()
      .get();

    const todayCompletedQuery = await db
      .collection("engagements")
      .where("clientId", "==", clientId)
      .where("status", "==", "completed")
      .where("completedAt", ">=", todayStart)
      .count()
      .get();

    // Get tokens spent (sum of all completed engagement rewards)
    const completedEngagements = await db
      .collection("engagements")
      .where("clientId", "==", clientId)
      .where("status", "==", "completed")
      .select("tokensEarned")
      .get();

    let totalTokensSpent = 0;
    for (const doc of completedEngagements.docs) {
      totalTokensSpent += doc.data().tokensEarned || 0;
    }

    // Get unique users reached
    const uniqueUsersSet = new Set<string>();
    for (const doc of completedEngagements.docs) {
      uniqueUsersSet.add(doc.data().userId);
    }

    // Get sub-account balance
    const subAccountsSnapshot = await db
      .collection("clients")
      .doc(clientId)
      .collection("subAccounts")
      .get();

    let totalBalance = 0;
    const subAccounts = [];
    for (const saDoc of subAccountsSnapshot.docs) {
      const saData = saDoc.data();
      totalBalance += saData.balance || 0;
      subAccounts.push({
        id: saDoc.id,
        name: saData.name,
        balance: saData.balance || 0,
        isActive: saData.isActive,
      });
    }

    return {
      success: true,
      client: {
        id: clientId,
        companyName: clientData.companyName,
        displayName: clientData.displayName,
        isActive: clientData.isActive,
        createdAt: clientData.createdAt,
      },
      threads: {
        total: threadsSnapshot.size,
        active: activeThreads,
      },
      opportunities: {
        total: opportunitiesSnapshot.size,
        active: activeOpportunities,
      },
      engagements: {
        total: allEngagementsQuery.data().count,
        completed: completedEngagementsQuery.data().count,
        today: todayEngagementsQuery.data().count,
        completedToday: todayCompletedQuery.data().count,
      },
      reach: {
        uniqueUsers: uniqueUsersSet.size,
        totalTokensSpent,
      },
      budget: {
        totalBalance,
        subAccounts,
      },
    };
  }
);

/**
 * Get engagement analytics for a specific thread
 * Admin-only function
 */
export const getThreadAnalytics = functions.https.onCall(
  async (data, context) => {
    await requireAdminPermission(context, "earn:getThreadAnalytics", "getThreadAnalytics");

    const { threadId, startDate, endDate } = data;

    if (!threadId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "threadId is required"
      );
    }

    // Verify thread exists
    const threadDoc = await db.collection("earnThreads").doc(threadId).get();
    if (!threadDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Thread not found");
    }
    const threadData = threadDoc.data()!;

    // Parse date range
    const startTimestamp = startDate
      ? admin.firestore.Timestamp.fromDate(new Date(startDate))
      : admin.firestore.Timestamp.fromDate(
          new Date(Date.now() - 30 * 24 * 60 * 60 * 1000) // Default: last 30 days
        );
    const endTimestamp = endDate
      ? admin.firestore.Timestamp.fromDate(new Date(endDate))
      : admin.firestore.Timestamp.now();

    // Get all opportunities for this thread
    const opportunitiesSnapshot = await db
      .collection("earnOpportunities")
      .where("threadId", "==", threadId)
      .get();

    const opportunityStats: Array<{
      id: string;
      title: string;
      earningType: string;
      tokenReward: number;
      isActive: boolean;
      engagements: number;
      completed: number;
      completionRate: number;
    }> = [];

    // Get engagements for each opportunity
    for (const oppDoc of opportunitiesSnapshot.docs) {
      const opp = oppDoc.data();

      const engagementsQuery = await db
        .collection("engagements")
        .where("earnOpportunityId", "==", oppDoc.id)
        .where("createdAt", ">=", startTimestamp)
        .where("createdAt", "<=", endTimestamp)
        .count()
        .get();

      const completedQuery = await db
        .collection("engagements")
        .where("earnOpportunityId", "==", oppDoc.id)
        .where("status", "==", "completed")
        .where("completedAt", ">=", startTimestamp)
        .where("completedAt", "<=", endTimestamp)
        .count()
        .get();

      const total = engagementsQuery.data().count;
      const completed = completedQuery.data().count;

      opportunityStats.push({
        id: oppDoc.id,
        title: opp.title,
        earningType: opp.earningType,
        tokenReward: opp.tokenReward,
        isActive: opp.isActive,
        engagements: total,
        completed,
        completionRate: total > 0 ? Math.round((completed / total) * 100) : 0,
      });
    }

    // Get overall thread stats
    const threadEngagementsQuery = await db
      .collection("engagements")
      .where("threadId", "==", threadId)
      .where("createdAt", ">=", startTimestamp)
      .where("createdAt", "<=", endTimestamp)
      .count()
      .get();

    const threadCompletedQuery = await db
      .collection("engagements")
      .where("threadId", "==", threadId)
      .where("status", "==", "completed")
      .where("completedAt", ">=", startTimestamp)
      .where("completedAt", "<=", endTimestamp)
      .count()
      .get();

    // Get daily breakdown (last 7 days)
    const dailyStats: Array<{ date: string; engagements: number; completed: number }> = [];
    for (let i = 6; i >= 0; i--) {
      const dayStart = new Date();
      dayStart.setDate(dayStart.getDate() - i);
      dayStart.setHours(0, 0, 0, 0);

      const dayEnd = new Date(dayStart);
      dayEnd.setHours(23, 59, 59, 999);

      const dayEngagements = await db
        .collection("engagements")
        .where("threadId", "==", threadId)
        .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(dayStart))
        .where("createdAt", "<=", admin.firestore.Timestamp.fromDate(dayEnd))
        .count()
        .get();

      const dayCompleted = await db
        .collection("engagements")
        .where("threadId", "==", threadId)
        .where("status", "==", "completed")
        .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(dayStart))
        .where("completedAt", "<=", admin.firestore.Timestamp.fromDate(dayEnd))
        .count()
        .get();

      dailyStats.push({
        date: dayStart.toISOString().split("T")[0],
        engagements: dayEngagements.data().count,
        completed: dayCompleted.data().count,
      });
    }

    // Calculate totals from opportunity stats
    const totalEngagements = threadEngagementsQuery.data().count;
    const totalCompleted = threadCompletedQuery.data().count;

    return {
      success: true,
      thread: {
        id: threadId,
        title: threadData.title,
        clientId: threadData.clientId,
        clientName: threadData.clientName,
        isActive: threadData.isActive,
        createdAt: threadData.createdAt,
        availableOpportunities: threadData.availableOpportunities,
        completedOpportunities: threadData.completedOpportunities,
        completedUniqueUsers: threadData.completedUniqueUsers || 0,
      },
      dateRange: {
        start: startTimestamp.toDate().toISOString(),
        end: endTimestamp.toDate().toISOString(),
      },
      summary: {
        totalEngagements,
        totalCompleted,
        completionRate:
          totalEngagements > 0
            ? Math.round((totalCompleted / totalEngagements) * 100)
            : 0,
        opportunityCount: opportunitiesSnapshot.size,
        activeOpportunities: opportunitiesSnapshot.docs.filter(
          (d) => d.data().isActive
        ).length,
      },
      opportunities: opportunityStats,
      dailyStats,
    };
  }
);

// ============================================================================
// STATISTICS
// ============================================================================

/**
 * Get earn statistics
 * Returns counts and stats for admin dashboard
 */
export const getEarnStatistics = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated"
      );
    }
    requireAppCheck(context, "getEarnStatistics");

    // Get total threads
    const threadsCount = await db
      .collection("earnThreads")
      .where("isActive", "==", true)
      .count()
      .get();

    // Get total active opportunities
    const opportunitiesCount = await db
      .collection("earnOpportunities")
      .where("isActive", "==", true)
      .count()
      .get();

    // Get today's engagements
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const todayStart = admin.firestore.Timestamp.fromDate(today);

    const todayEngagements = await db
      .collection("engagements")
      .where("createdAt", ">=", todayStart)
      .count()
      .get();

    const completedToday = await db
      .collection("engagements")
      .where("completedAt", ">=", todayStart)
      .where("status", "==", "completed")
      .count()
      .get();

    // Get total clients
    const clientsCount = await db
      .collection("clients")
      .where("isActive", "==", true)
      .count()
      .get();

    return {
      activeThreads: threadsCount.data().count,
      activeOpportunities: opportunitiesCount.data().count,
      engagementsToday: todayEngagements.data().count,
      completedToday: completedToday.data().count,
      activeClients: clientsCount.data().count,
    };
  }
);

// ============================================================================
// SOFT-DELETE FUNCTIONS
// ============================================================================

/**
 * Soft-delete a single earn opportunity.
 * Sets isDeleted: true and decrements parent thread's availableOpportunities if active.
 */
export const adminSoftDeleteOpportunity = functions.https.onCall(
  async (data: { opportunityId: string }, context) => {
    requireAppCheck(context, "adminSoftDeleteOpportunity");
    const adminCtx = await requireAdminPermission(context, "earn:deleteOpportunity", "adminSoftDeleteOpportunity");

    const { opportunityId } = data;
    if (!opportunityId) {
      throw new functions.https.HttpsError("invalid-argument", "opportunityId is required");
    }

    const oppRef = db.collection("earnOpportunities").doc(opportunityId);
    const oppDoc = await oppRef.get();

    if (!oppDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Opportunity not found");
    }

    const opp = oppDoc.data()!;
    if (opp.isDeleted === true) {
      throw new functions.https.HttpsError("failed-precondition", "Opportunity is already deleted");
    }

    const now = admin.firestore.FieldValue.serverTimestamp();

    // Mark opportunity as deleted
    await oppRef.update({
      isDeleted: true,
      isActive: false,
      deletedAt: now,
      deletedBy: context.auth!.uid,
      updatedAt: now,
    });

    // Decrement parent thread's availableOpportunities if opportunity was active
    if (opp.isActive && opp.threadId) {
      await db.collection("earnThreads").doc(opp.threadId).update({
        availableOpportunities: admin.firestore.FieldValue.increment(-1),
        updatedAt: now,
      });
    }

    logAdminAction(adminCtx.uid, "adminSoftDeleteOpportunity", "success", { opportunityId, threadId: opp.threadId }).catch(() => {});

    return { success: true };
  }
);

/**
 * Soft-delete an earn thread and all its opportunities.
 * Cascades deletion to all child opportunities.
 */
export const adminSoftDeleteThread = functions.https.onCall(
  async (data: { threadId: string }, context) => {
    requireAppCheck(context, "adminSoftDeleteThread");
    const adminCtx = await requireAdminPermission(context, "earn:deleteThread", "adminSoftDeleteThread");

    const { threadId } = data;
    if (!threadId) {
      throw new functions.https.HttpsError("invalid-argument", "threadId is required");
    }

    const threadRef = db.collection("earnThreads").doc(threadId);
    const threadDoc = await threadRef.get();

    if (!threadDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Thread not found");
    }

    const thread = threadDoc.data()!;
    if (thread.isDeleted === true) {
      throw new functions.https.HttpsError("failed-precondition", "Thread is already deleted");
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const uid = context.auth!.uid;

    // Cascade: soft-delete all opportunities in this thread
    const oppsSnapshot = await db
      .collection("earnOpportunities")
      .where("threadId", "==", threadId)
      .get();

    let deletedOpportunities = 0;
    if (!oppsSnapshot.empty) {
      const batch = db.batch();
      for (const oppDoc of oppsSnapshot.docs) {
        if (oppDoc.data().isDeleted !== true) {
          batch.update(oppDoc.ref, {
            isDeleted: true,
            isActive: false,
            deletedAt: now,
            deletedBy: uid,
            updatedAt: now,
          });
          deletedOpportunities++;
        }
      }
      await batch.commit();
    }

    // Mark thread as deleted
    await threadRef.update({
      isDeleted: true,
      isActive: false,
      deletedAt: now,
      deletedBy: uid,
      updatedAt: now,
    });

    // Decrement client's activeCampaigns if thread was active
    if (thread.isActive && thread.clientId) {
      await db.collection("clients").doc(thread.clientId).update({
        activeCampaigns: admin.firestore.FieldValue.increment(-1),
        updatedAt: now,
      });
    }

    logAdminAction(adminCtx.uid, "adminSoftDeleteThread", "success", { threadId, clientId: thread.clientId, deletedOpportunities }).catch(() => {});

    return { success: true, deletedOpportunities };
  }
);

// ============================================================================
// CLEANUP ORPHANED THREADS/OPPORTUNITIES
// ============================================================================

/**
 * One-off admin cleanup: find threads whose parent client is deleted/missing
 * and cascade soft-delete to them and their opportunities.
 */
export const adminCleanupOrphanedThreads = functions.https.onCall(
  async (_data: unknown, context) => {
    requireAppCheck(context, "adminCleanupOrphanedThreads");
    const adminCtx = await requireAdminPermission(context, "earn:cleanupOrphaned", "adminCleanupOrphanedThreads");

    const now = admin.firestore.FieldValue.serverTimestamp();
    const uid = context.auth!.uid;

    // Get all non-deleted threads
    const threadsSnapshot = await db
      .collection("earnThreads")
      .where("isDeleted", "!=", true)
      .get();

    let orphanedThreads = 0;
    let orphanedOpportunities = 0;

    for (const threadDoc of threadsSnapshot.docs) {
      const thread = threadDoc.data();
      if (!thread.clientId) continue;

      // Check if parent client exists and is not deleted
      const clientDoc = await db.collection("clients").doc(thread.clientId).get();
      const clientDeleted = !clientDoc.exists || clientDoc.data()?.isDeleted === true;

      if (!clientDeleted) continue;

      // Cascade soft-delete opportunities
      const oppsSnapshot = await db
        .collection("earnOpportunities")
        .where("threadId", "==", threadDoc.id)
        .get();

      if (!oppsSnapshot.empty) {
        const batch = db.batch();
        for (const oppDoc of oppsSnapshot.docs) {
          if (oppDoc.data().isDeleted !== true) {
            batch.update(oppDoc.ref, {
              isDeleted: true,
              isActive: false,
              deletedAt: now,
              deletedBy: uid,
              deletionReason: "orphaned: parent client deleted",
              updatedAt: now,
            });
            orphanedOpportunities++;
          }
        }
        await batch.commit();
      }

      // Soft-delete the thread
      await threadDoc.ref.update({
        isDeleted: true,
        isActive: false,
        deletedAt: now,
        deletedBy: uid,
        deletionReason: "orphaned: parent client deleted",
        updatedAt: now,
      });
      orphanedThreads++;
    }

    logAdminAction(adminCtx.uid, "adminCleanupOrphanedThreads", "success", { orphanedThreads, orphanedOpportunities }).catch(() => {});

    return { success: true, orphanedThreads, orphanedOpportunities };
  }
);

// ============================================================================
// EARN INBOX — Client-grouped thread listing
// ============================================================================

/**
 * Get eligible inbox for the current user, grouped by client.
 *
 * Returns clients sorted by pinned → featured → alphabetical, each containing
 * their eligible threads with aggregated opportunity data.
 */
export const getEligibleInbox = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "getEligibleInbox");

    const userCtx = await buildUserTargetingContext(context);
    const { profile: userProfile } = userCtx;

    // ========================================================================
    // 1. Get all active threads, apply targeting
    // ========================================================================
    const now = admin.firestore.Timestamp.now();

    const threadsSnapshot = await db
      .collection("earnThreads")
      .where("isActive", "==", true)
      .get();

    // Eligible threads grouped by clientId
    const threadsByClient = new Map<
      string,
      { thread: admin.firestore.DocumentData; id: string }[]
    >();

    for (const threadDoc of threadsSnapshot.docs) {
      const thread = threadDoc.data();

      // Scheduling constraints
      if (thread.activeFrom && thread.activeFrom.toMillis() > now.toMillis()) continue;
      if (thread.activeTo && thread.activeTo.toMillis() < now.toMillis()) continue;
      if (thread.budgetExhausted === true) continue;
      if (thread.isDeleted === true) continue;

      const targeting: TargetingCriteria | null = thread.targeting || null;
      const completedUniqueUsers = thread.completedUniqueUsers || 0;

      if (
        !isUserEligibleForTargeting(userProfile, targeting, completedUniqueUsers) ||
        !checkBrandInteraction(targeting, userProfile.interactedClientIds, thread.clientId)
      ) {
        continue;
      }

      const clientId = thread.clientId as string;
      if (!threadsByClient.has(clientId)) {
        threadsByClient.set(clientId, []);
      }
      threadsByClient.get(clientId)!.push({ thread, id: threadDoc.id });
    }

    if (threadsByClient.size === 0) {
      return {
        success: true,
        clients: [],
        dailyLimit: {
          completions: userCtx.dailyCompletions,
          cap: userCtx.dailyEarnCap,
          limitReached: userCtx.dailyLimitReached,
        },
      };
    }

    // ========================================================================
    // 2. Batch-read client docs for isPinned/isFeatured
    // ========================================================================
    const clientIds = Array.from(threadsByClient.keys());
    const clientRefs = clientIds.map((id) => db.collection("clients").doc(id));
    const clientDocs = await db.getAll(...clientRefs);

    const clientDataMap = new Map<string, admin.firestore.DocumentData>();
    for (const doc of clientDocs) {
      if (doc.exists) {
        clientDataMap.set(doc.id, doc.data()!);
      }
    }

    // ========================================================================
    // 3. For each client's threads, fetch active opportunities (batch)
    // ========================================================================
    const allThreadIds = Array.from(threadsByClient.values())
      .flat()
      .map((t) => t.id);

    // Firestore `in` queries support max 30 items; batch if needed
    const oppsByThread = new Map<string, admin.firestore.DocumentData[]>();
    for (let i = 0; i < allThreadIds.length; i += 30) {
      const batch = allThreadIds.slice(i, i + 30);
      const oppsSnapshot = await db
        .collection("earnOpportunities")
        .where("threadId", "in", batch)
        .where("isActive", "==", true)
        .get();

      for (const oppDoc of oppsSnapshot.docs) {
        const opp = oppDoc.data();
        if (opp.isDeleted === true) continue;
        // Check opp-level expiry
        if (opp.expiresAt && opp.expiresAt.toMillis() < now.toMillis()) continue;
        if (opp.budgetExhausted === true) continue;

        const tid = opp.threadId as string;
        if (!oppsByThread.has(tid)) {
          oppsByThread.set(tid, []);
        }
        oppsByThread.get(tid)!.push({ ...opp, _id: oppDoc.id });
      }
    }

    // ========================================================================
    // 3b. Batch-query user's completed engagements for these opportunities
    // ========================================================================
    const allOppIds = Array.from(oppsByThread.values())
      .flat()
      .map((o) => (o as Record<string, unknown>)._id as string)
      .filter(Boolean);

    const completedOppIds = new Set<string>();
    const userId = context.auth!.uid;

    for (let i = 0; i < allOppIds.length; i += 30) {
      const batch = allOppIds.slice(i, i + 30);
      const engSnap = await db
        .collection("engagements")
        .where("userId", "==", userId)
        .where("earnOpportunityId", "in", batch)
        .where("status", "==", "completed")
        .get();

      for (const doc of engSnap.docs) {
        completedOppIds.add(doc.data().earnOpportunityId);
      }
    }

    // ========================================================================
    // 4. Build client response objects
    // ========================================================================
    const clientResults: Record<string, unknown>[] = [];

    for (const [clientId, threadEntries] of threadsByClient.entries()) {
      const clientDoc = clientDataMap.get(clientId);
      // Use first thread for fallback client display info
      const firstThread = threadEntries[0].thread;

      const clientName = clientDoc?.displayName || clientDoc?.companyName ||
        firstThread.clientName || "Unknown";
      const clientAvatarImage = clientDoc?.avatarImage || firstThread.clientAvatarImage || null;
      const clientAvatarColor = clientDoc?.avatarColor || firstThread.clientAvatarColor || null;
      const clientIsPinned = clientDoc?.isPinned === true;
      const clientIsFeatured = clientDoc?.isFeatured === true;

      // Build thread objects with aggregated opp data
      const threads: Record<string, unknown>[] = [];

      for (const { thread, id: threadId } of threadEntries) {
        const opps = oppsByThread.get(threadId) || [];

        // Aggregate opportunity data
        const totalTokenReward = opps.reduce(
          (sum, o) => sum + (o.tokenReward || 0), 0
        );
        const rewardTypesSet = new Set<string>();
        const earningTypesSet = new Set<string>();
        const opportunityIds: string[] = [];
        let hasRewardCampaign = false;
        let soonestExpiry: admin.firestore.Timestamp | null = null;
        let totalDurationSeconds = 0;

        let completedByUser = 0;

        for (const opp of opps) {
          const oppId = opp._id || '';
          opportunityIds.push(oppId);
          if (completedOppIds.has(oppId)) completedByUser++;
          if (opp.rewardType) rewardTypesSet.add(opp.rewardType);
          if (opp.earningType) earningTypesSet.add(opp.earningType);
          totalDurationSeconds += (opp.durationSeconds || 0);
          if (opp.rewardCampaignId) hasRewardCampaign = true;
          if (opp.expiresAt) {
            if (!soonestExpiry || opp.expiresAt.toMillis() < soonestExpiry.toMillis()) {
              soonestExpiry = opp.expiresAt;
            }
          }
        }

        // Also consider thread-level activeTo as an expiry
        if (thread.activeTo) {
          if (!soonestExpiry || thread.activeTo.toMillis() < soonestExpiry.toMillis()) {
            soonestExpiry = thread.activeTo;
          }
        }

        threads.push({
          id: threadId,
          title: thread.title,
          description: thread.description || null,
          threadImage: thread.threadImage || null,
          isPinned: thread.isPinned ?? false,
          isFeatured: thread.isFeatured ?? false,
          activeTo: thread.activeTo || null,
          availableOpportunities: opps.length,
          completedByUser,
          totalTokenReward,
          rewardTypes: Array.from(rewardTypesSet),
          earningTypes: Array.from(earningTypesSet),
          estimatedDurationSeconds: totalDurationSeconds,
          opportunityIds,
          hasRewardCampaign,
          soonestExpiry,
        });
      }

      // Sort threads: pinned first (alpha) → featured (alpha) →
      // has-expiry by soonest → no-expiry (alpha)
      threads.sort((a, b) => {
        // Pinned first
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        // Featured second
        if (a.isFeatured && !b.isFeatured) return -1;
        if (!a.isFeatured && b.isFeatured) return 1;
        // Among remaining: expiry-based, then alphabetical
        const aExpiry = a.soonestExpiry as admin.firestore.Timestamp | null;
        const bExpiry = b.soonestExpiry as admin.firestore.Timestamp | null;
        if (aExpiry && !bExpiry) return -1;
        if (!aExpiry && bExpiry) return 1;
        if (aExpiry && bExpiry) {
          return aExpiry.toMillis() - bExpiry.toMillis();
        }
        return (a.title as string).localeCompare(b.title as string);
      });

      clientResults.push({
        clientId,
        clientName,
        clientAvatarImage,
        clientAvatarColor,
        isPinned: clientIsPinned,
        isFeatured: clientIsFeatured,
        activeThreadCount: threads.length,
        threads,
      });
    }

    // Sort clients: pinned first (alpha) → featured (alpha) → rest (alpha)
    clientResults.sort((a, b) => {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      if (a.isFeatured && !b.isFeatured) return -1;
      if (!a.isFeatured && b.isFeatured) return 1;
      return (a.clientName as string).localeCompare(b.clientName as string);
    });

    return {
      success: true,
      clients: clientResults,
      dailyLimit: {
        completions: userCtx.dailyCompletions,
        cap: userCtx.dailyEarnCap,
        limitReached: userCtx.dailyLimitReached,
      },
    };
  }
);
