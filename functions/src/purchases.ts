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
  const { productId, recipientNumber } = request.data;

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

  // Get provider details
  const providerDoc = await db.collection("serviceProviders").doc(product.providerId).get();
  if (!providerDoc.exists) {
    throw new HttpsError("not-found", "Provider not found");
  }
  const provider = providerDoc.data()!;

  const tokenAmount = product.priceTokens || 0;
  const zarAmount = product.priceZar || 0;
  const purchaseCategory = provider.category || "airtime";

  // Validate user balance (main ledger account IS the default wallet)
  const mainCheck = await validateMainWalletBalance(userId, tokenAmount);
  if (!mainCheck.sufficient) {
    throw new HttpsError(
      "failed-precondition",
      `Insufficient balance: has ${mainCheck.available}, needs ${tokenAmount}`
    );
  }

  // Create purchase document first
  const purchaseRef = db.collection("purchases").doc();

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
      subAccountId: null,
      status: "processing",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      processedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Process purchase through the Trust Ledger system
    const ledgerResult = await processPurchaseTransaction(
      userId,
      product.providerId,
      provider.name,
      tokenAmount,
      purchaseRef.id,
      undefined, // main wallet — no sub-account needed
      null, // no account type
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

    // Update purchase with ledger reference
    await purchaseRef.update({
      ledgerJournalId: ledgerResult.journalId,
    });

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
    throw new HttpsError("internal", `Purchase failed: ${errorMessage}`);
  }
});

/**
 * Get purchase details by ID
 */
export const getPurchaseDetails = onCall({ labels: { area: "wallet" } }, async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  requireAppCheck(request, "getPurchaseDetails");

  const userId = request.auth.uid;
  const { purchaseId } = request.data;

  if (!purchaseId) {
    throw new HttpsError("invalid-argument", "Purchase ID is required");
  }

  const purchaseDoc = await db.collection("purchases").doc(purchaseId).get();

  if (!purchaseDoc.exists) {
    throw new HttpsError("not-found", "Purchase not found");
  }

  const purchase = purchaseDoc.data()!;

  if (purchase.userId !== userId) {
    throw new HttpsError("permission-denied", "Not authorized to view this purchase");
  }

  return {
    ...purchase,
    createdAt: purchase.createdAt?.toDate?.()?.toISOString() || null,
    processedAt: purchase.processedAt?.toDate?.()?.toISOString() || null,
    completedAt: purchase.completedAt?.toDate?.()?.toISOString() || null,
  };
});

/**
 * Simulate VAS provider API call
 * In production, replace with actual API integration
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
  await new Promise((resolve) => setTimeout(resolve, 1000));

  // Simulate success (95% success rate for demo)
  const isSuccess = Math.random() > 0.05;

  if (isSuccess) {
    const category = purchase.category;

    if (category === "electricity") {
      // Electricity returns a token
      return {
        success: true,
        voucherCode: generateElectricityToken(),
        reference: `EL${Date.now()}`,
      };
    } else if (category === "voucher") {
      // Vouchers return code and PIN
      return {
        success: true,
        voucherCode: generateVoucherCode(),
        voucherPin: generateVoucherPin(),
        reference: `VC${Date.now()}`,
      };
    } else {
      // Airtime/data just needs reference
      return {
        success: true,
        reference: `TX${Date.now()}`,
      };
    }
  } else {
    return {
      success: false,
      error: "Provider unavailable. Please try again.",
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
