# Buy Tab — Comprehensive Implementation Plan

> **Source of truth**: `memory/buy_tab_complete.md` (design spec)
> **This document**: Step-by-step implementation plan with phases, tasks, file paths, and verification criteria.
> **Rule**: NO implementation without explicit user approval. Check off tasks as completed.

---

## Phase 0: Foundation & Entities (Prerequisites for all other phases)

**Goal**: Colour tokens, entity/model/enum changes, Drift tables, build_runner — the bedrock everything builds on.

**Prerequisites**: None (this is first)

### 0.1 Buy Colour Tokens (Spec §2)

- [ ] Add 21 colour tokens to `lib/core/theme/app_colors.dart` as static constants
  - Backgrounds: `buyBackground (#F5F7FA)`, `buyCard (#FFFFFF)`, `buyCardBorder (#E8ECF1)`, `buyDivider (#EAECF0)`, `buyChipBg (#F1F5F9)`, `buyChipBorder (#E2E8F0)`, `buyShadow (rgba(0,0,0,0.05))`
  - Text: `buyTextPrimary (#1A1A2E)`, `buyTextSecondary (#64748B)`, `buyTextTertiary (#94A3B8)`
  - Status: `buyError (#DC2626)`, `buyWarning (#F59E0B)`, `buySuccess (#059669)`
  - Feature accents: `buyGroupBuyAccent (#059669)`, `buyGroupBuyAccentLight (#10B981)`, `buyMarketplaceAccent (#08C2F4)`, `buyMarketplaceAccentDark (#0974FF)`
  - Offline banner: `buyOfflineBg (#FFF8E1)`, `buyOfflineBorder (#FFE082)`, `buyOfflineText (#B45309)`
  - Shimmer: `buyShimmerBase (#E2E8F0)`, `buyShimmerHigh (#F1F5F9)`

**Verify**: All 21 tokens defined, no existing tokens overwritten.

### 0.2 New Enums (Spec §8.25)

- [ ] CREATE `lib/domain/enums/service_area_type.dart` — `ServiceAreaType { myLocationOnly, deliverNearby, nationwide }`
- [ ] CREATE `lib/domain/enums/seller_level.dart` — `SellerLevel { newSeller, active, trusted, star }`
- [ ] CREATE `lib/domain/enums/delivery_method.dart` — `DeliveryMethod { collection, delivery, both }`
- [ ] CREATE `lib/domain/enums/delivered_via.dart` — `DeliveredVia { inPerson, courier, leftAtLocation }`
- [ ] CREATE `lib/domain/enums/dispute_reason.dart` — `DisputeReason { notReceived, notAsDescribed, damaged, sellerUnresponsive, other }`
- [ ] CREATE `lib/domain/enums/dispute_resolution.dart` — `DisputeResolution { refundBuyer, releaseToSeller, partialRefund, requireReturn, split }`
- [ ] CREATE `lib/domain/enums/refund_type.dart` — `RefundType { buyerDispute, sellerInitiated, deliveryTimeout, adminAction, confirmationTimeout }`
- [ ] CREATE `lib/domain/enums/offer_status.dart` — `OfferStatus { pending, accepted, declined, countered, expired, withdrawn }`

### 0.3 Enum Modifications (Spec §8.25, §14.5)

- [ ] MODIFY `lib/domain/enums/marketplace_category.dart` — Replace all values with 8-category system: `foodAndDrinks, beautyAndWellness, homeAndProperty, clothingAndFashion, fixAndRepair, movingAndDelivery, kidsPetsAndCare, everythingElse`
- [ ] MODIFY `lib/domain/enums/provider_status.dart` — REMOVE `pending`, `rejected`. RENAME `approved` → `active`. ADD `banned`. Final: `active, suspended, banned`
- [ ] MODIFY `lib/domain/enums/listing_status.dart` — ADD `paused`, `expired`, `sold`. REMOVE `soldOut`. Final: `active, paused, expired, flagged, removed, sold`
- [ ] MODIFY `lib/domain/entities/purchase.dart` (PurchaseCategory enum) — ADD `marketplace, school, municipal, insurance, funeral, stokvel, gaming` (Spec §14.5: `marketplace` value for marketplace order history tracking)
- [ ] UPDATE corresponding TypeScript enum in `functions/src/purchases.ts` — add matching values: `marketplace`, `school`, `municipal`, `insurance`, `funeral`, `stokvel`, `gaming` to the PurchaseCategory type/enum
- [ ] UPDATE VAS Mapping dropdown in `buy_category_management_screen.dart` — add `school`, `municipal`, `insurance`, `funeral`, `stokvel`, `gaming` options

### 0.4 New Entities (Spec §8.25)

- [ ] CREATE `lib/domain/entities/sa_location.dart` — Freezed: id, name, type, parentId, province, city, postalCode, latitude, longitude
- [ ] CREATE `lib/domain/entities/saved_listing.dart` — Freezed: listingId, savedAt, listingTitle, listingPrice, listingThumbnailUrl, listingStatus, sellerName
- [ ] CREATE `lib/domain/entities/marketplace_offer.dart` — Freezed: id, listingId, buyerId, sellerId, offerAmount, originalPrice, status, counterAmount, chatConversationId, expiresAt
- [ ] CREATE `lib/domain/entities/marketplace_dispute.dart` — Freezed: reason (DisputeReason), details, photos (List<String>), sellerResponse, sellerPhotos (List<String>), proposedResolution, resolution (DisputeResolution?), resolutionAmount (int?), resolutionNote (Spec §8.25)
- [ ] CREATE `lib/domain/entities/location_data.dart` — Freezed value object: provinceId, province, cityId, city, suburbId, suburb, postalCode, coordinates

### 0.5 Entity Modifications (Spec §8.25)

- [ ] MODIFY `lib/domain/entities/marketplace_listing.dart`:
  - ADD: `location: LocationData?`, `serviceAreaType: ServiceAreaType`, `deliveryMethod: DeliveryMethod`, `deliveryFee: int?`, `geohash: String?`, `favouriteCount: int`, `expiresAt: DateTime?`, `renewalCount: int`, `totalPausedDays: int`, `pausedAt: DateTime?`
  - CHANGE: `category` type from old `MarketplaceCategory` enum to `String` — validated against the 8-value `MarketplaceCategory` enum at runtime
  - CHANGE: `status` to use updated `ListingStatus` enum
- [ ] HANDLE `category` field type migration (breaking change, §8.25):
  1. Change `MarketplaceListing.category` Freezed field from `MarketplaceCategory` enum to `String`
  2. Update `MarketplaceListingModel.fromJson()` to read `category` as `String` (currently reads as enum)
  3. Update `MarketplaceListingModel.toJson()` to write `category` as `String`
  4. Add `MarketplaceCategory.fromString(String)` helper that validates the value against the 8 allowed values and throws on unknown
  5. Update all Firestore queries that filter by `category` — these already use string equality in Firestore, so the query value changes from `MarketplaceCategory.x.name` to the new string constant
  6. Update `marketplace_hub_screen.dart` category chips to use new 8-category string values
  7. Update `buy_category_management_screen.dart` admin filters
  8. Build one-off `migrateListingCategories` CF in Phase 8.5 to map existing Firestore listing docs from old 5-category values to new 8-category values (e.g. `electronics` → `everythingElse`, create explicit mapping table)
- [ ] MODIFY `lib/domain/entities/marketplace_provider.dart`:
  - ADD: `categories: List<String>`, `subCategories: List<String>?`, `sellerLevel: SellerLevel`, `avgResponseTimeHrs: double?`, `warningCount: int`, `reportCount: int`, `disputeRate: double`, `cancellationRate: double`, `suspensionReason: String?`, `suspensionTrigger: String?`, `suspendedAt: DateTime?`, `bannedAt: DateTime?`, `profileLocation: LocationData?`
  - REMOVE: `servicesDescription` (deferred to progressive disclosure)
- [ ] MODIFY `lib/domain/entities/buy_order.dart`:
  - ADD: `deliveryFee: int?`, `totalAmount: int`, `deliveryMethod: String`, `deliveredVia: String?`, `trackingInfo: String?`, `deliveryDeadline: DateTime?`, `buyerConfirmationDeadline: DateTime?`, `refundType: String?`, `disputeDetails: String?`, `disputePhotos: List<String>?`, `sellerDisputeResponse: String?`, `sellerDisputePhotos: List<String>?`, `sellerProposedResolution: String?`, `disputeResolutionAmount: int?`, `disputeResolutionNote: String?`, `refundedAt: DateTime?`
- [ ] VERIFY `BuyOrder` entity preserves existing `chatConversationId: String?` field (already present per §14.2) — when adding the new fields above, ensure this existing nullable field remains in the Freezed class, the model's `fromJson`/`toJson`, and the mapper. It is used by `order_detail_screen.dart` for the "Chat with Seller" button.
- [ ] MODIFY vouch entity: ADD `orderId: String?`, `quickTags: List<String>?`, `deliveryMethod: String?`
- [ ] MODIFY `UserProfile` entity: ADD `profileLocation: LocationData?`, `selectedClusters: List<String>?`

### 0.6 BrandStorefront Entity Additions (Spec §4.14)

- [ ] MODIFY `lib/domain/entities/brand_storefront.dart`:
  - ADD: `isDraft: bool`, `publishedAt: DateTime?`, `tier: String`, `heroFocalPointX: double`, `heroFocalPointY: double`, `showChatButton: bool`, `bannerVideoUrl: String?`
  - ADD: `announcementText: String?`, `announcementDeepLink: String?`, `announcementDismissible: bool`
  - ADD: `showcaseVideos: List<ShowcaseVideo>`, `coupons: List<StorefrontCoupon>`, `faqItems: List<FaqItem>`
  - ADD: `testimonialReviewIds: List<String>`, `locations: List<BrandLocation>`
  - ADD: `richTextBlocks: Map<String, String>`, `sectionSettings: Map<String, SectionSettings>`
  - ADD: `totalViews: int`
- [ ] SET Freezed defaults for new BrandStorefront fields:
  - `isDraft` → `@Default(true)` — new storefronts start as unpublished drafts. "Publish" action in admin builder (Phase 2.13) sets `isDraft: false` and writes `publishedAt: DateTime.now()`
  - `tier` → `@Default('standard')` — all storefronts begin at standard tier until admin upgrades via `updateBrandTier` CF (Phase 2.14)
  - `showChatButton` → `@Default(false)` — opt-in per brand
  - `announcementDismissible` → `@Default(true)`
  - `totalViews` → `@Default(0)`
  - `heroFocalPointX` → `@Default(0.5)`, `heroFocalPointY` → `@Default(0.5)` — centre-crop default

### 0.7 GroupBuy Entity Modifications (Spec §9.16)

- [ ] MODIFY GroupBuy entity: ADD `collectionDeadline`, `deliveryStatus`, `fulfilmentInstructions`, `collectedCount`, `category`, `deliveryFee`, `organizerSuccessRate`
- [ ] MODIFY GroupBuyContribution entity: ADD `voucherCode`, `hasCollected`, `collectedAt`, `walletId`, `deliveryAddress`
- [ ] MODIFY GroupBuyRequest entity: ADD `imageUrl: String?` (Spec §9.16 — photo attached to suggestion, missing from form UI)

### 0.8 New & Modified Models + Mappers (Spec §8.25)

- [ ] CREATE `SaLocationModel`, `SavedListingModel`, `MarketplaceOfferModel`, `MarketplaceDisputeModel`, `LocationDataModel` in `lib/data/models/`
- [ ] MODIFY `MarketplaceListingModel`, `MarketplaceProviderModel`, `BuyOrderModel`, `VouchModel` — mirror entity changes
- [ ] MODIFY `BrandStorefrontModel` — mirror all new fields
- [ ] MODIFY `GroupBuyModel`, `GroupBuyContributionModel`, `GroupBuyRequestModel` — mirror new fields
- [ ] UPDATE all `toEntity()` / `fromEntity()` / `fromJson()` / `toJson()` methods

### 0.9 New Drift Tables (Spec §12.1)

- [ ] ADD 7 new tables to `lib/data/datasources/local/app_database.dart`:
  1. `LocalBrandStorefronts` — full entity cache, TTL 1hr
  2. `LocalBrandProducts` — per-storefront cache, TTL 30min
  3. `LocalBrandReviews` — top 20 per brand, TTL 30min
  4. `LocalGroupBuys` — active only, TTL 15min
  5. `LocalGroupBuyRequests` — user's own, TTL 1hr
  6. `LocalMarketplaceListings` — top 50 recent, TTL 30min
  7. `LocalMarketplaceOrders` — user's own orders, TTL 15min
- [ ] ADD `sa_locations` table — shipped SA location database (~22K rows)
- [ ] ADD `saved_listings` table — offline favourites cache (consumed in Phase 3.18 Favourites; included in Phase 0 to avoid a second schema migration later)
- [ ] DROP `LocalBuyRegulars` table (dead feature, §7) — add explicit `m.deleteTable('local_buy_regulars')` step in migration
- [ ] Bump schema version, write migration (single version bump covering all new tables + the drop)

### 0.10 Package Dependencies (Spec §4, §8, §12)

- [ ] ADD to `pubspec.yaml` (if not already present):
  - `flutter_colorpicker` — colour pickers in admin storefront builder (§4.7)
  - `flutter_quill` (or similar) — rich text editor for Description/Rich Text sections (§4.8)
  - `confetti` (optional) — coupon claim + level-up celebration animations (§4.8, §8.7)
  - `geolocator` — GPS integration for "Near me" location filtering (§8.17)
  - `flutter_markdown` — markdown rendering in brand storefront richText sections (§4.8)
  - `easy_localization` — string extraction and localization (§12.8)
  - Verify `mobile_scanner`, `url_launcher`, `cached_network_image` already present

### 0.11 Run build_runner

- [ ] `dart run build_runner build --delete-conflicting-outputs`
- [ ] Fix any generated code conflicts
- [ ] Verify all `.freezed.dart`, `.g.dart`, `injection.config.dart` files regenerate cleanly

**Verify**: `flutter analyze --fatal-infos` passes with zero errors.

---

## Phase 1: Hub Redesign & Light Theme (Spec §2, §3, §6, §7)

**Goal**: Transform Buy tab hub from dark to light theme. Remove dead features. Wire utilities. Convert all 5 utility screens to light theme.

**Prerequisites**: Phase 0 complete.

### 1.1 Hub Screen Light Theme (Spec §3)

- [ ] `lib/presentation/screens/buy/buy_services_screen.dart`:
  - Remove `LinearGradient` body background → solid `buyBackground`
  - Remove `_buildMyRegulars()` call and imports
  - Update shimmer colours: base `buyShimmerBase`, highlight `buyShimmerHigh`
  - Update error/empty state cards to white card + border style
  - Update RefreshIndicator: spinner `AppColors.primary`, bg `buyCard`

### 1.2 Layer Dividers (Spec §3)

- [ ] MODIFY `lib/presentation/widgets/buy/buy_layer_divider.dart`:
  - Change from 8px solid block to 1px line `buyDivider` + 16px padding top/bottom

### 1.3 Utilities Chips (Spec §6)

- [ ] MODIFY `lib/presentation/widgets/buy/buy_category_tile.dart`:
  - Dense chip: 18px icon (from `fintech_icons_light_dark_pack/` PNGs scaled to 18×18) + 11px label, 8px radius, white bg, `buyCardBorder` border, `buyShadow` shadow
  - Padding: `4px 8px 4px 5px`
  - Label: 11px, weight 600, `buyTextPrimary`
  - Tap: border → cyan `#08C2F4`
  - Min height: 44px (accessibility, §12.6)
  - Icon mapping: Electricity→`lightning_48.png`, Airtime→`phone_48.png`, Data→`wifi_48.png`, Vouchers→`ticket_48.png`, School→`cap_48.png`, Municipal→`bank_48.png`, Insurance→`insurance_48.png`, Funeral→`funeral_48.png`, Stokvel→`users_48.png`, Gaming→`gaming_48.png`
  - Short labels: "School" (not "School Fees"), "Municipal" (not "Municipal Bills")
- [ ] MODIFY `lib/presentation/widgets/buy/buy_category_grid.dart`:
  - Flat `Wrap` layout, 6px spacing, no group labels
- [ ] MODIFY tap behaviour: ALL categories → `/buy/category/:purchaseCategoryMapping` (no subcategory detour)
- [ ] UPDATE `_onCategoryTap` in hub screen
- [ ] Visibility rules: only show `isActive == true` chips, sort by `sortOrder`, `isComingSoon` chips greyed + "SOON" badge + not tappable

### 1.4 Remove My Regulars + Recent Recipients (Spec §7, §6)

- [ ] DELETE `lib/presentation/widgets/buy/my_regulars_dock.dart` (or mark deprecated)
- [ ] Remove all imports/references from `buy_services_screen.dart`
- [ ] Remove `getRecentRecipients()` from `purchase_remote_datasource.dart`
- [ ] Remove `loadRecentRecipients` / `selectRecentRecipient` from `purchase_bloc.dart` / events / state
- [ ] Remove corresponding methods from `purchase_repository.dart` (domain interface) and `purchase_repository_impl.dart` (implementation)
- [ ] Remove `purchase_event.dart` entries for `loadRecentRecipients`, `selectRecentRecipient`
- [ ] Do NOT show recent recipients in the recipient input field

### 1.5 Marketplace Entry Card — Option B Elevated (Spec §8.1)

- [ ] Rebuild marketplace hub card in `buy_services_screen.dart` as a **static promotional card** (no CF call, no live data):
  - Cyan-tinted gradient bg, 4px gradient left accent bar (`#08C2F4` → `#0974FF`)
  - 56x56 storefront icon circle with cyan glow
  - Title: "Intengiso Marketplace", 16px, w800
  - Full-width gradient CTA: "Explore Marketplace →"
  - All content is hardcoded — trending thumbnails and listing counts are only fetched when the user navigates to the marketplace hub screen (Phase 3.1)
  - Do NOT call `getMarketplaceStats` (dead code, removed in Phase 9.1) or add `loadMarketplaceStats` to `BuyTabBloc`

### 1.6 Hlangana Group Buys Hub Card (Spec §9.2)

- [ ] Rebuild group buys hub card:
  - White card + green tint `rgba(5,150,105,0.02)`, 4px solid `#059669` left accent
  - Handshake icon + title + subtitle
  - Green CTA button

### 1.7 Cluster Opt-In Card (Spec §3, §9.4)

- [ ] Update cluster opt-in styling: white card, green accent, `#059669` icon/button

### 1.8 Offline Banner Integration (Spec §10.4, §12.1)

- [ ] Wire `BuyOfflineBanner` into `BuyServicesScreen` via `BlocBuilder<ConnectivityBloc>`
- [ ] Update banner colours to light theme: `buyOfflineBg`, `buyOfflineBorder`, `buyOfflineText`

### 1.9 BuyTabBloc Updates (Spec §3)

- [ ] ADD event `loadUserClusters` — reads `selectedClusters` from user profile
- [ ] ADD state field `userClusters: List<String>`
- [ ] Wire `GroupBuyBloc.loadHubGroupBuys(clusters)` from `loadBuyTab` handler
- [ ] Implement hub group buy **ranking algorithm** (Spec §9.5) in datasource `getGroupBuysForHub()`:
  - `score = (percentComplete × 0.4) + (endingSoon × 0.3) + (clusterMatch × 0.3)`
  - `percentComplete` = currentTokens / targetTokens (0–1)
  - `endingSoon` = 1.0 if ≤24h remaining, 0.5 if ≤72h, 0.0 otherwise
  - `clusterMatch` = 1.0 if deal cluster is in user's `selectedClusters`, 0.0 otherwise
  - Sort descending by score, return top N for hub display

### 1.10 Feature Flag Wiring (Spec §11.6)

- [ ] Wire `FeatureFlagBloc.isEnabled()` into hub section visibility
- [ ] Check flags: `buy_featured_carousel`, `buy_marketplace`, `buy_group_buys`, `buy_vas_utilities`

### 1.11 Utility Screens Light Theme — Detailed (Spec §6)

All 5 screens require full light theme conversion per spec §6 detailed colour specs:

#### BuyCategoryScreen (Spec §6 — Provider Grid → Product List → Recipient → Purchase)
- [ ] Remove `WaveBackground` → solid `buyBackground (#F5F7FA)`. AppBar stays dark (IMaliAppBar)
- [ ] Provider Grid: white cards `buyCard`, 1px `buyCardBorder`, 12px radius, `buyShadow`, 3 columns, initials fallback: circle `buyChipBg` bg + `buyTextPrimary` text. Tap: border → cyan, subtle scale
- [ ] Provider Grid empty state: white card, 48px `Icons.store_outlined` `buyTextTertiary`, "No providers available" `buyTextSecondary`, outline retry button
- [ ] Provider Grid shimmer: `buyShimmerBase` / `buyShimmerHigh`, match 3-column grid
- [ ] Recipient Input: white card container, `buyDivider` bottom border, label 14px w600 `buyTextPrimary`, TextField fill `buyChipBg`, border `buyCardBorder`, focus `#08C2F4` cyan, hint `buyTextTertiary`, QR scanner icon cyan (electricity only)
- [ ] Product List: white cards, 1px `buyCardBorder`, selected 2px cyan border, 12px radius, `buyShadow`, name 15px w600, description 13px `buyTextSecondary`, validity 12px `buyTextTertiary`, price ZAR 17px bold tokenGold, price tokens 12px `buyTextTertiary`, selected checkmark cyan
- [ ] Product List empty/shimmer states per spec
- [ ] Purchase FAB: cyan bg `#08C2F4`, white text/icon, "Buy for X tokens", only when product selected AND recipient entered

#### BuyWalletSelectionScreen (Spec §6)
- [ ] **Step-up auth** (Spec §14.7): Before calling `processPurchase` CF, call `await StepUpAuthService.verify(context)`. If verification fails, do not proceed. Inject `StepUpAuthService` into `PurchaseBloc`.
- [ ] Body bg `buyBackground`, AppBar "Confirm Purchase"
- [ ] Purchase summary card: white, 12px radius, `buyCardBorder`, product name 16px w600, provider 13px `buyTextSecondary`, recipient with phone icon, 0.5px divider, price 20px w700 tokenGold
- [ ] Wallet cards: radio-style, selected 2px cyan border + cyan tint bg, unselected 1px `buyCardBorder`, wallet name 14px w600, balance 13px `buyTextSecondary`, insufficient: red + warning text, radio indicator cyan/grey
- [ ] Sub-account restriction: amber info row
- [ ] Sticky bottom: white bg, top border 0.5px, full-width cyan button 52dp, disabled `#E2E8F0` bg + `buyTextTertiary` text, processing white spinner

#### BuySuccessScreen (Spec §6)
- [ ] `buyBackground`, no AppBar, `PopScope(canPop: false)`
- [ ] 64px green circle checkmark, "Purchase Successful!" 22px w700, category-specific subtitle 14px `buyTextSecondary`
- [ ] Receipt card: white, 12px radius, `buyCardBorder`, rows (Product, Provider, Recipient, Amount tokenGold, Reference monospace, Date), 0.5px dividers
- [ ] Actions: "Back to Buy" cyan CTA → `/buy`, "View History" outline → `/buy/history`

#### BuyFailureScreen (Spec §6)
- [ ] `buyBackground`, `PopScope(canPop: false)`
- [ ] 64px red circle "!" icon, "Purchase Failed" 22px w700, error message 14px `buyTextSecondary`
- [ ] **Auto-refund notice**: Shield icon `#059669` + "Your tokens have been automatically refunded." — 14px green bold. **Always shown** — auto-refund is guaranteed (Spec §6 Purchase Auto-Refund)
- [ ] Attempted purchase card: same as success receipt but with 3px red left border
- [ ] Actions: "Try Again" cyan CTA → pop back to BuyCategoryScreen with state preserved, "Back to Buy" outline → `/buy`

#### BuyPurchaseHistoryScreen (Spec §6)
- [ ] `buyBackground`, AppBar "Purchase History"
- [ ] Filter chips: "All" (default) | category chips. Active: cyan tint bg + cyan border + text. Inactive: white + `buyCardBorder` + `buyTextPrimary`
- [ ] Status dropdown: "All" | "Completed" | "Failed" | "Refunded"
- [ ] Purchase cards: white, 12px radius, `buyCardBorder`. Row 1: provider logo 32px + product name 14px bold + status pill (completed green, failed red, refunded amber, pending cyan). Row 2: recipient 13px `buyTextSecondary` + amount tokenGold. Row 3: date + reference 12px `buyTextTertiary`. Tap: expand in-place to full receipt details
- [ ] Empty state: illustration + "No purchases yet" + "Go to Buy" cyan CTA
- [ ] Pagination: load 20 at a time, infinite scroll

**Verify**: Hub loads, all utility chips visible, light theme applied across all 5 utility screens, feature flags control section visibility, My Regulars + Recent Recipients completely removed.

---

## Phase 2: Featured Carousel & Brand Partners (Spec §4, §5)

**Goal**: Polish featured carousel, implement brand storefront enhancements.

**Prerequisites**: Phase 0-1 complete.

### 2.1 Featured Carousel Polish (Spec §5)

- [ ] Verify auto-advance 5s, pause on touch, lifecycle-aware
- [ ] Verify 4 card types render correctly (promotion, trending, collectible, campaign)
- [ ] Verify video support: muted auto-play, looping, fallback to poster image
- [ ] Verify dot indicators: active `#FF328C` 20px pill, inactive `#94A3B8` 6px circle
- [ ] Verify shimmer: `buyShimmerBase`, `buyShimmerHigh`, `buyCard` container
- [ ] Verify deep linking: GoRouter paths via `context.push()`, external URLs via `launchUrl()`
- [ ] **Community scoping** (Spec §14.4): `FeaturedItem` has `communityIds: List<String>`. Consumer query must filter: show only items where `communityIds` is empty (visible to all) OR contains one of the user's `communityIds`. Pass user's community IDs from `UserProfile.communityIds` into the featured items datasource query.

### 2.2 Brand Partners Strip Redesign (Spec §4.2)

- [ ] REBUILD `lib/presentation/widgets/buy/brand_partners_strip.dart`:
  - Card: ~140-160px wide, brand colour at 5-8% opacity over white
  - 3px left accent strip in brand colour
  - Shadow: brand colour at 8% opacity
  - Content: 40x40 logo, 13-14px bold name, 11-12px tagline, "Visit →" cyan link

### 2.3 BrandStorefront Entity Expansion (already in Phase 0.6)

- [ ] Verify all new fields from §4.14 are on entity, model, mapper

### 2.4 Brand Storefront Screen — 8 New Section Renderers (Spec §4.8)

- [ ] `announcementBar` — scrolling ticker, brand accent bg at 15%, dismiss per session
- [ ] `videoShowcase` — horizontal video card scroll, tap expands to inline player
- [ ] `couponCenter` — vertical coupon cards, "Claim" flow → CF → show code + copy
- [ ] `faq` — `ExpansionTile` accordion, one expanded at a time
- [ ] `testimonials` — horizontal `PageView` of large quote cards, auto-advance 6s
- [ ] `locationCard` — address cards with "Get Directions" button (maps intent)
- [ ] `divider` — configurable spacer/line (multi-instance)
- [ ] `richText` — markdown rendering via `flutter_markdown` (multi-instance)

### 2.5 Per-Section Colour Schemes (Spec §4.7.6)

- [ ] Implement `SectionSettings` with 4 colour modes: brand-light, brand-dark, brand-accent, custom
- [ ] Auto-text-colour logic: contrast ratio ≥ 4.5:1
- [ ] Apply padding, heading override, content alignment, visibility toggle per section

### 2.6 Consumer Experience Enhancements (Spec §4.11)

- [ ] Section entrance animations: fade in + slide up 16px, staggered 100ms per section, 400ms duration, `CurvedAnimation` with `Curves.easeOut`
- [ ] Hero parallax: 0.7× scroll speed via `SliverAppBar` + `FlexibleSpaceBar`
- [ ] Animated stats: `TweenAnimationBuilder<int>` for follower/rating counts, 800ms duration
- [ ] Follow button on hero: `[♡ Follow]` / `[✓ Following]` with follower count, optimistic UI update
- [ ] Share storefront: AppBar share icon → platform share intent with brand name + deep link
- [ ] Brand colour refresh: `RefreshIndicator` colour uses brand `accentColor`
- [ ] Section scroll-to: tapping section in admin reorder list scrolls preview to that section

### 2.7 Floating Chat Button (Spec §4.10)

- [ ] FAB bottom-right: chat icon, brand `accentColor` bg, shadow, navigates to brand DM
- [ ] Only shown if `showChatButton == true` AND brand messaging enabled

### 2.8 Brand Products Admin CFs (Spec §4.7.11)

- [ ] BUILD `adminListBrandProducts` in `buyAdmin.ts`
- [ ] BUILD `adminCreateBrandProduct` — writes to subcollection `brandStorefronts/{id}/products`
- [ ] BUILD `adminUpdateBrandProduct` — partial update
- [ ] BUILD `adminDeleteBrandProduct` — hard delete with logging

### 2.9 Coupon CF (Spec §4.8.3)

- [ ] BUILD `claimStorefrontCoupon` — validate, atomic increment, write claim record to `storefrontCoupons` collection, return code

### 2.10 Analytics CFs (Spec §4.12)

- [ ] BUILD `recordStorefrontView` — debounced (1 per user per brand per hour), daily aggregate
- [ ] BUILD `getBrandAnalytics` — returns daily data + summary for date range
- [ ] BUILD `getBrandMutualFollowers` — returns mutual friend names + count
- [ ] CREATE Firestore collection structure: `brandAnalytics/{brandId}/daily/{YYYY-MM-DD}`

### 2.11 BrandStorefrontBloc Updates (Spec §4.17)

- [ ] ADD events: `claimCoupon`, `recordView`, `toggleFollow`
- [ ] ADD state fields: `claimedCouponIds`, `isFollowing`, `mutualFollowers`, `mutualFollowerCount`
- [ ] Handler: `_onClaimCoupon`, `_onRecordView` (fire-and-forget), `_onToggleFollow` (optimistic)

### 2.12 Repository & Datasource Updates (Spec §4.18)

- [ ] ADD to `BuyRepository`: `claimCoupon()`, `recordStorefrontView()`, `getMutualFollowers()`
- [ ] ADD to `BuyRemoteDataSource`: corresponding CF calls
- [ ] UPDATE `getBrandStorefronts()` query: filter `isDraft == false` AND `isActive == true`
- [ ] **Community scoping** (Spec §14.4): `BrandStorefront` has `communityIds: List<String>`. Consumer query must filter: show only storefronts where `communityIds` is empty (visible to all) OR contains one of the user's `communityIds`. Pass user's community IDs into the brand storefronts datasource query. This applies to both the brand partners strip on the hub and the full brand storefront listing.

### 2.13 Admin — Brand Storefront Builder (Spec §4.7)

- [ ] REPLACE admin list+dialog approach with split-pane builder:
  - Left panel: 5 tabs (Basics, Hero & Visual Identity, Content & Links, Dynamic Content, Products) + Analytics tab
  - Right panel: phone-frame live preview (375×812px) rendering actual `BrandStorefrontScreen`
- [ ] Visual colour pickers: `flutter_colorpicker` package for all hex fields
- [ ] Image focal point: draggable pin on hero image preview, saves `heroFocalPointX`, `heroFocalPointY`
- [ ] Section management: add/reorder (`ReorderableListView`) /visibility toggle/duplicate/remove
- [ ] BUILD `duplicateStorefrontSection` CF in `buyAdmin.ts` (Spec §14.10): deep-copies a section within the same storefront (duplicates config, settings, content), appends to section order. Required for multi-instance section types (`divider`, `richText`). Admin-only, exported from `index.ts`.
- [ ] Active toggle (§4.7.7): immediate Firestore write, confirmation dialog on deactivate
- [ ] Draft/Publish workflow: auto-save every 30s via `Timer.periodic`, "Publish" validates required fields (name, logo, at least 1 section), sets `isDraft: false`, `publishedAt: DateTime.now()`
- [ ] Undo/Redo: 30-state in-memory stack using `List<BrandStorefrontState>`, Ctrl+Z / Ctrl+Shift+Z keyboard shortcuts
- [ ] Starter templates: 5 templates (Telecom, Retail, Restaurant, Services, Entertainment) — pre-configured section orders + placeholder content, loaded via "Start from template" button on create
- [ ] Validation rules per tab: Basics (name required, logo required), Hero (image required if hero section enabled), Products (at least 1 product if products section enabled)

### 2.14 Premium Tiers (Spec §4.13)

- [ ] Implement tier field: `standard`, `premium`, `featured`
- [ ] Consumer-side enforcement: check `storefront.tier` before rendering sections (standard: 9 original sections only, premium: +8 new sections, featured: premium + homepage spotlight)
- [ ] Admin-side: locked sections show lock icon + "Upgrade to Premium" tooltip
- [ ] BUILD `updateBrandTier` CF in `buyAdmin.ts` (Spec §14.10): changes a storefront's `tier` field (`standard` → `premium` → `featured` or downgrade). Admin-only with `requireAdmin`. On upgrade: unlock new section types. On downgrade: hide (don't delete) premium sections that are no longer accessible. Exported from `index.ts`.

### 2.15 Brand Products Migration (Spec §13.5)

- [ ] Migrate data from top-level `brandProducts` collection to `brandStorefronts/{id}/products` subcollection
- [ ] Update all queries to read from subcollection pattern
- [ ] Keep top-level `brandProducts` collection for backward compatibility during migration, then mark as deprecated

### 2.16 CF Expansion for create/update (Spec §4.15)

- [ ] EXPAND `adminCreateBrandStorefront` — accept ALL new fields + validation rules
- [ ] EXPAND `adminUpdateBrandStorefront` — accept ALL new fields + validation rules
- [ ] FIX `editBrandReview` — add brand aggregate recomputation: after edit, recalculate `averageRating` and `reviewCount` on the `BrandStorefront` document. Query all reviews for the brand where `isRemovedByAdmin == false` AND `isFiltered == false`, compute average of `overallRating`, update storefront doc atomically via Firestore transaction.
- [ ] FIX `adminFlagBrandReview` — exclude flagged/filtered reviews from aggregate: set `isFiltered: true` on the review doc, then recalculate `averageRating` and `reviewCount` on the `BrandStorefront` document (same transaction pattern as `editBrandReview`). This ensures flagged reviews don't skew the brand's public rating.

### 2.17 Drift Cache Integration

- [ ] Implement stale-while-revalidate for brand storefronts, products, reviews using new Drift tables

**Verify**: Brand strip renders light theme, storefront screen shows all 17 section types, coupons claimable, analytics tracking, admin builder functional with undo/redo + auto-save + templates.

---

## Phase 3: Marketplace — Consumer (Spec §8.2-8.21)

**Goal**: Full marketplace consumer experience — hub, listing cards, detail, orders, seller portal, chat enhancements, voice messages, offer system, first-time buyer UX.

**Prerequisites**: Phase 0-1 complete. Phase 2 preferred but not blocking.

### 3.1 Marketplace Hub Screen (Spec §8.2)

- [ ] REDESIGN `marketplace_hub_screen.dart`:
  - Trending strip at top (horizontal scroll, 160px cards with view counts)
  - Category chips (horizontal scroll, 8 categories + "All" default)
  - Subcategory filter chips (appear on category select)
  - Sort/filter bar: "Recommended", "Newest", "Price: Low→High", "Price: High→Low", "Nearest"
  - Location filter: "Near me" chip
  - Full-screen search overlay: recent searches, popular searches, autocomplete

### 3.2 Marketplace Listing Card (Spec §8.2)

- [ ] REDESIGN `marketplace_listing_card.dart`:
  - Image 1:1, price FIRST (anchoring), title second
  - Location row: pin icon + "Suburb, City"
  - Seller level badge + name + verified checkmark
  - Favourite heart (top-right), "NEW" badge (top-left if <24hrs)
  - Long-press: quick-view bottom sheet — shows larger image, price, title, seller info, "Buy Now" + "Message Seller" buttons, dismiss via tap outside or swipe down (Spec §8.2)

### 3.3 Listing Detail Screen (Spec §8.3)

- [ ] REDESIGN `marketplace_listing_detail_screen.dart`:
  - 4 progressive disclosure layers
  - Layer 1: image carousel, price (24px bold), title, category badge, location, listed time
  - Layer 2: seller card (tappable → profile), description, delivery method
  - Layer 3: "Payment Protection" expandable, seller's other listings, similar listings
  - Layer 4: report bottom sheet, terms
  - Trust stack above sticky CTA: 4 trust indicators
  - Sticky bottom CTA: "Message Seller" + "Buy Now — [price]" with price in button
  - "Make an offer" link → bottom sheet with price input (pre-fill 80%)

### 3.4 Buy Flow (Spec §8.3)

- [ ] 3-tap purchase: "Buy Now" → confirmation bottom sheet → "Pay" → success
- [ ] Confirmation sheet: listing summary, wallet balance, delivery method, trust indicator
- [ ] Processing: lock animation + haptic
- [ ] Success: checkmark animation + "Order placed!" + auto-create buyer-seller chat
- [ ] Step-up auth integration: call `StepUpAuthService.verify()` before purchase

### 3.5 Seller Portal (Spec §8.2 — NEW screen)

- [ ] CREATE `lib/presentation/screens/buy/seller_portal_screen.dart`:
  - State A (not registered): hero illustration, 3 "how it works" steps, category preview, "Start Selling" CTA
  - State B (active seller): earnings card, action cards row, quick actions, performance snapshot
  - State C (suspended): warning status card, reason, "Contact support"
  - State D (banned): permanent removal notice

### 3.6 My Listings Screen (Spec §8.2 — NEW)

- [ ] CREATE `lib/presentation/screens/buy/my_listings_screen.dart`:
  - Filter chips: All/Active/Paused/Expired/Sold with counts
  - Listing management cards: thumbnail, title, price, status pill, stats row, context-aware action buttons
  - Stale listing nudge: after 3+ renewals with <10 views — show inline nudge "This listing isn't getting much attention. Try updating your photos or lowering the price." (Spec §8.19)

### 3.7 Listing Edit (Spec §8.2)

- [ ] CREATE listing edit screen — reuse create form, pre-filled
- [ ] Price locked when active orders or pending offers exist (Spec §8.2 — show disabled state with explanation tooltip "Price can't be changed while you have active orders")
- [ ] Category immutable after creation (Spec §8.2 — field shown but disabled with "Category can't be changed" helper text)

### 3.8 Provider Registration — 2-Step Flow (Spec §8.2)

- [ ] REWRITE `provider_registration_screen.dart`:
  - Step 1: Display name (pre-filled from profile)
  - Step 2: Category selection (8 tiles, multi-select)
  - Inline confirmation + "Start Selling" → create provider with `status: active`
  - Progressive data collection: photo prompted after 1st sale, bio after 3rd sale, services after 5th sale — milestone prompts on seller portal screen (Spec §8.2)

### 3.9 Create Listing — Photo-First Flow (Spec §8.2)

- [ ] REDESIGN `create_listing_screen.dart`:
  - Step 1: Photo first (camera/gallery, up to 5, WebP max 200KB)
  - Step 2: Details form — title, category, price (with ZAR conversion + suggestion via `getPriceSuggestion` CF), description, service area, location (autocomplete), delivery method
  - Step 3: Preview — renders exact `MarketplaceListingCard` as buyers see it
  - Step 4: Success celebration — share to WhatsApp/iMali chat, "List another"
  - Listing quality indicator (0-100% progress bar)
  - Progressive upload: images upload immediately on selection

### 3.10 My Orders Screen (Spec §8.5)

- [ ] REDESIGN `my_orders_screen.dart`:
  - Tabs: "Buying" / "Selling"
  - Order cards: thumbnail + title + amount + counterparty + visual status tracker + action button
  - Visual status tracker: connected dots (Ordered → Held safely → Delivered → Done)
  - Context-aware action buttons per status

### 3.11 Order Detail Screen (Spec §8.13 — NEW)

- [ ] CREATE `lib/presentation/screens/buy/order_detail_screen.dart`:
  - Order header card, large visual status tracker
  - Delivery/collection timer (7-day countdown)
  - Order details section with payment breakdown
  - Context-aware action section (buyer/seller variants)
  - "Mark as delivered" flow (3 delivery method options: in person, courier, left at location)
  - "I received it" flow with inline review prompt

### 3.12 Dispute Flow — Full Lifecycle (Spec §8.14 — NEW)

- [ ] CREATE dispute initiation bottom sheet:
  - 5 reason cards (from `DisputeReason` enum), details field (min 20 chars), photo upload (max 3)
  - Language: "Submit concern" not "File dispute"
- [ ] CREATE seller dispute response:
  - Buyer's concern display, seller response field, evidence photos, proposed resolution chips (refund/partial/keep/return)
- [ ] Admin dispute resolution (covered in Phase 4): partial refund input, "Require return" option, resolution note
- [ ] Dispute timeline in order detail: show all dispute events chronologically (opened → seller notified → seller responded → admin resolved)
- [ ] Auto-refund unresponsive seller: 5-day escalation path (Day 1: push reminder → Day 2: SMS escalation → Day 4: final warning → Day 5: auto-refund) (Spec §8.26 notifications #15-#23)

### 3.13 Review / Vouch Flow (Spec §8.15)

- [ ] Inline review prompt after receipt confirmation:
  - 5 star rating (32px), quick tags (5 options), comment (optional)
  - "Skip" allowed → triggers 24hr + 72hr push reminders (max 2)
- [ ] Review display on seller profile: cards with verified purchase badge, sort options

### 3.14 Seller Level System (Spec §8.7)

- [ ] 4 levels: New Seller (grey), Active Seller (blue), Trusted (green shield), Star (gold star)
- [ ] Badge display on listing cards (14px), detail (icon + text), profile (24px + progress)
- [ ] Level-up celebration modal: confetti animation + badge animation + congratulations message + "Share achievement" button (Spec §8.7)
  - Active: "You've made 3 sales and earned your Active Seller badge."
  - Trusted: "Trusted Seller status. Your listings now get priority in search."
  - Star: "Star Seller status. You'll be featured on the trending strip."

### 3.15 Buyer-Seller Chat Enhancements (Spec §8.6)

- [ ] Quick reply chips above message input (buyer/seller contextual)
- [ ] In-chat "Make an Offer" chip → offer bottom sheet
- [ ] Offer message card with Accept/Decline buttons
- [ ] Order status system messages in chat thread
- [ ] "Buy Now" button in `ListingContextHeader`
- [ ] **Voice messages**: first-class citizen for low-literacy users (Spec §8.6)
  - Hold-to-record voice button (alongside text input)
  - Waveform visualization during recording
  - Playback with waveform in message bubble
  - Max 2 minutes per voice message
  - Opus codec, max 500KB per message
  - Reuse existing voice message infrastructure from chat if available, or create marketplace-specific implementation

### 3.16 Offer System — Full Lifecycle (Spec §8.6, §8.8)

- [ ] "Make an offer" bottom sheet on listing detail: price input pre-filled at 80% of listing price, token + ZAR display
- [ ] Offer message card in chat: shows offer amount, original price, Accept / Decline / Counter buttons
- [ ] Counter-offer flow: seller taps Counter → price input → sends counter-offer message card
- [ ] Offer acceptance: auto-creates order at accepted price, transitions to order flow
- [ ] 24-hour offer expiry: `OfferStatus.expired` set via scheduled CF, notification #46 sent to buyer
- [ ] Withdraw offer: buyer can withdraw before response via "Withdraw" action on offer card
- [ ] CFs: `makeOffer` (validate, create offer doc, send notification #42), `respondToOffer` (accept/decline/counter, send notifications #43-#45)

### 3.17 SA Location System (Spec §8.17)

- [ ] CREATE `lib/data/datasources/local/sa_location_datasource.dart` — Drift DAO for `sa_locations` table
- [ ] CREATE `lib/presentation/widgets/common/location_autocomplete.dart` — type-ahead, local DB query, debounce 200ms
- [ ] CREATE `lib/domain/entities/sa_location.dart` (already in Phase 0)
- [ ] CREATE `assets/sa_locations.db` or `assets/sa_locations.json.gz` — shipped ~22K locations
- [ ] Data prep script: OpenDB CSV → clean → deduplicate → convert to SQLite/JSON, fields: id, name, type (province/city/suburb), parentId, province, city, postalCode, latitude, longitude
- [ ] Geohash generation: compute geohash on listing create/update from coordinates for proximity queries
- [ ] Buyer-side location filtering: "Near me" / "My city" / "My province" / "Anywhere"
- [ ] GPS integration: `geolocator` package, single read per session (cached), client-side only, permission request dialog
- [ ] CREATE `SaLocationRepository` interface — `searchLocations(query)`, `getLocationById(id)`, `getProvinces()`, `getCitiesByProvince(provinceId)`

### 3.18 Favourites / Saved Items (Spec §8.18)

- [ ] Heart icon on listing card + detail
- [ ] CREATE `saved_items_screen.dart` — full-screen grid with sort options
- [ ] Stale item handling: greyed out with overlay label, "See similar items?" bottom sheet
- [ ] Storage: Drift local + Firestore `users/{uid}/favourites` subcollection, sync on app start
- [ ] Favourite count on listing detail (shown if ≥3)

### 3.19 Listing Expiry & Renewal (Spec §8.19)

- [ ] 90-day listing lifespan, timer pauses when paused
- [ ] Expiry notifications: 7-day, 1-day, on-expiry push (notifications #26-#28)
- [ ] One-tap free renewal: extends 90 days, bumps to top of "most recent"
- [ ] Stale listing nudge after 3+ renewals with <10 views: "This listing isn't getting much attention" inline card (Spec §8.19)

### 3.20 Seller-Initiated Refund (Spec §8.20)

- [ ] "Refund Buyer" button on seller order detail (escrowed/fulfilled)
- [ ] Confirmation bottom sheet → CF `sellerInitiatedRefund` → release escrow → status `refunded`

### 3.21 First-Time Buyer Experience — Full Detail (Spec §8.21)

- [ ] **Location banner on Buy hub** (Spec §8.21): shown when `profileLocation` is null
  - Two CTAs: "Enable GPS" (triggers `geolocator` permission + single read) and "Set manually" (opens location autocomplete)
  - Dismissible, but re-appears on next app launch until location is set
  - Styling: white card, cyan accent, pin icon
- [ ] **Contextual tooltips** (Spec §8.21): CREATE `lib/presentation/widgets/common/contextual_tooltip.dart`
  - One-time tooltips (max 4 across marketplace), stored in SharedPreferences `shown_tooltip_{id}`
  - Tooltip 1: On first listing view — "Tap the heart to save items for later"
  - Tooltip 2: On first listing view — "All payments are held safely until you confirm"
  - Tooltip 3: On first seller profile view — "Check reviews from other buyers"
  - Tooltip 4: On first order — "You have 5 days to confirm after delivery"
  - Arrow pointing to relevant UI element, dismiss on tap anywhere
- [ ] **First-purchase trust explainer** (Spec §8.21): 3-step Payment Protection visual
  - Step 1: Shield + "You pay" — "Your tokens are held safely, not sent to the seller"
  - Step 2: Box + "Seller delivers" — "The seller sends your item within 7 days"
  - Step 3: Check + "You confirm" — "Only then does the seller get paid"
  - Shown in expandable section on listing detail (Layer 3), expanded by default on first visit
- [ ] Empty state personalities in marketplace hub: different icon + message per context (no results, empty category, error)

### 3.22 Auto-Moderation System — Full Detail (Spec §8.12)

- [ ] Provider doc new fields: `warningCount`, `suspensionReason`, `suspensionTrigger`, etc. (already in Phase 0.5)
- [ ] **8 auto-moderation triggers with thresholds** (Spec §8.12):
  1. ≥3 reports on single listing → listing auto-flagged, hidden from browse
  2. Dispute rate >30% (of completed orders) → warning issued
  3. Cancellation rate >40% → warning issued
  4. Delivery timeout (7 days) on ≥3 orders → warning issued
  5. Average response time >48 hours → warning issued
  6. Trust score drops below 2.0 → automatic suspension
  7. Banned words detected in listing title/description → listing auto-flagged
  8. Warning accumulation: 3 warnings within 30 days → automatic suspension
- [ ] Suspension cascade CF: atomically flag all listings, cancel/refund all active orders, notify buyer + seller (notification #34, #37)
- [ ] Banned words: `config/marketplace` Firestore doc with `bannedWords` array field, checked on listing create/update
- [ ] CREATE `config/marketplace` Firestore document during Phase 8 seeding (contains `bannedWords: []`)

### 3.23 Share Functionality (Spec §14.1)

- [ ] Share listing to WhatsApp: pre-formatted message with deep link
- [ ] Share to iMali chat via `ForwardConversationPicker` using `MessageType.marketplaceShare`
- [ ] Copy link option
- [ ] **Firebase Dynamic Links setup** (Spec §8.24):
  - Configure Firebase Dynamic Links in Firebase console
  - Link patterns: `imali.app/listing/:listingId`, `imali.app/seller/:providerId`, `imali.app/order/:orderId`
  - Fallback to app store if app not installed
  - Deep link handler in `app_router.dart` to parse incoming dynamic links

### 3.24 New Marketplace CFs (Spec §8.8)

- [ ] `updateMarketplaceListing` — edit listing (owner only)
- [ ] `toggleMarketplaceListingStatus` — pause/unpause
- [ ] `getSellerDashboard` — earnings, stats, level progress
- [ ] `renewMarketplaceListing` — extend expiry 90 days
- [ ] `suspendProviderCascade` — auto-suspend + cascade (flag listings, cancel orders, notify)
- [ ] `makeOffer` / `respondToOffer` — offer system (see 3.16)
- [ ] `getSimilarListings` — same category, exclude current
- [ ] `getPriceSuggestion` — avg price in subcategory
- [ ] `sellerInitiatedRefund` — validate + release escrow
- [ ] `onFavouriteWrite` — Firestore trigger: increment/decrement `favouriteCount`

### 3.25 Scheduled CFs — Marketplace (Spec §8.8, §8.26)

- [ ] `expireMarketplaceListings` — scheduled daily: listings past 90-day expiry → status `expired`, send notifications #28
- [ ] `checkDeliveryTimers` — scheduled daily: escrowed >7 days → auto-cancel + refund buyer, send notifications #10-#11
- [ ] `checkBuyerConfirmationWindows` — scheduled daily: fulfilled >5 days with responsive seller → auto-release escrow to seller, send notifications #13-#14
- [ ] `autoRefundUnresponsiveSeller` — scheduled daily: disputes >5 days with no seller response → auto-refund buyer, send notifications #19-#20
- [ ] `sendReviewReminder` — scheduled daily: 24hr + 72hr after receipt confirmation if no review submitted, send notifications #24-#25
- [ ] `expireOffers` — scheduled hourly: offers >24hrs old → status `expired`, send notification #46

### 3.26 Marketplace Notification Templates (Spec §8.26)

- [ ] Implement 46 notification templates in `buyNotifications.ts`:
  - **Order lifecycle** (#1-7): order placed (seller + buyer), delivered, confirmed, cancelled (seller + buyer), seller-initiated refund
  - **Delivery timer** (#8-11): 2 days left, 1 day left, timer expired (buyer refund + seller cancel)
  - **Buyer confirmation window** (#12-14): 3-day nudge, auto-release (buyer + seller)
  - **Disputes** (#15-23): opened, Day 1 follow-up, Day 2 SMS escalation, Day 4 final warning, Day 5 auto-refund (buyer + seller), admin resolves (refund or release), seller responds
  - **Reviews** (#24-25): 24hr reminder, 72hr final reminder
  - **Listing lifecycle** (#26-31): 7-day expiry, 1-day expiry, on expiry, flagged, unflagged, removed
  - **Seller account** (#32-37): registration, warning, suspended, reinstated, banned, suspension cascade (affected buyers)
  - **Seller level** (#38-41): level-up Active/Trusted/Star, weekly earnings summary
  - **Offers** (#42-46): new offer, accepted, declined, countered, expired
  - **SMS template** #17: dispute escalation Day 2 (via Twilio or similar)
- [ ] Deduplication: each notification has unique key (orderId + trigger type), don't re-send if already sent
- [ ] Scheduling: review reminders, expiry reminders, delivery timer, buyer confirmation — all via scheduled CFs

### 3.27 GoRouter Routes (Spec §8.24)

- [ ] ADD new consumer routes:
  - `/buy/marketplace/saved` → SavedItemsScreen
  - `/buy/marketplace/seller-portal` → SellerPortalScreen
  - `/buy/marketplace/my-listings` → MyListingsScreen
  - `/buy/marketplace/edit-listing/:id` → ListingEditScreen
  - `/buy/marketplace/listing-preview` → ListingPreviewScreen
  - `/buy/marketplace/orders/:orderId/dispute` → DisputeFlowScreen
  - `/buy/marketplace/orders/:orderId/review` → ReviewScreen
- [ ] FIX Sell FAB: change from `/buy/marketplace/create-listing` to `/buy/marketplace/seller-portal`

### 3.28 New Widgets

- [ ] CREATE `seller_portal_screen.dart`
- [ ] CREATE `my_listings_screen.dart`
- [ ] CREATE `order_detail_screen.dart`
- [ ] CREATE `order_status_tracker.dart` — visual dot-and-line tracker
- [ ] CREATE `seller_level_badge.dart` — 4 seller levels
- [ ] CREATE `quick_reply_chips.dart` — buyer/seller contextual chips
- [ ] CREATE `offer_message_card.dart` — Accept/Decline/Counter chat card
- [ ] CREATE `delivery_timer_widget.dart` — 7-day countdown
- [ ] CREATE `location_card_message.dart` — chat message for collection location
- [ ] CREATE `review_prompt_widget.dart` — inline review prompt
- [ ] CREATE `dispute_flow_screen.dart`
- [ ] CREATE `saved_items_screen.dart`
- [ ] CREATE `location_banner.dart` — location prompt for Buy hub
- [ ] CREATE `contextual_tooltip.dart` — one-time tooltips
- [ ] CREATE `quick_view_sheet.dart` — long-press listing preview bottom sheet
- [ ] CREATE `voice_message_recorder.dart` — hold-to-record + waveform (if not reusing existing)

### 3.29 Notification Routing (Spec §14.6)

- [ ] ADD routing for `purchase_success` → `/buy/history`
- [ ] ADD routing for `purchase_refund` → `/buy/history`
- [ ] ADD routing for `coupon_claimed` → `/buy/brand/{storefrontId}`

**Verify**: Full marketplace flow works end-to-end: browse → view listing → buy → escrow → deliver → confirm → review. Seller flow: register → create listing → manage → fulfil → get paid. Offer flow: make → accept/decline/counter → order. Voice messages work in buyer-seller chat. First-time buyer UX (location banner, tooltips, trust explainer) shows correctly.

---

## Phase 4: Marketplace — Admin (Spec §8.22)

**Goal**: Admin portal screens for marketplace management.

**Prerequisites**: Phase 3 in progress or complete.

### 4.1 Provider Management — Major Rework (Spec §8.22)

- [ ] Remove "Pending" and "Rejected" tabs (no approval queue — registration is instant)
- [ ] Rename tabs: "Active" | "Suspended" | "Banned"
- [ ] Add auto-moderation stats per provider: warning count, dispute rate, cancellation rate, avg response time
- [ ] Add suspension management actions: "Reinstate" (undo suspension, restore listings), "Confirm Suspension" (keep suspended), "Ban" (permanent)
- [ ] Add seller level display per provider with level badge icon
- [ ] Add provider location display (suburb, city, province)

### 4.2 Listing Moderation — Moderate Changes (Spec §8.22)

- [ ] Add banned words management section (inline or separate screen — see 4.8)
- [ ] Add listing expiry info (days remaining, renewal count), favourite count, view count
- [ ] Add service area type + structured location display (province → city → suburb)
- [ ] Add listing quality score display
- [ ] "Unflag" action for falsely flagged listings → restore to active, send notification #30

### 4.3 Order Management — Major Rework (Spec §8.22)

- [ ] Add visual order status tracker (same `order_status_tracker.dart` as consumer)
- [ ] Add delivery timer status + delivery method info (collection/delivery/both)
- [ ] Add dispute detail view: buyer concern (reason, details, photos) + seller response (response, photos, proposed resolution) side by side
- [ ] Add resolution options: "Refund buyer" / "Release to seller" / "Partial refund" (token amount input) / "Require return" / "Split 50/50"
- [ ] Add SMS/WhatsApp escalation trigger button → calls `adminEscalateToSms` CF
- [ ] Add maker-checker for refunds >500 tokens: requires second admin approval

### 4.4 Analytics — Moderate Changes (Spec §8.22)

- [ ] Add time-range filter (Today / 7d / 30d / All time)
- [ ] Add seller level distribution chart (pie/bar: New/Active/Trusted/Star counts)
- [ ] Add dispute outcomes breakdown (refunded/released/partial/returned)
- [ ] Add avg delivery time, avg review rating
- [ ] Add location heatmap / top locations (province-level counts)

### 4.5 Category Management — Moderate Changes (Spec §8.22)

- [ ] Update to 8-category system with subcategories (see spec §8.2 subcategory table)
- [ ] Add category icon management (fintech icons PNGs from `docs/fintech_icons_light_dark_pack/`)

### 4.6 Escrow Overview — Minor Changes (Spec §8.22)

- [ ] Add delivery timer-linked escrow (orders approaching 7-day expiry — highlight in amber/red)
- [ ] Add seller-initiated refund tracking

### 4.7 NEW: Seller Levels Config Screen (Spec §8.22)

- [ ] Admin route `/buy-seller-levels`
- [ ] Editable thresholds per level (e.g., Active: 3 sales + 3.0 rating, Trusted: 10 sales + 4.0 rating, Star: 25 sales + 4.5 rating)
- [ ] Current distribution counts (how many sellers at each level)
- [ ] CF: `adminUpdateSellerLevelConfig`

### 4.8 NEW: Banned Words Management (Spec §8.22, §8.12)

- [ ] Text area, one word per line, stored in `config/marketplace` Firestore doc `bannedWords` array
- [ ] Test field to check if phrase would trigger flag (client-side check against word list)
- [ ] Can be a section within Listing Moderation screen or standalone at `/buy-banned-words`

### 4.9 Admin Router Updates (Spec §14.8)

- [ ] ADD route `/buy-seller-levels` → `SellerLevelsConfigScreen` to `admin_router.dart`
- [ ] ADD route `/buy-banned-words` → `BannedWordsManagementScreen` to `admin_router.dart` (or embed as section within Listing Moderation screen per 4.8)
- [ ] ADD sidebar entries for new routes (after "Escrow Overview"): "Seller Levels" and "Banned Words"

### 4.10 New Admin CFs (Spec §8.22)

- [ ] `adminBanProvider` — permanent ban + cascade (flag all listings, cancel all orders, refund, notify)
- [ ] `adminReinstateProvider` — undo suspension, restore listings to active, send notification #35
- [ ] `adminPartialRefund` — specific token amount refund (debit escrow, credit buyer, for partial resolution)
- [ ] `adminRequireReturn` — set "return required" status on disputed order
- [ ] `adminEscalateToSms` — trigger SMS to unresponsive seller (notification #17 via Twilio)
- [ ] `adminUpdateSellerLevelConfig` — update thresholds in `config/marketplace` doc
- [ ] `adminUpdateBannedWords` — update `bannedWords` array in `config/marketplace` doc
- [ ] REMOVE `adminApproveProvider`, `adminRejectProvider` (no approval queue)
- [ ] RENAME `adminUnsuspendProvider` → `adminReinstateProvider`

**Verify**: All admin screens load, CRUD operations work, maker-checker enforced for large refunds, dispute resolution options all functional.

---

## Phase 5: Hlangana Group Buys (Spec §9)

**Goal**: Full group buy consumer + admin experience with community-organized deals.

**Prerequisites**: Phase 0-1 complete.

### 5.1 Group Buy List Screen Redesign (Spec §9.6)

- [ ] Light theme conversion (green accent throughout)
- [ ] Tabs: "Deals" / "My Deals"
- [ ] Filter chips: "All" / "Official" / "Community" / cluster names / "Ending Soon"
- [ ] Sort: "Closest to target" / "Newest" / "Ending soon" / "Lowest price"
- [ ] FAB speed dial: "Start a group buy" (people icon) + "Suggest a deal" (lightbulb icon)
- [ ] Deal cards: full-width, green accent, Official/Community badge distinction
  - Admin-curated: brand logo + "Official" green pill
  - Community: people icon + "Community deal" green-outline pill

### 5.2 Group Buy Detail Screen Redesign (Spec §9.7)

- [ ] 4-layer progressive disclosure
- [ ] Layer 1: deal image, price anchoring (original strikethrough → deal price green bold), savings badge, progress section, countdown
- [ ] Layer 2: description, fulfilment info card, deal source card (brand info OR organizer info with member-since + success rate)
- [ ] Layer 3: "How Group Buys work" expandable (3-step visual), participant count, similar deals
- [ ] Layer 4: report (5 reason cards), terms
- [ ] Green trust stack above CTA (4 indicators: shield + people count + clock + lock)
- [ ] Context-aware sticky CTA (6 variants by status per Spec §9.7):
  - `open`, not joined → "Join — X tokens (RY)" green CTA
  - `open`, joined → "Leave this deal" outline red
  - `targetMet`, joined → "Deal is on! Waiting..." green text
  - `completed`, digital → "View your voucher code" green CTA
  - `completed`, physical → "View collection details" green CTA
  - `expired` / `cancelled` / full → grey disabled text
- [ ] **Step-up auth** (Spec §14.7): Before calling `joinGroupBuy` CF, call `await StepUpAuthService.verify(context)`. If verification fails, do not proceed. Inject `StepUpAuthService` into `GroupBuyBloc`.
- [ ] One-tap join (digital + physical collection): wallet check → step-up auth → spinner → haptic + checkmark
- [ ] Physical delivery join: mini bottom sheet for delivery address (pre-filled from profile)
- [ ] Join error handling: insufficient balance (inline error + "Top up" link), network (toast + reset), deal filled/expired (toast + CTA update + screen reload)
- [ ] Leave flow: one-step confirmation bottom sheet → spinner → success toast → screen reload

### 5.3 Fulfilment UI — Full Detail (Spec §9.8)

#### Digital Fulfilment — Voucher Display
- [ ] Voucher card (replaces progress section on detail screen): white bg, green 2px border, 16px radius
  - Header: gift icon + "Your voucher code" 16px bold green
  - Code: large monospace 24px bold `buyTextPrimary`, letter-spaced (e.g., "ABC-DEF-1234")
  - "Copy code" outline button: green text, copy icon, haptic + "Copied!" toast
  - Instructions from admin (14px `buyTextSecondary`)
  - Screenshot reminder: camera icon + "Take a screenshot of your code" 12px `buyTextTertiary`
  - Expiry (if set): "Use by [date]" amber warning if <7 days

#### Physical Collection — Collection Flow
- [ ] Collection card (replaces progress section): white bg, green 2px border, 16px radius
  - Header: pin icon + "Collect your item" 16px bold green
  - Address list: each as tappable row with pin icon + address text + "Get directions" green link (opens device maps)
  - Proof of purchase: QR code generated from contribution ID (150px centred) + "Show this QR code when you collect" + reference "#HLG-[short-id]" monospace
  - Collection deadline (if set): "Collect by [date]" amber warning if <3 days
  - "I collected it" green CTA → confirmation bottom sheet ("Confirm you collected your item?" + "Yes, I collected it" green CTA + "Not yet" text link) → updates participant status, triggers escrow release when all collected

#### Physical Delivery — Delivery Flow
- [ ] Delivery card: white bg, green 2px border, 16px radius
  - Header: truck icon + "Your item will be delivered" 16px bold green
  - Delivery address: user's address 14px `buyTextPrimary`
  - Status: "The brand is preparing deliveries" or "Your item has been shipped"
  - Tracking info (if provided): courier name + tracking number
  - "I received it" green CTA (same pattern as marketplace receipt confirmation)

### 5.4 Suggest a Deal Screen (Spec §9.10)

- [ ] Light theme form: brand/store, description, estimated price, link, image (camera/gallery, single, WebP max 200KB), auto-join toggle (default ON)
- [ ] Success screen with checkmark animation + "Browse deals" CTA + "Suggest another" text link

### 5.5 Community Group Buy Creation — Full Detail (Spec §9.11)

- [ ] CREATE `community_group_buy_create_screen.dart`:
  - **Who can create**: Any verified user (phone verified, account not suspended), no special registration needed
  - **Physical deals only**: digital voucher distribution requires brand partnership → admin-only
  - **Max 30 participants** (Spec §9.12): community-organized deals are capped at 30 max participants. Admin-curated deals have no cap. Enforce in UI (max field validation) and server-side (`createGroupBuy` CF).
  - **Organizer join restriction** (Spec §9.12): organizer cannot join their own deal after creation — only via the auto-join toggle at creation time. `joinGroupBuy` CF must reject if `userId == groupBuy.organizerId`.
  - **Info banner**: green tint bg + green left border + people icon + "Spotted a deal? Get a group together and save!" + trust subtext

  **Step 1 — Image (commitment step)**:
  - Camera/gallery picker, full-width tap area, required (photo of product/store/flyer)
  - Single image, WebP max 200KB, thumbnail preview with remove "✕"

  **Step 2 — Deal Details (scrollable form, 11 fields)**:
  1. Title (required, min 5 chars): "What's the deal?"
  2. Description (required, min 20 chars): multiline 3 rows
  3. Category (required): chip selector — Food & Groceries | Clothing & Fashion | Home & Household | Electronics | Services | Other
  4. Price per person (required): token input with ZAR conversion
  5. Original price (optional): auto-calculates savings percentage
  6. Min participants (required, min 3)
  7. Max participants (required, ≥ min)
  8. Deadline (required): date picker, min 3 days max 30 days from now
  9. Fulfilment method (required): "Collection" or "Delivery" chips
  10. Collection address(es) (if collection, max 3): address text fields + "+ Add another"
  11. Delivery fee (if delivery, optional): token input
  12. Your area (required): cluster picker (pre-filled from My Areas)

  **Step 3 — Preview & Publish**:
  - Preview card showing exact deal appearance
  - "I want to be first to join" toggle (default ON)
  - Trust reminder: shield icon + refund guarantee text
  - "Publish deal" green CTA → success screen with share to WhatsApp

### 5.6 Organizer Management — My Deals Tab (Spec §9.11)

- [ ] Organizer sees their created deals in "My Deals" tab with organizer-specific actions:
  - **While `open`**: participant count + progress, "Share deal" button, "Edit deal" (can edit description/image/addresses, CANNOT change price/max/deadline after first join), "Cancel deal" red button with confirmation → refunds all
  - **When `targetMet`**: celebration banner, "Mark items ready" (collection) or "Mark as shipped" (delivery) → triggers completion + notifications
  - **When `completed`**: collection/delivery tracking — see which participants confirmed receipt, escrow released per-participant as confirmations arrive
- [ ] Organizer trust indicators on deal detail: name, avatar, "Member since [month year]", "X successful deals" (green) or "First group buy" (neutral), green checkmark badge if 3+ successful deals

### 5.7 My Deals Tab — Consumer Detail (Spec §9.6)

- [ ] **Active deals** (shown by default): same card layout as Deals tab, filtered to user's joined deals
  - Status indicators: "Waiting for more people" (progress bar), "Deal is on!" (green badge), "Ready to collect!" (pulsing green), "Collect by [date]" (if deadline set)
- [ ] **Completed deals** (expandable section at bottom):
  - "Show completed deals (X)" collapse/expand toggle, default collapsed
  - Completed: "Deal complete ✓" green text
  - Expired/refunded: "Refunded — deal didn't reach target" grey text
  - Cancelled: "Cancelled" grey text
- [ ] **Empty state**: "You haven't joined any group buys yet" + "Browse deals" green CTA

### 5.8 User Opt-In — My Areas (Spec §9.4)

- [ ] UserProfile: `selectedClusters` field (1-3 clusters)
- [ ] CREATE `lib/presentation/widgets/common/cluster_picker_sheet.dart` (Spec §10.16): bottom sheet with 21 clusters grouped by province headers, cyan checkboxes, multi-select max 3, "Confirm" button. White sheet bg, `buyCardBorder` dividers. Reused in: hub opt-in prompt, profile settings, admin group buy creation, community deal creation.
- [ ] Add "My Areas" to profile settings screen (opens `ClusterPickerSheet`)
- [ ] Hub inline prompt when `userClusters` is empty

### 5.9 Group Buy Light Theme (Spec §9.14)

- [ ] Convert all screens/widgets with detailed colour mapping per spec §9.14:
  - `group_buy_list_screen.dart`: bg `buyBackground`, tab indicator/active `#059669`, inactive `buyTextTertiary`, FAB `#059669`
  - `group_buy_detail_screen.dart`: bg `buyBackground`, cards `buyCard` + `buyCardBorder`, title `buyTextPrimary`, description `buyTextSecondary`, CTA `#059669`
  - `create_group_buy_screen.dart`: bg `buyBackground`, info box green tint, TextField fill `buyChipBg`, focus `#059669`, CTA `#059669`
  - `group_buy_card.dart`: white + green tint, 3px solid `#059669` left accent, `buyCardBorder`, `buyTextPrimary` title, green join button
  - `group_buy_progress_bar.dart`: track `#E2E8F0`, fill gradient `#059669` → `#10B981`
  - `countdown_timer_widget.dart`: default `buyTextPrimary`, urgent `#DC2626`, expired `buyTextTertiary`
  - NEW `community_group_buy_create_screen.dart`: same light theme pattern

### 5.10 Group Buy CFs (Spec §9.17)

- [ ] NEW `confirmGroupBuyCollection` — participant confirms physical collection, updates `hasCollected`/`collectedAt`, increments `collectedCount`, triggers escrow release when all collected
- [ ] NEW `adminConvertSuggestion` — marks suggestion approved, creates group buy from suggestion data, optionally auto-joins suggesting user, sends notification #12
- [ ] NEW `adminCancelGroupBuy` — cancel any active deal + refund all participants, sends notification #8
- [ ] NEW `cancelCommunityGroupBuy` — organizer cancels own deal (only while status = `open`, NOT after `targetMet`), refunds all, sends notification #8
- [ ] NEW `updateGroupBuyDeliveryStatus` — admin or organizer updates `deliveryStatus` (preparing/shipped/delivered), triggers notification #6
- [ ] NEW `sendGroupBuyReminders` — scheduled: deals ending in 24h → notification #11, collection deadlines 1 day away → notification #13
- [ ] UPDATE `createGroupBuy` — extend for community creation: accept `category`, `deliveryFee`, `addresses[]`, enforce physical-only for non-admin, validate min 3 participants + deadline 3-30 days, **enforce max 30 participants for non-admin** (Spec §9.12), set `createdByAdmin: false`, auto-join organizer if toggle on (only way organizer can join own deal), send notification #16
- [ ] UPDATE `joinGroupBuy` — accept `deliveryAddress` (required for physical delivery) + `walletId` (default 'primary'), **reject if `userId == groupBuy.organizerId`** (organizer can only join via auto-join at creation, Spec §9.12), send notification #18 to organizer
- [ ] UPDATE `leaveGroupBuy` — send notification #15 to leaving user
- [ ] UPDATE `completeGroupBuy` — allow organizer (not just admin) for community deals, distribute `voucherCode` to each contribution doc for digital deals, send notifications #4/#5/#6
- [ ] UPDATE `adminForceCompleteGroupBuy` — accept voucher code upload (CSV or array), validate count matches participants

### 5.11 Group Buy Notifications (Spec §9.15)

- [ ] Implement 19 notification templates (#1-19) in `buyNotifications.ts`:
  - #1-2: New deal live (digital all users / physical matching clusters)
  - #3: Target reached (all participants)
  - #4-6: Deal completed (digital voucher / physical collection / physical delivery)
  - #7: Expired + refunded
  - #8: Cancelled + refunded
  - #9-10: Spots milestones (50%/75%/90%) and 3 spots left
  - #11: Ending soon (24h)
  - #12: Suggestion goes live
  - #13: Collection deadline approaching (1 day)
  - #14: Participant collected (internal Firestore only)
  - #15: Voluntary leave + refund
  - #16: New community deal live
  - #17: Community deal reported (admin internal)
  - #18: Organizer — someone joined
  - #19: Organizer — target reached

### 5.12 Group Buy Admin — Full Detail (Spec §9.18)

- [ ] Create form: add `collectionDeadline` date picker, `fulfilmentInstructions` text field, image upload
- [ ] Active tab: "Cancel deal" red button (confirmation dialog), delivery status dropdown (Preparing/Shipped/Delivered), collection progress ("X of Y collected"), source badge (Official vs "Community — by [Name]"), report count badge if ≥1
- [ ] Completed tab: voucher code upload (text area one-per-line or CSV, validate count matches participants, "Distribute" button), address list export (CSV download), collection tracking table (participant name + collected ✓/✗ + date)
- [ ] Suggestions tab: "Convert to deal" button (pre-fills create form with suggestion data via `adminConvertSuggestion`), "Reward suggester" toggle
- [ ] **NEW Community Moderation tab** (Spec §9.18): lists community deals flagged by auto-moderation (≥3 reports or high dispute rate). Per flagged deal: deal details, report reasons list, organizer profile + history (past deals, success rate). Actions: "Dismiss reports" (unflag) / "Cancel deal + refund" / "Suspend organizer" (prevents new deals, existing active deals continue)

### 5.13 Share-to-Chat

- [ ] Group buy share via `MessageType.groupBuyShare` + `ForwardConversationPicker`

### 5.14 First-Time Group Buy Experience (Spec §9.13)

- [ ] First visit with empty clusters: inline prompt "Select your area to see group buys near you" + "Set up" green button
- [ ] First join: one-time tooltip on progress bar "As more people join, the bar fills up..."
- [ ] First deal completion: enhanced success card "Your first group buy deal!" + celebration animation + savings callout + share button

**Verify**: Full group buy flow: browse → join → target met → fulfilment → confirm receipt. Community creation flow works. Organizer management functional. Admin can manage all deal types including community moderation.

---

## Phase 6: VAS Admin & Purchase Infrastructure (Spec §6)

**Goal**: Admin screens for VAS utility providers and products. Purchase auto-refund guarantee. Purchase notifications.

**Prerequisites**: Phase 0-1 complete.

### 6.1 VAS Provider Management Screen (Spec §6)

- [ ] CREATE `vas_provider_management_screen.dart`:
  - **Route**: `/buy-vas-providers`
  - **List view**: Filter by category dropdown (all 10 PurchaseCategory values), table columns: Logo, Name, Code, Category, Products count, Active status, Sort Order. Stats row: Total providers, Active, Inactive, per-category counts
  - **Create/Edit form**: Name (required), Code (required, unique, kebab-case), Category (required, dropdown), Logo URL (optional), Description (optional), Sort Order (int), Active toggle
  - **Actions**: Toggle active/inactive, Delete (soft-delete: `isActive=false`, `isDeleted=true`), "View products" → navigates to product management

### 6.2 VAS Product Management Screen (Spec §6)

- [ ] CREATE `vas_product_management_screen.dart`:
  - **Route**: `/buy-vas-providers/:providerId/products`
  - **Header**: Provider name + logo + category
  - **Table**: Name, Code, Price ZAR, Price tokens (auto-calculated: ZAR × 100), Validity, Active, Sort Order. Stats row: Total/Active/Inactive
  - **Create/Edit**: all fields including metadata JSON
  - **Bulk operations**: price update (percentage or flat amount), activate/deactivate
  - **Duplicate product**: copy with new name/code for quick creation of similar bundles

### 6.3 VAS Provider Seeding (Spec §6)

- [ ] "Seed Defaults" button on VAS Provider Management screen → confirmation dialog with provider count → calls `adminSeedVasProviders`
- [ ] Seed data: Electricity (Eskom, City Power, Tshwane), Airtime (Vodacom, MTN, Cell C, Telkom Mobile), Data (same providers), Vouchers (1ForYou, Blu Voucher, Flash, OTT). School/Municipal/Insurance/Funeral/Stokvel/Gaming: empty

### 6.4 VAS Admin CFs (Spec §6)

- [ ] `adminCreateVasProvider`, `adminUpdateVasProvider`, `adminToggleVasProvider`, `adminDeleteVasProvider`
- [ ] `adminCreateVasProduct` — writes to `serviceProducts` + updates provider's embedded products
- [ ] `adminUpdateVasProduct`, `adminToggleVasProduct`, `adminDeleteVasProduct`
- [ ] `adminBulkUpdateVasProductPrices` — percentage or flat adjustment
- [ ] `adminSeedVasProviders` — idempotent seed, skips existing by code

### 6.5 Admin Router Updates

- [ ] Add routes: `/buy-vas-providers`, `/buy-vas-providers/:providerId/products`
- [ ] Add sidebar entry: "VAS Providers" (between "Categories" and "Purchases")

### 6.6 Purchase Auto-Refund Guarantee (Spec §6)

- [ ] Verify `processPurchase` CF in `purchases.ts` implements auto-refund on failure:
  - If purchase fails after token deduction (VAS provider API error, timeout, network), auto-refund tokens to user wallet via ledger
  - Idempotency key: `purchaseRefund:${purchaseId}` — safe to retry
  - Ledger entries: debit PURCHASE_ESCROW (or wallet reversal), credit user wallet
  - Edge case: if refund itself fails, admin dashboard flags for manual resolution
- [ ] Verify failure screen always shows "Your tokens have been automatically refunded" (wired in Phase 1.11)

### 6.7 Purchase Notification Templates (Spec §6)

- [ ] Implement 3 templates in `buyNotifications.ts`:
  1. **Purchase successful** → Buyer: "Your [product] for [recipient] is ready. Ref: #PUR-[id]" → deep link `/buy/history`
  2. **Purchase failed + refunded** → Buyer: "Your [product] purchase failed. Your [X] tokens have been refunded." → deep link `/buy/history`
  3. **Purchase pending >5 min** → Buyer: "Your [product] purchase is still processing." → deep link `/buy/history`

**Verify**: Admin can CRUD providers/products, seed defaults, bulk update prices. Auto-refund works on purchase failure. All 3 purchase notification templates fire correctly.

---

## Phase 7: Cross-Cutting — Analytics, Localization, Offline (Spec §12)

**Goal**: Infrastructure services that span the entire Buy tab.

**Prerequisites**: Phase 0 complete. Best done alongside or after Phases 1-5.

### 7.1 BuyAnalyticsService — Full Event List (Spec §12.7)

- [ ] CREATE `lib/core/services/buy_analytics_service.dart`:
  - `@lazySingleton`, wraps `FirebaseAnalytics`
  - All events prefixed `buy_`, snake_case parameters
  - All methods fire-and-forget `void` (not `Future<void>`) — analytics failures must never block UX

  **~30 tracking methods** (Spec §12.7):
  ```
  // Hub & Navigation
  trackBuyTabOpened()
  trackCategoryTapped({categoryId, categoryName})
  trackBrandPartnerTapped({brandId, brandName})
  trackFeaturedItemTapped({itemId, itemType})
  trackMarketplaceOpened()
  trackGroupBuysOpened()
  trackPurchaseHistoryOpened()

  // Purchase Funnel
  trackPurchaseStarted({categoryId, providerId, amountTokens})
  trackWalletSelected({walletType})
  trackPurchaseConfirmed({categoryId, providerId, amountTokens})
  trackPurchaseSucceeded({purchaseId, amountTokens, categoryId})
  trackPurchaseFailed({categoryId, error})

  // Marketplace
  trackListingViewed({listingId, category})
  trackListingCreated({category, priceTokens})
  trackMarketplaceSearched({query, resultCount})
  trackOrderCreated({orderId, amountTokens})
  trackProviderRegistered()

  // Brand Storefront
  trackStorefrontViewed({brandId, brandName})
  trackStorefrontSectionTapped({brandId, sectionType})
  trackBrandFollowed({brandId})
  trackBrandUnfollowed({brandId})
  trackCouponClaimed({brandId, couponId})
  trackProductTapped({brandId, productId})

  // Group Buys
  trackGroupBuyViewed({groupBuyId})
  trackGroupBuyJoined({groupBuyId, amountTokens})
  trackGroupBuyLeft({groupBuyId})
  trackGroupBuyRequestSubmitted()

  // QR Scanner
  trackQrScannerOpened()
  trackQrScanSuccess({format})
  ```

- [ ] Register in `core/di/register_module.dart`
- [ ] Inject into BLoCs: BuyTabBloc, PurchaseBloc, MarketplaceBloc, BrandStorefrontBloc, GroupBuyBloc
- [ ] Call tracking methods from BLoC event handlers (not UI)

### 7.2 Localization Setup (Spec §12.8)

- [ ] Add `easy_localization` to `pubspec.yaml` (if not present)
- [ ] CREATE `assets/translations/en.json` with `"buy"` key
- [ ] Key convention: `buy.screen_name.string_purpose`
- [ ] **~155 strings** organized by screen (Spec §12.8):
  - `buy_services_screen` (~25): "Buy", "Purchase history", "Intengiso Marketplace", etc.
  - `buy_wallet_selection_screen` (~12): "Confirm Purchase", "Pay from", etc.
  - `buy_success_screen` (~5): "Purchase Successful", "Done", etc.
  - `buy_failure_screen` (~5): "Purchase Failed", "Your tokens have been refunded", etc.
  - `buy_purchase_history_screen` (~6): "Purchase History", "No purchases yet", etc.
  - `brand_storefront_screen` (~20): "Follow", "Following", "Products", "Reviews", etc.
  - `marketplace_hub_screen` (~15): "Marketplace", "Search marketplace...", etc.
  - `group_buy_list_screen` (~10): "Group Buys", "Suggest a Deal", etc.
  - `group_buy_detail_screen` (~15): "Join", "Leave", "Target Met!", etc.
  - Buy widgets (~30): "See All", "SOON", "LIVE", "Expired", "Retry", etc.
  - Error/empty states (~12): "Something went wrong", "No providers yet", etc.
- [ ] Replace hardcoded strings with `.tr()` calls as each screen is touched
- [ ] English only for now (Afrikaans, Zulu, Xhosa deferred)

### 7.3 Offline Cache Integration (Spec §12.1)

- [ ] Implement stale-while-revalidate pattern in repositories using new Drift tables
- [ ] Wire `NetworkInfo.isConnected` check in BuyTabBloc offline flow
- [ ] Ensure all list fetches use Firestore `limit()` (never fetch entire collections)

### 7.4 Image Optimization Compliance (Spec §12.2)

- [ ] Audit all Buy widgets: verify `CachedNetworkImage` usage (never raw `Image.network`)
- [ ] Verify error fallback: placeholder icon on failure
- [ ] Verify shimmer placeholder during load
- [ ] Video: WiFi-only auto-play, data cost warning on mobile >1MB upload

### 7.5 Data Cost Awareness (Spec §12.3)

- [ ] Verify image lazy loading in all `ListView.builder` contexts
- [ ] Video auto-play WiFi only check
- [ ] Data cost warning before uploads >1MB on mobile data

### 7.6 Error Handling Patterns (Spec §12.10)

- [ ] Verify all repositories return `Either<Failure, T>`
- [ ] Verify BLoCs fold `Either` → emit `errorMessage` on Left
- [ ] Verify UI: inline error card (Pattern 1) for data fetch, snackbar (Pattern 2) for action failures

**Verify**: Analytics events fire, localization strings render, offline cache works, no raw `Image.network` calls.

---

## Phase 8: Firestore Rules, Indexes, CF Exports & Config (Spec §13, §14.10)

**Goal**: Deploy all security rules, indexes, export new CFs, create config documents.

**Prerequisites**: All feature CFs written.

### 8.1 Security Rules (Spec §13.1)

- [ ] VERIFY all 18 existing Buy collection rules are correct per spec §13.1:
  - `purchases` (own only), `serviceProviders` (auth read), `serviceProducts` (auth read), `featureFlags` (auth read), `buyCategories` (auth read), `featuredItems` (auth read), `brandStorefronts` (auth read), `brandStorefronts/{id}/products` (auth read), `brandProducts` (auth read), `brandReviews` (auth read), `groupBuyRequests` (own only), `providers` (auth read), `marketplaceListings` (auth read), `buyOrders` (own only: buyerId or sellerId), `marketplaceReports` (admin only), `groupBuys` (auth read), `users/{uid}/buyRegulars` (own only), `contributions` (own only: contributorId)
  - All writes: CF only
- [ ] ADD rules for 4 new collections:
  - `brandAnalytics/{brandId}/daily/{date}` — CF only read/write (admin reads via CF)
  - `brandFollowers` — authenticated read (to check follow status), CF only write
  - `storefrontCoupons` — **top-level collection** with `storefrontId` + `userId` fields (not a subcollection) — authenticated read (to check claim status), CF only write. Top-level is required because the `storefrontCoupons` index in Phase 8.2 uses `storefrontId` + `userId` composite fields.
  - `users/{uid}/favourites` — own only read (`userId == auth.uid`), CF only write (via `onFavouriteWrite` trigger in Phase 3.24). Required for saved listings sync (Phase 3.18).

### 8.2 New Composite Indexes (Spec §13.3)

- [ ] Add 8 new indexes to `firestore.indexes.json`:
  1. `brandStorefronts`: `isActive` + `isDraft` + `isPremium`
  2. `brandStorefronts`: `tier` + `isActive`
  3. `brandAnalytics/daily`: `date` desc
  4. `brandFollowers`: `userId` + `brandId`
  5. `brandFollowers`: `brandId` + `createdAt` desc
  6. `storefrontCoupons`: `storefrontId` + `userId`
  7. `groupBuys`: `clusters` (array-contains-any) + `status` + `deadline`
  8. `buyOrders`: `status` + `createdAt` desc

### 8.3 Index Cleanup (Spec §13.4)

- [ ] DROP `buyRegulars` index (`isPinned` + `lastUsedAt`) — feature removed
- [ ] REPLACE `brandStorefronts` index (`isActive` + `isPremium`) with new 3-field index including `isDraft`

### 8.4 CF Exports — Full List (Spec §14.10)

- [ ] Update `functions/src/index.ts` to export ALL new Cloud Functions from each source file:
  - **From `buyAdmin.ts`**: `adminCreateVasProvider`, `adminUpdateVasProvider`, `adminToggleVasProvider`, `adminDeleteVasProvider`, `adminCreateVasProduct`, `adminUpdateVasProduct`, `adminToggleVasProduct`, `adminDeleteVasProduct`, `adminBulkUpdateVasProductPrices`, `adminSeedVasProviders`, `adminListBrandProducts`, `adminCreateBrandProduct`, `adminUpdateBrandProduct`, `adminDeleteBrandProduct`, `adminUpdateSellerLevelConfig`, `adminUpdateBannedWords`, `adminBanProvider`, `adminReinstateProvider`, `adminPartialRefund`, `adminRequireReturn`, `adminEscalateToSms`, `adminConvertSuggestion`, `adminCancelGroupBuy`, `updateBrandTier`, `duplicateStorefrontSection`
  - **From `marketplace.ts`**: `updateMarketplaceListing`, `toggleMarketplaceListingStatus`, `getSellerDashboard`, `renewMarketplaceListing`, `suspendProviderCascade`, `makeOffer`, `respondToOffer`, `getSimilarListings`, `getPriceSuggestion`, `sellerInitiatedRefund`
  - **From `marketplace.ts` (scheduled)**: `expireMarketplaceListings`, `checkDeliveryTimers`, `checkBuyerConfirmationWindows`, `autoRefundUnresponsiveSeller`, `sendReviewReminder`, `expireOffers`
  - **From `marketplace.ts` (triggers)**: `onFavouriteWrite`
  - **From `groupBuys.ts`**: `confirmGroupBuyCollection`, `cancelCommunityGroupBuy`, `updateGroupBuyDeliveryStatus`
  - **From `groupBuys.ts` (scheduled)**: `sendGroupBuyReminders`
  - **From `brands.ts`**: `claimStorefrontCoupon`, `recordStorefrontView`, `getBrandAnalytics`, `getBrandMutualFollowers`
  - **From `buyNotifications.ts`**: all notification triggers (46 marketplace + 19 group buy + 3 purchase = 68 total)
- [ ] Verify exports from all files: `buyAdmin.ts`, `marketplace.ts`, `groupBuys.ts`, `purchases.ts`, `buyNotifications.ts`, `brands.ts`

### 8.5 Config Documents (Spec §8.12)

- [ ] CREATE `config/marketplace` Firestore document with initial fields:
  - `bannedWords: []` — empty array, populated by admin via `adminUpdateBannedWords`
  - `sellerLevelThresholds: { active: { sales: 3, rating: 3.0 }, trusted: { sales: 10, rating: 4.0 }, star: { sales: 25, rating: 4.5 } }`
  - `listingExpiryDays: 90` — used by `expireMarketplaceListings` scheduled CF (Phase 3.25)
  - `deliveryTimeoutDays: 7` — used by `checkDeliveryTimers` scheduled CF (Phase 3.25) and auto-moderation trigger #4 (Phase 3.22)
  - `buyerConfirmationDays: 5` — used by `checkBuyerConfirmationWindows` scheduled CF (Phase 3.25)
  - `disputeAutoRefundDays: 5` — used by `autoRefundUnresponsiveSeller` scheduled CF (Phase 3.25) and dispute escalation path (Phase 3.12)
  - `defaultNearbyRadiusKm: 25` — used by "Near me" location filter in marketplace hub (Phase 3.1, 3.17)
- [ ] All scheduled CFs and auto-moderation triggers must read these values from the config document (not hardcode) to allow admin tuning without redeployment
- [ ] Add to seed function or document as manual setup step
- [ ] BUILD `migrateListingCategories` one-off CF in `buyAdmin.ts`:
  1. Query all `marketplaceListings` docs
  2. For each doc, read old `category` enum value and map to new 8-category string:
     - Define explicit mapping: e.g. old `food` → new `foodAndDrinks`, old `beauty` → new `beautyAndWellness`, old `services` → new `fixAndRepair` or `everythingElse`, etc. (finalise mapping during implementation based on actual old enum values)
  3. Batch-write updated `category` string values (use Firestore batch writes, 500 per batch)
  4. Log unmapped values for manual review
  5. Idempotent — skip docs already using new category values
  6. Admin-only, callable once, export from `index.ts`

**Verify**: `firebase deploy --only firestore:rules` succeeds, indexes deploy without errors, all CFs exported and callable.

---

## Phase 9: Polish & Cleanup (Spec §10, §12.6)

**Goal**: Dead code removal, accessibility pass, widget polish, final verification.

**Prerequisites**: All feature phases complete.

### 9.1 Dead Code Removal — Complete List (Spec §7, §10.23)

- [ ] DELETE `my_regulars_dock.dart` (or verify already removed in Phase 1.4)
- [ ] DROP `LocalBuyRegulars` Drift table (verify migration in Phase 0.9)
- [ ] REMOVE `getMarketplaceStats` — delete from:
  1. `lib/domain/repositories/buy_repository.dart` (interface method)
  2. `lib/data/repositories/buy_repository_impl.dart` (implementation)
  3. `lib/data/datasources/remote/buy_remote_datasource.dart` (CF call)
  4. Any BLoC event/handler that calls it (search for `getMarketplaceStats` / `loadMarketplaceStats`)
  5. Verify no UI widget reads the result — the hub marketplace card (Phase 1.5) is static and does not need this data; trending data is fetched on the marketplace hub screen (Phase 3.1) instead
- [ ] REMOVE `adminApproveProvider`, `adminRejectProvider` CFs (no approval queue — Phase 4.10)
- [ ] REMOVE `buyRegulars` Firestore index (dropped in Phase 8.3)
- [ ] Verify `buy_coming_soon_teaser.dart` usage — keep if feature flags can disable layers, delete if not (§10.23)
- [ ] Clean up `buy_my_regulars` feature flag (flag remains for cleanup tracking, can be toggled off)
- [ ] DELETE `BuySubcategoryListScreen` and its route `/buy/subcategories/:categoryId` from `app_router.dart`:
  1. Phase 1.3 removes subcategory navigation for utilities — all categories now go directly to `/buy/category/:purchaseCategoryMapping`
  2. Marketplace subcategory filtering uses inline chips on `marketplace_hub_screen.dart` (Phase 3.1), not this screen
  3. Search codebase for all imports/references to `buy_subcategory_list_screen.dart` and remove them
  4. If any reference is found outside of Buy tab utilities, investigate before deleting — but per current spec, this screen has no remaining consumer
- [ ] REMOVE any unused imports, orphaned files, dead event handlers

### 9.2 Brand Products Migration Cleanup (Spec §13.5)

- [ ] If brand products were migrated from top-level to subcollection in Phase 2.15, verify migration complete
- [ ] Remove or deprecate top-level `brandProducts` queries if all data is in subcollections
- [ ] Update any remaining references to use subcollection pattern

### 9.3 Accessibility Pass (Spec §12.6)

- [ ] Audit all tappable elements: minimum 48×48px touch targets
- [ ] Increase category tile min height from 36px → 44px
- [ ] Verify WCAG 2.1 AA contrast ratios for all Buy colour tokens
- [ ] Verify all tappable cards have visual feedback (`InkWell` / `GestureDetector`)
- [ ] Verify disabled states: 50% opacity + non-tappable
- [ ] Verify `AppButton` enforces minimum height + shows spinner in loading state

### 9.4 Common Widget Light Theme Audit (Spec §10)

- [ ] `BuySectionHeader` — title `buyTextPrimary` 18px w700, "See All" cyan 14px w500
- [ ] `BuyLayerDivider` — 8px height `buyDivider` (updated in Phase 1)
- [ ] `BuyOfflineBanner` — amber tint styling (integrated in Phase 1)
- [ ] `BuyComingSoonTeaser` — white card, border, shadow
- [ ] `BuyQrScanner` — scan area border cyan, overlay `Colors.black54`
- [ ] `TrustBadge` — 3 sizes, colour gradient by score (red <2.0, amber 2.0-3.5, green >3.5)
- [ ] `EscrowStatusIndicator` — green completed, cyan pulsing current, grey future, terminal badges (disputed amber, refunded grey, cancelled red)
- [ ] `CountdownTimerWidget` — `buyTextPrimary` normal, red urgent, "Expired" text
- [ ] `MarketplaceSearchBar` — `buyBackground`, `buyCardBorder`, 20px radius
- [ ] `ShareableBuyCard` — white card, type badge (cyan marketplace / green group buy)
- [ ] `ListingContextHeader` — white bg, `buyCardBorder` bottom border
- [ ] `CollectibleDropCard` — keeps dark aesthetic for premium feel
- [ ] `TrendingStrip` — red pulsing "LIVE" dot
- [ ] `ClusterPickerSheet` — white sheet, cyan checkboxes
- [ ] `TokenDisplay` — CREATE `lib/presentation/widgets/common/token_display.dart` if it does not already exist. Reusable widget accepting a `size` enum (`small`, `medium`, `large`, `hero`) and `int amount`:
  - `small`: 12px text, 12px tokenGold icon
  - `medium`: 14px text, 14px icon
  - `large`: 18px bold text, 18px icon
  - `hero`: 24px bold text, 24px icon
  - All sizes: tokenGold colour for icon, `buyTextPrimary` for amount text, `NumberFormat` for thousands separator
  - Used in: listing cards (medium), listing detail price (hero), wallet selection (large), purchase history (small), group buy detail (large), order cards (medium)
- [ ] Loading patterns: shimmer (grids), full-screen spinner (detail), overlay spinner (actions)
- [ ] Error patterns: inline card + snackbar
- [ ] Empty states: 48px icon `buyTextTertiary`, message `buyTextSecondary`
- [ ] Pull-to-refresh: spinner `AppColors.primary`, bg `buyCard`
- [ ] Standard screen patterns: BlocBuilder branching, BlocConsumer side-effects, infinite scroll guards

### 9.5 Push Notification Routing Verification (Spec §14.6)

- [ ] Verify existing routes: `marketplace_order`, `marketplace_dispute`, `provider_status`, `group_buy_milestone`
- [ ] Verify new routes: `purchase_success`, `purchase_refund`, `coupon_claimed`

### 9.6 Build & Lint

- [ ] `dart run build_runner build --delete-conflicting-outputs`
- [ ] `flutter analyze --fatal-infos` — zero errors
- [ ] `flutter test` — all tests pass

**Verify**: Zero dead code, accessibility minimums met, all widgets use light theme tokens, lint clean.

---

## Phase Summary

| Phase | Scope | New Files (est.) | Modified Files (est.) | New CFs (est.) |
|-------|-------|------------------|-----------------------|----------------|
| 0 | Foundation & Entities | ~14 | ~18 | 0 |
| 1 | Hub Redesign & Light Theme | ~2 | ~15 | 0 |
| 2 | Featured Carousel & Brand Partners | ~5 | ~12 | ~12 |
| 3 | Marketplace Consumer | ~22 | ~18 | ~25 |
| 4 | Marketplace Admin | ~2 | ~8 | ~9 |
| 5 | Hlangana Group Buys | ~6 | ~12 | ~12 |
| 6 | VAS Admin | ~3 | ~4 | ~10 |
| 7 | Cross-Cutting | ~3 | ~10 | 0 |
| 8 | Firestore Rules & Indexes | 0 | ~4 | 0 |
| 9 | Polish & Cleanup | 0 | ~15 | 0 |
| **Total** | | **~59** | **~116** | **~68** |

> **Note**: File counts above are plan-level estimates. Spec §16 cites ~71 new + ~31 modified (~102 total). The discrepancy is because this plan counts at a different granularity — "modified files" here includes files touched across multiple phases (counted once per phase), while the spec counts distinct files. The CF count increased from ~66 to ~68 with the addition of `updateBrandTier` and `duplicateStorefrontSection`.

---

## Dependency Graph

```
Phase 0 (Foundation)
  ├── Phase 1 (Hub) ─────────────────┐
  │     ├── Phase 2 (Brand Partners)  │
  │     ├── Phase 3 (Marketplace)     ├── Phase 7 (Cross-Cutting)
  │     │     └── Phase 4 (Mkt Admin) │      └── Phase 8 (Rules/Indexes/Config)
  │     ├── Phase 5 (Group Buys)      │            └── Phase 9 (Polish)
  │     └── Phase 6 (VAS Admin)  ─────┘
```

- **Phase 0** must complete before anything else
- **Phase 1** must complete before Phases 2-6
- **Phases 2-6** can run in parallel (independent features)
- **Phase 7** can run alongside Phases 2-6 (integrates incrementally)
- **Phase 8** requires all CFs from Phases 2-6 to be written
- **Phase 9** is the final pass after all features are complete

---

## Spec Section → Phase Mapping

| Spec Section | Phase(s) | Notes |
|-------------|----------|-------|
| §1 Architecture Decisions | Referenced throughout | 47 decisions inform all phases |
| §2 Color Tokens | Phase 0.1 | 21 tokens |
| §3 Hub Layout | Phase 1.1-1.10 | Hub screen + BuyTabBloc |
| §4 Brand Partners | Phase 2 | Storefront builder, 8 new sections, tiers (2.14 + `updateBrandTier` CF), analytics, `duplicateStorefrontSection` CF (2.13), community scoping (2.12) |
| §5 Featured Carousel | Phase 2.1 | Polish + verification + community scoping |
| §6 Utilities | Phase 0.3, 1.3, 1.4, **1.11**, **6** | Light theme (1.11), VAS admin (6), auto-refund (6.6), purchase notifications (6.7), recent recipients removal (1.4), **step-up auth (1.11)** |
| §7 My Regulars (REMOVED) | Phase 1.4, 9.1 | Full removal in 1.4, cleanup verification in 9.1 |
| §8 Marketplace | Phase 3, 4 | Consumer (3), Admin (4 incl. admin router 4.9), voice messages (3.15), offers (3.16), auto-moderation (3.22), SA location (3.17), first-time UX (3.21), scheduled CFs (3.25), config doc (8.5) |
| §9 Group Buys | Phase 5 | Community creation (5.5 + max 30 + organizer join constraint), fulfilment UI (5.3), organizer mgmt (5.6), My Deals (5.7), moderation (5.12), first-time UX (5.14), **step-up auth (5.2)**, ClusterPickerSheet (5.8), ranking algorithm (1.9) |
| §10 Common UI Components | Phase 5.8, 9.4 | 16 cross-cutting + 7 shared widgets + ClusterPickerSheet (5.8) + TokenDisplay verification (9.4) |
| §11 Feature Flags | Phase 1.10 | Wiring into hub |
| §12 Cross-Cutting | Phase 0.9-0.10, 7 | Drift (0.9), packages (0.10), analytics (7.1), localization (7.2), offline (7.3), images (7.4), errors (7.6) |
| §13 Firestore Rules & Indexes | Phase 8 | 18 existing + **4 new** rules (incl. favourites), 8 new indexes, config docs (7 fields), category migration |
| §14 Key Integration Points | Phase 1.11, 3.4, 3.15, 3.23, 3.29, 5.2, 8.4, 9.5 | Share-to-chat, buyer-seller chat, wallet, notifications, CF exports, deep links, **step-up auth (1.11, 3.4, 5.2)**, **community scoping (2.1, 2.12)** |
| §15 Phased Implementation | Superseded by this document | |
| §16 Implementation Files Summary | Superseded by this document | |

---

## Verification Checklist (Per Phase)

Before marking any phase as complete, verify:

1. **Clean Architecture** — respect layer boundaries (domain → data → presentation)
2. **SOLID / DRY** — small focused functions, no duplication
3. **Deterministic** — no undefined behavior, clear fallback semantics
4. **No race conditions** — proper synchronization, sequential awaits
5. **Edge cases** — null, empty, network failure, partial data, timeout, re-entrant calls
6. **build_runner** — run after every Freezed/entity/model/DI change
7. **Lint clean** — `flutter analyze --fatal-infos` passes
8. **Light theme** — all Buy screens use Buy colour tokens, no `AppColors` dark palette
9. **Accessibility** — 48px touch targets, WCAG AA contrast, visual feedback
10. **No dead code** — no unused imports, no orphan files

---

## Gap Coverage Reference

This section maps each of the 40 identified gaps to the plan task that addresses it.

### Critical Gaps (12 original + 5 from second review = 17)
| # | Gap | Addressed In |
|---|-----|-------------|
| 1 | VAS Admin screen details | Phase 6.1-6.3 (full screen specs) |
| 2 | Utilities light theme (5 screens) | Phase 1.11 (detailed per-screen specs) |
| 3 | Recent Recipients removal | Phase 1.4 (full cleanup list) |
| 4 | Purchase notifications | Phase 6.7 (3 templates with copy) |
| 5 | Purchase auto-refund guarantee | Phase 6.6 (idempotency + ledger) |
| 6 | Voice messages in chat | Phase 3.15 (hold-to-record, waveform, playback) |
| 7 | Community group buy creation | Phase 5.5 (full 11-field form, 3-step flow) |
| 8 | Group buy fulfilment UI | Phase 5.3 (voucher/collection/delivery cards) |
| 9 | Location banner | Phase 3.21 (GPS + manual, dismissible) |
| 10 | Contextual tooltips | Phase 3.21 (4 tooltips, SharedPreferences) |
| 11 | First-purchase trust builder | Phase 3.21 (3-step Payment Protection) |
| 12 | Seller level-up celebration | Phase 3.14 (confetti + modal detail) |
| C1 | `updateBrandTier` CF missing | Phase 2.14 (new CF + export in 8.4) |
| C2 | `duplicateStorefrontSection` CF missing | Phase 2.13 (new CF + export in 8.4) |
| C3 | Step-up auth missing for utility purchases + group buy joins | Phase 1.11 (utility), Phase 5.2 (group buy) |
| C4 | `config/marketplace` document incomplete (5 fields missing) | Phase 8.5 (all 7 fields + config-driven CFs) |
| C5 | `getMarketplaceStats` contradiction | Phase 1.5 (static card clarified), Phase 9.1 (removal rationale) |

### Significant Gaps (10 original + 7 from second review = 17)
| # | Gap | Addressed In |
|---|-----|-------------|
| 13 | Brand builder details | Phase 2.13 (undo/redo, auto-save, templates, validation) |
| 14 | Consumer enhancements | Phase 2.6 (animation timings, scroll-to) |
| 15 | Marketplace admin details | Phase 4.1-4.6 (per-screen detail) |
| 16 | Scheduled CFs consolidated | Phase 3.25 (6 scheduled CFs), 5.10 (1 scheduled CF) |
| 17 | 68 notification templates | Phase 3.26 (46), 5.11 (19), 6.7 (3) |
| 18 | Auto-moderation thresholds | Phase 3.22 (8 triggers with numeric thresholds) |
| 19 | SA Location details | Phase 3.17 (data prep, geohash, GPS, repository) |
| 20 | Offer system lifecycle | Phase 3.16 (make/accept/decline/counter/expire/withdraw) |
| 21 | Dispute flow detail | Phase 3.12 (seller response, admin resolution, timeline, auto-refund path) |
| S1 | Community scoping for consumer queries | Phase 2.1 (featured carousel), Phase 2.12 (brand storefronts) |
| S2 | Group buy hub ranking algorithm | Phase 1.9 (exact scoring formula) |
| S3 | Community deal constraints (max 30, organizer join) | Phase 5.5 (constraints), Phase 5.10 (server-side enforcement) |
| S4 | Favourites collection missing from security rules | Phase 8.1 (4th new collection rule added) |
| S5 | Admin router updates for seller levels + banned words | Phase 4.9 (new routes + sidebar entries) |
| S6 | Brand review aggregate recomputation underspecified | Phase 2.16 (transaction pattern, exclusion criteria) |
| S7 | MarketplaceListing `category` type change is breaking | Phase 0.5 (migration note), Phase 8.5 (migration CF) |

### Correctness Gaps (6)
| # | Gap | Addressed In |
|---|-----|-------------|
| 22 | Phase mapping table | Mapping table updated with detailed Notes column |
| 23 | Package dependencies | Phase 0.10 (complete package list) |
| 24 | Dead code specifics | Phase 9.1 (complete list with file paths) |
| 25 | Firestore rules complete | Phase 8.1 (all 18 existing + **4 new** listed) |
| 26 | TypeScript enum sync | Phase 0.3 (explicit file path + values) |
| 27 | config/marketplace doc | Phase 8.5 (document creation + **all 7 fields**) |

### Minor Gaps (12 original + 8 from second review = 20)
| # | Gap | Addressed In |
|---|-----|-------------|
| 28 | Brand products migration | Phase 2.15 (migration task), 9.2 (cleanup) |
| 29 | Listing edit restrictions | Phase 3.7 (price lock + category immutable) |
| 30 | Stale listing nudge | Phase 3.6, 3.19 (3+ renewals <10 views) |
| 31 | Progressive data collection | Phase 3.8 (milestones: 1st/3rd/5th sale) |
| 32 | Quick-view bottom sheet | Phase 3.2 (long-press detail) |
| 33 | Group buy My Deals details | Phase 5.7 (status indicators, completed section) |
| 34 | Convert suggestion flow | Phase 5.12 (pre-fill form, auto-join) |
| 35 | Community moderation tab | Phase 5.12 (flagged deals, organizer suspension) |
| 36 | BuyAnalyticsService events | Phase 7.1 (full ~30 method list) |
| 37 | Localization string count | Phase 7.2 (per-screen breakdown) |
| 38 | CF exports specifics | Phase 8.4 (full function name list incl. `updateBrandTier`, `duplicateStorefrontSection`) |
| 39 | Firebase Dynamic Links | Phase 3.23 (configuration + link patterns) |
| 40 | MarketplaceDispute entity | Phase 0.4 (new entity with fields) |
| M1 | ClusterPickerSheet widget never created | Phase 5.8 (explicit CREATE task) |
| M2 | TokenDisplay widget creation unclear | Phase 9.4 (create-if-missing guidance) |
| M3 | `isDraft` default not specified | Phase 0.6 (default `true`) |
| M4 | Phase Summary file counts diverge from spec §16 | Phase Summary footnote (explains discrepancy) |
| M5 | `chatConversationId` preservation on BuyOrder | Phase 0.5 (PRESERVE note) |
| M6 | `storefrontCoupons` collection vs subcollection | Phase 8.1 (explicit: top-level collection) |
| M7 | `BuySubcategoryListScreen` removal ambiguity | Phase 9.1 (decision criteria clarified) |
| M8 | Drift `saved_listings` table placement rationale | Phase 0.9 (note: avoids second migration) |