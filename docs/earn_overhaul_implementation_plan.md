# Earn Feature Overhaul — Implementation Plan

## 1. Overview

### Goal
Transform the Earn feature from a basic list into a chat-inbox UI backed by a
client-funded token economy.  The TSX mockups (earn-inbox, earn-thread,
earn-detail, earn-message-card, reward-animation) serve as the visual reference.

### Three-Level Data Hierarchy
```
Client (Brand / Business)
 └── Earn Thread (Campaign — appears as inbox row)
      └── Earn Opportunity (Task — appears as message card)
           └── Engagement (User's lifecycle for one opportunity)
```

### Token Flow (Revised)
```
Client Sub-Account (source, pre-funded budget)
  │ debit 100 tokens
  ├── 90 → User sub-account (default OR brand-restricted)
  ├──  5 → Daily Pot
  └──  5 → Weekly Pot
```

Current system debits a `treasury` account.  After this overhaul, client-funded
threads debit the client's sub-account instead.  iMaliChat's own threads
(e.g. "iMaliChat Daily") are a client like any other and fund from their own
sub-account.

---

## 2. Complete Data Model

### 2.1 Client (NEW)

**Firestore:** `clients/{clientId}`

| Field | Type | Description |
|---|---|---|
| `id` | string | Auto-generated |
| `name` | string | Internal name |
| `displayName` | string | User-facing name |
| `avatarImage` | string? | Logo URL |
| `avatarColor` | string? | Fallback hex e.g. "#0066CC" |
| `isActive` | bool | Can create new threads |
| `ledgerAccountId` | string | Client's master ledger account ID (`client:{clientId}`) |
| `brandAccountTypeId` | string | Account type ID for user brand wallets |
| `budgetWarningThreshold` | number | Default 0.20 (20%) |
| `contactEmail` | string? | Admin contact |
| `createdAt` | Timestamp | |
| `updatedAt` | Timestamp | |

### 2.2 Client Sub-Account (NEW)

**Firestore:** `clients/{clientId}/subAccounts/{subAccountId}`

| Field | Type | Description |
|---|---|---|
| `id` | string | Auto-generated |
| `name` | string | "Nike Q1 2026 Budget", "Video Ads Fund" |
| `balance` | number | Current token balance (decrements on each engagement) |
| `initialBudget` | number | Starting balance for threshold calculation |
| `isActive` | bool | |
| `warningNotifiedAt` | Timestamp? | When 20% warning was last sent (prevent spam) |
| `depletedAt` | Timestamp? | When balance hit 0 |
| `createdAt` | Timestamp | |
| `updatedAt` | Timestamp | |

### 2.3 Earn Thread (UPDATED)

**Firestore:** `earnThreads/{threadId}`

| Field | Type | Change | Description |
|---|---|---|---|
| `id` | string | existing | |
| `clientId` | string | **NEW** | References `clients/{clientId}` |
| `clientName` | string | **RENAMED** from `brandName` | Denormalized |
| `clientAvatarImage` | string? | **RENAMED** from `avatarImage` | Denormalized |
| `clientAvatarColor` | string? | **RENAMED** from `avatarColor` | Denormalized |
| `title` | string | **NEW** | Thread-specific title e.g. "iMaliChat Daily" |
| `description` | string? | **NEW** | Optional subtitle |
| `isActive` | bool | existing | Manual toggle |
| `isFeatured` | bool | **NEW** | Promoted placement |
| `isPinned` | bool | existing | Sticky at top |
| `activeFrom` | Timestamp? | **NEW** | null = immediately |
| `activeTo` | Timestamp? | **NEW** | null = indefinite |
| `tokenSourceSubAccountId` | string | **NEW** | Client sub-account that funds rewards |
| `tokenDestAccountTypeId` | string? | **NEW** | User sub-account type for deposits (null = default wallet) |
| `availableOpportunities` | number | existing | |
| `completedOpportunities` | number | existing | |
| `createdAt` | Timestamp | existing | |
| `lastActivityAt` | Timestamp? | existing | Inbox sort key |
| `targeting` | TargetingCriteria? | **NEW** | Audience targeting rules (null = all users) |
| `completedUniqueUsers` | number | **NEW** | Counter for maxAudience enforcement |
| ~~`brandId`~~ | ~~string~~ | **REMOVED** | Replaced by `clientId` |

### 2.4 Earn Opportunity (UPDATED)

**Firestore:** `earnOpportunities/{opportunityId}`

| Field | Type | Change | Description |
|---|---|---|---|
| `id` | string | existing | |
| `threadId` | string | existing | |
| `title` | string | existing | |
| `description` | string? | existing | |
| `earningType` | string | **NEW** | "survey" \| "video" \| "trivia" \| "rating" \| "poll" |
| `tokenReward` | number | existing | |
| `mediaType` | string | existing | "video" \| "image" \| "text" |
| `mediaUrl` | string | existing | |
| `questions` | array | existing | |
| `durationSeconds` | number | existing | |
| `expiresAt` | Timestamp? | existing | |
| `isActive` | bool | existing | |
| `brandName` | string? | existing | Denormalized |
| `brandAvatarColor` | string? | existing | Denormalized |
| `campaignId` | string? | existing | |
| `targeting` | TargetingCriteria? | **NEW** | Optional override; AND-intersected with thread targeting |
| `createdAt` | Timestamp | existing | |

### 2.5 Engagement (UPDATED)

**Firestore:** `engagements/{engagementId}`

| Field | Type | Change | Description |
|---|---|---|---|
| `id` | string | existing | |
| `userId` | string | existing | |
| `earnOpportunityId` | string | existing | |
| `oddienceCampaignId` | string | existing | Legacy field |
| `threadId` | string | **NEW** | Denormalized from opportunity for targeting queries |
| `clientId` | string | **NEW** | Denormalized from thread for brand interaction tracking |
| `status` | string | existing | |
| `startedAt` | Timestamp | existing | |
| `completedAt` | Timestamp? | existing | |
| `watchDurationSeconds` | number | existing | |
| `requiredDurationSeconds` | number | existing | |
| `answers` | array | existing | |
| `evidence` | map? | existing | |
| `tokensEarned` | number? | existing | |
| `failureReason` | string? | existing | |
| `attemptNumber` | number | existing | |
| `streakDayAtCompletion` | number? | existing | |
| `multiplierApplied` | number? | existing | |
| `createdAt` | Timestamp | existing | |
| `updatedAt` | Timestamp? | existing | |

New fields `threadId` and `clientId` are denormalized at engagement creation
time.  `clientId` enables efficient querying for the `previousBrandInteraction`
targeting criterion without needing to join through opportunity → thread.

### 2.6 TargetingCriteria (NEW)

**Embedded on:** `EarnThread.targeting` and `EarnOpportunity.targeting`

| Field | Type | Description |
|---|---|---|
| `genders` | string[]? | `["male", "female", "non-binary", "prefer_not_to_say"]`. null = all |
| `ageMin` | number? | Minimum age (inclusive). null = no minimum |
| `ageMax` | number? | Maximum age (inclusive). null = no maximum |
| `provinces` | string[]? | SA provinces e.g. `["gauteng", "western_cape"]`. null = all |
| `cities` | string[]? | Cities e.g. `["johannesburg", "cape_town"]`. null = all |
| `languages` | string[]? | Language codes e.g. `["en", "zu", "af"]`. null = all |
| `interests` | string[]? | Category tags e.g. `["sports", "fashion", "tech"]`. null = all |
| `devicePlatforms` | string[]? | `["android", "ios"]`. null = all |
| `accountAgeMinDays` | number? | Minimum account age in days. null = no minimum |
| `accountAgeMaxDays` | number? | Maximum account age in days. null = no maximum |
| `engagementLevel` | string[]? | `["new", "active", "dormant"]`. null = all |
| `previousBrandInteraction` | string? | `"include"` (only returning users) or `"exclude"` (only new users). null = no filter |
| `maxAudience` | number? | Maximum unique users who can engage. null = unlimited |

**Semantics:**
- A `null` or missing `targeting` object on a thread/opportunity = show to everyone
- Every non-null field within targeting acts as an AND filter
- Thread targeting applies to ALL opportunities within the thread
- Opportunity-level targeting (if set) acts as an additional AND with thread targeting
  (intersection — opportunity cannot EXPAND thread audience, only narrow it)

**Engagement Level Classification:**
- `"new"`: account created < 7 days ago
- `"active"`: completed ≥ 1 engagement in last 7 days
- `"dormant"`: account > 7 days old AND 0 engagements in last 30 days

**`maxAudience` Tracking:**
- Thread document has `completedUniqueUsers: number` (starts at 0)
- Incremented atomically in `processEngagement` when a user's first completed
  engagement for this thread is recorded
- `getEligibleThreads` excludes threads where `completedUniqueUsers >= maxAudience`

**`previousBrandInteraction` Tracking:**
- User document has `interactedClientIds: string[]` (new field)
- Updated via `FieldValue.arrayUnion([clientId])` in `processEngagement`
- `getEligibleThreads` checks user's `interactedClientIds` against thread's `clientId`

### 2.7 Predefined Constant Lists

Shared between backend (validation) and admin Flutter (dropdowns).
Define in `functions/src/constants/targeting.ts` and mirror in
`lib/domain/constants/targeting_constants.dart`.

**South African Provinces:**
`gauteng`, `western_cape`, `eastern_cape`, `kwazulu_natal`, `free_state`,
`north_west`, `mpumalanga`, `limpopo`, `northern_cape`

**Languages:**
`en` (English), `af` (Afrikaans), `zu` (isiZulu), `xh` (isiXhosa),
`st` (Sesotho), `tn` (Setswana), `nr` (isiNdebele), `nso` (Sepedi),
`ss` (siSwati), `ve` (Tshivenda), `ts` (Xitsonga)

**Interest Categories:**
`sports`, `fashion`, `tech`, `food`, `music`, `gaming`, `fitness`,
`travel`, `beauty`, `finance`, `education`, `entertainment`,
`automotive`, `health`, `shopping`, `parenting`

**Genders:**
`male`, `female`, `non-binary`, `prefer_not_to_say`

**Engagement Levels:**
`new`, `active`, `dormant`

---

## 3. Implementation Phases

### Phase 1 — Extend Client Admin Backend

**Extends existing `functions/src/adminAccounts.ts`** (NOT a new file).

The following functions already exist and are working:
- `adminCreateClient` — creates client profile + ledger account
- `adminListClients` — lists all clients with ledger data
- `adminGetClient` — returns full client details
- `adminUpdateClient` — updates client profile
- `adminUpdateClientStatus` — freeze/unfreeze
- `adminFundClientAccount` — funds master ledger account via journal

**1.1 Extend `adminCreateClient` — Add Earn-Specific Fields:**

Add to the existing function's data parameters and Firestore write:
```typescript
// New fields added to data param:
displayName?: string;       // User-facing name (defaults to companyName)
avatarImage?: string;       // Logo URL
avatarColor?: string;       // Fallback hex e.g. "#0066CC"
brandAccountTypeId?: string; // Account type ID for user brand wallets
budgetWarningThreshold?: number; // Default 0.20

// Added to clients/{clientId} document:
displayName: displayName || companyName,
avatarImage: avatarImage || null,
avatarColor: avatarColor || null,
brandAccountTypeId: brandAccountTypeId || null,
budgetWarningThreshold: budgetWarningThreshold ?? 0.20,
isActive: true,
```

**1.2 New: `adminCreateClientSubAccount`** — creates per-campaign budget:
- Input: `clientId`, `name`, `initialBudget`
- Creates doc in `clients/{clientId}/subAccounts/{subAccountId}`
- Posts journal: Treasury → Client master account (audit trail)
- Returns `{ success, subAccountId }`

**1.3 New: `adminFundClientSubAccount`** — tops up sub-account:
- Input: `clientId`, `subAccountId`, `amount`, `reference`
- Increments `balance` and `initialBudget`
- Clears `depletedAt`, re-activates auto-deactivated threads
- Posts journal for audit trail

**1.4 New: `adminListClientSubAccounts`** — for admin dashboard:
- Input: `clientId`
- Returns all sub-accounts with `remainingPercent` computed

**Firestore Security Rules (add to `firestore.rules`):**
```
match /clients/{clientId} {
  allow read: if false;  // server-only
  allow write: if false;

  match /subAccounts/{subAccountId} {
    allow read: if false;
    allow write: if false;
  }
}
```
Clients are server-only — the Flutter app never reads the clients collection
directly.  Thread documents carry denormalized client display data.

---

### Phase 2 — Update EarnThread & EarnOpportunity (Backend)

**Update `functions/src/earnAdmin.ts`:**

1. **`createEarnThread`** — updated signature:
   - Input: `clientId` (required, replaces `brandId`), `title` (required),
     `description?`, `isFeatured?`, `activeFrom?`, `activeTo?`,
     `tokenSourceSubAccountId` (required), `tokenDestAccountTypeId?`,
     `isPinned?`, `isActive?`, **`targeting?`** (TargetingCriteria object)
   - On create:
     - Fetch client doc to get `displayName`, `avatarImage`, `avatarColor`
     - Denormalize as `clientName`, `clientAvatarImage`, `clientAvatarColor`
     - Validate `tokenSourceSubAccountId` exists and is active on the client
     - If `targeting` provided, validate all fields against allowed constants
     - Set `completedUniqueUsers: 0`
     - Write to `earnThreads/{threadId}`

2. **`createEarnOpportunity`** — add `earningType` + `targeting`:
   - Input: all existing fields + `earningType` (required) + **`targeting?`**
   - Validate `earningType` is one of: survey, video, trivia, rating, poll
   - If `targeting` provided, validate fields
   - Rest of logic unchanged

3. **`deactivateExpiredOpportunities`** (scheduled function) — extend:
   - Also check `earnThreads` where `activeTo < now` and `isActive == true`
   - Deactivate those threads
   - Also check `earnThreads` where `activeFrom > now` — these should not yet
     be active (guard against premature activation)

4. **NEW: `getEligibleThreads`** — Cloud Function replacing direct Firestore reads:
   ```
   Input: none (userId from context.auth.uid)

   Steps:
   1. Get user profile from users/{userId}
      → Extract: gender, dateOfBirth, province, city
   2. Get user document extended fields:
      → languages, interests, interactedClientIds
   3. Get device platform from request context
   4. Calculate account age from user.createdAt
   5. Calculate engagement level:
      - Query engagements where userId == user, status == completed,
        completedAt >= 7 days ago → count
      - If account age < 7 days → "new"
      - If recent count >= 1 → "active"
      - Else if account age > 7 days AND no engagement in 30 days → "dormant"
   6. Get all active earn threads:
      - Query earnThreads where isActive == true
      - Filter out threads where activeFrom > now OR activeTo < now
   7. For EACH thread, apply targeting filter:
      - If targeting is null → INCLUDE
      - Check each non-null targeting field:
        a. genders: user.gender IN targeting.genders
        b. ageMin/ageMax: ageMin <= user.age <= ageMax
        c. provinces: user.province IN targeting.provinces
        d. cities: user.city IN targeting.cities
        e. languages: ANY user.languages IN targeting.languages
        f. interests: ANY user.interests IN targeting.interests
        g. devicePlatforms: user.device IN targeting.devicePlatforms
        h. accountAgeMinDays/Max: check account age
        i. engagementLevel: user.level IN targeting.engagementLevel
        j. previousBrandInteraction:
           - "include" → thread.clientId IN user.interactedClientIds
           - "exclude" → thread.clientId NOT IN user.interactedClientIds
        k. maxAudience: thread.completedUniqueUsers < targeting.maxAudience
      - ALL non-null conditions must be true (AND logic)
   8. Return filtered list of eligible threads
   ```

   **Performance:** Fetches all active threads (typically < 100) and filters
   in memory.  User profile is a single read.  Engagement history query for
   level classification is bounded.  No scalability concern at current scale.

5. **NEW: `getEligibleOpportunities`** — Cloud Function for opportunity listing:
   ```
   Input: threadId

   Steps:
   1. Get user profile (same as above)
   2. Get all active opportunities for threadId
   3. For EACH opportunity:
      - If opportunity.targeting is null → INCLUDE
      - Else apply same targeting logic (AND-intersected with thread targeting)
   4. Get user's existing engagements for this thread
      → Mark completed/in-progress opportunities
   5. Return opportunities with engagement status
   ```

6. **NEW: `functions/src/constants/targeting.ts`** — shared constants:
   - Valid provinces, languages, interests, genders, engagement levels
   - Validation helper: `validateTargetingCriteria(targeting)`
   - Used by createEarnThread, createEarnOpportunity, and getEligibleThreads

---

### Phase 3 — Update processEngagement (Token Flow)

**This is the most critical phase.** Changes to `functions/src/engagement.ts`
and `functions/src/ledger/index.ts`.

#### 3.1 Update `startEngagement` — Denormalization + Budget Pre-Check

**At engagement creation** (when user starts an engagement via `startEngagement`):
- Denormalize `threadId` from the opportunity document onto the engagement
- Denormalize `clientId` from the thread document onto the engagement
- These are written at creation time so they're available for queries later
- **Budget pre-check:** Fetch the thread's `tokenSourceSubAccountId`, read the
  client sub-account balance, and verify `balance >= opportunity.tokenReward`.
  If budget is insufficient → fail early with "This offer is currently unavailable"
  instead of letting the user complete the entire engagement and then fail.
  This is a soft check (the definitive check happens at `processEngagement`).

#### 3.1b Update `processEngagement` — Token Flow

**Before calling `processEarningWithSplit`**, add:

```
1. Fetch the thread document from earnThreads/{threadId}
   a. Fetch client sub-account: clients/{clientId}/subAccounts/{tokenSourceSubAccountId}
   b. Validate sub-account is active and balance >= totalRewardAmount
   c. If balance < totalRewardAmount → FAIL with "Insufficient budget"
   d. Pass clientId + tokenSourceSubAccountId to processEarningWithSplit
3. If thread has tokenDestAccountTypeId:
   a. Find user's sub-account with matching accountTypeId
   b. If not found → auto-create it:
      - name = clientName + " Wallet"
      - accountTypeId = tokenDestAccountTypeId
      - userId = current user
      - balance = 0, isDefault = false, isActive = true
   c. Pass the sub-account ID to processEarningWithSplit
4. If thread has no clientId (legacy) → use existing treasury flow
```

#### 3.2 Update `processEarningWithSplit`

Add optional parameters:
```typescript
export async function processEarningWithSplit(
  userId: string,
  totalAmount: number,
  engagementId: string,
  description: string,
  subAccountId?: string,
  accountTypeId?: string | null,
  metadata?: Record<string, unknown>,
  // NEW:
  clientId?: string,
  clientSubAccountId?: string,
): Promise<PostJournalResult>
```

Within the function:
- If `clientId` and `clientSubAccountId` are provided:
  - **Debit** `clients/{clientId}/subAccounts/{clientSubAccountId}` by
    `totalAmount` (within the Firestore transaction)
  - Use `client:{clientId}` as the debit account in the journal entry
    (instead of `treasury`)
- If not provided → debit `treasury` as before (backward compatible)

#### 3.3 Budget Monitoring

After the debit, still within `processEngagement`:

```
1. Read updated client sub-account balance
2. Calculate: remainingPercent = balance / initialBudget
3. If remainingPercent <= budgetWarningThreshold AND warningNotifiedAt is null
   or > 24 hours ago:
   a. Set warningNotifiedAt = now on client sub-account
   b. Create notification document (for admin dashboard / email trigger)
4. If balance <= 0:
   a. Set depletedAt = now, isActive = false on client sub-account
   b. Query all earnThreads where tokenSourceSubAccountId == this sub-account
      AND isActive == true
   c. Set isActive = false on each (auto-deactivation)
   d. Create notification document for admin
```

#### 3.4 Targeting Tracking Updates

After successful engagement completion, within `processEngagement`:

```
1. Update user's interactedClientIds:
   - users/{userId}.interactedClientIds = FieldValue.arrayUnion([clientId])
   - Enables previousBrandInteraction targeting

2. Update thread's completedUniqueUsers:
   - Check if user has any previous completed engagement for this thread
   - If NOT (first completion): increment earnThreads/{threadId}.completedUniqueUsers
   - Enables maxAudience targeting

3. Both updates are cheap (single field update) and can run outside
   the main Firestore transaction
```

#### 3.5 Auto-Create User Brand Sub-Account

**NOTE:** `getOrCreateBrandSubAccount` is already exported from
`functions/src/ledger/index.ts` (line 40).  Verify its signature matches the
requirements below.  If it does, simply call it from `processEngagement`.
If the existing function only creates at the ledger level (not user-scoped),
add a thin wrapper in `functions/src/wallet.ts`:

```typescript
export async function findOrCreateBrandSubAccount(
  userId: string,
  accountTypeId: string,
  brandName: string,
): Promise<string>  // returns subAccountId
```

Logic:
1. Query `ledgerAccounts/{userId}/subAccounts` where
   `accountTypeId == accountTypeId` and `isActive == true`
2. If found → return existing `id`
3. If not found → create new sub-account:
   - `name`: `${brandName} Wallet`
   - `accountTypeId`: provided value
   - `userId`: provided value
   - `balance`: 0
   - `lifetimeCredits`: 0
   - `lifetimeDebits`: 0
   - `isDefault`: false
   - `isActive`: true
4. Return new `id`

**If `getOrCreateBrandSubAccount` from ledger already covers this, skip
creating a new function and call the existing one directly.**

---

### Phase 4 — Flutter Domain & Data Layer Updates

#### 4.1 New: `TargetingCriteria` Entity

**File:** `lib/domain/entities/targeting_criteria.dart` (NEW)

```dart
@freezed
class TargetingCriteria with _$TargetingCriteria {
  const factory TargetingCriteria({
    List<String>? genders,
    int? ageMin,
    int? ageMax,
    List<String>? provinces,
    List<String>? cities,
    List<String>? languages,
    List<String>? interests,
    List<String>? devicePlatforms,
    int? accountAgeMinDays,
    int? accountAgeMaxDays,
    List<String>? engagementLevel,
    String? previousBrandInteraction,
    int? maxAudience,
  }) = _TargetingCriteria;

  factory TargetingCriteria.fromJson(Map<String, dynamic> json) =>
      _$TargetingCriteriaFromJson(json);
}
```

#### 4.2 New: Targeting Constants

**File:** `lib/domain/constants/targeting_constants.dart` (NEW)

```dart
class TargetingConstants {
  static const provinces = ['gauteng', 'western_cape', ...];
  static const languages = ['en', 'af', 'zu', 'xh', ...];
  static const interests = ['sports', 'fashion', 'tech', ...];
  static const genders = ['male', 'female', 'non-binary', 'prefer_not_to_say'];
  static const engagementLevels = ['new', 'active', 'dormant'];
  static const earningTypes = ['survey', 'video', 'trivia', 'rating', 'poll'];

  // Display labels (for admin UI dropdowns)
  static const provinceLabels = {
    'gauteng': 'Gauteng',
    'western_cape': 'Western Cape',
    // ...
  };
  // ... same pattern for other constants
}
```

#### 4.3 Update `UserProfile` Entity

**File:** `lib/domain/entities/user_profile.dart`

Add missing fields required for targeting:
```dart
List<String>? languages;   // NEW — preferred languages
List<String>? interests;   // NEW — interest categories
```

These fields are already present in the Firestore user document
(added as part of this overhaul) but not yet in the entity.
Also update `isComplete` getter to account for new fields if desired.

**Note:** `gender`, `dateOfBirth`, `province`, `city` already exist
on UserProfile.  `createdAt` exists on User entity (for account age).

#### 4.4 Update `Engagement` Entity

**File:** `lib/domain/entities/engagement.dart`

Add denormalized fields:
```dart
String? threadId;    // NEW — denormalized from opportunity
String? clientId;    // NEW — denormalized from thread
```

#### 4.5 Update `EarnThread` Entity

**File:** `lib/domain/entities/earn_thread.dart`

Replace `brandId`/`brandName` fields with:
```dart
String clientId;
String clientName;          // was brandName
String? clientAvatarImage;  // was avatarImage
String? clientAvatarColor;  // was avatarColor
String title;               // NEW
String? description;        // NEW
bool isFeatured;            // NEW
DateTime? activeFrom;       // NEW
DateTime? activeTo;         // NEW
String? tokenSourceSubAccountId;   // NEW
String? tokenDestAccountTypeId;    // NEW
TargetingCriteria? targeting;      // NEW
int completedUniqueUsers;          // NEW (for maxAudience display in admin)
```

Keep: `isPinned`, `isActive`, `availableOpportunities`,
`completedOpportunities`, `createdAt`, `lastActivityAt`

Update computed properties:
```dart
String get brandInitials  →  clientName initials
bool get isCurrentlyActive → isActive
    && (activeFrom == null || DateTime.now().isAfter(activeFrom!))
    && (activeTo == null || DateTime.now().isBefore(activeTo!))
```

#### 4.6 Update `EarnOpportunity` Entity

**File:** `lib/domain/entities/earn_opportunity.dart`

Add:
```dart
enum EarningType { survey, video, trivia, rating, poll }

EarningType earningType;            // NEW
TargetingCriteria? targeting;       // NEW
```

Keep all existing fields.

#### 4.7 Update Data Models (Freezed)

**`lib/data/models/earn_thread_model.dart`:**
- Update fields to match entity (including `targeting` as nested JSON)
- Update `fromJson` / `toEntity` / `fromEntity` / `toFirestoreJson`

**`lib/data/models/earn_opportunity_model.dart`:**
- Add `earningType` field with string ↔ enum conversion
- Add `targeting` as nested JSON (nullable)

**`lib/data/models/engagement_model.dart`:**
- Add `threadId` and `clientId` fields (nullable for backward compat)

**`lib/data/models/user_model.dart`:**
- Add `languages` (List<String>?) and `interests` (List<String>?) fields
- Add `interactedClientIds` (List<String>?) field

#### 4.8 Update `EarnRepository` Domain Interface

**File:** `lib/domain/repositories/earn_repository.dart`

**Remove:**
- `Stream<Either<Failure, List<EarnThread>>> watchEarnThreads();`
- `Stream<Either<Failure, List<EarnOpportunity>>> watchOpportunities({...});`

**Rename:**
- `getEarnThreads()` → `getEligibleThreads()`
- `getOpportunities({required String threadId, ...})` → `getEligibleOpportunities(String threadId)`

All other methods (`startEngagement`, `submitSurvey`, `getEngagementHistory`, etc.)
remain unchanged — they already use Future-based Cloud Function calls.

#### 4.9 Update `EarnRemoteDataSource` — Switch to Cloud Functions

**File:** `lib/data/datasources/remote/earn_remote_datasource.dart`
**File:** `lib/data/repositories/earn_repository_impl.dart` — update to match new interface

**CRITICAL CHANGE:** Thread and opportunity fetching switches from direct
Firestore reads to Cloud Function calls for server-side targeting.

**Before (current):**
```dart
// Direct Firestore read
Future<List<EarnThread>> getEarnThreads() async {
  final snapshot = await _firestore.collection('earnThreads')
    .where('isActive', isEqualTo: true)
    .orderBy('isPinned', descending: true)
    .orderBy('lastActivityAt', descending: true)
    .get();
  return snapshot.docs.map(...).toList();
}

// Realtime stream
Stream<List<EarnThread>> watchEarnThreads() { ... }
```

**After (new):**
```dart
// Cloud Function call
Future<List<EarnThread>> getEligibleThreads() async {
  final result = await FirebaseFunctions.instance
    .httpsCallable('getEligibleThreads')
    .call<Map<String, dynamic>>({
      'devicePlatform': Platform.isAndroid ? 'android' : 'ios',
    });
  final threads = (result.data['threads'] as List)
    .map((t) => EarnThreadModel.fromJson(t).toEntity())
    .toList();
  return threads;
}

// Cloud Function call (replaces direct Firestore read)
Future<List<EarnOpportunity>> getEligibleOpportunities(String threadId) async {
  final result = await FirebaseFunctions.instance
    .httpsCallable('getEligibleOpportunities')
    .call<Map<String, dynamic>>({'threadId': threadId});
  // Returns opportunities with engagement status
  return ...;
}
```

**Removed methods:**
- `watchEarnThreads()` — no longer needed (real-time not possible with
  server-side filtering; replaced by pull-to-refresh)
- `watchOpportunities()` — same reason

**Retained methods:**
- `submitSurvey()` — unchanged (already calls Cloud Function)
- `startEngagement()` — now also writes `threadId` + `clientId` to engagement
- `getEngagementHistory()` — unchanged (user's own data, direct Firestore OK)

#### 4.10 Run `build_runner`

```
dart run build_runner build --delete-conflicting-outputs
```

---

### Phase 5 — EarnBloc Updates

**File:** `lib/presentation/blocs/earn/`

#### 5.1 Update `EarnState`

Minimal changes — state already tracks `threads`, `selectedThread`,
`opportunities`, `currentEngagement`, `engagementPhase`.

The new entity fields flow through automatically since BLoC uses
`EarnThread` / `EarnOpportunity` entities.

No new events needed — the existing `LoadThreads`, `SelectThread`,
`LoadOpportunities`, `StartEngagement`, `UpdateWatchProgress`,
`SubmitSurvey`, `LoadHistory` cover all UI flows.

#### 5.2 Switch Thread Loading from Stream to Future

**ARCHITECTURAL CHANGE:** The current BLoC subscribes to a Firestore
stream for real-time thread updates (`watchEarnThreads`).  With server-side
targeting via Cloud Function, real-time streaming is no longer possible.

**Remove from `earn_event.dart`:**
- `EarnEvent.watchThreads()` factory — no longer needed
- `EarnEvent.threadsUpdated(List<EarnThread> threads)` — internal stream event

**Remove from `earn_bloc.dart`:**
- `StreamSubscription? _threadsSubscription` field (line 22)
- `_onWatchThreads()` handler — entire method
- `_onThreadsUpdated()` handler — entire method
- Remove stream cleanup from `close()` method

**Update `_onLoadThreads`:**
```dart
// BEFORE: Stream subscription
_threadSubscription = _repository.watchEarnThreads().listen(
  (threads) => emit(state.copyWith(threads: threads)),
);

// AFTER: One-shot load via Cloud Function
final result = await _repository.getEligibleThreads();
result.fold(
  (failure) => emit(state.copyWith(status: EarnStatus.error, ...)),
  (threads) => emit(state.copyWith(threads: threads, status: EarnStatus.loaded)),
);
```

**Update `_onSelectThread` / `_onLoadOpportunities`:**
```dart
// NOTE: Opportunities already use one-shot loading (no stream subscription).
// Only change needed: call the new Cloud Function method name.

// BEFORE: Direct Firestore read
final result = await _repository.getOpportunities(threadId: threadId);

// AFTER: Cloud Function call
final result = await _repository.getEligibleOpportunities(threadId);
result.fold(
  (failure) => ...,
  (opportunities) => emit(state.copyWith(opportunities: opportunities)),
);
```

**Refresh mechanism:** Pull-to-refresh on the earn screens re-dispatches
`LoadThreads` / `LoadOpportunities` which calls the Cloud Function again.

**`totalAvailableOpportunities`:** This field exists in `EarnState` but is
never populated by any handler.  Either:
- Populate it from the sum of `thread.availableOpportunities` when threads load
- Or remove it from state if not needed by any UI widget

#### 5.3 Verify Event Handlers

Confirm that `_onStartEngagement` and `_onSubmitSurvey` don't need
changes — they call repository methods which call Cloud Functions.
The Cloud Function changes (Phase 3) are transparent to the BLoC.

The only BLoC concern: after `submitSurvey` completes, the returned
`subAccountId` might now be a brand sub-account instead of the default.
The UI should display this correctly.  The BLoC already stores the
engagement result with `tokensEarned` and `subAccountId`.

---

### Phase 6 — Flutter UI Rewrite

This phase rewrites all earn screens following the TSX mockup patterns.
All screens use `WaveBackground`, `IMaliAppBar`, and existing theme
constants (`AppColors`, `AppSpacing`).

**IMPORTANT:** The current `earn_screen.dart` uses `Navigator.push()` (Material
routing) for thread navigation instead of GoRouter.  The rewrite MUST use
`context.go()` or `context.push()` for all earn navigation to integrate with
the GoRouter route structure defined in Phase 7.

#### 6.1 Earn Inbox — Rewrite `earn_screen.dart`

**Reference:** `earn-inbox.tsx`

Structure:
```
Scaffold
├── appBar: IMaliAppBar(title: 'Earn')
└── body: WaveBackground
    └── BlocConsumer<EarnBloc, EarnState>
        └── Column
            ├── Header section
            │   ├── Row: "Earn Chats" title + active thread count Badge
            │   ├── Subtitle: "Chat with brands, complete tasks, earn money."
            │   └── "Invite friends & Earn" button → navigate to /home/referrals
            │       (or wherever referral screen is routed)
            └── Thread list (ListView.separated)
                └── ThreadListItem for each thread
                    ├── Avatar (CircleAvatar with clientAvatarImage or initials)
                    │   └── Green dot if isCurrentlyActive
                    ├── Column: clientName (bold), "Tap to view..." subtitle
                    │   └── "Active" / "Featured" badge
                    └── Chevron icon
                    → onTap: context.go('/earn/thread/${thread.id}')
```

Sort order: pinned first, then featured, then by `lastActivityAt` descending.

Includes:
- Pull-to-refresh (dispatches `LoadThreads`)
- Real-time updates via existing `WatchThreads` subscription
- Loading state (spinner)
- Empty state ("No earn opportunities available")
- History icon button in AppBar → shows `EngagementHistorySheet`
  (preserve existing bottom sheet logic — move to separate widget file
  `lib/presentation/widgets/earn/engagement_history_sheet.dart`)

#### 6.2 Earn Thread — Rewrite `earn_detail_screen.dart`

**Reference:** `earn-thread.tsx`

Route: `/earn/thread/:threadId`
Constructor: `EarnThreadScreen({required String threadId})`

Structure:
```
Scaffold
├── appBar: custom header (not IMaliAppBar)
│   ├── Back button → context.pop()
│   ├── Avatar (from thread/client)
│   ├── Column: thread.title, "Active Session" with pulsing green dot
│   └── (no extra actions)
└── body: WaveBackground
    └── BlocBuilder<EarnBloc, EarnState>
        └── ListView
            ├── Date header: "Today, 2/5/2026" (centered, muted)
            ├── System message bubble (centered):
            │   "Welcome back! Here are your daily opportunities to earn."
            └── For each opportunity:
                └── Row
                    ├── Small brand avatar (left)
                    └── EarnMessageCard (flex-1)
```

On `initState`:
- Dispatch `SelectThread(threadId)` (which loads opportunities)

#### 6.3 Earn Message Card — NEW Widget

**File:** `lib/presentation/widgets/earn/earn_message_card.dart`

**Reference:** `earn-message-card.tsx`

Props:
```dart
class EarnMessageCard extends StatelessWidget {
  final EarnOpportunity opportunity;
  final bool isCompleted;
  final VoidCallback onTap;
}
```

Layout:
```
Container (rounded, chat-bubble style with rounded-tl-none)
├── Row: title (bold) + reward badge ("👑 50 Tokens" or "Done" or "Expired")
├── Description text (muted)
├── Row: duration chip ("⏱ 45 sec") + earning type ("• Survey") + expiry ("Expires in 1d")
└── Action button (full-width):
    - Available: "Play Now 50" / "Watch Video 15" (pink gradient)
    - Completed: "Completed" (disabled, dimmed)
    - Expired: "Offer Expired" (disabled, dimmed)
```

Button label format:  The opportunity's `earningType` determines the verb:
- survey → "Start Survey {tokens}"
- video → "Watch Video {tokens}"
- trivia → "Play Now {tokens}"
- rating → "Rate Now {tokens}"
- poll → "Vote Now {tokens}"

onTap → `context.go('/earn/thread/${threadId}/opportunity/${opportunity.id}')`

#### 6.4 Earn Interaction — Rewrite `earn_interaction_screen.dart`

**Reference:** `earn-detail.tsx`

Route: `/earn/thread/:threadId/opportunity/:opportunityId`
Constructor: `EarnInteractionScreen({required String threadId, required String opportunityId})`

This is a **StatefulWidget** with local state managing the 3-step flow.

**Header:**
```
Row
├── Back button
├── Column: brand name (small caps, muted), opportunity title (bold)
└── Reward badge: "👑 Up to {tokens}"
```

**Step 1 — Media View:**
```
Column
├── Media card (Container with border)
│   ├── if text → Text content (large, readable)
│   ├── if image → Image.network with aspect ratio
│   ├── if video → Video placeholder with play button + progress bar
│   └── Footer: countdown "Reviewing... 3s" with progress bar
│       OR "✓ Content Unlocked!" (green, when countdown done)
└── Button: "Continue to Questions" (enabled when unlocked)
    OR "Wait {N}s" (disabled during countdown)
```

On screen open:
- Dispatch `StartEngagement(opportunityId: opportunityId)`
- Start local countdown timer (based on `opportunity.durationSeconds`,
  clamped to 3-10 seconds for UX)
- On countdown complete: dispatch `UpdateWatchProgress` with full duration
- Show reward animation overlay

**Step 2 — Survey:**
```
Column
├── Header: "Question {n} of {total}" + "+{reward} tokens"
├── Question card (Container)
│   ├── Question text (large, bold)
│   └── Options list (tap to select, highlight selected)
└── Button: "Submit Answer" (disabled until selection)
```

On submit:
- Record answer locally
- Show reward animation
- After 1s delay: advance to next question or → Step 3
- On last question: dispatch `SubmitSurvey` with all answers + evidence

**Step 3 — Completion:**
```
Column (centered)
├── Large green checkmark circle (animated scale-in)
├── "Nice Work!" heading
├── "You just earned" subtitle
├── Large token count (gold, animated)
├── "Tokens" label
├── Balance card: "Your new balance: X,XXX Tokens"
├── Button: "Back to Earn Offers" → pop to /earn
└── Text button: "Go Home" → go to /home
```

#### 6.5 Reward Animation — NEW Widget

**File:** `lib/presentation/widgets/earn/reward_animation.dart`

**Reference:** `reward-animation.tsx`

```dart
class RewardAnimation extends StatelessWidget {
  final bool show;
  final VoidCallback? onComplete;
}
```

Overlay widget using `AnimatedOpacity` + `ScaleTransition`:
- Gold circle with crown icon
- Scales from 0 → 1.5 → 1, fades out, moves upward
- Duration: 1.5 seconds
- Uses `IgnorePointer` so taps pass through

#### 6.6 Engagement History Sheet — Extract to Widget

**File:** `lib/presentation/widgets/earn/engagement_history_sheet.dart`

Move the existing `EngagementHistorySheet` from `earn_screen.dart` into
its own widget file.  No logic changes — just extraction for cleanliness.

#### 6.7 Delete `earn_wallet_confirm_screen.dart`

The reward/confirmation is shown inline in the interaction screen (Step 3).
This placeholder screen is no longer needed.

---

### Phase 7 — Routing Updates

**File:** `lib/presentation/router/app_router.dart`

Replace the earn routes section:

```dart
// ---- Tab 1: Earn ----
StatefulShellBranch(
  routes: [
    GoRoute(
      path: '/earn',
      name: 'earn',
      builder: (context, state) => const EarnScreen(),
      routes: [
        // Thread view (opportunities as chat messages)
        GoRoute(
          path: 'thread/:threadId',
          name: 'earnThread',
          builder: (context, state) {
            final threadId = state.pathParameters['threadId'] ?? '';
            return EarnThreadScreen(threadId: threadId);
          },
          routes: [
            // Interaction (media + survey + reward)
            GoRoute(
              path: 'opportunity/:opportunityId',
              name: 'earnInteraction',
              builder: (context, state) {
                final threadId = state.pathParameters['threadId'] ?? '';
                final opportunityId = state.pathParameters['opportunityId'] ?? '';
                return EarnInteractionScreen(
                  threadId: threadId,
                  opportunityId: opportunityId,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
),
```

**Import changes:**
- Remove: `earn_wallet_confirm_screen.dart`
- Rename: `earn_detail_screen.dart` → now contains `EarnThreadScreen`
- Keep: `earn_interaction_screen.dart` → rewritten
- Add: none (new widgets are imported by screens, not router)

---

### Phase 8 — Firestore Rules & Indexes

#### 8.1 Security Rules

Add/update in `firestore.rules`:

```
// Clients — server-only (admin Cloud Functions)
match /clients/{clientId} {
  allow read, write: if false;

  match /subAccounts/{subAccountId} {
    allow read, write: if false;
  }
}

// Earn Threads — server-only reads (served via getEligibleThreads CF)
// This is a CHANGE from previous authenticated read access.
// Threads are now served via Cloud Functions for targeting.
match /earnThreads/{threadId} {
  allow read: if false;   // was: request.auth != null
  allow write: if false;
}

// Earn Opportunities — server-only reads (served via getEligibleOpportunities CF)
match /earnOpportunities/{opportunityId} {
  allow read: if false;   // was: request.auth != null
  allow write: if false;
}
```

Engagements remain authenticated read (user reads own engagements),
server-only write (processed via Cloud Function).

#### 8.2 Composite Indexes

Add to `firestore.indexes.json`:

```json
{
  "collectionGroup": "earnThreads",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "isActive", "order": "ASCENDING" },
    { "fieldPath": "isPinned", "order": "DESCENDING" },
    { "fieldPath": "isFeatured", "order": "DESCENDING" },
    { "fieldPath": "lastActivityAt", "order": "DESCENDING" }
  ]
}
```

```json
{
  "collectionGroup": "earnThreads",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "tokenSourceSubAccountId", "order": "ASCENDING" },
    { "fieldPath": "isActive", "order": "ASCENDING" }
  ]
}
```

```json
{
  "collectionGroup": "earnOpportunities",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "threadId", "order": "ASCENDING" },
    { "fieldPath": "isActive", "order": "ASCENDING" },
    { "fieldPath": "createdAt", "order": "DESCENDING" }
  ]
}
```

**New indexes for engagement queries (needed by Phase 3.4 targeting tracking):**

```json
{
  "collectionGroup": "engagements",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "threadId", "order": "ASCENDING" },
    { "fieldPath": "userId", "order": "ASCENDING" },
    { "fieldPath": "status", "order": "ASCENDING" }
  ]
}
```

This index supports:
- `getEligibleOpportunities`: checking user's existing engagements for a thread
- Phase 3.4: checking if user's first completed engagement for `completedUniqueUsers`

---

### Phase 9 — Data Migration

#### 9.1 Seed iMaliChat Client

Admin Cloud Function or manual Firestore write:

```
clients/imalichat:
  name: "iMaliChat"
  displayName: "iMaliChat"
  avatarImage: <app logo URL>
  avatarColor: "#FF338A"  (primary brand color)
  isActive: true
  ledgerAccountId: "client:imalichat"
  brandAccountTypeId: null  (uses default wallet)
  budgetWarningThreshold: 0.20

clients/imalichat/subAccounts/main:
  name: "iMaliChat Operations Fund"
  balance: 10000000  (seed budget — 100,000 ZAR equivalent)
  initialBudget: 10000000
  isActive: true
```

#### 9.2 Migrate Existing Earn Threads

One-time migration script (Cloud Function or Firestore admin script):

For each document in `earnThreads`:
```
1. Set clientId = "imalichat" (all existing threads are iMaliChat)
2. Set clientName = brandName
3. Set clientAvatarImage = avatarImage
4. Set clientAvatarColor = avatarColor
5. Set title = brandName (or a better title)
6. Set isFeatured = false
7. Set tokenSourceSubAccountId = "main" (iMaliChat's main fund)
8. Set tokenDestAccountTypeId = null (default wallet)
9. Keep all other fields unchanged
```

#### 9.3 Migrate Existing Earn Opportunities

For each document in `earnOpportunities`:
```
1. Set earningType = "survey" (default for existing)
   OR infer from mediaType: if "video" → "video", else → "survey"
```

---

### Phase 10 — Analysis & Testing

1. Run `dart analyze lib` — fix all errors and warnings
2. Run `build_runner` if any Freezed models were changed
3. Verify Cloud Functions compile: `cd functions && npm run build`
4. Deploy Firestore rules: `firebase deploy --only firestore:rules`
5. Deploy Firestore indexes: `firebase deploy --only firestore:indexes`
6. Deploy Cloud Functions: `firebase deploy --only functions`
7. Test full flow:
   a. Admin creates client via `createClient`
   b. Admin creates client sub-account via `createClientSubAccount`
   c. Admin funds sub-account via `fundClientSubAccount`
   d. Admin creates earn thread via `createEarnThread`
   e. Admin creates earn opportunity via `createEarnOpportunity`
   f. User opens Earn tab → sees thread in inbox
   g. User taps thread → sees opportunities as message cards
   h. User taps opportunity → goes through media → survey → reward
   i. User's wallet shows tokens in correct sub-account
   j. Client sub-account balance decremented
   k. Budget warning fires at 20% remaining
   l. Auto-deactivation fires at 0% remaining

---

## 4. Integration Checklist

### Cross-System Integration

| System | Integration Point | Phase |
|---|---|---|
| Trust Ledger | Journal entries use `client:{clientId}` as debit account | Phase 3 |
| Sub-Accounts | Auto-create brand wallet via `findOrCreateBrandSubAccount` | Phase 3 |
| Wallet BLoC | `refreshLedger` already called after engagement completion | Existing |
| Pot System | 5%/5% split unchanged; pot entries still created | Existing |
| Streak System | `updateEngagementStats` unchanged | Existing |
| Leaderboard | Score updates unchanged | Existing |
| Referral Assist | Assist score update unchanged | Existing |
| Play Integrity | Security validation unchanged | Existing |
| Firestore Rules | earnThreads + earnOpportunities → server-only reads | Phase 8 |
| Targeting | getEligibleThreads Cloud Function filters by user profile | Phase 2 |
| User Profile | `languages`, `interests` added to entity + model | Phase 4 |
| Engagement Tracking | `threadId`, `clientId` denormalized on engagement doc | Phase 3 |
| Brand Interaction | `interactedClientIds` tracked on user doc | Phase 3 |
| Max Audience | `completedUniqueUsers` counter on thread doc | Phase 3 |
| Stream→Future | EarnBloc switches from Firestore streams to CF calls | Phase 5 |
| Admin Client Mgmt | Extends existing `adminAccounts.ts` (NOT new file) | Phase 1 |
| Admin Dashboard | `adminGetEarnOverview` with budget alerts | Phase 11 |
| Denormalization | Client field changes cascade to thread documents | Phase 1 |
| Constants Sync | `targeting.ts` (backend) mirrors `targeting_constants.dart` (Flutter) | Phase 2 + 4 |

---

## 5. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Client sub-account race condition (concurrent debits) | Medium | High | All debits within Firestore transactions |
| Budget depletion mid-engagement (user started before budget hit 0) | Low | Medium | Check balance at `processEngagement` time, fail gracefully |
| Video player complexity in interaction screen | Medium | Medium | Start with placeholder (like TSX), use `video_player` package later |
| `getEligibleThreads` CF latency on Earn tab open | Medium | Medium | Show loading state; CF reads user profile + threads (~2 reads); typically < 500ms |
| Incomplete user profiles reduce targeting reach | Medium | Medium | Missing field = excluded from targeted campaigns. Incentivize profile completion |
| `completedUniqueUsers` counter accuracy under concurrency | Low | Low | Use `FieldValue.increment(1)` which is atomic; minor over-count acceptable |
| Loss of real-time thread updates (stream→future) | Medium | Low | Pull-to-refresh is sufficient for earn content that changes infrequently |
| Targeting constants drift between backend + Flutter | Low | Medium | Define constants in one source; lint/test to verify sync |
| Cloud Function cold starts on `getEligibleThreads` | Medium | Low | Function is lightweight; cold start adds ~1-2s only on first call |
| `interactedClientIds` growing unbounded on user doc | Low | Low | Even with 100+ clients, array is tiny; no performance concern |

---

## 6. Phase Dependencies (Consumer App)

See Section 11 for the full dependency graph including admin phases.

Phases 1-3: Backend (client admin, earn admin + targeting CFs, engagement).
Phases 4-7: Consumer Flutter (data layer, BLoC, UI, routing).
Phase 8: Firestore rules + indexes (deploy with backend).
Phases 9-10: Migration + final verification.
Phases 11-14: Admin dashboard (parallel with consumer Flutter).

---

## 7. Admin Dashboard — Existing Infrastructure Audit

Before implementing, note what already exists:

### 7.1 Backend (`functions/src/adminAccounts.ts`)

Already implemented and deployed:

| Function | Status | Notes |
|---|---|---|
| `requireAdmin(context)` | Working | Checks `token.admin \|\| token.superAdmin` custom claims |
| `adminCreateClient` | Working | Creates client profile + ledger account. Fields: `clientId`, `companyName`, `contactEmail`, `contactName`, `companyRegistration?`, `industry?`, `billingAddress?`, `vatNumber?` |
| `adminListClients` | Working | Merges ledger accounts + client profiles |
| `adminGetClient` | Working | Returns full client details |
| `adminUpdateClient` | Working | Updates client profile, syncs company name to ledger |
| `adminUpdateClientStatus` | Working | Freeze/unfreeze via ledger + profile |
| `adminFundClientAccount` | Working | Posts journal: Treasury → Client credit |

**Gap:** These functions create a *master ledger account* per client (`client:{clientId}`), but the earn overhaul requires *client sub-accounts* (`clients/{clientId}/subAccounts/`) for per-campaign budget tracking. The existing `adminFundClientAccount` funds the master account via journal; the new system needs to fund individual sub-accounts.

### 7.2 Backend (`functions/src/earnAdmin.ts`)

Already implemented:

| Function | Status | Notes |
|---|---|---|
| `createEarnThread` | Working | Uses old model: `brandId`, `brandName`. Needs update for new client fields |
| `createEarnOpportunity` | Working | Validates thread exists, manages active counts. Needs `earningType` field |
| `syncCampaignsToOpportunities` | Working | Bulk import from legacy campaigns collection |
| `deactivateExpiredOpportunities` | Working | Scheduled daily at 1 AM SAST |
| `getEarnStatistics` | Working | Returns thread/opportunity/engagement counts |

### 7.3 Flutter Admin App

| Component | File | Status |
|---|---|---|
| Entry point | `lib/presentation/admin/main_admin.dart` | Exists |
| App widget | `lib/presentation/admin/admin_app.dart` | Exists |
| Router | `lib/presentation/admin/router/admin_router.dart` | Exists — has TODO for admin role check |
| Shell/Sidebar | `lib/presentation/admin/shell/admin_shell.dart` | Working — sidebar with nav items |
| Login screen | `lib/presentation/admin/screens/admin_login_screen.dart` | UI complete, auth NOT connected |
| Dashboard | `lib/presentation/admin/screens/admin_dashboard_screen.dart` | Placeholder |
| Client management | `lib/presentation/admin/screens/client_management_screen.dart` | UI skeleton with create dialog, NOT wired to backend |
| Other screens | ledger, pots, users, cashouts, suppliers | Placeholders |

---

## 8. Admin Dashboard Implementation Phases

### Phase 11 — Admin Backend: Targeting & Dashboard

Phase 1 already handles extending `adminAccounts.ts` with sub-account
CRUD and earn-specific client fields.  Phase 2 already handles updating
`createEarnThread` and `createEarnOpportunity` with targeting fields.

This phase adds the remaining admin-specific functions.

#### 11.1 New: `adminGetEarnOverview`

**File:** `functions/src/earnAdmin.ts`

Replaces/extends `getEarnStatistics` for the admin dashboard:

```typescript
export const adminGetEarnOverview = functions.https.onCall(
  async (data, context) => {
    requireAppCheck(context, "adminGetEarnOverview");
    await requireAdmin(context);

    // Existing stats
    const activeThreads = await db.collection("earnThreads")
      .where("isActive", "==", true).count().get();
    const activeOpportunities = await db.collection("earnOpportunities")
      .where("isActive", "==", true).count().get();
    const activeClients = await db.collection("clients")
      .where("isActive", "==", true).count().get();

    // Today's engagements
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const todayStart = admin.firestore.Timestamp.fromDate(today);
    const engagementsToday = await db.collection("engagements")
      .where("createdAt", ">=", todayStart).count().get();
    const completedToday = await db.collection("engagements")
      .where("completedAt", ">=", todayStart)
      .where("status", "==", "completed").count().get();

    // Budget alerts (sub-accounts below warning threshold)
    const allSubAccounts = await db.collectionGroup("subAccounts")
      .where("isActive", "==", true).get();
    const budgetAlerts = allSubAccounts.docs
      .filter(doc => {
        const d = doc.data();
        return d.initialBudget > 0 &&
          (d.balance / d.initialBudget) <= (d.budgetWarningThreshold ?? 0.20);
      })
      .map(doc => ({
        ...doc.data(),
        clientId: doc.ref.parent.parent?.id,
      }));

    return {
      activeClients: activeClients.data().count,
      activeThreads: activeThreads.data().count,
      activeOpportunities: activeOpportunities.data().count,
      engagementsToday: engagementsToday.data().count,
      completedToday: completedToday.data().count,
      budgetAlerts,
    };
  }
);
```

#### 11.2 New: `adminListEarnThreads`

**File:** `functions/src/earnAdmin.ts`

Admin-only function to list ALL threads (no targeting filter):
```typescript
export const adminListEarnThreads = functions.https.onCall(
  async (data: { clientId?: string }, context) => {
    requireAppCheck(context, "adminListEarnThreads");
    await requireAdmin(context);

    let query = db.collection("earnThreads").orderBy("createdAt", "desc");
    if (data.clientId) {
      query = query.where("clientId", "==", data.clientId);
    }
    const threads = await query.get();
    return { threads: threads.docs.map(d => ({ id: d.id, ...d.data() })) };
  }
);
```

#### 11.3 New: `adminListEarnOpportunities`

**File:** `functions/src/earnAdmin.ts`

Admin-only function to list ALL opportunities for a thread:
```typescript
export const adminListEarnOpportunities = functions.https.onCall(
  async (data: { threadId: string }, context) => {
    requireAppCheck(context, "adminListEarnOpportunities");
    await requireAdmin(context);

    const opportunities = await db.collection("earnOpportunities")
      .where("threadId", "==", data.threadId)
      .orderBy("createdAt", "desc").get();
    return { opportunities: opportunities.docs.map(d => ({ id: d.id, ...d.data() })) };
  }
);
```

#### 11.4 Export New Functions

**File:** `functions/src/index.ts`

Add exports:
```typescript
export {
  adminCreateClientSubAccount,
  adminFundClientSubAccount,
  adminListClientSubAccounts,
} from "./adminAccounts";

export {
  adminGetEarnOverview,
  adminListEarnThreads,
  adminListEarnOpportunities,
  getEligibleThreads,
  getEligibleOpportunities,
} from "./earnAdmin";
```

---

### Phase 12 — Admin Flutter: Data Layer & BLoC

#### 12.1 Admin Data Source

**File:** `lib/data/datasources/remote/admin_remote_datasource.dart` (NEW)

Provides typed wrappers around Cloud Functions calls:

```dart
abstract class AdminRemoteDataSource {
  // Clients
  Future<List<ClientSummary>> listClients();
  Future<ClientDetail> getClient(String clientId);
  Future<String> createClient(CreateClientRequest request);
  Future<void> updateClient(String clientId, UpdateClientRequest request);
  Future<void> updateClientStatus(String clientId, String action, String reason);

  // Client Sub-Accounts
  Future<List<ClientSubAccount>> listClientSubAccounts(String clientId);
  Future<String> createClientSubAccount(CreateSubAccountRequest request);
  Future<void> fundClientSubAccount(FundSubAccountRequest request);

  // Earn Threads
  Future<String> createEarnThread(CreateThreadRequest request);
  Future<void> updateEarnThread(String threadId, UpdateThreadRequest request);

  // Earn Opportunities
  Future<String> createEarnOpportunity(CreateOpportunityRequest request);
  Future<void> updateEarnOpportunity(String opportunityId, UpdateOpportunityRequest request);

  // Dashboard
  Future<EarnOverview> getEarnOverview();
}
```

Implementation calls `FirebaseFunctions.instance.httpsCallable('functionName')`.

#### 12.2 Admin Repository

**File:** `lib/data/repositories/admin_repository_impl.dart` (NEW)

```dart
abstract class AdminRepository {
  Future<Either<Failure, List<ClientSummary>>> listClients();
  Future<Either<Failure, ClientDetail>> getClient(String clientId);
  Future<Either<Failure, String>> createClient(CreateClientRequest request);
  // ... etc
}
```

Wraps data source calls in try/catch, returns `Either<Failure, T>`.

#### 12.3 Admin Request/Response Models

**File:** `lib/data/models/admin/` (NEW directory)

- `create_client_request.dart` — all client fields including earn-specific
- `create_sub_account_request.dart` — clientId, name, initialBudget
- `fund_sub_account_request.dart` — clientId, subAccountId, amount, reference
- `create_thread_request.dart` — all new thread fields
- `create_opportunity_request.dart` — all opportunity fields + earningType + questions
- `client_summary.dart` — list item model
- `client_detail.dart` — full detail model with sub-accounts
- `earn_overview.dart` — dashboard stats model

#### 12.4 Admin BLoC

**File:** `lib/presentation/admin/blocs/admin_bloc.dart` (NEW)

Events:
```dart
@freezed
class AdminEvent with _$AdminEvent {
  // Clients
  const factory AdminEvent.loadClients() = _LoadClients;
  const factory AdminEvent.createClient(CreateClientRequest request) = _CreateClient;
  const factory AdminEvent.selectClient(String clientId) = _SelectClient;

  // Sub-Accounts
  const factory AdminEvent.loadSubAccounts(String clientId) = _LoadSubAccounts;
  const factory AdminEvent.createSubAccount(CreateSubAccountRequest request) = _CreateSubAccount;
  const factory AdminEvent.fundSubAccount(FundSubAccountRequest request) = _FundSubAccount;

  // Threads
  const factory AdminEvent.loadThreads({String? clientId}) = _LoadThreads;
  const factory AdminEvent.createThread(CreateThreadRequest request) = _CreateThread;

  // Opportunities
  const factory AdminEvent.loadOpportunities(String threadId) = _LoadOpportunities;
  const factory AdminEvent.createOpportunity(CreateOpportunityRequest request) = _CreateOpportunity;

  // Dashboard
  const factory AdminEvent.loadOverview() = _LoadOverview;
}
```

State:
```dart
@freezed
class AdminState with _$AdminState {
  const factory AdminState({
    @Default(AdminStatus.initial) AdminStatus status,
    @Default([]) List<ClientSummary> clients,
    ClientDetail? selectedClient,
    @Default([]) List<ClientSubAccount> subAccounts,
    @Default([]) List<EarnThread> threads,
    @Default([]) List<EarnOpportunity> opportunities,
    EarnOverview? overview,
    String? error,
  }) = _AdminState;
}
```

This BLoC is provided at the admin app level (in `admin_app.dart`), NOT
in the consumer mobile app.

---

### Phase 13 — Admin Flutter: Screens

#### 13.1 Admin Login — Wire to Firebase Auth

**File:** `lib/presentation/admin/screens/admin_login_screen.dart` (UPDATE)

Change `_handleLogin()`:
- Replace the dummy `Future.delayed` with actual
  `FirebaseAuth.instance.signInWithEmailAndPassword`
- On success: `GoRouter` redirect handles navigation to dashboard
- The `AuthBloc` already handles auth state changes

**File:** `lib/presentation/admin/router/admin_router.dart` (UPDATE)

Fix the TODO at line 94:
```dart
redirect: (context, state) {
  final authState = context.read<AuthBloc>().state;
  final isAuthenticated = authState.status == AuthStatus.authenticated;
  final isOnLogin = state.matchedLocation == '/login';

  // Check admin role from Firebase custom claims
  final isAdmin = authState.user?.customClaims?['admin'] == true ||
      authState.user?.customClaims?['superAdmin'] == true;

  if (!isAuthenticated && !isOnLogin) return '/login';
  if (isAuthenticated && !isAdmin && !isOnLogin) return '/login?error=unauthorized';
  if (isAuthenticated && isAdmin && isOnLogin) return '/';
  return null;
},
```

#### 13.2 Client Management Screen — Wire to Backend

**File:** `lib/presentation/admin/screens/client_management_screen.dart` (REWRITE)

The existing screen has a good UI skeleton (stats cards, search/filter, table,
create dialog).  Rewrite to:

1. **Connect to `AdminBloc`** — dispatch `loadClients()` on init
2. **Populate stats cards** — from `AdminBloc.state.overview`:
   - Total Clients, Active Campaigns, Total Balance, Total Spent
3. **Populate table** — from `AdminBloc.state.clients`:
   - Each row shows: company name, contact, industry, balance, campaigns, status
   - Row tap → navigate to client detail
4. **Wire Create dialog** — change `_handleCreate()` to dispatch
   `AdminEvent.createClient(...)` instead of dummy `Future.delayed`
5. **Add earn-specific fields to create dialog**:
   - `displayName` (user-facing name)
   - `avatarImage` (logo URL or upload)
   - `avatarColor` (hex color picker)
   - `brandAccountTypeId` (text field)
   - `budgetWarningThreshold` (slider, default 20%)

#### 13.3 Client Detail Screen (NEW)

**File:** `lib/presentation/admin/screens/client_detail_screen.dart` (NEW)

**Route:** `/clients/:clientId`

Layout (web desktop — wide layout):
```
Scaffold
├── AppBar: "← Clients / {companyName}" breadcrumb
└── Body: Row
    ├── Left panel (2/3 width)
    │   ├── Client info card (name, contact, industry, reg, VAT)
    │   ├── Sub-Accounts section
    │   │   ├── Header: "Budget Accounts" + "Add Sub-Account" button
    │   │   └── DataTable:
    │   │       Columns: Name | Balance | Initial | Remaining % | Status | Actions
    │   │       Each row: clickable, shows fund/deactivate actions
    │   │       Color-coded: green (>50%), amber (20-50%), red (<20%)
    │   └── Earn Threads section
    │       ├── Header: "Campaigns (Threads)" + "Create Thread" button
    │       └── List of threads for this client
    │           Each: title, status, opportunities count, sub-account link
    │           Click → navigate to thread detail
    └── Right panel (1/3 width)
        ├── Quick Stats card
        │   ├── Total Balance (all sub-accounts)
        │   ├── Active Threads
        │   ├── Active Opportunities
        │   └── Total Engagements
        ├── Activity timeline (recent events)
        └── Actions: Edit Client, Freeze/Unfreeze
```

Dialogs:
- **Create Sub-Account**: name + initial budget → `adminCreateClientSubAccount`
- **Fund Sub-Account**: amount + reference → `adminFundClientSubAccount`
- **Create Thread**: opens thread creation dialog (see 13.4)

#### 13.4 Thread Management Dialog/Screen

**File:** `lib/presentation/admin/screens/thread_management_screen.dart` (NEW)

Can be accessed:
1. From client detail screen → "Create Thread" button (pre-fills clientId)
2. From a new top-level `/earn-threads` admin route (see all threads across clients)

**Create Thread form — 2-step:**

**Step 1 — Campaign Details:**
```
Client (dropdown, required) — pre-selected if coming from client detail
Title (text, required) — "iMaliChat Daily", "Nike Summer Survey"
Description (text area, optional)
Token Source Sub-Account (dropdown, required) — filtered by selected client
Token Destination Type (text, optional) — null = default wallet
Featured (toggle)
Pinned (toggle)
Active (toggle)
Active From (date picker, optional)
Active To (date picker, optional)
```

**Step 2 — Audience Targeting** (uses shared `TargetingFormWidget`):
```
Genders (multi-select chips: Male, Female, Non-binary, Prefer not to say)
Age Range (range slider: 13-65+, or "All ages" toggle)
Provinces (multi-select chips: 9 SA provinces)
Cities (multi-select chips or text input with autocomplete)
Languages (multi-select chips: 11 SA languages)
Interests (multi-select chips from predefined categories)
Device Platforms (toggle chips: Android, iOS)
Account Age (range: min/max days, or "All" toggle)
Engagement Level (multi-select: New, Active, Dormant)
Previous Brand Interaction (radio: No filter | Include only | Exclude)
Max Audience Size (number input, optional)
```

All targeting fields default to null (= no restriction, show to all).
A summary chip shows active filters: "3 filters active" with tooltip.

On submit → calls `createEarnThread` Cloud Function with targeting object.

**Thread list view** (when showing all threads):
```
DataTable:
Columns: Title | Client | Sub-Account | Opportunities | Status | Featured | Actions
Filter: by client, by status (active/inactive/scheduled/expired)
```

#### 13.5 Opportunity Management Screen

**File:** `lib/presentation/admin/screens/opportunity_management_screen.dart` (NEW)

Accessed from thread detail or thread list → "Add Opportunity" button.

**Create Opportunity form — 4-step wizard:**

**Step 1 — Basic Info:**
```
Thread (dropdown, required) — pre-selected if coming from thread
Title (text, required) — "Watch Nike's New Ad"
Description (text area, optional)
Earning Type (dropdown, required) — survey | video | trivia | rating | poll
Token Reward (number, required) — e.g. 50
Duration (seconds, required) — media viewing time
Active (toggle)
Expires At (date picker, optional)
```

**Step 2 — Media:**
```
Media Type (radio: video | image | text)
Media URL (text, required) — Firebase Storage URL or external
Preview (live preview of media based on type)
```

**Step 3 — Questions (Survey Builder):**
```
Question list (reorderable):
  Each question:
  ├── Question text (text field)
  ├── Options (dynamic list of text fields)
  │   ├── Option A
  │   ├── Option B
  │   ├── Option C (optional)
  │   └── Option D (optional)
  │   └── + Add Option
  └── Correct Answer (dropdown, optional — for trivia type)

+ Add Question button
```

**Step 4 — Targeting Override (optional):**
```
Toggle: "Use thread targeting" (default ON) / "Custom targeting"
If custom targeting:
  └── Same TargetingFormWidget as thread creation
      Shows inherited thread targeting in read-only above the form
      Custom values NARROW the thread audience (AND intersection)
```

Note: opportunity targeting can only be MORE restrictive than thread targeting.
The admin UI should show a warning if opportunity targeting would result in
zero eligible audience (e.g., thread targets men, opportunity targets women).

Every opportunity follows the standard format: media → questions → reward.
The `earningType` only changes how the consumer app presents it (button labels,
UI chrome) — NOT the data structure.

On submit → calls `createEarnOpportunity` Cloud Function.

**Preview panel:**
Shows a mock of how the opportunity will appear in the consumer app:
- Message card preview (how it looks in the thread)
- Interaction preview (media + first question)

#### 13.6 Shared: `TargetingFormWidget`

**File:** `lib/presentation/admin/widgets/targeting_form_widget.dart` (NEW)

Reusable widget used by both thread and opportunity creation forms.

```dart
class TargetingFormWidget extends StatefulWidget {
  final TargetingCriteria? initialValue;
  final TargetingCriteria? inheritedTargeting;  // read-only display (for opportunities)
  final ValueChanged<TargetingCriteria?> onChanged;
}
```

Layout:
```
Column
├── Genders section: FilterChip for each gender
├── Age Range section: RangeSlider (13-65+) with "All ages" toggle
├── Provinces section: Wrap of FilterChips for 9 SA provinces
├── Cities section: Autocomplete text field with chips
├── Languages section: FilterChips for 11 SA languages
├── Interests section: FilterChips for predefined categories
├── Device Platforms section: ToggleButtons (Android, iOS)
├── Account Age section: Min/Max number fields with "All" toggle
├── Engagement Level section: FilterChips (New, Active, Dormant)
├── Brand Interaction section: RadioListTile (No filter, Include, Exclude)
└── Max Audience section: Number field with "Unlimited" toggle
```

Uses constants from `TargetingConstants` for labels and values.
Each section has a clear/reset button.
Shows active filter count in a summary bar.

#### 13.7 Budget Monitoring Dashboard

**File:** `lib/presentation/admin/screens/admin_dashboard_screen.dart` (UPDATE)

The existing dashboard screen is a placeholder.  Rewrite to show:

```
Scaffold
└── SingleChildScrollView
    ├── Stats row (4 cards):
    │   ├── Active Clients
    │   ├── Active Threads
    │   ├── Active Opportunities
    │   └── Engagements Today
    │
    ├── Budget Alerts section (if any)
    │   └── List of sub-accounts below threshold
    │       Each: client name, sub-account name, balance, % remaining
    │       Color: amber for <20%, red for depleted
    │       Action: "Fund" button → opens fund dialog
    │
    ├── Recent Engagements chart (daily bar chart, last 7 days)
    │   └── X: date, Y: engagement count
    │
    └── Quick Actions
        ├── "Create Client" → navigate to /clients
        ├── "Create Thread" → navigate to thread creation
        └── "View All Threads" → navigate to /earn-threads
```

Dispatches `AdminEvent.loadOverview()` on init.  Calls `adminGetEarnOverview`.

#### 13.7 Update Admin Router — Add New Routes

**File:** `lib/presentation/admin/router/admin_router.dart` (UPDATE)

Add new routes inside the `ShellRoute`:
```dart
// Client Detail
GoRoute(
  path: '/clients/:clientId',
  name: 'adminClientDetail',
  builder: (context, state) {
    final clientId = state.pathParameters['clientId'] ?? '';
    return ClientDetailScreen(clientId: clientId);
  },
),

// Earn Thread Management
GoRoute(
  path: '/earn-threads',
  name: 'adminEarnThreads',
  builder: (context, state) => const ThreadManagementScreen(),
),

// Thread Detail with Opportunities
GoRoute(
  path: '/earn-threads/:threadId',
  name: 'adminEarnThreadDetail',
  builder: (context, state) {
    final threadId = state.pathParameters['threadId'] ?? '';
    return ThreadDetailScreen(threadId: threadId);
  },
),

// Opportunity Creator (standalone, or could be dialog)
GoRoute(
  path: '/earn-threads/:threadId/create-opportunity',
  name: 'adminCreateOpportunity',
  builder: (context, state) {
    final threadId = state.pathParameters['threadId'] ?? '';
    return OpportunityManagementScreen(threadId: threadId);
  },
),
```

#### 13.8 Update Admin Sidebar — Add Earn Section

**File:** `lib/presentation/admin/shell/admin_shell.dart` (UPDATE)

Add a new "EARN MANAGEMENT" section after "ACCOUNT MANAGEMENT":
```dart
// Earn Management section
const Padding(
  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
  child: Text(
    'EARN MANAGEMENT',
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      letterSpacing: 0.5,
    ),
  ),
),
_NavItem(
  icon: Icons.forum_outlined,
  selectedIcon: Icons.forum,
  label: 'Earn Threads',
  path: '/earn-threads',
  isSelected: currentPath.startsWith('/earn-threads'),
),
```

---

### Phase 14 — Admin Integration & End-to-End Testing

#### 14.1 Provide AdminBloc in Admin App

**File:** `lib/presentation/admin/admin_app.dart` (UPDATE)

Wrap the admin app's `MaterialApp.router` with:
```dart
BlocProvider<AdminBloc>(
  create: (context) => getIt<AdminBloc>(),
  child: MaterialApp.router(...),
)
```

Register `AdminBloc`, `AdminRepository`, and `AdminRemoteDataSource` in
the DI container (`injection.dart` or a separate `admin_injection.dart`).

#### 14.2 Run `build_runner` for Admin Models

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generate Freezed code for admin events, states, and models.

#### 14.3 End-to-End Admin Flow Verification

Test the complete admin flow:

1. **Login**: Admin signs in with email/password → verified via custom claims
2. **Dashboard**: Shows stats, budget alerts (if any), recent activity
3. **Create Client**:
   - Fill form → calls `adminCreateClient` with earn fields
   - Client appears in clients list with correct display name / avatar
4. **Create Sub-Account**:
   - From client detail → "Add Sub-Account"
   - Name: "Q1 2026 Campaign Fund", Budget: 1,000,000 tokens
   - Sub-account appears in table with correct balance
5. **Create Thread WITH TARGETING**:
   - From client detail → "Create Thread"
   - Selects client, picks sub-account, enters title/description
   - Sets targeting: gender = female, age 18-35, province = gauteng
   - Thread appears in earn threads list with "3 filters" indicator
6. **Create Opportunity with targeting override**:
   - From thread → "Add Opportunity"
   - Step 1: Title, earning type (survey), reward (50 tokens)
   - Step 2: Media URL, media type (video)
   - Step 3: 3 questions with 4 options each
   - Step 4: Override targeting → add interest = "fashion"
   - Opportunity appears in thread's opportunity list
7. **Consumer verification — TARGETING**:
   - **User A** (female, 25, Gauteng): opens Earn tab → sees thread
   - **User B** (male, 25, Gauteng): opens Earn tab → does NOT see thread
   - **User C** (female, 40, Gauteng): opens Earn tab → does NOT see thread (age)
   - **User D** (female, 25, Western Cape): opens Earn tab → does NOT see thread
   - User A taps thread → sees opportunity (has "fashion" interest)
   - User A with no interests set → does NOT see opportunity (missing field = excluded)
8. **Consumer verification — engagement flow**:
   - User A completes engagement → tokens flow from client sub-account to user
   - Client sub-account balance decremented
   - User A's `interactedClientIds` now includes this client
   - Thread's `completedUniqueUsers` incremented to 1
9. **Budget monitoring**:
   - Deplete sub-account to <20% → warning appears on admin dashboard
   - Deplete to 0 → thread auto-deactivated
   - Fund sub-account → thread re-activated
   - Consumer app no longer shows deactivated thread
10. **Max audience**:
    - Create thread with maxAudience = 2
    - User A and User B complete engagements → completedUniqueUsers = 2
    - User C calls getEligibleThreads → thread NOT returned (audience full)
11. **Previous brand interaction**:
    - Create thread with previousBrandInteraction = "exclude"
    - User A (already interacted with this client) → does NOT see thread
    - New User E → sees thread
    - Create another thread with previousBrandInteraction = "include"
    - User A → sees thread (returning customer)
    - User E → does NOT see thread

---

## 9. Prerequisites & Dependencies

### 9.1 User Profile Data for Targeting

Targeting requires user profile fields that may not be populated for all users.
The following fields MUST exist on the user document (`users/{userId}`) for
targeting to work:

| Field | Entity | Status | Required For |
|---|---|---|---|
| `gender` | UserProfile | **EXISTS** | Gender targeting |
| `dateOfBirth` | UserProfile | **EXISTS** | Age range targeting |
| `province` | UserProfile | **EXISTS** | Province targeting |
| `city` | UserProfile | **EXISTS** | City targeting |
| `languages` | UserProfile | **NEEDS ADDING** | Language targeting |
| `interests` | UserProfile | **NEEDS ADDING** | Interest targeting |
| `createdAt` | User | **EXISTS** | Account age targeting |
| `interactedClientIds` | User | **NEEDS ADDING** | Brand interaction targeting |

**Device platform** is determined at runtime from the Cloud Function request
context — no profile field needed.

**Engagement level** is computed in real-time from the engagements collection
— no profile field needed.

**Important:** If a user's profile is missing a field that a thread targets
(e.g., `gender` is null but thread targets `["female"]`), the user is
EXCLUDED.  This is by design — incomplete profiles see fewer targeted
campaigns, which incentivizes profile completion.

The profile collection approach (how/when users fill in languages and
interests) is outside the scope of this plan and will be addressed separately.

### 9.2 Denormalization Cascade

When client fields change (displayName, avatarImage, avatarColor), all
threads for that client need their denormalized fields updated.

Add to `adminUpdateClient` in `adminAccounts.ts`:
```
If displayName, avatarImage, or avatarColor changed:
  → Query earnThreads where clientId == this client
  → Batch update clientName, clientAvatarImage, clientAvatarColor
```

---

## 10. Updated File Change Summary

### Backend Files (Cloud Functions)

| Action | File |
|---|---|
| **UPDATE** | `functions/src/adminAccounts.ts` — extend createClient, add sub-account CRUD |
| **UPDATE** | `functions/src/earnAdmin.ts` — targeting on create, getEligibleThreads/Opportunities, admin list functions, adminGetEarnOverview |
| **UPDATE** | `functions/src/engagement.ts` — threadId/clientId on engagement, interactedClientIds tracking, completedUniqueUsers tracking |
| **UPDATE** | `functions/src/wallet.ts` — add `findOrCreateBrandSubAccount` |
| **UPDATE** | `functions/src/ledger/index.ts` — update `processEarningWithSplit` |
| **UPDATE** | `functions/src/index.ts` — export all new functions |
| **NEW** | `functions/src/constants/targeting.ts` — predefined lists, validation helper |

### Consumer Flutter Files

| Action | File |
|---|---|
| **NEW** | `lib/domain/entities/targeting_criteria.dart` |
| **NEW** | `lib/domain/constants/targeting_constants.dart` |
| **UPDATE** | `lib/domain/entities/user_profile.dart` — add languages, interests |
| **UPDATE** | `lib/domain/entities/engagement.dart` — add threadId, clientId |
| **UPDATE** | `lib/domain/entities/earn_thread.dart` — new client/targeting fields |
| **UPDATE** | `lib/domain/entities/earn_opportunity.dart` — add earningType, targeting |
| **UPDATE** | `lib/data/models/user_model.dart` — add languages, interests, interactedClientIds |
| **UPDATE** | `lib/data/models/earn_thread_model.dart` — new fields + targeting |
| **UPDATE** | `lib/data/models/earn_opportunity_model.dart` — earningType + targeting |
| **UPDATE** | `lib/data/models/engagement_model.dart` — add threadId, clientId |
| **UPDATE** | `lib/domain/repositories/earn_repository.dart` — remove watch methods, rename to getEligible |
| **UPDATE** | `lib/data/datasources/remote/earn_remote_datasource.dart` — switch to Cloud Functions |
| **UPDATE** | `lib/data/repositories/earn_repository_impl.dart` — update for new datasource methods |
| **REWRITE** | `lib/presentation/screens/earn/earn_screen.dart` — inbox UI |
| **REWRITE** | `lib/presentation/screens/earn/earn_detail_screen.dart` → EarnThreadScreen |
| **REWRITE** | `lib/presentation/screens/earn/earn_interaction_screen.dart` — interaction flow |
| **DELETE** | `lib/presentation/screens/earn/earn_wallet_confirm_screen.dart` |
| **NEW** | `lib/presentation/widgets/earn/earn_message_card.dart` |
| **NEW** | `lib/presentation/widgets/earn/reward_animation.dart` |
| **NEW** | `lib/presentation/widgets/earn/engagement_history_sheet.dart` |
| **UPDATE** | `lib/presentation/blocs/earn/earn_bloc.dart` — stream→future, remove subscriptions |
| **UPDATE** | `lib/presentation/blocs/earn/earn_event.dart` — remove watchThreads, threadsUpdated events |
| **UPDATE** | `lib/presentation/blocs/earn/earn_state.dart` — populate or remove totalAvailableOpportunities |
| **UPDATE** | `lib/presentation/router/app_router.dart` — new earn routes |

### Admin Flutter Files

| Action | File |
|---|---|
| **NEW** | `lib/data/datasources/remote/admin_remote_datasource.dart` |
| **NEW** | `lib/data/repositories/admin_repository_impl.dart` |
| **NEW** | `lib/data/models/admin/` (directory — request/response models) |
| **NEW** | `lib/presentation/admin/blocs/admin_bloc.dart` |
| **NEW** | `lib/presentation/admin/blocs/admin_event.dart` |
| **NEW** | `lib/presentation/admin/blocs/admin_state.dart` |
| **NEW** | `lib/presentation/admin/widgets/targeting_form_widget.dart` |
| **UPDATE** | `lib/presentation/admin/screens/admin_login_screen.dart` — wire to Firebase Auth |
| **UPDATE** | `lib/presentation/admin/screens/admin_dashboard_screen.dart` — earn overview |
| **REWRITE** | `lib/presentation/admin/screens/client_management_screen.dart` — wire to backend |
| **NEW** | `lib/presentation/admin/screens/client_detail_screen.dart` |
| **NEW** | `lib/presentation/admin/screens/thread_management_screen.dart` |
| **NEW** | `lib/presentation/admin/screens/opportunity_management_screen.dart` |
| **UPDATE** | `lib/presentation/admin/router/admin_router.dart` — new routes, admin role check |
| **UPDATE** | `lib/presentation/admin/shell/admin_shell.dart` — earn nav section |
| **UPDATE** | `lib/presentation/admin/admin_app.dart` — provide AdminBloc |

### Infrastructure Files

| Action | File |
|---|---|
| **UPDATE** | `firestore.rules` — clients server-only, threads/opportunities server-only |
| **UPDATE** | `firestore.indexes.json` — composite indexes for queries |

---

## 11. Updated Phase Dependencies

```
Phase 1 (Extend Client Admin Backend — adminAccounts.ts)
  ↓
Phase 2 (Thread/Opportunity Backend + Targeting CFs + getEligibleThreads)
  ↓
Phase 3 (processEngagement Token Flow + Targeting Tracking)  ← most critical
  ↓
Phase 4 (Flutter Data Layer — entities, models, CF-based datasource)
  ↓
Phase 5 (EarnBloc — stream→future)
  ↓
Phase 6 (Flutter UI Rewrite — consumer app)  ← largest effort
  ↓
Phase 7 (Routing — consumer app)

Phase 8 (Firestore Rules & Indexes — server-only earn reads)

Phase 11 (Admin Backend — overview, list functions)  ← depends on Phase 1-2
  ↓
Phase 12 (Admin Flutter Data Layer & BLoC)
  ↓
Phase 13 (Admin Flutter Screens + TargetingFormWidget)
  ↓
Phase 14 (Admin Integration & E2E Targeting Testing)

Phase 9 (Data Migration)  ← after all code deployed
  ↓
Phase 10 (Analysis & Full Verification)  ← final
```

**Recommended execution order:**
1. Phases 1-3 (backend — client, earn, engagement, targeting)
2. Phase 8 (rules/indexes — deploy alongside backend)
3. Phases 4-7 + 11-13 in parallel (consumer Flutter + admin Flutter)
4. Phase 14 (admin E2E + targeting verification)
5. Phase 9 (migration)
6. Phase 10 (final verification)

**Key dependencies to watch:**
- Phase 2 `getEligibleThreads` requires Phase 1's client sub-account structure
- Phase 4's datasource switch requires Phase 2's Cloud Functions to be deployed
- Phase 5's stream→future change MUST happen with Phase 4's datasource switch
- Phase 8's rule changes (server-only reads) MUST deploy WITH Phase 2's CFs
- Phase 13's `TargetingFormWidget` uses Phase 4's `TargetingConstants`
