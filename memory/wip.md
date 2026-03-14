# WIP: Storefront Builder Enhancements

## Status: COMMITTED (8bea3c1)

### What was built
1. **Inline section editors on Dynamic Content tab** — tap any section to edit:
   - quickActions, banner, promotions, gallery, socialLinks, announcementBar,
     videoShowcase, couponCenter, faq, locationCard, richText
   - Non-editable sections (featuredProducts, products, reviews, about, testimonials, divider) show hints
2. **Pixel-accurate App Preview** — toggle between Sections/App Preview, refresh button, uses StorefrontPreview widget
3. **Section visibility** — StorefrontPreview respects sectionSettings.isVisible
4. **Removed Content & Links tab** — banner, announcement, social links now inline in Dynamic Content

### Bugs fixed
- Auto-save duplicate storefront creation: `_save()` now checks `widget.storefrontId ?? _data['id']`
- Product image upload: `resizeImageForUpload` throws on web → wrapped in try/catch with raw upload fallback
- Storage rules: added `brand_assets/{storefrontId}/{subfolder}/{fileName}` for products/gallery/videos
- Featured products overflow: height 200→220
- Products tab infinite reload: `_productsLoaded` flag
- CF `adminListBrandProducts`: better error messages, try/catch around Firestore query

### Known remaining issues
- App Preview may show cached version in browser — user needs to clear site data or use incognito
- Product image in Firestore doc may have empty imageUrl if created before Storage rules fix
- Debug prints still in code (can be removed later)

### Not yet done
- No git push (user hasn't asked)
