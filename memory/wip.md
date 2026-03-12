---
name: Buy Tab Full Implementation
description: Completing all missing Buy Tab features — CFs, Flutter plumbing, BLoC handlers
type: project
---

# Current Task: Buy Tab Full Implementation

## Status: WAVES 1-5 COMPLETE — Ready to commit (2026-03-12)

## What Was Done

### Wave 2: Cloud Functions (TypeScript)
- **marketplace.ts**: 11 callable CFs + 5 scheduled + 1 trigger (onFavouriteWrite)
- **buyAdmin.ts**: 7 admin moderation + 4 brand product CRUD + 10 VAS CRUD + 1 migration
- **groupBuys.ts**: 3 callable CFs + 1 scheduled (sendGroupBuyReminders)
- **brands.ts**: 5 CFs (claimStorefrontCoupon, recordStorefrontView, getBrandAnalytics, getBrandMutualFollowers, toggleBrandFollow)
- **buyNotifications.ts**: Extended onMarketplaceOrderUpdated + 5 new triggers
- **adminAuth.ts**: Added 22 new AdminPermission entries + role mappings

### Wave 3: Flutter Presentation
- **BrandStorefrontBloc**: 3 new handlers (claimCoupon, recordView, toggleFollow)
- **MarketplaceBloc**: 6 new handlers (updateListing, toggleListingStatus, renewListing, makeOffer, respondToOffer, sellerRefund)
- **GroupBuyBloc**: 3 new handlers (confirmCollection, cancelGroupBuy, updateDeliveryStatus)
- **BuyRepository**: 3 new abstract methods + implementations (claimStorefrontCoupon, recordStorefrontView, toggleBrandFollow)
- **MarketplaceRepository**: 7 new implementations already existed from prior session
- **GroupBuyRepository**: 3 new implementations (confirmCollection, cancelGroupBuy, updateDeliveryStatus)
- **State files**: Added loading flags and success messages for all new operations
- **brand_storefront_screen.dart**: Fixed 8 section builders (video.title nullable, richTextBlocks Map iteration)

### Wave 4: Config & Exports
- **index.ts**: Already covered by wildcard exports
- **adminAuth.ts**: 22 new permissions added to type + platformAdmin/financeAdmin role arrays

### Wave 5: Build & Verify
- TypeScript: `npx tsc --noEmit` — CLEAN
- `build_runner`: 2332 outputs generated successfully
- `flutter analyze`: 0 errors in modified files (remaining errors all pre-existing in test files + Drift)
- `pubspec.yaml`: flutter_quill upgraded ^10.8.5 → ^11.5.0 (required for intl 0.20.2 compat)

## Files Modified
- `functions/src/marketplace.ts`, `buyAdmin.ts`, `groupBuys.ts`, `brands.ts`, `buyNotifications.ts`, `adminAuth.ts`
- `lib/domain/repositories/buy_repository.dart`, `group_buy_repository.dart`, `marketplace_repository.dart`
- `lib/data/repositories/buy_repository_impl.dart`, `group_buy_repository_impl.dart`, `marketplace_repository_impl.dart`
- `lib/data/datasources/remote/marketplace_remote_datasource.dart`, `group_buy_remote_datasource.dart`
- `lib/presentation/blocs/brand_storefront/` (bloc, event, state)
- `lib/presentation/blocs/marketplace/` (bloc, event, state)
- `lib/presentation/blocs/group_buy/` (bloc, event, state)
- `lib/presentation/screens/buy/brand_storefront_screen.dart`
- `pubspec.yaml`, `pubspec.lock`

## Next Steps
1. Commit all changes
2. Push (with user approval)
3. Fresh-eyes audit of entire Buy Tab implementation
