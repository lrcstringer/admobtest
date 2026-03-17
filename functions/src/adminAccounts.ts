/**
 * Admin Account Management Functions
 *
 * Cloud Functions for managing supplier and client (brand partner) accounts.
 * These functions require admin authentication.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import {
  createSupplierAccount,
  createClientAccount,
  getAccountsByType,
  freezeAccount,
  unfreezeAccount,
  getAccount,
  getBalance,
  closeAccount,
  createAccount,
} from "./ledger/accounts";
import { postJournal, getRecentJournals } from "./ledger/journals";
import { AccountId, SystemAccounts, LedgerConfig, AccountTypeRules } from "./ledger/types";
import { processClientSubAccountFunding } from "./ledger/index";
import {
  getUserSubAccounts,
  createAccountType,
  listAccountTypes,
  getAccountType,
  updateAccountType,
  deactivateAccountType,
} from "./ledger/subAccounts";
import {
  reconcileAllAccounts,
  verifySystemBalance,
  verifyAllJournalsBalanced,
  getLedgerStatistics,
} from "./ledger/reconciliation";
import { requireAppCheck } from "./security";
import { requireAdminPermission, createPendingAction, logAdminAction } from "./adminAuth";

const db = admin.firestore();



// ============================================================================
// SUPPLIER ACCOUNT MANAGEMENT
// ============================================================================

/**
 * Create a new supplier account
 */
export const adminCreateSupplier = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminCreateSupplier");
  const adminCtx = await requireAdminPermission(request, "accounts:createSupplier", "adminCreateSupplier");

  const { providerId, providerName, category, contactEmail, contactName } = request.data as {
    providerId: string;
    providerName: string;
    category?: string;
    contactEmail?: string;
    contactName?: string;
  };

  if (!providerId || !providerName) {
    throw new HttpsError(
      "invalid-argument",
      "Provider ID and name are required"
    );
  }

  // Create ledger account
  const account = await createSupplierAccount(providerId, providerName);

  // Create/update supplier profile document
  await db.collection("suppliers").doc(providerId).set(
    {
      id: providerId,
      name: providerName,
      category: category || "general",
      contactEmail: contactEmail || null,
      contactName: contactName || null,
      ledgerAccountId: account.id,
      status: "active",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      createdBy: request.auth!.uid,
    },
    { merge: true }
  );

  logAdminAction(adminCtx.uid, "adminCreateSupplier", "success", { providerId, providerName, ledgerAccountId: account.id }).catch(() => {});

  return {
    success: true,
    supplier: {
      id: providerId,
      name: providerName,
      ledgerAccountId: account.id,
    },
  };
});

/**
 * List all supplier accounts
 */
export const adminListSuppliers = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminListSuppliers");
  await requireAdminPermission(request, "accounts:listSuppliers", "adminListSuppliers");

  // Get ledger accounts
  const accounts = await getAccountsByType("supplier");

  // Get supplier profiles
  const supplierDocs = await db.collection("suppliers").get();
  const profiles = new Map<string, FirebaseFirestore.DocumentData>();
  supplierDocs.forEach((doc) => {
    profiles.set(doc.id, doc.data());
  });

  // Merge data
  const suppliers = accounts.map((account) => {
    const supplierId = AccountId.parseSupplierId(account.id);
    const profile = supplierId ? profiles.get(supplierId) : null;

    return {
      id: supplierId,
      ledgerAccountId: account.id,
      name: account.name,
      balance: account.balance,
      status: account.status,
      category: profile?.category || "general",
      contactEmail: profile?.contactEmail,
      contactName: profile?.contactName,
      createdAt: account.createdAt,
    };
  });

  return { suppliers };
});

/**
 * Update supplier status (freeze/unfreeze)
 */
export const adminUpdateSupplierStatus = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminUpdateSupplierStatus");
  const adminCtx = await requireAdminPermission(request, "accounts:updateSupplierStatus", "adminUpdateSupplierStatus");

  const { providerId, action, reason } = request.data as {
    providerId: string;
    action: "freeze" | "unfreeze";
    reason: string;
  };
  const accountId = AccountId.supplier(providerId);

  const result =
    action === "freeze"
      ? await freezeAccount(accountId, reason, request.auth!.uid)
      : await unfreezeAccount(accountId, reason, request.auth!.uid);

  if (!result.success) {
    throw new HttpsError("internal", result.error || "Failed to update status");
  }

  // Update supplier profile
  await db.collection("suppliers").doc(providerId).update({
    status: action === "freeze" ? "frozen" : "active",
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  logAdminAction(adminCtx.uid, "adminUpdateSupplierStatus", "success", { providerId, action, reason }).catch(() => {});

  return { success: true };
});

// ============================================================================
// CLIENT (BRAND PARTNER) ACCOUNT MANAGEMENT
// ============================================================================

/**
 * Create a new client (brand partner) account
 */
export const adminCreateClient = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminCreateClient");
  const adminCtx = await requireAdminPermission(request, "accounts:createClient", "adminCreateClient");

  const {
    clientId,
    companyName,
    contactEmail,
    contactName,
    companyRegistration,
    industry,
    billingAddress,
    vatNumber,
    displayName,
    avatarImage,
    avatarColor,
    brandAccountTypeId,
    budgetWarningThreshold,
    isRewardSponsor,
    rewardWebhookSecret,
    rewardMetadata,
    isPinned,
    isFeatured,
    isBrandMessagingEnabled,
  } = request.data as {
    clientId: string;
    companyName: string;
    contactEmail: string;
    contactName: string;
    companyRegistration?: string;
    industry?: string;
    billingAddress?: string;
    vatNumber?: string;
    displayName?: string;
    avatarImage?: string;
    avatarColor?: string;
    brandAccountTypeId?: string;
    budgetWarningThreshold?: number;
    isRewardSponsor?: boolean;
    rewardWebhookSecret?: string;
    rewardMetadata?: Record<string, unknown>;
    isPinned?: boolean;
    isFeatured?: boolean;
    isBrandMessagingEnabled?: boolean;
  };

  if (!clientId || !companyName || !contactEmail || !contactName) {
    throw new HttpsError(
      "invalid-argument",
      "Client ID, company name, contact email, and contact name are required"
    );
  }

  // Guard: reject if a client doc with this ID already exists (including soft-deleted)
  const existingClient = await db.collection("clients").doc(clientId).get();
  if (existingClient.exists) {
    const wasDeleted = existingClient.data()?.isDeleted === true;
    throw new HttpsError(
      "already-exists",
      wasDeleted
        ? "A client with this ID was previously deleted. Use a different ID."
        : "A client with this ID already exists"
    );
  }

  // Create ledger account
  const account = await createClientAccount(clientId, companyName, {
    contactEmail,
    contactName,
    companyRegistration,
    industry,
  });

  // Create client profile document
  await db.collection("clients").doc(clientId).set({
    id: clientId,
    companyName,
    contactEmail,
    contactName,
    companyRegistration: companyRegistration || null,
    industry: industry || null,
    billingAddress: billingAddress || null,
    vatNumber: vatNumber || null,
    ledgerAccountId: account.id,
    status: "active",
    isActive: true,
    // Earn-specific fields
    displayName: displayName || companyName,
    avatarImage: avatarImage || null,
    avatarColor: avatarColor || null,
    brandAccountTypeId: brandAccountTypeId || null,
    budgetWarningThreshold: budgetWarningThreshold ?? 0.20,
    // Reward sponsor fields
    isRewardSponsor: isRewardSponsor ?? false,
    rewardWebhookSecret: rewardWebhookSecret || null,
    rewardMetadata: rewardMetadata || {},
    // Inbox display flags
    isPinned: isPinned ?? false,
    isFeatured: isFeatured ?? false,
    // Brand messaging opt-in (discoverable in contacts)
    isBrandMessagingEnabled: isBrandMessagingEnabled ?? true,
    // Campaign stats
    totalCampaigns: 0,
    activeCampaigns: 0,
    totalSpent: 0,
    totalImpressions: 0,
    totalEngagements: 0,
    // Timestamps
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    createdBy: request.auth!.uid,
  });

  logAdminAction(adminCtx.uid, "adminCreateClient", "success", { clientId, companyName, ledgerAccountId: account.id }).catch(() => {});

  return {
    success: true,
    client: {
      id: clientId,
      companyName,
      displayName: displayName || companyName,
      ledgerAccountId: account.id,
    },
  };
});

/**
 * List all client (brand partner) accounts
 */
export const adminListClients = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminListClients");
  await requireAdminPermission(request, "accounts:listClients", "adminListClients");

  const { pageSize = 100, startAfterId } = request.data || {};

  // Get ledger accounts
  const accounts = await getAccountsByType("client");

  // Get client profiles with pagination
  let query = db.collection("clients")
    .orderBy("createdAt", "desc")
    .limit(pageSize);
  if (startAfterId) {
    const startAfterDoc = await db.collection("clients").doc(startAfterId).get();
    if (startAfterDoc.exists) {
      query = query.startAfter(startAfterDoc);
    }
  }
  const clientDocs = await query.get();
  const profiles = new Map<string, FirebaseFirestore.DocumentData>();
  clientDocs.forEach((doc) => {
    profiles.set(doc.id, doc.data());
  });

  // Merge data, skip deleted clients
  const clients = accounts
    .map((account) => {
      const clientId = AccountId.parseClientId(account.id);
      const profile = clientId ? profiles.get(clientId) : null;

      // Skip deleted clients
      if (profile?.isDeleted === true) return null;

      return {
        id: clientId,
        ledgerAccountId: account.id,
        companyName: account.name,
        balance: account.balance,
        status: account.status,
        isDeleted: profile?.isDeleted || false,
        contactEmail: profile?.contactEmail,
        contactName: profile?.contactName,
        displayName: profile?.displayName,
        avatarImage: profile?.avatarImage,
        avatarColor: profile?.avatarColor,
        industry: profile?.industry,
        companyRegistration: profile?.companyRegistration || null,
        vatNumber: profile?.vatNumber || null,
        billingAddress: profile?.billingAddress || null,
        budgetWarningThreshold: profile?.budgetWarningThreshold ?? 0.20,
        brandAccountTypeId: profile?.brandAccountTypeId || null,
        totalCampaigns: profile?.totalCampaigns || 0,
        activeCampaigns: profile?.activeCampaigns || 0,
        totalSpent: profile?.totalSpent || 0,
        isRewardSponsor: profile?.isRewardSponsor || false,
        createdAt: account.createdAt,
      };
    })
    .filter((c) => c !== null);

  return { clients };
});

/**
 * Get client details
 */
export const adminGetClient = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminGetClient");
  await requireAdminPermission(request, "accounts:getClient", "adminGetClient");

  const { clientId } = request.data as { clientId: string };
  const accountId = AccountId.client(clientId);

  const account = await getAccount(accountId);
  if (!account) {
    throw new HttpsError("not-found", "Client not found");
  }

  const profileDoc = await db.collection("clients").doc(clientId).get();
  const profile = profileDoc.data();

  return {
    client: {
      id: clientId,
      ledgerAccountId: account.id,
      companyName: account.name,
      balance: account.balance,
      status: account.status,
      ...profile,
    },
  };
});

/**
 * Update client status (freeze/unfreeze)
 */
export const adminUpdateClientStatus = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminUpdateClientStatus");
  const adminCtx = await requireAdminPermission(request, "accounts:updateClientStatus", "adminUpdateClientStatus");

  const { clientId, action, reason } = request.data as {
    clientId: string;
    action: "freeze" | "unfreeze";
    reason: string;
  };
  const accountId = AccountId.client(clientId);

  const result =
    action === "freeze"
      ? await freezeAccount(accountId, reason, request.auth!.uid)
      : await unfreezeAccount(accountId, reason, request.auth!.uid);

  if (!result.success) {
    throw new HttpsError("internal", result.error || "Failed to update status");
  }

  // Update client profile
  await db.collection("clients").doc(clientId).update({
    status: action === "freeze" ? "frozen" : "active",
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  logAdminAction(adminCtx.uid, "adminUpdateClientStatus", "success", { clientId, action, reason }).catch(() => {});

  return { success: true };
});

/**
 * Update client profile
 */
export const adminUpdateClient = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminUpdateClient");
  const adminCtx = await requireAdminPermission(request, "accounts:updateClient", "adminUpdateClient");

  const { clientId, updates } = request.data as {
    clientId: string;
    updates: {
      companyName?: string;
      contactEmail?: string;
      contactName?: string;
      industry?: string;
      billingAddress?: string;
      vatNumber?: string;
      displayName?: string;
      avatarImage?: string;
      avatarColor?: string;
      brandAccountTypeId?: string;
      budgetWarningThreshold?: number;
      isRewardSponsor?: boolean;
      rewardWebhookSecret?: string;
      rewardMetadata?: Record<string, unknown>;
      sponsorUserId?: string;
      isPinned?: boolean;
      isFeatured?: boolean;
      isBrandMessagingEnabled?: boolean;
    };
  };

  // Validate client exists
  const accountId = AccountId.client(clientId);
  const account = await getAccount(accountId);
  if (!account) {
    throw new HttpsError("not-found", "Client not found");
  }

  // If sponsorUserId is provided, set custom claim so the user can access
  // their own campaign reports via getSponsorCampaignReport
  if (updates.sponsorUserId) {
    try {
      await admin.auth().setCustomUserClaims(updates.sponsorUserId, {
        ...(
          await admin.auth().getUser(updates.sponsorUserId)
        ).customClaims,
        sponsorClientId: clientId,
      });
    } catch (claimErr) {
      logger.warn("Failed to set sponsor claim", {
        userId: updates.sponsorUserId,
        error: claimErr,
      });
      throw new HttpsError(
        "not-found",
        "Sponsor user not found in Firebase Auth"
      );
    }
  }

  // Remove sponsorUserId from Firestore updates (it's an Auth claim, not a profile field)
  const { sponsorUserId: _unused, ...profileUpdates } = updates;

  // Update profile
  await db.collection("clients").doc(clientId).update({
    ...profileUpdates,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update ledger account name if company name changed
  if (updates.companyName) {
    await db.collection("ledgerAccounts").doc(accountId).update({
      name: updates.companyName,
      updatedAt: admin.firestore.Timestamp.now(),
    });
  }

  // Denormalization cascade: update earnThreads if display fields changed
  if (updates.displayName || updates.avatarImage || updates.avatarColor) {
    const threadsSnapshot = await db
      .collection("earnThreads")
      .where("clientId", "==", clientId)
      .get();

    if (!threadsSnapshot.empty) {
      const batch = db.batch();
      const threadUpdates: Record<string, unknown> = {
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      if (updates.displayName !== undefined) {
        threadUpdates.clientName = updates.displayName;
      }
      if (updates.avatarImage !== undefined) {
        threadUpdates.clientAvatarImage = updates.avatarImage;
      }
      if (updates.avatarColor !== undefined) {
        threadUpdates.clientAvatarColor = updates.avatarColor;
      }

      for (const doc of threadsSnapshot.docs) {
        batch.update(doc.ref, threadUpdates);
      }
      await batch.commit();
    }

    // Also cascade to rewardCampaigns linked to this client
    const campaignsSnapshot = await db
      .collection("rewardCampaigns")
      .where("clientId", "==", clientId)
      .where("isDeleted", "==", false)
      .get();

    if (!campaignsSnapshot.empty) {
      const campaignBatch = db.batch();
      const campaignUpdates: Record<string, unknown> = {
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      };
      if (updates.displayName !== undefined) {
        campaignUpdates.clientName = updates.displayName;
      }
      if (updates.avatarImage !== undefined) {
        campaignUpdates.clientAvatarImage = updates.avatarImage;
      }
      if (updates.avatarColor !== undefined) {
        campaignUpdates.clientAvatarColor = updates.avatarColor;
      }

      for (const doc of campaignsSnapshot.docs) {
        campaignBatch.update(doc.ref, campaignUpdates);
      }
      await campaignBatch.commit();
    }
  }

  logAdminAction(adminCtx.uid, "adminUpdateClient", "success", { clientId, updatedFields: Object.keys(updates) }).catch(() => {});

  return { success: true };
});

/**
 * Fund a client account (admin adds tokens to client's balance)
 *
 * Posts journal: DR cbook CR client:{clientId}
 * This IS the token creation/seeding mechanism — because cbook is an asset account
 * (debit-normal), the debit INCREASES cbook balance while the credit INCREASES
 * client balance. Both sides go up. No separate seeding step needed.
 *
 * Uses cbook:bus for iMaliChat's own account, cbook:trust for external clients.
 */
export const adminFundClientAccount = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminFundClientAccount");
  const adminCtx = await requireAdminPermission(request, "accounts:fundClient", "adminFundClientAccount");

  const { clientId, amount, reference, paymentMethod } = request.data as {
    clientId: string;
    amount: number;
    reference: string;
    paymentMethod?: string;
  };

  if (!clientId || !amount || amount <= 0 || !reference) {
    throw new HttpsError(
      "invalid-argument",
      "Client ID, positive amount, and reference are required"
    );
  }

  // Guard: cannot fund a deleted client
  const clientDoc = await db.collection("clients").doc(clientId).get();
  if (clientDoc.data()?.isDeleted === true) {
    throw new HttpsError(
      "failed-precondition",
      "Cannot fund a deleted client"
    );
  }

  // Create pending action instead of executing
  const { pendingActionId } = await createPendingAction(
    adminCtx,
    "accounts:fundClient",
    "adminFundClientAccount",
    { clientId, amount, reference, paymentMethod, makerUid: adminCtx.uid },
    `Fund client ${clientId} with ${amount} tokens`,
  );

  return { success: true, pendingActionId, requiresApproval: true };
});

/**
 * Refund tokens from client account back to cash book
 *
 * Posts journal: DR client:{clientId} CR cbook
 * Inverse of funding. Validates client has sufficient balance.
 */
export const adminRefundClient = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminRefundClient");
  const adminCtx = await requireAdminPermission(request, "accounts:refundClient", "adminRefundClient");

  const { clientId, amount, reason } = request.data as {
    clientId: string;
    amount: number;
    reason: string;
  };

  if (!clientId || !amount || amount <= 0 || !reason) {
    throw new HttpsError(
      "invalid-argument",
      "Client ID, positive amount, and reason are required"
    );
  }

  // Create pending action instead of executing
  const { pendingActionId } = await createPendingAction(
    adminCtx,
    "accounts:refundClient",
    "adminRefundClient",
    { clientId, amount, reason, makerUid: adminCtx.uid },
    `Refund ${amount} tokens from client ${clientId}: ${reason}`,
  );

  return { success: true, pendingActionId, requiresApproval: true };
});

// ============================================================================
// CLIENT SUB-ACCOUNT MANAGEMENT (Earn Overhaul)
// ============================================================================

/**
 * Create a client sub-account for per-campaign budget tracking.
 *
 * Creates both:
 * 1. A Firestore doc at clients/{clientId}/subAccounts/{subAccountId} (metadata)
 * 2. A ledger account at ledgerAccounts/client_subacc:{subAccountId} (balance)
 *
 * Sub-accounts are created empty (balance 0) and funded separately
 * via adminFundClientSubAccount.
 */
export const adminCreateClientSubAccount = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminCreateClientSubAccount");
  const adminCtx = await requireAdminPermission(request, "accounts:createSubAccount", "adminCreateClientSubAccount");

  const { clientId, name } = request.data as {
    clientId: string;
    name: string;
  };

  if (!clientId || !name) {
    throw new HttpsError(
      "invalid-argument",
      "Client ID and name are required"
    );
  }

  // Validate client exists and is not deleted
  const clientDoc = await db.collection("clients").doc(clientId).get();
  if (!clientDoc.exists) {
    throw new HttpsError("not-found", "Client not found");
  }
  if (clientDoc.data()?.isDeleted === true) {
    throw new HttpsError(
      "failed-precondition",
      "Cannot create sub-account for a deleted client"
    );
  }

  const now = admin.firestore.FieldValue.serverTimestamp();
  const subAccountRef = db
    .collection("clients")
    .doc(clientId)
    .collection("subAccounts")
    .doc();

  const ledgerAccountId = AccountId.clientSubAccount(subAccountRef.id);

  // Create the ledger account
  const ledgerResult = await createAccount({
    type: "client_subacc",
    name: `${name} — ${clientId}`,
    ownerId: subAccountRef.id,
    metadata: { clientId, subAccountFirestoreId: subAccountRef.id },
  });

  if (!ledgerResult.success) {
    throw new HttpsError(
      "internal",
      `Failed to create ledger account: ${ledgerResult.error}`
    );
  }

  // Create the Firestore metadata doc (balance is on the ledger, not here)
  await subAccountRef.set({
    id: subAccountRef.id,
    name,
    ledgerAccountId,
    isActive: true,
    budgetExhausted: false,
    warningNotifiedAt: null,
    depletedAt: null,
    createdAt: now,
    updatedAt: now,
    createdBy: request.auth!.uid,
  });

  logAdminAction(adminCtx.uid, "adminCreateClientSubAccount", "success", { clientId, subAccountId: subAccountRef.id, ledgerAccountId }).catch(() => {});

  return { success: true, subAccountId: subAccountRef.id, ledgerAccountId };
});

/**
 * Fund (top up) a client sub-account.
 *
 * Posts an on-ledger journal: DR client:{clientId} CR client_subacc:{subAccountId}
 * Validates client master account has sufficient ledger balance.
 */
export const adminFundClientSubAccount = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminFundClientSubAccount");
  const adminCtx = await requireAdminPermission(request, "accounts:fundSubAccount", "adminFundClientSubAccount");

  const { clientId, subAccountId, amount, reference } = request.data as {
    clientId: string;
    subAccountId: string;
    amount: number;
    reference: string;
  };

  if (!clientId || !subAccountId || !amount || amount <= 0 || !reference) {
    throw new HttpsError(
      "invalid-argument",
      "Client ID, sub-account ID, positive amount, and reference are required"
    );
  }

  // Guard: cannot fund a deleted client's sub-account
  const clientDoc = await db.collection("clients").doc(clientId).get();
  if (clientDoc.data()?.isDeleted === true) {
    throw new HttpsError(
      "failed-precondition",
      "Cannot fund a deleted client's sub-account"
    );
  }

  const subAccountRef = db
    .collection("clients")
    .doc(clientId)
    .collection("subAccounts")
    .doc(subAccountId);

  const subAccountDoc = await subAccountRef.get();
  if (!subAccountDoc.exists) {
    throw new HttpsError("not-found", "Sub-account not found");
  }

  // Ensure the ledger account exists (auto-create for pre-existing sub-accounts)
  const ledgerAccId = AccountId.clientSubAccount(subAccountId);
  const existingLedger = await getAccount(ledgerAccId);
  if (!existingLedger) {
    const subAccData = subAccountDoc.data()!;
    await createAccount({
      type: "client_subacc",
      name: `${subAccData.name || subAccountId} — ${clientId}`,
      ownerId: subAccountId,
      metadata: { clientId, subAccountFirestoreId: subAccountId, migratedFromLegacy: true },
    });

    // Store ledger account reference on the Firestore doc
    await subAccountRef.update({ ledgerAccountId: ledgerAccId });
  }

  // Post on-ledger journal: DR client CR client_subacc
  const result = await processClientSubAccountFunding(
    clientId, subAccountId, amount, reference, request.auth!.uid
  );

  if (!result.success) {
    throw new HttpsError(
      "internal",
      result.error || "Failed to fund sub-account"
    );
  }

  const now = admin.firestore.FieldValue.serverTimestamp();

  // Clear budget exhaustion on the Firestore metadata doc
  await subAccountRef.update({
    budgetExhausted: false,
    depletedAt: null,
    updatedAt: now,
  });

  // Clear budgetExhausted on threads linked to this sub-account
  const ledgerAccountId = AccountId.clientSubAccount(subAccountId);
  const threadsSnapshot = await db
    .collection("earnThreads")
    .where("tokenSourceAccountId", "==", ledgerAccountId)
    .where("budgetExhausted", "==", true)
    .get();

  if (!threadsSnapshot.empty) {
    const batch = db.batch();
    for (const doc of threadsSnapshot.docs) {
      batch.update(doc.ref, { budgetExhausted: false, updatedAt: now });
    }
    await batch.commit();
  }

  logAdminAction(adminCtx.uid, "adminFundClientSubAccount", "success", { clientId, subAccountId, amount, journalId: result.journalId }).catch(() => {});

  return {
    success: true,
    journalId: result.journalId,
  };
});

/**
 * List all sub-accounts for a client.
 * Balance is read from the ledger account (authoritative), not the Firestore metadata doc.
 */
export const adminListClientSubAccounts = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminListClientSubAccounts");
  await requireAdminPermission(request, "accounts:listSubAccounts", "adminListClientSubAccounts");

  const { clientId } = request.data as { clientId: string };

  if (!clientId) {
    throw new HttpsError(
      "invalid-argument",
      "Client ID is required"
    );
  }

  const snapshot = await db
    .collection("clients")
    .doc(clientId)
    .collection("subAccounts")
    .orderBy("createdAt", "desc")
    .get();

  // Fetch ledger balances for all sub-accounts
  const subAccountResults = await Promise.allSettled(
    snapshot.docs.map(async (doc) => {
      const d = doc.data();
      const ledgerAccountId = AccountId.clientSubAccount(doc.id);
      const balance = await getBalance(ledgerAccountId);

      return {
        id: doc.id,
        name: d.name,
        ledgerAccountId,
        balance,
        isActive: d.isActive,
        budgetExhausted: d.budgetExhausted,
        createdAt: d.createdAt,
        updatedAt: d.updatedAt,
        createdBy: d.createdBy,
      };
    })
  );

  const subAccounts = subAccountResults
    .filter((r): r is PromiseFulfilledResult<any> => r.status === "fulfilled")
    .map((r) => r.value);

  return { subAccounts };
});

// ============================================================================
// SYSTEM ACCOUNT STATUS
// ============================================================================

/**
 * Get current system account balances (CBooks, pots, cashout pending)
 */
export const adminGetSystemAccountStatus = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminGetSystemAccountStatus");
  await requireAdminPermission(request, "accounts:getSystemStatus", "adminGetSystemAccountStatus");

  const twentyFourHoursAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);
  const twentyFourHoursAgoTs = admin.firestore.Timestamp.fromDate(twentyFourHoursAgo);

  // Phase 1: All independent queries in parallel
  const [
    cbookBus, cbookTrust, dailyPot, weeklyPot, cashoutPending, imalichatMain,
    potResidual, subAccountsSnap, activeClientsSnap, activeCampaignsAgg, activeOppsSnap,
    totalUsersAgg, recentLoginsAgg, recentCompletedSnap,
  ] = await Promise.all([
    // Existing ledger balances
    getBalance(SystemAccounts.CBOOK_BUS),
    getBalance(SystemAccounts.CBOOK_TRUST),
    getBalance(SystemAccounts.DAILY_POT),
    getBalance(SystemAccounts.WEEKLY_POT),
    getBalance(SystemAccounts.CASHOUT_PENDING),
    getBalance(SystemAccounts.IMALICHAT_CLIENT),
    getBalance(SystemAccounts.POT_RESIDUAL),
    db.collection("clients").doc("imalichat").collection("subAccounts").get(),
    // New: other clients, campaigns, opportunities, users, activity
    db.collection("clients").where("isActive", "==", true).limit(1000).get(),
    db.collection("earnThreads").where("isActive", "==", true).count().get(),
    db.collection("earnOpportunities").where("isActive", "==", true).limit(1000).get(),
    db.collection("users").count().get(),
    db.collection("users").where("lastLoginAt", ">=", twentyFourHoursAgoTs).count().get(),
    db.collection("engagements")
      .where("status", "==", "completed")
      .where("completedAt", ">=", twentyFourHoursAgoTs)
      .limit(1000)
      .get(),
  ]);

  // Phase 2: iMaliChat sub-account balances
  let subAccountTotal = 0;
  if (!subAccountsSnap.empty) {
    const subBalanceResults = await Promise.allSettled(
      subAccountsSnap.docs.map((doc) => getBalance(AccountId.clientSubAccount(doc.id)))
    );
    subAccountTotal = subBalanceResults
      .filter((r): r is PromiseFulfilledResult<number> => r.status === "fulfilled")
      .reduce((sum, r) => sum + r.value, 0);
  }

  // Phase 2b: Other clients' sub-account balances
  let otherClientsBalance = 0;
  const otherClients = activeClientsSnap.docs.filter((d) => d.id !== "imalichat");
  if (otherClients.length > 0) {
    const otherSubSnaps = await Promise.all(
      otherClients.map((c) => c.ref.collection("subAccounts").get())
    );
    const allSubIds = otherSubSnaps.flatMap((snap) => snap.docs.map((d) => d.id));
    if (allSubIds.length > 0) {
      const otherSubBalanceResults = await Promise.allSettled(
        allSubIds.map((id) => getBalance(AccountId.clientSubAccount(id)))
      );
      otherClientsBalance = otherSubBalanceResults
        .filter((r): r is PromiseFulfilledResult<number> => r.status === "fulfilled")
        .reduce((sum, r) => sum + r.value, 0);
    }
  }

  // Compute aggregates from fetched docs
  const activeOpportunitiesTokens = activeOppsSnap.docs.reduce(
    (sum, d) => sum + ((d.data().tokenReward as number) || 0), 0
  );
  const tokensEarnedLast24h = recentCompletedSnap.docs.reduce(
    (sum, d) => sum + ((d.data().tokensEarned as number) || 0), 0
  );

  return {
    // Existing
    cbookBus,
    cbookTrust,
    dailyPot,
    weeklyPot,
    cashoutPending,
    potResidual,
    imalichat: imalichatMain + subAccountTotal,
    // New metrics
    otherClientsBalance,
    activeCampaigns: activeCampaignsAgg.data().count,
    activeOpportunities: activeOppsSnap.size,
    activeOpportunitiesTokens,
    totalUsers: totalUsersAgg.data().count,
    uniqueLoginsLast24h: recentLoginsAgg.data().count,
    tokensEarnedLast24h,
  };
});

// ============================================================================
// LEDGER RECONCILIATION
// ============================================================================

/**
 * Run ledger reconciliation and return overview data.
 * Always returns: system balance check, account list, statistics, recent journals.
 * When runFullRecon=true, also runs per-account reconciliation + journal integrity check.
 */
export const adminRunLedgerRecon = onCall(
  { timeoutSeconds: 120, memory: "256MiB", labels: { area: "admin" } },
  async (request) => {
    await requireAppCheck(request, "adminRunLedgerRecon");
    await requireAdminPermission(request, "accounts:runRecon", "adminRunLedgerRecon");

    // Always fetch overview data in parallel
    const [systemBalance, stats, journals, accountsSnap] = await Promise.all([
      verifySystemBalance(),
      getLedgerStatistics(),
      getRecentJournals(25),
      db.collection(LedgerConfig.COLLECTION_ACCOUNTS).get(),
    ]);

    // Build account list
    const accounts = accountsSnap.docs.map((doc) => {
      const a = doc.data();
      return {
        id: a.id,
        type: a.type,
        name: a.name,
        balance: a.balance,
        status: a.status,
      };
    });

    // Format recent journals
    const recentJournals = journals.map((j) => ({
      id: j.id,
      type: j.type,
      status: j.status,
      description: j.description,
      totalDebits: j.totalDebits,
      totalCredits: j.totalCredits,
      entries: j.entries.map((e) => ({
        accountId: e.accountId,
        entryType: e.entryType,
        amount: e.amount,
      })),
      postedAt: j.postedAt?.toMillis?.() ?? null,
    }));

    // Optionally run full reconciliation
    let reconciliation = null;
    let journalIntegrity = null;

    if (request.data?.runFullRecon === true) {
      const [recon, integrity] = await Promise.all([
        reconcileAllAccounts(),
        verifyAllJournalsBalanced(),
      ]);

      reconciliation = {
        total: recon.total,
        passed: recon.passed,
        failed: recon.failed,
        results: recon.results.map((r) => ({
          accountId: r.accountId,
          storedBalance: r.storedBalance,
          calculatedBalance: r.calculatedBalance,
          isReconciled: r.isReconciled,
          discrepancy: r.discrepancy,
        })),
      };

      journalIntegrity = {
        total: integrity.total,
        balanced: integrity.balanced,
        unbalanced: integrity.unbalanced,
      };
    }

    return {
      systemBalance: {
        isValid: systemBalance.isValid,
        drift: systemBalance.drift,
        cbookBalances: systemBalance.cbookBalances,
        userBalances: systemBalance.userBalances,
        potBalances: systemBalance.potBalances,
        supplierBalances: systemBalance.supplierBalances,
        clientBalances: systemBalance.clientBalances,
        clientSubaccBalances: systemBalance.clientSubaccBalances,
        systemBalances: systemBalance.systemBalances,
        groupBalances: systemBalance.groupBalances,
      },
      statistics: stats,
      accounts,
      recentJournals,
      reconciliation,
      journalIntegrity,
    };
  }
);

// ============================================================================
// USER ACCOUNTS
// ============================================================================

/**
 * List all user accounts with ledger balances and profile data.
 * Primary source is the `users` collection so every registered user appears,
 * even those who haven't triggered ledger account creation yet.
 */
export const adminListUsers = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminListUsers");
  await requireAdminPermission(request, "accounts:listUsers", "adminListUsers");

  const { pageSize = 50, startAfterId } = request.data || {};

  // Primary source: user profile documents (only fields needed for admin list)
  let userQuery = db.collection("users")
    .select("displayName", "email", "phoneNumber", "kycTier", "createdAt", "isActive")
    .orderBy("createdAt", "desc")
    .limit(pageSize);
  if (startAfterId) {
    const startAfterDoc = await db.collection("users").doc(startAfterId).get();
    if (startAfterDoc.exists) {
      userQuery = userQuery.startAfter(startAfterDoc);
    }
  }
  const userDocs = await userQuery.get();

  // Secondary source: ledger accounts for balance/status (only needed fields)
  const ledgerSnapshot = await db
    .collection("ledgerAccounts")
    .where("type", "==", "user")
    .select("balance", "status", "userId")
    .get();
  const ledgerMap = new Map<string, FirebaseFirestore.DocumentData>();
  ledgerSnapshot.docs.forEach((doc) => {
    const userId = AccountId.parseUserId(doc.id);
    if (userId) {
      ledgerMap.set(userId, doc.data());
    }
  });

  const users = userDocs.docs.map((doc) => {
    const userId = doc.id;
    const profile = doc.data();
    const ledger = ledgerMap.get(userId);

    return {
      id: userId,
      ledgerAccountId: ledger?.id || `user:${userId}`,
      name: ledger?.name || profile?.profile?.displayName || profile?.displayName || null,
      displayName:
        profile?.profile?.displayName || profile?.displayName || null,
      phoneNumber: profile?.phoneNumber || null,
      email: profile?.email || null,
      balance: ledger?.balance ?? 0,
      status: ledger?.status || "active",
      createdAt: ledger?.createdAt || profile?.createdAt || null,
      lastLoginAt: profile?.lastLoginAt || null,
    };
  });

  return { users };
});

/**
 * List all sub-accounts for a specific user.
 * Reads from ledgerAccounts/{userId}/subAccounts/ (bypasses security rules).
 */
export const adminListUserSubAccounts = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminListUserSubAccounts");
  await requireAdminPermission(request, "accounts:listUserSubAccounts", "adminListUserSubAccounts");

  const { userId } = request.data as { userId: string };
  if (!userId) {
    throw new HttpsError(
      "invalid-argument",
      "User ID is required"
    );
  }

  const subAccounts = await getUserSubAccounts(userId);

  return {
    subAccounts: subAccounts.map((sa) => ({
      id: sa.id,
      name: sa.name,
      balance: sa.balance,
      isDefault: sa.isDefault,
      accountTypeId: sa.accountTypeId,
      lifetimeCredits: sa.lifetimeCredits,
      lifetimeDebits: sa.lifetimeDebits,
      isActive: sa.isActive,
      createdAt: sa.createdAt,
    })),
  };
});

// ============================================================================
// ACCOUNT TYPE MANAGEMENT
// ============================================================================

/**
 * List all account types (optionally including inactive).
 * Enriches each with the advertiser's display name.
 */
export const adminListAccountTypes = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    await requireAppCheck(request, "adminListAccountTypes");
    await requireAdminPermission(
      request,
      "accounts:listAccountTypes",
      "adminListAccountTypes"
    );

    const { includeInactive = false } = request.data || {};

    const accountTypes = await listAccountTypes(includeInactive === true);

    // Enrich with advertiser display names
    const advertiserIds = [
      ...new Set(
        accountTypes
          .map((at) => at.advertiserId)
          .filter((id): id is string => id !== null)
      ),
    ];

    const advertiserNames = new Map<string, string>();
    if (advertiserIds.length > 0) {
      const clientDocs = await Promise.all(
        advertiserIds.map((id) => db.collection("clients").doc(id).get())
      );
      for (const doc of clientDocs) {
        if (doc.exists) {
          const data = doc.data();
          advertiserNames.set(
            doc.id,
            data?.displayName || data?.companyName || doc.id
          );
        }
      }
    }

    return {
      accountTypes: accountTypes.map((at) => ({
        id: at.id,
        advertiserId: at.advertiserId,
        advertiserName: at.advertiserId
          ? advertiserNames.get(at.advertiserId) || at.advertiserId
          : null,
        name: at.name,
        description: at.description,
        iconUrl: at.iconUrl,
        isRestricted: at.isRestricted,
        rules: at.rules,
        isActive: at.isActive,
        createdAt: at.createdAt,
      })),
    };
  }
);

/**
 * Get a single account type by ID.
 */
export const adminGetAccountType = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    await requireAppCheck(request, "adminGetAccountType");
    await requireAdminPermission(
      request,
      "accounts:getAccountType",
      "adminGetAccountType"
    );

    const { accountTypeId } = request.data as { accountTypeId: string };
    if (!accountTypeId) {
      throw new HttpsError("invalid-argument", "accountTypeId is required");
    }

    const accountType = await getAccountType(accountTypeId);
    if (!accountType) {
      throw new HttpsError("not-found", "Account type not found");
    }

    let advertiserName: string | null = null;
    if (accountType.advertiserId) {
      const clientDoc = await db
        .collection("clients")
        .doc(accountType.advertiserId)
        .get();
      if (clientDoc.exists) {
        const data = clientDoc.data();
        advertiserName =
          data?.displayName || data?.companyName || accountType.advertiserId;
      }
    }

    return {
      accountType: {
        ...accountType,
        advertiserName,
      },
    };
  }
);

/**
 * Create a new account type with rules.
 */
export const adminCreateAccountType = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    await requireAppCheck(request, "adminCreateAccountType");
    const adminCtx = await requireAdminPermission(
      request,
      "accounts:createAccountType",
      "adminCreateAccountType"
    );

    const { id, name, description, rules, advertiserId, iconUrl } =
      request.data as {
        id: string;
        name: string;
        description: string;
        rules?: Partial<AccountTypeRules>;
        advertiserId?: string;
        iconUrl?: string;
      };

    if (!id || !name || !description) {
      throw new HttpsError(
        "invalid-argument",
        "id, name, and description are required"
      );
    }

    if (!/^[a-z0-9_]+$/.test(id)) {
      throw new HttpsError(
        "invalid-argument",
        "ID must use lowercase letters, numbers, and underscores only"
      );
    }

    const existing = await getAccountType(id);
    if (existing) {
      throw new HttpsError(
        "already-exists",
        `Account type "${id}" already exists`
      );
    }

    if (advertiserId) {
      const clientDoc = await db
        .collection("clients")
        .doc(advertiserId)
        .get();
      if (!clientDoc.exists || clientDoc.data()?.isDeleted === true) {
        throw new HttpsError(
          "not-found",
          "Advertiser (client) not found or deleted"
        );
      }
    }

    const validatedRules: AccountTypeRules = {
      allowedOfframps: rules?.allowedOfframps || ["*"],
      allowP2pSend: rules?.allowP2pSend !== false,
      allowP2pReceive: rules?.allowP2pReceive !== false,
      allowCashout: rules?.allowCashout !== false,
      expiryDays:
        typeof rules?.expiryDays === "number" ? rules.expiryDays : null,
      p2pRestrictToSameAccountType:
        rules?.p2pRestrictToSameAccountType === true,
    };

    const accountType = await createAccountType(
      id,
      name,
      description,
      validatedRules,
      { advertiserId, iconUrl }
    );

    logAdminAction(adminCtx.uid, "adminCreateAccountType", "success", {
      id,
      name,
      advertiserId,
    }).catch(() => {});

    return { success: true, accountType };
  }
);

/**
 * Update an existing account type's fields and/or rules.
 */
export const adminUpdateAccountType = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    await requireAppCheck(request, "adminUpdateAccountType");
    const adminCtx = await requireAdminPermission(
      request,
      "accounts:updateAccountType",
      "adminUpdateAccountType"
    );

    const { accountTypeId, updates } = request.data as {
      accountTypeId: string;
      updates: {
        name?: string;
        description?: string;
        iconUrl?: string | null;
        isActive?: boolean;
        rules?: Partial<AccountTypeRules>;
      };
    };

    if (!accountTypeId) {
      throw new HttpsError("invalid-argument", "accountTypeId is required");
    }

    if (!updates || Object.keys(updates).length === 0) {
      throw new HttpsError(
        "invalid-argument",
        "At least one field to update is required"
      );
    }

    let updated;
    try {
      updated = await updateAccountType(accountTypeId, updates);
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes("ACCOUNT_TYPE_NOT_FOUND")) {
        throw new HttpsError("not-found", "Account type not found");
      }
      throw err;
    }

    logAdminAction(adminCtx.uid, "adminUpdateAccountType", "success", {
      accountTypeId,
      updatedFields: Object.keys(updates),
    }).catch(() => {});

    return { success: true, accountType: updated };
  }
);

/**
 * Deactivate (soft-delete) an account type.
 * Reactivation is done via adminUpdateAccountType with { isActive: true }.
 */
export const adminDeactivateAccountType = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    await requireAppCheck(request, "adminDeactivateAccountType");
    const adminCtx = await requireAdminPermission(
      request,
      "accounts:updateAccountType",
      "adminDeactivateAccountType"
    );

    const { accountTypeId } = request.data as { accountTypeId: string };
    if (!accountTypeId) {
      throw new HttpsError("invalid-argument", "accountTypeId is required");
    }

    try {
      await deactivateAccountType(accountTypeId);
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes("ACCOUNT_TYPE_NOT_FOUND")) {
        throw new HttpsError("not-found", "Account type not found");
      }
      throw err;
    }

    logAdminAction(
      adminCtx.uid,
      "adminDeactivateAccountType",
      "success",
      { accountTypeId }
    ).catch(() => {});

    return { success: true };
  }
);

// ============================================================================
// SOFT-DELETE CLIENT
// ============================================================================

/**
 * Soft-delete a client: refund sub-account balances -> master, then master -> cbook.
 * Close ledger accounts, cascade soft-delete to threads, opportunities, and sub-accounts.
 */
export const adminSoftDeleteClient = onCall({ labels: { area: "admin" } }, async (request) => {
  await requireAppCheck(request, "adminSoftDeleteClient");
  const adminCtx = await requireAdminPermission(request, "accounts:softDeleteClient", "adminSoftDeleteClient");

  const { clientId, reason } = request.data as {
    clientId: string;
    reason?: string;
  };
  if (!clientId) {
    throw new HttpsError("invalid-argument", "clientId is required");
  }

  const clientRef = db.collection("clients").doc(clientId);
  const clientDoc = await clientRef.get();

  if (!clientDoc.exists) {
    throw new HttpsError("not-found", "Client not found");
  }

  const client = clientDoc.data()!;
  if (client.isDeleted === true) {
    throw new HttpsError("failed-precondition", "Client is already deleted");
  }

  const uid = request.auth!.uid;
  const now = admin.firestore.FieldValue.serverTimestamp();
  const accountId = AccountId.client(clientId);

  // 1. Refund all sub-account balances back to client master
  const subAccountsSnapshot = await clientRef.collection("subAccounts").get();
  for (const saDoc of subAccountsSnapshot.docs) {
    const ledgerAccountId = AccountId.clientSubAccount(saDoc.id);
    const subBalance = await getBalance(ledgerAccountId);

    if (subBalance > 0) {
      const subRefundResult = await postJournal({
        idempotencyKey: `client_delete_subacc_refund:${saDoc.id}:${Date.now()}`,
        type: "subacc_fund",
        description: `Sub-account refund on client deletion: ${saDoc.id}`,
        entries: [
          {
            accountId: ledgerAccountId,
            entryType: "debit",
            amount: subBalance,
            description: "Sub-account balance refund on deletion",
          },
          {
            accountId,
            entryType: "credit",
            amount: subBalance,
            description: `Refund from sub-account ${saDoc.id}`,
          },
        ],
        referenceType: "client_fund",
        referenceId: clientId,
        initiatedBy: uid,
        metadata: { deletionReason: reason || null, subAccountId: saDoc.id },
      });

      if (!subRefundResult.success) {
        logger.warn(`Could not refund sub-account ${saDoc.id}: ${subRefundResult.error}`);
      }
    }

    // Close the sub-account ledger account
    await closeAccount(ledgerAccountId, reason || "Client deleted", uid).catch((err) =>
      logger.warn(`Could not close sub-account ledger ${ledgerAccountId}: ${err}`)
    );
  }

  // 2. Refund remaining client master balance to cbook
  let refundedAmount = 0;
  const balance = await getBalance(accountId);

  if (balance > 0) {
    const isImalichat = clientId === "imalichat";
    const cbookAccount = isImalichat ? SystemAccounts.CBOOK_BUS : SystemAccounts.CBOOK_TRUST;

    const result = await postJournal({
      idempotencyKey: `client_delete_refund:${clientId}:${Date.now()}`,
      type: "client_refund",
      description: `Client deleted: balance refund to CBook. Reason: ${reason || "No reason provided"}`,
      entries: [
        {
          accountId,
          entryType: "debit",
          amount: balance,
          description: "Balance refund on client deletion",
        },
        {
          accountId: cbookAccount,
          entryType: "credit",
          amount: balance,
          description: "Client deletion refund",
        },
      ],
      referenceType: "client_fund",
      referenceId: clientId,
      initiatedBy: uid,
      metadata: { deletionReason: reason || null },
    });

    if (!result.success) {
      throw new HttpsError(
        "internal",
        `Failed to refund balance: ${result.error}`
      );
    }
    refundedAmount = balance;
  }

  // 3. Close client ledger account (requires balance == 0, which steps 1+2 ensure)
  const closeResult = await closeAccount(
    accountId,
    reason || "Client deleted by admin",
    uid
  );
  if (!closeResult.success) {
    logger.warn(`Could not close ledger account ${accountId}: ${closeResult.error}`);
  }

  // 4. Cascade soft-delete to all threads and their opportunities
  let deletedThreads = 0;
  let deletedOpportunities = 0;

  const threadsSnapshot = await db
    .collection("earnThreads")
    .where("clientId", "==", clientId)
    .get();

  for (const threadDoc of threadsSnapshot.docs) {
    if (threadDoc.data().isDeleted === true) continue;

    // Soft-delete opportunities in this thread
    const oppsSnapshot = await db
      .collection("earnOpportunities")
      .where("threadId", "==", threadDoc.id)
      .get();

    if (!oppsSnapshot.empty) {
      const oppBatch = db.batch();
      for (const oppDoc of oppsSnapshot.docs) {
        if (oppDoc.data().isDeleted !== true) {
          oppBatch.update(oppDoc.ref, {
            isDeleted: true,
            isActive: false,
            deletedAt: now,
            deletedBy: uid,
            updatedAt: now,
          });
          deletedOpportunities++;
        }
      }
      await oppBatch.commit();
    }

    // Soft-delete the thread
    await threadDoc.ref.update({
      isDeleted: true,
      isActive: false,
      deletedAt: now,
      deletedBy: uid,
      updatedAt: now,
    });
    deletedThreads++;
  }

  // 5. Soft-delete all sub-account Firestore docs
  if (!subAccountsSnapshot.empty) {
    const subBatch = db.batch();
    for (const saDoc of subAccountsSnapshot.docs) {
      subBatch.update(saDoc.ref, {
        isDeleted: true,
        isActive: false,
        deletedAt: now,
        updatedAt: now,
      });
    }
    await subBatch.commit();
  }

  // 6. Mark client as deleted
  await clientRef.update({
    isDeleted: true,
    isActive: false,
    deletedAt: now,
    deletedBy: uid,
    deletionReason: reason || null,
    status: "closed",
    updatedAt: now,
  });

  logAdminAction(adminCtx.uid, "adminSoftDeleteClient", "success", { clientId, reason, refundedAmount, deletedThreads, deletedOpportunities }).catch(() => {});

  return {
    success: true,
    refundedAmount,
    deletedThreads,
    deletedOpportunities,
  };
});

// ============================================================================
// ONE-TIME BACKFILL: displayNameLower
// ============================================================================

export const backfillDisplayNameLower = onCall({ labels: { area: "admin" } }, async (request) => {
  const adminCtx = await requireAdminPermission(request, "platform:runMigration", "backfillDisplayNameLower");
  const db = admin.firestore();

  const snapshot = await db.collection("users").get();
  let updated = 0;
  let skipped = 0;
  const batch = db.batch();

  for (const doc of snapshot.docs) {
    const data = doc.data();
    if (data.displayNameLower) {
      skipped++;
      continue;
    }
    const displayName = data.displayName as string | undefined;
    if (!displayName) {
      skipped++;
      continue;
    }
    batch.update(doc.ref, { displayNameLower: displayName.toLowerCase() });
    updated++;

    // Firestore batches limited to 500
    if (updated % 500 === 0) {
      await batch.commit();
    }
  }

  if (updated % 500 !== 0) {
    await batch.commit();
  }

  logAdminAction(adminCtx.uid, "backfillDisplayNameLower", "success", { updated, skipped }).catch(() => {});
  logger.info(`backfillDisplayNameLower: updated=${updated}, skipped=${skipped}`);

  return { success: true, updated, skipped };
});

// ============================================================================
// BACKFILL: activeAccountTypeIds
// ============================================================================

/**
 * One-time backfill to populate activeAccountTypeIds on user documents.
 * Scans all ledger accounts, collects active brand sub-account accountTypeIds,
 * and writes the array to each user's document for fast search filtering.
 */
export const backfillActiveAccountTypeIds = onCall(
  { labels: { area: "admin" } },
  async (request) => {
    const adminCtx = await requireAdminPermission(request, "platform:runMigration", "backfillActiveAccountTypeIds");

    const ledgerDocs = await db.collection("ledgerAccounts").get();
    let updated = 0;
    let skipped = 0;

    for (const doc of ledgerDocs.docs) {
      // Only process user ledger accounts (format: "user:{uid}")
      if (!doc.id.startsWith("user:")) {
        skipped++;
        continue;
      }
      const userId = doc.id.substring(5); // strip "user:" prefix

      // Get all active sub-accounts with an accountTypeId
      const subAccounts = await doc.ref
        .collection("subAccounts")
        .where("isActive", "==", true)
        .get();

      const accountTypeIds = [
        ...new Set(
          subAccounts.docs
            .map((sa) => sa.data().accountTypeId as string | null)
            .filter((id): id is string => !!id)
        ),
      ];

      if (accountTypeIds.length > 0) {
        await db.collection("users").doc(userId).update({
          activeAccountTypeIds: accountTypeIds,
        });
        updated++;
      } else {
        skipped++;
      }
    }

    logAdminAction(adminCtx.uid, "backfillActiveAccountTypeIds", "success", { updated, skipped }).catch(() => {});
    logger.info(`backfillActiveAccountTypeIds: updated=${updated}, skipped=${skipped}`);

    return { success: true, updated, skipped };
  }
);
