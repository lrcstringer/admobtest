---
name: gooi_gooi_feature
description: Gooi-Gooi rotating savings feature — design review complete, implementation plan approved, ready for Phase 1
type: project
---

# Gooi-Gooi Feature

## Status: Implementation plan approved (2026-03-12)

## What It Is
Pure rotating savings feature (NOT a stokvel). Group pools money in turns — each cycle, everyone contributes and one member receives the whole pot. Lives on Chat screen as 4th Quick Action Strip item using `gooigooi.png` icon.

## Key Design Decisions
- Max 12 members, max 12 cycles
- Contribution amounts in tokens (display as ZAR ÷100), min R10 max R10,000
- 3 roster methods: AGREED (drag-and-drop), RANDOM (lottery), BIDDING (downward auction)
- Reserve fund at 3% of contributions; can go negative from bad debt
- Initiator is convenor, not authority — triggers payouts but can't redirect them
- 72-hour auto-trigger fallback if Initiator doesn't act
- Delegation: Initiator can delegate payout trigger only (max 14 days)
- Late fees are Initiator manual action (apply/waive), NOT automatic
- Bad Debts Write-Off is explicit Initiator action at round close
- Bidding bonuses distributed at round close (not per-cycle)
- Wallet selection from MVP (main or sub-account)
- Auto-debit opt-in from MVP
- Grace period extension: 24h unilateral + up to 48h via majority vote
- Each group gets its own conversation thread
- Max 3 active groups per user

## Firestore
- `gooiGroups/{groupId}` with subcollections: members, cycles, contributions, payouts, bids, auditLog
- `gooiGooiDebts/{debtId}` — cross-group debt tracking
- `gooiGooiConfig/default` — admin-configurable limits

## Cloud Functions
- `functions/src/gooiGooi.ts` — 22 callable functions
- `functions/src/gooiGooiScheduled.ts` — 7 scheduled functions
- `functions/src/gooiGooiNotifications.ts` — FCM handlers
- `functions/src/helpers/gooiGooiHelpers.ts` — validation/config
- `functions/src/ledger/gooiGooiEscrow.ts` — 9 ledger operations

## Ledger
- 10 new journal types (gooi_contribution, gooi_payout, gooi_reserve, etc.)
- Uses existing `group` account type with Pot + Reserve sub-accounts
- 10 new idempotency key builders

## Implementation Phases
1. **Phase 1 — MVP Core** (4 weeks): Backend + Flutter full stack
2. **Phase 2 — Reliability** (2 weeks): Reserve management, defaults, withdrawal voting, round completion
3. **Phase 3 — Security** (2 weeks): ID verification, POPIA, admin portal
4. **Phase 4 — Scale** (2 weeks): Trust scoring, analytics, PDF statements

## Full Plan Location
`C:\Users\lance\.claude\plans\encapsulated-zooming-biscuit.md`
