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
  getBalance,
  closeAccount,
} from "./ledger/accounts";
import { AccountId, SystemAccounts } from "./ledger/types";
import { getUserSubAccounts } from "./ledger/subAccounts";
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

    // Guard: reject if a client doc with this ID already exists (including soft-deleted)
    const existingClient = await db.collection("clients").doc(clientId).get();
    if (existingClient.exists) {
      const wasDeleted = existingClient.data()?.isDeleted === true;
      throw new functions.https.HttpsError(
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
        createdAt: account.createdAt,
      };
    })
    .filter((c) => c !== null);

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

    // Guard: cannot fund a deleted client
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (clientDoc.data()?.isDeleted === true) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Cannot fund a deleted client"
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
 * Create a client sub-account for per-campaign budget tracking.
 * Sub-accounts are created empty (balance 0) and funded separately
 * via adminFundClientSubAccount to avoid double-counting.
 */
export const adminCreateClientSubAccount = functions.https.onCall(
  async (
    data: {
      clientId: string;
      name: string;
      initialBudget?: number;
    },
    context
  ) => {
    requireAppCheck(context, "adminCreateClientSubAccount");
    await requireAdmin(context);

    const { clientId, name } = data;

    if (!clientId || !name) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Client ID and name are required"
      );
    }

    // Validate client exists and is not deleted
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (!clientDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Client not found");
    }
    if (clientDoc.data()?.isDeleted === true) {
      throw new functions.https.HttpsError(
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

    await subAccountRef.set({
      id: subAccountRef.id,
      name,
      balance: 0,
      initialBudget: 0,
      isActive: true,
      budgetExhausted: false,
      warningNotifiedAt: null,
      depletedAt: null,
      createdAt: now,
      updatedAt: now,
      createdBy: context.auth!.uid,
    });

    return { success: true, subAccountId: subAccountRef.id };
  }
);

/**
 * Fund (top up) a client sub-account.
 * Allocates tokens from the client's master ledger balance into the sub-account.
 * No journal is posted — sub-accounts are internal tracking docs, not real ledger
 * accounts. The tokens already exist in the client master ledger (funded via
 * adminFundClientAccount).
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

    // Guard: cannot fund a deleted client's sub-account
    const clientDoc = await db.collection("clients").doc(clientId).get();
    if (clientDoc.data()?.isDeleted === true) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Cannot fund a deleted client's sub-account"
      );
    }

    // Validate client master ledger has sufficient balance
    const clientAccountId = AccountId.client(clientId);
    const masterBalance = await getBalance(clientAccountId);
    if (masterBalance < amount) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        `Insufficient client balance (${masterBalance} tokens). Fund the client account first.`
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

    // Increment balance and initialBudget, clear budget exhaustion
    // NOTE: isActive is NOT touched — that's admin-controlled only
    await subAccountRef.update({
      balance: admin.firestore.FieldValue.increment(amount),
      initialBudget: admin.firestore.FieldValue.increment(amount),
      budgetExhausted: false,
      depletedAt: null,
      updatedAt: now,
    });

    // Clear budgetExhausted on threads linked to this sub-account
    // NOTE: isActive is NOT touched — admin may have intentionally paused threads
    const threadsSnapshot = await db
      .collection("earnThreads")
      .where("tokenSourceSubAccountId", "==", subAccountId)
      .where("budgetExhausted", "==", true)
      .get();

    if (!threadsSnapshot.empty) {
      const batch = db.batch();
      for (const doc of threadsSnapshot.docs) {
        batch.update(doc.ref, { budgetExhausted: false, updatedAt: now });
      }
      await batch.commit();
    }

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

// ============================================================================
// TREASURY MANAGEMENT
// ============================================================================

/**
 * Seed the treasury with newly minted tokens.
 *
 * Creates a balanced journal: debit system:mint, credit system:treasury.
 * system:mint is the only account allowed to go negative.
 */
export const adminSeedTreasury = functions.https.onCall(
  async (
    data: {
      amount: number;
      reason: string;
    },
    context
  ) => {
    requireAppCheck(context, "adminSeedTreasury");
    await requireAdmin(context);

    const { amount, reason } = data;

    if (!amount || amount <= 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "A positive amount is required"
      );
    }
    if (!reason || reason.trim() === "") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "A reason is required for audit trail"
      );
    }

    const { seedTreasury } = await import("./ledger");

    const result = await seedTreasury(amount, reason, context.auth!.uid);

    if (!result.success) {
      throw new functions.https.HttpsError(
        "internal",
        result.error || "Failed to seed treasury"
      );
    }

    // Read balances after seed
    const treasuryBalance = await getBalance(SystemAccounts.TREASURY);
    const mintBalance = await getBalance(SystemAccounts.MINT);

    return {
      success: true,
      journalId: result.journalId,
      amountMinted: amount,
      treasuryBalanceAfter: treasuryBalance,
      mintBalanceAfter: mintBalance,
    };
  }
);

/**
 * Get current treasury status (balances + monitoring info)
 */
export const adminGetTreasuryStatus = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminGetTreasuryStatus");
    await requireAdmin(context);

    const treasuryBalance = await getBalance(SystemAccounts.TREASURY);
    const mintBalance = await getBalance(SystemAccounts.MINT);

    // Get latest notifications for context
    const notificationsSnapshot = await db
      .collection("adminNotifications")
      .where("type", "in", ["treasury_low_balance", "treasury_depleted"])
      .orderBy("createdAt", "desc")
      .limit(5)
      .get();

    const recentNotifications = notificationsSnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      treasuryBalance,
      mintBalance,
      totalMinted: Math.abs(mintBalance),
      tokensInCirculation: Math.abs(mintBalance) - treasuryBalance,
      recentNotifications,
    };
  }
);

// ============================================================================
// USER ACCOUNTS
// ============================================================================

/**
 * List all user accounts with ledger balances and profile data.
 * Includes all statuses (active + frozen).
 */
export const adminListUsers = functions.https.onCall(async (_data, context) => {
  requireAppCheck(context, "adminListUsers");
  await requireAdmin(context);

  // Query all user-type ledger accounts (including frozen)
  const snapshot = await db
    .collection("ledgerAccounts")
    .where("type", "==", "user")
    .get();
  const accounts = snapshot.docs.map((doc) => doc.data());

  // Get user profile documents
  const userDocs = await db.collection("users").get();
  const profiles = new Map<string, FirebaseFirestore.DocumentData>();
  userDocs.forEach((doc) => {
    profiles.set(doc.id, doc.data());
  });

  const users = accounts.map((account) => {
    const userId = AccountId.parseUserId(account.id);
    const profile = userId ? profiles.get(userId) : null;

    return {
      id: userId,
      ledgerAccountId: account.id,
      name: account.name,
      displayName:
        profile?.profile?.displayName || profile?.displayName || null,
      phoneNumber: profile?.phoneNumber || null,
      email: profile?.email || null,
      balance: account.balance,
      status: account.status,
      createdAt: account.createdAt,
    };
  });

  return { users };
});

/**
 * List all sub-accounts for a specific user.
 * Reads from ledgerAccounts/{userId}/subAccounts/ (bypasses security rules).
 */
export const adminListUserSubAccounts = functions.https.onCall(
  async (data: { userId: string }, context) => {
    requireAppCheck(context, "adminListUserSubAccounts");
    await requireAdmin(context);

    const { userId } = data;
    if (!userId) {
      throw new functions.https.HttpsError(
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
  }
);

// ============================================================================
// SOFT-DELETE CLIENT
// ============================================================================

/**
 * Soft-delete a client: refund remaining balance to Treasury, close ledger account,
 * cascade soft-delete to all threads, opportunities, and sub-accounts.
 */
export const adminSoftDeleteClient = functions.https.onCall(
  async (
    data: {
      clientId: string;
      reason?: string;
    },
    context
  ) => {
    requireAppCheck(context, "adminSoftDeleteClient");
    await requireAdmin(context);

    const { clientId, reason } = data;
    if (!clientId) {
      throw new functions.https.HttpsError("invalid-argument", "clientId is required");
    }

    const clientRef = db.collection("clients").doc(clientId);
    const clientDoc = await clientRef.get();

    if (!clientDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Client not found");
    }

    const client = clientDoc.data()!;
    if (client.isDeleted === true) {
      throw new functions.https.HttpsError("failed-precondition", "Client is already deleted");
    }

    const uid = context.auth!.uid;
    const now = admin.firestore.FieldValue.serverTimestamp();
    const accountId = AccountId.client(clientId);

    // 1. Refund remaining ledger balance to Treasury
    let refundedAmount = 0;
    const balance = await getBalance(accountId);

    if (balance > 0) {
      const { postJournal } = await import("./ledger/journals");

      const result = await postJournal({
        idempotencyKey: `client_delete_refund:${clientId}:${Date.now()}`,
        type: "adjustment",
        description: `Client deleted: balance refund to Treasury. Reason: ${reason || "No reason provided"}`,
        entries: [
          {
            accountId,
            entryType: "debit",
            amount: balance,
            description: "Balance refund on client deletion",
          },
          {
            accountId: SystemAccounts.TREASURY,
            entryType: "credit",
            amount: balance,
            description: "Client deletion refund",
          },
        ],
        referenceType: "system",
        referenceId: clientId,
        initiatedBy: uid,
        metadata: { deletionReason: reason || null },
      });

      if (!result.success) {
        throw new functions.https.HttpsError(
          "internal",
          `Failed to refund balance: ${result.error}`
        );
      }
      refundedAmount = balance;
    }

    // 2. Close ledger account (requires balance == 0, which step 1 ensures)
    const closeResult = await closeAccount(
      accountId,
      reason || "Client deleted by admin",
      uid
    );
    if (!closeResult.success) {
      // Non-fatal: account may already be closed or frozen
      console.warn(`Could not close ledger account ${accountId}: ${closeResult.error}`);
    }

    // 3. Cascade soft-delete to all threads and their opportunities
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
        deletedAt: now,
        deletedBy: uid,
        updatedAt: now,
      });
      deletedThreads++;
    }

    // 4. Soft-delete all sub-accounts
    const subAccountsSnapshot = await clientRef.collection("subAccounts").get();
    if (!subAccountsSnapshot.empty) {
      const subBatch = db.batch();
      for (const saDoc of subAccountsSnapshot.docs) {
        subBatch.update(saDoc.ref, {
          isDeleted: true,
          isActive: false,
          balance: 0,
          deletedAt: now,
          updatedAt: now,
        });
      }
      await subBatch.commit();
    }

    // 5. Mark client as deleted
    await clientRef.update({
      isDeleted: true,
      deletedAt: now,
      deletedBy: uid,
      deletionReason: reason || null,
      status: "closed",
      updatedAt: now,
    });

    return {
      success: true,
      refundedAmount,
      deletedThreads,
      deletedOpportunities,
    };
  }
);
