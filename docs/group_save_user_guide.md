# iMaliChat Group Save — Complete User Guide

> **Version**: 2.0
> **Last updated**: 2026-03-18
> **Audience**: Product team, QA, support staff, and stakeholders

---

## Table of Contents

1. [Overview](#1-overview)
2. [Group Save (Chat Tab — Collection Room)](#2-group-save-chat-tab--collection-room)
   - 2.1 [Concept](#21-concept)
   - 2.2 [How to Access](#22-how-to-access)
   - 2.3 [Roles](#23-roles)
   - 2.4 [Creating a Group Save](#24-creating-a-group-save)
   - 2.5 [The Collection Room](#25-the-collection-room)
   - 2.6 [Contributing Tokens](#26-contributing-tokens)
   - 2.7 [Distributing Tokens](#27-distributing-tokens)
   - 2.8 [Withdrawing Tokens](#28-withdrawing-tokens)
   - 2.9 [Cancelling a Collection](#29-cancelling-a-collection)
   - 2.10 [Pool Lifecycle & Statuses](#210-pool-lifecycle--statuses)
   - 2.11 [Expiry](#211-expiry)
   - 2.12 [Notifications](#212-notifications)
   - 2.13 [Rules & Limits](#213-rules--limits)
   - 2.14 [Ledger & Money Flow](#214-ledger--money-flow)
3. [Group Sasaza (Comparison)](#3-group-sasaza-comparison)
4. [Gooi-Gooi Rotating Savings](#4-gooi-gooi-rotating-savings)
   - 4.1 [Concept](#41-concept)
   - 4.2 [Roles](#42-roles)
   - 4.3 [Group Lifecycle](#43-group-lifecycle)
   - 4.4 [Forming Phase](#44-forming-phase)
   - 4.5 [Roster Setup & Methods](#45-roster-setup--methods)
   - 4.6 [Activation](#46-activation)
   - 4.7 [Contribution Cycle](#47-contribution-cycle)
   - 4.8 [Grace Period & Late Fees](#48-grace-period--late-fees)
   - 4.9 [Payout Processing](#49-payout-processing)
   - 4.10 [Auto-Contribute](#410-auto-contribute)
   - 4.11 [Trigger Delegation](#411-trigger-delegation)
   - 4.12 [Grace Period Extensions](#412-grace-period-extensions)
   - 4.13 [Defaults, Debts & Penalties](#413-defaults-debts--penalties)
   - 4.14 [Group Completion](#414-group-completion)
   - 4.15 [Dissolution](#415-dissolution)
   - 4.16 [Configuration & Limits](#416-configuration--limits)
   - 4.17 [Reserve Fund](#417-reserve-fund)
   - 4.18 [Bidding Roster Method (Advanced)](#418-bidding-roster-method-advanced)
5. [Legacy Group Save (Stokvels)](#5-legacy-group-save-stokvels)
6. [Pot Pools (Daily & Weekly Draws)](#6-pot-pools-daily--weekly-draws)
7. [Group Buy — Hlangana](#7-group-buy--hlangana)
8. [Complete Rules Reference](#8-complete-rules-reference)
9. [Glossary](#9-glossary)

---

## 1. Overview

iMaliChat's **Group Save** ecosystem gives users multiple ways to pool funds, save collectively, and unlock financial benefits through group participation. The system is built on a **double-entry ledger** that guarantees every token movement is fully auditable and balanced.

**Token economics reminder**: 100 tokens = R1 ZAR. All amounts in this guide are in tokens unless stated otherwise.

There are four distinct systems under the Group Save umbrella:

| System | Purpose | Entry Point | Status |
|--------|---------|-------------|--------|
| **Group Save (Collection Room)** | Chat-integrated group savings pool | Chat tab → "Group Save" button | **Active — Primary** |
| **Gooi-Gooi** | Rotating savings circles (formal stokvel) | Chat tab → "Gooi-Gooi" button | Active |
| **Pot Pools** | Daily & weekly prize draws from engagement earnings | Automatic | Active |
| **Group Buy (Hlangana)** | Collective purchasing for group discounts | Buy tab | Active |
| **Legacy Groups** | Traditional stokvels, family, club, org savings | Deprecated | Being replaced by Gooi-Gooi |

### Quick Comparison: Group Save vs Gooi-Gooi

| Feature | Group Save (Collection Room) | Gooi-Gooi |
|---------|------------------------------|-----------|
| **Purpose** | Flexible group savings toward a shared goal | Formal rotating savings with fixed payouts |
| **Contribution** | Variable amounts, any time | Fixed amount, per cycle |
| **Members** | 1–50 invitees + organizer | 2–12 members |
| **Cycles** | Open-ended (keep pool open for multiple rounds) | 1–12 fixed cycles |
| **Payout** | Organizer distributes manually (flexible split) | Automatic rotation — one member receives the pot per cycle |
| **Withdrawals** | Members can withdraw their own contributions | Not allowed mid-cycle |
| **Formality** | Casual, chat-integrated | Structured, rule-enforced |
| **Chat** | Built-in conversation room | Linked conversation |

---

## 2. Group Save (Chat Tab — Collection Room)

### 2.1 Concept

Group Save is a **casual, chat-integrated savings pool** built directly into the messaging experience. An organizer creates a Collection Room with a savings goal, invites friends or family, and everyone contributes tokens at their own pace. When the organizer is ready, they distribute the pooled tokens among participants — either equally or in custom amounts.

Think of it as a **digital money jar** that lives inside a group chat. Everyone can see who contributed, how much has been collected, and chat about the savings goal — all in one place.

**Key characteristics**:
- **Flexible contributions** — members contribute any amount (10–100,000 tokens), any number of times
- **No fixed schedule** — contribute when you can, no deadlines or penalties
- **Organizer-controlled distribution** — the organizer decides when and how to distribute
- **Built-in chat** — the Collection Room IS a conversation, with a progress card at the top
- **Withdrawal option** — non-organizer members can withdraw their own contributions at any time
- **Multi-round support** — after distributing, the organizer can keep the pool open for a next round

### 2.2 How to Access

1. Open the **Chat tab** (third tab in the bottom navigation)
2. Look at the **Quick Action Strip** below the tab bar (collapses on scroll, reappears on scroll up)
3. Tap the **"Group Save"** button (styled in secondary colour with a group icon)
4. This navigates to the Create Group Save screen

The Quick Action Strip also shows:
- **Sasaza** — Group gift (gold)
- **Gooi-Gooi** — Rotating savings (teal)
- **Send/Request Tokens** — Direct token transfer (accent)

### 2.3 Roles

Group Save has only **two roles**:

#### Organizer
The user who creates the Collection Room. They have full control:

| Responsibility | Details |
|---------------|---------|
| Create the pool | Set title, purpose, message; invite participants |
| Contribute | Add tokens like any member |
| Distribute tokens | Decide when to distribute and how much each participant gets |
| Keep pool open | After distributing, can choose to keep the pool open for another round |
| Cancel collection | Cancel the pool entirely, triggering automatic pro-rata refunds |

The organizer is identified by the `organizerId` field on the pool. **Only one organizer per pool** — this cannot be transferred.

#### Participant (Invitee)
Anyone invited by the organizer:

| Responsibility | Details |
|---------------|---------|
| Contribute | Add tokens to the pool |
| Chat | Send messages in the Collection Room conversation |
| Withdraw | Pull back up to their own contribution total at any time |

Participants **cannot** distribute, cancel, or manage the pool in any way.

### 2.4 Creating a Group Save

When the user taps "Group Save" on the Chat tab, they see the **Create Group Save** form:

#### Required Fields

| Field | Description | Constraints |
|-------|-------------|-------------|
| **Title** | Name for the savings pool | 1–100 characters, required |
| **Purpose** | What the savings goal is (e.g., "Save for holiday") | 1–200 characters, required (Group Save only — not shown for Sasaza) |
| **Invitees** | People to invite to contribute | At least 1 person, maximum 50 |

#### Optional Fields

| Field | Description | Constraints |
|-------|-------------|-------------|
| **Message** | Personal note shown in the collection room | 0–200 characters |

#### Invitee Selection
- Tap "Add" next to Invitees to open the **contact picker**
- Select one or more contacts
- Selected contacts appear as **dismissible chips** (tap ✕ to remove)
- The organizer is automatically excluded from the invitee list (they're already a participant)
- Duplicate contacts are silently ignored

#### What Happens on Submit
1. The system validates all fields
2. A **group ledger account** is created (`group:{poolId}`) to hold pooled funds in escrow
3. A **TokenPool document** is created in Firestore with status `collecting`
4. A **conversation** is created (type: `collection`) with all participants auto-accepted
5. A **system message** is posted: "{OrganizerName} started a Group Save: {Purpose}"
6. **FCM push notifications** are sent to all invitees: "Group Save invitation — {OrganizerName} invited you to contribute"
7. The organizer is navigated to the new **Collection Room**

### 2.5 The Collection Room

The Collection Room is the main screen for an active Group Save pool. It combines a **progress card** at the top with a **chat conversation** below.

#### Pool Progress Card (Top)
Displays:
- **Mode badge**: "Group Save"
- **Title**: The pool name
- **Purpose**: The savings goal description
- **Total tokens collected**: Running total with token gold icon
- **Contributor count**: How many unique people have contributed
- **Distribution history**: If tokens have been distributed, shows "X distributed / Y available"
- **Payout breakdown**: After distribution, shows who received how much

#### Action Buttons (shown dynamically based on role and pool status)

| Button | Who sees it | When shown | What it does |
|--------|------------|------------|--------------|
| **Contribute** | All participants (organizer + invitees) | Pool is `collecting` | Opens contribute bottom sheet |
| **Distribute** | Organizer only | Pool is `collecting` AND has available balance > 0 | Opens distribute bottom sheet |
| **Withdraw** | Non-organizer participants who have contributed | Pool is `collecting` | Opens withdrawal bottom sheet |
| **Cancel Collection** | Organizer only | Pool is `collecting` | Shows in the app bar ⋮ menu, triggers confirmation dialog |

#### Chat Area (Bottom)
- Standard message list with message bubbles
- Message input bar (only shown while pool is `collecting`)
- System messages appear for contributions, withdrawals, distributions, and cancellations

#### Terminal Status Banners
When the pool reaches a terminal state, the action buttons are replaced by a status banner:
- **Distributed** (green, checkmark) — Pool fully distributed
- **Cancelled — Refunded** (red, cancel icon) — Organizer cancelled, contributions refunded
- **Expired** (grey, timer-off icon) — Pool expired without action

### 2.6 Contributing Tokens

When a participant taps **Contribute**, a bottom sheet appears:

#### Contribute Sheet
- **Available balance** displayed at the top (from user's main wallet)
- **Amount input** — numeric field, digits only
- **Quick amount chips**: 50, 100, 200, 500 tokens (tap to auto-fill)
- **Anonymous toggle** — *Only shown for Sasaza mode, NOT for Group Save*
- **Contribute button** — enabled when amount ≥ 10 tokens

#### Validation Rules
| Rule | Value |
|------|-------|
| Minimum contribution | 10 tokens (R0.10) |
| Maximum contribution | 100,000 tokens (R1,000) |
| Balance check | Must have sufficient wallet balance |
| Participant check | Must be organizer or invitee |
| Status check | Pool must be in `collecting` status |

#### What Happens on Contribute
1. **Balance pre-check**: System validates the user has enough tokens in their main wallet
2. **Firestore transaction**: Pool counters updated atomically (totalAmount, contributionCount, contributorCount, per-user contribution record)
3. **Ledger operation**: `processGroupContribution` moves tokens from user's wallet to the group account (`group:{poolId}`)
4. **Rollback safety**: If the ledger operation fails, pool counters are automatically rolled back
5. **System message** posted: "{Name} contributed {amount} tokens"
6. **FCM notification** sent to the organizer (if a non-organizer contributed)

#### Multiple Contributions
- Users can contribute **multiple times**
- Each contribution is tracked with:
  - `totalAmount`: Running total for that user
  - `contributionCount`: Number of separate contributions
  - `lastContributedAt`: Timestamp of most recent contribution

### 2.7 Distributing Tokens

When the organizer taps **Distribute**, a bottom sheet appears:

#### Distribute Sheet
- **Participant list**: All participants (organizer + invitees) shown with avatar and name
- **Amount input per participant**: Each has a numeric field to specify their share
- **Equal Split button**: Automatically divides the available balance equally among all participants (handles remainders by giving 1 extra token to the first N participants)
- **Running total indicator**: Shows "{allocated} / {available} available" with color coding:
  - Green (checkmark): Valid allocation (> 0 and ≤ available)
  - Orange (info): No allocation yet
  - Red (info): Over-allocated
- **"Keep pool open for next round" toggle**: Only appears when distributing the **full** available balance
  - If checked: Pool stays in `collecting` status after distribution — accepts more contributions for a new round
  - If unchecked: Pool transitions to `completed` — no further activity
- **Confirm button**: "Distribute & Close" (full distribution, not keeping open) or "Distribute" (partial or keeping open)

#### Distribution Rules
| Rule | Value |
|------|-------|
| Who can distribute | Organizer only |
| Minimum allocation | At least 1 token total (across all participants) |
| Maximum allocation | Cannot exceed available balance (total − already distributed) |
| Recipients | Must be pool participants (organizer or invitees) |
| Zero allocations | Participants with 0 tokens are skipped (not included in payout) |

#### Partial vs Full Distribution
- **Partial distribution**: Allocated amount < available balance. Pool stays in `collecting` status. More contributions can come in, and the organizer can distribute again later.
- **Full distribution (keep open)**: Allocated amount = available balance, toggle checked. All current funds are distributed, but pool stays open for the next round.
- **Full distribution (close)**: Allocated amount = available balance, toggle unchecked. Pool transitions to `completed`. No further activity.

#### What Happens on Distribute
1. **Firestore transaction**: Validates organizer, mode (save), status (collecting), payout sum ≤ available balance. Updates `payouts` array, `totalDistributed`, and optionally `status` and `completedAt`.
2. **Ledger operation**: `processGroupPayout` moves tokens from group account to each recipient's wallet. Uses deterministic transaction ID for idempotency.
3. **Rollback safety**: If ledger fails, Firestore changes are rolled back (status, payouts, totalDistributed).
4. **System message**: "Pool distributed! {Name}: {amount} tokens, {Name}: {amount} tokens..." or "Partial distribution: ..."
5. **FCM notifications**: Sent to all participants (except organizer).

#### Distribution History
After any distribution, the **Payout Breakdown** section appears in the progress card, showing each recipient with their avatar, name, and amount received — sorted by amount descending.

### 2.8 Withdrawing Tokens

Non-organizer participants who have contributed can request a withdrawal at any time.

#### Withdrawal Sheet
- **"Your contribution: {amount} tokens"** displayed at top
- **Amount input** — numeric field
- **Quick amount chips**: Dynamically generated based on user's contribution total:
  - 50 (if contribution ≥ 50)
  - 100 (if contribution ≥ 100)
  - 200 (if contribution ≥ 200)
  - "All ({total})" — always shown as last chip
- **Withdraw button** — enabled when amount > 0 and ≤ contribution total

#### Withdrawal Rules
| Rule | Value |
|------|-------|
| Who can withdraw | Any participant who has contributed (including organizer — though the UI only shows the withdraw button for non-organizers) |
| Maximum amount | The user's own contribution total (cannot withdraw more than they put in) |
| Available balance check | Pool must have sufficient available balance (total − already distributed) |
| Minimum amount | 1 token |
| Auto-approved | Yes — withdrawals are automatically approved, no organizer approval needed |

#### What Happens on Withdraw
1. **Firestore transaction**: Validates the user is a participant, pool is `save` mode and `collecting`, withdrawal ≤ user's contribution, withdrawal ≤ available balance. Updates user's `contributions.totalAmount`, pool `totalAmount`, and `contributorCount` (decremented if contribution reaches 0).
2. **Ledger operation**: `processGroupWithdrawal` moves tokens from group account back to user's wallet. Deterministic transaction ID for idempotency.
3. **Rollback safety**: If ledger fails, pool counters are rolled back.
4. **System message**: "{Name} withdrew {amount} tokens"
5. **FCM notification**: Sent to the organizer (if the withdrawer isn't the organizer).

### 2.9 Cancelling a Collection

The organizer can cancel the pool at any time while it's in `collecting` status.

#### Cancellation Flow
1. Organizer taps the **⋮ menu** in the app bar → **"Cancel Collection"**
2. A **confirmation dialog** appears:
   - If contributions exist: "All {totalAmount} tokens will be refunded to contributors."
   - If no contributions: "This collection room will be closed."
3. On confirm:

#### What Happens on Cancel
1. **Firestore transaction**: Validates organizer, status is `collecting`. Sets status to `cancelled`, records `cancelledAt`.
2. **Refund calculation**: Remaining balance = totalAmount − totalDistributed
   - If remaining > 0: **Pro-rata refunds** calculated for each contributor
   - Each contributor gets: `floor(theirContribution / totalContributed × remainingBalance)`
   - Any rounding residual (1-2 tokens) goes to the first contributor
   - If remaining = 0 (all previously distributed): No refund needed
3. **Ledger operation**: `processGroupPayout` refunds tokens from group account to each contributor's wallet.
4. **Rollback safety**: If refund ledger operation fails, pool status is rolled back to `collecting`.
5. **System message**: "Collection cancelled. {X} tokens refunded." or "Collection cancelled. No refund needed (all tokens were already distributed)."
6. **FCM notifications**: Sent to all invitees.

### 2.10 Pool Lifecycle & Statuses

```
                         ┌─────────────┐
                 ┌──────→│  COMPLETED  │
                 │       └─────────────┘
┌────────────┐   │           (organizer distributes full amount, keep-open unchecked)
│ COLLECTING │───┤
│            │───┤       ┌─────────────┐
└────────────┘   ├──────→│  CANCELLED  │
                 │       └─────────────┘
                 │           (organizer cancels → refunds)
                 │
                 └──────→┌─────────────┐
                         │   EXPIRED   │
                         └─────────────┘
                             (30-day Sasaza expiry — Group Save has NO expiry)
```

| Status | Meaning | Terminal? |
|--------|---------|-----------|
| `collecting` | Active, accepting contributions. Actions available: contribute, distribute, withdraw, cancel | No |
| `completed` | Fully distributed (and pool not kept open). No further actions possible. | Yes |
| `cancelled` | Organizer cancelled. All remaining contributions refunded pro-rata. | Yes |
| `expired` | Expiry date passed (Sasaza only — Group Save pools have **no expiry**). Remaining contributions refunded. | Yes |
| `sent` | Sasaza-only status (gift sent to recipient, awaiting claim). Not applicable to Group Save. | No |

**Important**: Group Save pools do **not** have an expiry date. They remain in `collecting` status indefinitely until the organizer distributes or cancels. Only Sasaza (group gift) pools have a 30-day collection expiry.

### 2.11 Expiry

- **Group Save pools**: No expiry. They stay open forever until the organizer takes action.
- **Sasaza pools**: 30-day collection window. If the gift isn't sent within 30 days, the pool expires and contributions are refunded.
- **Sent Sasaza gifts**: 7-day claim window. If the recipient doesn't claim within 7 days, the gift expires (tokens were already transferred to the recipient during "send", so the status change is informational only).

A **scheduled Cloud Function** runs hourly to check for and process expired pools:
- `collecting` pools past expiry → refund remaining balance pro-rata → status `expired`
- `sent` pools past claim expiry → mark expired (no refund — tokens already with recipient)

### 2.12 Notifications

#### Push Notifications (FCM)

| Event | Recipients | Title | Body |
|-------|-----------|-------|------|
| Pool created | All invitees | "Group Save invitation" | "{Organizer} invited you to contribute" |
| Contribution received | Organizer (if contributor ≠ organizer) | "New contribution" | "{Name} contributed {amount} tokens" |
| Distribution | All invitees | "Pool distributed!" or "Partial distribution" | "{amount} tokens distributed" / "{amount} tokens distributed (pool remains open)" |
| Withdrawal | Organizer (if withdrawer ≠ organizer) | "Pool withdrawal" | "{Name} withdrew {amount} tokens" |
| Cancellation | All invitees | "Collection cancelled" | "The collection has been cancelled. {X} tokens refunded." |

#### System Messages (In-Chat)

| Event | Message |
|-------|---------|
| Pool created | "{Organizer} started a Group Save: {Purpose}" |
| Contribution | "{Name} contributed {amount} tokens" |
| Distribution | "Pool distributed! {Name}: {amount}, {Name}: {amount}..." |
| Partial distribution | "Partial distribution: {Name}: {amount}, ..." |
| Withdrawal | "{Name} withdrew {amount} tokens" |
| Cancellation | "Collection cancelled. {X} tokens refunded." |
| Expiry | "Collection expired. {X} tokens refunded." |

### 2.13 Rules & Limits

| Rule | Value | Enforcement |
|------|-------|-------------|
| Min contribution | 10 tokens (R0.10) | Hard — rejected by backend |
| Max contribution | 100,000 tokens (R1,000) | Hard — rejected by backend |
| Min invitees | 1 | Hard — validated on creation |
| Max invitees | 50 | Hard — validated on creation |
| Title length | 1–100 characters | Hard — validated on creation |
| Purpose length | 1–200 characters | Hard — required for Group Save |
| Message length | 0–200 characters | Soft — optional |
| Expiry (Group Save) | **None** | Pool stays open indefinitely |
| Expiry (Sasaza) | 30 days collection, 7 days gift claim | Hard — hourly scheduled check |
| Who can contribute | Organizer + invitees only | Hard — participant check |
| Who can distribute | Organizer only | Hard — permission check |
| Who can withdraw | Any participant with contributions > 0 | Hard — auto-approved up to their total |
| Who can cancel | Organizer only | Hard — permission check |
| Withdrawal limit | User's own contribution total | Hard — cannot withdraw more than contributed |
| Distribution limit | Available balance (total − distributed) | Hard — validated in transaction |
| Multiple contributions | Allowed | Tracked per-user with count + total |
| Multiple distributions | Allowed (partial distributions) | Each appended to payouts array |
| Idempotency | All ledger operations use deterministic transaction IDs | Prevents double-processing on retries |

### 2.14 Ledger & Money Flow

All token movements are recorded in the **double-entry ledger**. Every debit has a matching credit.

#### Account Structure
- **Group account**: `group:{poolId}` — holds all pooled tokens in escrow
- Created automatically when the pool is created via `getOrCreateGroupAccount(poolId)`

#### Contribution Flow
```
User's Main Wallet ──(amount)──→ Group Account (group:{poolId})
   [debit user]                     [credit group]
```

#### Distribution Flow
```
Group Account (group:{poolId}) ──(amount per recipient)──→ Each Recipient's Main Wallet
   [debit group]                                              [credit user]
```

#### Withdrawal Flow
```
Group Account (group:{poolId}) ──(amount)──→ User's Main Wallet
   [debit group]                                [credit user]
```

#### Cancellation/Refund Flow
```
Group Account (group:{poolId}) ──(pro-rata share)──→ Each Contributor's Main Wallet
   [debit group]                                        [credit user]
```

#### Idempotency Keys
| Operation | Key Format | Purpose |
|-----------|-----------|---------|
| Contribution | `{contributionId}` (unique per contribution) | Prevents double-charge |
| Distribution | `distribute_{poolId}_{payoutIndex}` | Prevents double-payout |
| Withdrawal | `withdraw_{poolId}_{userId}_{previousTotal}` | Prevents double-withdrawal |
| Cancellation | `cancel_{poolId}` | Prevents double-refund |
| Expiry | `expire_{poolId}` | Prevents double-expiry-refund |
| Send gift | `send_{poolId}` | Prevents double-send |

#### Rollback Safety
Every operation follows a **3-phase pattern**:
1. **Phase 1**: Firestore transaction — validate state and update pool document
2. **Phase 2**: Ledger operation — move tokens via double-entry journal
3. **Phase 3**: Side effects — system messages, FCM notifications (fire-and-forget)

If Phase 2 fails, Phase 1 changes are **rolled back** to their previous state. Phase 3 is fire-and-forget (non-blocking) to prevent double-charge scenarios if side effects fail after a successful ledger operation.

---

## 3. Group Sasaza (Comparison)

Group Sasaza shares the same **Collection Room** infrastructure as Group Save but serves a different purpose: **collecting a group gift for an external recipient**.

| Feature | Group Save | Group Sasaza |
|---------|-----------|--------------|
| **Purpose** | Group savings for participants | Group gift for someone outside the group |
| **Purpose field** | Required ("What is the savings goal?") | Not shown |
| **Style picker** | Not shown | Shown (ndlovukazi, celebration, love, birthday, professional) |
| **Recipient** | All participants share the pool | Single external recipient |
| **Recipient can be invitee** | N/A | No — recipient cannot be an invitee |
| **Recipient can be self** | N/A | No — cannot send a gift to yourself |
| **Anonymous contributions** | Not available | Available — hide your name from the recipient |
| **Distribution** | Organizer distributes to participants via "Distribute" | Organizer sends to recipient via "Send" |
| **Withdrawals** | Members can withdraw their contributions | Not available |
| **Keep pool open** | Yes — multi-round support | No — gift is one-time |
| **Expiry** | No expiry | 30-day collection, then 7-day gift claim |
| **Final action** | Distribute & Close | Send → recipient Opens → recipient Claims |

### Sasaza Gift Delivery
1. Organizer taps **"Send to {Recipient}"** → confirmation dialog
2. Tokens transfer from group account to recipient's wallet
3. A **groupGift message** is created in the organizer↔recipient P2P conversation
4. The message shows: gift style, amount, contributor names (unless anonymous), and a "claim" action
5. Recipient **opens** the gift (visual reveal) → then **claims** it (status → completed)
6. Contributors and organizer are notified when the gift is claimed

---

## 4. Gooi-Gooi Rotating Savings

### 4.1 Concept

Gooi-Gooi is a **formal rotating savings circle** — the digital equivalent of a traditional stokvel or chama. A small group of trusted members (2–12 people) agree to contribute a **fixed amount** each cycle. Each cycle, **one member receives the entire pot**. The order rotates through all members, so by the end everyone has both contributed to and received from the group equally.

**Example**: 6 members each contribute 2,000 tokens per month. Each month, one member receives ~12,000 tokens. After 6 months, every member has contributed 12,000 and received 12,000 — but each got access to a lump sum they wouldn't have had otherwise.

The system enforces fairness through:
- A **reserve fund** (3% of contributions) that covers shortfalls
- **Late fees** that discourage tardiness
- **Debt tracking** for defaulters
- **Audit logging** of every action

### 4.2 Roles

#### Initiator
The user who creates the group:

| Responsibility | Details |
|---------------|---------|
| Create the group | Set name, contribution amount, frequency, total cycles, roster method |
| Invite members | Send invitations (expire after 7 days) |
| Lock the roster | Finalize member order before activation |
| Activate the group | Transition from forming → active |
| Trigger payouts | Initiate the payout to the cycle's recipient |
| Extend grace period | Can unilaterally extend by up to 24 hours |
| Apply/waive late fees | Decide whether to enforce or forgive late fees |
| Dissolve the group | Can dissolve unilaterally during forming; requires vote during active |

The initiator is also a regular contributing member — they are not exempt.

#### Member
A regular participant:

| Responsibility | Details |
|---------------|---------|
| Accept/decline invitations | Must respond within 7 days |
| Contribute each cycle | Pay the fixed amount (+ 3% reserve) by the due date |
| Receive payout | Collect the pot when it's their turn |
| Vote on group matters | Grace extensions, mid-cycle withdrawals, dissolution |
| Set auto-contribute | Optionally enable automatic payments |
| Delegate trigger | Optionally delegate payout trigger rights |

#### Trigger Delegate
A temporary role assigned to another member:

| Responsibility | Details |
|---------------|---------|
| Trigger payouts | Can initiate the payout on behalf of the delegating member |
| Duration | Maximum 14 days per delegation |
| Scope | Payout trigger only — no other initiator powers |

### 4.3 Group Lifecycle

```
┌──────────┐     All members      ┌──────────┐     All cycles       ┌───────────┐
│ FORMING  │ ──── accepted ──────→│  ACTIVE  │ ──── completed ────→│ COMPLETED │
│          │     + roster locked   │          │                      │           │
└──────────┘                       └──────────┘                      └───────────┘
     │                                  │
     │ Initiator dissolves              │ Vote or initiator dissolves
     ▼                                  ▼
┌───────────┐                     ┌───────────┐
│ DISSOLVED │                     │ DISSOLVED │
└───────────┘                     └───────────┘
```

| Status | Meaning |
|--------|---------|
| `forming` | Group created, accepting member invitations, roster not yet locked |
| `active` | Roster locked, cycles are running |
| `completed` | All cycles finished successfully |
| `dissolved` | Group ended early |

### 4.4 Forming Phase

#### Step 1: Create the Group

| Field | Description | Constraints |
|-------|-------------|-------------|
| **Name** | Display name | Required |
| **Contribution Amount** | Fixed amount per cycle | 1,000–1,000,000 tokens (R10–R10,000) |
| **Cycle Frequency** | How often | `weekly` (7 days), `biweekly` (14 days), `monthly` (30 days) |
| **Total Cycles** | Number of rounds | 1–12 |
| **Roster Method** | How order is determined | `agreed`, `random`, `bidding` |
| **Grace Period** | Hours after due date | Default 48h, minimum 24h |
| **Late Fee %** | Penalty for late contributions | 0–10%, default 5% |
| **Recipient Contributes** | Whether the cycle's recipient must also contribute | Default: yes |

**Pre-creation validation**:
- User must have ≤ 3 active Gooi groups
- User must have no outstanding Gooi debts
- Contribution amount within 1,000–1,000,000 range

The initiator is automatically added as the first member.

#### Step 2: Invite Members
- Invitations expire after **7 days**
- Invitees see group details before deciding
- Can accept or decline

### 4.5 Roster Setup & Methods

#### Agreed Method
Members negotiate in the group chat, initiator locks the agreed order.

#### Random Method
System generates a **deterministic random order** using a seeded shuffle. Revealed when the initiator locks the roster.

#### Bidding Method
1. **48-hour bidding window** opens
2. Members bid for earlier positions by accepting a **smaller payout** (minimum 80% of pot)
3. Lower bid % = earlier position preference
4. Non-bidders are placed in remaining positions
5. Discounts go to the **bidding discount pool**, redistributed to later-position members

### 4.6 Activation

Requires:
1. All invited members have accepted (minimum 2 total)
2. Roster is locked
3. Initiator confirms activation

Upon activation:
- Chat conversation created/linked
- Cycle 1 opens immediately
- First member in roster order is the first recipient
- Due date = activation date + cycle frequency

### 4.7 Contribution Cycle

```
┌────────────┐    Due date      ┌──────────────┐   Grace close    ┌──────────────────┐
│ COLLECTING │ ───────────────→ │ GRACE PERIOD │ ──────────────→  │ AWAITING TRIGGER │
└────────────┘                  │  (48 hours)  │                  └──────────────────┘
                                └──────────────┘                         │
                                                               Manual or auto-trigger
                                                                         ▼
                                                                  ┌──────────────────┐
                                                                  │    COMPLETE      │
                                                                  └──────────────────┘
```

| Status | Meaning |
|--------|---------|
| `pending` | Cycle exists but hasn't opened |
| `collecting` | Contribution window open |
| `awaitingTrigger` | Grace ended, waiting for trigger |
| `payoutProcessing` | Payout executing |
| `complete` | Cycle done |
| `defaulted` | Critical failure |
| `payoutFailed` | Payout failed (retries up to 3×) |

#### How to Contribute
1. Open the Gooi dashboard
2. Tap "Contribute"
3. Confirm the amount (fixed — cannot be changed)
4. System deducts: **base amount** + **3% reserve** from user's wallet
5. Ledger journal entry created

**All members must contribute** each cycle. By default, the recipient also contributes (configurable).

### 4.8 Grace Period & Late Fees

- **Grace period**: Begins at due date, default **48 hours** (min 24h)
- Late contributions are marked `late` and incur a **percentage surcharge** (default 5%, range 0–10%)
- Late fees go into the group pot (benefiting the recipient)
- The **initiator can waive** individual late fees
- The **initiator can unilaterally extend** the grace period by up to **24 hours** (once per cycle)
- **Members can vote** to extend by up to **48 additional hours** (12-hour voting window, simple majority)

### 4.9 Payout Processing

#### Who Can Trigger?
- The **initiator** (always)
- A **trigger delegate** (if designated)
- The **system** automatically at **72 hours** after grace close

#### Payout Calculation
1. Total collected = sum of all base contributions
2. If shortfall (members missed): **reserve fund** covers the gap
3. Payout = collected + reserve top-up

#### After Payout
- Cycle marked `complete`
- Next cycle opens automatically (if cycles remain)
- Next member in roster becomes recipient

### 4.10 Auto-Contribute

Members can enable **automatic contributions**:
- Toggle on the dashboard
- Choose source wallet sub-account
- Triggers when a new cycle opens
- Falls back to manual if insufficient balance

### 4.11 Trigger Delegation

- Delegate to any active member
- Duration: 1–14 days (default 7)
- Scope: payout trigger only
- Auto-expires, can be revoked

### 4.12 Grace Period Extensions

| Type | Limit | Approval |
|------|-------|----------|
| Initiator unilateral | Up to 24 hours, once per cycle | None needed |
| Member vote | Up to 48 hours | Simple majority, 12-hour vote window |

### 4.13 Defaults, Debts & Penalties

When a member misses a contribution:
1. Contribution marked `missed`
2. Added to cycle's **defaulter list**
3. **Debt record** created (status: `outstanding`)
4. **Reserve fund** covers their share
5. Missed cycle count increments

Debts carry across cycles. A member with debts **cannot create new Gooi groups**. Debts can be `recovered` (member pays back) or `writtenOff` (Phase 2).

### 4.14 Group Completion

When the final cycle's payout completes:
- Group status → `completed`
- All members notified
- Reserve fund available for distribution (Phase 2)
- Chat remains accessible

### 4.15 Dissolution

- **Forming phase**: Initiator dissolves unilaterally, no financial impact
- **Active phase**: 80% member vote required, outstanding debts must be settled

### 4.16 Configuration & Limits

| Limit | Value |
|-------|-------|
| Max members per group | 12 |
| Max total cycles | 12 |
| Max active groups per user | 3 |
| Min contribution | 1,000 tokens (R10) |
| Max contribution | 1,000,000 tokens (R10,000) |
| Reserve rate | 3% (fixed) |
| Auto-trigger delay | 72 hours after grace close |
| Max payout retries | 3 |
| Invitation expiry | 7 days |
| Max delegation duration | 14 days |
| Max late fee | 10% |
| Bidding window | 48 hours |
| Min bid percentage | 80% |
| Max unilateral grace extension | 24 hours |
| Max voted grace extension | 48 hours |
| Grace extension vote window | 12 hours |
| Dissolution vote threshold | 80% of active members |

**All settings are locked once the group is activated — cannot be changed.**

### 4.17 Reserve Fund

| Aspect | Details |
|--------|---------|
| Rate | 3% of every base contribution |
| Storage | Separate `reserve` sub-account within group's ledger account |
| Purpose | Covers shortfalls from missed contributions |
| Usage | Automatically tapped during payout if collected < expected |
| Return | Phase 2 — proportional return upon group completion |

**Example**: 6 members × 2,000 tokens = 360 tokens/cycle in reserve. Over 6 cycles = 2,160 tokens. Covers one missed contribution (2,000) with 160 remaining.

### 4.18 Bidding Roster Method (Advanced)

1. 48-hour bidding window opens after all members accept
2. Members bid: target position + percentage of pot they'll accept (80–100%)
3. Lower % = earlier position (e.g., "85% for position 2" beats "90% for position 2")
4. Non-bidders fill remaining positions
5. Discounts accumulate in the **bidding discount pool**
6. Pool redistributed to later-position members (rewards patience)

---

## 5. Legacy Group Save (Stokvels)

> **Deprecated** — being replaced by Gooi-Gooi. Remains functional for existing groups.

### Group Types
- **Stokvel**: Traditional savings club with rotating payouts
- **Family**: Family financial group
- **Organization**: Organisational pooled fund
- **Club**: Social club fund

### Roles & Permissions (5 levels)

| Action | Owner | Admin | Treasurer | Member | Viewer |
|--------|:-----:|:-----:|:---------:|:------:|:------:|
| View group/ledger | ✓ | ✓ | ✓ | ✓ | ✓ |
| Contribute (self) | ✓ | ✓ | ✓ | ✓ | ✗ |
| Approve transfers | ✓ (∞) | ✓ (≤10k) | ✓ (≤5k) | ✗ | ✗ |
| Manage members | ✓ | ✓ | ✗ | ✗ | ✗ |
| Manage settings | ✓ | ✗ | ✗ | ✗ | ✗ |
| Close/suspend | ✓ | ✗ | ✗ | ✗ | ✗ |
| Trigger payout | ✓ | ✓ | ✓ | ✗ | ✗ |

### Stokvel Payout Types
- **Rotating**: Fixed order, cycling through roster
- **Lottery**: Random member selected each cycle
- **Fixed Date**: Distribute on a specific date (e.g., December)
- **Goal Reached**: Distribute when target amount is hit

### Transaction Approvals
Transactions above **5,000 tokens** (configurable) require multi-signature approval:
- PendingApproval record created
- Required approvers must all approve
- 48-hour expiry
- If any approver rejects → cancelled

---

## 6. Pot Pools (Daily & Weekly Draws)

### How It Works
When users earn tokens through brand engagement, **5% is automatically contributed** to community pots.

| Pool | Period | Winners | Draw Time |
|------|--------|---------|-----------|
| Daily | 00:00–23:59 SAST | Top 5 | 00:00 SAST next day |
| Weekly | Mon 00:00 – Sun 23:59 SAST | Top 10 | Monday 00:00 SAST |

- Winners selected based on **weighted entries** (more activity = higher chance)
- Users do **not manually contribute** — the 5% is automatic
- Past draw results viewable in history

---

## 7. Group Buy — Hlangana

### Concept
Collective purchasing where members pool tokens to unlock group discounts.

### Flow
1. Organizer creates a deal (title, target amount, deadline, discount %)
2. Users contribute tokens
3. If target met by deadline → deal activates (vouchers distributed or pickup arranged)
4. If target NOT met → all contributions refunded

### Sponsor Types
- **Community**: User-organized
- **Brand**: Brand partner sponsors
- **Platform**: Admin-curated

### Deal Types
- **Digital**: Voucher codes distributed
- **Physical**: Location-based pickup

### Limits
| Limit | Value |
|-------|-------|
| Min participants | 2 |
| Max participants | 10,000 |
| Max target | 10,000,000 tokens |

---

## 8. Complete Rules Reference

### Group Save (Collection Room) Rules

| Rule | Value | Enforcement |
|------|-------|-------------|
| Min contribution | 10 tokens | Hard |
| Max contribution | 100,000 tokens | Hard |
| Max invitees | 50 | Hard |
| Title length | 1–100 chars | Hard |
| Purpose length | 1–200 chars | Hard (required for save mode) |
| Message length | 0–200 chars | Soft (optional) |
| Pool expiry | None (Group Save) / 30 days (Sasaza) | Hard |
| Gift claim expiry | 7 days (Sasaza only) | Hard |
| Contribution eligibility | Organizer + invitees only | Hard |
| Distribution eligibility | Organizer only | Hard |
| Withdrawal eligibility | Any contributor | Hard (auto-approved) |
| Withdrawal limit | User's own contribution total | Hard |
| Cancel eligibility | Organizer only, collecting status | Hard |
| Refund method | Pro-rata based on contribution share | Hard |
| Idempotency | All ledger ops use deterministic IDs | Hard |

### Gooi-Gooi Rules

| Rule | Value | Enforcement |
|------|-------|-------------|
| Max active groups per user | 3 | Hard |
| No new groups with debts | — | Hard |
| Contribution range | 1,000–1,000,000 tokens | Hard |
| Max members | 12 | Hard |
| Max cycles | 12 | Hard |
| Reserve rate | 3% | Hard (not configurable) |
| Late fee range | 0–10% | Hard |
| Grace period minimum | 24 hours | Hard |
| Invitation expiry | 7 days | Hard |
| Delegation max | 14 days | Hard |
| Auto-trigger | 72h after grace close | Hard |
| Max payout retries | 3 | Hard |
| Bidding window | 48 hours | Hard |
| Min bid | 80% of pot | Hard |
| Grace extension (initiator) | Up to 24h, once/cycle | Hard |
| Grace extension (vote) | Up to 48h, majority | Hard |
| Dissolution vote | 80% of members | Hard |
| Settings locked after activation | All | Hard |

---

## 9. Glossary

| Term | Definition |
|------|-----------|
| **Available balance** | Pool's total amount minus already distributed amount |
| **Base contribution** | The fixed token amount each Gooi member contributes per cycle (excluding reserve) |
| **Bidding discount pool** | Accumulated discounts from Gooi members who accepted less than 100% for earlier positions |
| **Collection Room** | A chat conversation linked to a Token Pool — where Group Save and Sasaza pools live |
| **Contributor** | A participant who has added tokens to a pool |
| **Cycle** | One round of contribution + payout in Gooi-Gooi |
| **Defaulter** | A Gooi member who missed a contribution |
| **Dissolution** | Early termination of a Gooi group |
| **Double-entry** | Bookkeeping where every transaction has equal debits and credits |
| **Equal split** | Distribution option that divides available balance equally among all participants |
| **Escrow** | System account holding funds temporarily until conditions are met |
| **FCM** | Firebase Cloud Messaging — push notification system |
| **Fire-and-forget** | Side effects (notifications, system messages) that don't block the main operation |
| **Forming** | Gooi group status during setup, before activation |
| **Gooi-Gooi** | Rotating savings circle system (from Afrikaans "throw-throw") |
| **Grace period** | Extra time after due date for late Gooi contributions |
| **Group account** | Ledger account (`group:{id}`) holding pooled tokens |
| **Hlangana** | Group buying system (Zulu for "come together") |
| **Idempotency key** | Unique identifier ensuring a ledger operation is processed exactly once |
| **Initiator** | The member who creates a Gooi-Gooi group |
| **Journal** | A ledger record of a financial transaction (debit + credit pair) |
| **Keep open** | Option to keep a Group Save pool accepting contributions after a distribution |
| **Late fee** | Surcharge on Gooi contributions received after the due date |
| **Organizer** | The user who creates a Group Save or Sasaza Collection Room |
| **Partial distribution** | Distributing less than the full available balance |
| **Participant** | Any user in a Collection Room (organizer or invitee) |
| **Pot** | The accumulated contributions for a cycle |
| **Pro-rata refund** | Refund proportional to each contributor's share of total contributions |
| **Quick Action Strip** | The collapsible action row on the Chat tab with Sasaza, Group Save, Gooi-Gooi, and Token buttons |
| **Reserve fund** | 3% Gooi safety net covering shortfalls from missed contributions |
| **Rollback** | Automatic reversal of Firestore changes if a ledger operation fails |
| **Roster** | Ordered list of Gooi members determining payout sequence |
| **Stokvel** | Traditional South African savings club |
| **System message** | Automated in-chat message recording pool events |
| **Token** | iMaliChat's unit of value. 100 tokens = R1 ZAR |
| **Token Pool** | The data entity backing a Collection Room (stores mode, status, contributions, payouts) |
| **Trigger** | Action of initiating a Gooi payout after contributions are collected |
| **Trigger delegate** | A Gooi member temporarily authorized to trigger payouts |

---

*End of Group Save User Guide*
