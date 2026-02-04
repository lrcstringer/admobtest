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
