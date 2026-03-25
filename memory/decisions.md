# Architecture Decisions

## 2026-03-25 — Play Integrity tier downgraded to HIGH for processEngagement

`processEngagement` was changed from `IntegrityTier = "HIGHEST"` to `"HIGH"` (the lower/less-strict tier).

**Why:** HIGHEST tier blocks devices with only `MEETS_BASIC_INTEGRITY` (many legitimate budget Android devices). This caused unnecessary rejection during pre-launch testing. HIGH tier still blocks devices with no integrity labels at all (emulators, root without masking), but allows basic-integrity-only devices with a warning log.

**MUST REVISIT BEFORE GO-LIVE:** Evaluate whether `processEngagement` should be restored to `"HIGHEST"`. The risk of leaving it at HIGH is that sideloaded or tampered APKs on basic-integrity devices can earn tokens. Weigh against user rejection rate data from Play Console before launch.

**How to apply:** When preparing the production release, check Play Console → Android Vitals → Integrity signals to assess what percentage of real users would be blocked by HIGHEST. If < 5%, restore to HIGHEST.

---
