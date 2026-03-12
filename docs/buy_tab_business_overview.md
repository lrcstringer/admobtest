# Buy Tab — Comprehensive Business Overview

> **Document purpose**: Business-level overview of all 5 Buy tab features — their purpose, processes, use cases, entities, screens, admin functionality, and how each works from a user perspective.
> **Generated**: 2026-03-13

---

## Table of Contents

1. [Buy Tab Overview](#1-buy-tab-overview)
2. [Feature 1: Buy Tab Home & Featured Items](#feature-1-buy-tab-home--featured-items)
3. [Feature 2: Brand Storefronts](#feature-2-brand-storefronts)
4. [Feature 3: VAS Purchases (Airtime, Data, Electricity)](#feature-3-vas-purchases)
5. [Feature 4: P2P Marketplace — Intengiso](#feature-4-p2p-marketplace--intengiso)
6. [Feature 5: Group Buys — Hlangana](#feature-5-group-buys--hlangana)
7. [Cross-Feature: The Token Economy](#cross-feature-the-token-economy)

---

## 1. Buy Tab Overview

The Buy tab is one of five main sections in the iMaliChat app (**Home | Earn | Chat | Buy | Wallet**). It serves as the **spending hub** where users convert earned tokens into real-world value — prepaid services, brand deals, peer-to-peer goods, and group purchases.

### Buy Tab Home Screen — 4-Layer Layout (top to bottom)

| Layer | Content | Where It Leads |
|-------|---------|----------------|
| **Layer 1: Featured & Brands** | Featured items carousel + brand partners strip | Brand storefronts, categories, external URLs |
| **Layer 2: Regulars & Utilities** | "My Regulars" dock + VAS category grid (Airtime, Data, Electricity, etc.) | Pre-filled or new VAS purchase flow |
| **Layer 3: Intengiso Marketplace** | Community P2P marketplace entry card with trending thumbnails, listing/seller counts | P2P Marketplace hub |
| **Layer 4: Hlangana Group Buys** | Cluster opt-in prompt + group buying deals | Group Buys screen |

### Complete Screen Map (28 screens)

#### Core
| Screen | Route | Purpose |
|--------|-------|---------|
| Buy Services (Hub) | `/buy` | Main 4-layer hub screen |
| Purchase History | `/buy/history` | Past purchases list |
| Transactions | `/buy/transactions` | Transaction history & details |

#### VAS Purchases
| Screen | Route | Purpose |
|--------|-------|---------|
| Category Drill-Down | `/buy/category/:categoryId` | Provider grid → product selection → payment |
| Wallet Selection | `/buy/wallet-selection` | Choose payment method |
| Purchase Success | `/buy/wallet-selection/success` | Confirmation with voucher/PIN |
| Purchase Failure | `/buy/wallet-selection/failure` | Error details + retry |

#### Brand Storefronts
| Screen | Route | Purpose |
|--------|-------|---------|
| Brand Storefront Detail | `/buy/brand/:storefrontId` | Full brand page with sections |

#### P2P Marketplace (Intengiso)
| Screen | Route | Purpose |
|--------|-------|---------|
| Marketplace Hub | `/buy/marketplace` | 5-category tabs + search |
| Listing Detail | `/buy/marketplace/listing/:listingId` | Full listing with buy/offer/save |
| Seller Profile | `/buy/marketplace/provider/:providerId` | Seller info, vouches, listings |
| Provider Registration | `/buy/marketplace/register` | Become a marketplace seller |
| Create Listing | `/buy/marketplace/create-listing` | Create new listing form |
| My Orders | `/buy/marketplace/orders` | User's marketplace orders |
| Order Detail | `/buy/marketplace/orders/:orderId` | Order tracking & actions |
| Report | `/buy/marketplace/report/:targetType/:targetId` | Report listing or seller |
| Subcategory List | `/buy/subcategories/:categoryId` | Browse marketplace subcategories |
| My Listings | *(seller portal)* | Manage own listings by status |
| Edit Listing | *(seller portal)* | Edit an existing listing |
| Seller Dashboard | *(seller portal)* | Seller analytics & management |
| Saved Items | *(seller portal)* | Saved/wishlisted listings |

#### Group Buys (Hlangana)
| Screen | Route | Purpose |
|--------|-------|---------|
| Group Buy List | `/buy/group-buys` | Active Deals & My Deals tabs |
| Create Group Buy | `/buy/group-buys/create` | Suggest a new deal |
| Community Group Buy Create | `/buy/group-buys/community-create` | Community-led group buy |
| Group Buy Detail | `/buy/group-buys/:groupBuyId` | Progress, contributors, join/leave/complete |
| Voucher Redemption | `/buy/group-buys/:groupBuyId/voucher` | Redeem digital voucher |
| Collection Confirmation | `/buy/group-buys/:groupBuyId/collection` | Confirm physical item pickup |

### Data Loading
The Buy tab uses an **offline-first pattern**: cached data loads instantly, then refreshes from the server in the background. This ensures the Buy tab is usable even with poor connectivity.

---

## Feature 1: Buy Tab Home & Featured Items

### Purpose
The Buy tab home is the **landing page** and navigation hub for all spending features. Featured items are admin-curated promotional cards that surface deals, campaigns, and seasonal offers.

### Featured Items

Featured items are the **primary promotional mechanism** on the Buy tab. They appear as an auto-advancing carousel (5-second interval) at the top of the screen. The carousel pauses on user touch and resumes on scroll.

**Featured item types:**
| Type | Purpose |
|------|---------|
| `campaign` | Brand activation or promotion |
| `collectible` | Limited-edition or NFT-style drop |
| `trending` | Algorithmically selected hot items |
| `promotion` | Time-bound discount or offer |

**What admins configure per featured item:**
- Title, subtitle, and CTA button text (marketing copy)
- Image OR looping video (rich media)
- Background gradient (presets: goldOrange, cyanBlue, pinkPurple, logo, custom) or custom hex colours
- Image layout (`full` = entire card, `right` = right half only) and opacity
- Deep link route (internal route like `/buy/category/airtime` or external URL)
- Associated brand ID (for brand storefront links)
- Sort order (controls carousel position)
- Schedule window (`scheduledStart` → `scheduledEnd`) for time-limited campaigns
- Community targeting (specific community IDs, or empty = shown globally)
- Active/inactive toggle

**Visibility rules:**
- Item must be marked active
- Current time must be within the scheduled window (if one is set)
- All schedule comparisons use UTC for consistency

**Example:** Admin creates a "Vodacom R50 Bundle Launch" → sets looping video + gold gradient → schedules for next Monday 9am → targets Sandton cluster → carousel shows it with "Claim with Vodacom" CTA button.

### Buy Categories

Categories define the **types of services** available. Each appears as a tappable tile in the utilities grid with an emoji icon.

| Category | Icon | Examples |
|----------|------|----------|
| Airtime | 📱 | Vodacom, MTN, Cell C top-ups |
| Data | 📶 | Mobile data bundles |
| Electricity | 💡 | Prepaid electricity tokens (Eskom, local) |
| Water | 💧 | Prepaid water |
| Voucher | 🎟️ | Gift vouchers, store credit |
| Other | 📦 | Future service types |

**Category features:**
- Categories can be marked **"Coming Soon"** — shown greyed-out as a teaser for future launches
- Categories can be **feature-flagged** — gated by community or globally (e.g., "Marketplace only in Johannesburg for beta")
- Categories with `purchaseCategoryMapping` route to the VAS provider flow
- Categories without mapping (e.g., Marketplace) show subcategory lists instead

**Admin manages:** Create, update, deactivate, toggle "Coming Soon", manage feature flags, set subcategories, customise icon/colour/sort order.

### Regulars (Quick Repeat Purchases)

Regulars are **saved purchase shortcuts** that appear as a horizontal scrolling chip dock. They are created automatically when a user completes a VAS purchase, enabling one-tap re-buying.

**What a regular stores:**
- Provider and product (e.g., "Vodacom R29 Airtime")
- Category and category emoji
- Recipient (phone number, meter number, etc.)
- Optional user-defined nickname (e.g., "Mom's phone")
- Purchase count (used for ordering — most-bought items appear first)
- Last purchased date
- Pinned status (user can pin favourites to the front of the dock)

**How they work:**
1. User buys airtime/data → system creates or updates a regular with recipient number
2. Next visit to Buy tab → regulars dock shows chips (e.g., "MTN R50")
3. One tap → pre-fills the purchase flow with saved provider, product, and recipient
4. After repeated purchases, usage count increases and chip rises in ordering
5. Users can pin regulars for permanent priority positioning

**Note:** Regulars are entirely user-driven — admin has no direct control over them. They are auto-generated from purchase history.

### Admin Functionality
- **Featured Items**: Full CRUD — create with rich media + gradients + scheduling + community targeting, update live campaigns, soft-delete expired ones
- **Categories**: Full CRUD — create, update, toggle active/"Coming Soon", manage feature flags and subcategories
- **Feature Flags**: Create and toggle feature gates by community or globally
- All admin functions require `buy:` permission checks

---

## Feature 2: Brand Storefronts

### Purpose
Brand storefronts are **digital brand pages** within the app where brand partners showcase their products, run promotions, offer coupons, share media content, and engage directly with users. They function like mini e-commerce pages inside iMaliChat.

### How Brand Storefronts Work

Each brand storefront is backed by a **Brand Account** (the business's administrative profile) and configured with **sections** — modular content blocks that make each page unique.

#### Brand Account
| Field | Purpose |
|-------|---------|
| Brand name & display name | Business identity |
| Logo & cover image | Visual branding |
| Contact info | Email, phone, website, social media |
| Category | Business type (retail, telecoms, food, etc.) |
| Verification status | Admin-verified badge |
| Follower count | Social proof |
| Aggregate rating | From user reviews |

#### Storefront Sections
Each storefront is composed of configurable sections:

| Section Type | Content |
|-------------|---------|
| **Hero** | Top banner with brand imagery, headline, and call-to-action |
| **Products** | Grid/list of the brand's product catalog |
| **Promotions** | Special offers, deals, announcements (with optional expiry) |
| **Showcase Videos** | Embedded video content (product demos, brand stories) |
| **Coupons** | Claimable discount codes and vouchers |
| **FAQ** | Frequently asked questions |
| **Locations** | Physical store locations with addresses and map coordinates |
| **Custom** | Flexible content blocks |

Each section has a title, sort order, active/inactive toggle, and display settings (column count, layout style, background colour, card style, max items).

### Key Business Processes

#### Coupon System
Brands offer digital coupons through their storefront.

**Coupon properties:**
- Code, title, description
- Discount type: percentage off, fixed amount off, or free item
- Discount value
- Expiry date
- Max claims (total across all users)
- Current claim count

**Claiming flow:**
1. User sees available coupons on the brand page (expired coupons are filtered out)
2. User taps "Claim"
3. System checks: has user already claimed this coupon? Is the max claims limit reached?
4. If eligible → coupon code is returned and saved; claim count increments
5. Already-claimed coupons show as "Claimed" (cannot claim again)

**Rules:** One claim per user per coupon. Max claims limit prevents over-distribution. Expired coupons hidden from display.

#### Brand Reviews
Users rate brands on three dimensions:
- **Quality** (1–5 stars)
- **Value** (1–5 stars)
- **Service** (1–5 stars)
- Optional free-text comment
- Optional link to a specific order

All three ratings are required. The brand's aggregate rating is calculated from all reviews.

#### Following Brands
- Users can follow/unfollow brands
- Follow status is persisted per user
- The UI updates optimistically (instant toggle, reverts on server failure)
- Following may surface brand content more prominently or trigger notifications

#### Chat with Brand
- Storefronts can optionally enable a **Chat button**
- When enabled, users can initiate direct conversation with the brand
- Bridges the Buy and Chat features of the app

#### Storefront Analytics
- Each unique visitor is tracked (one count per user per storefront, not per visit)
- Admins access brand analytics showing views, engagement, and performance metrics
- Analytics access requires the `buy:getBrandAnalytics` admin permission

### Main Screens
1. **Brand Storefronts List** — Browse all active brand storefronts (name, logo, category, rating)
2. **Brand Storefront Detail** — Full brand page with hero, products, promos, videos, coupons, FAQ, locations, reviews, follow/unfollow, chat button, submit review

### Admin Functionality
- **Brand Management**: Create, update, soft-delete brand storefronts
- **Section Configuration**: Add, remove, reorder content sections with display settings
- **Product Management**: Add products with pricing, descriptions, images
- **Coupon Management**: Create coupons with limits, expiry, discount types
- **Brand Analytics**: View storefront performance (requires `buy:getBrandAnalytics` permission)

---

## Feature 3: VAS Purchases

### Purpose
VAS (Value-Added Services) purchases allow users to **buy prepaid services** — airtime, data bundles, electricity, water, and vouchers — using their token balance. This is the **core utility feature** that gives real-world spending power to earned tokens.

### How VAS Purchases Work

#### Purchase Flow (User Journey)
1. User taps a category tile on the Buy tab (e.g., "Airtime")
2. **Purchase Screen** shows available **service providers** for that category (e.g., Vodacom, MTN, Cell C)
3. User selects a provider
4. Provider's available **products** are shown (e.g., "R29 Airtime", "1GB Data Bundle")
5. User selects a product and enters a **recipient** (phone number, meter number, etc.)
6. User confirms the purchase
7. **Step-up authentication** triggers (biometric or PIN verification)
8. System deducts tokens from the user's wallet via the double-entry ledger
9. Purchase record is created with `pending` status
10. Backend calls the third-party provider API to fulfil the purchase
11. On success: status → `completed`, voucher/PIN details delivered to user
12. On failure: status → `failed`, automatic refund triggered

#### Purchase Status Lifecycle
```
pending → processing → completed (happy path)
pending → processing → failed → refunded (failure path)
pending → cancelled (user/system cancellation)
```

### Service Providers & Products

**Service Provider** = a company offering prepaid services (e.g., Vodacom, Eskom):
- Name, code, logo, category, active status, sort order
- Contains a list of products

**Service Product** = an individual purchasable item within a provider:
- Name and code (e.g., "R29 Airtime", "1GB 30-day Data")
- Price in tokens and price in ZAR (dual pricing, 100 tokens = R1)
- Description and validity period (e.g., "30 days")
- Active status and sort order

Only active providers with active products are shown to users.

### Pricing
All products display dual pricing:
- **Token price** (e.g., 2,900 tokens)
- **ZAR price** (e.g., R29.00)
- Conversion: **100 tokens = R1 ZAR**

### Safety & Security
- **Step-up authentication**: Biometric/PIN required before every purchase
- **Idempotency**: Each purchase uses a unique idempotency key to prevent duplicate charges on network retries
- **Balance validation inside transaction**: Token balance is checked within the ledger transaction (not before), preventing race conditions where two purchases could overdraw
- **Automatic refunds**: Failed purchases trigger automatic token refund

### Notifications
Users receive push notifications for:
- Purchase completion (success, with voucher/PIN details)
- Purchase failure (with error context)
- Refund confirmation

### Main Screen
**Purchase Screen** — Single screen with sequential steps:
1. Provider selection (logos and names)
2. Product selection (prices in tokens and ZAR)
3. Recipient input (phone number, meter number)
4. Confirmation (purchase summary)
5. Result (success with voucher/PIN, or failure with error)

### Admin Functionality
- **Provider Management**: Create, update, deactivate service providers
- **Product Management**: Add/edit/deactivate products within providers, set pricing in tokens and ZAR, set validity periods
- **Category Management**: Manage purchase categories
- **Purchase Monitoring**: View purchase records, monitor failures, track refunds

---

## Feature 4: P2P Marketplace — Intengiso

### Purpose
Intengiso ("trading" in isiZulu) is a **peer-to-peer marketplace** where users buy and sell goods and services to each other using tokens. It features **escrow payment protection**, an **offer/negotiation system**, a **vouch-based reputation system**, and a **4-tier seller progression system**.

Core philosophy: **Trustless transactions through escrow, reputation through vouching, and seller progression through a tiered level system.**

### How the Marketplace Works

#### Becoming a Seller (3-Step Registration)

Registration is **instant** — no admin approval required. Users become active sellers immediately.

**Step 1 — Profile Setup:**
- Display name (min. 2 characters), optional bio and profile photo
- No email/ID verification required

**Step 2 — Category & Services:**
- Select primary marketplace category from 8 available:
  - Food & Drinks | Beauty & Wellness | Home & Property | Clothing & Fashion
  - Fix & Repair | Moving & Delivery | Kids/Pets/Care | Everything Else
- Optionally add multiple categories and sub-categories
- Write services description

**Step 3 — Confirmation & Submit**

**Profile tracks:** Join date, total sales, average rating, vouch count, verified status, seller level

#### 4-Tier Seller Level Progression
| Level | Threshold | Badge |
|-------|-----------|-------|
| New Seller | 0 completed orders | 🟡 |
| Active | 1+ completed orders | 🟠 |
| Trusted | Higher engagement | 🔵 |
| Star | Best performers | ⭐ |

**Verified badge** automatically awarded when: vouch count ≥ 5 AND trust score ≥ 4.0 (or manually overridden by admin).

#### Creating a Listing
Sellers create listings with:
- Title (min. 3 characters) and description
- Category and optional sub-category
- Price in tokens (ZAR equivalent auto-calculated)
- Up to 5 images (auto-uploaded to Firebase Storage)
- Location (free text or geohash-based)
- **Delivery method**: Collection, Delivery, or Both
- **Service area type**: "My Location Only" | "Deliver Nearby" | "Nationwide"
- **Delivery fee** (optional, in tokens, added to order total)
- Listing ID is **deterministic** (`{providerId}_{titleHash}_{dateBucket}`) to prevent accidental duplicates

**Listings go live immediately** — no admin review queue.

**Listing statuses:**
| Status | Meaning |
|--------|---------|
| `active` | Listed and visible to buyers |
| `pending` | Under review or offer accepted |
| `paused` | Temporarily hidden by seller |
| `sold` | Item has been sold |
| `expired` | Listing timed out |
| `flagged` | Reported by users, hidden until resolved |
| `removed` | Taken down by admin or seller |

**Listing metadata tracked:** View count, report count, favourite count, renewal count (stale renewal detection if ≥ 3 renewals without new images), total days paused.

#### Browsing & Searching
Buyers can:
- Browse by category (8 categories with sub-categories) or community
- Search with text queries
- Paginated browsing (load more)
- Save/favourite listings for later (with stale item detection for delisted/sold items)
- View a seller's profile, other listings, reputation, and level badge
- Geolocation-based search (geohash)

#### Offer & Negotiation System
The marketplace supports **offer-based negotiation**, not just fixed prices:

1. **Buyer makes an offer:**
   - Offer amount in tokens (must be less than asking price — validated server-side)
   - Optional message to seller
   - One active offer per user per listing (enforced by deterministic ID: `{userId}_{listingId}`)
   - Offers auto-expire after a set period

2. **Seller responds:**
   - **Accept** → proceeds to order creation; listing marked as `pending`
   - **Decline** → offer rejected
   - **Counter** → seller proposes different amount (must be ≤ listing price)

3. **Buyer responds to counter:**
   - Accept the counter price → order created at counter price
   - Decline or ignore → offer expires

4. **Offer statuses:** pending → accepted / declined / countered / expired / withdrawn

**Discount auto-calculated:** `discount% = (1 - offerAmount / originalPrice) × 100`

**Chat integration:** Each offer can link to a chat conversation for synchronous negotiation.

#### Order Lifecycle (Escrow-Protected)

This is the core safety mechanism of the marketplace:

```
Step 1: PURCHASE — Buyer selects wallet, balance pre-checked
        ↓         Step-up auth (biometric/PIN) required
Step 2: ESCROW — Tokens debited from buyer → MARKETPLACE_ESCROW system account
        ↓         Order status: escrowed
Step 3: FULFILMENT — Seller marks fulfilled (with optional tracking/proof)
        ↓         Order status: fulfilled
Step 4: RECEIPT — Buyer confirms receipt → escrow releases tokens to seller
                  Order status: completed
```

**Alternative flows:**
- **Cancel**: Either party cancels `pending` or `escrowed` orders → tokens return to buyer
- **Dispute**: Either party raises dispute with reason + photo evidence → admin review
- **Seller Refund**: Seller voluntarily refunds (full or partial)

**Full order statuses:** `pending` → `escrowed` → `fulfilled` → `completed`, or `cancelled`, `disputed`, `refunded`

**Delivery methods:**
| Method | Description |
|--------|-------------|
| `collection` | Buyer picks up from seller (no delivery fee) |
| `delivery` | Seller ships to buyer (optional delivery fee applies) |
| `meetup` | In-person exchange |
| `digital` | Instant digital delivery |

**Automatic timeout enforcement (scheduled jobs):**
- Seller hasn't fulfilled within ~7 days of escrow → auto-refund buyer
- Buyer hasn't confirmed receipt within ~7 days of fulfilment → auto-release to seller

#### Dispute & Resolution Flow

1. **Either party raises dispute** with reason (min. 10 characters) + photo evidence
2. **Opposing party responds** with written response + counter-evidence photos + proposed resolution amount
3. **Admin reviews** both sides and either approves the proposed resolution or imposes a custom one
4. **Resolution** triggers appropriate refund (full or partial)

**Refund trigger types:**
| Type | Description |
|------|-------------|
| `buyerDispute` | Buyer opened a dispute |
| `sellerInitiated` | Seller proactively refunded |
| `deliveryTimeout` | Seller didn't deliver in time |
| `adminAction` | Admin-mandated refund |
| `confirmationTimeout` | Buyer didn't confirm after deadline |

#### Vouch / Reputation System
After a completed transaction, the buyer can **vouch** for the seller:
- Rating (1–5 stars) and optional comment
- Linked to the specific order (can't vouch without participation — prevents fake reviews)
- Contributes to seller's **trust score** (average of all ratings) and **vouch count**
- At 5 vouches + 4.0+ trust score → automatic **verified badge**

#### Reporting & Moderation
Users can report listings or sellers for inappropriate content, scams, or fraudulent behaviour:
- Report count tracked per listing
- Flagged listings hidden from search until admin review
- **Provider suspension cascade**: If a seller is suspended, all their active listings are auto-paused and they can't create new listings (existing in-progress orders continue)

#### Listing Management (Seller)
Sellers can: update listings, pause/unpause, mark as sold, renew expired listings (transactional to prevent race conditions, stale renewal detected at ≥ 3 renewals)

#### Seller Dashboard
The seller dashboard provides:
1. **Seller Level Card** — Current level with progress to next level and visual badges
2. **Stats Grid** — Completed orders, total earnings (tokens + ZAR), trust score, active listing count
3. **Quick Actions** — View orders, create listing, view listings
4. **Earnings & Analytics** — Average response time, dispute rate, cancellation rate, warning count
5. **My Listings Summary** — Status breakdown of all listings

### Payment Protection
- **Payment Protection Explainer** widget appears near the Buy button on listing detail screens, educating buyers about escrow
- All tokens flow through the **MARKETPLACE_ESCROW** system account in the double-entry ledger
- Every escrow operation uses **idempotency keys** to prevent duplicate ledger entries on retries
- If escrow processing fails after order creation, the order and listing status are automatically reverted

### Main Screens
1. **Marketplace Hub** — 5-category tab browsing + search bar
2. **Listing Detail** — Full listing with images, description, price, seller profile + level badge, Buy Now, Make Offer, Payment Protection Explainer, save/report
3. **Seller Profile** — Seller info, vouch history, all listings, trust score, level badge
4. **Provider Registration** — 3-step seller registration flow
5. **Create Listing** — Form with category, pricing, images, delivery method, service area
6. **My Listings** — Seller's listing management by status (active, pending, paused, sold, expired, flagged)
7. **My Orders** — Order management with detail drill-down
8. **Order Detail** — Order tracking, fulfilment confirmation, dispute, refund
9. **Report** — Report a listing or seller with reason
10. **Seller Dashboard** — Analytics, level progression, earnings
11. **Saved Items** — Favourited listings with stale item indicators

### Admin Functionality
The marketplace is largely **self-service**, with backend enforcement of:
- Deterministic IDs (prevent duplicate listings and offers)
- Transaction wrapping for renewal and offer processing (prevent race conditions)
- Escrow management via the double-entry ledger with idempotency
- Report review queue for flagged content
- Provider suspension cascade (auto-pause all listings)
- Server-side validation of offer amounts and counter-offer bounds
- Scheduled auto-refund and auto-completion jobs

### Key Business Rules
1. All purchases go through escrow — tokens locked in MARKETPLACE_ESCROW, released only on buyer confirmation
2. Step-up auth required before any purchase
3. One offer per user per listing (deterministic IDs)
4. Offers must be below asking price; counter-offers must be ≤ listing price
5. Accepted offers lock the listing (status → `pending`)
6. Listing renewal is transactional (prevents concurrent renewals)
7. Sellers can voluntarily refund buyers (full or partial)
8. Buyers can dispute orders with photo evidence for admin review
9. Auto-refund if seller doesn't fulfil within ~7 days
10. Auto-complete if buyer doesn't confirm receipt within ~7 days
11. Seller verification at 5 vouches + 4.0+ trust score
12. Suspended sellers have all listings auto-paused
13. Listings go live immediately (no approval queue)
14. Stale renewal detection at ≥ 3 renewals without new images

---

## Feature 5: Group Buys — Hlangana

### Purpose
Hlangana ("come together" in isiZulu) is a **collective purchasing feature** that allows users to pool tokens together for group/bulk buying. It operates in two modes:
1. **Admin-Curated Hub Deals** — Deals sourced and managed by the iMaliChat team
2. **Community Group Buys** — User-organised group purchases within communities

### How Group Buys Work

#### Mode 1: Admin-Curated Hub Deals

The iMaliChat team curates deals from brands and retailers:
- **Digital deals** → shown to ALL users (no geographic restriction)
- **Physical deals** → filtered by user **cluster** (geographic/demographic grouping) since physical items need local pickup/delivery

Hub deals appear in the Group Buy Hub Section on the Buy tab home screen.

**Deal Suggestion Flow:**
Users can suggest deals they'd like to see:
1. User submits: description, brand/store, estimated price, source URL, image, whether they want to auto-join
2. Suggestion ID is deterministic (`{userId}_{descHash}_{dateBucket}`) — prevents duplicate suggestions
3. Admin reviews and can approve (creating an official group buy) or decline

#### Mode 2: Community Group Buys

Any user (the "organiser") can create a group buy:
- Title, description, target amount (total tokens needed), deadline
- Optional link to a marketplace listing
- Min participants (default: 2) and optional max participants

#### Contribution Flow
1. User selects amount to contribute
2. Tokens are deducted and placed in **escrow**
3. Contribution record created (deterministic ID: `{userId}_{groupBuyId}` — one contribution per user per group buy)

Contributions track: amount, wallet, status, voucher code (digital items), collection status (physical items)

#### Group Buy Lifecycle
```
active → funded → completed    (happy path)
active → expired               (deadline passed, target not met → auto-refund)
active/funded → cancelling → cancelled  (organiser cancels → auto-refund)
```

| Status | Meaning |
|--------|---------|
| `active` | Open for contributions |
| `funded` | Target amount reached |
| `completed` | Organiser confirmed fulfilment, escrow released |
| `expired` | Deadline passed without reaching target |
| `cancelling` | Cancellation in progress |
| `cancelled` | Cancelled, all contributions refunded |

#### Completion (Organiser Only)
When funded and fulfilled:
1. Organiser marks as complete
2. Escrow tokens released to seller/vendor
3. Digital goods: voucher codes distributed to contributors
4. Physical goods: collection tracking enabled

#### Leaving a Group Buy
Participants (not the organiser) can leave:
1. Contribution refunded from escrow
2. Group buy totals updated
3. Organiser notified via push notification

#### Delivery & Collection (Physical Items)
- Organiser updates delivery status with tracking info
- Contributors confirm collection of their physical item individually

#### Automatic Expiration
A scheduled Cloud Function periodically checks for group buys past their deadline, auto-expires them, and refunds all contributors.

### Main Screens
1. **Group Buy Screen** — Browse hub deals (filtered by cluster for physical), active community group buys, user's own group buys; create new group buy; suggest a deal
2. **Group Buy Detail** — Progress indicator (current vs. target), contributor list, join/leave/complete/cancel buttons, delivery status, deadline countdown, collection confirmation

### Admin Functionality
- **Hub Deal Management**: Create admin-curated group buys with type (digital/physical), cluster targeting, deadlines
- **Deal Suggestion Review**: Approve or decline user-submitted suggestions
- **Scheduled Expiration**: Automatic expiry and refund processing

### Key Business Rules
1. All contributions held in escrow — released on completion, refunded on expiry/cancellation
2. One contribution per user per group buy (deterministic IDs)
3. Organiser cannot leave their own group buy — must cancel instead
4. Only the organiser can complete, cancel, or update delivery status
5. Physical hub deals filtered by user cluster; digital deals shown to all
6. Automatic expiration and refund for group buys past deadline
7. Duplicate suggestion prevention via deterministic IDs
8. Organiser notified when a participant leaves
9. Per-contributor collection confirmation for physical items
10. Min/max participant constraints enforced

---

## Cross-Feature: The Token Economy

The Buy tab is where the iMaliChat **token economy closes its loop**:

```
Brands fund tokens → Users earn tokens (Earn tab) → Users spend tokens (Buy tab)
```

| Spending Channel | What Users Get |
|-----------------|----------------|
| VAS Purchases | Airtime, data, electricity, water, vouchers |
| Brand Storefronts | Product discovery, coupons, brand engagement |
| P2P Marketplace | Goods and services from other users |
| Group Buys | Bulk/group-discounted items through collective purchasing |

**Token conversion:** 100 tokens = R1 ZAR

**Financial safety mechanisms across all features:**
- **Double-entry ledger**: Every token movement has a corresponding debit and credit
- **Escrow**: Marketplace purchases and group buy contributions are held in escrow, not directly transferred
- **Step-up authentication**: Biometric/PIN required before financial transactions
- **Idempotency**: Unique keys prevent duplicate charges on network retries
- **Balance validation inside transactions**: Prevents race conditions where concurrent operations could overdraw an account
- **Automatic refunds**: Failed purchases, expired group buys, and cancellations trigger automatic refunds
