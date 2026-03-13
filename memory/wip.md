# WIP: Buy Tab Light Theme Migration + Fixes

## What we did
Complete visual overhaul of the Buy tab to match the light commerce theme spec from `buy_tab_complete.md`.

## Status: COMPLETE

### Changes made
1. **Full color token migration** — ~68 Buy tab files migrated from dark tokens to Buy light tokens (`buyBackground`, `buyCard`, `buyTextPrimary`, etc.)
2. **buy_services_screen.dart rewritten** — Removed My Regulars, gradient background, old marketplace/group buy cards. Added Option B marketplace card (white + cyan accent), white group buys card (green accent), 1px layer dividers, green cluster opt-in
3. **buy_category_tile.dart updated** — Dense chip spec: 8px radius, 11px/w600 label, 18px icon, compact padding (5,4,8,4), 6px gaps
4. **buy_category_grid.dart updated** — 6px spacing/runSpacing
5. **buy_layer_divider.dart updated** — 1px line + 16px vertical padding (not 8px solid block)
6. **Featured Items filter fix** — `_filterFeaturedByCommunity()` now shows ALL items when user has no clusters (was incorrectly hiding community-targeted items)
7. **HTML mockup created** — `docs/buy_screen_mockup.html` showing pixel-accurate rendering

### Key decisions
- AppBar stays dark (spec requirement) — icons/text on AppBar use `AppColors.textPrimary` (white), NOT `buyTextPrimary`
- Featured Items: users with no clusters see all items; users with clusters see global + matching community items

### Files modified
- `lib/presentation/screens/buy/buy_services_screen.dart` (major rewrite)
- `lib/presentation/widgets/buy/buy_category_tile.dart` (dense chip spec)
- `lib/presentation/widgets/buy/buy_category_grid.dart` (6px spacing)
- `lib/presentation/widgets/buy/buy_layer_divider.dart` (1px line)
- ~64 other Buy tab screen/widget files (token migration)
- `docs/buy_screen_mockup.html` (new)

### Not yet done
- No commit made (user hasn't asked)
- Audit plan batches 1-7 not started (separate from visual overhaul)
