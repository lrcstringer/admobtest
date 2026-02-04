# Ledger System Refactor - Complete Plan

## Core Principle: ONE System - The Ledger

There is **ONLY** the Trust Ledger system. The word "wallet" is **UI terminology only** - it never appears in backend code or data structures.

| Term | Meaning |
|------|---------|
| **Ledger Account** | A user's account in the ledger system |
| **Sub-Account** | A subdivision within a ledger account (shown as "wallets" in UI) |
| **Account Type** | Rules defining what a sub-account can do (restrictions) |
| **Journal** | An immutable record of a token movement |

### System Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                       TRUST LEDGER SYSTEM                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  SYSTEM ACCOUNTS (internal, managed by Cloud Functions)              │
│  ├── system:treasury        Source of all tokens                     │
│  ├── system:referrals       Referral rewards pool                    │
│  ├── system:operations      Platform operations                      │
│  ├── system:fees            Accumulated fees                         │
│  ├── pot:daily              Daily pot balance                        │
│  ├── pot:weekly             Weekly pot balance                       │
│  ├── cashout:pending        Pending cashout holding                  │
│  └── supplier:{id}          Service provider accounts                │
│                                                                      │
│  USER ACCOUNTS                                                       │
│  └── ledgerAccounts/{userId}                                         │
│       ├── totalBalance: sum of all sub-accounts                      │
│       └── subAccounts/{subAccountId}                                 │
│            ├── default (unrestricted)    → UI: "iMaliChat Wallet"    │
│            ├── shoprite (restricted)     → UI: "Shoprite Rewards"    │
│            └── vodacom (unrestricted)    → UI: "Vodacom Wallet"      │
│                                                                      │
│  SUPPORTING COLLECTIONS                                              │
│  ├── ledgerJournals/{id}         Immutable transaction records       │
│  ├── accountTypes/{id}           Sub-account restriction rules       │
│  ├── userEngagementStats/{id}    Streak and lifetime metrics         │
│  └── users/{id}/dailyScores/{date}  Per-user daily scoring          │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Complete Firestore Schema

### User Ledger Account

```
ledgerAccounts/{userId}
├── userId: string
├── totalBalance: int                      # Sum of all sub-accounts
├── createdAt: timestamp
├── updatedAt: timestamp
│
└── subAccounts/{subAccountId}             # Subcollection
    ├── id: string
    ├── accountTypeId: string | null       # null = default unrestricted
    ├── name: string                       # Display name for UI
    ├── balance: int
    ├── lifetimeCredits: int               # Total ever credited
    ├── lifetimeDebits: int                # Total ever debited
    ├── isActive: bool
    ├── createdAt: timestamp
    └── updatedAt: timestamp
```

### Account Types (Restriction Rules)

```
accountTypes/{accountTypeId}
├── id: string
├── advertiserId: string | null            # null = platform default
├── name: string                           # "Shoprite Rewards"
├── description: string
├── iconUrl: string | null
├── isRestricted: bool
├── rules: {
│   ├── allowedOfframps: string[]          # ["*"] or ["shoprite_voucher"]
│   ├── allowP2pSend: bool
│   ├── allowP2pReceive: bool
│   ├── allowCashout: bool
│   └── expiryDays: int | null             # Days until unused balance expires
│ }
├── isActive: bool
└── createdAt: timestamp
```

### Ledger Journals (Transaction Records)

```
ledgerJournals/{journalId}
├── id: string
├── idempotencyKey: string                 # Prevents duplicates
├── type: string                           # "earn" | "pot_win" | "referral" | "p2p" | "purchase" | "cashout"
├── status: string                         # "posted" | "reversed"
├── description: string
├── entries: [                             # Double-entry bookkeeping
│   { accountId, entryType: "debit"|"credit", amount, description }
│ ]
├── subAccountId: string | null            # Which user sub-account affected
├── accountTypeId: string | null           # For audit trail
├── referenceType: string                  # "engagement" | "pot_draw" | "referral" | etc.
├── referenceId: string
├── initiatedBy: string                    # userId or "system"
├── metadata: object
├── createdAt: timestamp
└── reversedAt: timestamp | null
```

### User Engagement Stats (Streak Tracking)

```
userEngagementStats/{userId}
├── userId: string
├── currentStreak: int                     # Consecutive days
├── longestStreak: int
├── streakStartedAt: timestamp
├── lastEarnedDate: string                 # "YYYY-MM-DD" in SAST
├── totalEngagementsCompleted: int
├── totalTokensEarned: int
└── updatedAt: timestamp
```

### User Daily Scores (Scoring History)

```
users/{userId}/dailyScores/{YYYY-MM-DD}
├── date: string                           # "YYYY-MM-DD"
├── engagementsCompleted: int
├── tokensEarned: int
├── streakDay: int                         # What day of streak
├── streakMultiplier: double               # 1.0, 1.2, 1.35, or 1.5
├── assistScore: int                       # From referrals
├── finalScore: int                        # (completions × multiplier) + assistScore
├── displayName: string                    # Cached for leaderboard display
├── username: string | null
├── avatarUrl: string | null
└── updatedAt: timestamp
```

### Pot Leaderboards (Draw-Time Rankings)

```
potLeaderboards/{potId}
├── potId: string
├── potType: string                        # "daily" | "weekly"
├── dateKey: string                        # "YYYY-MM-DD" or "YYYY-Www"
├── totalParticipants: int
├── createdAt: timestamp
│
└── entries/{rank}                         # Subcollection, doc ID = "0001", "0002", etc.
    ├── rank: int
    ├── userId: string
    ├── displayName: string
    ├── username: string | null
    ├── avatarUrl: string | null
    ├── finalScore: int
    ├── engagementsCompleted: int
    └── createdAt: timestamp
```

### Collections to DELETE

```
wallets/{walletId}                         # REMOVE - replaced by ledgerAccounts.subAccounts
leaderboards/{period}/scores/{userId}      # REMOVE - replaced by dailyScores + potLeaderboards
```

---

## Feature Data Flows

### Feature 1: EARN (Engagement Completion)

**File:** `functions/src/engagement.ts` → `processEngagement()`

**Trigger:** User completes an ad/survey engagement

**Current Flow (BROKEN):**
```
User completes engagement
    ↓
processEarningWithSplit()
    ├── Credits ledgerAccounts/{userId}.balance (aggregate)
    ├── Credits pot:daily
    └── Credits pot:weekly
    ↓
updateLeaderboardScores()
    └── Writes to leaderboards/daily/scores/{userId}  ← WRONG LOCATION
    ↓
updateUserStreak()
    └── Writes to wallets/{walletId}                  ← WRONG LOCATION
```

**New Flow (CORRECT):**
```
User completes engagement
    ↓
1. getOrCreateDefaultSubAccount(userId)
    └── Returns subAccountId for default (unrestricted) sub-account
    ↓
2. processEarningWithSplit(userId, tokens, engagementId, subAccountId)
    ├── Debit: system:treasury (100%)
    ├── Credit: user's sub-account (90%)
    ├── Credit: pot:daily (5%)
    └── Credit: pot:weekly (5%)
    ↓
3. updateEngagementStats(userId, tokensEarned)
    └── Writes to userEngagementStats/{userId}
        ├── Updates currentStreak (based on lastEarnedDate)
        ├── Updates longestStreak
        └── Returns streakInfo { currentStreak, multiplier }
    ↓
4. updateDailyScore(userId, tokensEarned, streakInfo)
    └── Writes to users/{userId}/dailyScores/{date}
        ├── Increments engagementsCompleted
        ├── Increments tokensEarned
        ├── Calculates finalScore = (completions × multiplier) + assistScore
        └── Caches displayName, username, avatarUrl
    ↓
5. updateReferrerAssistScore(referrerId, tokensEarned) [if user has referrer]
    └── Updates referrer's users/{referrerId}/dailyScores/{date}
        ├── Increments assistScore by 10% of tokensEarned
        └── Recalculates finalScore
    ↓
6. Store audit fields on engagement document
    ├── streakDayAtCompletion
    └── multiplierApplied
```

**Token Movement:**
```
system:treasury ─────────────────────┐
        │                            │
        ├── 90% ──→ ledgerAccounts/{userId}/subAccounts/{default}
        ├──  5% ──→ pot:daily
        └──  5% ──→ pot:weekly
```

---

### Feature 2: POTS (Daily/Weekly Draws)

**Files:** `functions/src/pots.ts`

#### 2a. Pot Initialization

**Trigger:** Scheduled - Daily at 00:00 SAST, Weekly on Monday 00:00 SAST

**Current Flow:** ✓ Correct (creates pot document)

**No changes needed** for initialization.

---

#### 2b. Pot Draw

**Trigger:** Scheduled - Daily at 20:00 SAST, Weekly on Sunday 20:00 SAST

**Current Flow (BROKEN):**
```
runDailyPotDraw()
    ↓
Query leaderboards/daily/scores
    ORDER BY totalTokensEarned DESC    ← WRONG! Should be finalScore
    ↓
For each winner (top 10):
    processPotWin(winnerId, amount)
        └── Credits ledgerAccounts/{userId}.balance  ← Should be sub-account
```

**New Flow (CORRECT):**
```
runDailyPotDraw()
    ↓
1. buildPotLeaderboard(potId, dateKey)
    └── Query all users/{}/dailyScores/{date} (collection group)
        ORDER BY finalScore DESC, updatedAt ASC
        ↓
        Write to potLeaderboards/{potId}/entries/{rank}
    ↓
2. Get top 10 from potLeaderboards/{potId}/entries
    ORDER BY rank ASC
    LIMIT 10
    ↓
3. Get pot balance from pot:daily ledger account
    ↓
4. For each winner:
    a. getOrCreateDefaultSubAccount(winnerId)
    b. processPotWin(potType, winnerId, amount, subAccountId)
        ├── Debit: pot:daily
        └── Credit: winner's default sub-account
    c. Create potWinners/{id} record
    ↓
5. Mark pot as distributed
```

**Token Movement:**
```
pot:daily ──┬── 30% ──→ ledgerAccounts/{rank1}/subAccounts/{default}
            ├── 20% ──→ ledgerAccounts/{rank2}/subAccounts/{default}
            ├── 15% ──→ ledgerAccounts/{rank3}/subAccounts/{default}
            ├── 10% ──→ ledgerAccounts/{rank4}/subAccounts/{default}
            ├──  8% ──→ ledgerAccounts/{rank5}/subAccounts/{default}
            ├──  6% ──→ ledgerAccounts/{rank6}/subAccounts/{default}
            ├──  5% ──→ ledgerAccounts/{rank7}/subAccounts/{default}
            ├──  3% ──→ ledgerAccounts/{rank8}/subAccounts/{default}
            ├──  2% ──→ ledgerAccounts/{rank9}/subAccounts/{default}
            └──  1% ──→ ledgerAccounts/{rank10}/subAccounts/{default}
```

---

### Feature 3: REFERRALS

**File:** `functions/src/referrals.ts`

#### 3a. Apply Referral Code

**Trigger:** New user applies a referral code

**Current Flow:** ✓ Uses ledger (but needs sub-account update)

**New Flow:**
```
applyReferralCode(refereeUserId, code)
    ↓
1. Validate code exists and not self-referral
    ↓
2. Get referrer userId from referralCodes collection
    ↓
3. getOrCreateDefaultSubAccount(referrerId)
   getOrCreateDefaultSubAccount(refereeId)
    ↓
4. processReferralRewards(referrerId, refereeId, referralId, subAccountIds)
    ├── Debit: system:referrals (REFERRER_REWARD + REFEREE_REWARD)
    ├── Credit: referrer's default sub-account (REFERRER_REWARD = 500)
    └── Credit: referee's default sub-account (REFEREE_REWARD = 100)
    ↓
5. Update referral record with ledgerJournalId
    ↓
6. Update referralStats/{referrerId}
```

**Token Movement:**
```
system:referrals ──┬── 500 ──→ ledgerAccounts/{referrer}/subAccounts/{default}
                   └── 100 ──→ ledgerAccounts/{referee}/subAccounts/{default}
```

#### 3b. Generate Referral Code

**Trigger:** Firestore trigger on user creation

**Current Flow:** ✓ Correct (creates referralCodes document)

**No changes needed.**

---

### Feature 4: CHAT P2P (Token Transfers)

**File:** `functions/src/chat.ts`

#### 4a. Send Tokens

**Trigger:** User sends tokens to another user via chat

**Current Flow (INCOMPLETE):**
```
sendTokens(senderId, recipientId, amount)
    ↓
validateSufficientBalance(user:senderId)  ← Checks aggregate, not sub-account
    ↓
processP2PTransfer()
    └── Debit: user:{senderId}            ← Should be sub-account
        Credit: user:{recipientId}        ← Should be sub-account
```

**New Flow:**
```
sendTokens(senderId, recipientId, amount)
    ↓
1. getDefaultSubAccount(senderId)
    ↓
2. validateSubAccountAllows(subAccount.accountTypeId, "p2p_send")
    └── Only unrestricted accounts can send
    ↓
3. validateSubAccountBalance(senderId, subAccountId, amount)
    ↓
4. getOrCreateDefaultSubAccount(recipientId)
    ↓
5. processP2PTransfer(senderId, senderSubAccountId, recipientId, recipientSubAccountId, amount)
    ├── Debit: sender's sub-account
    └── Credit: recipient's default sub-account
    ↓
6. Create chatMessage with ledgerJournalId
```

**Token Movement:**
```
ledgerAccounts/{sender}/subAccounts/{default}
    │
    └── amount ──→ ledgerAccounts/{recipient}/subAccounts/{default}
```

**Account Type Validation:**
- Sender's sub-account must have `rules.allowP2pSend = true`
- Only default (unrestricted) sub-accounts can send
- Restricted brand sub-accounts CANNOT send P2P

---

#### 4b. Request Tokens

**Trigger:** User requests tokens from another user

**Current Flow:** ✓ Correct (just creates a message, no token movement)

**No changes needed.**

---

#### 4c. Accept Token Request

**Trigger:** User pays a token request

**Current Flow (INCOMPLETE):** Same issues as sendTokens

**New Flow:** Same as sendTokens - validate account type, use sub-accounts

---

### Feature 5: PURCHASES (Airtime, Data, Electricity, Vouchers)

**File:** `functions/src/purchases.ts`

**Trigger:** User purchases a service product

**Current Flow (INCOMPLETE):**
```
processPurchase(userId, productId, recipientNumber)
    ↓
validateSufficientBalance(user:userId)    ← Checks aggregate, not sub-account
    ↓
processPurchaseTransaction()
    └── Debit: user:{userId}              ← Should check account type restrictions!
        Credit: supplier:{providerId}
```

**New Flow:**
```
processPurchase(userId, productId, recipientNumber)
    ↓
1. Get product details (priceTokens, providerId, category)
    ↓
2. getDefaultSubAccount(userId)
    ↓
3. validateSubAccountAllows(subAccount.accountTypeId, product.category)
    └── Check if account type's allowedOfframps includes this category
        e.g., Shoprite sub-account can only purchase "shoprite_voucher"
    ↓
4. validateSubAccountBalance(userId, subAccountId, priceTokens)
    ↓
5. processPurchaseTransaction(userId, subAccountId, providerId, amount)
    ├── Debit: user's sub-account
    └── Credit: supplier:{providerId}
    ↓
6. Call VAS provider API
    ↓
7. On success: Update purchase as completed
   On failure: Reverse journal entry, refund sub-account
```

**Token Movement:**
```
ledgerAccounts/{user}/subAccounts/{subAccountId}
    │
    └── amount ──→ supplier:{providerId}
```

**Account Type Validation Examples:**

| Sub-Account Type | Can Purchase |
|-----------------|--------------|
| Default (unrestricted) | Anything: airtime, data, electricity, vouchers, etc. |
| Shoprite Rewards | Only `shoprite_voucher` |
| Vodacom (unrestricted) | Anything |
| PEP Rewards | Only `pep_voucher` |

---

### Feature 6: CASHOUT (Bank Withdrawal)

**File:** `functions/src/wallet.ts`

#### 6a. Initiate Cashout

**Trigger:** User requests withdrawal to bank account

**Current Flow (INCOMPLETE):**
```
processCashout(userId, amount, bankDetails)
    ↓
validateSufficientBalance(user:userId)    ← Should check sub-account
    ↓
initiateCashout()
    └── Debit: user:{userId}              ← Should check account type allows cashout!
        Credit: cashout:pending
```

**New Flow:**
```
processCashout(userId, amount, bankDetails)
    ↓
1. Validate minimum amount (5000 tokens = R50)
    ↓
2. getDefaultSubAccount(userId)
    ↓
3. validateSubAccountAllows(subAccount.accountTypeId, "cashout")
    └── Only unrestricted accounts can cash out
    ↓
4. validateSubAccountBalance(userId, subAccountId, amount)
    ↓
5. Check KYC tier allows this amount (from user profile)
    ↓
6. initiateCashout(userId, subAccountId, amount, cashoutId)
    ├── Debit: user's sub-account
    └── Credit: cashout:pending
    ↓
7. Create cashouts/{id} record with status: "pending"
```

**Token Movement (Initiate):**
```
ledgerAccounts/{user}/subAccounts/{default}
    │
    └── amount ──→ cashout:pending
```

#### 6b. Complete Cashout

**Trigger:** Admin confirms bank transfer completed

**Flow:**
```
completeCashoutRequest(cashoutId)
    ↓
completeCashout()
    ├── Debit: cashout:pending
    └── Credit: system:treasury (tokens burned)
```

**Token Movement (Complete):**
```
cashout:pending
    │
    └── amount ──→ system:treasury (burned)
```

#### 6c. Fail/Refund Cashout

**Trigger:** Admin marks cashout as failed

**Flow:**
```
failCashoutRequest(cashoutId, reason)
    ↓
failCashout()
    ├── Debit: cashout:pending
    └── Credit: user's sub-account (refund)
```

**Token Movement (Fail):**
```
cashout:pending
    │
    └── amount ──→ ledgerAccounts/{user}/subAccounts/{default} (refund)
```

---

### Feature 7: ACCOUNT CREATION

**File:** `functions/src/triggers.ts` (or user creation flow)

**Trigger:** New user signs up

**Current Flow:** Creates wallet document (WRONG)

**New Flow:**
```
onUserCreated(userId)
    ↓
1. Create ledgerAccounts/{userId}
    ├── userId
    ├── totalBalance: 0
    ├── createdAt
    └── updatedAt
    ↓
2. Create default sub-account
    ledgerAccounts/{userId}/subAccounts/{auto-id}
    ├── accountTypeId: null (unrestricted)
    ├── name: "iMaliChat"
    ├── balance: 0
    ├── lifetimeCredits: 0
    ├── lifetimeDebits: 0
    └── isActive: true
    ↓
3. Create userEngagementStats/{userId}
    ├── currentStreak: 0
    ├── longestStreak: 0
    └── totalEngagementsCompleted: 0
    ↓
4. Generate referral code (existing)
```

---

### Feature 8: ACCOUNT DELETION

**File:** `functions/src/accountDeletion.ts`

**Trigger:** User requests account deletion

**Current Flow:** Deletes wallet document

**New Flow:**
```
deleteAccount(userId)
    ↓
1. Delete all sub-accounts
    ledgerAccounts/{userId}/subAccounts/*
    ↓
2. Delete ledger account
    ledgerAccounts/{userId}
    ↓
3. Delete engagement stats
    userEngagementStats/{userId}
    ↓
4. Delete daily scores
    users/{userId}/dailyScores/*
    ↓
5. Delete other user data (existing)
```

---

### Feature 9: DATA EXPORT (POPIA/GDPR)

**File:** `functions/src/dataExport.ts`

**Trigger:** User requests data export

**Current Flow:** Exports wallet data

**New Flow:**
```
exportUserData(userId)
    ↓
Export:
├── User profile
├── ledgerAccounts/{userId} + all subAccounts/*
├── userEngagementStats/{userId}
├── users/{userId}/dailyScores/*
├── All ledgerJournals where userId is involved
├── Referral data
├── Cashout history
├── Purchase history
└── Engagement history
```

---

### Feature 10: LEADERBOARD (Scoring System)

**File:** `functions/src/leaderboard.ts`

**Trigger:** Called from processEngagement

**Current Flow (COMPLETELY WRONG):**
```
updateLeaderboardScores()
    └── Writes to leaderboards/daily/scores/{userId}

updateUserStreak()
    └── Writes to wallets/{walletId}   ← WRONG!
```

**New Flow:**
The entire file needs to be **rewritten** or **deleted**.

Replace with:
- `updateDailyScore()` → writes to `users/{userId}/dailyScores/{date}`
- `updateReferrerAssistScore()` → updates referrer's daily score
- `buildPotLeaderboard()` → called at draw time, writes to `potLeaderboards`

**DELETE these functions:**
- `updateLeaderboardScores()`
- `updateUserStreak()`
- `syncStreakToLeaderboard()`
- Any function that writes to `wallets` or `leaderboards/{period}/scores`

---

### Feature 11: LEGACY CODE TO DELETE

**File:** `functions/src/wallet.ts`

**DELETE:**
```typescript
// DELETE: Duplicate of engagement flow, writes to old wallet
export const processEarning = ...

// DELETE: No longer needed with dailyScores approach
export const resetDailyEarnings = ...
```

---

## Implementation Phases

### Phase 1: Ledger Foundation

**New Files:**
- `functions/src/ledger/subAccounts.ts`

**Modified Files:**
- `functions/src/ledger/index.ts` - Add subAccountId parameter
- `functions/src/ledger/journals.ts` - Add subAccountId to journal entries
- `functions/src/ledger/types.ts` - Add SubAccount types

**Key Functions:**
```typescript
// subAccounts.ts
getOrCreateDefaultSubAccount(userId): Promise<{subAccountId, isNew}>
getOrCreateBrandSubAccount(userId, accountTypeId, name): Promise<{subAccountId, isNew}>
getSubAccountBalance(userId, subAccountId): Promise<number>
getUserTotalBalance(userId): Promise<number>
validateSubAccountAllows(accountTypeId, operation): Promise<{allowed, reason?}>
creditSubAccount(userId, subAccountId, amount, tx?): Promise<void>
debitSubAccount(userId, subAccountId, amount, tx?): Promise<void>
```

---

### Phase 2: Engagement Stats & Scoring

**New Files:**
- `functions/src/engagementStats.ts`
- `functions/src/dailyScores.ts`

**Key Functions:**
```typescript
// engagementStats.ts
updateEngagementStats(userId, tokensEarned): Promise<StreakInfo>
getStreakInfo(userId): Promise<StreakInfo>
getStreakMultiplier(days): number

// dailyScores.ts
updateDailyScore(userId, tokensEarned, streakInfo, profile): Promise<void>
updateReferrerAssistScore(referrerId, refereeTokensEarned): Promise<void>
buildPotLeaderboard(potId, dateKey): Promise<void>
```

---

### Phase 3: Update All Token Flows

| Feature | File | Changes |
|---------|------|---------|
| Earn | `engagement.ts` | Use sub-account, call new stats/score functions |
| Pots | `pots.ts` | Fix ranking, use sub-accounts for winners |
| Referrals | `referrals.ts` | Use sub-accounts |
| Chat P2P | `chat.ts` | Add account type validation, use sub-accounts |
| Purchases | `purchases.ts` | Add account type validation, use sub-accounts |
| Cashout | `wallet.ts` | Add account type validation, use sub-accounts |

---

### Phase 4: Account Lifecycle

| Feature | File | Changes |
|---------|------|---------|
| User Creation | `triggers.ts` | Create ledger account + default sub-account |
| User Deletion | `accountDeletion.ts` | Delete sub-accounts, engagement stats, daily scores |
| Data Export | `dataExport.ts` | Include sub-accounts, engagement stats, daily scores |

---

### Phase 5: Cleanup

**Delete from backend:**
- `wallet.ts:processEarning()` function
- `wallet.ts:resetDailyEarnings()` scheduled function
- `leaderboard.ts` - entire file or rewrite completely
- All writes to `wallets` collection
- All writes to `leaderboards/{period}/scores`

**Delete from Firestore (after migration stable):**
- `wallets` collection
- `leaderboards` collection

---

### Phase 6: Flutter Frontend

**New entities:**
- `SubAccount` (replaces Wallet)
- `UserEngagementStats`
- `DailyScore`
- `AccountType`

**Updated entities:**
- `LedgerAccount` - add subAccounts list

**Repository changes:**
```dart
// Remove
Future<Either<Failure, Wallet>> getMainWallet();
Stream<Either<Failure, Wallet>> watchWallet(String walletId);

// Add
Stream<Either<Failure, List<SubAccount>>> watchSubAccounts();
Stream<Either<Failure, UserEngagementStats>> watchEngagementStats();
Future<Either<Failure, DailyScore?>> getTodayScore();
```

**BLoC changes:**
- WalletBloc → reads from sub-accounts + engagement stats
- Remove all references to Wallet entity

**UI changes:**
- HomeScreen: Read balance from default sub-account, streak from engagement stats
- Wallet display: Show sub-accounts list (displayed as "wallets" to user)

---

## Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Ledger accounts - user can read their own
    match /ledgerAccounts/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if false; // Server-only

      match /subAccounts/{subAccountId} {
        allow read: if request.auth != null && request.auth.uid == userId;
        allow write: if false; // Server-only
      }
    }

    // Engagement stats - user can read their own
    match /userEngagementStats/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if false; // Server-only
    }

    // Daily scores - user can read their own
    match /users/{userId}/dailyScores/{date} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if false; // Server-only
    }

    // Pot leaderboards - authenticated users can read (for display)
    match /potLeaderboards/{potId} {
      allow read: if request.auth != null;
      allow write: if false;

      match /entries/{rank} {
        allow read: if request.auth != null;
        allow write: if false;
      }
    }

    // Account types - authenticated users can read
    match /accountTypes/{typeId} {
      allow read: if request.auth != null;
      allow write: if false; // Admin-only via console
    }

    // Ledger journals - user can read journals that involve them
    match /ledgerJournals/{journalId} {
      allow read: if request.auth != null &&
        resource.data.entries.hasAny([
          {'accountId': 'user:' + request.auth.uid}
        ]);
      allow write: if false; // Server-only
    }
  }
}
```

---

## Firestore Indexes

```json
{
  "indexes": [
    {
      "collectionGroup": "dailyScores",
      "queryScope": "COLLECTION_GROUP",
      "fields": [
        { "fieldPath": "date", "order": "ASCENDING" },
        { "fieldPath": "finalScore", "order": "DESCENDING" },
        { "fieldPath": "updatedAt", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "subAccounts",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "accountTypeId", "order": "ASCENDING" },
        { "fieldPath": "isActive", "order": "ASCENDING" }
      ]
    }
  ]
}
```

---

## Testing Checklist

### Token Flow Tests

| Test | Expected |
|------|----------|
| User completes engagement | Tokens credited to default sub-account |
| Engagement with referrer | Referrer's assistScore increases |
| Daily pot draw | Winners ranked by finalScore, credited to default sub-account |
| Apply referral code | Both users credited to default sub-accounts |
| P2P send from default | Transfer succeeds |
| P2P send from restricted | Transfer blocked with error message |
| Purchase from default | Purchase succeeds |
| Purchase from restricted (wrong category) | Purchase blocked |
| Purchase from restricted (correct category) | Purchase succeeds |
| Cashout from default | Cashout initiated |
| Cashout from restricted | Cashout blocked |

### Streak Tests

| Test | Expected |
|------|----------|
| First engagement ever | Streak = 1, multiplier = 1.0 |
| Second engagement same day | Streak unchanged |
| Engagement next day | Streak = 2, multiplier = 1.0 |
| Engagement day 3 | Streak = 3, multiplier = 1.2 |
| Engagement day 7 | Streak = 7, multiplier = 1.35 |
| Engagement day 10 | Streak = 10, multiplier = 1.5 |
| Missed a day | Streak resets to 1 |

### Scoring Tests

| Test | Expected |
|------|----------|
| finalScore calculation | (completions × multiplier) + assistScore |
| Pot ranking | Ordered by finalScore DESC, then updatedAt ASC |

---

## Rollback Plan

1. Firestore rules keep old collections readable during transition
2. Cloud Functions can be reverted to previous version
3. No destructive migrations - old data preserved until confirmed stable
4. Flutter app can fall back to old data sources if needed

---

## Summary: Files to Modify

| File | Action |
|------|--------|
| `functions/src/ledger/subAccounts.ts` | **CREATE** |
| `functions/src/engagementStats.ts` | **CREATE** |
| `functions/src/dailyScores.ts` | **CREATE** |
| `functions/src/ledger/index.ts` | MODIFY - add subAccountId support |
| `functions/src/ledger/journals.ts` | MODIFY - add subAccountId field |
| `functions/src/engagement.ts` | MODIFY - use new systems |
| `functions/src/pots.ts` | MODIFY - fix ranking, use sub-accounts |
| `functions/src/referrals.ts` | MODIFY - use sub-accounts |
| `functions/src/chat.ts` | MODIFY - add validation, use sub-accounts |
| `functions/src/purchases.ts` | MODIFY - add validation, use sub-accounts |
| `functions/src/wallet.ts` | MODIFY - remove legacy, update cashout |
| `functions/src/triggers.ts` | MODIFY - create ledger account on user creation |
| `functions/src/accountDeletion.ts` | MODIFY - delete new collections |
| `functions/src/dataExport.ts` | MODIFY - export new collections |
| `functions/src/leaderboard.ts` | **DELETE or REWRITE** |
| `lib/domain/entities/sub_account.dart` | **CREATE** |
| `lib/domain/entities/user_engagement_stats.dart` | **CREATE** |
| `lib/domain/entities/daily_score.dart` | **CREATE** |
| `lib/domain/entities/wallet.dart` | **DELETE** |
| `lib/data/models/wallet_model.dart` | **DELETE** |
