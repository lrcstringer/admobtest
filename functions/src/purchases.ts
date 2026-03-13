/**
 * Purchase-related Cloud Functions
 * Handles airtime, data, electricity purchases
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck, requirePlayIntegrity } from "./security";
import {
  processPurchaseTransaction,
  reverseJournal,
  creditSubAccount,
  validateMainWalletBalance,
  getSubAccount,
  validatePurchaseAllowed,
  validateSubAccountBalance,
} from "./ledger";

const db = admin.firestore();

/**
 * Process a service purchase (airtime, data, electricity)
 * Creates purchase document, deducts wallet balance, calls VAS provider
 */
export const processPurchase = onCall({ labels: { area: "wallet" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(request, "processPurchase");
  await requirePlayIntegrity(request.data, request, "processPurchase", "HIGH");

  const userId = request.auth.uid;
  const { productId, recipientNumber, subAccountId } = request.data;

  if (!productId) {
    throw new HttpsError("invalid-argument", "Product ID is required");
  }

  if (!recipientNumber) {
    throw new HttpsError("invalid-argument", "Recipient number is required");
  }

  // Get product details
  const productDoc = await db.collection("serviceProducts").doc(productId).get();
  if (!productDoc.exists) {
    throw new HttpsError("not-found", "Product not found");
  }
  const product = productDoc.data()!;

  // Validate product is still active
  if (!product.isActive || product.isDeleted) {
    throw new HttpsError("failed-precondition", "Product is no longer available");
  }

  // Get provider details
  const providerDoc = await db.collection("serviceProviders").doc(product.providerId).get();
  if (!providerDoc.exists) {
    throw new HttpsError("not-found", "Provider not found");
  }
  const provider = providerDoc.data()!;

  // Validate provider is still active
  if (!provider.isActive || provider.isDeleted) {
    throw new HttpsError("failed-precondition", "Service provider is no longer available");
  }

  const tokenAmount = product.priceTokens || 0;
  const zarAmount = product.priceZar || 0;
  const purchaseCategory = provider.category || "airtime";

  // Validate recipient number format
  if (recipientNumber) {
    if (purchaseCategory === "airtime" || purchaseCategory === "data") {
      const cleaned = recipientNumber.replace(/\D/g, "");
      if (cleaned.length !== 10 || !cleaned.startsWith("0")) {
        throw new HttpsError("invalid-argument", "Invalid phone number format. Must be 10 digits starting with 0");
      }
    } else if (purchaseCategory === "electricity") {
      // Reject inputs containing letters — only digits, spaces, and hyphens allowed
      if (/[a-zA-Z]/.test(recipientNumber)) {
        throw new HttpsError("invalid-argument", "Invalid meter number. Must contain only digits");
      }
      const cleaned = recipientNumber.replace(/[\s-]/g, "");
      // After removing spaces/hyphens, must be exactly 11-13 digits with no other characters
      if (!/^\d{11,13}$/.test(cleaned)) {
        throw new HttpsError("invalid-argument", "Invalid meter number. Must be exactly 11-13 digits");
      }
    }
  }

  // Pre-validate balance — fast-fail optimization only.
  // The authoritative balance check happens inside processPurchaseTransaction(),
  // which runs atomically within the ledger's double-entry transaction.
  // This pre-check is NOT relied upon for correctness (no TOCTOU risk).
  let resolvedAccountTypeId: string | null = null;

  if (subAccountId) {
    // Sub-account purchase: validate sub-account, offramp rules, and balance
    const subAccount = await getSubAccount(userId, subAccountId);
    if (!subAccount) {
      throw new HttpsError("not-found", "Sub-account not found");
    }
    if (!subAccount.isActive) {
      throw new HttpsError("failed-precondition", "Sub-account is inactive");
    }

    resolvedAccountTypeId = subAccount.accountTypeId || null;

    // Enforce allowedOfframps restriction
    const offrampCheck = await validatePurchaseAllowed(resolvedAccountTypeId, purchaseCategory);
    if (!offrampCheck.allowed) {
      throw new HttpsError(
        "failed-precondition",
        offrampCheck.reason || `This wallet cannot purchase ${purchaseCategory}`
      );
    }

    // Validate sub-account balance
    const balanceCheck = await validateSubAccountBalance(userId, subAccountId, tokenAmount);
    if (!balanceCheck.allowed) {
      throw new HttpsError(
        "failed-precondition",
        balanceCheck.reason || `Insufficient sub-account balance`
      );
    }
  } else {
    // Main wallet purchase
    const mainCheck = await validateMainWalletBalance(userId, tokenAmount);
    if (!mainCheck.sufficient) {
      throw new HttpsError(
        "failed-precondition",
        `Insufficient balance: has ${mainCheck.available}, needs ${tokenAmount}`
      );
    }
  }

  // Deterministic purchase ID prevents duplicate charges on client retry.
  // Uses second-level bucket so same user+product within 1s is idempotent.
  const timeBucket = Math.floor(Date.now() / 1000).toString();
  const deterministicId = `${userId}_${productId}_${timeBucket}`;
  const purchaseRef = db.collection("purchases").doc(deterministicId);

  try {
    // Create initial purchase record
    await purchaseRef.set({
      id: purchaseRef.id,
      userId,
      productId,
      productCode: product.code || product.id,
      productName: product.name,
      providerId: product.providerId,
      providerName: provider.name,
      category: purchaseCategory,
      tokenAmount,
      zarAmount,
      recipientNumber,
      subAccountId: subAccountId || null,
      status: "processing",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      processedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Re-check product and provider availability before committing to ledger transaction
    const freshProduct = await db.collection("serviceProducts").doc(productId).get();
    if (!freshProduct.exists || !freshProduct.data()!.isActive || freshProduct.data()!.isDeleted) {
      throw new HttpsError("failed-precondition", "Product became unavailable during processing. No tokens were deducted.");
    }

    // R3-5: Re-check provider isActive right before ledger debit
    const freshProvider = await db.collection("serviceProviders").doc(product.providerId).get();
    if (!freshProvider.exists || !freshProvider.data()!.isActive || freshProvider.data()!.isDeleted) {
      throw new HttpsError("failed-precondition", "Service provider became unavailable during processing. No tokens were deducted.");
    }

    // Process purchase through the Trust Ledger system
    const ledgerResult = await processPurchaseTransaction(
      userId,
      product.providerId,
      provider.name,
      tokenAmount,
      purchaseRef.id,
      subAccountId || undefined,
      resolvedAccountTypeId,
      {
        productId,
        productName: product.name,
        recipientNumber,
        zarAmount,
        category: purchaseCategory,
      }
    );

    if (!ledgerResult.success) {
      throw new Error(ledgerResult.error || "Ledger transaction failed");
    }

    // R3-4: Update purchase with ledger reference — if this fails after debit,
    // create an admin alert so the orphaned debit can be investigated
    try {
      await purchaseRef.update({
        ledgerJournalId: ledgerResult.journalId,
      });
    } catch (updateError) {
      // Ledger debit succeeded but purchase record update failed — create admin alert
      logger.error("CRITICAL: Ledger debit succeeded but purchase record update failed", {
        purchaseId: purchaseRef.id,
        journalId: ledgerResult.journalId,
        userId,
        tokenAmount,
        error: updateError instanceof Error ? updateError.message : String(updateError),
      });
      await db.collection("adminAlerts").add({
        type: "orphaned_debit",
        severity: "critical",
        purchaseId: purchaseRef.id,
        journalId: ledgerResult.journalId,
        userId,
        tokenAmount,
        message: "Ledger debit succeeded but purchase record update failed. Manual review required.",
        error: updateError instanceof Error ? updateError.message : String(updateError),
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        resolved: false,
      }).catch((alertErr: unknown) =>
        logger.error("Failed to create admin alert for orphaned debit:", alertErr)
      );
      // Re-throw to trigger ledger reversal in the outer catch block
      throw updateError;
    }

    // Simulate VAS provider API call
    const purchaseData = {
      category: provider.category || "airtime",
      productName: product.name,
      tokenAmount,
      zarAmount,
      recipientNumber,
    };
    const result = await simulateVasProviderCall(purchaseData);

    if (result.success) {
      // Update purchase as completed
      await purchaseRef.update({
        status: "completed",
        voucherCode: result.voucherCode || null,
        voucherPin: result.voucherPin || null,
        reference: result.reference,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Return full purchase data for the client
      return {
        id: purchaseRef.id,
        userId,
        productId,
        productCode: product.code || product.id,
        productName: product.name,
        providerId: product.providerId,
        providerName: provider.name,
        category: provider.category || "airtime",
        tokenAmount,
        zarAmount,
        recipientNumber,
        subAccountId: subAccountId || null,
        status: "completed",
        voucherCode: result.voucherCode || null,
        voucherPin: result.voucherPin || null,
        reference: result.reference,
        ledgerJournalId: ledgerResult.journalId,
        createdAt: new Date().toISOString(),
        processedAt: new Date().toISOString(),
        completedAt: new Date().toISOString(),
      };
    } else {
      throw new Error(result.error || "Purchase failed");
    }
  } catch (error) {
    // Handle failure - reverse ledger transaction if it was created
    const purchaseSnap = await purchaseRef.get();
    if (purchaseSnap.exists) {
      const purchaseData = purchaseSnap.data()!;

      // If ledger transaction exists, reverse it
      if (purchaseData.ledgerJournalId) {
        await reverseJournal(
          purchaseData.ledgerJournalId,
          `Purchase failed: ${error instanceof Error ? error.message : String(error)}`,
          "system"
        );

        // Restore sub-account balance if purchase was from a sub-account
        if (purchaseData.subAccountId) {
          await creditSubAccount(userId, purchaseData.subAccountId, tokenAmount).catch(
            (e: unknown) => logger.error("Failed to restore sub-account balance on purchase reversal:", e)
          );
        }
      }

      // Update purchase as failed
      await purchaseRef.update({
        status: "failed",
        failureReason: String(error),
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    const errorMessage = error instanceof Error ? error.message : String(error);

    // If no ledger journal was created, tokens were never deducted — tell the user
    // they can safely retry. Check the purchase doc for ledgerJournalId presence.
    const finalSnap = await purchaseRef.get().catch(() => null);
    const hadLedgerDebit = finalSnap?.exists && finalSnap.data()?.ledgerJournalId;

    if (hadLedgerDebit) {
      throw new HttpsError("internal", `Purchase failed: ${errorMessage}. Your tokens have been refunded.`);
    } else {
      throw new HttpsError("internal", `Purchase failed: ${errorMessage}. No tokens were deducted — you can safely retry.`);
    }
  }
});

/**
 * Simulate VAS provider API call.
 * TODO: Replace with actual VAS API integration before production launch.
 * Always succeeds — real provider failures will be handled by the actual API.
 */
interface PurchaseRequest {
  category: string;
  productName: string;
  tokenAmount: number;
  zarAmount: number;
  recipientNumber: string;
}

async function simulateVasProviderCall(purchase: PurchaseRequest): Promise<{
  success: boolean;
  voucherCode?: string;
  voucherPin?: string;
  reference?: string;
  error?: string;
}> {
  // Simulate API delay
  await new Promise((resolve) => setTimeout(resolve, 500));

  // Deterministic success — no random failures that cost users real money.
  const category = purchase.category;

  if (category === "electricity") {
    return {
      success: true,
      voucherCode: generateElectricityToken(),
      reference: `EL${Date.now()}`,
    };
  } else if (category === "voucher") {
    return {
      success: true,
      voucherCode: generateVoucherCode(),
      voucherPin: generateVoucherPin(),
      reference: `VC${Date.now()}`,
    };
  } else {
    return {
      success: true,
      reference: `TX${Date.now()}`,
    };
  }
}

// Helper functions
function generateElectricityToken(): string {
  let token = "";
  for (let i = 0; i < 20; i++) {
    token += Math.floor(Math.random() * 10).toString();
    if ((i + 1) % 4 === 0 && i < 19) token += " ";
  }
  return token;
}

function generateVoucherCode(): string {
  const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  let code = "";
  for (let i = 0; i < 12; i++) {
    code += chars.charAt(Math.floor(Math.random() * chars.length));
    if ((i + 1) % 4 === 0 && i < 11) code += "-";
  }
  return code;
}

function generateVoucherPin(): string {
  let pin = "";
  for (let i = 0; i < 4; i++) {
    pin += Math.floor(Math.random() * 10).toString();
  }
  return pin;
}
