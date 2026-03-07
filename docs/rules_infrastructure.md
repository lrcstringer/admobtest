# iMaliChat Rules Infrastructure — Comprehensive Reference

> **Last updated:** 2026-03-07
> **Scope:** Account Type rules, sub-account behaviour, P2P transfer restrictions, cashout rules, purchase offramp rules, token expiry — covering definition, storage, enforcement, and known gaps.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Rule Definitions — What Rules Can Be Set](#2-rule-definitions--what-rules-can-be-set)
3. [Where and How Rules Are Configured](#3-where-and-how-rules-are-configured)
4. [Where and How Rules Are Enforced](#4-where-and-how-rules-are-enforced)
5. [Enforcement Gaps](#5-enforcement-gaps)
6. [Architectural Notes and Advice](#6-architectural-notes-and-advice)
7. [Quick Reference Tables](#7-quick-reference-tables)
8. [File Reference Map](#8-file-reference-map)

---

## 1. Overview

iMaliChat uses a **multi-wallet architecture** where each user has:

- **One main wallet** — unrestricted, receives all earnings by default
- **Zero or more brand sub-accounts** — created automatically when a user earns from or interacts with a brand campaign; governed by an **Account Type** that defines the rules

Account Types are the core mechanism for configuring rules. An Account Type is a template document in Firestore that defines what operations a brand wallet allows. When a user receives tokens into a brand wallet, the rules of that Account Type govern all future operations on those tokens.

### Key Principle: Defense in Depth

Rules are enforced at **three layers**:

| Layer | Purpose | Bypass risk |
|-------|---------|-------------|
| **Flutter UI** (client) | UX convenience — hide buttons, filter contacts | Can be bypassed by modified client |
| **Cloud Function** (CF) | Input validation + pre-checks before ledger call | Authoritative for HTTP-level errors |
| **Ledger** (`processP2PTransfer`, etc.) | Final enforcement inside Firestore transaction | Cannot be bypassed — single source of truth |

---

## 2. Rule Definitions — What Rules Can Be Set

### 2.1 AccountTypeRules Interface

**Defined in:** `functions/src/ledger/types.ts` (lines 558–565)

```typescript
interface AccountTypeRules {
  allowedOfframps: string[];              // Purchase categories allowed
  allowP2pSend: boolean;                  // Can send tokens via P2P
  allowP2pReceive: boolean;              // Can receive tokens via P2P
  allowCashout: boolean;                 // Can cash out tokens to bank
  expiryDays: number | null;             // Days until unused balance expires
  p2pRestrictToSameAccountType: boolean; // Restrict P2P to same brand type
}
```

### 2.2 Individual Rule Descriptions

#### `allowP2pSend` (default: `true`)

**What it controls:** Whether tokens held in this brand wallet can be sent to another user via P2P transfer.

**When `false`:** The user cannot send tokens from this wallet to anyone. The tokens are "locked in" — they can only be spent on purchases (if allowed by `allowedOfframps`) or cashed out (if allowed by `allowCashout`).

**Use case:** A brand wants users to spend tokens only at their stores, not transfer them to friends.

---

#### `allowP2pReceive` (default: `true`)

**What it controls:** Whether this brand wallet can receive tokens from other users via P2P transfer.

**When `false`:** No other user can send tokens into this wallet. The only way tokens enter is through brand-funded earn activities.

**Use case:** A brand wants to ensure all tokens in their wallets were earned directly, not transferred in from other users.

---

#### `allowCashout` (default: `true`)

**What it controls:** Whether tokens in this brand wallet can be cashed out (converted to fiat/ZAR and paid to the user's bank account).

**When `false`:** Tokens are trapped in the wallet and can only be spent on purchases or transferred (if allowed).

**Use case:** A loyalty-only brand wallet where tokens can only be redeemed for the brand's products/services, never converted to cash.

---

#### `p2pRestrictToSameAccountType` (default: `false`)

**What it controls:** When sending tokens from this brand wallet, the recipient **must also have** a sub-account of the same Account Type. Tokens are automatically routed to the recipient's matching brand wallet.

**When `true`:**
- Client-side: User search is filtered to only show contacts who have a matching brand sub-account (via `activeAccountTypeIds` denormalized array on user documents + `array-contains` Firestore query)
- Server-side: `processP2PTransfer` searches the recipient's sub-accounts for a match and rejects the transfer if none found

**When `false`:** Tokens can be sent to any user. If sent from a brand wallet, they arrive in the recipient's main wallet (unless the recipient also has a matching brand wallet and the transfer explicitly targets it).

**Use case:** A closed-loop loyalty program where Shoprite tokens can only be sent between Shoprite members.

---

#### `allowedOfframps` (default: `["*"]`)

**What it controls:** Which purchase categories (airtime, data, electricity, vouchers, etc.) tokens from this wallet can be used for.

**Values:**
- `["*"]` — all purchase categories allowed (unrestricted)
- `["shoprite_voucher", "checkers_voucher"]` — only specific categories
- `[]` — no purchases allowed (tokens can only be transferred or cashed out)

**Derived flag:** `isRestricted` is a computed boolean: `true` when `allowedOfframps` does **not** include `"*"`.

**Use case:** A brand wallet where tokens can only be redeemed for that brand's specific vouchers.

---

#### `expiryDays` (default: `null`)

**What it controls:** The number of days after which unused tokens in this wallet type should expire.

**Values:**
- `null` — tokens never expire
- `30` — tokens expire 30 days after being credited (example)

**Use case:** A time-limited promotional campaign where tokens must be used within 90 days.

> **WARNING: This rule is currently NOT ENFORCED.** See [Section 5.1](#51-expirydays-not-enforced-critical) for details.

---

### 2.3 SubAccountTypeDefinition (Account Type Document)

**Firestore collection:** `accountTypes/{accountTypeId}`

```typescript
interface SubAccountTypeDefinition {
  id: string;                    // Unique ID (lowercase alphanumeric + underscores)
  advertiserId: string | null;   // Link to brand partner client (null = platform)
  name: string;                  // Display name (e.g., "Shoprite Rewards")
  description: string;           // Human-readable description
  iconUrl: string | null;        // Brand icon URL
  isRestricted: boolean;         // Computed: !rules.allowedOfframps.includes("*")
  rules: AccountTypeRules;       // The rules object above
  isActive: boolean;             // Soft-delete flag
  createdAt: Timestamp;
}
```

### 2.4 SubAccount (Per-User Wallet Instance)

**Firestore path:** `ledgerAccounts/user:{userId}/subAccounts/{subAccountId}`

```typescript
interface SubAccount {
  id: string;
  userId: string;
  accountTypeId: string | null;  // FK to accountTypes doc (null = unrestricted)
  name: string;                  // Display name
  balance: number;               // Current token balance
  lifetimeCredits: number;       // Total ever credited
  lifetimeDebits: number;        // Total ever debited
  isActive: boolean;
  isDefault: boolean;            // true only for the main wallet sub-account
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

The `accountTypeId` field is the foreign key that links a user's sub-account to its rule set. When `null`, the sub-account is unrestricted (user-created or main wallet).

---

## 3. Where and How Rules Are Configured

### 3.1 Admin Portal — Account Type Management Screen

**File:** `lib/presentation/admin/screens/account_type_management_screen.dart`

The admin portal provides a full CRUD interface for Account Types:

| Action | CF Called | Admin Permission |
|--------|----------|-----------------|
| List all types | `adminListAccountTypes` | `accounts:listAccountTypes` |
| Get single type | `adminGetAccountType` | `accounts:getAccountType` |
| Create new type | `adminCreateAccountType` | `accounts:createAccountType` |
| Edit type | `adminUpdateAccountType` | `accounts:updateAccountType` |
| Deactivate type | `adminDeactivateAccountType` | `accounts:updateAccountType` |
| Reactivate type | `adminUpdateAccountType` | `accounts:updateAccountType` |

**UI Form Fields:**

| Field | Type | Validation | Notes |
|-------|------|-----------|-------|
| ID | Text | `/^[a-z0-9_]+$/`, immutable after creation | Used as Firestore doc ID |
| Name | Text | Required | Display name |
| Description | Textarea | Required | |
| Advertiser | Dropdown | Optional | Links to client/brand partner |
| Icon URL | Text | Optional | Brand icon |
| Allow P2P Send | Toggle | Default: ON | |
| Allow P2P Receive | Toggle | Default: ON | |
| Allow Cashout | Toggle | Default: ON | |
| P2P Same Type Only | Toggle | Default: OFF | |
| Allowed Offramps | Text (CSV) | Default: `["*"]` | |
| Expiry Days | Number | Optional, null = never | |

**Table Display:** Shows all types with visual rule indicators (icons for each enabled/disabled rule), status badges, and action buttons.

### 3.2 Backend — Account Type CRUD Cloud Functions

**File:** `functions/src/adminAccounts.ts` (lines 1214–1497)

#### `adminCreateAccountType` (line 1320)

Creates a new Account Type document. Rules are validated and merged with defaults:

```typescript
const validatedRules: AccountTypeRules = {
  allowedOfframps: rules?.allowedOfframps || ["*"],
  allowP2pSend: rules?.allowP2pSend !== false,           // Default: true
  allowP2pReceive: rules?.allowP2pReceive !== false,     // Default: true
  allowCashout: rules?.allowCashout !== false,           // Default: true
  expiryDays: typeof rules?.expiryDays === "number" ? rules.expiryDays : null,
  p2pRestrictToSameAccountType: rules?.p2pRestrictToSameAccountType === true, // Default: false
};
```

**Key behaviour:** Boolean defaults are **permissive** — if a rule flag is omitted, operations are allowed. Only `p2pRestrictToSameAccountType` defaults to `false` (restrictive = opt-in).

#### `adminUpdateAccountType` (line 1407)

Updates existing type. Rules are **partially merged** — only the provided rule fields are overwritten. Existing rules for unspecified fields are preserved.

**Important:** Changes take effect **immediately** for all future operations. There is no caching of rules on sub-account documents; rules are always fetched fresh from the `accountTypes` collection at operation time.

#### `adminDeactivateAccountType` (line 1463)

Soft-deletes an Account Type (`isActive: false`). Existing sub-accounts continue to work because rule lookups use the document ID, not the `isActive` flag. Can be reactivated via `adminUpdateAccountType`.

### 3.3 Inline Account Type Creation (Earn Threads)

**File:** `functions/src/earnAdmin.ts` (lines 210–231)

When creating an Earn Thread, an admin can specify `inlineAccountType` which automatically creates a new Account Type. This is used when a brand campaign needs a dedicated wallet type. The same `AccountTypeRules` validation logic applies.

### 3.4 Sub-Account Creation (User-Side)

**File:** `functions/src/ledger/subAccounts.ts` (lines 97–159)

`getOrCreateBrandSubAccount(userId, accountTypeId, name)` — Called automatically when a user first earns tokens from a brand campaign. It:

1. Checks if the user already has a sub-account with this `accountTypeId`
2. If yes, returns the existing one (idempotent)
3. If no, creates a new sub-account linked to the Account Type
4. Denormalizes: adds `accountTypeId` to user document's `activeAccountTypeIds` array

This function is the **only** way brand sub-accounts are created for users. Users cannot manually create brand sub-accounts.

### 3.5 Sub-Account Lifecycle

| Operation | Function | File |
|-----------|----------|------|
| Create | `getOrCreateBrandSubAccount()` | `ledger/subAccounts.ts:97` |
| Deactivate | `deactivateSubAccount()` | `ledger/subAccounts.ts:554` |
| Delete all | `deleteAllSubAccounts()` | `ledger/subAccounts.ts:605` |

**Deactivation rules:**
- Cannot deactivate the default (main) sub-account
- Must have zero balance before deactivation
- Removes `accountTypeId` from user's `activeAccountTypeIds` if no other active sub-accounts of same type remain

---

## 4. Where and How Rules Are Enforced

### 4.1 Rule Delivery to Client

**Cloud Function:** `getSubAccounts` in `functions/src/wallet.ts` (lines 280–310)

When the Flutter app loads a user's wallets, this CF enriches each sub-account with its rule flags by looking up the Account Type:

```typescript
const rules = await getAccountTypeRules(sa.accountTypeId);
return {
  ...sa,
  allowP2pSend: rules.allowP2pSend,
  allowP2pReceive: rules.allowP2pReceive,
  allowCashout: rules.allowCashout,
  p2pRestrictToSameAccountType: rules.p2pRestrictToSameAccountType ?? false,
  allowedOfframps: rules.allowedOfframps,
};
```

This allows the Flutter client to make UI decisions based on rules without additional CF calls.

### 4.2 Client-Side Enforcement (Flutter UI)

Client-side enforcement is **UX-only** — it provides a better experience by hiding irrelevant options, but it is not a security boundary.

#### 4.2.1 Wallet Detail Screen

**File:** `lib/presentation/screens/wallet/wallet_detail_screen.dart`

| Button | Show condition | Behaviour |
|--------|---------------|-----------|
| **Send** | `!subAccount.isRestricted \|\| subAccount.allowP2pSend` | Unrestricted: always. Brand: only if `allowP2pSend` |
| **Request** | `subAccount.isRestricted && subAccount.allowP2pReceive` | Brand wallets only, only if `allowP2pReceive` |
| **Cash Out** | `subAccount.allowCashout` | Hidden entirely if cashout not allowed |
| **Rewards/Use** | `subAccount.isRestricted` | Brand wallets only |

#### 4.2.2 Wallet Picker (Send/Request Modal)

**File:** `lib/presentation/widgets/messaging/wallet_picker.dart`

Filters which wallets appear in the picker:
```dart
final eligible = subAccounts.where((sa) {
  if (!sa.isRestricted) return false;  // Only brand wallets shown
  return isSendMode ? sa.allowP2pSend : sa.allowP2pReceive;
}).toList();
```

Shows a lock icon on wallets with `p2pRestrictToSameAccountType: true`.

#### 4.2.3 Contact Search Filtering (`p2pRestrictToSameAccountType`)

**Files:**
- `lib/presentation/widgets/messaging/token_actions_sheet.dart` (lines 60–68)
- `lib/presentation/screens/wallet/wallet_send_screen.dart` (lines 27–35)

When a brand wallet with `p2pRestrictToSameAccountType: true` is selected, the `_filterAccountTypeId` getter extracts the `accountTypeId` and passes it to user search:

```dart
String? get _filterAccountTypeId {
  if (_selectedSubAccountId == null) return null;
  final walletState = context.read<WalletBloc>().state;
  final sa = walletState.subAccounts
      .where((s) => s.id == _selectedSubAccountId).firstOrNull;
  if (sa == null || !sa.p2pRestrictToSameAccountType) return null;
  return sa.accountTypeId;
}
```

This `accountTypeId` is passed to `UserSearchBloc.searchUsers()`, which passes it to the `searchUsers` Cloud Function, which adds `array-contains` filtering on the recipient's `activeAccountTypeIds` field.

**Flow:**
```
User selects brand wallet → _filterAccountTypeId computed
  → UserSearchBloc.searchUsers(query, accountTypeId: X)
    → searchUsers CF: .where("activeAccountTypeIds", "array-contains", X)
      → Only users with matching brand sub-account returned
```

#### 4.2.4 In-Conversation Mode Warning

**File:** `token_actions_sheet.dart` (lines 196–216)

When sending from inside a conversation (recipient is fixed), if a restricted wallet is selected, an info banner is shown:
> "This wallet requires the recipient to have a matching brand wallet."

The actual enforcement still happens server-side.

### 4.3 Cloud Function Enforcement

#### 4.3.1 `sendP2PTransfer` (wallet.ts, lines 398–481)

Pre-validates before calling ledger:

| Check | Code | Error |
|-------|------|-------|
| Auth required | `request.auth` | `unauthenticated` |
| Amount > 0 | `amount > 0` | `invalid-argument` |
| Not self-send | `recipientUserId !== userId` | `invalid-argument` |
| Sub-account P2P send allowed | `validateSubAccountAllows(accountTypeId, "p2p_send")` | `failed-precondition` |
| Sufficient balance | `validateSubAccountBalance()` or `validateMainWalletBalance()` | `failed-precondition` |

#### 4.3.2 `sendConversationTokens` (conversationTokens.ts, lines 49–180)

Pre-validates, then delegates to ledger:

| Check | Code | Error |
|-------|------|-------|
| Auth + AppCheck + PlayIntegrity | Highest security level | `unauthenticated` |
| Conversation exists | Firestore lookup | `not-found` |
| Both users are participants | Membership check | `permission-denied` |
| Not self-send | `recipientId !== userId` | `invalid-argument` |
| Sufficient balance | Balance validation | `failed-precondition` |

Note: Does **not** pre-validate `p2p_send` — relies on `processP2PTransfer` for that.

#### 4.3.3 `requestConversationTokens` (conversationTokens.ts, lines 182–275)

Creates a pending request message. No balance or rule validation (tokens don't move yet).

#### 4.3.4 `acceptConversationTokenRequest` (conversationTokens.ts, lines 281–402)

When paying a token request:

| Check | Code | Error |
|-------|------|-------|
| Message exists, is pending, not expired | DB lookup | `failed-precondition` |
| If requester has restricted wallet: payer must have matching | Sub-account lookup | `failed-precondition` |
| Payer balance sufficient | Balance validation | `failed-precondition` |

#### 4.3.5 `processCashout` (wallet.ts, lines 38–157)

| Check | Code | Error |
|-------|------|-------|
| Amount >= MIN_CASHOUT_AMOUNT (5000 tokens / R50) | `amount >= 5000` | `invalid-argument` |
| Sub-account allows cashout | `validateSubAccountAllows(accountTypeId, "cashout")` | `failed-precondition` |
| Sufficient balance | Balance validation | `failed-precondition` |

#### 4.3.6 `transferBetweenWallets` (wallet.ts, lines 315–393)

Internal transfers between a user's own wallets:

| Check | Code | Error |
|-------|------|-------|
| Source ≠ destination | `fromId !== toId` | `invalid-argument` |
| Source sub-account allows P2P send | `validateSubAccountAllows(accountTypeId, "p2p_send")` | `failed-precondition` |
| Sufficient balance | Balance validation | `failed-precondition` |

Note: Does **not** validate `p2p_receive` on destination wallet. See [Section 5.2](#52-allowp2preceive-not-enforced-server-side-high).

#### 4.3.7 `processPurchase` (purchases.ts, lines 26–234)

| Check | Code | Error |
|-------|------|-------|
| Sub-account offramp allowed | `validatePurchaseAllowed(accountTypeId, purchaseCategory)` | `failed-precondition` |
| Sufficient balance | Balance validation | `failed-precondition` |

### 4.4 Ledger-Level Enforcement

**File:** `functions/src/ledger/index.ts`

#### 4.4.1 `processP2PTransfer` (lines 592–729) — The Final Authority

This is the **single source of truth** for P2P transfer rules. All P2P flows ultimately call this function.

**Checks performed (in order):**

1. **Sender sub-account exists** → `SUB_ACCOUNT_NOT_FOUND`
2. **Sender balance sufficient** → `INSUFFICIENT_SUB_ACCOUNT_BALANCE` or `INSUFFICIENT_BALANCE`
3. **`allowP2pSend` allowed** → `P2P_SEND_NOT_ALLOWED` (via `validateSubAccountAllows`)
4. **`p2pRestrictToSameAccountType` enforcement:**
   - If sender's account type has this flag, search recipient's sub-accounts for matching `accountTypeId`
   - If no match found → `RECIPIENT_MISSING_MATCHING_ACCOUNT`
   - If match found → auto-route tokens to recipient's matching sub-account
5. **Create journal entries** (double-entry: DR sender, CR recipient)
6. **Atomic transaction:** Post journal + debit sender sub-account + credit recipient sub-account

**NOT checked:** `allowP2pReceive` on recipient's account type. See [Section 5.2](#52-allowp2preceive-not-enforced-server-side-high).

#### 4.4.2 `validateSubAccountAllows` (subAccounts.ts, lines 224–265)

Central validation function for all operations:

```typescript
function validateSubAccountAllows(
  accountTypeId: string | null,
  operation: "p2p_send" | "p2p_receive" | "cashout" | "purchase"
): Promise<{ allowed: boolean; reason?: string }>
```

| Operation | Checks | Error message |
|-----------|--------|---------------|
| `p2p_send` | `rules.allowP2pSend` | "This account cannot send P2P transfers" |
| `p2p_receive` | `rules.allowP2pReceive` | "This account cannot receive P2P transfers" |
| `cashout` | `rules.allowCashout` | "This account cannot process cashouts" |
| `purchase` | `rules.allowedOfframps` (via `validatePurchaseAllowed`) | "This account cannot make purchases" |

**Key point:** The `p2p_receive` validation **exists** in `validateSubAccountAllows` but is **never called** in any transfer flow.

#### 4.4.3 `validatePurchaseAllowed` (subAccounts.ts, lines 270–290)

```typescript
function validatePurchaseAllowed(
  accountTypeId: string | null,
  purchaseCategory: string
): Promise<{ allowed: boolean; reason?: string }>
```

Checks if `purchaseCategory` is in `allowedOfframps` or if wildcard `"*"` is present.

### 4.5 Error Codes

**Defined in:** `functions/src/ledger/types.ts` (lines 670–677)

```typescript
const SubAccountErrorCodes = {
  SUB_ACCOUNT_NOT_FOUND: "SUB_ACCOUNT_NOT_FOUND",
  ACCOUNT_TYPE_NOT_FOUND: "ACCOUNT_TYPE_NOT_FOUND",
  OPERATION_NOT_ALLOWED: "OPERATION_NOT_ALLOWED",
  INSUFFICIENT_SUB_ACCOUNT_BALANCE: "INSUFFICIENT_SUB_ACCOUNT_BALANCE",
  SUB_ACCOUNT_INACTIVE: "SUB_ACCOUNT_INACTIVE",
  OFFRAMP_NOT_ALLOWED: "OFFRAMP_NOT_ALLOWED",
};
```

Additional error codes used in `processP2PTransfer`:
- `P2P_SEND_NOT_ALLOWED`
- `RECIPIENT_MISSING_MATCHING_ACCOUNT`
- `INSUFFICIENT_BALANCE` (main wallet)
- `TRANSACTION_FAILED` (Firestore transaction failure)

---

## 5. Enforcement Gaps

### 5.1 ~~`expiryDays` Not Enforced~~ — RESOLVED

**Severity:** CRITICAL — **FIXED**

**Resolution:** Fully implemented token expiry system:

1. **`lastCreditAt` tracking** — `creditSubAccount()` now sets `lastCreditAt: now` on every credit, resetting the expiry clock. New sub-accounts initialize with `lastCreditAt: null`.
2. **Scheduled sweep** — `expireSubAccountTokens` Cloud Function runs daily at 2 AM SAST. Finds sub-accounts where `lastCreditAt + expiryDays < now` with `balance > 0`. Creates double-entry journal (DR user, CR brand client account) and debits sub-account balance.
3. **Flutter UI** — Wallet detail screen shows "Expires in X days" with color-coded warnings (red ≤ 0 days, warning ≤ 7 days).
4. **Enriched API** — `getSubAccounts` CF returns `expiryDays` and `lastCreditAt` to the client.
5. **Firestore index** — CollectionGroup index on `subAccounts` for `accountTypeId + isActive + lastCreditAt`.
6. **Idempotency** — Uses `token_expiry:{subId}:{dateKey}` idempotency keys to prevent double-processing.

**Files changed:** `ledger/types.ts`, `ledger/subAccounts.ts`, `ledger/index.ts`, `wallet.ts`, `index.ts`, `firestore.indexes.json`, `sub_account.dart`, `sub_account_model.dart`, `wallet_detail_screen.dart`

---

### 5.2 ~~`allowP2pReceive` Not Enforced Server-Side~~ — RESOLVED

**Severity:** HIGH — **FIXED**

**Resolution:** Server-side `p2p_receive` checks added at all relevant enforcement points:

1. **`processP2PTransfer`** (ledger/index.ts) — After determining `finalRecipientSubAccountId`, validates `p2p_receive` on recipient's account type. Returns `P2P_RECEIVE_NOT_ALLOWED` error code. This covers `sendP2PTransfer`, `sendConversationTokens`, and `acceptConversationTokenRequest` since they all funnel through `processP2PTransfer`.
2. **`transferBetweenWallets`** (wallet.ts) — Validates destination sub-account's `p2p_receive` for both main→sub and sub→sub transfer scenarios. Throws `failed-precondition` HttpsError.

**Error code added:** `P2P_RECEIVE_NOT_ALLOWED` in `SubAccountErrorCodes`.

**Files changed:** `ledger/index.ts`, `wallet.ts`, `ledger/types.ts`

---

### 5.3 `allowP2pSend` Not Checked for Main Wallet Sends (LOW)

**Severity:** LOW

**Description:** In `processP2PTransfer`, the `allowP2pSend` check only runs when `senderAccountTypeId` is set (i.e., sending from a brand wallet). When sending from the main wallet (`senderSubAccountId` is undefined), no `allowP2pSend` check occurs. This is technically correct since the main wallet has no Account Type and is always unrestricted, but it means:

- There is no mechanism to disable P2P sends from the main wallet
- If a future requirement needs main wallet P2P restrictions, there's no infrastructure for it

**Impact:** None currently. The main wallet is designed to be unrestricted. This is a design note, not a bug.

---

### 5.4 `transferBetweenWallets` Does Not Check Destination Rules (MEDIUM)

**Severity:** MEDIUM

**Description:** When a user transfers tokens between their own wallets (e.g., main → brand, brand → brand), the code validates `p2p_send` on the source wallet but does **not** validate any rules on the destination:

- **Main → Brand:** Credits destination without checking `allowP2pReceive`
- **Brand → Brand:** Only validates source's `allowP2pSend`, not destination's `allowP2pReceive`
- **Brand → Main:** Only validates source's `allowP2pSend` (main wallet has no restrictions, so this is fine)

**Impact:** A user could move tokens into a brand wallet that has `allowP2pReceive: false`, bypassing the receive restriction. However, since this is the user's own wallet (not an external send), this may be intentional.

**Consideration:** Whether own-wallet transfers should respect `allowP2pReceive` is a product decision. If receive-disabled wallets should only accept tokens from brand earn activities, then destination validation is needed.

---

### 5.5 No Rule Propagation to Existing Sub-Accounts on Rule Change (LOW)

**Severity:** LOW

**Description:** When an admin updates an Account Type's rules via `adminUpdateAccountType`, the changes take effect immediately for all **future** operations. However:

- No notification is sent to connected Flutter clients to refresh their cached sub-account data
- The Flutter client caches sub-account rules from `getSubAccounts` in BLoC state
- Until the user refreshes their wallet view, the UI may show stale rule states (e.g., showing a Send button for a wallet that just had `allowP2pSend` disabled)

**Impact:** Brief window where client UI doesn't reflect updated rules. Server-side enforcement still applies correctly, so the user would get an error if they try a now-disallowed action.

**Mitigation:** Rules are re-fetched on every app foreground event and wallet screen visit. The staleness window is typically seconds to minutes.

---

### 5.6 `sendConversationTokens` Does Not Pre-Validate `allowP2pSend` (LOW)

**Severity:** LOW

**Description:** The `sendConversationTokens` CF validates auth, conversation membership, and balance — but does **not** call `validateSubAccountAllows(accountTypeId, "p2p_send")` before calling `processP2PTransfer`.

**Impact:** None in practice. `processP2PTransfer` performs this check internally (line 629). The transfer will still be rejected if `allowP2pSend` is false. However, the error message comes from the ledger layer rather than the CF layer, which may provide a less user-friendly error.

**Consideration:** Adding the pre-check would provide a better error message at the CF level, consistent with `sendP2PTransfer` in `wallet.ts` which does pre-check.

---

### 5.7 ~~No Purchase UI Enforcement of `allowedOfframps`~~ — ALREADY RESOLVED

**Severity:** LOW — **NO FIX NEEDED**

**Resolution:** Upon deeper investigation, `buy_wallet_selection_screen.dart` (lines 273-278) already filters wallets using `sa.allowsPurchaseCategory(purchaseCategory)`. Server also validates via `validatePurchaseAllowed()`. Main wallet handles all categories. This gap was a false positive in the original audit.

---

### 5.8 Denormalization Consistency for `activeAccountTypeIds` (LOW)

**Severity:** LOW

**Description:** The `activeAccountTypeIds` array on user documents is maintained at three lifecycle points:
1. `getOrCreateBrandSubAccount` — adds via `arrayUnion`
2. `deactivateSubAccount` — removes via `arrayRemove` if no other active sub-accounts of same type
3. `deleteAllSubAccounts` — deletes the field entirely

However:
- If a sub-account is deleted directly (not through `deactivateSubAccount` or `deleteAllSubAccounts`), the array won't be updated
- If Firestore operations fail partially (write to sub-account succeeds but user doc update fails), the array could drift

**Impact:** Contact search filtering could show/hide users incorrectly. Over time, `activeAccountTypeIds` could become stale.

**Mitigation:** The `backfillActiveAccountTypeIds` admin function can re-sync the array at any time. Server-side transfer enforcement doesn't rely on this array (it checks actual sub-accounts).

---

## 6. Architectural Notes and Advice

### 6.1 Rule Lookup Architecture

Rules are **not** stored on sub-account documents. They are always fetched from the `accountTypes` collection at operation time. This means:

**Advantages:**
- Rule changes propagate immediately to all future operations
- No need to update thousands of sub-account documents when a rule changes
- Single source of truth

**Trade-offs:**
- Every operation requires an extra Firestore read to fetch rules
- No caching layer — each CF invocation re-fetches rules
- Consider adding a server-side cache (e.g., in-memory LRU with short TTL) for high-throughput operations

### 6.2 Rule Defaults Are Permissive

All boolean rules default to **allowing** the operation. Only `p2pRestrictToSameAccountType` defaults to `false` (which means "allow P2P with anyone"). This design means:

- If rules are accidentally omitted, the account type behaves like the main wallet (fully permissive)
- An admin must explicitly disable operations
- This is the safer default for user experience but requires admins to be intentional about restrictions

### 6.3 `isRestricted` Is a Derived Property

`isRestricted` is computed as `!rules.allowedOfframps.includes("*")`. It indicates whether the wallet has restricted purchase categories. In the Flutter entity, it's computed as `accountTypeId != null` (any brand wallet is considered restricted). These are subtly different definitions:

- **Backend:** `isRestricted` = has restricted offramps (a wallet with an `accountTypeId` but `allowedOfframps: ["*"]` would NOT be restricted)
- **Flutter:** `isRestricted` = has an `accountTypeId` (any brand wallet is considered restricted regardless of offramp rules)

The Flutter definition is more conservative and used primarily for UI styling and button visibility.

### 6.4 Security Model

The rules infrastructure follows a **defense-in-depth** pattern:

1. **UI Layer:** Convenience filtering. Bypassable with a modified client. Never trust alone.
2. **CF Layer:** Input validation and early error reporting. Provides user-friendly error messages.
3. **Ledger Layer:** Atomic enforcement within Firestore transactions. Cannot be bypassed.

**Recommendation:** Any new rule should be enforced at minimum at the ledger layer. CF and UI layers are for UX improvement only.

### 6.5 Idempotency

All ledger operations use idempotency keys:
- P2P transfers: `p2p:{transferId}`
- Cashouts: `cashout_init:{cashoutId}`
- Purchases: `purchase:{purchaseId}`

This ensures that retried requests (due to network issues) don't double-process. The idempotency check happens inside the Firestore transaction, before any balance changes.

### 6.6 Audit Trail

All rule-governed operations create journal entries in the ledger system. Each journal records:
- Who initiated the operation
- What accounts were debited/credited
- The amounts
- The account type and sub-account involved
- Metadata (message, reference, etc.)
- Timestamp

Admin operations (account type CRUD) are logged via `logAdminAction()` for compliance.

---

## 7. Quick Reference Tables

### 7.1 Rule Enforcement Matrix

| Rule | Flutter UI | Cloud Function | Ledger | Status |
|------|-----------|---------------|--------|--------|
| `allowP2pSend` | Hide Send button, filter wallet picker | Validate in `sendP2PTransfer`, `transferBetweenWallets` | Validate in `processP2PTransfer` | FULLY ENFORCED |
| `allowP2pReceive` | Hide Request button, filter wallet picker | **NOT CHECKED** | **NOT CHECKED** | **UI-ONLY** |
| `allowCashout` | Hide Cash Out button | Validate in `processCashout` | Validate in `initiateCashout` | FULLY ENFORCED |
| `p2pRestrictToSameAccountType` | Filter contact search | `acceptConversationTokenRequest` checks match | `processP2PTransfer` auto-routes or rejects | FULLY ENFORCED |
| `allowedOfframps` | **NOT FILTERED** (method exists but unused) | Validate in `processPurchase` | Validate in `processPurchaseTransaction` | SERVER-ONLY |
| `expiryDays` | **NOT SHOWN** | **NOT ENFORCED** | **NOT ENFORCED** | **NOT IMPLEMENTED** |

### 7.2 Transfer Flow Validation Summary

| Flow | Auth | Balance | `p2p_send` | `p2p_receive` | `p2pRestrict` | Notes |
|------|------|---------|-----------|--------------|---------------|-------|
| Wallet Send (`sendP2PTransfer`) | Yes | CF + Ledger | CF + Ledger | **NO** | Ledger | |
| Conversation Send (`sendConversationTokens`) | Yes + AppCheck | CF | Ledger only | **NO** | Ledger | Missing CF pre-check for p2p_send |
| Accept Request (`acceptConversationTokenRequest`) | Yes + AppCheck | CF | Ledger only | **NO** | CF + Ledger | |
| Internal Transfer (`transferBetweenWallets`) | Yes | CF | CF (source) | **NO** | N/A | No destination rule check |
| Purchase (`processPurchase`) | Yes | CF | N/A | N/A | N/A | Checks `allowedOfframps` |
| Cashout (`processCashout`) | Yes | CF + Ledger | N/A | N/A | N/A | Checks `allowCashout` |

### 7.3 Error Code Quick Reference

| Error Code | Meaning | Returned by |
|------------|---------|-------------|
| `SUB_ACCOUNT_NOT_FOUND` | Sub-account doesn't exist | Ledger |
| `ACCOUNT_TYPE_NOT_FOUND` | Account type doesn't exist | `getOrCreateBrandSubAccount` |
| `OPERATION_NOT_ALLOWED` | Generic rule violation | `validateSubAccountAllows` |
| `INSUFFICIENT_SUB_ACCOUNT_BALANCE` | Sub-account balance too low | Ledger |
| `SUB_ACCOUNT_INACTIVE` | Sub-account deactivated | Ledger |
| `OFFRAMP_NOT_ALLOWED` | Purchase category restricted | `validatePurchaseAllowed` |
| `P2P_SEND_NOT_ALLOWED` | `allowP2pSend` is false | `processP2PTransfer` |
| `RECIPIENT_MISSING_MATCHING_ACCOUNT` | Recipient has no matching brand wallet | `processP2PTransfer` |
| `INSUFFICIENT_BALANCE` | Main wallet balance too low | Ledger |
| `TRANSACTION_FAILED` | Firestore transaction failed | Ledger |

---

## 8. File Reference Map

### 8.1 Backend (Cloud Functions / TypeScript)

| File | Rules-Related Content |
|------|----------------------|
| `functions/src/ledger/types.ts` | `AccountTypeRules` interface, `SubAccountTypeDefinition`, `SubAccountConfig`, `SubAccountErrorCodes`, `SubAccountOperation` type |
| `functions/src/ledger/subAccounts.ts` | `getOrCreateBrandSubAccount`, `validateSubAccountAllows`, `validatePurchaseAllowed`, `getAccountTypeRules`, `deactivateSubAccount`, `deleteAllSubAccounts`, `creditSubAccount`, `debitSubAccount` |
| `functions/src/ledger/index.ts` | `processP2PTransfer` (main enforcement), `initiateCashout`, `processPurchaseTransaction` |
| `functions/src/wallet.ts` | `sendP2PTransfer`, `processCashout`, `transferBetweenWallets`, `getSubAccounts` (enriches with rules) |
| `functions/src/conversationTokens.ts` | `sendConversationTokens`, `requestConversationTokens`, `acceptConversationTokenRequest`, `declineConversationTokenRequest` |
| `functions/src/purchases.ts` | `processPurchase` (validates `allowedOfframps`) |
| `functions/src/adminAccounts.ts` | `adminCreateAccountType`, `adminUpdateAccountType`, `adminDeactivateAccountType`, `adminListAccountTypes`, `adminGetAccountType`, `adminCreateClientSubAccount`, `adminFundClientSubAccount`, `backfillActiveAccountTypeIds` |
| `functions/src/earnAdmin.ts` | Inline account type creation in `createEarnThread` |
| `functions/src/contacts.ts` | `searchUsers` — `accountTypeId` filter for `p2pRestrictToSameAccountType` |
| `firestore.indexes.json` | Composite index: `users` → `activeAccountTypeIds` (CONTAINS) + `displayNameLower` (ASC) |

### 8.2 Flutter (Dart)

| File | Rules-Related Content |
|------|----------------------|
| `lib/domain/entities/sub_account.dart` | Entity with `allowP2pSend`, `allowP2pReceive`, `allowCashout`, `p2pRestrictToSameAccountType`, `allowedOfframps`, `isRestricted`, `allowsPurchaseCategory()` |
| `lib/data/models/sub_account_model.dart` | Model with JSON serialization for all rule fields |
| `lib/presentation/screens/wallet/wallet_detail_screen.dart` | Button visibility based on rules, Send/Request/Cashout actions |
| `lib/presentation/screens/wallet/wallet_send_screen.dart` | Contact filter via `_filterAccountTypeId` |
| `lib/presentation/widgets/messaging/token_actions_sheet.dart` | Contact filter, wallet picker filter, info banner for restrictions |
| `lib/presentation/widgets/messaging/wallet_picker.dart` | Eligible wallet filtering by `allowP2pSend`/`allowP2pReceive`, lock icon for `p2pRestrictToSameAccountType` |
| `lib/presentation/blocs/wallet/wallet_bloc.dart` | Wallet state management, sub-account loading |
| `lib/presentation/blocs/user_search/user_search_bloc.dart` | Passes `accountTypeId` to `searchUsers` CF |
| `lib/presentation/admin/screens/account_type_management_screen.dart` | Full admin CRUD UI for Account Types |
| `lib/presentation/admin/screens/accounts_action_screen.dart` | Fund client / fund sub-account admin actions |

### 8.3 Flag Cross-Reference — Every File Where Each Flag Is Used

#### `allowP2pSend`
- `functions/src/ledger/types.ts` — interface definition
- `functions/src/ledger/subAccounts.ts` — `validateSubAccountAllows` case `"p2p_send"`
- `functions/src/ledger/index.ts` — checked in `processP2PTransfer`
- `functions/src/wallet.ts` — pre-checked in `sendP2PTransfer`, `transferBetweenWallets`; enriched in `getSubAccounts`
- `functions/src/adminAccounts.ts` — rules validation in `adminCreateAccountType`
- `functions/src/earnAdmin.ts` — inline rules validation
- `lib/domain/entities/sub_account.dart` — entity field
- `lib/data/models/sub_account_model.dart` — model field
- `lib/presentation/screens/wallet/wallet_detail_screen.dart` — Send button visibility
- `lib/presentation/widgets/messaging/wallet_picker.dart` — eligibility filter (send mode)
- `lib/presentation/widgets/messaging/token_actions_sheet.dart` — wallet filter
- `lib/presentation/admin/screens/account_type_management_screen.dart` — admin toggle

#### `allowP2pReceive`
- `functions/src/ledger/types.ts` — interface definition
- `functions/src/ledger/subAccounts.ts` — `validateSubAccountAllows` case `"p2p_receive"` (EXISTS but NEVER CALLED)
- `functions/src/wallet.ts` — enriched in `getSubAccounts` (BUT never validated)
- `functions/src/adminAccounts.ts` — rules validation
- `functions/src/earnAdmin.ts` — inline rules validation
- `lib/domain/entities/sub_account.dart` — entity field
- `lib/data/models/sub_account_model.dart` — model field
- `lib/presentation/screens/wallet/wallet_detail_screen.dart` — Request button visibility
- `lib/presentation/widgets/messaging/wallet_picker.dart` — eligibility filter (request mode)
- `lib/presentation/widgets/messaging/token_actions_sheet.dart` — wallet filter
- `lib/presentation/admin/screens/account_type_management_screen.dart` — admin toggle

#### `allowCashout`
- `functions/src/ledger/types.ts` — interface definition
- `functions/src/ledger/subAccounts.ts` — `validateSubAccountAllows` case `"cashout"`
- `functions/src/wallet.ts` — pre-checked in `processCashout`; enriched in `getSubAccounts`
- `functions/src/adminAccounts.ts` — rules validation
- `functions/src/earnAdmin.ts` — inline rules validation
- `lib/domain/entities/sub_account.dart` — entity field
- `lib/data/models/sub_account_model.dart` — model field
- `lib/presentation/screens/wallet/wallet_detail_screen.dart` — Cash Out button visibility
- `lib/presentation/admin/screens/account_type_management_screen.dart` — admin toggle

#### `p2pRestrictToSameAccountType`
- `functions/src/ledger/types.ts` — interface definition
- `functions/src/ledger/index.ts` — enforced in `processP2PTransfer`
- `functions/src/wallet.ts` — enriched in `getSubAccounts`
- `functions/src/contacts.ts` — `searchUsers` filtering
- `functions/src/adminAccounts.ts` — rules validation
- `functions/src/earnAdmin.ts` — inline rules validation
- `lib/domain/entities/sub_account.dart` — entity field
- `lib/data/models/sub_account_model.dart` — model field
- `lib/presentation/screens/wallet/wallet_send_screen.dart` — `_filterAccountTypeId` computation
- `lib/presentation/widgets/messaging/token_actions_sheet.dart` — `_filterAccountTypeId` computation
- `lib/presentation/widgets/messaging/wallet_picker.dart` — lock icon display
- `lib/presentation/admin/screens/account_type_management_screen.dart` — admin toggle

#### `allowedOfframps`
- `functions/src/ledger/types.ts` — interface definition
- `functions/src/ledger/subAccounts.ts` — `validatePurchaseAllowed`
- `functions/src/purchases.ts` — purchase validation
- `functions/src/wallet.ts` — enriched in `getSubAccounts`
- `functions/src/adminAccounts.ts` — rules validation; `isRestricted` computation
- `functions/src/earnAdmin.ts` — inline rules validation
- `lib/domain/entities/sub_account.dart` — entity field + `allowsPurchaseCategory()` method
- `lib/data/models/sub_account_model.dart` — model field
- `lib/presentation/admin/screens/account_type_management_screen.dart` — admin input

#### `expiryDays`
- `functions/src/ledger/types.ts` — interface definition
- `functions/src/ledger/subAccounts.ts` — default value (`null`)
- `functions/src/adminAccounts.ts` — rules validation, stored in Firestore
- `functions/src/earnAdmin.ts` — inline rules validation
- `lib/presentation/admin/screens/account_type_management_screen.dart` — admin input + table display
- **NOT enforced anywhere** — no scheduled function, no at-operation check

---

*End of document.*
