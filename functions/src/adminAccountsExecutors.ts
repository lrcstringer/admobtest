/**
 * Executor functions for maker-checker pending actions.
 *
 * These extract the core business logic from adminFundClientAccount,
 * adminRefundClient, and completeCashoutRequest so they can be invoked
 * by the adminApproveAction handler after checker approval.
 */

import * as admin from "firebase-admin";
import { postJournal } from "./ledger/journals";
import { AccountId, IdempotencyKey, SystemAccounts } from "./ledger/types";
import { completeCashout } from "./ledger";

const db = admin.firestore();

/**
 * Execute client funding: DR cbook CR client.
 * Extracted from adminFundClientAccount.
 */
export async function executeFundClient(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { clientId, amount, reference, paymentMethod, makerUid } = payload as {
    clientId: string;
    amount: number;
    reference: string;
    paymentMethod?: string;
    makerUid?: string;
  };

  // Guard: cannot fund a deleted client
  const clientDoc = await db.collection("clients").doc(clientId).get();
  if (clientDoc.data()?.isDeleted === true) {
    throw new Error("Cannot fund a deleted client");
  }

  const accountId = AccountId.client(clientId);
  const isImalichat = clientId === "imalichat";
  const cbookAccount = isImalichat
    ? SystemAccounts.CBOOK_BUS
    : SystemAccounts.CBOOK_TRUST;

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.clientFund(clientId, reference),
    type: "client_fund",
    description: `Client account funding: ${reference}`,
    entries: [
      {
        accountId: cbookAccount,
        entryType: "debit",
        amount,
        description: `Fund client ${clientId}`,
      },
      {
        accountId,
        entryType: "credit",
        amount,
        description: "Account credit from funding",
      },
    ],
    referenceType: "client_fund",
    referenceId: reference,
    initiatedBy: makerUid || "system",
    metadata: { paymentMethod, fundedBy: makerUid, cbookAccount, approvedVia: "maker-checker" },
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to fund account");
  }

  await db.collection("clients").doc(clientId).update({
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return {
    success: true,
    journalId: result.journalId,
    newBalance: result.data?.entries.find((e) => e.accountId === accountId)?.balanceAfter,
  };
}

/**
 * Execute client refund: DR client CR cbook.
 * Extracted from adminRefundClient.
 */
export async function executeRefundClient(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { clientId, amount, reason, makerUid } = payload as {
    clientId: string;
    amount: number;
    reason: string;
    makerUid?: string;
  };

  const accountId = AccountId.client(clientId);
  const isImalichat = clientId === "imalichat";
  const cbookAccount = isImalichat
    ? SystemAccounts.CBOOK_BUS
    : SystemAccounts.CBOOK_TRUST;

  const reference = `refund_${Date.now()}`;

  const result = await postJournal({
    idempotencyKey: IdempotencyKey.clientRefund(clientId, reference),
    type: "client_refund",
    description: `Client refund: ${reason}`,
    entries: [
      {
        accountId,
        entryType: "debit",
        amount,
        description: `Refund: ${reason}`,
      },
      {
        accountId: cbookAccount,
        entryType: "credit",
        amount,
        description: `Refund from client ${clientId}`,
      },
    ],
    referenceType: "client_fund",
    referenceId: reference,
    initiatedBy: makerUid || "system",
    metadata: { reason, refundedBy: makerUid, cbookAccount, approvedVia: "maker-checker" },
  });

  if (!result.success) {
    throw new Error(result.error || "Failed to refund client");
  }

  return {
    success: true,
    journalId: result.journalId,
    newBalance: result.data?.entries.find((e) => e.accountId === accountId)?.balanceAfter,
  };
}

/**
 * Execute cashout completion: moves from pending to supplier account.
 * Extracted from completeCashoutRequest.
 */
export async function executeCompleteCashout(
  payload: Record<string, unknown>,
): Promise<Record<string, unknown>> {
  const { cashoutId, adminNotes, makerUid } = payload as {
    cashoutId: string;
    adminNotes?: string;
    makerUid?: string;
  };

  const cashoutDoc = await db.collection("cashouts").doc(cashoutId).get();
  if (!cashoutDoc.exists) {
    throw new Error("Cashout not found");
  }

  const cashoutData = cashoutDoc.data()!;
  if (cashoutData.status !== "pending") {
    throw new Error(`Cashout is not pending (status: ${cashoutData.status})`);
  }

  const supplierId = cashoutData.supplierId || "cashout_default";
  const ledgerResult = await completeCashout(
    cashoutId,
    cashoutData.tokenAmount,
    supplierId,
    {
      completedBy: makerUid || "system",
      adminNotes,
      approvedVia: "maker-checker",
    },
  );

  if (!ledgerResult.success) {
    throw new Error(`Failed to complete cashout: ${ledgerResult.error}`);
  }

  await cashoutDoc.ref.update({
    status: "completed",
    completedAt: admin.firestore.FieldValue.serverTimestamp(),
    completedBy: makerUid || "system",
    completionLedgerJournalId: ledgerResult.journalId,
    adminNotes: adminNotes || null,
  });

  return {
    success: true,
    ledgerJournalId: ledgerResult.journalId,
  };
}
