/**
 * Group Buy Escrow Functions
 *
 * Provides dedicated ledger operations for group buy (Hlangana) escrow.
 * Uses GROUP_BUY_ESCROW system account for proper double-entry tracking.
 *
 * Flow: Contributor → GROUP_BUY_ESCROW (on join)
 *       GROUP_BUY_ESCROW → Organizer (on target met / completion)
 *       GROUP_BUY_ESCROW → Contributor (on expiry / cancellation refund)
 */

import { SystemAccounts, AccountId, IdempotencyKey } from "./types";
import { postJournal } from "./journals";
import { ensureSystemAccounts, getOrCreateUserAccount } from "./accounts";

/**
 * Debit contributor's wallet and credit group buy escrow.
 * Called when a user joins a group buy.
 */
export async function processGroupBuyEscrow(
  userId: string,
  amount: number,
  groupBuyId: string,
  description: string
): Promise<string> {
  await Promise.all([ensureSystemAccounts(), getOrCreateUserAccount(userId)]);

  const userAccountId = AccountId.user(userId);
  const escrowAccountId = SystemAccounts.GROUP_BUY_ESCROW;
  const idempotencyKey = IdempotencyKey.groupBuyEscrow(groupBuyId, userId);

  const result = await postJournal({
    idempotencyKey,
    type: "group_buy_escrow",
    description,
    entries: [
      { accountId: userAccountId, entryType: "debit", amount },
      { accountId: escrowAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: groupBuyId,
    initiatedBy: userId,
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to escrow tokens for group buy");
  }

  return result.journalId!;
}

/**
 * Debit group buy escrow and credit organizer's wallet.
 * Called when the group buy target is met and the deal completes.
 */
export async function releaseGroupBuyEscrow(
  organizerId: string,
  amount: number,
  groupBuyId: string,
  description: string
): Promise<string> {
  await Promise.all([ensureSystemAccounts(), getOrCreateUserAccount(organizerId)]);

  const organizerAccountId = AccountId.user(organizerId);
  const escrowAccountId = SystemAccounts.GROUP_BUY_ESCROW;
  const idempotencyKey = IdempotencyKey.groupBuyRelease(groupBuyId);

  const result = await postJournal({
    idempotencyKey,
    type: "group_buy_release",
    description,
    entries: [
      { accountId: escrowAccountId, entryType: "debit", amount },
      { accountId: organizerAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: groupBuyId,
    initiatedBy: "system",
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to release group buy escrow");
  }

  return result.journalId!;
}

/**
 * Refund group buy escrow back to individual contributor.
 * Called on expiry or cancellation.
 */
export async function refundGroupBuyContribution(
  userId: string,
  amount: number,
  groupBuyId: string,
  description: string
): Promise<string> {
  await Promise.all([ensureSystemAccounts(), getOrCreateUserAccount(userId)]);

  const userAccountId = AccountId.user(userId);
  const escrowAccountId = SystemAccounts.GROUP_BUY_ESCROW;
  const idempotencyKey = IdempotencyKey.groupBuyRefund(groupBuyId, userId);

  const result = await postJournal({
    idempotencyKey,
    type: "group_buy_refund",
    description,
    entries: [
      { accountId: escrowAccountId, entryType: "debit", amount },
      { accountId: userAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: groupBuyId,
    initiatedBy: "system",
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to refund group buy contribution");
  }

  return result.journalId!;
}
