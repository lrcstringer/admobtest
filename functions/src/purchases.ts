/**
 * Purchase-related Cloud Functions
 * Handles airtime, data, electricity purchases
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Process a service purchase (airtime, data, electricity)
 * In a real app, this would integrate with a VAS provider API
 */
export const processPurchase = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { purchaseId } = data;

  if (!purchaseId) {
    throw new functions.https.HttpsError("invalid-argument", "Purchase ID is required");
  }

  // Get purchase document
  const purchaseRef = db.collection("purchases").doc(purchaseId);
  const purchaseDoc = await purchaseRef.get();

  if (!purchaseDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Purchase not found");
  }

  const purchase = purchaseDoc.data();

  if (purchase?.oddienceUserId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized to process this purchase");
  }

  if (purchase?.status !== "pending") {
    throw new functions.https.HttpsError("failed-precondition", "Purchase is not in pending state");
  }

  try {
    // Update status to processing
    await purchaseRef.update({
      status: "processing",
      processedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Simulate VAS provider API call
    // In production, this would call the actual provider API
    const result = await simulateVasProviderCall(purchase);

    if (result.success) {
      // Update purchase as completed
      await purchaseRef.update({
        status: "completed",
        voucherCode: result.voucherCode,
        voucherPin: result.voucherPin,
        reference: result.reference,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Update transaction status
      const txQuery = await db.collection("transactions")
        .where("referenceId", "==", purchaseId)
        .where("referenceType", "==", "purchase")
        .limit(1)
        .get();

      if (!txQuery.empty) {
        await txQuery.docs[0].ref.update({
          status: "completed",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      return {
        success: true,
        voucherCode: result.voucherCode,
        voucherPin: result.voucherPin,
        reference: result.reference,
      };
    } else {
      throw new Error(result.error || "Purchase failed");
    }
  } catch (error) {
    // Handle failure - refund tokens
    await handlePurchaseFailure(purchaseRef, purchase, error);

    throw new functions.https.HttpsError("internal", `Purchase failed: ${error}`);
  }
});

/**
 * Simulate VAS provider API call
 * In production, replace with actual API integration
 */
async function simulateVasProviderCall(purchase: FirebaseFirestore.DocumentData): Promise<{
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

/**
 * Handle purchase failure - refund tokens
 */
async function handlePurchaseFailure(
  purchaseRef: FirebaseFirestore.DocumentReference,
  purchase: FirebaseFirestore.DocumentData,
  error: unknown
) {
  await db.runTransaction(async (transaction) => {
    // Update purchase as failed
    transaction.update(purchaseRef, {
      status: "failed",
      failureReason: String(error),
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Refund tokens to wallet
    const walletQuery = await db.collection("wallets")
      .where("oddienceUserId", "==", purchase.oddienceUserId)
      .limit(1)
      .get();

    if (!walletQuery.empty) {
      const walletDoc = walletQuery.docs[0];
      transaction.update(walletDoc.ref, {
        tokenBalance: admin.firestore.FieldValue.increment(purchase.tokenAmount),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Create refund transaction
      const refundRef = db.collection("transactions").doc();
      transaction.set(refundRef, {
        id: refundRef.id,
        walletId: walletDoc.id,
        oddienceUserId: purchase.oddienceUserId,
        type: "refund",
        tokenAmount: purchase.tokenAmount,
        zarAmount: purchase.zarAmount,
        description: `Refund for failed purchase: ${purchase.productName}`,
        status: "completed",
        referenceId: purchaseRef.id,
        referenceType: "purchase",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // Update original transaction as failed
    const txQuery = await db.collection("transactions")
      .where("referenceId", "==", purchaseRef.id)
      .where("referenceType", "==", "purchase")
      .limit(1)
      .get();

    if (!txQuery.empty) {
      transaction.update(txQuery.docs[0].ref, {
        status: "failed",
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
  });
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
