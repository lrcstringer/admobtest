# Accounting System Redesign — CBook + On-Ledger Client Sub-Accounts

## Context

The current ledger system has several architectural issues:
1. **Treasury/Mint pattern is wrong**: `system:mint` goes negative to create tokens, `system:treasury` acts as a pass-through. This should be replaced by proper Cash Book accounts (`cbook:bus` for iMaliChat business, `cbook:trust` for external client trust funds).
2. **Client sub-accounts are off-ledger**: They exist as Firestore documents at `clients/{clientId}/subAccounts/{subAccountId}` with shadow balances that are decremented outside the ledger. This breaks audit trail and creates race conditions.
3. **Referrals come from a phantom pool**: `system:referrals` has no clear funding source. Referrals should be funded by `client:imalichat`.
4. **Cashout burns tokens to treasury**: Should instead credit a supplier account.

### Design Decisions (User-Confirmed)
- **CBook accounts are asset-type (debit-normal)**: a debit INCREASES the balance, a credit DECREASES it. This is the opposite of all other accounts (user, client, pot, supplier, etc.) which are credit-normal (credit increases, debit decreases). CBook cannot go negative — standard balance validation applies. The `DR cbook CR client` funding journal simultaneously creates tokens in the cbook and funds the client — this IS the seeding mechanism, no separate seed function needed.
- `system:mint` and `system:treasury` are **removed entirely**
- Client sub-accounts become **full ledger accounts** with ID format `client_subacc:{subAccountId}`
- Earn thread admin selects debit source from **both** the client main account AND any sub-accounts
- All accounts validated equally — no negative balance exceptions
- `postJournal()` applies debit/credit rules based on account type (asset vs liability-like)

---

## Phase 1: Ledger Schema Changes

### 1a. Update `AccountType` union
**File:** `functions/src/ledger/types.ts` (line 17)

Add new types, remove `cashout`:
```

"cbook"          // Cash Book accounts (business, trust)
"client_subacc"  // Client sub-accounts (on-ledger budgets)
```

Remove `"cashout"` (replaced by `"system"` prefix for cashout_pending).

Final union: `"system" | "pot" | "user" | "supplier" | "client" | "client_subacc" | "cbook" | "group"`

### 1b. Replace `SystemAccounts` constants
**File:** `functions/src/ledger/types.ts` (line 34)

Remove: `MINT`, `TREASURY`, `REFERRALS`, `OPERATIONS`, `FEES`
Change: `CASHOUT_PENDING` from `"cashout:pending"` to `"system:cashout_pending"`
Add: `CBOOK_BUS: "cbook:bus"`, `CBOOK_TRUST: "cbook:trust"`, `IMALICHAT_CLIENT: "client:imalichat"`

New constants:
```typescript
export const SystemAccounts = {
  CBOOK_BUS: "cbook:bus",                    // iMaliChat business cash book
  CBOOK_TRUST: "cbook:trust",                // External client trust cash book
  DAILY_POT: "pot:daily",                    // Daily pot accumulator
  WEEKLY_POT: "pot:weekly",                  // Weekly pot accumulator
  CASHOUT_PENDING: "system:cashout_pending", // Pending cashout holding
  IMALICHAT_CLIENT: "client:imalichat",      // iMaliChat's own client account
} as const;
```

### 1c. Add `AccountId` helpers
**File:** `functions/src/ledger/types.ts` (line 389)

Add:
```typescript
clientSubAccount: (subAccountId: string) => `client_subacc:${subAccountId}`,
parseClientSubAccountId: (accountId: string): string | null => {
  if (accountId.startsWith("client_subacc:")) return accountId.substring(14);
  return null;
},
isClientSubAccount: (accountId: string): boolean => accountId.startsWith("client_subacc:"),
isCbookAccount: (accountId: string): boolean => accountId.startsWith("cbook:"),
isDebitNormal: (accountId: string): boolean => accountId.startsWith("cbook:"),
// Asset accounts (cbook) are debit-normal: debit increases balance, credit decreases.
// All other accounts are credit-normal: credit increases balance, debit decreases.
```

Remove: `isMintAccount`

### 1d. Update `JournalType` union
**File:** `functions/src/ledger/types.ts` (line 80)

Remove: `system_seed`, `campaign_fund`, `campaign_reward`
Add: `client_fund`, `client_refund`, `subacc_fund`
Keep all others.

### 1e. Add `IdempotencyKey` helpers
**File:** `functions/src/ledger/types.ts` (line 435)

Add:
```typescript
clientFund: (clientId: string, reference: string) => `client_fund:${clientId}:${reference}`,
clientRefund: (clientId: string, reference: string) => `client_refund:${clientId}:${reference}`,
subAccountFund: (subAccountId: string, reference: string) => `subacc_fund:${subAccountId}:${reference}`,
```

Remove: `systemSeed`, `campaignFund`, `campaignReward`

### 1f. Add `referenceType` option
**File:** `functions/src/ledger/types.ts` (line 139)

Add `"client_fund"` to the `referenceType` union.

---

## Phase 2: Account Initialization

### 2a. Rewrite `initializeSystemAccounts()`
**File:** `functions/src/ledger/accounts.ts`

Replace current 8-account creation with 6 accounts:

| Account ID | Type | Name |
|---|---|---|
| `cbook:bus` | `cbook` | iMaliChat Business Cash Book |
| `cbook:trust` | `cbook` | Client Trust Cash Book |
| `pot:daily` | `pot` | Daily Pot |
| `pot:weekly` | `pot` | Weekly Pot |
| `system:cashout_pending` | `system` | Pending Cashouts |
| `client:imalichat` | `client` | iMaliChat |

All start with `balance: 0`, `status: "active"`.

### 2b. Replace mint-exception with asset-account-aware balance calculation in `postJournal()`
**File:** `functions/src/ledger/journals.ts` (lines 120, 129-131, and 163-165)

**Replace** the uniform balance-change formula (line 120):
```typescript
// OLD: all accounts treated the same
const change = entry.entryType === "credit" ? entry.amount : -entry.amount;

// NEW: asset accounts (cbook) are debit-normal
const isAsset = AccountId.isDebitNormal(entry.accountId);
const change = isAsset
  ? (entry.entryType === "debit" ? entry.amount : -entry.amount)
  : (entry.entryType === "credit" ? entry.amount : -entry.amount);
```

**Remove** the `AccountId.isMintAccount()` checks (lines 129-131 and 163-165) that skip negative-balance validation. All accounts are now validated equally — no account may go negative. The asset-aware calculation means cbook accounts naturally increase on debit (funding clients) and decrease on credit (refunds), so they never need to go negative.

**Inside the transaction** (line 163-165): apply the same asset-aware formula when re-validating balances with fresh data.

### 2c. Update Platform Management callable
**File:** `functions/src/migrations/admobSystemThreadMigration.ts`

The existing `adminRunPlatformSetup` creates the iMaliChat client doc + sub-account + thread + opportunity. Update to also call `initializeSystemAccounts()` so the "Setup Initial Accounts" is part of platform setup.

### 2d. Update Platform Management screen
**File:** `lib/presentation/admin/screens/platform_management_screen.dart`

Add a status check row for each new system account (`cbook:bus`, `cbook:trust`, `pot:daily`, `pot:weekly`, `system:cashout_pending`). Show green/red status for each. The "Run Setup" button creates them all.

---

## Phase 3: Core Journal Functions

### 3a. Rewrite `processEarningWithSplit()`
**File:** `functions/src/ledger/index.ts` (line 183)

**Key changes:**
1. Replace `sourceAccountId` logic: no more treasury fallback. Source is always the `tokenSourceAccountId` from the earn thread (either `client:{clientId}` or `client_subacc:{subAccountId}`).
2. New parameter: `tokenSourceAccountId: string` (replaces `clientId` + `clientSubAccountId` pair).
3. **Remove off-ledger sub-account decrement** (lines 260-270) — the ledger journal now directly debits the correct account.
4. Remove `checkTreasuryBalance()` call (line 248-252).

New signature:
```typescript
export async function processEarningWithSplit(
  userId: string,
  totalAmount: number,
  engagementId: string,
  description: string,
  tokenSourceAccountId: string,       // e.g. "client:abc" or "client_subacc:xyz"
  userSubAccountId?: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>,
): Promise<PostJournalResult>
```

Internally:
- `createEarningEntries(userId, totalAmount, tokenSourceAccountId)` — works as-is, just takes different source ID
- `postJournal(...)` — same pattern
- `creditSubAccount(userId, userSubAccountId, userShare)` — same pattern (user sub-accounts stay off-ledger for now)
- **No off-ledger client sub-account decrement** — the journal debit handles it

### 3b. Rewrite `processReferralRewards()`
**File:** `functions/src/ledger/index.ts` (line 443)

Change source from `SystemAccounts.REFERRALS` to `SystemAccounts.IMALICHAT_CLIENT`:
```typescript
const entries = createReferralEntries(referrerId, refereeId, SystemAccounts.IMALICHAT_CLIENT);
```

### 3c. Rewrite `completeCashout()`
**File:** `functions/src/ledger/index.ts` (line 678)

Change credit target from `SystemAccounts.TREASURY` to `supplier:{supplierId}`:

New signature adds `supplierId` parameter:
```typescript
export async function completeCashout(
  cashoutId: string,
  amount: number,
  supplierId: string,           // e.g. "cashout_eft", "cashout_ewallet"
  metadata?: Record<string, unknown>
): Promise<PostJournalResult>
```

Entries:
```typescript
{ accountId: SystemAccounts.CASHOUT_PENDING, entryType: "debit", amount },
{ accountId: AccountId.supplier(supplierId), entryType: "credit", amount },
```

### 3d. Update `initiateCashout()` and `failCashout()`
**File:** `functions/src/ledger/index.ts`

Update `SystemAccounts.CASHOUT_PENDING` references (account ID changed from `cashout:pending` to `system:cashout_pending`). The code already uses the constant, so only the constant value changes (Phase 1b).

### 3e. Add `processClientSubAccountFunding()`
**File:** `functions/src/ledger/index.ts` (new function)

```typescript
export async function processClientSubAccountFunding(
  clientId: string,
  subAccountId: string,
  amount: number,
  reference: string,
  adminUserId: string,
): Promise<PostJournalResult>
```

Entries:
```typescript
{ accountId: AccountId.client(clientId), entryType: "debit", amount },
{ accountId: AccountId.clientSubAccount(subAccountId), entryType: "credit", amount },
```

Journal type: `subacc_fund`. Validates client account has sufficient balance.

### 3f. Remove `seedTreasury()` and `checkTreasuryBalance()`
**File:** `functions/src/ledger/index.ts`

Delete both functions entirely. Remove from exports in `index.ts`.

### 3g. Update exports
**File:** `functions/src/ledger/index.ts`

- Remove: `seedTreasury`, `checkTreasuryBalance`
- Add: `processClientSubAccountFunding`

---

## Phase 4: Admin Backend

### 4a. Rewrite `adminFundClientAccount()` → `adminFundClient()`
**File:** `functions/src/adminAccounts.ts` (line 586)

Replace current treasury→client journal with cbook→client:
```typescript
const isImalichat = clientId === "imalichat";
const cbookAccount = isImalichat ? SystemAccounts.CBOOK_BUS : SystemAccounts.CBOOK_TRUST;

entries: [
  { accountId: cbookAccount, entryType: "debit", amount },
  { accountId: AccountId.client(clientId), entryType: "credit", amount },
]
```

Journal type: `client_fund` (was `adjustment`).

**This IS the token creation/seeding mechanism.** Because cbook is an asset account (debit-normal), the debit INCREASES its balance while the credit INCREASES the client balance. Both sides go up. No separate seeding step needed.

### 4b. Add `adminRefundClient()` (new callable)
**File:** `functions/src/adminAccounts.ts`

Inverse of funding — admin refunds tokens from client back to cbook:
```typescript
const isImalichat = clientId === "imalichat";
const cbookAccount = isImalichat ? SystemAccounts.CBOOK_BUS : SystemAccounts.CBOOK_TRUST;

entries: [
  { accountId: AccountId.client(clientId), entryType: "debit", amount },
  { accountId: cbookAccount, entryType: "credit", amount },
]
```

Journal type: `client_refund`. Validates client account has sufficient balance.
Requires `data: { clientId, amount, reason }`.

### 4c. Rewrite `adminCreateClientSubAccount()`
**File:** `functions/src/adminAccounts.ts` (line 677)

In addition to creating the Firestore doc at `clients/{clientId}/subAccounts/{subAccountId}`, also **create a ledger account**:
```typescript
const ledgerAccountId = AccountId.clientSubAccount(subAccountRef.id);
await createAccount({
  type: "client_subacc",
  name: `${name} — ${clientId}`,
  ownerId: clientId,
  metadata: { clientId, subAccountFirestoreId: subAccountRef.id },
});
```

The Firestore doc keeps metadata (name, isActive, budgetExhausted, etc.) but **balance is now on the ledger** — remove `balance` and `initialBudget` from the Firestore doc. Add `ledgerAccountId` field to the Firestore doc for easy reference.

### 4d. Rewrite `adminFundClientSubAccount()`
**File:** `functions/src/adminAccounts.ts` (line 742)

Replace the current off-ledger balance increment with a proper journal via `processClientSubAccountFunding()`:

```typescript
const result = await processClientSubAccountFunding(
  clientId, subAccountId, amount, reference, context.auth!.uid
);
```

This posts: DR `client:{clientId}` CR `client_subacc:{subAccountId}`.
Validates client master account has sufficient ledger balance.

### 4e. Update `adminDeleteClient()` refund journal
**File:** `functions/src/adminAccounts.ts` (line 1089)

Change refund target from `SystemAccounts.TREASURY` to the appropriate cbook:
```typescript
const isImalichat = clientId === "imalichat";
const cbookAccount = isImalichat ? SystemAccounts.CBOOK_BUS : SystemAccounts.CBOOK_TRUST;

entries: [
  { accountId, entryType: "debit", amount: balance },
  { accountId: cbookAccount, entryType: "credit", amount: balance },
]
```

Journal type: `client_refund` (was `adjustment`).

Also: before refunding master balance, refund all sub-account balances back to client master:
1. Query all active `client_subacc:{subAccId}` ledger accounts for this client
2. For each with balance > 0: DR `client_subacc:{subAccId}` CR `client:{clientId}`
3. Then refund client master balance to cbook

### 4f. Update `adminListClientSubAccounts()`
**File:** `functions/src/adminAccounts.ts` (line 829)

Read balance from ledger account (`ledgerAccounts/client_subacc:{subAccountId}`) instead of the Firestore sub-account doc. The response stays the same shape but balance comes from the authoritative ledger.

### 4g. Export new functions
**File:** `functions/src/index.ts`

- Add: `adminRefundClient`
- Rename: `adminFundClientAccount` → `adminFundClient` (or keep old name and change internals)
- Remove: `seedTreasury` export (from `initializeTrustLedger` flow)

---

## Phase 5: Engagement Flow

### 5a. Update `startEngagement()` budget pre-check
**File:** `functions/src/engagement.ts` (line 180)

Change from reading Firestore `clients/{clientId}/subAccounts/{subAccountId}.balance` to reading ledger balance via `getBalance(tokenSourceAccountId)`:

```typescript
// tokenSourceAccountId is either "client:{clientId}" or "client_subacc:{subAccountId}"
const tokenSourceAccountId = threadData.tokenSourceAccountId;
if (tokenSourceAccountId) {
  const balance = await getBalance(tokenSourceAccountId);
  if (balance < rewardAmount) {
    throw new functions.https.HttpsError("failed-precondition", "This offer is currently unavailable");
  }
}
```

### 5b. Update `processEngagement()` budget pre-check
**File:** `functions/src/engagement.ts` (line 541)

Same change — read from ledger instead of Firestore sub-account doc.

### 5c. Update `processEngagement()` → `processEarningWithSplit()` call
**File:** `functions/src/engagement.ts` (line 623)

Pass the new `tokenSourceAccountId` parameter instead of separate `clientId` + `clientSubAccountId`:

```typescript
const tokenSourceAccountId = threadData.tokenSourceAccountId
  || (clientId ? AccountId.client(clientId) : null);

const ledgerResult = await processEarningWithSplit(
  userId,
  rewardAmount,
  engagementId,
  `Earned from ${engagement.type}`,
  tokenSourceAccountId!,       // The ledger account to debit
  subAccountId,                // User's sub-account to credit
  tokenDestAccountTypeId,
  { engagementType, earnOpportunityId, campaignId, threadId, clientId },
);
```

### 5d. Update budget monitoring post-processing
**File:** `functions/src/engagement.ts` (line 648+)

Read sub-account balance from ledger instead of Firestore doc. Set `budgetExhausted` flag on the Firestore metadata doc (not the ledger account).

### 5e. Update EarnThread schema
**File:** `functions/src/earnAdmin.ts`

In `createEarnThread`:
- Replace `tokenSourceSubAccountId` field with `tokenSourceAccountId` — stores the full ledger account ID (either `client:{clientId}` or `client_subacc:{subAccountId}`)
- The admin selects from a list of available accounts (Phase 6)

In `updateEarnThread`:
- Allow updating `tokenSourceAccountId`

---

## Phase 6: Admin Flutter UI

### 6a. Client Management — Sub-Account Funding
**File:** `lib/presentation/admin/screens/client_management_screen.dart`

Update the "Top Up" dialog in `_SubAccountsDialog`:
- Call the updated `adminFundClientSubAccount` (which now posts a journal)
- Show ledger balance instead of Firestore balance
- Add a "Refund Client" action button on the client card (calls `adminRefundClient`)

### 6b. Client Management — Sub-Account Balance Display
**File:** `lib/presentation/admin/screens/client_management_screen.dart`

In `adminListClientSubAccounts` response, balance now comes from ledger. No UI change needed if the backend returns the same shape.

### 6c. Earn Thread Creation — Token Source Selection
**File:** `lib/presentation/admin/screens/earn_management_screen.dart` (or wherever thread creation dialog lives)

When creating/editing an earn thread, show a dropdown of:
- `client:{clientId}` — "Main Account (balance: X tokens)"
- `client_subacc:{subAccId1}` — "Sub-Account Name 1 (balance: Y tokens)"
- `client_subacc:{subAccId2}` — "Sub-Account Name 2 (balance: Z tokens)"

Store the selected value as `tokenSourceAccountId` on the thread.

### 6d. Platform Management — System Account Status
**File:** `lib/presentation/admin/screens/platform_management_screen.dart`

Add status rows for each new system account. Update the "Run Setup" button to call the updated `initializeTrustLedger` / `adminRunPlatformSetup`. No separate CBook seeding UI needed — the `adminFundClient` journal (DR cbook CR client) is the seeding mechanism.

---

## Phase 7: Consumer Flutter App

### 7a. Update `LedgerAccountType` enum
**File:** `lib/domain/entities/ledger_account.dart` (line 9)

Current enum:
```dart
enum LedgerAccountType { system, pot, user, supplier, cashout }
```

Update to match backend `AccountType`:
```dart
enum LedgerAccountType { system, pot, user, supplier, cbook, clientSubacc, client, group }
```

- Add: `cbook`, `clientSubacc`, `client`, `group`
- Remove: `cashout` (cashout_pending is now `system` type)
- Update comment to reflect new types

### 7b. Update `LedgerJournalType` enum
**File:** `lib/domain/entities/ledger_journal.dart` (line 7)

Current enum has 12 values. Update:
- Remove: `systemSeed` (no longer exists)
- Add: `clientFund`, `clientRefund`, `subaccFund`

New enum:
```dart
enum LedgerJournalType {
  earn,             // User earned tokens (from engagement)
  potContribution,  // Automatic pot contribution from earnings
  potWin,           // User won a pot draw
  purchase,         // User purchased goods/services
  referralReward,   // Referral bonus paid
  p2pTransfer,      // User-to-user transfer
  cashoutInitiate,  // Cashout started (user -> pending)
  cashoutComplete,  // Cashout completed (pending -> supplier)
  cashoutFailed,    // Cashout failed (pending -> user refund)
  reversal,         // Reversal of a previous journal
  adjustment,       // Manual admin adjustment
  clientFund,       // CBook -> Client funding (also seeds cbook as asset debit)
  clientRefund,     // Client -> CBook refund
  subaccFund,       // Client -> Sub-Account funding
}
```

### 7c. Update `LedgerReferenceType` enum
**File:** `lib/domain/entities/ledger_journal.dart` (line 53)

Add `clientFund` to match backend:
```dart
enum LedgerReferenceType {
  engagement, purchase, referral, transfer, cashout, potDraw, potEntry, clientFund,
}
```

### 7d. Rename `tokenSourceSubAccountId` → `tokenSourceAccountId` in EarnThread entity
**File:** `lib/domain/entities/earn_thread.dart` (line 31)

Change:
```dart
String? tokenSourceSubAccountId,
```
To:
```dart
String? tokenSourceAccountId,
```

This is a Freezed class — requires `build_runner` regeneration.

### 7e. Update admin earn datasource parameter
**File:** `lib/data/datasources/remote/admin_earn_remote_datasource.dart` (lines 83, 98)

In `createOrUpdateThread()`:
- Rename parameter: `tokenSourceSubAccountId` → `tokenSourceAccountId`
- Update Cloud Function call data key: `'tokenSourceSubAccountId'` → `'tokenSourceAccountId'`

### 7f. Update transaction history display
**File:** `lib/presentation/screens/wallet/transaction_history_screen.dart`

**`_getJournalIcon()` (line 269):** Remove `systemSeed` case, add new types:
```dart
case LedgerJournalType.clientFund:
  return Icons.account_balance;
case LedgerJournalType.clientRefund:
  return Icons.account_balance;
case LedgerJournalType.subaccFund:
  return Icons.account_balance;
```

**`_getTypeDisplayName()` (line 410):** Remove `systemSeed` case, add new types:
```dart
case LedgerJournalType.clientFund:
  return 'Client Funding';
case LedgerJournalType.clientRefund:
  return 'Client Refund';
case LedgerJournalType.subaccFund:
  return 'Sub-Account Funding';
```

Note: These new types (`clientFund`, `clientRefund`, `subaccFund`) are admin-only journal types that won't normally appear in a consumer user's transaction history. However, the enum must be complete to handle JSON deserialization without crashes.

### 7g. Run `build_runner`

After all Freezed entity changes (7a-7d), regenerate generated files:
```bash
dart run build_runner build --delete-conflicting-outputs
```

This regenerates:
- `lib/domain/entities/ledger_account.freezed.dart` + `.g.dart`
- `lib/domain/entities/ledger_journal.freezed.dart` + `.g.dart`
- `lib/domain/entities/earn_thread.freezed.dart` + `.g.dart`

### 7h. Consumer screens NOT affected (confirmed)

The following consumer screens/BLoCs were audited and require **no changes**:
- `lib/presentation/screens/wallet/wallet_screen.dart` — reads from BLoC state, no account type logic
- `lib/presentation/screens/wallet/wallet_detail_screen.dart` — single wallet detail
- `lib/presentation/screens/wallet/cashout_screen.dart` — consumer side unaffected (backend handles supplier ID)
- `lib/presentation/screens/home/home_screen.dart` — balance display, pot cards
- `lib/presentation/blocs/wallet/wallet_bloc.dart` — manages ledger account/journals, no hardcoded system account IDs
- `lib/presentation/blocs/earn/earn_bloc.dart` — engagement flow managed by backend
- `lib/data/datasources/remote/wallet_remote_datasource.dart` — no hardcoded system account references
- `lib/data/datasources/remote/earn_remote_datasource.dart` — calls Cloud Functions, no direct account references
- `lib/data/datasources/remote/purchase_remote_datasource.dart` — unaffected
- `lib/data/datasources/remote/referral_remote_datasource.dart` — unaffected
- `lib/presentation/screens/groups/` — group features use groupAccounts.ts which is unchanged

---

## Phase 8: Cleanup

### 8a. Remove dead code
- `seedTreasury()` and `checkTreasuryBalance()` from `ledger/index.ts`
- `initializeTrustLedger` callable export (or rewrite to call new `initializeSystemAccounts`)
- `AccountId.isMintAccount()` from types
- `SystemAccounts.MINT`, `TREASURY`, `REFERRALS`, `OPERATIONS`, `FEES`
- Remove any references to old account IDs: `"system:mint"`, `"system:treasury"`, `"system:referrals"`, `"system:operations"`, `"system:fees"`, `"cashout:pending"`

### 8b. Update ledger/index.ts exports
- Remove: `seedTreasury`, `checkTreasuryBalance`
- Add: `processClientSubAccountFunding`

---

## Implementation Order

1. **Phase 1** — Ledger schema changes (types.ts) — foundation for everything
2. **Phase 2** — Account initialization + postJournal validation changes
3. **Phase 3** — Core journal functions (earning, referral, cashout, sub-account funding)
4. **Phase 4** — Admin backend (fund/refund client, create/fund sub-account)
5. **Phase 5** — Engagement flow (budget checks, earning call)
6. **Phase 6** — Admin Flutter UI
7. **Phase 7** — Consumer Flutter app (entity enums, earn thread field rename, transaction display, build_runner)
8. **Phase 8** — Cleanup dead code

---

## Verification Checklist

1. **`tsc --noEmit`** — 0 errors on all Cloud Functions
2. **`dart run build_runner build --delete-conflicting-outputs`** — regenerate Freezed files
3. **`flutter analyze`** — 0 errors
4. **Manual testing:**
  - Platform Setup creates all 6 system accounts
  - Admin funds client via cbook→client journal (verify cbook balance increases via asset-debit, client balance increases via credit)
  - Admin creates client sub-account → ledger account created
  - Admin funds sub-account → DR client CR client_subacc journal posted
  - Earn thread created with sub-account as token source
  - User completes engagement → sub-account debited on-ledger (no off-ledger decrement)
  - Referral rewards debit client:imalichat
  - Cashout complete credits supplier account
  - Client deletion refunds all sub-accounts → master → cbook
  - Consumer wallet screen loads without errors (LedgerAccountType deserialization works)
  - Transaction history screen displays correctly (no missing enum cases)
  - Consumer earn flow completes end-to-end (earn thread → engagement → reward)

---

## Files Modified (Summary)

| File | Change |
|---|---|
| `functions/src/ledger/types.ts` | AccountType, SystemAccounts, AccountId, JournalType, IdempotencyKey |
| `functions/src/ledger/accounts.ts` | Rewrite `initializeSystemAccounts()` |
| `functions/src/ledger/journals.ts` | Replace mint exception with asset-account-aware balance calculation (debit-normal for cbook) |
| `functions/src/ledger/index.ts` | Rewrite earning/referral/cashout, add sub-account funding, remove seed/treasury |
| `functions/src/adminAccounts.ts` | Rewrite fund/create/list sub-account, add refund, update delete |
| `functions/src/engagement.ts` | Budget checks from ledger, new earning call signature |
| `functions/src/earnAdmin.ts` | Thread `tokenSourceAccountId` field |
| `functions/src/index.ts` | Update exports (add `adminRefundClient`) |
| `functions/src/migrations/admobSystemThreadMigration.ts` | Include system account init |
| `lib/presentation/admin/screens/platform_management_screen.dart` | System account status |
| `lib/presentation/admin/screens/client_management_screen.dart` | Sub-account balance from ledger, refund action |
| `lib/presentation/admin/screens/earn_management_screen.dart` | Token source dropdown |
| `lib/domain/entities/ledger_account.dart` | Update `LedgerAccountType` enum: add `cbook`, `clientSubacc`, `client`, `group`; remove `cashout` |
| `lib/domain/entities/ledger_journal.dart` | Update `LedgerJournalType` enum: add `clientFund`, `clientRefund`, `subaccFund`; remove `systemSeed`. Add `clientFund` to `LedgerReferenceType` |
| `lib/domain/entities/earn_thread.dart` | Rename `tokenSourceSubAccountId` → `tokenSourceAccountId` |
| `lib/data/datasources/remote/admin_earn_remote_datasource.dart` | Rename parameter + data key `tokenSourceSubAccountId` → `tokenSourceAccountId` |
| `lib/presentation/screens/wallet/transaction_history_screen.dart` | Update icon/display name switch for new journal types, remove `systemSeed` |
| Generated `.freezed.dart` / `.g.dart` files | Regenerate via `build_runner` after entity changes |

## Deferred Items
- **User sub-accounts**: Currently remain off-ledger. Could be made on-ledger in a future phase.
- **Cashout supplier selection**: Admin UI for selecting supplier when completing cashout (currently not needed if a generic supplier ID is used).
```