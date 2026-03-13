# Buy Tab Re-Audit Report (Post-Fix)

**Date**: 2026-03-13
**Scope**: All 5 Buy tab features + Admin Portal Backend (post-197-fix review)
**Method**: Independent deep-read of every file in each feature area after all fixes applied
**Criteria**: Clean Architecture, determinism, race conditions, edge cases, functionality gaps

---

## Executive Summary

| Feature | Issues Found | Critical | High | Medium | Low |
|---------|-------------|----------|------|--------|-----|
| Featured Items | 15 | 1 | 3 | 7 | 4 |
| Brand Storefronts | 16 | 2 | 4 | 6 | 4 |
| VAS Purchases | 22 | 2 | 5 | 9 | 6 |
| P2P Marketplace | 18 | 3 | 5 | 6 | 4 |
| Group Buys | 37 | 5 | 8 | 14 | 10 |
| Admin Backend | 36 | 3 | 7 | 16 | 10 |
| **TOTAL** | **144** | **16** | **32** | **58** | **38** |

**Down from 197 → 144 remaining issues.** Original 197 critical/high issues are largely resolved. Remaining issues are mostly medium/low severity found on deeper inspection, plus a few new critical issues introduced or exposed by the fixes.

---

## FEATURE 1: FEATURED ITEMS (15 issues)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| R1-1 | Soft-delete items not filtered in carousel | `featured_carousel.dart` | `isCurrentlyActive` checks schedule dates but not `isDeleted`/`isActive` flags — deleted items still render if within schedule window |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| R1-2 | Opacity default mismatch | Entity vs CF | Entity defaults opacity to `1.0` but CF may write `null`; model doesn't handle null opacity → crash on certain items |
| R1-3 | Video controller lifecycle on rapid `didUpdateWidget` | `featured_carousel.dart` | `_disposed` flag added but video controller may still callback between `dispose()` call and flag set |
| R1-4 | Cache TTL not enforced | `app_database.dart` | Featured items cache serves stale data indefinitely; no TTL or staleness check |

### Medium

- Community filtering UI added to admin but not wired to consumer-side query
- `bgGradientType` validation in CF doesn't match all Flutter gradient types
- Timer cancellation in `dispose()` doesn't null out the timer reference
- Offline-first fetch returns unfiltered items before server response arrives
- Admin edit dialog resets schedule fields if user opens and cancels without changes
- `imageLayout` enum validation allows values not handled by Flutter widget
- No loading state shown while video controller initializes

### Low

- Dot indicator animation jitter when filtered list changes length
- Admin schedule date pickers don't enforce minimum 1-hour window
- Featured item ordering assumes server returns in `order` field sequence
- No empty state when all items are outside schedule window

---

## FEATURE 2: BRAND STOREFRONTS (16 issues)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| R2-1 | `orderId` required in BLoC event but optional in repository chain | Multiple files | `BrandStorefrontEvent.submitReview` now requires `orderId` but `BuyRepository.submitBrandReview` still has `String? orderId` — type mismatch if null slips through |
| R2-2 | Coupon `isActive` not filtered before display | `brand_storefront_screen.dart` | Expired coupons are now filtered by `expiresAt` but deactivated coupons (`isActive: false`) still show |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| R2-3 | `toggleFollow` re-entrancy | `brand_storefront_bloc.dart` | Rapid follow/unfollow creates race — no guard against concurrent toggle |
| R2-4 | `reviewSubmitSuccess` doesn't refresh storefront data | `brand_storefront_bloc.dart` | After successful review, stale review list shown until manual refresh |
| R2-5 | `followedAt` timestamp not parsed in model | `brand_storefront_model.dart` | CF writes `followedAt` but model doesn't read it |
| R2-6 | Coupon `maxClaims`/`expiry` not validated in CF | `brands.ts` | Coupons can be created with `maxClaims: 0` or past expiry dates |

### Medium

- `isRedeemed` flag still never updated on coupon claims
- Product detail navigation still TODO stub
- No domain repository interface for brand-specific operations
- Review submission doesn't validate `hasAllRatings` despite getter existing
- Brand search doesn't filter soft-deleted brands
- Mutual follower count still dead state in BLoC

### Low

- Follow count animation shows intermediate wrong number
- Brand logo placeholder doesn't match design system
- No pagination on reviews list
- Coupon claim count not displayed to users

---

## FEATURE 3: VAS PURCHASES (22 issues)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| R3-1 | Step-up auth not actually blocking purchase flow | `purchase_bloc.dart` | Recipient validation added but step-up auth (`evaluateRequired()`) not integrated — purchase proceeds without biometric/PIN |
| R3-2 | `isDeleted` check missing in datasource queries | `buy_remote_datasource.dart` | Product listing queries don't filter `isDeleted: true` — CF validates but client shows deleted products |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| R3-3 | Recipient validation regex mismatch | `purchase_bloc.dart` vs `purchase_remote_datasource.dart` | BLoC validates phone as `^0[6-8]\d{8}$` but datasource has different regex — inconsistent rejection |
| R3-4 | Purchase record not created on CF failure after debit | `purchases.ts` | If Firestore write fails after ledger debit, tokens deducted but no purchase record exists |
| R3-5 | Provider `isActive` not re-checked during purchase | `purchases.ts` | Product re-checked but provider status could change between validation and execution |
| R3-6 | Category filter in admin uses string matching | `buyAdmin.ts` | `adminListVasProducts` accepts raw string category, doesn't validate against enum |
| R3-7 | No purchase history pagination | `purchase_bloc.dart` | All purchases loaded at once — performance issue for active users |

### Medium

- `PurchaseModel._parseCategory` falls back silently to `other`
- Data layer catches business logic errors via string matching (`"Insufficient balance"`)
- No timeout handling for VAS provider simulation
- Electricity meter number validation too permissive (accepts any 11+ digits)
- Purchase confirmation screen doesn't show fee breakdown
- `priceTokens` bounds (1-1M) don't account for bulk purchases
- VAS product search has no debounce
- Provider code uniqueness not enforced in CF
- No retry mechanism for failed purchases where tokens were not deducted

### Low

- Product grid doesn't show out-of-stock indicator
- No product detail sheet/screen
- Sort order defaults differ between admin and consumer views
- Purchase receipt not downloadable
- No purchase cancellation window
- Provider logo upload has no size validation

---

## FEATURE 4: P2P MARKETPLACE (18 issues)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| R4-1 | `refundType` format inconsistency | `marketplace.ts` vs `refund_type.dart` | CF writes `auto_unresponsive_seller` (snake_case) but enum parser expects `autoUnresponsiveSeller` (camelCase) — type mismatch on deserialization |
| R4-2 | `sellerName` not parsed in `MarketplaceOfferModel` | `marketplace_offer_model.dart` | Field added to entity but `fromJson` doesn't read `sellerName` from Firestore doc |
| R4-3 | `respondToOffer` creates non-deterministic order ID | `marketplace.ts` | Accept branch creates order with auto-generated Firestore ID — no idempotency on retry |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| R4-4 | Counter offer validation uses stale listing price | `marketplace.ts` | `respondToOffer` reads listing price outside transaction — concurrent price update creates wrong bounds |
| R4-5 | `make_offer_screen.dart` has TODO placeholder for CF call | `make_offer_screen.dart` | Screen UI built but actual `makeOffer` CF invocation is a TODO stub |
| R4-6 | Contact seller navigates to chat but doesn't create/find existing chat room | `marketplace_listing_detail_screen.dart` | Routes to chat screen without ensuring a chat room exists between buyer and seller |
| R4-7 | Favourite toggle optimistic update doesn't handle auth failure | `marketplace_bloc.dart` | If user session expired, revert logic silently fails |
| R4-8 | `proposeResolution` allows resolution amount > original price | `marketplace.ts` | No upper bound validation on proposed refund amount |

### Medium

- Listing expiry `getDaysUntilExpiry` method unused in any UI
- Delivery deadline display in order detail doesn't account for timezone
- `renewListing` incremented renewal count but UI shows raw number without context
- Seller dashboard route added to router but screen component not implemented
- `vouchForProvider` orderId requirement not enforced in Flutter UI
- Image URL validation in CF rejects valid CDN URLs with query params

### Low

- Make Offer button visible even when user is the seller
- No confirmation dialog before buying at full listing price
- Offer list doesn't show counter offer history
- Search results don't indicate delivery method

---

## FEATURE 5: GROUP BUYS (37 issues)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| R5-1 | Delivery address captured in UI but not passed to CF | `group_buy_detail_screen.dart` | Address dialog collects input but `joinGroupBuy` CF call doesn't include `deliveryAddress` param |
| R5-2 | Voucher distribution sets `hasCollected: true` immediately | `buyAdmin.ts` | `adminDistributeGroupBuyVouchers` marks vouchers as collected at distribution time, not when user actually claims |
| R5-3 | `collectedCount` not decremented on leave | `groupBuys.ts` | `leaveGroupBuy` doesn't adjust `collectedCount` — count diverges from reality |
| R5-4 | `confirmCollection` allows action when status is `targetMet` | `groupBuys.ts` | Should only allow collection on `completed` status |
| R5-5 | Collection double-count risk | `groupBuys.ts` | No idempotency check on `confirmCollection` — user can confirm multiple times |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| R5-6 | Community group buy creation still not wired in Flutter | Missing | CF `createGroupBuy` works but no Flutter screen allows community organizers to create |
| R5-7 | Hub group buy discovery dead code | Data layer | `getHubGroupBuys` CF exists but user's cluster IDs never fetched |
| R5-8 | Admin voucher upload has no duplicate code detection | `buyAdmin.ts` | Same voucher code can be uploaded twice across batches |
| R5-9 | `cancelCommunityGroupBuy` refund loop is not batched | `groupBuys.ts` | Processes all contributor refunds sequentially — timeout risk for large groups |
| R5-10 | `checkExpiredGroupBuys` processes all expired in single invocation | `groupBuys.ts` | No batch limit — could timeout with many expired group buys |
| R5-11 | Leave compensation fails silently if original wallet no longer exists | `groupBuys.ts` | Wallet deletion between join and leave = lost tokens |
| R5-12 | Organizer name resolution fragile | `groupBuys.ts` | Uses `userProfile.displayName` fallback but profile doc might not exist |
| R5-13 | `maxParticipants` enforced at join but not at admin creation | `buyAdmin.ts` | Admin curated group buy can set `maxParticipants: 0` |

### Medium

- `GroupBuyContributionModel` new fields (`voucherCode`, `hasCollected`, `collectedAt`, `walletId`) not yet added to model
- `cancelling` intermediate status adds complexity without clear benefit
- No ledger journal type for group buy operations
- Admin suggestions tab has approve/reject dialogs but no loading states
- `suggestGroupBuyDeal` deterministic ID doesn't prevent same user suggesting different deals with same hash
- Group buy detail screen doesn't show contribution history
- No deadline extension UI for organizers
- Physical group buy doesn't validate delivery address format
- Group buy search/filter not implemented on consumer side
- `leaveGroupBuy` doesn't check if group buy is in `cancelling` status
- Brand group buy `linkedListingId` validation doesn't check listing status
- No notification when group buy reaches target
- Contribution amount validation doesn't check minimum
- Group buy categories not implemented

### Low

- No group buy sharing/invite flow
- Progress bar doesn't animate on contribution
- No group buy recommendation algorithm
- Expired group buy visual state unclear
- No organizer dashboard for tracking contributions
- Contribution receipt not generated
- Group buy images not validated for size/format
- No group buy FAQ or help section
- Admin group buy list has no export functionality
- Contributor list not paginated

---

## FEATURE 6: ADMIN BACKEND (36 issues)

### Critical

| # | Issue | File | Description |
|---|-------|------|-------------|
| R6-1 | 5 new CFs missing `requireAppCheck` | `buyAdmin.ts` | `adminApproveGroupBuyRequest`, `adminRejectGroupBuyRequest`, `adminCreateCuratedGroupBuy`, `adminUploadGroupBuyVouchers`, `adminDistributeGroupBuyVouchers` skip app attestation |
| R6-2 | `logAdminAction` parameter order wrong in new CFs | `buyAdmin.ts` | Some new CFs pass parameters in wrong order to logging function — audit trail corrupted |
| R6-3 | `adminCreateCuratedGroupBuy` doesn't validate required fields | `buyAdmin.ts` | Missing validation for `title`, `description`, `targetAmount` — can create empty group buys |

### High

| # | Issue | File | Description |
|---|-------|------|-------------|
| R6-4 | Suspend cascade inconsistent with ban cascade | `buyAdmin.ts` | Ban cascades to `pending`/`flagged` listings (fixed) but suspend does not — suspended provider's listings remain active |
| R6-5 | `brandGroupBuy` `organizerId` could reference invalid user | `buyAdmin.ts` | No user existence check when setting `organizerId` |
| R6-6 | `adminExtendGroupBuyDeadline` no maximum extension limit | `buyAdmin.ts` | Can extend deadline indefinitely — no business rule cap |
| R6-7 | `adminDistributeGroupBuyVouchers` doesn't verify contributor eligibility | `buyAdmin.ts` | Distributes to all contributors regardless of payment status |
| R6-8 | Voucher upload accepts any string as code | `buyAdmin.ts` | No format validation — empty strings, duplicates within batch, special characters all accepted |
| R6-9 | `adminCreateCuratedGroupBuy` uses auto-generated ID | `buyAdmin.ts` | Not deterministic — retry creates duplicate group buys |
| R6-10 | Admin permission for new CFs may not be in all admin roles | `adminAuth.ts` | New permissions added to `platformAdminPerms` but not to `financeAdmin` where relevant |

### Medium

- Provider deletion cascade check queries only first 10 products
- `adminListVasProducts` pagination cursor not validated
- Featured item create/update doesn't validate `imageUrl` accessibility
- Admin group buy management screen doesn't show participant details
- Maker-checker pattern not applied to new group buy admin CFs
- `adminRejectGroupBuyRequest` doesn't notify the requester
- `adminApproveGroupBuyRequest` auto-creates group buy without validation of suggestion fields
- Curated group buy missing `termsAndConditions` field
- Voucher distribution doesn't check if group buy is completed
- Admin analytics queries have no date range limits
- Provider approval flow doesn't verify business documents
- Product price update doesn't invalidate existing cart items
- Admin audit log search has no pagination
- Featured content ordering conflicts not detected
- Ban/unban doesn't send notification to provider
- Soft-delete doesn't cascade to related sub-collections consistently

### Low

- Admin UI doesn't show timezone for scheduled operations
- No admin bulk operations (ban multiple, activate multiple)
- Admin dashboard metrics not cached
- Export functionality missing for all admin lists
- No admin notification preferences
- Admin role assignment has no expiry mechanism
- Audit log entries don't include IP address
- No admin session timeout warning
- Admin search doesn't support partial matching
- Provider onboarding workflow has no status tracking

---

## Cross-Cutting Themes (Post-Fix)

### 1. Incomplete Wiring (UI ↔ CF Gap)
Several fixes added UI elements or CF capabilities that aren't fully connected:
- Delivery address captured but not sent to CF (R5-1)
- Make Offer screen built but CF call is TODO (R4-5)
- Seller dashboard route exists but screen not implemented
- Community group buy creation CF works but no Flutter UI

### 2. Validation Layer Mismatches
Validation rules differ between Flutter and CF layers:
- Recipient phone regex differs between BLoC and datasource (R3-3)
- `refundType` snake_case vs camelCase (R4-1)
- `orderId` required in event but optional in repo chain (R2-1)

### 3. Idempotency Gaps (Remaining)
While major escrow idempotency was fixed, several operations still lack it:
- Order creation on offer accept (R4-3)
- Collection confirmation (R5-5)
- Curated group buy creation (R6-9)
- Voucher distribution (R5-2 semantics)

### 4. Missing `requireAppCheck` on New CFs
5 newly added admin CFs skip app attestation — security gap (R6-1)

### 5. Cascade Inconsistencies
Provider status changes (ban/suspend/delete) cascade differently:
- Ban → cascades to active/paused/pending/flagged listings
- Suspend → only cascades to active/paused (not pending/flagged)
- Delete → blocked if active products but not if pending products

---

## Recommended Priority Order (Post-Fix)

### Tier 1: Fix Immediately (Data Integrity / Security)
1. R4-1: Fix `refundType` format mismatch (snake_case ↔ camelCase)
2. R4-2: Parse `sellerName` in `MarketplaceOfferModel`
3. R5-1: Wire delivery address from UI to CF
4. R4-5: Complete Make Offer CF call (remove TODO)
5. R6-1: Add `requireAppCheck` to 5 new admin CFs
6. R6-2: Fix `logAdminAction` parameter order
7. R2-1: Align `orderId` type across repository chain
8. R3-1: Integrate step-up auth before purchases
9. R5-2: Fix voucher distribution `hasCollected` semantics
10. R5-5: Add idempotency to `confirmCollection`

### Tier 2: Fix Before Launch (Correctness)
11. R1-1: Add `isDeleted`/`isActive` filter to carousel
12. R2-2: Filter deactivated coupons
13. R3-2: Filter `isDeleted` products in datasource queries
14. R3-3: Align recipient validation regex
15. R4-3: Deterministic order ID on offer accept
16. R5-3: Fix `collectedCount` on leave
17. R5-4: Restrict `confirmCollection` to `completed` status
18. R6-3: Validate required fields in curated group buy creation
19. R6-9: Deterministic ID for curated group buys

### Tier 3: Fix Soon (Completeness)
20-30: Remaining high-severity items (cascade consistency, missing wiring, pagination)

### Tier 4: Polish
31+: Low-severity items (UI polish, export, notifications)
