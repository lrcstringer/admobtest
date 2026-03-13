# Buy Tab Fresh-Eyes Audit Report

**Date**: 2026-03-13
**Scope**: All 5 Buy tab features + Admin Portal Backend
**Method**: Independent deep-read of every file in each feature area
**Criteria**: Clean Architecture, determinism, race conditions, edge cases, functionality gaps

---

## Executive Summary

| Feature | Issues Found | Critical | High | Medium | Low |
|---------|-------------|----------|------|--------|-----|
| Featured Items | 46 | 3 | 5 | 20 | 18 |
| Brand Storefronts | 17 | 4 | 1 | 7 | 5 |
| VAS Purchases | 15 | 3 | 3 | 5 | 4 |
| P2P Marketplace | 70 | 14 | 20 | 25 | 11 |
| Group Buys | 44 | 4 | 8 | 15 | 7 |
| Admin Portal Backend | 5 | 0 | 1 | 3 | 1 |
| **TOTAL** | **197** | **28** | **38** | **75** | **46** |

**Admin Portal Backend is the strongest area** — secure, well-guarded, with proper maker-checker patterns.
**P2P Marketplace has the most issues** — many missing UIs, model field gaps, and idempotency risks.

---

## FEATURE 1: FEATURED ITEMS

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| F1-1 | Scheduled items not filtered in carousel | `featured_carousel.dart` | Entity has `isCurrentlyActive` getter but carousel renders all items without checking schedule dates |
| F1-2 | Hex color parsing can crash | `featured_carousel.dart:152` | If hex value is corrupted/invalid, `Color(int.parse(...))` throws unhandled exception |
| F1-3 | Auto-advance timer race on rapid item changes | `featured_carousel.dart:43-52` | Rapid `RefreshBuyTab` events create multiple timers; old callbacks fire after new PageController created |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| F1-4 | Admin has no scheduling UI | `featured_content_management_screen.dart` | CF supports `scheduledStart`/`scheduledEnd` but admin dialog has no date pickers |
| F1-5 | Admin schedule filter logic inverted | `featured_content_management_screen.dart:88` | Items with `isActive=true` AND future schedule disappear from all tabs |
| F1-6 | Admin rapid create submits duplicates | `featured_content_management_screen.dart:1024-1028` | `saving=true` set AFTER validation; double-click sends two CF calls |
| F1-7 | Offline cache not filtered by isActive | `app_database.dart:381` | Stale/inactive items served from local cache without filtering |
| F1-8 | Community filtering not exposed in admin UI | `featured_content_management_screen.dart` | Entity supports `communityIds` targeting but no admin input |

### Medium (selected)

- Admin schedule display uses local time not UTC (`DateTime.now()` vs `.toUtc()`)
- Admin edit dialog doesn't show current schedule dates
- Hex color validation only client-side, no CF validation
- Video controller not disposed if `didUpdateWidget` fires rapidly (resource leak)
- Upload coordination race: image orphaned if CF fails after upload
- Admin fallback query doesn't filter `isActive`
- Featured items cache has no TTL enforcement
- Image resize utility imported but never used in admin upload
- No CF validation of image/video URL schemes (could be `javascript:` or `data:`)

---

## FEATURE 2: BRAND STOREFRONTS

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| F2-1 | Expired coupons not filtered before display | `brand_storefront_screen.dart` | Promotions ARE filtered by `expiresAt`, but coupons are not |
| F2-2 | Race condition in `recordStorefrontView` | `brands.ts:140-142` | `totalViews` incremented OUTSIDE transaction; concurrent views can lose counts |
| F2-3 | `orderId` optional in review event but required in entity | `brand_storefront_event.dart:18-25` | `BrandReview` entity requires `orderId` but event has `String?`; null passed to CF |
| F2-4 | Review ratings silently default to 1 | `brand_review_model.dart:36-39` | If user only sets 2 of 3 rating dimensions, third defaults to 1 without validation |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| F2-5 | No dedicated `BrandStorefrontRepository` interface | Missing file | All brand operations mixed into `BuyRepository`; violates Clean Architecture separation |

### Medium (selected)

- `isRedeemed` flag on coupon claims created but never updated anywhere
- Unfollow doesn't check brand existence; follower count can go negative
- Product detail navigation is TODO stub (line 634)
- No domain repository interface for brand-specific operations

---

## FEATURE 3: VAS PURCHASES

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| F3-1 | Missing `isActive`/`isDeleted` validation in `processPurchase` | `purchases.ts:45-57` | CF checks doc exists but not active status; purchases proceed for deactivated products |
| F3-2 | `ServiceProviderModel` only handles 4 of 13 categories | `service_provider_model.dart:104-117` | 9 categories silently fall back to `other`; category-filtered searches fail |
| F3-3 | No `priceTokens` bounds validation in `adminCreateVasProduct` | `buyAdmin.ts:3551` | Very small or very large `priceZar` creates nonsensical token amounts |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| F3-4 | Race: product becomes inactive between validation and purchase | `purchases.ts:44-150` | `isActive` not re-checked inside ledger transaction |
| F3-5 | Category enum not validated in `adminCreateVasProvider` | `buyAdmin.ts:3300` | Any string accepted; stored as-is in Firestore |
| F3-6 | Recipient number validation exists but never called during purchase | `purchase_remote_datasource.dart:254-272` | `validateRecipientNumber` method unused in `makePurchase` flow |

### Medium (selected)

- No deterministic ID in `adminCreateVasProduct` (auto-generated, no idempotency)
- `PurchaseModel._parseCategory` silently falls back to `other`
- Data layer catches business logic errors via string matching (`"Insufficient balance"`)
- No timeout handling for VAS provider simulation
- Provider name/code not validated for length or special characters

---

## FEATURE 4: P2P MARKETPLACE (Intengiso)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| F4-1 | Listing ID collision in `createMarketplaceListing` | `marketplace.ts:151` | `${providerId}_${titleHash}_${dateBucket}` — "iPhone 13" and "iPhone-13" same day produce identical IDs; second overwrites first |
| F4-2 | No idempotency keys in escrow calls | `marketplace.ts:324,498,1359` | `buyMarketplaceItem`, `confirmMarketplaceReceipt`, `respondToOffer` all call escrow ledger without idempotency keys; retry = double charge |
| F4-3 | `sellerInitiatedRefund` not idempotent | `marketplace.ts:1460` | Order marked "refunding" then refund attempted outside transaction; retry = double refund |
| F4-4 | Make Offer UI completely missing | No screen | CF `makeOffer` exists but no Flutter screen to call it |
| F4-5 | `_onContactSeller` is a stub | `marketplace_listing_detail_screen.dart:420` | "Contact Seller" button does nothing (TODO comment) |
| F4-6 | `_onBuy` navigates but doesn't dispatch purchase event | `marketplace_listing_detail_screen.dart:423` | Routes to orders screen but no `BuyItem` event dispatched |
| F4-7 | No CF for seller to respond to dispute | Missing | Entity has `sellerDisputeResponse`/`sellerDisputePhotos` fields but no CF to update them |
| F4-8 | No CF for dispute photo submission | Missing | `disputePhotos` field exists but no CF to upload after initial dispute |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| F4-9 | Missing `listingTitle`/`buyerName` in `MarketplaceOfferModel` | `marketplace_offer_model.dart` | CF writes these fields but model/entity don't parse them |
| F4-10 | Missing `offerZar`/`counterZar` in `MarketplaceOfferModel` | `marketplace_offer_model.dart` | ZAR values lost on deserialization |
| F4-11 | Missing `offerId` in `BuyOrderModel`/`BuyOrder` entity | `buy_order_model.dart` | Orders from offers can't trace back to offer terms |
| F4-12 | `checkDeliveryTimers` no duplicate completion guard | `marketplace.ts:1654` | Scheduled job could release escrow twice if re-run |
| F4-13 | `autoRefundUnresponsiveSeller` doesn't handle missing `escrowJournalId` | `marketplace.ts:1807` | Buyer stuck with no tokens and order in limbo |
| F4-14 | Missing seller dashboard UI | No screen | CF `getSellerDashboard` returns data but no screen displays it |
| F4-15 | No image URL validation | `marketplace.ts:139` | `imageUrls` accepted as-is; SSRF/phishing risk |
| F4-16 | Missing seller-proposed partial refund CF | Missing | Entity has `disputeResolutionAmount` but no CF to set it |
| F4-17 | `RefundType` enum missing `autoUnresponsiveSeller` value | Enum file | Silent fallback masks data |
| F4-18 | `OrderStatus` enum missing `refunding` value | Enum file | Silent fallback masks data |

### Medium (selected)

- Listing status transitions not validated (can unpause sold listing?)
- `buyMarketplaceItem` doesn't validate seller is approved provider
- No rate limiting on `makeOffer` (spam vector)
- Favourite count/renewal count not displayed on detail screen
- Delivery method/fee/deadline not shown in order detail UI
- Missing `message` field in `MarketplaceOfferModel`
- `vouchForProvider` has race condition on concurrent vouches
- `reportMarketplaceItem` rate limit has UTC midnight gaming window

---

## FEATURE 5: GROUP BUYS (Hlangana)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| F5-1 | Ledger idempotency design flaw in `joinGroupBuy` | `groupBuys.ts:222-246` | Firestore tx succeeds then ledger op attempted separately; partial success = Firestore/ledger disagree |
| F5-2 | `completeGroupBuy` status flip not atomic | `groupBuys.ts` | Concurrent joins near target can both trigger completion |
| F5-3 | Missing voucher code distribution system | Not implemented | Entity has `voucherCodes` but no CF to upload/assign/distribute codes to contributors |
| F5-4 | Missing admin-curated group buy creation | Not implemented | Only brand group buys can be created via admin; no CF for generic curated deals |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| F5-5 | User clusters not loaded in Flutter | Data layer | `getHubGroupBuys` CF exists but user's cluster IDs never fetched; hub filtering is dead code |
| F5-6 | Missing admin request approval/rejection CFs | Not implemented | `GroupBuyRequest` has status field but no CFs to approve/reject suggestions |
| F5-7 | Community organizers can't create group buys from Flutter | UI missing | `createGroupBuy` CF works but screen was repurposed for suggestions only |
| F5-8 | `adminCreateBrandGroupBuy` missing many entity fields | `buyAdmin.ts:1867-1946` | `imageUrl`, `originalPrice`, `category`, `deliveryFee`, etc. not accepted |
| F5-9 | Organizer can't access admin-curated group buy management | BLoC | `isOrganizer` check fails for admin-created deals where `organizerId` is admin UID |
| F5-10 | Physical group buy join dialog doesn't capture delivery address | `group_buy_detail_screen.dart:603` | Entity has `deliveryAddress` but dialog doesn't ask for it |

### Medium (selected)

- `leaveGroupBuy` compensation transaction missing `walletId`
- Wallet ID not persisted through contribution lifecycle
- Missing admin UI for voucher code assignment
- No scheduled job to finalize incomplete collections after deadline
- Brand group buy `organizerName` fragile if brand lookup fails
- Deterministic ID pattern not extracted to reusable const
- `cancelling` intermediate status adds complexity without clear benefit
- No ledger journal type for group buy operations (uses generic `transfer`)
- Admin suggestions tab shows count but no action buttons

---

## FEATURE 6: ADMIN PORTAL BACKEND

### Assessment: STRONG

The admin backend is the best-implemented area of the Buy tab.

| Aspect | Rating | Notes |
|--------|--------|-------|
| Permission guards | PASS | All 43 functions use `requireAdminPermission()` |
| Maker-checker | PASS | 5 financial operations require dual approval |
| Transaction safety | PASS | Executors read data inside transactions |
| Escrow handling | PASS | Two-phase with rollback on failure |
| Soft-delete | PASS | Consistent `isDeleted + isActive` pattern |
| Audit logging | PASS | Every operation logs with `logAdminAction()` |
| Input validation | PASS | Comprehensive type/existence/range checks |

### Issues Found

| # | Severity | Issue | File | Description |
|---|----------|-------|------|-------------|
| A-1 | HIGH | `getBrandAnalytics` has redundant `requireAuth()` | `brands.ts:197` | Semantic confusion; admin-only function calls user auth first |
| A-2 | MEDIUM | Provider ban only cascades `active`/`paused` listings | `buyAdmin.ts:2653` | `pending` and `flagged` listings orphaned |
| A-3 | MEDIUM | `adminExtendGroupBuyDeadline` allows earlier deadline | `buyAdmin.ts:1674` | No check that new deadline > current deadline |
| A-4 | MEDIUM | Provider deletion has no cascade check for products | `buyAdmin.ts:3447` | Provider with active products can be soft-deleted |
| A-5 | LOW | Concurrent review flags trigger redundant rating recalculations | `buyAdmin.ts:2315` | Inefficient but not incorrect |

---

## Cross-Cutting Themes

### 1. Missing Model Fields (Data Loss)
Multiple CFs write fields that Flutter models don't parse:
- `MarketplaceOfferModel`: missing `listingTitle`, `buyerName`, `offerZar`, `counterZar`, `message`
- `BuyOrderModel`: missing `offerId`
- `GroupBuyContribution`: `walletId` not persisted through lifecycle

### 2. Enum Gaps (Silent Fallbacks)
Several enums are missing values that CFs write:
- `OrderStatus`: missing `refunding`
- `RefundType`: missing `autoUnresponsiveSeller`
- `ServiceProviderModel._parseCategory`: only handles 4 of 13 categories

### 3. Idempotency Gaps
Escrow/ledger operations in marketplace functions lack idempotency keys, creating double-charge risk on retries.

### 4. Missing UIs (Feature Gaps)
Several CF features have no corresponding Flutter UI:
- Make Offer, Seller Dashboard, Dispute Response, Contact Seller
- Admin scheduling, community filtering, voucher distribution
- Community group buy creation, hub group buy discovery

### 5. Race Conditions Pattern
Common pattern: validation outside transaction, action inside transaction. The gap allows state changes between validation and execution.

---

## Recommended Priority Order

### Tier 1: Fix Before Launch (Financial Risk)
1. Add idempotency keys to all marketplace escrow calls (F4-2, F4-3)
2. Fix `processPurchase` to check `isActive`/`isDeleted` (F3-1)
3. Fix listing ID collision in `createMarketplaceListing` (F4-1)
4. Fix group buy ledger idempotency design (F5-1)
5. Add missing enum values (`refunding`, `autoUnresponsiveSeller`) (F4-17, F4-18)
6. Fix `ServiceProviderModel` to handle all 13 categories (F3-2)

### Tier 2: Fix Before Launch (Broken Features)
7. Filter expired coupons in storefront screen (F2-1)
8. Fix `recordStorefrontView` race condition (F2-2)
9. Add hex color error handling in carousel (F1-2)
10. Fix `orderId` optional→required in review event (F2-3)
11. Parse missing `MarketplaceOfferModel` fields (F4-9, F4-10)
12. Parse missing `offerId` in `BuyOrderModel` (F4-11)

### Tier 3: Implement Missing Features
13. Make Offer UI screen
14. Contact Seller → E2EE chat integration
15. Seller dispute response CF + UI
16. Voucher distribution system for group buys
17. Admin scheduling UI for featured items
18. Community group buy creation flow
19. Seller dashboard UI

### Tier 4: Harden
20. Add admin schedule date pickers
21. Fix auto-advance timer lifecycle
22. Add `priceTokens` bounds validation
23. Validate category enum in admin CFs
24. Add recipient number validation before purchase
25. Fix `autoRefundUnresponsiveSeller` for missing escrow
26. Add physical group buy address capture at join

### Tier 5: Polish
27. UTC time in admin schedule filters
28. Featured items cache TTL
29. Image resize before admin upload
30. Provider ban cascade for pending/flagged listings
31. Deadline extension validation (new > current)
32. Rate limiting on makeOffer
33. Listing status transition validation
