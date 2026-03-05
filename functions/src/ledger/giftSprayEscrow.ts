/**
 * Gift & Token Spray Escrow Functions
 *
 * Provides dedicated ledger operations for gift and spray token flows.
 * Uses GIFT_ESCROW and SPRAY_ESCROW system accounts for proper
 * double-entry tracking.
 */

import { SystemAccounts, AccountId, IdempotencyKey } from "./types";
import { postJournal } from "./journals";
import { ensureSystemAccounts, getOrCreateUserAccount } from "./accounts";

/**
 * Debit sender's wallet and credit gift escrow.
 * Called when a gift is created.
 */
export async function processGiftDebit(
  senderId: string,
  amount: number,
  giftId: string,
  description: string
): Promise<string> {
  await ensureSystemAccounts();
  await getOrCreateUserAccount(senderId);

  const senderAccountId = AccountId.user(senderId);
  const escrowAccountId = SystemAccounts.GIFT_ESCROW;
  const idempotencyKey = IdempotencyKey.giftDebit(giftId);

  const result = await postJournal({
    idempotencyKey,
    type: "gift_debit",
    description,
    entries: [
      { accountId: senderAccountId, entryType: "debit", amount },
      { accountId: escrowAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: giftId,
    initiatedBy: senderId,
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to debit sender for gift");
  }

  return result.journalId!;
}

/**
 * Debit gift escrow and credit recipient's wallet.
 * Called when a gift is claimed.
 */
export async function processGiftCredit(
  recipientId: string,
  amount: number,
  giftId: string,
  description: string
): Promise<string> {
  await ensureSystemAccounts();
  await getOrCreateUserAccount(recipientId);

  const recipientAccountId = AccountId.user(recipientId);
  const escrowAccountId = SystemAccounts.GIFT_ESCROW;
  const idempotencyKey = IdempotencyKey.giftCredit(giftId);

  const result = await postJournal({
    idempotencyKey,
    type: "gift_credit",
    description,
    entries: [
      { accountId: escrowAccountId, entryType: "debit", amount },
      { accountId: recipientAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: giftId,
    initiatedBy: "system",
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to credit recipient for gift");
  }

  return result.journalId!;
}

/**
 * Refund gift escrow back to sender.
 * Called when a gift expires unclaimed.
 */
export async function processGiftRefund(
  senderId: string,
  amount: number,
  giftId: string,
  description: string
): Promise<string> {
  await ensureSystemAccounts();
  await getOrCreateUserAccount(senderId);

  const senderAccountId = AccountId.user(senderId);
  const escrowAccountId = SystemAccounts.GIFT_ESCROW;
  const idempotencyKey = IdempotencyKey.giftRefund(giftId);

  const result = await postJournal({
    idempotencyKey,
    type: "gift_refund",
    description,
    entries: [
      { accountId: escrowAccountId, entryType: "debit", amount },
      { accountId: senderAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: giftId,
    initiatedBy: "system",
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to refund sender for expired gift");
  }

  return result.journalId!;
}

/**
 * Debit contributor's wallet and credit spray escrow.
 * Called for each spray contribution.
 */
export async function processSprayContributionDebit(
  contributorId: string,
  amount: number,
  sprayId: string,
  description: string
): Promise<string> {
  await ensureSystemAccounts();
  await getOrCreateUserAccount(contributorId);

  const contributorAccountId = AccountId.user(contributorId);
  const escrowAccountId = SystemAccounts.SPRAY_ESCROW;
  const idempotencyKey = IdempotencyKey.sprayContribution(sprayId, contributorId);

  const result = await postJournal({
    idempotencyKey,
    type: "spray_contribution",
    description,
    entries: [
      { accountId: contributorAccountId, entryType: "debit", amount },
      { accountId: escrowAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: sprayId,
    initiatedBy: contributorId,
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to debit contributor for spray");
  }

  return result.journalId!;
}

/**
 * Debit spray escrow and credit recipient.
 * Called when spray is closed or claimed.
 */
export async function processSprayPayout(
  recipientId: string,
  amount: number,
  sprayId: string,
  description: string
): Promise<string> {
  await ensureSystemAccounts();
  await getOrCreateUserAccount(recipientId);

  const recipientAccountId = AccountId.user(recipientId);
  const escrowAccountId = SystemAccounts.SPRAY_ESCROW;
  const idempotencyKey = IdempotencyKey.sprayPayout(sprayId);

  const result = await postJournal({
    idempotencyKey,
    type: "spray_payout",
    description,
    entries: [
      { accountId: escrowAccountId, entryType: "debit", amount },
      { accountId: recipientAccountId, entryType: "credit", amount },
    ],
    referenceType: "transfer",
    referenceId: sprayId,
    initiatedBy: "system",
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to pay out spray to recipient");
  }

  return result.journalId!;
}
