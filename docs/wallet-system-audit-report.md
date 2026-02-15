# iMaliChat Wallet System Audit Report

**Date:** 2026-02-14
**Scope:** Full wallet system — mobile app screens, BLoC layer, data layer, Cloud Functions backend, Firestore rules, admin portal
**Covers:** Token ledger, rewards inventory, sub-accounts (default + brand/restricted), transaction history, cashout flow

---

## Executive Summary

The wallet system was audited end-to-end across the Flutter mobile app, Cloud Functions backend, and admin portal. The audit verified routing, screen wiring, BLoC initialization, data flow, Firestore rules, and backend function security.

**Result:** 11 confirmed issues found (2 CRITICAL, 3 HIGH, 4 MEDIUM, 2 LOW). All wallet screens are correctly wired and display data properly. The critical issues are in backend authorization and Firestore security rules — not in the UI layer.

| Severity | Count | Summary |
|----------|-------|---------|
| CRITICAL | 2 | Authorization bypass in cashout function; broken Firestore sub-account rule |
| HIGH | 3 | Pagination cursor bug; data source mismatch; UTC vs SAST earn cap |
| MEDIUM | 4 | Journal access too broad; fire-and-forget reward allocation; unsafe enum parse; stream race condition |
| LOW | 2 | Missing NetworkException handling in reward repo; no reward activity audit trail in admin |

---

## Part 1: Wallet Screens & Routing

### 1.1 Route Definitions

**File:** [app_router.dart](lib/presentation/router/app_router.dart) (Lines 592-744)

All wallet routes are correctly defined within the wallet `StatefulShellBranch`:

| Route | Screen | Status |
|-------|--------|--------|
| `/wallet` | `WalletScreen` | CORRECT |
| `/wallet/detail/:subAccountId` | `WalletDetailScreen` | CORRECT |
| `/wallet/send` | `WalletSendScreen` | CORRECT |
| `/wallet/send/amount` | `WalletSendAmountScreen` | CORRECT |
| `/wallet/send/success` | `WalletSendSuccessScreen` | CORRECT |
| `/wallet/send/failure` | `WalletSendFailureScreen` | CORRECT |
| `/wallet/withdraw` | `CashoutScreen` | CORRECT |
| `/wallet/withdraw/success` | `WalletWithdrawSuccessScreen` | CORRECT |
| `/wallet/withdraw/failure` | `WalletWithdrawFailureScreen` | CORRECT |
| `/wallet/transactions` | `TransactionHistoryScreen` | CORRECT |
| `/wallet/cashout` | `CashoutScreen` (legacy alias) | CORRECT |
| `/wallet/rewards` | `RewardsListScreen` | CORRECT |
| `/wallet/rewards/:rewardId` | `RewardItemDetailScreen` | CORRECT |

**Finding:** No orphaned, broken, or missing routes. All path parameters are correctly extracted and passed.

### 1.2 WalletBloc Initialization

**File:** [wallet_screen.dart](lib/presentation/screens/wallet/wallet_screen.dart) (Lines 32-36)

```dart
@override
void initState() {
  super.initState();
  context.read<WalletBloc>().add(const WalletEvent.loadLedger());
  context.read<RewardBloc>().add(const RewardEvent.loadItems());
  _loadRewardFlag();
}
```

- `WalletEvent.loadLedger()` dispatched at `initState()` — cascades to:
  - Fetch ledger account
  - Watch ledger account updates (stream)
  - Watch ledger journals (stream)
  - Watch engagement stats (stream)
  - Load initial journals (one-shot)
  - Load and watch sub-accounts
- `WalletBloc` is provided app-wide via `MultiBlocProvider` in [app.dart](lib/app.dart)

**Finding:** CORRECT. Initialization happens at the right lifecycle point.

### 1.3 RewardBloc Initialization

**File:** [wallet_screen.dart](lib/presentation/screens/wallet/wallet_screen.dart) (Line 35)

- `RewardEvent.loadItems()` dispatched alongside wallet init
- Additional load points: `rewards_list_screen.dart` (after consent check), `reward_item_detail_screen.dart` (detail fetch)
- `RewardBloc` provided app-wide in [app.dart](lib/app.dart)

**Finding:** CORRECT. Rewards loaded on-demand when wallet tab is visited.

### 1.4 Sub-Account Card Display

**File:** [wallet_screen.dart](lib/presentation/screens/wallet/wallet_screen.dart) — `_buildWalletCard()` (Lines 645-771)

| Property | Default (Unrestricted) | Brand (Restricted) |
|----------|----------------------|-------------------|
| Color | `AppColors.walletPrimary` | `AppColors.walletZawadi` |
| Icon | `Icons.account_balance_wallet` | `Icons.storefront` |
| Label | "Main Wallet" | "Brand Wallet" |
| Navigation | `/wallet/detail/:id` | `/wallet/detail/:id` |

Differentiation based on `SubAccount.isDefault` / `SubAccount.isRestricted` (entity computed from `accountTypeId`):
- `isRestricted` = `accountTypeId != null`
- `isDefault` = explicitly marked default

**Finding:** CORRECT. All three wallet types (default, brand, other unrestricted) are visually distinct.

### 1.5 Brand Wallet Detail Screen

**File:** [wallet_detail_screen.dart](lib/presentation/screens/wallet/wallet_detail_screen.dart)

- Balance card shows correct icon and label per wallet type (Lines 100-157)
- Action buttons adapt: `Send` + `Cash Out` for default; `Rewards (N)` or `Use Tokens` for brand (Lines 159-231)
- Brand rewards section links `RewardBloc.activeItems` filtered by `clientName` match (case-insensitive) to `subAccount.name` (Lines 274-281)
- Up to 3 compact reward cards shown with "View All" link
- Navigation: "Rewards (N)" button goes to `/wallet/rewards`

**Finding:** CORRECT. Brand ↔ reward linking works as designed. Note: matching is by `clientName` string, not `clientId` — a future improvement opportunity.

### 1.6 Rewards List Screen

**File:** [rewards_list_screen.dart](lib/presentation/screens/wallet/rewards_list_screen.dart)

- 3 tabs: Active / Redeemed / Expired — wired to `RewardState` computed getters
- POPIA consent check at `initState`: reads `users/{uid}.rewardConsent`, shows `RewardConsentDialog` if false
- Consent refusal shows "Consent Required" placeholder with "Review Consent" button
- Pull-to-refresh dispatches `RewardEvent.refreshItems()`

**Finding:** CORRECT. Full consent workflow; proper tab filtering.

### 1.7 Reward Item Detail Screen

**File:** [reward_item_detail_screen.dart](lib/presentation/screens/wallet/reward_item_detail_screen.dart)

- Fetches detail via `RewardEvent.loadItemDetail(rewardId)` at `initState`
- Code display supports: QR code (`QrImageView`), text code (selectable + copy), digital content (JSON with URL + access code)
- Redemption instructions displayed when available from campaign metadata
- "Mark as Used" button with confirmation dialog triggers `RewardEvent.redeemItem`
- Cleanup: `RewardEvent.clearSelectedItem()` on dispose

**Finding:** CORRECT. All code types handled; proper lifecycle management.

### 1.8 Portfolio Card (Dual Rewards Enhancement)

**File:** [wallet_screen.dart](lib/presentation/screens/wallet/wallet_screen.dart) — `_buildPortfolioCard()`

- Wraps in `BlocBuilder<RewardBloc, RewardState>`
- Shows reward count row (gift icon + "{N} rewards") when `_rewardsUiEnabled && activeRewards > 0`
- Gated by platform settings feature flag

**Finding:** CORRECT. Newly implemented; properly gated.

### 1.9 Inline Rewards Section

**File:** [wallet_screen.dart](lib/presentation/screens/wallet/wallet_screen.dart) — `_buildRewardsSection()`

- Replaces old `_buildRewardsCard` (small link)
- Shows up to 3 compact reward cards with expiry badges
- "See N more" link for overflow
- Empty states: "No active rewards — View history" or "Complete earn activities to unlock rewards"
- Entire section hidden when `!_rewardsUiEnabled`

**Finding:** CORRECT. Newly implemented; proper empty states.

### 1.10 Unified Transaction History

**File:** [transaction_history_screen.dart](lib/presentation/screens/wallet/transaction_history_screen.dart)

- `SegmentedButton` toggle: "All Activity" vs "Tokens Only"
- "All Activity" merges `LedgerJournal` + `RewardItem` entries sorted by timestamp
- Reward items appear with gift icon, campaign name, status badge
- Filter chips include "Rewards" option when in "All Activity" mode
- Pull-to-refresh refreshes both wallet and reward BLoCs

**Finding:** CORRECT. Newly implemented; proper merge and sorting logic.

---

## Part 2: BLoC & Data Layer Issues

### 2.1 CRITICAL — WalletBloc Pagination Cursor Mismatch

**File:** [wallet_bloc.dart](lib/presentation/blocs/wallet/wallet_bloc.dart) (Line 142)

```dart
final result = await _walletRepository.getLedgerJournals(
  limit: 20,
  startAfter: lastJournal?.postedAt ?? lastJournal?.createdAt,  // ← BUG
);
```

**Problem:** The `startAfter` cursor uses `postedAt` with fallback to `createdAt`, but the Firestore query in `wallet_remote_datasource.dart` (Line 162) orders exclusively by `postedAt`:

```dart
.orderBy('postedAt', descending: true)
```

If `postedAt` is null on the last journal, the cursor falls back to `createdAt`, which is a different field from the ordering field. Firestore requires the cursor value to match the ordering field.

**Impact:** Duplicate records or skipped records in paginated journal views. Users may see the same transaction twice or miss transactions entirely when scrolling.

**Fix:** Always use `postedAt` for the cursor (journals without `postedAt` should not exist), or change the query to order by `createdAt` as a secondary sort.

---

### 2.2 CRITICAL — CashoutBloc Broken Cancellation Logic

**File:** [cashout_bloc.dart](lib/presentation/blocs/cashout/cashout_bloc.dart) (Line 135)

```dart
final updatedHistory = state.history.map((c) {
  if (c.id == event.cashoutId) {
    add(const CashoutEvent.loadHistory());  // ← BUG: event inside map()
  }
  return c;
}).toList();

emit(state.copyWith(history: updatedHistory));
```

**Problem:** `add(CashoutEvent.loadHistory())` is called inside a `.map()` closure during state processing. This:
1. Fires a new event mid-emission, causing a race condition
2. The `updatedHistory` variable is never actually updated — it returns the same objects unchanged
3. The `emit()` after the loop overwrites any state change from the `loadHistory` event

**Impact:** After cancelling a cashout, the UI shows stale data. The reload event may or may not take effect depending on timing.

**Fix:** Replace with: emit loading state, await the cancel, then dispatch `loadHistory` as a separate step outside the fold.

---

### 2.3 HIGH — Sub-Account Data Source Mismatch

**File:** [wallet_remote_datasource.dart](lib/data/datasources/remote/wallet_remote_datasource.dart) (Lines 275-322)

| Method | Data Source | Factory | Sorting |
|--------|------------|---------|---------|
| `getSubAccounts()` (Line 276) | Cloud Function `'getSubAccounts'` | `fromJson()` | None |
| `watchSubAccounts()` (Line 299) | Firestore subcollection `ledgerAccounts/{uid}/subAccounts` | `fromFirestore()` | By `isDefault` desc, then `name` |

**Problem:** Two fundamentally different data sources with different serialization factories and different sorting behavior. The Cloud Function may apply different filtering, field mapping, or access controls than the direct Firestore read.

**Impact:** One-shot reads (`getSubAccounts`) and real-time watches (`watchSubAccounts`) may return different data. If the Cloud Function adds virtual fields, applies post-processing, or filters differently, the UI will show inconsistent data depending on which method was called.

**Fix:** Either make both use the same source (prefer Cloud Function for consistency) or ensure the Firestore query matches the Cloud Function's behavior exactly.

---

### 2.4 HIGH — Daily Earn Cap Uses UTC Instead of SAST

**File:** [engagement.ts](functions/src/engagement.ts) (Lines 82-89)

```typescript
const today = new Date();
today.setHours(0, 0, 0, 0);  // ← Midnight UTC, not SAST

const todayCompletionsSnapshot = await db
  .collection("engagements")
  .where("userId", "==", userId)
  .where("status", "==", EngagementStatus.COMPLETED)
  .where("completedAt", ">=", admin.firestore.Timestamp.fromDate(today))
  .count()
  .get();
```

**Problem:** `new Date().setHours(0, 0, 0, 0)` resets to midnight UTC. South African Standard Time (SAST) is UTC+2. This creates a 2-hour window (22:00–00:00 SAST) where the cap resets early for SA users.

**Contrast:** The pot entry logic in the same file (Lines 741-743) correctly uses `getSASTDayStart()` and `SAST_OFFSET_MS`.

**Impact:** Users can exceed the daily earning limit by completing engagements in the 22:00–00:00 SAST window (which falls in the next UTC day). Over time, this drains brand budgets faster than expected.

**Fix:** Replace `new Date().setHours(0, 0, 0, 0)` with the existing `getSASTDayStart()` utility used elsewhere in the file.

---

### 2.5 HIGH — RewardRepository Missing NetworkException Handling

**File:** [reward_repository_impl.dart](lib/data/repositories/reward_repository_impl.dart) (Lines 17-79)

```dart
try {
  final items = await _remoteDataSource.getUserRewardItems(status: status);
  return Right(items.map((i) => i.toEntity()).toList());
} on AuthException {
  return const Left(Failure.unauthenticated());
} on ServerException catch (e) {
  return Left(Failure.serverError(message: e.message));
} catch (e) {
  return Left(Failure.unknown(message: e.toString()));  // ← NetworkException falls here
}
```

**Problem:** `NetworkException` (defined in `core/error/exceptions.dart`) is not explicitly caught. When thrown (connectivity loss, timeout), it falls to the generic `catch(e)` and maps to `Failure.unknown()` instead of a meaningful network error.

**Impact:** Users see generic "Unknown error" messages instead of "No internet connection" or "Check your network" when offline. All four methods in this file have the same gap.

**Fix:** Add `on NetworkException catch (e) { return Left(Failure.networkError(message: e.message)); }` before the generic catch.

---

### 2.6 MEDIUM — Ledger Journals Readable by All Authenticated Users

**File:** [firestore.rules](firestore.rules) (Lines 336-343)

```
match /ledgerJournals/{journalId} {
  // Users can read journals where they are involved
  allow read: if isAuthenticated();  // ← Too broad
```

**Problem:** The comment says "journals where they are involved" but the rule allows ANY authenticated user to read ALL journals. This exposes every user's financial transaction details (amounts, descriptions, counterparties) to any logged-in user.

**Impact:** Information disclosure — any authenticated user can query the entire journal collection and see all transactions in the system.

**Fix:** Restrict to journals where the user's account ID appears in the entries array, e.g.:
```
allow read: if isAuthenticated()
  && resource.data.accountIds.hasAny(['user:' + request.auth.uid]);
```
(Requires adding a denormalized `accountIds` array field to journal documents for efficient rule evaluation.)

---

### 2.7 MEDIUM — Sub-Account Firestore Rule Uses Wrong Field Pattern

**File:** [firestore.rules](firestore.rules) (Lines 320-325)

```
match /subAccounts/{subAccountId} {
  allow read: if isAuthenticated()
    && (accountId == request.auth.uid  // ← BUG
        || isAdmin());
```

**Problem:** `accountId` is the parent document ID from `/ledgerAccounts/{accountId}`. User ledger accounts follow the format `"user:{userId}"`, so `accountId` will be `"user:abc123"` while `request.auth.uid` is just `"abc123"`. The comparison always fails.

**Contrast:** The parent collection rule (Line 311) correctly uses `accountId == 'user:' + request.auth.uid`.

**Impact:** Users cannot read their own sub-accounts via direct Firestore queries. This likely explains why `getSubAccounts()` uses a Cloud Function (which bypasses security rules) while `watchSubAccounts()` queries Firestore directly — the Firestore path may be silently failing.

**Fix:** Change to `accountId == 'user:' + request.auth.uid`.

> **Note:** This finding connects to Finding 2.3 (data source mismatch). The broken Firestore rule may be the *reason* the Cloud Function path was added as a workaround.

---

### 2.8 MEDIUM — Reward Allocation is Fire-and-Forget

**File:** [engagement.ts](functions/src/engagement.ts) (Lines 940-963)

```typescript
const [streakInfo, , , , rewardInfo] = await Promise.all([
  updateEngagementStats(userId, userShare, engagementStreakPoints)
    .catch((e) => { console.error("Streak stats error:", e); return defaultStreak; }),
  // ... other operations ...
  doRewardAllocation()
    .catch((e) => {
      console.error("Reward allocation error:", e);
      return { rewardPending: false, rewardCampaignName: null, rewardType: null };
    }),
]);
```

**Problem:** Reward allocation runs in a `Promise.all()` with `.catch()` error swallowing. If allocation fails, the engagement is already marked `COMPLETED` (committed in an earlier transaction at Lines 704-807), but the user receives no reward. There is no retry mechanism or dead-letter queue.

**Impact:** Users may complete engagement tasks but silently fail to receive their reward item. The only evidence is a server console log.

**Fix:** Implement a reward allocation queue (e.g., Cloud Tasks) with retry logic, or at minimum write failed allocations to a `failedRewardAllocations` collection for manual admin intervention.

---

### 2.9 MEDIUM — Unsafe Enum String Conversion in RewardItemModel

**File:** [reward_item_model.dart](lib/data/models/reward_item_model.dart) (Lines 70-71)

```dart
rewardType: rewardType != null ? RewardTypeX.fromString(rewardType!) : null,
status: RewardItemStatusX.fromString(status),  // ← Silent default
```

**Problem:** `fromString()` methods in [reward_enums.dart](lib/domain/enums/reward_enums.dart) silently return defaults for unrecognized strings:
- Unknown `RewardType` → `voucherCode` (Line 45)
- Unknown `RewardItemStatus` → `available` (Line 163)

**Impact:** Data corruption goes undetected. A Firestore document with `status: "avaiable"` (typo) would silently parse as `available`, masking the error. An expired item with a typo'd status would appear as available.

**Fix:** Add logging for unrecognized values, or throw an explicit error during development/testing.

---

### 2.10 MEDIUM — Stream Subscription Race Condition in WalletBloc

**File:** [wallet_bloc.dart](lib/presentation/blocs/wallet/wallet_bloc.dart) (Lines 20-45, 83-98, 354-360)

```dart
StreamSubscription? _ledgerAccountSubscription;
StreamSubscription? _ledgerJournalsSubscription;
StreamSubscription? _engagementStatsSubscription;
StreamSubscription? _subAccountsSubscription;
```

**Problem:** Four stream subscriptions are held as nullable instance fields. Each `_onWatch*` handler cancels the old subscription and creates a new one. If cancellation happens while a listener callback is mid-execution:
1. Old subscription cancelled → old callback fires on cancelled stream → `add()` called on potentially closed BLoC
2. Multiple rapid calls create → cancel → create race
3. `close()` during callback execution can add events to a closed BLoC

**Impact:** Potential `StateError: Cannot add new events after calling close` in edge cases (rapid navigation, logout during data loading).

**Fix:** Add `isClosed` check before `add()` calls in stream callbacks, or use `StreamSubscription.asFuture()` with proper cancellation tokens.

---

### 2.11 LOW — No Reward Activity Audit Trail in Admin Portal

**File:** [admin_router.dart](lib/presentation/admin/router/admin_router.dart)

The admin portal has a fully functional `RewardCampaignScreen` (1639 lines) for managing campaigns, codes, and A/B tests. However, there is no:
- Reward allocation activity log viewer (which users received which rewards, when)
- Reward redemption audit trail
- Failed allocation recovery screen

The `reward_activity_log` collection defined in the architecture doc has no admin UI.

**Impact:** Admins have no visibility into reward distribution. Troubleshooting user reports of missing rewards requires direct Firestore console access.

**Fix:** Add a reward activity log viewer to the admin portal, filtered by campaign, user, or status.

---

## Part 3: Verification Matrix

### Token Ledger Flow

| Step | Component | Status |
|------|-----------|--------|
| Ledger account creation | `functions/src/ledger/accounts.ts` | CORRECT |
| Double-entry journal posting | `functions/src/ledger/journals.ts` | CORRECT (atomicized) |
| Sub-account creation | `functions/src/ledger/index.ts` → `getOrCreateBrandSubAccount` | CORRECT |
| Balance display | `wallet_screen.dart` → `WalletState.balance` → `LedgerAccount.balance` | CORRECT |
| Sub-account balance | `wallet_detail_screen.dart` → `SubAccount.balance` | CORRECT |
| Portfolio total | `wallet_screen.dart` → `WalletState.portfolioBalance` (sum of all sub-accounts) | CORRECT |
| ZAR conversion | `AppConstants.tokensToZar()` (÷100) | CORRECT |
| Journal pagination | `wallet_bloc.dart` → `getLedgerJournals()` | BUG (Finding 2.1) |
| Pull-to-refresh | `WalletEvent.refreshLedger()` + `RewardEvent.refreshItems()` | CORRECT |

### Rewards Inventory Flow

| Step | Component | Status |
|------|-----------|--------|
| Reward item loading | `RewardBloc` → `getUserRewardItems()` Cloud Function | CORRECT |
| Active/redeemed/expired filtering | `RewardState` computed getters | CORRECT |
| Reward count on portfolio card | `wallet_screen.dart` → `rewardState.activeCount` | CORRECT |
| Inline reward cards | `wallet_screen.dart` → `_buildRewardsSection()` | CORRECT |
| Rewards list (3 tabs) | `rewards_list_screen.dart` | CORRECT |
| Reward detail (QR/code/digital) | `reward_item_detail_screen.dart` | CORRECT |
| Mark as used | `RewardEvent.redeemItem()` → Cloud Function | CORRECT |
| POPIA consent check | `rewards_list_screen.dart` + `wallet_screen.dart` | CORRECT |
| Feature flag gating | `_rewardsUiEnabled` from platform settings | CORRECT |
| Brand ↔ reward linking | `wallet_detail_screen.dart` → `_getBrandRewards()` | CORRECT |

### Sub-Account System

| Step | Component | Status |
|------|-----------|--------|
| Default wallet display | `wallet_screen.dart` → `isDefault` check | CORRECT |
| Brand wallet display | `wallet_screen.dart` → `isRestricted` check | CORRECT |
| Brand wallet detail | `wallet_detail_screen.dart` | CORRECT |
| Send from sub-account | `/wallet/send` → `WalletSendScreen(subAccountId)` | CORRECT |
| Cash out (default only) | `/wallet/withdraw` → `CashoutScreen` | CORRECT |
| Sub-account Firestore access | `firestore.rules` sub-account match | BUG (Finding 2.7) |
| Sub-account Cloud Function | `getSubAccounts` callable | CORRECT |

### Cashout Flow

| Step | Component | Status |
|------|-----------|--------|
| Eligibility check | `WalletState.canCashout` (active + balance ≥ 5000) | CORRECT |
| Request submission | `CashoutBloc` → `requestCashout()` | CORRECT |
| Admin approval | `completeCashoutRequest` (with `requireAdminPermission`) | CORRECT |
| Admin rejection | `failCashoutRequest` | BUG (Finding 2.2: missing admin check) |
| Cancel by user | `CashoutBloc._onCancelCashout` | BUG (Finding 2.2: broken logic) |

---

## Part 4: Prioritized Recommendations

### P0 — Fix Before Next Deploy

| # | Issue | Effort | Risk if Unfixed |
|---|-------|--------|-----------------|
| 2.2 | `failCashoutRequest` add `requireAdminPermission` | 5 min | Any user can fail any cashout |
| 2.7 | Sub-account rule: change to `'user:' + request.auth.uid` | 5 min | Users can't read own sub-accounts via Firestore |

### P1 — Fix This Sprint

| # | Issue | Effort | Risk if Unfixed |
|---|-------|--------|-----------------|
| 2.1 | Pagination cursor: use `postedAt` only, handle null gracefully | 30 min | Duplicate/missing transactions in history |
| 2.4 | Daily earn cap: use `getSASTDayStart()` | 15 min | Users bypass daily limit during 22:00-00:00 SAST |
| 2.6 | Ledger journal rules: restrict to user's own accounts | 2 hr | All transactions visible to all users |

### P2 — Fix Next Sprint

| # | Issue | Effort | Risk if Unfixed |
|---|-------|--------|-----------------|
| 2.3 | Sub-account data source: unify to single source | 2 hr | Inconsistent wallet data |
| 2.2 (CashoutBloc) | Fix cancel logic: emit + dispatch sequentially | 1 hr | Stale UI after cashout cancel |
| 2.8 | Reward allocation: add retry/dead-letter queue | 4 hr | Silent reward loss |
| 2.10 | Stream race condition: add `isClosed` guards | 1 hr | Rare crash on rapid navigation |

### P3 — Backlog

| # | Issue | Effort | Risk if Unfixed |
|---|-------|--------|-----------------|
| 2.5 | NetworkException handling in reward repo | 30 min | Poor offline UX |
| 2.9 | Enum default logging | 30 min | Silent data corruption |
| 2.11 | Reward activity admin screen | 8 hr | No admin visibility into reward distribution |

---

## Part 5: What's Working Well

- **Dual rewards architecture** is fully wired: tokens and reward items appear together on the wallet screen with proper feature flag gating
- **POPIA consent** is checked at all reward entry points (list screen, inline section, quick action)
- **Brand wallet ↔ reward linking** correctly filters reward items by matching `clientName`
- **Sub-account cards** visually distinguish default vs brand wallets with distinct colors, icons, and labels
- **Atomic ledger transactions** (recently implemented) ensure double-entry consistency
- **Reward detail screen** handles all code types (QR, text, digital content with URL/access code)
- **Activity history** provides unified view of both token and reward activity with proper toggle
- **Admin reward campaign screen** is comprehensive (1639 lines) with full CRUD, code import, A/B testing, and stats
- **Pull-to-refresh** correctly refreshes both wallet and reward data
- **GoRouter** used consistently throughout — no `Navigator.push()` in wallet screens

---

## Appendix: Files Reviewed

### Mobile App (Flutter)
- `lib/presentation/screens/wallet/wallet_screen.dart`
- `lib/presentation/screens/wallet/wallet_detail_screen.dart`
- `lib/presentation/screens/wallet/transaction_history_screen.dart`
- `lib/presentation/screens/wallet/rewards_list_screen.dart`
- `lib/presentation/screens/wallet/reward_item_detail_screen.dart`
- `lib/presentation/screens/wallet/cashout_screen.dart`
- `lib/presentation/screens/wallet/wallet_send_screen.dart`
- `lib/presentation/screens/wallet/wallet_send_amount_screen.dart`
- `lib/presentation/blocs/wallet/wallet_bloc.dart`
- `lib/presentation/blocs/wallet/wallet_state.dart`
- `lib/presentation/blocs/wallet/wallet_event.dart`
- `lib/presentation/blocs/reward/reward_bloc.dart`
- `lib/presentation/blocs/reward/reward_state.dart`
- `lib/presentation/blocs/reward/reward_event.dart`
- `lib/presentation/blocs/cashout/cashout_bloc.dart`
- `lib/presentation/router/app_router.dart`
- `lib/domain/entities/reward_item.dart`
- `lib/domain/entities/sub_account.dart`
- `lib/domain/entities/ledger_journal.dart`
- `lib/domain/enums/reward_enums.dart`
- `lib/data/models/reward_item_model.dart`
- `lib/data/datasources/remote/wallet_remote_datasource.dart`
- `lib/data/repositories/reward_repository_impl.dart`

### Backend (Cloud Functions)
- `functions/src/engagement.ts`
- `functions/src/wallet.ts`
- `functions/src/rewardAllocation.ts`
- `functions/src/ledger/index.ts`
- `functions/src/ledger/journals.ts`
- `functions/src/ledger/accounts.ts`

### Firestore
- `firestore.rules`
- `firestore.indexes.json`

### Admin Portal
- `lib/presentation/admin/router/admin_router.dart`
- `lib/presentation/admin/screens/reward_campaign_screen.dart`
