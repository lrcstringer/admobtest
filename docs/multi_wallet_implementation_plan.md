# Multi-Wallet Portfolio Implementation Plan

## Executive Summary

Transform the current single-balance Wallet tab into a multi-wallet portfolio view where users see their **iMaliChat Wallet** (default, unrestricted) plus any **brand wallets** (restricted, earned through brand campaigns). Each wallet is a tappable card leading to a detail screen with actions (Send, Withdraw, History). The backend ledger sub-account system already supports this — this plan activates it in the Flutter client and wires up the remaining Cloud Functions endpoints.

---

## Architecture Overview

### What Already Exists

| Layer | Component | Status |
|-------|-----------|--------|
| **Backend** | `ledger/subAccounts.ts` — full CRUD for sub-accounts | **Complete** |
| **Backend** | `ledger/index.ts` — `processEarningWithSplit()` credits sub-account | **Complete** |
| **Backend** | `ledger/journals.ts` — double-entry journal posting | **Complete** |
| **Backend** | `wallet.ts` — cashout with sub-account support | **Complete** |
| **Backend** | `engagement.ts` — `processEngagement()` passes `subAccountId` | **Complete** |
| **Flutter** | `SubAccount` entity (`lib/domain/entities/sub_account.dart`) | **Defined, unused** |
| **Flutter** | `SubAccountModel` (`lib/data/models/sub_account_model.dart`) | **Defined, unused** |
| **Flutter** | `WalletBloc/State/Events` — single `LedgerAccount` + journals | **Active, needs extension** |
| **Flutter** | `WalletRepository` / `WalletRemoteDataSource` | **Active, needs extension** |
| **Flutter** | `wallet_screen.dart` — single balance view | **Active, will be replaced** |
| **Flutter** | `transaction_history_screen.dart` — journal list with filters | **Active, will be extended** |
| **Flutter** | `cashout_screen.dart` — full cashout flow (786 lines) | **Active, reuse as-is** |
| **Flutter** | Placeholder screens (send, success, failure) | **Stubs, need implementation** |

### Firestore Data Model

```
ledgerAccounts/
  user:{userId}/                     ← Master account (balance = sum of all sub-accounts)
    subAccounts/
      {subAccountId}/               ← Individual wallets
        userId: string
        accountTypeId: string|null  ← null = unrestricted (iMaliChat Wallet)
        name: string                ← "iMaliChat" or brand name
        balance: int                ← Token balance
        lifetimeCredits: int
        lifetimeDebits: int
        isActive: bool
        isDefault: bool             ← true for iMaliChat Wallet only
        createdAt: timestamp
        updatedAt: timestamp

accountTypes/
  {accountTypeId}/                  ← Brand wallet definitions
    name: string                    ← "Nike SA", "Checkers", etc.
    description: string
    brandId: string
    allowedOfframps: string[]       ← ["nike_store", "nike_online"]
    allowP2pSend: bool
    allowP2pReceive: bool
    allowCashout: bool              ← false for brand wallets
    expiryDays: int|null
    isActive: bool

ledgerJournals/
  {journalId}/
    ...existing fields...
    metadata.subAccountId: string   ← Which sub-account was affected
```

### Screen Hierarchy

```
Tab 3: /wallet                         → WalletsListScreen (portfolio view)
        /wallet/:subAccountId          → WalletDetailScreen (single wallet)
        /wallet/:subAccountId/history  → TransactionHistoryScreen (filtered)
        /wallet/:subAccountId/send     → WalletSendContactScreen (contact picker)
        /wallet/:subAccountId/send/:contactId → WalletSendAmountScreen
        /wallet/:subAccountId/send/:contactId/success → WalletSendSuccessScreen
        /wallet/:subAccountId/send/:contactId/failure → WalletSendFailureScreen
        /wallet/cashout                → CashoutScreen (existing, default wallet only)
        /wallet/transactions           → TransactionHistoryScreen (all wallets)
```

---

## Phase 1: Backend — Expose Sub-Accounts to Client

### 1.1 Cloud Function: `getSubAccounts`

**File:** `functions/src/wallet.ts`

New HTTPS callable that returns all active sub-accounts for the authenticated user. The backend `getUserSubAccounts()` in `ledger/subAccounts.ts` already exists — this just wraps it as a callable.

```typescript
export const getSubAccounts = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new HttpsError('unauthenticated', 'Not authenticated');
  const userId = context.auth.uid;

  // getUserSubAccounts() already exists in ledger/subAccounts.ts
  const subAccounts = await getUserSubAccounts(userId);

  // Ensure default sub-account exists (creates if missing)
  if (subAccounts.length === 0 || !subAccounts.find(sa => sa.isDefault)) {
    const defaultSA = await getOrCreateDefaultSubAccount(userId);
    return [defaultSA];
  }

  return subAccounts;
});
```

**Why callable instead of direct Firestore read?** The `getOrCreateDefaultSubAccount()` logic handles auto-creation atomically. If the client reads the subcollection directly and it's empty, there's a race condition. The callable ensures the default always exists.

### 1.2 Firestore Security Rules

**File:** `firestore.rules`

Add read access for the sub-accounts subcollection:

```
match /ledgerAccounts/{accountId}/subAccounts/{subAccountId} {
  allow read: if isAuthenticated()
    && accountId == 'user:' + request.auth.uid;
  // Writes are server-side only (Cloud Functions)
}
```

Also add read access for `accountTypes` (public brand definitions):

```
match /accountTypes/{typeId} {
  allow read: if isAuthenticated();
}
```

### 1.3 Cloud Function: `transferBetweenWallets`

**File:** `functions/src/wallet.ts`

Wraps the existing `transferBetweenSubAccounts()` from `ledger/subAccounts.ts`:

```typescript
export const transferBetweenWallets = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new HttpsError('unauthenticated', 'Not authenticated');

  const { fromSubAccountId, toSubAccountId, amount, note } = data;

  // Validate both sub-accounts belong to user
  // transferBetweenSubAccounts() already validates and creates journal
  const result = await transferBetweenSubAccounts(
    context.auth.uid,
    fromSubAccountId,
    toSubAccountId,
    amount,
    note || 'Wallet transfer',
  );

  return { success: true, journalId: result.journalId };
});
```

### 1.4 Register New Functions

**File:** `functions/src/index.ts`

Export the new callables:

```typescript
export { getSubAccounts, transferBetweenWallets } from './wallet';
```

### 1.5 Journal Metadata Enhancement

**File:** `functions/src/ledger/index.ts`

Ensure `processEarningWithSplit()`, `processPurchaseTransaction()`, and `processP2PTransfer()` write `subAccountId` into journal `metadata` so the Flutter client can filter transactions by wallet. Check existing code — this may already be present. If not, add:

```typescript
metadata: {
  ...existingMetadata,
  subAccountId: subAccountId,
}
```

---

## Phase 2: Flutter — Data Layer

### 2.1 Extend `WalletRemoteDataSource`

**File:** `lib/data/datasources/remote/wallet_remote_datasource.dart`

Add sub-account methods to both the abstract class and implementation:

```dart
// Abstract class additions:
Future<List<SubAccountModel>> getSubAccounts();
Stream<List<SubAccountModel>> watchSubAccounts();
Future<void> transferBetweenWallets({
  required String fromSubAccountId,
  required String toSubAccountId,
  required int amount,
  String? note,
});
```

Implementation:

```dart
@override
Future<List<SubAccountModel>> getSubAccounts() async {
  final userId = currentUserId;
  if (userId == null) throw const AuthException(message: 'User not authenticated');

  try {
    // Call the Cloud Function which ensures default sub-account exists
    final callable = _functions.httpsCallable('getSubAccounts');
    final result = await callable.call<List<dynamic>>({});

    return (result.data).map((data) {
      final map = Map<String, dynamic>.from(data as Map);
      return SubAccountModel.fromJson(map);
    }).toList();
  } catch (e) {
    throw ServerException(message: e.toString());
  }
}

@override
Stream<List<SubAccountModel>> watchSubAccounts() {
  final userId = currentUserId;
  if (userId == null) {
    return Stream.error(const AuthException(message: 'User not authenticated'));
  }

  return _ledgerAccountsCollection
      .doc('user:$userId')
      .collection('subAccounts')
      .where('isActive', isEqualTo: true)
      .orderBy('isDefault', descending: true)  // Default wallet first
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return SubAccountModel.fromFirestore(doc);
        }).toList();
      });
}

@override
Future<void> transferBetweenWallets({
  required String fromSubAccountId,
  required String toSubAccountId,
  required int amount,
  String? note,
}) async {
  final callable = _functions.httpsCallable('transferBetweenWallets');
  await callable.call<Map<String, dynamic>>({
    'fromSubAccountId': fromSubAccountId,
    'toSubAccountId': toSubAccountId,
    'amount': amount,
    if (note != null) 'note': note,
  });
}
```

### 2.2 Extend `WalletRepository`

**File:** `lib/domain/repositories/wallet_repository.dart`

Add sub-account methods:

```dart
// Sub-Account Methods
Future<Either<Failure, List<SubAccount>>> getSubAccounts();
Stream<Either<Failure, List<SubAccount>>> watchSubAccounts();
Future<Either<Failure, void>> transferBetweenWallets({
  required String fromSubAccountId,
  required String toSubAccountId,
  required int amount,
  String? note,
});
```

### 2.3 Extend `WalletRepositoryImpl`

**File:** `lib/data/repositories/wallet_repository_impl.dart`

Implement the new methods following the existing pattern (try/catch → Either):

```dart
@override
Future<Either<Failure, List<SubAccount>>> getSubAccounts() async {
  try {
    final models = await _remoteDataSource.getSubAccounts();
    return Right(models.map((m) => m.toEntity()).toList());
  } catch (e) {
    if (e is AuthException) return const Left(Failure.unauthenticated());
    return Left(Failure.serverError(message: e.toString()));
  }
}

@override
Stream<Either<Failure, List<SubAccount>>> watchSubAccounts() {
  return _remoteDataSource.watchSubAccounts().map((models) {
    try {
      return Right<Failure, List<SubAccount>>(
        models.map((m) => m.toEntity()).toList(),
      );
    } catch (e) {
      return Left<Failure, List<SubAccount>>(
        Failure.serverError(message: e.toString()),
      );
    }
  });
}

@override
Future<Either<Failure, void>> transferBetweenWallets({
  required String fromSubAccountId,
  required String toSubAccountId,
  required int amount,
  String? note,
}) async {
  try {
    await _remoteDataSource.transferBetweenWallets(
      fromSubAccountId: fromSubAccountId,
      toSubAccountId: toSubAccountId,
      amount: amount,
      note: note,
    );
    return const Right(null);
  } catch (e) {
    return Left(Failure.serverError(message: e.toString()));
  }
}
```

### 2.4 Extend `SubAccount` Entity

**File:** `lib/domain/entities/sub_account.dart`

Add a computed property for the accent gradient (used in UI):

```dart
/// Get accent color gradient based on account type
/// Default wallet uses primary gradient, brand wallets use distinct colors
List<Color>? get accentGradient => null; // UI layer handles this
```

No changes needed — the entity is already well-designed. The UI layer will map `accountTypeId` to colors.

### 2.5 Filter Journals by Sub-Account

**File:** `lib/data/datasources/remote/wallet_remote_datasource.dart`

Add optional `subAccountId` parameter to journal queries:

```dart
Future<List<LedgerJournalModel>> getLedgerJournals({
  int? limit,
  DateTime? startAfter,
  String? subAccountId,  // NEW: filter by wallet
});
```

In the implementation, filter journals where `metadata.subAccountId == subAccountId` (client-side filter on top of existing query, since Firestore doesn't support querying nested map fields efficiently).

---

## Phase 3: Flutter — State Management

### 3.1 Extend `WalletState`

**File:** `lib/presentation/blocs/wallet/wallet_state.dart`

```dart
@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletStatus.initial) WalletStatus status,
    LedgerAccount? ledgerAccount,
    UserEngagementStats? engagementStats,
    @Default([]) List<LedgerJournal> ledgerJournals,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMoreLedgerJournals,
    @Default([]) List<SubAccount> subAccounts,       // NEW
    String? selectedSubAccountId,                     // NEW: for detail view
    @Default(false) bool isTransferring,              // NEW: wallet-to-wallet transfer
    String? errorMessage,
    String? successMessage,                           // NEW
  }) = _WalletState;

  const WalletState._();

  // Existing computed properties unchanged...
  int get balance => ledgerAccount?.balance ?? 0;
  double get balanceZar => balance / 100;
  bool get canCashout => ledgerAccount?.isActive == true && balance >= 500;
  int get currentStreak => engagementStats?.currentStreak ?? 0;
  int get longestStreak => engagementStats?.longestStreak ?? 0;
  double get streakMultiplier => engagementStats?.streakMultiplier ?? 1.0;
  int get totalTokensEarned => engagementStats?.totalTokensEarned ?? 0;

  // NEW computed properties
  /// Total portfolio value in tokens (sum of all sub-account balances)
  int get portfolioBalance =>
      subAccounts.fold(0, (sum, sa) => sum + sa.balance);

  /// Total portfolio value in ZAR
  double get portfolioBalanceZar => portfolioBalance / 100;

  /// Get the default (iMaliChat) sub-account
  SubAccount? get defaultSubAccount =>
      subAccounts.where((sa) => sa.isDefault).firstOrNull;

  /// Get the currently selected sub-account
  SubAccount? get selectedSubAccount => selectedSubAccountId != null
      ? subAccounts.where((sa) => sa.id == selectedSubAccountId).firstOrNull
      : null;

  /// Brand (restricted) sub-accounts only
  List<SubAccount> get brandSubAccounts =>
      subAccounts.where((sa) => sa.isRestricted).toList();
}
```

### 3.2 Extend `WalletEvent`

**File:** `lib/presentation/blocs/wallet/wallet_event.dart`

```dart
@freezed
class WalletEvent with _$WalletEvent {
  // Existing events unchanged...
  const factory WalletEvent.loadLedger() = _LoadLedger;
  const factory WalletEvent.watchLedgerAccount() = _WatchLedgerAccount;
  const factory WalletEvent.ledgerAccountUpdated(LedgerAccount ledgerAccount) = _LedgerAccountUpdated;
  const factory WalletEvent.loadLedgerJournals({int? limit}) = _LoadLedgerJournals;
  const factory WalletEvent.loadMoreLedgerJournals() = _LoadMoreLedgerJournals;
  const factory WalletEvent.watchLedgerJournals({int? limit}) = _WatchLedgerJournals;
  const factory WalletEvent.ledgerJournalsUpdated(List<LedgerJournal> journals) = _LedgerJournalsUpdated;
  const factory WalletEvent.refreshLedger() = _RefreshLedger;
  const factory WalletEvent.watchEngagementStats() = _WatchEngagementStats;
  const factory WalletEvent.engagementStatsUpdated(UserEngagementStats stats) = _EngagementStatsUpdated;

  // NEW sub-account events
  const factory WalletEvent.loadSubAccounts() = _LoadSubAccounts;
  const factory WalletEvent.watchSubAccounts() = _WatchSubAccounts;
  const factory WalletEvent.subAccountsUpdated(List<SubAccount> subAccounts) = _SubAccountsUpdated;
  const factory WalletEvent.selectSubAccount(String subAccountId) = _SelectSubAccount;
  const factory WalletEvent.transferBetweenWallets({
    required String fromSubAccountId,
    required String toSubAccountId,
    required int amount,
    String? note,
  }) = _TransferBetweenWallets;
  const factory WalletEvent.clearMessages() = _ClearMessages;
}
```

### 3.3 Extend `WalletBloc`

**File:** `lib/presentation/blocs/wallet/wallet_bloc.dart`

Add handlers for the new events:

```dart
StreamSubscription? _subAccountsSubscription;  // NEW

// In constructor, register new handlers:
on<_LoadSubAccounts>(_onLoadSubAccounts);
on<_WatchSubAccounts>(_onWatchSubAccounts);
on<_SubAccountsUpdated>(_onSubAccountsUpdated);
on<_SelectSubAccount>(_onSelectSubAccount);
on<_TransferBetweenWallets>(_onTransferBetweenWallets);
on<_ClearMessages>(_onClearMessages);

// In _onLoadLedger, add after existing code:
add(const WalletEvent.loadSubAccounts());
add(const WalletEvent.watchSubAccounts());

// New handler implementations:

Future<void> _onLoadSubAccounts(_LoadSubAccounts event, Emitter<WalletState> emit) async {
  final result = await _walletRepository.getSubAccounts();
  result.fold(
    (failure) { /* Silent — sub-accounts may not exist yet */ },
    (subAccounts) => emit(state.copyWith(subAccounts: subAccounts)),
  );
}

void _onWatchSubAccounts(_WatchSubAccounts event, Emitter<WalletState> emit) {
  _subAccountsSubscription?.cancel();
  _subAccountsSubscription = _walletRepository.watchSubAccounts().listen(
    (result) {
      result.fold(
        (failure) {},
        (subAccounts) => add(WalletEvent.subAccountsUpdated(subAccounts)),
      );
    },
  );
}

void _onSubAccountsUpdated(_SubAccountsUpdated event, Emitter<WalletState> emit) {
  emit(state.copyWith(subAccounts: event.subAccounts));
}

void _onSelectSubAccount(_SelectSubAccount event, Emitter<WalletState> emit) {
  emit(state.copyWith(selectedSubAccountId: event.subAccountId));
}

Future<void> _onTransferBetweenWallets(
  _TransferBetweenWallets event, Emitter<WalletState> emit,
) async {
  emit(state.copyWith(isTransferring: true));

  final result = await _walletRepository.transferBetweenWallets(
    fromSubAccountId: event.fromSubAccountId,
    toSubAccountId: event.toSubAccountId,
    amount: event.amount,
    note: event.note,
  );

  result.fold(
    (failure) => emit(state.copyWith(
      isTransferring: false,
      errorMessage: failure.displayMessage,
    )),
    (_) => emit(state.copyWith(
      isTransferring: false,
      successMessage: 'Transfer complete',
    )),
  );
}

void _onClearMessages(_ClearMessages event, Emitter<WalletState> emit) {
  emit(state.copyWith(errorMessage: null, successMessage: null));
}

// In close():
_subAccountsSubscription?.cancel();
```

### 3.4 Run Freezed Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

This regenerates:
- `wallet_bloc.freezed.dart`
- Any other freezed files that changed

---

## Phase 4: Flutter — UI Screens

### 4.1 `WalletsListScreen` (replaces `wallet_screen.dart`)

**File:** `lib/presentation/screens/wallet/wallet_screen.dart`

This screen replaces the current single-balance view. Layout (top to bottom):

```
┌─────────────────────────────────┐
│  IMaliAppBar: "My Wallets"      │
│  [History button in extraActions]│
├─────────────────────────────────┤
│  Total Portfolio Value           │
│  R 357.00                        │
│  3,570 Tokens                    │
├─────────────────────────────────┤
│  YOUR ASSETS                     │
│                                  │
│  ┌─ iMaliChat Wallet ─────────┐ │
│  │ ▌ 3,570 Tokens  ≈ R357.00 │ │
│  │ ▌ Spend anywhere or        │ │
│  │ ▌ withdraw          🛡️ → │ │
│  └────────────────────────────┘ │
│                                  │
│  ┌─ Nike SA Wallet ───────────┐ │
│  │ ▌ 120 Tokens    ≈ R12.00  │ │
│  │ ▌ Use for Nike purchases → │ │
│  └────────────────────────────┘ │
│                                  │
│  ┌─ Checkers Wallet ──────────┐ │
│  │ ▌ 80 Tokens     ≈ R8.00   │ │
│  │ ▌ Use for Sixty60 coupons→ │ │
│  └────────────────────────────┘ │
└─────────────────────────────────┘
```

**Key implementation details:**

- Uses `BlocBuilder<WalletBloc, WalletState>` to read `state.subAccounts`
- Portfolio total = `state.portfolioBalance` / `state.portfolioBalanceZar`
- Each wallet card is a `GestureDetector` → `context.go('/wallet/${sa.id}')`
- Default wallet always appears first (sorted by `isDefault` descending)
- Left accent stripe: `AppColors.primaryGradient` for default, brand-specific for others
- Green shield icon (`Icons.verified_user`) on wallets where `canCashout == true`
- History button in app bar → `context.go('/wallet/transactions')`
- `RefreshIndicator` triggers `WalletEvent.refreshLedger()` + `WalletEvent.loadSubAccounts()`
- Loading state: show shimmer placeholders matching card layout
- Empty state: only the default wallet card (always at least one)

**Wallet card widget:**

```dart
Widget _buildWalletCard(BuildContext context, SubAccount subAccount) {
  final accentColors = subAccount.isDefault
      ? AppColors.primaryGradient
      : _getBrandGradient(subAccount.accountTypeId);

  return GestureDetector(
    onTap: () {
      context.read<WalletBloc>().add(WalletEvent.selectSubAccount(subAccount.id));
      context.go('/wallet/${subAccount.id}');
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Left accent stripe
          Container(
            width: 4,
            height: 100, // approximate
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: accentColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          // Card content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildWalletIcon(subAccount),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subAccount.name, style: titleSmall.bold),
                            Text(_getWalletDescription(subAccount), style: bodySmall.secondary),
                          ],
                        ),
                      ),
                      if (subAccount.canCashout)
                        Icon(Icons.verified_user, color: AppColors.success, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${subAccount.balance} Tokens', style: titleMedium.bold),
                          Text('≈ R${subAccount.balanceZar.toStringAsFixed(2)}',
                              style: bodySmall.secondary),
                        ],
                      ),
                      Icon(Icons.arrow_forward, color: AppColors.textSecondary, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
```

### 4.2 `WalletDetailScreen` (new)

**File:** `lib/presentation/screens/wallet/wallet_detail_screen.dart`

Shows a single wallet's details when a card is tapped.

```
┌──────────────────────────────────┐
│ ← Back   "iMaliChat Wallet"     │
├──────────────────────────────────┤
│                                  │
│  ┌────────────────────────────┐  │
│  │  ═══ gradient accent ═══  │  │
│  │                            │  │
│  │  [icon]  R 357.00          │  │
│  │          3,570 Tokens      │  │
│  │                            │  │
│  │  [ Send ]   [ Withdraw ]   │  │
│  └────────────────────────────┘  │
│                                  │
│  WALLET DETAILS                  │
│  ┌────────────────────────────┐  │
│  │ Type          General      │  │
│  │ ─────────────────────────  │  │
│  │ Description   Spend        │  │
│  │               anywhere     │  │
│  │ ─────────────────────────  │  │
│  │ Withdrawal    🛡️ Available│  │
│  └────────────────────────────┘  │
│                                  │
│  RECENT ACTIVITY                 │
│  [3 most recent transactions]    │
│  "View full history →"           │
└──────────────────────────────────┘
```

**Key implementation details:**

- Constructor takes `subAccountId` parameter (from route)
- Reads `state.selectedSubAccount` or finds by ID in `state.subAccounts`
- Action buttons:
  - **Send**: `context.go('/wallet/$subAccountId/send')` — only for unrestricted wallets or wallets where `allowP2pSend == true`
  - **Withdraw**: `context.go('/wallet/cashout')` — only for default wallet (`canCashout == true`). Disabled/grayed for brand wallets with "Restricted" label.
- Recent transactions: filter `state.ledgerJournals` where journal metadata `subAccountId` matches. Show 3 most recent with "View full history" link.
- Wallet details section shows: Type (General/Brand), Description, Withdrawal Status
- For brand wallets, add "Transfer to iMaliChat Wallet" button (calls `transferBetweenWallets`)

### 4.3 `WalletSendContactScreen` (replaces placeholder `wallet_send_screen.dart`)

**File:** `lib/presentation/screens/wallet/wallet_send_screen.dart`

Contact picker for P2P token transfer. Mirrors the TSX `wallet-send-select-contact.tsx`.

```
┌──────────────────────────────────┐
│ ← Back    "Send to..."          │
├──────────────────────────────────┤
│  🔍 Search people...            │
├──────────────────────────────────┤
│                                  │
│  [Avatar] Thabo M.              │
│           +27 82 123 4567       │
│                                  │
│  [Avatar] Sarah J.              │
│           +27 71 987 6543       │
│                                  │
│  [Avatar] Mike D.               │
│           +27 60 555 1234       │
│                                  │
└──────────────────────────────────┘
```

**Key implementation details:**

- Must check if contacts are synced (similar to chat contact sync flow)
- Filter to only show contacts on iMaliChat (similar pattern to chat feature)
- Search filters by name and phone number
- Tapping a contact → `context.go('/wallet/$subAccountId/send/$contactId')`
- Show empty state if no contacts synced with "Sync Contacts" button
- This screen may share logic with the existing chat send flow — consider extracting a shared contact list widget

### 4.4 `WalletSendAmountScreen` (new)

**File:** `lib/presentation/screens/wallet/wallet_send_amount_screen.dart`

Amount entry and confirmation. Mirrors TSX `wallet-send-amount.tsx`.

```
┌──────────────────────────────────┐
│ ← Back    "Send Money"          │
├──────────────────────────────────┤
│  From: [icon] iMaliChat Wallet  │
│        Available: R 357.00      │
├──────────────────────────────────┤
│                                  │
│         [Avatar]                 │
│       Sending to                 │
│      Thabo M.                    │
│                                  │
│       R [   0   ]                │
│                                  │
│  Add a note (optional)           │
│                                  │
│  [ Confirm & Send ]              │
│                                  │
└──────────────────────────────────┘
```

**Key implementation details:**

- Shows source wallet info (name, available balance)
- Shows recipient info (avatar, name)
- Amount input with "R" prefix, validates against available balance
- Optional note field
- "Confirm & Send" button calls a new Cloud Function `sendP2PTransfer`
- On success → navigate to success screen
- On failure → navigate to failure screen
- Amount validation: must be > 0, must not exceed wallet balance, must be integer tokens (convert from ZAR input: amount * 100)

### 4.5 Update Placeholder Screens

Replace the "Coming Soon" placeholders with actual implementations:

- **`wallet_send_success_screen.dart`**: Green checkmark, "Money Sent!" message, amount, recipient name, "Done" button → navigate back to wallet detail
- **`wallet_send_failure_screen.dart`**: Red X icon, error message, "Try Again" and "Go Back" buttons
- **`wallet_withdraw_success_screen.dart`**: Navigate from cashout flow on success
- **`wallet_withdraw_failure_screen.dart`**: Navigate from cashout flow on failure

### 4.6 Update `TransactionHistoryScreen`

**File:** `lib/presentation/screens/wallet/transaction_history_screen.dart`

Add optional `subAccountId` parameter to filter transactions for a specific wallet:

```dart
class TransactionHistoryScreen extends StatefulWidget {
  final String? subAccountId;  // null = show all wallets

  const TransactionHistoryScreen({super.key, this.subAccountId});
  // ...
}
```

In the build method, when `subAccountId` is not null, filter journals by checking `journal.metadata['subAccountId'] == subAccountId`.

Add a wallet selector chip/dropdown in the filter bar (next to existing type filter) so users can switch between wallets within the history view.

### 4.7 Update `CashoutScreen`

**File:** `lib/presentation/screens/wallet/cashout_screen.dart`

Minor change: pass the default sub-account ID to the cashout Cloud Function so it debits from the correct sub-account. The current implementation uses `user:$userId` as the account — this stays the same. Just ensure the cashout request includes `subAccountId` in the payload for the new `processCashout` (which already reads it from the request data in `wallet.ts`).

---

## Phase 5: Flutter — Routing

### 5.1 Update `AppRouter`

**File:** `lib/presentation/router/app_router.dart`

Replace the Wallet tab branch:

```dart
// ---- Tab 3: Wallet ----
StatefulShellBranch(
  routes: [
    GoRoute(
      path: '/wallet',
      name: 'wallet',
      builder: (context, state) => const WalletScreen(),  // Now the portfolio list
      routes: [
        // Wallet detail
        GoRoute(
          path: ':subAccountId',
          name: 'walletDetail',
          builder: (context, state) {
            final subAccountId = state.pathParameters['subAccountId'] ?? '';
            return WalletDetailScreen(subAccountId: subAccountId);
          },
          routes: [
            // Wallet-scoped transaction history
            GoRoute(
              path: 'history',
              name: 'walletHistory',
              builder: (context, state) {
                final subAccountId = state.pathParameters['subAccountId'] ?? '';
                return TransactionHistoryScreen(subAccountId: subAccountId);
              },
            ),
            // Send flow
            GoRoute(
              path: 'send',
              name: 'walletSend',
              builder: (context, state) {
                final subAccountId = state.pathParameters['subAccountId'] ?? '';
                return WalletSendScreen(subAccountId: subAccountId);
              },
              routes: [
                GoRoute(
                  path: ':contactId',
                  name: 'walletSendAmount',
                  builder: (context, state) {
                    final subAccountId = state.pathParameters['subAccountId'] ?? '';
                    final contactId = state.pathParameters['contactId'] ?? '';
                    return WalletSendAmountScreen(
                      subAccountId: subAccountId,
                      contactId: contactId,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'success',
                      name: 'walletSendSuccess',
                      builder: (context, state) => const WalletSendSuccessScreen(),
                    ),
                    GoRoute(
                      path: 'failure',
                      name: 'walletSendFailure',
                      builder: (context, state) => const WalletSendFailureScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // All-wallet transaction history
        GoRoute(
          path: 'transactions',
          name: 'transactions',
          builder: (context, state) => const TransactionHistoryScreen(),
        ),
        // Cashout (default wallet only)
        GoRoute(
          path: 'cashout',
          name: 'cashout',
          builder: (context, state) => const CashoutScreen(),
          routes: [
            GoRoute(
              path: 'success',
              name: 'walletWithdrawSuccess',
              builder: (context, state) => const WalletWithdrawSuccessScreen(),
            ),
            GoRoute(
              path: 'failure',
              name: 'walletWithdrawFailure',
              builder: (context, state) => const WalletWithdrawFailureScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
),
```

**Note:** Remove the legacy `/wallet/withdraw` and `/wallet/actions` routes. The `/wallet/cashout` route stays.

### 5.2 Update Navigation References

Search the codebase for any `context.go('/wallet')` or `context.push('/wallet/...')` calls and update as needed:

- `home_screen.dart` line 232: `context.go('/earn')` — no change needed
- `wallet_screen.dart`: internal links to `/wallet/cashout` and `/wallet/transactions` — no change needed
- Any references to `/wallet/send` → `/wallet/{defaultSubAccountId}/send`
- Any references to `/wallet/withdraw` → `/wallet/cashout`

---

## Phase 6: Cloud Function — P2P Transfer

### 6.1 `sendP2PTransfer` Cloud Function

**File:** `functions/src/wallet.ts`

Wraps the existing `processP2PTransfer()` from `ledger/index.ts`:

```typescript
export const sendP2PTransfer = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new HttpsError('unauthenticated', 'Not authenticated');

  const { recipientUserId, amount, subAccountId, note } = data;
  const senderUserId = context.auth.uid;

  // Validate amount
  if (!amount || amount <= 0) {
    throw new HttpsError('invalid-argument', 'Invalid amount');
  }

  // Validate daily send cap
  // (check against AppConstants.chatSendDailyCapTokens = 50000)

  // Get sender's sub-account (validate balance)
  // Get/create recipient's default sub-account

  // Process P2P transfer through ledger
  const result = await processP2PTransfer(
    senderUserId,
    recipientUserId,
    amount,
    subAccountId,                     // Sender's sub-account
    recipientDefaultSubAccountId,     // Recipient's default sub-account
    note || 'P2P Transfer',
  );

  return {
    success: true,
    journalId: result.journalId,
    amount: amount,
    recipientName: recipientProfile.displayName,
  };
});
```

### 6.2 Export in `index.ts`

```typescript
export { sendP2PTransfer } from './wallet';
```

---

## Phase 7: Firestore Indexes

### 7.1 Required Indexes

**File:** `firestore.indexes.json`

Add composite indexes for sub-account queries:

```json
{
  "collectionGroup": "subAccounts",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "isActive", "order": "ASCENDING" },
    { "fieldPath": "isDefault", "order": "DESCENDING" }
  ]
}
```

And for journal filtering by sub-account:

```json
{
  "collectionGroup": "ledgerJournals",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "status", "order": "ASCENDING" },
    { "fieldPath": "metadata.subAccountId", "order": "ASCENDING" },
    { "fieldPath": "postedAt", "order": "DESCENDING" }
  ]
}
```

---

## Implementation Order

The work should proceed in this order to maintain a working app at each step:

### Step 1: Backend (no UI changes)
1. Add `getSubAccounts` callable to `wallet.ts`
2. Add `transferBetweenWallets` callable to `wallet.ts`
3. Add `sendP2PTransfer` callable to `wallet.ts`
4. Update Firestore rules for sub-accounts
5. Export new functions in `index.ts`
6. Deploy Cloud Functions + rules
7. **Verify**: call `getSubAccounts` from Firebase console — should return default sub-account

### Step 2: Flutter Data Layer (no UI changes)
1. Extend `WalletRemoteDataSource` with sub-account methods
2. Extend `WalletRepository` interface
3. Extend `WalletRepositoryImpl`
4. Run `dart run build_runner build --delete-conflicting-outputs`
5. **Verify**: unit test that datasource returns sub-accounts

### Step 3: Flutter State Layer (no UI changes)
1. Extend `WalletState` with sub-account fields
2. Extend `WalletEvent` with sub-account events
3. Extend `WalletBloc` with sub-account handlers
4. Run `dart run build_runner build --delete-conflicting-outputs`
5. **Verify**: bloc loads sub-accounts on `loadLedger`

### Step 4: Flutter UI — Wallet List (replaces current wallet tab)
1. Rewrite `wallet_screen.dart` as portfolio list
2. **Verify**: wallet tab shows sub-account cards with correct balances

### Step 5: Flutter UI — Wallet Detail
1. Create `wallet_detail_screen.dart`
2. Update `app_router.dart` with new routes
3. **Verify**: tapping a wallet card opens detail with correct info

### Step 6: Flutter UI — Transaction History Enhancement
1. Add `subAccountId` parameter to `TransactionHistoryScreen`
2. Add wallet filter in filter bar
3. **Verify**: history filters by wallet correctly

### Step 7: Flutter UI — Send Flow
1. Implement `WalletSendScreen` (contact picker)
2. Implement `WalletSendAmountScreen`
3. Implement success/failure screens
4. **Verify**: full send flow works end-to-end

### Step 8: Flutter UI — Polish
1. Add wallet-to-wallet transfer UI on detail screen
2. Update any remaining navigation references
3. Remove unused placeholder screens and routes
4. Test all flows on device

---

## Files Modified/Created Summary

### Modified Files (existing)
| File | Change |
|------|--------|
| `functions/src/wallet.ts` | Add 3 new callables |
| `functions/src/index.ts` | Export new callables |
| `firestore.rules` | Sub-account + accountType read rules |
| `firestore.indexes.json` | Sub-account composite indexes |
| `lib/data/datasources/remote/wallet_remote_datasource.dart` | Sub-account methods |
| `lib/domain/repositories/wallet_repository.dart` | Sub-account interface methods |
| `lib/data/repositories/wallet_repository_impl.dart` | Sub-account implementations |
| `lib/presentation/blocs/wallet/wallet_state.dart` | Sub-account fields + computed props |
| `lib/presentation/blocs/wallet/wallet_event.dart` | Sub-account events |
| `lib/presentation/blocs/wallet/wallet_bloc.dart` | Sub-account handlers |
| `lib/presentation/screens/wallet/wallet_screen.dart` | Rewrite as portfolio list |
| `lib/presentation/screens/wallet/transaction_history_screen.dart` | Add subAccountId filter |
| `lib/presentation/screens/wallet/cashout_screen.dart` | Pass subAccountId to backend |
| `lib/presentation/router/app_router.dart` | New wallet routes |

### New Files
| File | Purpose |
|------|---------|
| `lib/presentation/screens/wallet/wallet_detail_screen.dart` | Single wallet detail view |
| `lib/presentation/screens/wallet/wallet_send_amount_screen.dart` | P2P send amount entry |

### Rewritten Files (existing stubs → full implementation)
| File | Purpose |
|------|---------|
| `lib/presentation/screens/wallet/wallet_send_screen.dart` | Contact picker (was placeholder) |
| `lib/presentation/screens/wallet/wallet_send_success_screen.dart` | Send success (was placeholder) |
| `lib/presentation/screens/wallet/wallet_send_failure_screen.dart` | Send failure (was placeholder) |
| `lib/presentation/screens/wallet/wallet_withdraw_success_screen.dart` | Withdraw success (was placeholder) |
| `lib/presentation/screens/wallet/wallet_withdraw_failure_screen.dart` | Withdraw failure (was placeholder) |

### Removed Files
| File | Reason |
|------|--------|
| `lib/presentation/screens/wallet/wallet_action_selection_screen.dart` | Replaced by wallet detail screen |

### Generated Files (auto-regenerated)
| File |
|------|
| `lib/presentation/blocs/wallet/wallet_bloc.freezed.dart` |
| `lib/data/models/sub_account_model.freezed.dart` |
| `lib/data/models/sub_account_model.g.dart` |

---

## Design Decisions & Rationale

### Why Sub-Accounts instead of multiple LedgerAccounts per user?

The double-entry ledger requires that `LedgerAccount` IDs are unique system-wide and participate in journal entries. Having one `LedgerAccount` per user (`user:{userId}`) maintains the invariant that all tokens in the system are accounted for. Sub-accounts subdivide the user's balance for UI purposes without complicating the bookkeeping.

### Why Cloud Function callable for `getSubAccounts` instead of direct Firestore read?

The `getOrCreateDefaultSubAccount()` function in `ledger/subAccounts.ts` handles the case where a user has no sub-accounts yet (creates the default one atomically). A direct Firestore read would return an empty list for new users, requiring additional client logic.

### Why not reuse the Chat Send flow for wallet P2P?

The Chat Send flow (`/chat/send-wallet`, `/chat/send-amount`) is tied to chat threads and message context. The Wallet Send flow is independent of messaging — it's a direct transfer from wallet detail. They share similar UI patterns but different entry points and navigation contexts. Shared contact list widget can be extracted later.

### Why filter journals client-side instead of Firestore query?

Firestore doesn't efficiently support querying nested map fields (`metadata.subAccountId`). The journals are already loaded into bloc state with a limit. Client-side filtering of the loaded journals is simpler and avoids additional indexes. For the wallet-scoped history screen, a dedicated Firestore query with `metadata.subAccountId` as a top-level indexed field could be added later if performance requires it.

### Why keep the existing cashout flow unchanged?

The `cashout_screen.dart` is 786 lines of production-quality code with bank transfer form validation, e-wallet/airtime selection, step-up authentication, and history. Rewriting it would be high-risk with no benefit. It just needs to be gated to only appear for the default (unrestricted) wallet.

---

## Testing Checklist

- [ ] New user with no sub-accounts → `getSubAccounts` creates default, UI shows one wallet
- [ ] User with brand wallets → portfolio shows all wallets with correct balances
- [ ] Tapping wallet card → opens detail with correct data
- [ ] Send flow → contact picker → amount → success for unrestricted wallet
- [ ] Send button disabled/hidden for restricted brand wallets (unless `allowP2pSend`)
- [ ] Withdraw only available on default wallet
- [ ] Withdraw disabled/restricted label on brand wallets
- [ ] Transaction history filtered by wallet shows only relevant transactions
- [ ] Transaction history "All Wallets" shows everything
- [ ] Wallet-to-wallet transfer succeeds and balances update
- [ ] Pull-to-refresh on portfolio reloads sub-accounts
- [ ] Real-time updates via Firestore snapshots
- [ ] Cashout flow works unchanged from default wallet
- [ ] Portfolio total equals sum of all sub-account balances
- [ ] App gracefully handles empty/loading/error states
