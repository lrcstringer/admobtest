# iMaliChat Trust Ledger — Complete Transaction Map

> **Last updated:** 2 March 2026
>
> This document maps every journal transaction in the iMaliChat double-entry
> ledger system: what triggers it, which accounts are debited and credited,
> and key metadata. Use it as a single source of truth when auditing,
> debugging, or extending the financial system.

---

## Table of Contents

1. [Fundamentals](#1-fundamentals)
2. [System Accounts](#2-system-accounts)
3. [User-Triggered Transactions](#3-user-triggered-transactions)
4. [Scheduled / Automated Transactions](#4-scheduled--automated-transactions)
5. [Idempotency Keys](#5-idempotency-keys)
6. [Configuration Constants](#6-configuration-constants)
7. [Firestore Collections](#7-firestore-collections)
8. [Invariants & Safety Guarantees](#8-invariants--safety-guarantees)

---

## 1. Fundamentals

### Double-Entry Bookkeeping

Every transaction creates a **journal** with two or more **entries** whose
debits and credits must balance exactly. Journals are immutable once posted;
corrections are made via reversal journals.

### Account Types

| Prefix | Type | Normal Balance | Debit Effect | Credit Effect |
|--------|------|---------------|-------------|--------------|
| `cbook:` | Cash book (asset) | Debit-normal | Increases | Decreases |
| `user:` | User wallet | Credit-normal | Decreases | Increases |
| `client:` | Brand budget | Credit-normal | Decreases | Increases |
| `client_subacc:` | Campaign sub-budget | Credit-normal | Decreases | Increases |
| `group:` | Community / stokvel | Credit-normal | Decreases | Increases |
| `pot:` | Pot accumulator | Credit-normal | Decreases | Increases |
| `system:` | System holding | Credit-normal | Decreases | Increases |
| `supplier:` | Payment provider | Credit-normal | Decreases | Increases |

### Token Economics

| Parameter | Value |
|-----------|-------|
| Conversion rate | **100 tokens = R1 ZAR** |
| Earning split | **90%** user / **5%** daily pot / **5%** weekly pot |
| Pot shares use `Math.floor()` | User receives the remainder (avoids fractional tokens) |

### Balance Calculation

```
available = ledgerAccount.balance - ledgerAccount.allocatedBalance
```

A transaction is rejected if `available < requiredAmount`.

---

## 2. System Accounts

All created during ledger initialisation with balance **0**.

| Account ID | Name | Purpose |
|---|---|---|
| `cbook:bus` | Business Cash Book | iMaliChat business asset account |
| `cbook:trust` | Client Trust Cash Book | External client trust holding |
| `pot:daily` | Daily Pot | Accumulates 5% of every earning |
| `pot:weekly` | Weekly Pot | Accumulates 5% of every earning |
| `system:escrow` | Engagement Escrow | Holds tokens during active engagement |
| `system:gift_escrow` | Gift Escrow | Holds gift (Sasaza) tokens until claimed |
| `system:spray_escrow` | Spray Escrow | Holds spray tokens until distributed |
| `system:cashout_pending` | Cashout Pending | Holds tokens between request and bank payout |
| `system:pot_residual` | Pot Residual | Rounding residual from floored pot distributions |
| `client:imalichat` | iMaliChat Client | Funds referral rewards and ad rewards |

Dynamic accounts created on demand:

| Pattern | Created When |
|---|---|
| `user:{userId}` | User first earns or receives tokens |
| `client:{clientId}` | Brand partner is onboarded |
| `client_subacc:{id}` | Campaign sub-account is funded |
| `group:{groupId}` | Community or stokvel is created with financials enabled |
| `supplier:{method}` | Cashout method first used (e.g. `supplier:cashout_eft`) |

---

## 3. User-Triggered Transactions

### 3.1 Earning (Engagement Lifecycle)

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 1 | **Earn screen** → navigate to interaction | Reserve max possible payout in escrow | `client:{clientId}` | `system:escrow` | `startEngagement` | `escrow_reserve` |
| 2 | **Earn screen** → Submit survey / upload | Release escrow, pay user with 90/5/5 split | `system:escrow` | `user:{userId}` (90%), `pot:daily` (5%), `pot:weekly` (5%) | `submitEngagement` | `escrow_release` |
| 3 | *(same as #2, bonus NOT triggered)* | Return excess escrow to brand | `system:escrow` | `client:{clientId}` | `submitEngagement` | `escrow_release` |
| 4 | **Earn screen** → Abandon / leave | Reverse escrow reservation | `system:escrow` | `client:{clientId}` | `abandonEngagement` | reversal |
| 5 | **Earn screen** → AdMob video completes | Ad reward credited to user | `client:imalichat` | `user:{userId}` | `recordAdReward` | `earn` |

### 3.2 Peer-to-Peer Transfers

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 6 | **Wallet Send Amount screen** → "Send" | Direct P2P token transfer | `user:{senderId}` | `user:{recipientId}` | `sendP2PTransfer` | `p2p_transfer` |
| 7 | **Token Actions Sheet** (in conversation) → "Send Instant Tokens" | Send tokens inside a chat | `user:{senderId}` | `user:{recipientId}` | `sendConversationTokens` | `p2p_transfer` |
| 8 | **Token Actions Sheet** (standalone, from Wallet) → "Send Instant Tokens" | Send tokens to any user | `user:{senderId}` | `user:{recipientId}` | `getOrCreateConversation` then `sendConversationTokens` | `p2p_transfer` |
| 9 | **Conversation Detail** → "Accept" on token request | Fulfil incoming token request | `user:{acceptorId}` | `user:{requesterId}` | `acceptConversationTokenRequest` | `p2p_transfer` |
| 10 | **Token Actions Sheet** → "Request Instant Tokens" | Create pending request *(no ledger entry)* | — | — | `requestConversationTokens` | — |
| 11 | **Conversation Detail** → "Decline" on request | Cancel request *(no ledger entry)* | — | — | `declineConversationTokenRequest` | — |

### 3.3 Cashout

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 12 | **Cashout screen** → "Request Cashout" (biometric gate) | Move tokens to pending | `user:{userId}` | `system:cashout_pending` | `processCashout` | `cashout_initiate` |
| 13 | **Admin portal** → Approve cashout | Release to payment provider | `system:cashout_pending` | `supplier:{method}` | `completeCashoutRequest` | `cashout_complete` |
| 14 | **System** → Cashout fails | Refund tokens to user | `system:cashout_pending` | `user:{userId}` | failure handler | `cashout_failed` |

### 3.4 Community / Stokvel

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 15 | **Community Transaction screen** → "Contribute" | Member contributes to group treasury | `user:{memberId}` | `group:{groupId}` | `contributeToCommunity` | `group_contribution` |
| 16 | **Community Transaction screen** → "Request Withdrawal" | Member withdraws from group treasury | `group:{groupId}` | `user:{memberId}` | `withdrawFromCommunity` | `group_withdrawal` |
| 17 | **Community Detail** (admin) → "Approve" | Finalize pending transaction | *(posts deferred journal)* | | `approveCommunityTransaction` | varies |
| 18 | **Community Detail** (admin) → "Reject" | Cancel pending transaction *(no entry)* | — | — | `rejectCommunityTransaction` | — |
| 19 | **Community Detail** (admin) → "Trigger Payout" | Distribute group funds to N members | `group:{groupId}` | `user:{memberId}` (x N) | `triggerCommunityPayout` | `group_payout` |

### 3.5 Gifts (Sasaza)

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 20 | **Gift send flow** → "Send Gift" | Debit sender, hold in escrow | `user:{senderId}` | `system:gift_escrow` | `sendGift` | `gift_debit` |
| 21 | **Gift claim** → "Claim" | Release escrow to recipient | `system:gift_escrow` | `user:{recipientId}` | `claimGift` | `gift_credit` |

### 3.6 Token Sprays

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 22 | **Spray flow** → "Contribute" | Debit contributor, hold in escrow | `user:{contributorId}` | `system:spray_escrow` | `contributeToSpray` | `spray_contribution` |
| 23 | **Spray close / claim** | Release spray to recipient | `system:spray_escrow` | `user:{recipientId}` | spray closure | `spray_payout` |

### 3.7 Purchases

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 24 | **Purchase flow** → "Buy" | User buys from supplier | `user:{userId}` | `supplier:{providerId}` | purchase callable | `purchase` |

### 3.8 Referrals

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 25 | **Auto** on referral completion | Reward both parties | `client:imalichat` | `user:{referrerId}` (100 tk) + `user:{refereeId}` (50 tk) | referral handler | `referral_reward` |

### 3.9 Admin Operations

| # | Trigger | Description | Debit | Credit | Cloud Function | Journal Type |
|---|---------|-------------|-------|--------|---------------|-------------|
| 26 | **Admin** → Fund sub-account | Allocate brand budget to campaign | `client:{clientId}` | `client_subacc:{id}` | admin funding | `subacc_fund` |
| 27 | **Admin / System** → Journal reversal | Undo any journal (entries swapped) | *(reverses original)* | *(reverses original)* | `reverseJournal` | `reversal` |

---

## 4. Scheduled / Automated Transactions

These run on Cloud Scheduler with no direct user interaction.

### 4.1 Pot Draws

| # | Function | Schedule | Description | Debit | Credit |
|---|----------|----------|-------------|-------|--------|
| 28 | `runDailyPotDraw` | Daily 20:00 SAST | Top 10 leaderboard share daily pot | `pot:daily` | `user:{winnerId}` (x 10) |
| 29 | *(same)* | *(same)* | Sweep rounding residual | `pot:daily` | `system:pot_residual` |
| 30 | `runWeeklyPotDraw` | Sunday 20:00 SAST | Top 10 leaderboard share weekly pot | `pot:weekly` | `user:{winnerId}` (x 10) |
| 31 | *(same)* | *(same)* | Sweep rounding residual | `pot:weekly` | `system:pot_residual` |

**Pot distribution percentages (top 10):**

| Rank | 1st | 2nd | 3rd | 4th | 5th | 6th | 7th | 8th | 9th | 10th | Residual |
|------|-----|-----|-----|-----|-----|-----|-----|-----|-----|------|----------|
| % | 30 | 20 | 15 | 10 | 8 | 6 | 5 | 3 | 2 | 1 | ~1% |

All amounts use `Math.floor()`. The residual (sum of rounding errors, roughly
1% of the pot) is swept to `system:pot_residual`.

### 4.2 Escrow Cleanup

| # | Function | Schedule | Description | Debit | Credit |
|---|----------|----------|-------------|-------|--------|
| 32 | `cleanupAbandonedEscrows` | Every 15 min | Reverse stale escrows (> 2 hrs old) | `system:escrow` | `client:{clientId}` |

### 4.3 Stokvel Penalties & Payouts

| # | Function | Schedule | Description | Debit | Credit |
|---|----------|----------|-------------|-------|--------|
| 33 | `calculateCommunityPenalties` | 1st of month 00:00 | Penalise missed stokvel contributions | `user:{memberId}` | `group:{groupId}` |
| 34 | `processCommunityPayouts` | 1st of month 10:00 | Auto stokvel payout (rotating / lottery / fixed-date) | `group:{groupId}` | `user:{memberId}` (x N) |

**Payout types:**

| Type | Behaviour |
|------|-----------|
| Rotating | Full group balance → next member in rotation order |
| Lottery | Full group balance → randomly selected member |
| Fixed date | Equal split among all active members |
| Goal reached | No automatic payout (admin triggers manually) |

### 4.4 Gift & Pool Expiry

| # | Function | Schedule | Description | Debit | Credit |
|---|----------|----------|-------------|-------|--------|
| 35 | `expireGifts` | Hourly | Refund unclaimed gifts to sender | `system:gift_escrow` | `user:{senderId}` |
| 36 | `expireTokenPools` | Hourly | Refund unsent pool contributions | `group:{poolId}` | `user:{contributorId}` (x N) |

### 4.5 Reconciliation (No Entries Created)

| # | Function | Schedule | Description |
|---|----------|----------|-------------|
| 37 | `runLedgerReconciliation` | Daily 04:00 | Audits all balances against journals. Logs discrepancies. Repairs drift. |

---

## 5. Idempotency Keys

Every journal has a unique idempotency key that prevents duplicate
processing. If a function retries (Cloud Functions at-least-once delivery),
the second attempt detects the existing key and returns the original result.

| Transaction Type | Key Pattern |
|---|---|
| Earning | `earn:{engagementId}` |
| Escrow reserve | `escrow_reserve:{engagementId}` |
| Escrow release | `escrow_release:{engagementId}` |
| Pot win | `pot_win:{potDrawId}:{userId}` |
| Pot residual | `pot_residual:{potDrawId}` |
| P2P transfer | `p2p:{transferId}` |
| Purchase | `purchase:{purchaseId}` |
| Referral | `referral:{referralId}` |
| Cashout initiate | `cashout_init:{cashoutId}` |
| Cashout complete | `cashout_complete:{cashoutId}` |
| Cashout failed | `cashout_failed:{cashoutId}` |
| Sub-account fund | `subacc_fund:{subAccountId}:{reference}` |
| Client fund | `client_fund:{clientId}:{reference}` |
| Gift debit | `gift_debit:{giftId}` |
| Gift credit | `gift_credit:{giftId}` |
| Gift refund | `gift_refund:{giftId}` |
| Spray contribution | `spray_contrib:{sprayId}:{userId}` |
| Spray payout | `spray_payout:{sprayId}` |
| Group contribution | `group_contrib:{groupId}:{transactionId}` |
| Group withdrawal | `group_withdraw:{groupId}:{transactionId}` |
| Group payout | `group_payout:{groupId}:{transactionId}` |
| Group penalty | `group_penalty:{groupId}:{memberId}:{date}` |
| Reversal | `reversal:{originalJournalId}` |

---

## 6. Configuration Constants

### Limits

| Constant | Value | Meaning |
|---|---|---|
| `MIN_TRANSFER_AMOUNT` | 1 token | Minimum for any transfer |
| `MIN_CASHOUT_AMOUNT` | 5 000 tokens (R50) | Minimum cashout request |
| `DAILY_EARNING_CAP` | 500 tokens | Max tokens earnable per day |
| `DAILY_P2P_LIMIT` | 10 000 tokens | Max P2P send per day |

### Referral Rewards

| Recipient | Amount |
|---|---|
| Referrer | 100 tokens |
| Referee (new user) | 50 tokens |

### Escrow

| Parameter | Value |
|---|---|
| TTL | 2 hours (7 200 000 ms) |
| Cleanup interval | Every 15 minutes |
| Cleanup batch size | 200 engagements |

---

## 7. Firestore Collections

### Primary Ledger

| Collection | Path | Purpose |
|---|---|---|
| `ledgerAccounts` | `ledgerAccounts/{accountId}` | All ledger accounts with balances |
| `ledgerJournals` | `ledgerJournals/{journalId}` | Immutable journal entries |
| `ledgerSnapshots` | `ledgerSnapshots/{snapshotId}` | Periodic balance snapshots for reconciliation |
| `ledgerAudit` | `ledgerAudit/{auditId}` | Audit log (account/journal events) |

### Sub-Accounts

| Collection | Path | Purpose |
|---|---|---|
| Sub-accounts | `ledgerAccounts/{userId}/subAccounts/{subId}` | User sub-wallets (off-ledger compartments) |
| Account types | `accountTypes/{typeId}` | Sub-account type definitions |

### Group Financial Data

| Collection | Path | Purpose |
|---|---|---|
| Groups | `groups/{groupId}` | Group / stokvel documents |
| Members | `groups/{groupId}/members/{memberId}` | Membership records |
| Transactions | `groups/{groupId}/transactions/{txId}` | Group transaction history |
| Pending approvals | `groups/{groupId}/pendingApprovals/{id}` | Approval queue |

### Journal Document Structure

```
{
  id:                   string          // Unique journal ID
  idempotencyKey:       string          // Prevents duplicate processing
  type:                 JournalType     // e.g. "earn", "p2p_transfer", "group_contribution"
  status:               "pending" | "posted" | "failed" | "reversed"
  description:          string          // Human-readable
  entries: [                            // 2+ balanced entries
    {
      id:               string          // "{journalId}_{index}"
      accountId:        string          // e.g. "user:abc123"
      entryType:        "debit" | "credit"
      amount:           number          // Always positive
      balanceAfter:     number          // Account balance after posting
      description:      string
    }
  ]
  totalDebits:          number          // Must equal totalCredits
  totalCredits:         number
  referenceType:        string          // "engagement", "transfer", "cashout", etc.
  referenceId:          string          // ID of referenced object
  initiatedBy:          string          // userId or "system"
  participantAccountIds: string[]       // Denormalised for security rules
  createdAt:            Timestamp
  postedAt:             Timestamp
  metadata:             Record<string, unknown>
}
```

---

## 8. Invariants & Safety Guarantees

| Guarantee | How It's Enforced |
|---|---|
| **Debits = Credits** | Journal posting validates `totalDebits === totalCredits` before commit |
| **No negative balances** | Every debit checks `available >= amount` inside the Firestore transaction |
| **Idempotent processing** | Duplicate idempotency key returns original result without re-posting |
| **Immutable journals** | Posted journals are never updated; corrections via `reverseJournal()` only |
| **Atomic posting** | Journal + all account balance updates happen in a single Firestore transaction |
| **Audit trail** | Every posted journal triggers `logJournalPostedAudit()` |
| **Daily reconciliation** | `runLedgerReconciliation` (04:00 SAST) verifies `sum(all accounts) = 0` |
| **Escrow time-bound** | Stale escrows (> 2 hrs) auto-reversed every 15 min |
| **Soft-delete safe** | Ledger accounts are never hard-deleted; soft-deleted groups preserve history |
| **Play Integrity** | Sensitive operations (cashout, send, contribute, withdraw) include device attestation |

---

*Generated from codebase analysis. Source files:*
*`functions/src/ledger/index.ts`, `journals.ts`, `accounts.ts`, `types.ts`,*
*`groupAccounts.ts`, `giftSprayEscrow.ts`, `subAccounts.ts`;*
*`functions/src/engagement.ts`, `communities.ts`, `wallet.ts`, `pots.ts`*
