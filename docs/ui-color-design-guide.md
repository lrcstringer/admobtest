# iMaliChat UI Color & Design Guide

## 1. Brand Palette Reference

### Primary Colors
| Name | Hex | Usage |
|---|---|---|
| **Pink** | `#FF328C` | Primary CTAs, active states, icons |
| **Blue** | `#0974FF` | Secondary buttons, links |
| **Cyan** | `#08C2F4` | Info highlights, media-related elements |
| **Gold** | `#FFB82C` | Tokens, rewards, badges |

### Secondary Colors
| Name | Hex | Usage |
|---|---|---|
| **Purple** | `#A011FF` | Accents, special features, social/invite |
| **Orange** | `#FF6429` | Warm accents, energy |
| **Orange-Bright** | `#FF9900` | Wallet, gradient start |

### Brand Gradients
| Name | Colors | Direction | Semantic |
|---|---|---|---|
| **Logo** | `#FF9900 -> #FF328C` | 90deg | Hero elements, wallet/portfolio |
| **Pink-Purple** | `#FF328C -> #A011FF` | 90deg | Social, invites, creative |
| **Cyan-Blue** | `#08C2F4 -> #0974FF` | 90deg | Media, info, educational |
| **Gold-Orange** | `#FFB82C -> #FF6429` | 90deg | Tokens, rewards, expression |
| **Background** | `#142978 -> #0C1124` | 180deg | App background (DO NOT CHANGE) |

### Dark Surfaces
| Name | Hex | Role |
|---|---|---|
| **Background** | `#0C1124` | App background |
| **Surface** | `#13161D` | Current card/container color |
| **Elevated** | `#1A1E2A` | Current elevated surface |
| **Border** | `#2A2E3D` | Current card borders |

---

## 2. Design Principles

### DO NOT CHANGE
- App background (`#0C1124` + wave background image)
- AppBar (transparent with white text)
- Bottom navigation bar (dark with glow effect on active)
- Button gradient fills (Earn Now, Continue, etc.)
- The pot card accent bar + text color matching pattern
- Today's Progress gradient block
- Auth/onboarding screens (these have their own focused visual flow)

### The Problem
Background is `#0C1124`, cards are `#13161D` — only 9 hex values apart. Everything merges into a dark slab. Screens that use color (pot cards, Earn Now button, progress bar) feel alive. Screens that don't (Upload, Settings, Profile) feel flat and lifeless.

### The Solution: Three-Tier Color System

**Tier 1: Full Gradient** — Maximum visual impact, used for CTAs and primary action buttons.
Applied via `LinearGradient` fill on the button/container background.

**Tier 2: Accent Bar** — Structural rhythm, used as a thin (3px) gradient strip on top edge of content cards.
Gives structure and color coding without overwhelming. Follows the pot card pattern.

**Tier 3: Tinted Background** — Atmospheric depth, applied as a very subtle (5-8% opacity) gradient tint on card backgrounds.
The card still reads as dark, but lifts off the background with perceptible warmth and depth.

### Semantic Color Mapping
Each gradient has a **meaning** — not used decoratively but to signal content type:

| Gradient | Semantic Domain | Used For |
|---|---|---|
| **Logo** (orange->pink) | Identity, Portfolio, Hero | Token balance card, portfolio card, hero CTAs |
| **Pink-Purple** | Social, Invite, Creative | Invite button, profile, social features, photo uploads |
| **Cyan-Blue** | Media, Info, Educational | Video content, surveys, informational cards, help |
| **Gold-Orange** | Tokens, Rewards, Achievement | Reward cards, token displays, text responses, earnings |
| **Primary (pink)** | Action, Active State | Already used for buttons and active elements — no change needed |

### Opacity Rules
| Opacity | Where Used |
|---|---|
| **100%** | Buttons, icons, text, thin accent bars |
| **20-30%** | Gradient borders on featured/highlighted cards |
| **10-15%** | Hover/pressed states, status chips |
| **5-8%** | Card background tints (Tier 3) |
| **0%** | Never color anything at 0% — use `AppColors.surface` if no tint desired |

### Application Rules
- **Max 2 treatments per card**: Accent bar + tint, OR tint + gradient border. Never all three.
- **Color must be semantic**: Don't pick colors randomly. Follow the gradient-to-domain mapping.
- **Group consistency**: All cards in the same section share the same gradient family.
- **Accent bar = 3px height**, always full-width across the top of the card, using `borderRadius` only on top corners so the bar follows the card shape.
- **Tint direction**: Always `topLeft -> bottomRight` to create a subtle diagonal warmth.

---

## 3. BrandCard Widget Specification

A reusable widget that encapsulates the Tier 2 + Tier 3 pattern.

```
BrandCard(
  gradient: BrandGradient.cyanBlue,   // which gradient to use
  showAccentBar: true,                 // Tier 2 accent bar (default: true)
  tintOpacity: 0.06,                   // Tier 3 background tint (default: 0.06, 0.0 = disabled)
  borderRadius: AppSpacing.borderRadiusLg,
  padding: AppSpacing.cardPadding,
  child: ...
)
```

**BrandGradient enum values:**
- `logo` — `AppColors.logoGradient` (#FF9900 -> #FF328C)
- `pinkPurple` — `AppColors.primaryGradient` (#FF328C -> #A011FF)
- `cyanBlue` — `AppColors.secondaryGradient` (#08C2F4 -> #0974FF)
- `goldOrange` — `AppColors.tertiaryGradient` (#FFB82C -> #FF6429)
- `none` — No gradient, flat `AppColors.surface` (opt out)

**Rendering:**
1. Outer `Container` with `borderRadius` and `clipBehavior: Clip.antiAlias`
2. If `showAccentBar`: 3px Container at top with full gradient
3. Card body with:
   - Background: `LinearGradient(topLeft -> bottomRight, [gradient[0].withOpacity(tintOpacity), gradient[1].withOpacity(tintOpacity * 0.5)])` blended over `AppColors.surface`
   - Border: `Border.all(color: AppColors.border)` (unchanged from current)
4. Padding + child

---

## 4. Screen-by-Screen Change Plan

### KEEP AS-IS (No changes needed)

#### Auth & Onboarding Screens
**Files:** All files in `screens/auth/` and `screens/onboarding/`
**Reason:** These have a focused onboarding flow with their own visual language (wave backgrounds, mascot, gradient buttons). They work well already and should remain distinct from the main app experience.

#### Splash Screen
**File:** `screens/splash/splash_screen.dart`
**Reason:** Brand animation, already uses gradient background correctly.

#### Main Shell
**File:** `screens/main/main_shell.dart`
**Reason:** Navigation scaffold, no visual content.

#### Success/Failure Screens
**Files:** `earn_wallet_confirm_screen.dart`, `chat_send_success_screen.dart`, `chat_send_failure_screen.dart`, `wallet_send_success_screen.dart`, `wallet_send_failure_screen.dart`, `wallet_withdraw_success_screen.dart`, `wallet_withdraw_failure_screen.dart`, `buy_success_screen.dart`, `buy_failure_screen.dart`
**Reason:** These are transient feedback screens with colored icons, confetti, and status-specific styling. They're already colorful enough. The success screen you showed (earn_wallet_confirm_screen) uses gold badge, green checkmark, colored breakdown rows — this is fine.

---

### HOME SCREEN
**File:** `screens/home/home_screen.dart`

#### Token Balance Card
- **Current:** `AppColors.surface` with border
- **Change:** Add Tier 3 **Logo** gradient tint at 6%
- **Reason:** Hero card on the page, should feel premium

#### Today's Progress Card
- **Current:** Already uses gold gradient background
- **Change:** NONE — already great

#### Daily Pot Card
- **Current:** Accent bar (logo gradient) + dark body
- **Change:** Add Tier 3 tint at 4% using the same gradient colors as the accent bar (yellow-tinted)
- **Reason:** Subtle lift to match the accent bar warmth

#### Weekly Pot Card
- **Current:** Accent bar (pink-purple gradient) + dark body
- **Change:** Add Tier 3 tint at 4% using pink-purple
- **Reason:** Same treatment as daily pot for consistency

#### "Invite Friends & Earn" Button
- **Current:** Dark surface card with icon + text — flat and boring
- **Change:** **Tier 1 full gradient** — `Pink-Purple` gradient background with white icon + white text
- **Reason:** This is a CTA. It should compete visually with "Earn Now" for attention. It's currently invisible.

#### Streak Badge
- **Current:** Bordered pill with dot + text
- **Change:** NONE — small element, already works

---

### EARN SCREEN
**File:** `screens/earn/earn_screen.dart`

#### Notification Cards (unread)
- **Current:** Light primary background (pink at ~10%) with primary border
- **Change:** NONE — already color-coded and works

#### Daily Limit Banner
- **Current:** Success color at 10% alpha with icon
- **Change:** NONE — functional color, works

#### Client Accordion Header
- **Current:** `AppColors.surface` / `AppColors.surfaceElevated` with border
- **Change:** When expanded, add Tier 3 **Logo** gradient tint at 4%
- **Reason:** Expanded state should feel "opened" and warmer. Collapsed stays dark.

#### Thread Cards (within expanded client)
- **Current:** `AppColors.surface` with border, optional pinned/featured border color
- **Change:** Add Tier 2 accent bar (3px) using **Gold-Orange** gradient (these are earn opportunities = tokens)
- **Change:** Pinned/featured cards: Add Tier 3 tint at 5% using same gradient as their accent border color
- **Reason:** Earnable content should feel warm (gold = tokens = money)

---

### EARN THREAD SCREEN (Campaign Detail)
**File:** `screens/earn/earn_thread_screen.dart`

#### Campaign Info Card
- **Current:** Surface card with client avatar, description, stats
- **Change:** Add Tier 2 accent bar using **Gold-Orange** + Tier 3 tint at 5%
- **Reason:** Consistent with earn domain = gold-orange

#### Opportunity List Items
- **Current:** Surface cards with border
- **Change:** Add Tier 2 accent bar using **Gold-Orange** at 3px
- **Reason:** Each opportunity = a way to earn tokens

---

### EARN INTERACTION SCREEN (Task Execution)
**File:** `screens/earn/earn_interaction_screen.dart`

#### Start State — Instruction Card (top, with "Upload" / "Survey" / "Video" label)
- **Current:** Surface card
- **Change:** Add Tier 3 tint at 5% matching the opportunity type:
  - Upload type: **Pink-Purple** (creative expression)
  - Survey/Poll type: **Cyan-Blue** (informational)
  - Video/AdVideo type: **Cyan-Blue** (media)
- **Reason:** Color-codes the experience type from the start

#### Start State — "How it works" Section
- **Current:** Instruction steps on dark background
- **Change:** NONE — text-based, works fine

#### Upload State — Video Recording Card
- **Current:** Surface card, dark and flat
- **Change:** BrandCard with **Cyan-Blue** gradient (Tier 2 accent bar + Tier 3 tint at 6%)
- **Reason:** Video = media = cyan-blue

#### Upload State — Photo Card
- **Current:** Surface card, dark and flat
- **Change:** BrandCard with **Pink-Purple** gradient (Tier 2 accent bar + Tier 3 tint at 6%)
- **Reason:** Photo = creative = pink-purple

#### Upload State — Text Response Card
- **Current:** Surface card, dark and flat
- **Change:** BrandCard with **Gold-Orange** gradient (Tier 2 accent bar + Tier 3 tint at 6%)
- **Reason:** Text = expression = gold-orange

#### Survey State — Question Card
- **Current:** Surface card with question text + answer options
- **Change:** Add Tier 3 **Cyan-Blue** tint at 5%
- **Reason:** Survey = informational = cyan-blue

#### Survey State — Answer Option Buttons
- **Current:** Surface-colored, changes on selection
- **Change:** Selected state: add gradient border using **Cyan-Blue** at 25% opacity
- **Reason:** Selected feedback should use the same gradient family as the question card

#### Review State
- **Current:** Dark cards with answer text
- **Change:** Each answer card: thin Tier 2 accent bar (**Cyan-Blue**) at top
- **Reason:** Consistency with survey domain

---

### CHAT SCREEN
**File:** `screens/chat/chat_screen.dart`

#### Quick Action Buttons (Send, Request, QR)
- **Current:** Icon circles with alpha(0.1) background
- **Change:** Each action gets its own gradient family for the icon circle background:
  - Send: **Logo** gradient at 15% (sending money = warm)
  - Request: **Gold-Orange** at 15% (requesting tokens)
  - QR: **Cyan-Blue** at 15% (digital/tech)
- **Reason:** Adds visual variety to the row without being heavy

#### Thread List Items
- **Current:** Standard ListTile on dark background
- **Change:** NONE — chat list is dense, functional UI. Adding color treatment would create noise. Unread badge (gold) already provides enough visual signal.

---

### CHAT DETAIL SCREEN
**File:** `screens/chat/chat_detail_screen.dart`

- **Change:** NONE — chat bubbles already use `chatBubbleSent` (pink) and `chatBubbleReceived` (surface). This is standard messaging UI and should stay clean.

---

### CHAT SEND FLOW
**Files:** `chat_send_amount_screen.dart`, `chat_send_wallet_selection_screen.dart`

#### Amount Input Card
- **Current:** Surface card with number pad
- **Change:** NONE — functional input screen, should stay clean

#### Wallet Selection Cards
- **Current:** Surface cards with left accent stripe (already colored per wallet type)
- **Change:** NONE — already has the accent stripe pattern (similar to Tier 2)

---

### WALLET SCREEN
**File:** `screens/wallet/wallet_screen.dart`

#### Portfolio Card
- **Current:** Already uses `logoGradient` — great
- **Change:** NONE

#### Action Cards (Cash Out, History)
- **Current:** Surface card with icon + text
- **Change:**
  - Cash Out: BrandCard with **Gold-Orange** (Tier 2 accent bar + Tier 3 tint at 5%). Cash out = money = gold.
  - History: BrandCard with **Cyan-Blue** (Tier 2 accent bar + Tier 3 tint at 5%). History = information = cyan-blue.
- **Reason:** These are key actions, currently bland. Color-coding distinguishes them.

#### Rewards Card
- **Current:** Surface card
- **Change:** BrandCard with **Gold-Orange** (Tier 2 accent bar + Tier 3 tint at 4%). Rewards = tokens = gold.

#### Wallet Cards (individual wallets)
- **Current:** Already have left accent stripe (colored by wallet type)
- **Change:** Add Tier 3 tint at 3% using the stripe's accent color
- **Reason:** Very subtle, amplifies the existing stripe's visual identity

#### Recent Activity Items
- **Current:** Icon circles already colored by activity type
- **Change:** NONE — dense list, color is already present in the icon circles

---

### WALLET DETAIL SCREEN
**File:** `screens/wallet/wallet_detail_screen.dart`

#### Wallet Header Card
- **Current:** Surface card
- **Change:** Add Tier 3 tint matching the wallet's accent color at 5%

#### Transaction List Items
- **Current:** Standard list with colored icon circles
- **Change:** NONE — dense list, functional

---

### CASHOUT SCREEN
**File:** `screens/wallet/cashout_screen.dart`

#### Amount Input Section
- **Current:** Surface-based
- **Change:** NONE — input UI should stay clean

#### Method Selection Cards
- **Current:** Surface cards
- **Change:** Selected method: Add gradient border (**Gold-Orange** at 20%) to indicate selection
- **Reason:** Selection feedback should be visible

---

### REWARDS SCREENS
**Files:** `rewards_list_screen.dart`, `reward_item_detail_screen.dart`

#### Reward Cards
- **Current:** Surface cards
- **Change:** BrandCard with **Gold-Orange** (Tier 2 accent bar + Tier 3 tint at 5%)
- **Reason:** Rewards = tokens = gold domain

#### Reward Detail Card
- **Current:** Surface card with details
- **Change:** BrandCard with **Gold-Orange** (Tier 2 accent bar + Tier 3 tint at 4%)

---

### POTS SCREEN
**File:** `screens/pots/pots_screen.dart`

#### Pot Cards (Active Tab)
- **Current:** Surface card with status chip, prize amount gradient box, stats, rank
- **Change:** Add Tier 3 tint at 4%:
  - Daily pot: Use daily pot's accent bar gradient colors
  - Weekly pot: Use weekly pot's accent bar gradient colors
- **Reason:** Slight lift, consistent with home screen pot card treatment

#### History Cards
- **Current:** Surface cards with winner info
- **Change:** Add Tier 2 accent bar (3px) matching pot type color
- **Reason:** Structure and visual rhythm in the list

#### Leaderboard Sheet
- **Change:** NONE — bottom sheet with dense list, functional UI

---

### PROFILE SCREEN
**File:** `screens/profile/profile_screen.dart`

#### Profile Header Card
- **Current:** Surface card with avatar, name, stats
- **Change:** Add Tier 3 **Pink-Purple** tint at 5%
- **Reason:** Profile = personal/identity = pink-purple

#### Stats Row (Tokens Earned | Referrals | Pots Won)
- **Current:** Inside profile header
- **Change:** Each stat value could use its semantic color (gold for tokens, pink for referrals, cyan for pots) instead of all being the same
- **Reason:** Quick visual parsing

#### Menu Section Cards (Account, Preferences, Security, Support)
- **Current:** Surface cards with list tiles
- **Change:** Each section gets a Tier 2 accent bar with a different gradient:
  - Account: **Logo** gradient (personal/identity)
  - Preferences: **Cyan-Blue** (settings/config)
  - Security: **Pink-Purple** (protection/important)
  - Support: **Gold-Orange** (help/guidance)
- **Change:** NO background tint on menu sections (too many cards, would be noisy)
- **Reason:** Accent bars create section distinction without clutter

---

### EDIT PROFILE SCREEN
**File:** `screens/profile/edit_profile_screen.dart`

- **Change:** NONE — form input screen, should stay clean and focused

---

### SETTINGS SCREENS
**Files:** `settings_screen.dart`, `notification_settings_screen.dart`, `security_settings_screen.dart`

#### Settings Menu Items
- **Current:** Surface cards with list tiles
- **Change:** Add Tier 2 accent bar per section (same pattern as Profile menu):
  - Notifications: **Cyan-Blue**
  - Security: **Pink-Purple**
- **Reason:** Subtle structure, same pattern used in profile

#### Toggle/Switch Rows
- **Change:** NONE — functional toggles, already use brand switch colors

---

### KYC VERIFICATION SCREEN
**File:** `screens/settings/kyc_verification_screen.dart`

#### Verification Step Cards
- **Current:** Surface cards with step number, status icon
- **Change:**
  - Completed steps: Tier 3 **success** color tint at 5% (green glow)
  - Current step: Tier 2 **Cyan-Blue** accent bar
  - Pending steps: No change (stay dark)
- **Reason:** Visual progress indication

---

### HELP & SUPPORT SCREEN
**File:** `screens/settings/help_support_screen.dart`

#### FAQ Cards
- **Current:** Surface cards with expandable content
- **Change:** Add Tier 2 **Cyan-Blue** accent bar (info/educational domain)
- **Reason:** Consistent with cyan-blue = informational

#### Contact/Support Cards
- **Change:** NONE — functional links

---

### ABOUT SCREEN
**File:** `screens/settings/about_screen.dart`

- **Change:** NONE — minimal info screen

---

### GROUPS SCREENS
**Files:** `groups_list_screen.dart`, `group_detail_screen.dart`, `create_group_screen.dart`, `group_transaction_screen.dart`, `pending_approvals_screen.dart`

#### Group Cards
- **Current:** Surface cards
- **Change:** BrandCard with **Pink-Purple** (Tier 2 accent bar + Tier 3 tint at 5%)
- **Reason:** Groups = social/community = pink-purple

#### Pending Approval Cards
- **Current:** Surface cards with status
- **Change:** Pending items: Tier 2 **Gold-Orange** accent bar (action needed = attention)
- **Reason:** Gold draws attention to items needing action

---

### BUY SERVICES SCREEN
**File:** `screens/buy/buy_services_screen.dart`

#### Service Category Cards
- **Current:** Surface cards with icons
- **Change:** BrandCard with **Cyan-Blue** (Tier 2 accent bar + Tier 3 tint at 5%)
- **Reason:** Services = browsing/exploring = informational = cyan-blue

#### Wallet Selection Cards (buy flow)
- **Current:** Surface cards with accent stripe
- **Change:** NONE — already has accent stripe (same as wallet screen)

---

### REFERRAL SCREEN
**File:** `screens/referral/referral_screen.dart`

#### Referral Stats Card
- **Current:** Surface card
- **Change:** BrandCard with **Pink-Purple** (Tier 2 accent bar + Tier 3 tint at 5%)
- **Reason:** Referral = social = pink-purple

#### Share/Invite CTA
- **Current:** Likely a standard button
- **Change:** Tier 1 full **Pink-Purple** gradient (same as "Invite Friends & Earn")
- **Reason:** Consistent CTA treatment for all invite/share actions

#### Referral List Items
- **Change:** NONE — dense list, functional

---

### HOW TO EARN / WHAT IS IMALICHAT
**Files:** `how_to_earn_screen.dart`, `what_is_emalichat_screen.dart`

#### Info Cards / Step Cards
- **Current:** Surface cards
- **Change:** BrandCard with **Cyan-Blue** (Tier 2 accent bar + Tier 3 tint at 5%)
- **Reason:** Educational content = informational = cyan-blue

---

### BONUS NETWORK / UPGRADE STATUS
**Files:** `bonus_network_screen.dart`, `upgrade_status_screen.dart`

#### Network Visualization Cards
- **Current:** Surface cards
- **Change:** BrandCard with **Pink-Purple** (social/network)

#### Status Tier Cards
- **Current:** Surface cards
- **Change:** Each tier uses its own gradient based on tier level:
  - Bronze: **Gold-Orange**
  - Silver: NONE (keep neutral)
  - Gold: **Logo** gradient
  - Premium: **Pink-Purple**
- **Reason:** Tiers have inherent color associations

---

## 5. Implementation Priority

### Phase 1 — BrandCard Widget + Home Screen (Highest Impact)
1. Create `BrandCard` widget and `BrandGradient` enum
2. Home: Token Balance card (Logo tint)
3. Home: Pot cards (add tint to match accent bars)
4. Home: "Invite Friends & Earn" (full Pink-Purple gradient)

### Phase 2 — Earn Flow (Most-Used Feature)
5. Earn screen: Thread cards (Gold-Orange accent bar + tint)
6. Earn interaction: Upload cards (Cyan-Blue, Pink-Purple, Gold-Orange per type)
7. Earn interaction: Survey question cards (Cyan-Blue tint)
8. Earn thread screen: Campaign + opportunity cards (Gold-Orange)

### Phase 3 — Wallet & Profile
9. Wallet: Action cards (Cash Out, History)
10. Wallet: Rewards card
11. Wallet: Individual wallet cards (subtle tint)
12. Profile: Header card + menu section accent bars

### Phase 4 — Secondary Screens
13. Pots screen: Active pot cards (tint) + history cards (accent bars)
14. Chat: Quick action icon circles (gradient families)
15. Settings: Section accent bars
16. Groups: Group cards
17. Buy: Service cards
18. Referral: Stats card + share CTA
19. Help: FAQ accent bars
20. Educational: Info cards

---

## 6. Summary of All Changes

| Change Type | Count | Screens Affected |
|---|---|---|
| Tier 1: Full Gradient CTAs | 2 | Home (Invite), Referral (Share) |
| Tier 2: Accent Bars added | ~15 | Earn, Profile, Settings, Groups, Pots history, Help, Buy, Educational |
| Tier 3: Background Tints added | ~20 | Home, Earn, Wallet, Profile, Pots, Groups, Referral, Buy |
| No changes | ~35 | Auth, onboarding, splash, chat detail, success/failure screens, form inputs, about, edit profile |

Total screens requiring changes: **~35 of 74**
Screens left untouched: **~39 of 74**
