# Buy Tab Comprehensive Audit Report

> **Date**: 2026-03-12
> **Scope**: 5 features × 10 audit dimensions + cross-feature + critique
> **Total checkpoints**: 283 feature checks + 13 critique checks = **296 verification points**

---

## Executive Summary

| Section | PASS | FAIL | PARTIAL | Total |
|---------|------|------|---------|-------|
| F1: Featured Items | 23 | 9 | 4 | 36 |
| F2: Brand Partners | 34 | 11 | 4 | 49 |
| F3: Utilities/VAS | 30 | 12 | 7 | 49 |
| F4: Marketplace | 54 | 13 | 2 | 69 |
| F5: Group Buy | 44 | 8 | 5 | 57 |
| Cross-Feature (X1–X10) | 5 | 3 | 2 | 10 |
| Critique Phase (C1–C3) | 5 | 2 | 5 | 13* |
| **GRAND TOTAL** | **195** | **58** | **29** | **283+13** |

*Critique phase also surfaced 4 new findings not in the original 283 checks.

**Overall pass rate**: 195/283 = **68.9%** (feature checks only)

---

## Severity Distribution

| Severity | Count | Description |
|----------|-------|-------------|
| P0-CRITICAL | 1 | Data loss / money loss / security breach |
| P1-HIGH | 12 | Incorrect behavior, race conditions with real impact |
| P2-MEDIUM | 18 | Architecture violations, missing validation, dead code |
| P3-LOW | 8 | Style inconsistency, missing optimization, missing test |

---

## ALL FINDINGS — Sorted by Severity

### P0-CRITICAL (1 issue)

| # | ID | Feature | Issue | File(s) | Fix |
|---|-----|---------|-------|---------|-----|
| 1 | F5-I2 | Group Buy | `GroupBuyContributionModel` missing 4 fields: `voucherCode`, `hasCollected`, `collectedAt`, `walletId`. Collection tracking and voucher codes never reach the UI. | `lib/data/models/group_buy_contribution_model.dart` | Add all 4 fields to model, update `fromJson`, `toEntity`, `fromEntity`. Run `build_runner`. |

---

### P1-HIGH (12 issues)

| # | ID | Feature | Issue | File(s) | Fix |
|---|-----|---------|-------|---------|-----|
| 2 | F5-C6 | Group Buy | `leaveGroupBuy` compensating tx uses `doc()` (random ID) instead of deterministic `${userId}_${groupBuyId}`. Orphans contribution on failure. | `functions/src/groupBuys.ts:436` | Change `doc()` to `` doc(`${userId}_${groupBuyId}`) `` |
| 3 | F5-D5 | Group Buy | CF uses "cancelling" intermediate status not in Flutter `GroupBuyStatus` enum. Model parser defaults to `open`, making cancelling group buys appear joinable. | `group_buy_model.dart`, `groupBuys.ts:719` | Add `cancelling` to Flutter enum OR map it to `cancelled` in parser. |
| 4 | F4-A3 / X5 | Marketplace | `marketplace_repository.dart` imports `dart:io` — domain depends on platform types, breaks web compilation for admin portal. | `lib/domain/repositories/marketplace_repository.dart:1` | Replace `List<File>` with `List<Uint8List>` or a platform-agnostic value object. |
| 5 | F4-I3 | Marketplace | `BuyOrder` entity uses `String?` for `deliveryMethod`/`refundType` while model uses typed enums. Type safety is inverted — entity is less safe than model. | `lib/domain/entities/buy_order.dart:38,43` | Change entity to use `DeliveryMethod?` and `RefundType?` enums. Update model `toEntity()`. |
| 6 | F4-J6 | Marketplace | No step-up auth (biometric/PIN) before marketplace purchases. Financial transactions (escrow) proceed without identity confirmation. | `lib/presentation/blocs/order/order_bloc.dart` | Add `StepUpAuthService` call before dispatching `buyItem`. |
| 7 | F3-J2 | Utilities | No step-up auth before VAS purchases. | `lib/presentation/screens/buy/buy_wallet_selection_screen.dart:150-157` | Add biometric/PIN prompt before `makePurchase` event. |
| 8 | F3-D3 | Utilities | Balance validation in `processPurchase` is OUTSIDE the transaction — TOCTOU race. Balance could decrease between validation and ledger debit. | `functions/src/purchases.ts:86-103` | Move balance check inside the ledger transaction, or use the ledger's own balance validation. |
| 9 | F3-F2 | Utilities | `buyNotifications.ts` uses `after.amountTokens` but purchase doc field is `tokenAmount`. Notification shows `undefined` for amount. | `functions/src/buyNotifications.ts:451` | Change `after.amountTokens` to `after.tokenAmount`. |
| 10 | F2-H4 | Brand Partners | `submitBrandReview` in Flutter does NOT send `orderId` but CF requires it (`"brandId and orderId are required"`). Review submission is broken. | `lib/data/repositories/buy_repository_impl.dart`, `functions/src/buyAdmin.ts:2079` | Add `orderId` parameter to Flutter's review submission chain (BLoC → repo → datasource). |
| 11 | F2-E6 | Brand Partners | `getBrandAnalytics` in `brands.ts` has NO `requireAdminPermission` — any authenticated user can pull any brand's analytics. | `functions/src/brands.ts:391` | Add `requireAdminPermission(request, "buy:getBrandAnalytics")`. |
| 12 | F2-D3 | Brand Partners | `recordStorefrontView` non-transactional visitor check — two simultaneous views from the same user can double-increment `uniqueVisitorCount`. | `functions/src/brands.ts:370-378` | Wrap visitor check + increment in a Firestore transaction. |
| 13 | F2-G2 | Brand Partners | `isFollowing` is never hydrated from server on `loadStorefront`. Always starts as `false` regardless of actual follow status. | `lib/presentation/blocs/brand_storefront/brand_storefront_bloc.dart` | Hydrate `isFollowing` from server in `_onLoadStorefront` (call `getClaimedCoupons` already exists, add follow check). |

---

### P2-MEDIUM (18 issues)

| # | ID | Feature | Issue | File(s) | Fix |
|---|-----|---------|-------|---------|-----|
| 14 | X6 | All | ALL 16 domain entities have `part '*.g.dart'` + `fromJson` — systemic Clean Architecture violation. Domain layer has serialization concerns. | All 16 entity files in `lib/domain/entities/` | Remove `.g.dart` parts and `fromJson` from entities. Use models for deserialization. Project-wide refactor. |
| 15 | X9 | All | Only 1 of 5 BLoCs tested (20%). `PurchaseBloc` has tests; `BuyTabBloc`, `MarketplaceBloc`, `BrandStorefrontBloc`, `GroupBuyBloc` have zero tests. | `test/` | Create `bloc_test` test files for all 4 untested BLoCs + `OrderBloc`. |
| 16 | F5-I4 | Group Buy | Enum mismatches: CF uses `"rejected"` for request status but Flutter expects `"declined"`. Admin decline flow silently fails (stays "pending" in UI). | `group_buy_request_model.dart:79`, `groupBuys.ts:513` | Align: either CF uses `"declined"` or Flutter parser handles `"rejected"`. |
| 17 | F5-B3 | Group Buy | `suggestGroupBuyDeal` uses `doc()` (random ID). Client retries create duplicate suggestions. | `functions/src/groupBuys.ts:500` | Use deterministic ID: `` `${userId}_${descHash}_${dateBucket}` `` |
| 18 | F5-C4 | Group Buy | Organizer can leave their own group buy instead of being forced to cancel. | `functions/src/groupBuys.ts:367-461` | Add check: `if (userId === groupBuy.organizerId) throw "Organizers must cancel instead of leaving"`. |
| 19 | F4-B2 | Marketplace | `createMarketplaceListing` uses random doc ID. Not deterministic — retries create duplicates. | `functions/src/marketplace.ts:137` | Use deterministic ID or add idempotency key. |
| 20 | F4-B4 | Marketplace | `makeOffer` uses random doc ID + non-transactional duplicate check. Race condition on concurrent offers. | `functions/src/marketplace.ts:1219` | Use deterministic ID `` `${userId}_${listingId}` `` with transaction. |
| 21 | F4-D2 | Marketplace | `respondToOffer` accept doesn't atomically mark listing as "pending". Two offers accepted simultaneously could both create orders. | `functions/src/marketplace.ts:1272-1354` | Add `tx.update(listingRef, { status: "pending" })` inside the accept branch. |
| 22 | F4-D5 | Marketplace | `renewListing` does NOT use a transaction — TOCTOU race. Concurrent purchase could be overwritten. | `functions/src/marketplace.ts:1039-1069` | Wrap read + status check + update in a transaction. |
| 23 | F3-B2/B3/B4 | Utilities | `Math.random()` used for token/voucher/PIN generation in simulation stub. Not cryptographic. | `functions/src/purchases.ts:324-348` | Replace with `crypto.randomBytes()` when integrating real VAS APIs. Flag as TODO. *(Reclassified from P1 — simulation placeholder)* |
| 24 | F3-B5 | Utilities | `simulateVasProviderCall` is a placeholder with hardcoded 500ms delay. Must be replaced before production. | `functions/src/purchases.ts:279` | Replace with real VAS API integration. |
| 25 | F3-I1/I2 | Utilities | Type mismatches: `Purchase` entity uses `PurchaseCategory` enum, model uses `String`. Same for `ServiceProvider`. | `purchase.dart`, `purchase_model.dart`, `service_provider.dart`, `service_provider_model.dart` | Align types — entity should use enums, model should parse strings to enums. |
| 26 | F2-G1 | Brand Partners | `BrandStorefrontBloc` has 2 unused state fields: `mutualFollowers`, `mutualFollowerCount`. No handler populates them despite `getBrandMutualFollowers` CF existing. | `brand_storefront_bloc.dart`, `brand_storefront_state.dart` | Either wire up `getBrandMutualFollowers` or remove the dead fields. |
| 27 | F2-C2 | Brand Partners | Expired coupons in storefront not filtered in UI. Users see expired coupons they can't claim. | `lib/presentation/screens/buy/brand_storefront_screen.dart:1221` | Filter coupons by `expiresAt` before rendering. |
| 28 | F1-B3 | Featured Items | `isCurrentlyActive` getter mixes UTC and local time in scheduled comparisons. | `lib/domain/entities/featured_item.dart` | Normalize to UTC for all schedule comparisons. |
| 29 | F1-E3 | Featured Items | Admin CRUD CFs do NOT accept `scheduledStart`/`scheduledEnd` params. Cannot schedule featured items via admin panel. | `functions/src/buyAdmin.ts` | Add `scheduledStart` and `scheduledEnd` to admin create/update CF params. |
| 30 | C2-4† | Marketplace | `ListingStatus` missing "pending" enum value. CF sets listing to "pending" when reserved, but Flutter defaults to "active". Reserved listings appear available. | `lib/domain/enums/listing_status.dart`, `marketplace.ts:278` | Add `pending` to `ListingStatus` enum. *(New finding from critique)* |
| 31 | C3-2† | Group Buy | `completeGroupBuy` CF has no Flutter caller. Organizer cannot complete deals from the app. Critical workflow gap. | `functions/src/groupBuys.ts`, missing Flutter code | Add `completeGroupBuy` event to `GroupBuyBloc`, plumb through repo → datasource → CF. *(New finding from critique)* |

---

### P3-LOW (8 issues)

| # | ID | Feature | Issue | File(s) | Fix |
|---|-----|---------|-------|---------|-----|
| 32 | F4-C4 | Marketplace | Offer amount > listing price not validated. Buyer can offer more than asking price. | `functions/src/marketplace.ts:1178-1179` | Add validation: `if (offerAmount >= listing.priceTokens) throw "Use Buy Now"`. |
| 33 | F4-C5 | Marketplace | Counter offer has no upper bound validation. | `functions/src/marketplace.ts:1301` | Add bounds check relative to original listing price. |
| 34 | F4-H7 | Marketplace | `getSellerDashboard()` returns untyped `Map<String, dynamic>`. | All layers | Create a typed `SellerDashboard` entity. |
| 35 | F4-J5 | Marketplace | `PaymentProtectionExplainer` widget exists but is unused in marketplace screens. | `payment_protection_explainer.dart` | Add near the "Buy" button on listing detail screen. |
| 36 | F5-B5 | Group Buy | `checkExpiredGroupBuys` query has no `orderBy` — non-deterministic processing order. | `functions/src/groupBuys.ts:541-545` | Add `.orderBy("deadline")`. |
| 37 | F5-F5 | Group Buy | No notification to organizer when a participant leaves. | `functions/src/buyNotifications.ts` | Add leave notification in `leaveGroupBuy` CF or via trigger. |
| 38 | F2-J4 | Brand Partners | `showChatButton` field on `BrandStorefront` is never referenced in the storefront screen. | `brand_storefront_screen.dart` | Wire up chat button visibility to the field value. |
| 39 | C3-4† | All | Collection names, status strings, and magic numbers hardcoded throughout. No constants file. | Multiple datasource and CF files | Extract to a shared constants file on each side (Dart + TS). *(New finding from critique)* |

---

## Dead Code Identified (from Critique C3-2)

These Cloud Functions exist but have **no Flutter caller**:

| CF | File | Status |
|----|------|--------|
| `completeGroupBuy` | `groupBuys.ts` | **Critical gap** — organizer completion flow missing |
| `getSimilarListings` | `marketplace.ts` | Dead — feature not wired |
| `getPriceSuggestion` | `marketplace.ts` | Dead — feature not wired |
| `followBrand` | `brands.ts` | Dead — replaced by `toggleBrandFollow` |
| `unfollowBrand` | `brands.ts` | Dead — replaced by `toggleBrandFollow` |
| `getFollowedBrands` | `brands.ts` | Dead — no screen uses it |
| `getAvailableBrands` | `brands.ts` | Dead — no screen uses it |
| `getBrandMutualFollowers` | `brands.ts` | Dead — explains dead state fields in BLoC |
| `getPurchaseDetails` | `purchases.ts` | Dead — no Flutter caller |

---

## Fix Priority Order

### Phase 1: P0 + P1 Critical Fixes (12 items)
These must be fixed before release. Ordered by dependency:

1. **#1 F5-I2**: Add 4 missing fields to `GroupBuyContributionModel` → run `build_runner`
2. **#2 F5-C6**: Fix compensating tx random ID in `leaveGroupBuy`
3. **#3 F5-D5**: Add "cancelling" to `GroupBuyStatus` enum OR fix parser
4. **#4 F4-A3/X5**: Replace `dart:io` File with `Uint8List` in marketplace repository
5. **#5 F4-I3**: Fix `BuyOrder` entity type safety (String → enum)
6. **#8 F3-D3**: Move balance validation inside transaction in `processPurchase`
7. **#9 F3-F2**: Fix `amountTokens` → `tokenAmount` in buyNotifications.ts
8. **#10 F2-H4**: Add `orderId` to `submitBrandReview` Flutter chain
9. **#11 F2-E6**: Add `requireAdminPermission` to `getBrandAnalytics`
10. **#12 F2-D3**: Wrap `recordStorefrontView` visitor check in transaction
11. **#6 F4-J6 + #7 F3-J2**: Add step-up auth before marketplace + VAS purchases
12. **#13 F2-G2**: Hydrate `isFollowing` from server on storefront load

### Phase 2: P2 Architecture & Safety Fixes (18 items)
Fix in this sprint. Grouped by file to minimize churn:

**Cloud Functions (TypeScript):**
- #17 F5-B3: Deterministic ID for `suggestGroupBuyDeal`
- #18 F5-C4: Block organizer from leaving own group buy
- #19 F4-B2: Deterministic ID for `createMarketplaceListing`
- #20 F4-B4: Deterministic ID for `makeOffer`
- #21 F4-D2: Atomically mark listing pending on offer accept
- #22 F4-D5: Transaction for `renewListing`
- #29 F1-E3: Add schedule params to admin featured item CFs
- #30 C2-4: Handle "pending" listing status in Flutter enum
- #31 C3-2: Wire `completeGroupBuy` CF to Flutter

**Flutter:**
- #16 F5-I4: Fix rejected/declined enum mismatch
- #25 F3-I1/I2: Align type mismatches in Purchase/ServiceProvider
- #26 F2-G1: Remove dead state fields or wire up `getBrandMutualFollowers`
- #27 F2-C2: Filter expired coupons in storefront UI
- #28 F1-B3: Normalize schedule comparisons to UTC

**Project-wide:**
- #14 X6: Remove `.g.dart`/`fromJson` from all 16 entities (large refactor)
- #15 X9: Write BLoC tests for 4 untested BLoCs + OrderBloc
- #23-24 F3-B2-B5: Flag simulation stubs for production replacement

### Phase 3: P3 Polish (8 items)
Backlog — fix when convenient.

### Phase 4: Post-fix Verification
1. Run `dart run build_runner build --delete-conflicting-outputs`
2. Run `flutter analyze --fatal-infos` — zero errors
3. Run `cd functions && npm run build` — zero errors
4. Run `flutter test` — all pass
5. Run `cd functions && npm test` — all pass

---

## Systemic Patterns Observed

### 1. Domain Layer Contamination (ALL features)
Every entity has `fromJson` + `.g.dart`. The project's CLAUDE.md says "Entities: no JSON annotations" but this is violated universally. This is a project-wide debt, not Buy-specific.

### 2. Missing Step-Up Auth (Marketplace + Utilities)
Financial operations (escrow, VAS purchases) proceed without re-authentication. The app has RASP and biometric infrastructure but doesn't enforce it before money-moving operations.

### 3. Non-Deterministic IDs (3 CFs)
`createMarketplaceListing`, `makeOffer`, and `suggestGroupBuyDeal` use auto-generated IDs. Other CFs in the same codebase correctly use deterministic IDs, showing this is oversight rather than pattern.

### 4. Enum String Mismatches (2 instances)
"cancelling" (GroupBuy) and "pending" (Listing) statuses exist in CFs but not in Flutter enums. Both default to incorrect values, causing incorrect UI states.

### 5. Test Coverage Gap
80% of BLoCs handling financial operations have zero test coverage. Only `PurchaseBloc` has tests, and even those cover only 10 of 15 events.

---

## Appendix: Checkpoint Index

### Feature 1: Featured Items (36 checks)
- 1A. Clean Architecture: F1-A1 through F1-A6
- 1B. Determinism: F1-B1 through F1-B4
- 1C. Edge Cases: F1-C1 through F1-C5
- 1D. Race Conditions: F1-D1 through F1-D2
- 1E. Cloud Functions: F1-E1 through F1-E4
- 1F. Notifications: F1-F1
- 1G. BLoC State: F1-G1 through F1-G3
- 1H. Repo+DS Plumbing: F1-H1 through F1-H3
- 1I. Entity/Model: F1-I1 through F1-I3
- 1J. Cross-Cutting: F1-J1 through F1-J5

### Feature 2: Brand Partners (49 checks)
- 2A–2J: F2-A1 through F2-J5

### Feature 3: Utilities/VAS (49 checks)
- 3A–3J: F3-A1 through F3-J6

### Feature 4: Marketplace (69 checks)
- 4A–4J: F4-A1 through F4-J7
- OrderBloc: 4 additional checks

### Feature 5: Group Buy (57 checks)
- 5A–5J: F5-A1 through F5-J6

### Cross-Feature (10 checks)
- X1 through X10

### Critique Phase (13 checks)
- C1-1 through C1-5 (Completeness)
- C2-1 through C2-4 (Correctness)
- C3-1 through C3-4 (Coverage)
