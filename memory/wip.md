# WIP: BATCH 5 — Flutter BLoC + Plumbing Fixes

## Status: COMPLETE (pending build_runner)

## Fixes
1. **Fix 1 (F2-H4)**: Added `orderId` (optional) to `submitBrandReview` chain: event -> bloc -> repo -> impl -> CF call data map. Updated `_ReviewSubmissionSheet` and `_showReviewBottomSheet` to accept and pass orderId.
2. **Fix 2 (F2-G2)**: Hydrated `isFollowing` from server in `_onLoadStorefront`. Added `isFollowingBrand` method to: `BuyRemoteDataSource` (checks `brandStorefronts/{id}/followers/{uid}` subcollection), `BuyRepositoryImpl`, `BuyRepository`.
3. **Fix 3 (F2-G1)**: Removed dead `mutualFollowers` and `mutualFollowerCount` fields from `BrandStorefrontState`.
4. **Fix 4 (F4-J6 + F3-J2)**: Added `StepUpAuthService` dependency to `OrderBloc` and `PurchaseBloc`. Step-up auth check added before `_onBuyItem` and `_onMakePurchase`.
5. **Fix 5 (C3-2)**: Wired `completeGroupBuy` CF: event, state (`isCompleting`), bloc handler, repository, impl, datasource.
6. **Fix 6 (F2-J4)**: Wired `showChatButton` — conditional chat button in `_buildBrandHeader`. Updated method signature to accept `BuildContext`.
7. **Fix 7 (F4-J5)**: Added `PaymentProtectionExplainer` widget to `MarketplaceListingDetailScreen` above provider card.
8. **Fix 8 (F5-F5)**: Added FCM notification to organizer in `leaveGroupBuy` CF after escrow refund.

## Next Step
Run `dart run build_runner build --delete-conflicting-outputs` to regenerate freezed files.
