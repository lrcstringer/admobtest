/**
 * Marketplace Escrow Functions
 *
 * Provides dedicated ledger operations for marketplace buy/sell escrow.
 * Uses MARKETPLACE_ESCROW system account for proper double-entry tracking.
 *
 * Flow: Buyer → MARKETPLACE_ESCROW → Seller (on receipt confirmation)
 *       MARKETPLACE_ESCROW → Buyer (on cancel/dispute refund)
 */

import { SystemAccounts, AccountId, IdempotencyKey } from "./types";
import { postJournal } from "./journals";
import { ensureSystemAccounts, getOrCreateUserAccount } from "./accounts";

/**
 * Debit buyer's wallet and credit marketplace escrow.
 * Called when a marketplace purchase is created.
 */
export async function processMarketplaceEscrow(
  buyerId: string,
  amount: number,
  orderId: string,
  description: string,
  overrideIdempotencyKey?: string
): Promise<string> {
  await Promise.all([ensureSystemAccounts(), getOrCreateUserAccount(buyerId)]);

  const buyerAccountId = AccountId.user(buyerId);
  const escrowAccountId = SystemAccounts.MARKETPLACE_ESCROW;
  const idempotencyKey = overrideIdempotencyKey || IdempotencyKey.marketplaceEscrow(orderId);

  const result = await postJournal({
    idempotencyKey,
    type: "marketplace_escrow",
    description,
    entries: [
      { accountId: buyerAccountId, entryType: "debit", amount },
      { accountId: escrowAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: orderId,
    initiatedBy: buyerId,
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to escrow tokens for marketplace order");
  }

  return result.journalId!;
}

/**
 * Debit marketplace escrow and credit seller's wallet.
 * Called when buyer confirms receipt.
 */
export async function releaseMarketplaceEscrow(
  sellerId: string,
  amount: number,
  orderId: string,
  description: string,
  overrideIdempotencyKey?: string
): Promise<string> {
  await Promise.all([ensureSystemAccounts(), getOrCreateUserAccount(sellerId)]);

  const sellerAccountId = AccountId.user(sellerId);
  const escrowAccountId = SystemAccounts.MARKETPLACE_ESCROW;
  const idempotencyKey = overrideIdempotencyKey || IdempotencyKey.marketplaceRelease(orderId);

  const result = await postJournal({
    idempotencyKey,
    type: "marketplace_release",
    description,
    entries: [
      { accountId: escrowAccountId, entryType: "debit", amount },
      { accountId: sellerAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: orderId,
    initiatedBy: "system",
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to release escrow to seller");
  }

  return result.journalId!;
}

/**
 * Refund marketplace escrow back to buyer.
 * Called on cancellation or dispute resolution in buyer's favour.
 */
export async function refundMarketplaceEscrow(
  buyerId: string,
  amount: number,
  orderId: string,
  description: string,
  overrideIdempotencyKey?: string
): Promise<string> {
  await Promise.all([ensureSystemAccounts(), getOrCreateUserAccount(buyerId)]);

  const buyerAccountId = AccountId.user(buyerId);
  const escrowAccountId = SystemAccounts.MARKETPLACE_ESCROW;
  const idempotencyKey = overrideIdempotencyKey || IdempotencyKey.marketplaceRefund(orderId);

  const result = await postJournal({
    idempotencyKey,
    type: "marketplace_refund",
    description,
    entries: [
      { accountId: escrowAccountId, entryType: "debit", amount },
      { accountId: buyerAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: orderId,
    initiatedBy: "system",
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to refund escrow to buyer");
  }

  return result.journalId!;
}
