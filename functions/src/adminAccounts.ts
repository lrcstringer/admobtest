/**
 * Admin Account Management Functions
 *
 * Cloud Functions for managing supplier and client (brand partner) accounts.
 * These functions require admin authentication.
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {
  createSupplierAccount,
  createClientAccount,
  getAccountsByType,
  freezeAccount,
  unfreezeAccount,
  getAccount,
} from "./ledger/accounts";
import { AccountId } from "./ledger/types";
import { requireAppCheck } from "./security";

const db = admin.firestore();

// ============================================================================
// ADMIN ROLE CHECK
// ============================================================================

/**
 * Verify the caller has admin role
 */
async function requireAdmin(context: functions.https.CallableContext): Promise<void> {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Must be authenticated");
  }

  // Check custom claims for admin role
  const token = context.auth.token;
  if (!token.admin && !token.superAdmin) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Admin access required"
    );
  }
}

// ============================================================================
// SUPPLIER ACCOUNT MANAGEMENT
// ============================================================================

/**
 * Create a new supplier account
 */
export const adminCreateSupplier = functions.https.onCall(
  async (
    data: {
      providerId: string;
      providerName: string;
      category?: string;
      contactEmail?: string;
      contactName?: string;
    },
    context
  ) => {
    requireAppCheck(context, "adminCreateSupplier");
    await requireAdmin(context);

    const { providerId, providerName, category, contactEmail, contactName } = data;

    if (!providerId || !providerName) {
      throw new functions.https.HttpsError(
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
        createdBy: context.auth!.uid,
      },
      { merge: true }
    );

    return {
      success: true,
      supplier: {
        id: providerId,
        name: providerName,
        ledgerAccountId: account.id,
      },
    };
  }
);

/**
 * List all supplier accounts
 */
export const adminListSuppliers = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "adminListSuppliers");
  await requireAdmin(context);

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
export const adminUpdateSupplierStatus = functions.https.onCall(
  async (
    data: {
      providerId: string;
      action: "freeze" | "unfreeze";
      reason: string;
    },
    context
  ) => {
    requireAppCheck(context, "adminUpdateSupplierStatus");
    await requireAdmin(context);

    const { providerId, action, reason } = data;
    const accountId = AccountId.supplier(providerId);

    const result =
      action === "freeze"
        ? await freezeAccount(accountId, reason, context.auth!.uid)
        : await unfreezeAccount(accountId, reason, context.auth!.uid);

    if (!result.success) {
      throw new functions.https.HttpsError("internal", result.error || "Failed to update status");
    }

    // Update supplier profile
    await db.collection("suppliers").doc(providerId).update({
      status: action === "freeze" ? "frozen" : "active",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);

// ============================================================================
// CLIENT (BRAND PARTNER) ACCOUNT MANAGEMENT
// ============================================================================

/**
 * Create a new client (brand partner) account
 */
export const adminCreateClient = functions.https.onCall(
  async (
    data: {
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
    },
    context
  ) => {
    requireAppCheck(context, "adminCreateClient");
    await requireAdmin(context);

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
    } = data;

    if (!clientId || !companyName || !contactEmail || !contactName) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Client ID, company name, contact email, and contact name are required"
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
      // Campaign stats
      totalCampaigns: 0,
      activeCampaigns: 0,
      totalSpent: 0,
      totalImpressions: 0,
      totalEngagements: 0,
      // Timestamps
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      createdBy: context.auth!.uid,
    });

    return {
      success: true,
      client: {
        id: clientId,
        companyName,
        displayName: displayName || companyName,
        ledgerAccountId: account.id,
      },
    };
  }
);

/**
 * List all client (brand partner) accounts
 */
export const adminListClients = functions.https.onCall(async (data, context) => {
  requireAppCheck(context, "adminListClients");
  await requireAdmin(context);

  // Get ledger accounts
  const accounts = await getAccountsByType("client");

  // Get client profiles
  const clientDocs = await db.collection("clients").get();
  const profiles = new Map<string, FirebaseFirestore.DocumentData>();
  clientDocs.forEach((doc) => {
    profiles.set(doc.id, doc.data());
  });

  // Merge data
  const clients = accounts.map((account) => {
    const clientId = AccountId.parseClientId(account.id);
    const profile = clientId ? profiles.get(clientId) : null;

    return {
      id: clientId,
      ledgerAccountId: account.id,
      companyName: account.name,
      balance: account.balance,
      status: account.status,
      contactEmail: profile?.contactEmail,
      contactName: profile?.contactName,
      industry: profile?.industry,
      totalCampaigns: profile?.totalCampaigns || 0,
      activeCampaigns: profile?.activeCampaigns || 0,
      totalSpent: profile?.totalSpent || 0,
      createdAt: account.createdAt,
    };
  });

  return { clients };
});

/**
 * Get client details
 */
export const adminGetClient = functions.https.onCall(
  async (data: { clientId: string }, context) => {
    requireAppCheck(context, "adminGetClient");
    await requireAdmin(context);

    const { clientId } = data;
    const accountId = AccountId.client(clientId);

    const account = await getAccount(accountId);
    if (!account) {
      throw new functions.https.HttpsError("not-found", "Client not found");
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
  }
);

/**
 * Update client status (freeze/unfreeze)
 */
export const adminUpdateClientStatus = functions.https.onCall(
  async (
    data: {
      clientId: string;
      action: "freeze" | "unfreeze";
      reason: string;
    },
    context
  ) => {
    requireAppCheck(context, "adminUpdateClientStatus");
    await requireAdmin(context);

    const { clientId, action, reason } = data;
    const accountId = AccountId.client(clientId);

    const result =
      action === "freeze"
        ? await freezeAccount(accountId, reason, context.auth!.uid)
        : await unfreezeAccount(accountId, reason, context.auth!.uid);

    if (!result.success) {
      throw new functions.https.HttpsError("internal", result.error || "Failed to update status");
    }

    // Update client profile
    await db.collection("clients").doc(clientId).update({
      status: action === "freeze" ? "frozen" : "active",
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true };
  }
);

/**
 * Update client profile
 */
export const adminUpdateClient = functions.https.onCall(
  async (
    data: {
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
      };
    },
    context
  ) => {
    requireAppCheck(context, "adminUpdateClient");
    await requireAdmin(context);

    const { clientId, updates } = data;

    // Validate client exists
    const accountId = AccountId.client(clientId);
    const account = await getAccount(accountId);
    if (!account) {
      throw new functions.https.HttpsError("not-found", "Client not found");
    }

    // Update profile
    await db.collection("clients").doc(clientId).update({
      ...updates,
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
    }

    return { success: true };
  }
);

/**
 * Fund a client account (admin adds tokens to client's balance)
 * This is used when a client pays for campaign credits
 */
export const adminFundClientAccount = functions.https.onCall(
  async (
    data: {
      clientId: string;
      amount: number;
      reference: string;
      paymentMethod?: string;
    },
    context
  ) => {
    requireAppCheck(context, "adminFundClientAccount");
    await requireAdmin(context);

    const { clientId, amount, reference, paymentMethod } = data;

    if (!clientId || !amount || amount <= 0 || !reference) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Client ID, positive amount, and reference are required"
      );
    }

    // Import journal posting
    const { postJournal } = await import("./ledger/journals");
    const { SystemAccounts } = await import("./ledger/types");

    const accountId = AccountId.client(clientId);

    // Post journal: Treasury -> Client
    const result = await postJournal({
      idempotencyKey: `client_fund:${clientId}:${reference}`,
      type: "adjustment",
      description: `Client account funding: ${reference}`,
      entries: [
        {
          accountId: SystemAccounts.TREASURY,
          entryType: "debit",
          amount,
          description: "Client funding outflow",
        },
        {
          accountId,
          entryType: "credit",
          amount,
          description: "Account credit from funding",
        },
      ],
      referenceType: "campaign",
      referenceId: reference,
      initiatedBy: context.auth!.uid,
      metadata: {
        paymentMethod,
        fundedBy: context.auth!.uid,
      },
    });

    if (!result.success) {
      throw new functions.https.HttpsError("internal", result.error || "Failed to fund account");
    }

    // Update client stats
    await db.collection("clients").doc(clientId).update({
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      journalId: result.journalId,
      newBalance: result.data?.entries.find((e) => e.accountId === accountId)?.balanceAfter,
    };
  }
);

// ============================================================================
// CLIENT SUB-ACCOUNT MANAGEMENT (Earn Overhaul)
// ============================================================================

/**
 * Create a client sub-account for per-campaign budget tracking
 */
export const adminCreateClientSubAccount = functions.https.onCall(
  async (
    data: {
      clientId: string;
      name: string;
      initialBudget: number;
    },
    context
  ) => {
    requireAppCheck(context, "adminCreateClientSubAccount");
    await requireAdmin(context);

    const { clientId, name, initialBudget } = data;

    if (!clientId || !name || !initialBudget || initialBudget <= 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Client ID, name, and positive initial budget are required"
      );
    }

    // Validate client exists
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (!clientDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Client not found");
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const subAccountRef = db
      .collection("clients")
      .doc(clientId)
      .collection("subAccounts")
      .doc();

    await subAccountRef.set({
      id: subAccountRef.id,
      name,
      balance: initialBudget,
      initialBudget,
      isActive: true,
      warningNotifiedAt: null,
      depletedAt: null,
      createdAt: now,
      updatedAt: now,
      createdBy: context.auth!.uid,
    });

    // Post journal: Treasury → Client master account (audit trail)
    const { postJournal: pj } = await import("./ledger/journals");
    const { SystemAccounts: SA } = await import("./ledger/types");

    const accountId = AccountId.client(clientId);
    await pj({
      idempotencyKey: `client_subaccount_fund:${clientId}:${subAccountRef.id}`,
      type: "adjustment",
      description: `Client sub-account created: ${name}`,
      entries: [
        {
          accountId: SA.TREASURY,
          entryType: "debit",
          amount: initialBudget,
          description: "Client sub-account initial funding",
        },
        {
          accountId,
          entryType: "credit",
          amount: initialBudget,
          description: `Sub-account: ${name}`,
        },
      ],
      referenceType: "campaign",
      referenceId: subAccountRef.id,
      initiatedBy: context.auth!.uid,
      metadata: {
        subAccountId: subAccountRef.id,
        subAccountName: name,
      },
    });

    return { success: true, subAccountId: subAccountRef.id };
  }
);

/**
 * Fund (top up) a client sub-account
 */
export const adminFundClientSubAccount = functions.https.onCall(
  async (
    data: {
      clientId: string;
      subAccountId: string;
      amount: number;
      reference: string;
    },
    context
  ) => {
    requireAppCheck(context, "adminFundClientSubAccount");
    await requireAdmin(context);

    const { clientId, subAccountId, amount, reference } = data;

    if (!clientId || !subAccountId || !amount || amount <= 0 || !reference) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Client ID, sub-account ID, positive amount, and reference are required"
      );
    }

    const subAccountRef = db
      .collection("clients")
      .doc(clientId)
      .collection("subAccounts")
      .doc(subAccountId);

    const subAccountDoc = await subAccountRef.get();
    if (!subAccountDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Sub-account not found");
    }

    const now = admin.firestore.FieldValue.serverTimestamp();

    // Increment balance and initialBudget, clear depletion
    await subAccountRef.update({
      balance: admin.firestore.FieldValue.increment(amount),
      initialBudget: admin.firestore.FieldValue.increment(amount),
      isActive: true,
      depletedAt: null,
      updatedAt: now,
    });

    // Re-activate threads that were auto-deactivated due to depleted budget
    const threadsSnapshot = await db
      .collection("earnThreads")
      .where("tokenSourceSubAccountId", "==", subAccountId)
      .where("isActive", "==", false)
      .get();

    if (!threadsSnapshot.empty) {
      const batch = db.batch();
      for (const doc of threadsSnapshot.docs) {
        batch.update(doc.ref, { isActive: true, updatedAt: now });
      }
      await batch.commit();
    }

    // Post journal for audit trail
    const { postJournal: pj } = await import("./ledger/journals");
    const { SystemAccounts: SA } = await import("./ledger/types");

    const accountId = AccountId.client(clientId);
    await pj({
      idempotencyKey: `client_subaccount_topup:${clientId}:${subAccountId}:${reference}`,
      type: "adjustment",
      description: `Client sub-account top-up: ${reference}`,
      entries: [
        {
          accountId: SA.TREASURY,
          entryType: "debit",
          amount,
          description: "Client sub-account top-up",
        },
        {
          accountId,
          entryType: "credit",
          amount,
          description: `Sub-account top-up: ${reference}`,
        },
      ],
      referenceType: "campaign",
      referenceId: reference,
      initiatedBy: context.auth!.uid,
      metadata: {
        subAccountId,
        fundedBy: context.auth!.uid,
      },
    });

    return { success: true };
  }
);

/**
 * List all sub-accounts for a client
 */
export const adminListClientSubAccounts = functions.https.onCall(
  async (data: { clientId: string }, context) => {
    requireAppCheck(context, "adminListClientSubAccounts");
    await requireAdmin(context);

    const { clientId } = data;

    if (!clientId) {
      throw new functions.https.HttpsError(
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

    const subAccounts = snapshot.docs.map((doc) => {
      const d = doc.data();
      const remainingPercent =
        d.initialBudget > 0 ? d.balance / d.initialBudget : 0;
      return {
        id: doc.id,
        ...d,
        remainingPercent,
      };
    });

    return { subAccounts };
  }
);
