# WIP: Fix All 144 Re-Audit Issues (Post-Fix Round 2)

## Status: COMPLETE

## Verification Results
- `npm run build` (TypeScript): PASS — zero errors
- `dart run build_runner build`: PASS — 71 outputs generated
- `flutter analyze lib/`: PASS — zero errors (432 info-level lints only, all pre-existing)
- Zero TODOs from our fixes in any CF or Flutter file

## Summary of All Changes

### marketplace.ts — 8 fixes
- R4-1: refundType format consistency (snake_case everywhere)
- R4-3: Deterministic order ID on offer accept
- R4-8: proposeResolution amount bounds validation
- Added missing fields to offer-accept order doc
- renewListing renewalExpiresAt field

### groupBuys.ts — 15 fixes
- R5-1: deliveryAddress in joinGroupBuy
- R5-3: collectedCount decrement on leave
- R5-4/R5-5: confirmCollection restricted + idempotent
- R5-9: Batched cancellation refunds
- R5-10: Expired query batch limit
- R5-11: Wallet validation on leave
- R5-12: Organizer name fallback
- FCM target-met notification
- Contribution amount validation
- Leave blocking for terminal statuses
- Auto-completion past collection deadline

### buyAdmin.ts + adminAuth.ts — 18 fixes + 2 executors
- R6-1: requireAppCheck on 5 new CFs
- R6-3: Field validation (type/fulfilmentType enums)
- R6-4: Suspend cascade to pending/flagged
- R6-5: organizerId validation
- R6-6: 90-day max extension
- R6-7: Contributor eligibility filter
- R6-8: Voucher code dedup/validation
- R6-9: Deterministic IDs
- R6-10: Finance admin permissions
- Maker-checker, notifications, cascading deletes, ordering conflicts

### brands.ts + purchases.ts — 10 fixes
- R2-6: Coupon validation + redeemStorefrontCoupon CF
- R3-4: Purchase record failure admin alerting
- R3-5: Provider isActive re-check
- Electricity validation, soft-delete filtering, clear error messages

### Flutter domain/data — 17 fixes
- R1-1/R1-2: FeaturedItem isDeleted + opacity parsing
- R1-4: Cache TTL
- R2-2/R2-3/R2-4/R2-5: Coupon filter, follow guard, review refresh, followedAt
- R3-2/R3-3: isDeleted query filter, regex alignment
- R4-5: Make Offer wired to MarketplaceEvent.makeOffer
- R5-1: deliveryAddress full chain wiring
- R16/R17: Buy confirmation dialog, delivery method display
- getOffer + loadLinkedOffer for offer chain display

### Flutter presentation — 25+ fixes
- Video lifecycle, timer nulling, community filtering
- Admin schedule pre-population, video loading state, empty states
- Rating validation, dead state removal, product navigation
- Reviews pagination, coupon counts, follow optimistic update
- Fee breakdown, search debounce, out-of-stock indicator
- Contribution history, deadline extension UI, address validation
- Group buy filters, share flow, progress animation, expired visual
- Offer chain display, seller dashboard screen
